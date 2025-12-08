Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B331AF0A;
	Mon,  8 Dec 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175415; cv=none; b=mQ4lsmYGwV02ZUbLe1FprrrOTpUFdJ+IFPp7eprko3Ck6RgqJykBzr/xizcAZ+L9bA2NQcMz9kFt1E9F7ttTuf1fheJh05IdyWWpBqQ6R7BHEvINdFYGBbbKd+n8tHYBVc773EUDz+MLnT80xUvbLlsTRGfjSF+Zy4Uo9tyTYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175415; c=relaxed/simple;
	bh=CBKpePU8YzS24DYStTop8saXN/aFoeKY8A1ZQfy6x5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utEWsi1lG7FLojZCkKH81bz5kcsMTjbbXwb0S+byZsiqo4yGwxYgn7LonVATwpJbfGNdIOZhCDcklnojSNZIWvD/+KXtq+mrFnqyJ5GI+vxuKLo7SD3szKt6BalDHB6IOv9HCBRPmgIZREmN2w+qDvMIPvYVbSvqAhHl+VCzfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1fWbwwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1fWbwwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297D2C19421;
	Mon,  8 Dec 2025 06:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175415;
	bh=CBKpePU8YzS24DYStTop8saXN/aFoeKY8A1ZQfy6x5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1fWbwwdL26H7CSpT1GiJ3AXdvHU2IoXrM7xZolVsqDyKPyOqF/8dNFIB3QywHqBy
	 4YIGrJZ1XhOsJiXFJ5xEvJ2qURr2ItUpG13MwlQ4tvtts08nLfjyFn4LlDzJRnrJS4
	 ApOrQasTN5tCXMWznZl364rhzFlGYVy8MdJqxyUjqQyyBK2OorUA6VEC07qdSIITgh
	 46i5xwRlJK+r9e/oj6UeoEjJQxu6Anm/BS+ZX7IXz/23Xcz2xocIbTZl6JqYCfzyxY
	 j6+Kms2homn/pE2wPiIPeOcGFX0tZKx34/pbbECHjMI6wpFuRfDUSzXLSppPb98TGd
	 zp1YsLwz1jrmA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 17/37] mm/damon/core: commit damon_sample_filters
Date: Sun,  7 Dec 2025 22:29:21 -0800
Message-ID: <20251208062943.68824-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data structure for access sample results filtering is not supported
on the online parameters update function.  Hence the feature cannot be
used with the online parameters update.  Add the support.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4b98473eef84..d952a833a05e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -573,6 +573,19 @@ void damon_destroy_sample_filter(struct damon_sample_filter *f,
 	damon_free_sample_filter(f);
 }
 
+static struct damon_sample_filter *damon_nth_sample_filter(int n,
+		struct damon_sample_control *ctrl)
+{
+	struct damon_sample_filter *f;
+	int i = 0;
+
+	damon_for_each_sample_filter(f, ctrl) {
+		if (i++ == n)
+			return f;
+	}
+	return NULL;
+}
+
 struct damon_ctx *damon_new_ctx(void)
 {
 	struct damon_ctx *ctx;
@@ -1290,6 +1303,67 @@ static int damon_commit_targets(
 	return 0;
 }
 
+static int damon_commit_sample_filter_arg(struct damon_sample_filter *dst,
+		struct damon_sample_filter *src)
+{
+	switch (src->type) {
+	case DAMON_FILTER_TYPE_CPUMASK:
+		dst->cpumask = src->cpumask;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int damon_commit_sample_filter(struct damon_sample_filter *dst,
+		struct damon_sample_filter *src)
+{
+	int err;
+
+	err = damon_commit_sample_filter_arg(dst, src);
+	if (err)
+		return err;
+	dst->matching = src->matching;
+	dst->allow = src->allow;
+	return 0;
+}
+
+static int damon_commit_sample_filters(struct damon_sample_control *dst,
+		struct damon_sample_control *src)
+{
+	struct damon_sample_filter *dst_filter, *next, *src_filter, *new_filter;
+	int i = 0, j = 0, err;
+
+	damon_for_each_sample_filter_safe(dst_filter, next, dst) {
+		src_filter = damon_nth_sample_filter(i++, src);
+		if (src_filter) {
+			err = damon_commit_sample_filter(dst_filter,
+					src_filter);
+			if (err)
+				return err;
+		} else {
+			damon_destroy_sample_filter(dst_filter, dst);
+		}
+	}
+
+	damon_for_each_sample_filter_safe(src_filter, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_filter = damon_new_sample_filter(
+				src_filter->type, src_filter->matching,
+				src_filter->allow);
+		if (!new_filter)
+			return -ENOMEM;
+		err = damon_commit_sample_filter_arg(new_filter, src_filter);
+		if (err)
+			return err;
+		damon_add_sample_filter(dst, new_filter);
+	}
+	return 0;
+}
+
 static bool damon_primitives_enabled_invalid(
 		struct damon_primitives_enabled *config)
 {
@@ -1304,7 +1378,7 @@ static int damon_commit_sample_control(
 		return -EINVAL;
 
 	dst->primitives_enabled = src->primitives_enabled;
-	return 0;
+	return damon_commit_sample_filters(dst, src);
 }
 
 /**
-- 
2.47.3
