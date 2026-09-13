Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3137204E;
	Sun, 13 Sep 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319504; cv=none; b=Ja+86Pw32QYvw/7MLje+j2fx1ipY0NNRVsCUyYsrGOPbIjNIxefDWlyHmpvE76zNEMGaRQO8IrtTYugbiVf9v6FidOi/Tu1mKy8nmwBLkY2SurrAP1bsuO/LZ6pe7wIfakOf6RwtjVLsC+E/pLl2gtuitBdvppToA3uVL6DHmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319504; c=relaxed/simple;
	bh=ObgMoYABrldXrXdU0sL5fWI1QVVyakXAVpf6lagOAG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izLHrqpS4O3LUe0lUsOm8ZQ3z2nYTCxDB7KqwlobA2V1XVl/25HzwEIVXCJD7EDOjUCdEkDQLBe8rQHYeSV/z8u4Pl2o56TVaczpXl9pT6CokBzwlJYIplw7r7GVfJh7Pp3ReaAJsdkQ6c1Q2tL0mkTJ1cgukSyuHN36y01WRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFquwlYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFquwlYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922871F00893;
	Sun, 13 Sep 2026 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319502;
	bh=1THrGcC3ePDhKbhiSZYXQDRdyryWEO/KzCpY2oKcSSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OFquwlYbr3QhoekrU4ZORdHQzsMivjK9VhJLQOFwTV2/tyoqge9b20QuSi2SrIkmf
	 tankTfYXLBtNg9ykTMR4C3w9d3IDZ6yVZaWKz1P52cqx4HyNaSYSF8zMs065FPxrLf
	 5bvWM/0fYlwAxXfuyFwwN5Q/82r+L/V1kZY28e3OPEe3XPdFeOXqtxHsABIXe1mTGu
	 uJdp6pt7JRapCttdg8fO0xHrLCpM7WSO37fLpXHwUz0Ueq9aCNlXgcjhat/JF7YWMO
	 beBSSkAg+BJgs17kxpT5JlH3MQgdOM5xueePt+o614YbJIjb2UkR7m29DH3ro/p/0C
	 y4oQ1Z0NEqXXg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/8] mm/damon/core: commit hugepage_size type damon filter
Date: Sun, 13 Sep 2026 10:11:24 -0700
Message-ID: <20260913171133.102366-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend data attribute probe filters commit logic for the new
hugepage_size filter type.  Since it needs to carry the size range of
the hugepage, update the logic to update the size range fields of the
commit destination filter struct.  While doing that, validate the given
range and propagate an error if it is invalid.  Add the error handling
in the callers, too.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5212bfb8f85f2..e2b41a434cd2b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1818,7 +1818,7 @@ static int damon_commit_preps(struct damon_probe *dst, struct damon_probe *src)
 	return 0;
 }
 
-static void damon_commit_filter(struct damon_filter *dst,
+static int damon_commit_filter(struct damon_filter *dst,
 		struct damon_filter *src)
 {
 	dst->type = src->type;
@@ -1828,23 +1828,33 @@ static void damon_commit_filter(struct damon_filter *dst,
 	case DAMON_FILTER_TYPE_MEMCG:
 		dst->memcg_id = src->memcg_id;
 		break;
+	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (src->range_max < src->range_min)
+			return -EINVAL;
+		dst->range_min = src->range_min;
+		dst->range_max = src->range_max;
+		break;
 	default:
 		break;
 	}
+	return 0;
 }
 
 static int damon_commit_filters(struct damon_probe *dst,
 		struct damon_probe *src)
 {
 	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damon_for_each_filter_safe(dst_filter, next, dst) {
 		src_filter = damon_nth_filter(i++, src);
-		if (src_filter)
-			damon_commit_filter(dst_filter, src_filter);
-		else
+		if (src_filter) {
+			err = damon_commit_filter(dst_filter, src_filter);
+			if (err)
+				return err;
+		} else {
 			damon_destroy_filter(dst_filter);
+		}
 	}
 
 	damon_for_each_filter_safe(src_filter, next, src) {
-- 
2.47.3
