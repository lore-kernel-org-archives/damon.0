Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84331D6DB5;
	Thu, 23 Oct 2025 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182741; cv=none; b=Zbt2SFK/2IqvtfPAFKyNkfhsmUD5FQN0TGoUxaBy7cm0KCMTg4abXWmLr5Sg20htjhFlXanvwhtgYu14r2C2K51MAzCTottvH20ausJelEgb489yYbPjIueVdEhdKdTkpLcwl//C59MbX2h0RzV6q/qaOHqTs7Iip+PNEe9M5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182741; c=relaxed/simple;
	bh=sIveTxFAmrzddRKi8UGGyF1J97Zrb1cqOFDFiER9cSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPMtpcr211s5OBitrC7Q77Ag3NhDW2W1+rpKuzR4Xm+6zehSPYlrTvX5fD/eJuD61PSpqI/RuzEM1ID6YvGTG/gd2jQYLF1P5f+EYFw1WwYvmdENCUERPm2D4Va8Q3OtgOaJjNjNoOZh17fAkx32rCGNjnbqAcCcGB7BUQWhrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM8SFIS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM8SFIS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC371C4CEE7;
	Thu, 23 Oct 2025 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182741;
	bh=sIveTxFAmrzddRKi8UGGyF1J97Zrb1cqOFDFiER9cSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HM8SFIS37glHiSpFmmcjCYxkGIzcWJLAW1xXOKGA6QvV+lu7JWqE/pP/VgPmP49c1
	 ahyGOwmevRjt+r98YKnnHji/x5qUPLSP95ulLqbUr7LQaE2usaeQ2a7Y83tGITrAsZ
	 vsKqP6aVMRPcGiKwPl6N8P7BovPpJiEv1rfiEdqoqPZAm1K8PBvoDa2uwVwmDz/rQQ
	 j8dx444E5ElZgZI7wc9zeZAxwKL35uZ7csTMiR+e9bFEEA1JmH0GHRbb1IdxOe9rpz
	 ERIydzLaZ9sKGH/8hbTFm7Mx1Nv24LB+b6m2rXyXMBJmErGf9niof/gritKIxTl6s/
	 OCS7QhFL0mQYg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/9] mm/damon/sysfs: test commit input against realistic destination
Date: Wed, 22 Oct 2025 18:25:26 -0700
Message-ID: <20251023012535.69625-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface tests if given online parameters update request is
valid, by committing those using the DAMON kernel API, to a test-purpose
destination context.  The test-purpose destination context is
constructed using damon_new_ctx(), so it has no target, no scheme.

If a source target has the obsolete field set, the test-purpose commit
will fail because damon_commit_targets() fails when there is a source
obsolete target that cannot find its matching destination target.  DAMON
sysfs interface is not letting users set the field for now, so there is
no problem.  However, the following commit will support that.  Also
there could be similar future changes that making commit fails based on
current context structure.

Make the test purpose commit destination context similar to the current
running one, by committing the running one to the test purpose context,
before doing the real test-purpose commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
---
 mm/damon/sysfs.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ccfb624a94b8..0fe6ea68d311 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1451,6 +1451,26 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx);
 
+/*
+ * Return a new damon_ctx for testing new parameters to commit.
+ */
+static struct damon_ctx *damon_sysfs_new_test_ctx(
+		struct damon_ctx *running_ctx)
+{
+	struct damon_ctx *test_ctx;
+	int err;
+
+	test_ctx = damon_new_ctx();
+	if (!test_ctx)
+		return NULL;
+	err = damon_commit_ctx(test_ctx, running_ctx);
+	if (err) {
+		damon_destroy_ctx(test_ctx);
+		return NULL;
+	}
+	return test_ctx;
+}
+
 /*
  * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
  * @kdamond:	The kobject wrapper for the associated kdamond.
@@ -1472,7 +1492,7 @@ static int damon_sysfs_commit_input(void *data)
 	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
-	test_ctx = damon_new_ctx();
+	test_ctx = damon_sysfs_new_test_ctx(kdamond->damon_ctx);
 	if (!test_ctx)
 		return -ENOMEM;
 	err = damon_commit_ctx(test_ctx, param_ctx);
-- 
2.47.3
