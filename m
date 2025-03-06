Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38825D1FA;
	Thu,  6 Mar 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283953; cv=none; b=looke3+2iPGn9J1iSNq41hzEidANhXgNPDx/peM0JkjY8U3YM9ciim3NHkakLaCuHL1nrdNVGF2yvfCQveuU1nwZXYge7S2cgAWWDm3D1szqZVSc5U8I0Grhiz3mGE4zUwFNdmrK6fgX+CHNB5kDUxLvwwK1f4pEVq3Z2jnUrWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283953; c=relaxed/simple;
	bh=s3K1j/KtFWFlfZ4nT5daB6KeJd16T5I6BVsvRI8TnBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCcycR+c/mr5mjiqwZwSiozhziz2vIO4IccWBjI0JdOLEXtq+7pdgTcnZat/Kv8YGY/8DtMfYXVkt9h5be1wNPekJTnADUKwH3DgxSo4i6s9ZDWZk7fKdEOZd8WoKNT+7nqJlmtVA/6KiJTYIeH60NgHVOH6XQ6sBmcPWHLqbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2YlYirJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2YlYirJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891C2C4AF09;
	Thu,  6 Mar 2025 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283953;
	bh=s3K1j/KtFWFlfZ4nT5daB6KeJd16T5I6BVsvRI8TnBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2YlYirJHFp/wJtVUL7tffYgMhDwY2Ik+mZkg4cYEO2+Cp0OBou2I0OjZMh+T4caT
	 ypz2HqLqrukRM8jMWJkTsEofWtapkCQog8j6CZJcSiDFoik7gQASwHwRfMlN/kSN06
	 MDivW6nDcqzWWg+Xnn68/8X5BHHcGc9m2FUz1CuKZghmvpUD+rZNwYLdN9yq/CX+sF
	 AstH6vhqHhTlpRiuh593cNXH7v0O3dnKFQqhnnUudFiGGrONwzfjrrM79OGKegO2g2
	 zmyK+gfhK+3oHGsyKk7aTz9wVbF/zubx1wZW7wku1tS9NSPtyLwvcSi8633R6LJdFc
	 ZE3c5WwcJUyXA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/13] mm/damon/sysfs: validate user inputs from damon_sysfs_commit_input()
Date: Thu,  6 Mar 2025 09:58:56 -0800
Message-Id: <20250306175908.66300-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Online DAMON parameters commit via DAMON sysfs interface can make
kdamond stop.  This behavior was made because it can make the
implementation simpler.  The implementation tries committing the
parameter without validation.  If it finds something wrong in the middle
of the parameters update, it returns error without reverting the
partially committed parameters back.  It is safe though, since it
immediately breaks kdamond main loop in the case of the error return.

Users can make the wrong parameters by mistake, though.  Stopping
kdamond in the case is not very useful behavior.  Also this makes it
difficult to utilize damon_call() instead of damon_callback hook for
online parameters update, since damon_call() cannot immediately break
kdamond main loop in the middle.

Validate the input parameters and return error when it fails before
starting parameters updates.  In case of mistakenly wrong parameters,
kdamond can continue running with the old and valid parameters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ccd435d234b9..87e4c6e3614e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1449,11 +1449,11 @@ static struct damon_ctx *damon_sysfs_build_ctx(
  * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
  * @kdamond:	The kobject wrapper for the associated kdamond.
  *
- * If the sysfs input is wrong, the kdamond will be terminated.
+ * Returns error if the sysfs input is wrong.
  */
 static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 {
-	struct damon_ctx *param_ctx;
+	struct damon_ctx *param_ctx, *test_ctx;
 	int err;
 
 	if (!damon_sysfs_kdamond_running(kdamond))
@@ -1465,7 +1465,15 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
+	test_ctx = damon_new_ctx();
+	err = damon_commit_ctx(test_ctx, param_ctx);
+	if (err) {
+		damon_sysfs_destroy_targets(test_ctx);
+		damon_destroy_ctx(test_ctx);
+		goto out;
+	}
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
+out:
 	damon_sysfs_destroy_targets(param_ctx);
 	damon_destroy_ctx(param_ctx);
 	return err;
-- 
2.39.5
