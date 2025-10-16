Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435F2E2DD8;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651263; cv=none; b=FLoVZb6i4ohw8xwVFoFm8K6jgrR2Ov1upH+jvGLRSuXov88YX/V6eRYF+lt2KiKQ2kYpBTdLCNVU88Zjn3w+pd02dUlPH+Xywg80ltQ9tPITMcWq6lgkZoG62VTL0WC+Q6pfjEVRdp4wAvAxGitik8ZEeqivxPbiWAZRbC3MVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651263; c=relaxed/simple;
	bh=ViqZA824hPzHAr3rZEOCt3wrknWYvtKIZnCeGd320Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu0umf9sOzo5WdhltXR2QZgmhjdh4NzU+Mu2gSpai4X9m9SCfSvCVqsmxGE7M2Nhgm26kXHabwSBkEG0mSdVKpfhpB7h6PwllOkKehbBqh7QV0VAoMTz+5HY1ZlsCFcFcf97B7X2nMmVRRbygaWsDG5Rn1QMtDVNUpDAszNvayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsh5UHOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsh5UHOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B18C116C6;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651262;
	bh=ViqZA824hPzHAr3rZEOCt3wrknWYvtKIZnCeGd320Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsh5UHOg/Bco/JPzss70ISncmMJwcSYWtb3xemxYvxxYWa5LeiC+wFrgNFnGGW28Y
	 KhBeaYy98TjBckzy0vJrgB32mLyg2y0Q0VD62w4Ipzq8VF0JHr4HpXiUgA8g6MrLzv
	 icPFHtiPDEmW45+Zybr3NyYgJlO5T4jycUbYxoBI3KyUY/XA5f8lsCw+LnIix3YOfe
	 cUvwMkPY2CM0LcHzYQN/GHRSrYK+Sya+wLlKvlEi60UVSo3IDVDhk0XJ/N1xQr84Wv
	 kQVzY7FCS1Mqva+PgvhvGtqzLU6pi1v6KieOXo9SKK660woehbnCSQU9ezkoObpQy+
	 dIY34Vzv/r04w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	bijan311@gmail.com,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/5] mm/damon/sysfs: test commit input against realistic destination
Date: Thu, 16 Oct 2025 14:47:29 -0700
Message-ID: <20251016214736.84286-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016214736.84286-1-sj@kernel.org>
References: <20251016214736.84286-1-sj@kernel.org>
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

If a source target has obsolete field set, the test-purpose commit will
fail because damon_commit_targets() fails when there is a source
obsolete target that cannot find its matching destination target.  DAMON
sysfs interface is not letting users set the field for now, so there is
no problem.  However, a following commit will support that.  Also there
could be similar future changes that making commit fails based on
current context structure.

Make the test purpose commit destination context similar to the current
running one, by committing the running one to the test purpose context,
before doing the real test-purpose commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dfdf69bdbbd3..6848437b86af 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1680,6 +1680,26 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
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
@@ -1701,7 +1721,7 @@ static int damon_sysfs_commit_input(void *data)
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
