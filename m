Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3F25B678;
	Wed, 26 Feb 2025 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551816; cv=none; b=gvyr1++Ms8dp4xo+seSU7G3OjJhOnxj+CC65OeFhQH9ly2jZDtlPfClF8HSTi9U8afWyoekAe+hpt+mUyF3FzCYFzMa2CmiiPL6LPj47AkBQkQEuVCwmZU5eT9r8PcDshz7K+0SNjCJnx+5olxhKZNa//BPiM9U2nvVvFgCE/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551816; c=relaxed/simple;
	bh=5n9xRLBBKD40DxaNJxpmX5CbdO8tnA9vHZtFNqo0gek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cu8YwEYv/7D4pEelQBVVrx7grLLJOWFaqH0RrhZrdSIUS6bgdr1fZ4BujMjsOrxU9TgBwg9sRdvUXL94FGO5yIU8ZE90JN8OQqur/wznb/mfhfOh7E2csNJ9VVKcDx4DSzWrV2/06Bekc875hecMqz3/72UJwFF64wQMxJYAnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNjpdu0n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNjpdu0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5C5C4CEE2;
	Wed, 26 Feb 2025 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551816;
	bh=5n9xRLBBKD40DxaNJxpmX5CbdO8tnA9vHZtFNqo0gek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNjpdu0naIeVD/lEw6HDtDk+7/Wad7TrQhcHR/+50Bj4hoe+y6aNGrXqIPF90UhX3
	 CAnGFDEcAhmNDIxn88JGEMRBGoudUaSX1NKQm0FkOSuDs4JRdCbeWv9hBjD8RTZW2T
	 zX69CheuLIzZ05UaOf95ACvkggJVfNhwABo1lFEvgGuIkuSaQAIMrQXxFm5i/Al1uH
	 tjGjfTNdOXeAmXEv7ouuwwFqyyTs2zuGY+USl8gVaBdkqXtugtuXtprfoyai76z29b
	 HKE4HYcVWyDaCKJnEBczKxPQpf3QrO9z32HKGAEsFMHouBXLW2Lr3ZnlOfa7uRonEm
	 ZbDqtOQl08BpA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/13] mm/damon/sysfs: validate user inputs from damon_sysfs_commit_input()
Date: Tue, 25 Feb 2025 22:36:39 -0800
Message-Id: <20250226063651.513178-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Online DAMON parameters commit via DAMON sysfs interface can make
kdamond stop.  This behavior was made because it can make the
implementation simpler.  The implementation simply tries committing the
parameter without validation.  If it finds something wrong, it returns
error without reverting partially committed parameters back.  It is safe
though, since it breaks kdamond main loop in the case of the error
return.

Users can make the wrong parameters by mistake, though.  Validating the
input parameters first and returning the error when some parameters
wrong, while letting kdamond continues running with the old parameters
would be the better behavior.  This behavior can also make damon_call()
carrying the online commit instead of the damon_callback hook in future
easier, because damon_call() cannot directly break kdamond main loop.

Implement the better behavior.

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
