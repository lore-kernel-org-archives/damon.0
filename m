Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00019F11B;
	Thu, 19 Dec 2024 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581027; cv=none; b=pQdechKKaqOm0Q4vzBEkLclrxXWSmYCHxEOAvdndpfsRT2trz/sxGA8LGarZo6hYBrQtZqo5UlMkO5M5xl2Y/Pn2QJuug+AyqCzT9xxNAiji/+HaRqEvN/wOjB6f2rS+A2ui63eFP78hj+ZGI6rPG66ZCgA76VcZeNBV3JWbzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581027; c=relaxed/simple;
	bh=v/ZiBRKbfbEykvCZNndO3AyZ9fQawvkE+ZCwqKdxiC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9bG2A3NxYOJoqXPWjvw0hx/q8nRYTK8TsUAa9BjPok3d06TTTSprjvX9uFjZjeYhXlq/MUoB2hbF4vV8AzViwBGraTH+xR4yiknW+I2y50UsngxdKy4ZnltGMCQzk3iQnPFlqEFnibL2nI49MbyQUhnDRyfBVgJWbRcL251Oro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLwCY7XC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLwCY7XC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3310C4CED7;
	Thu, 19 Dec 2024 04:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581026;
	bh=v/ZiBRKbfbEykvCZNndO3AyZ9fQawvkE+ZCwqKdxiC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLwCY7XCrXKLl9hrAIUoT8AM3rD7urUs/LxhpOgzcOc44OGsZAqdYBpczJLDfhqQd
	 Ugn8zdzXuyFUXipe/UpgChq1b7JY/NSSHKYsY68x4fZXAormDkhvVroMcIe/ddmgPk
	 D5agXjvf1pgf4EYBd60zHJfO5mxdeXSSJmE5+Y8ed9riJ927yCogDgGJb799JENyTg
	 3r74323OuSU6EHo5GhuZ/lCwdOUEnyVMddvXdn/N+WZKizVT590zkYNkgQURdZIeMk
	 DD92sALUgMeLD5Zl1PeFhKkK30JIS8Ms3XQIYkLfaPg6jF/Hh3ZXtVFtLlWNZwSfTA
	 r57yPAYktc80g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/18] mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action
Date: Wed, 18 Dec 2024 20:03:16 -0800
Message-Id: <20241219040327.61902-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_STAT action handling of paddr DAMON operations set implementation
is simply ignoring the filters, and therefore not reporting back the
filter-passed bytes.  Apply the filtrs and report back the information.

Before this change, DAMOS_STAT was doing nothing for DAMOS filters.
Hence users might see some performance regressions.  Such regression for
use cases where no filter is added to the scheme will be negligible,
since this change implementation avoid unnecessary filtering works if no
filter is installed.

For old users who were using DAMOS_STAT with filters, the regression
could be visible depending on the size of the region and the overhead of
the installed DAMOS filters.  But, because the filters were completely
ignored before in the use case, no real users would really depend on
such use case that makes no point.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5944316a0b4c..b0c283808ba6 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -485,6 +485,39 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	return applied * PAGE_SIZE;
 }
 
+static bool damon_pa_scheme_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+
+	damos_for_each_filter(f, s)
+		return true;
+	return false;
+}
+
+static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
+{
+	unsigned long addr;
+	LIST_HEAD(folio_list);
+
+	if (!damon_pa_scheme_has_filter(s))
+		return 0;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+
+		if (!folio)
+			continue;
+
+		if (damos_pa_filter_out(s, folio))
+			goto put_folio;
+		else
+			*sz_filter_passed += folio_size(folio);
+put_folio:
+		folio_put(folio);
+	}
+	return 0;
+}
 
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
@@ -501,7 +534,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		break;
+		return damon_pa_stat(r, scheme, sz_filter_passed);
 	default:
 		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
-- 
2.39.5

