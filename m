Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D561E0DBD;
	Mon,  6 Jan 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192054; cv=none; b=hUy+MAwPfvc6RwulPKSjdL9QtBDyAo2shxvaMOyrmsuP7RbD6pNeiu8NWlXVvxetWHp/7LjBlmz6HLztqHiAVM1CSQIYcZONiDki7hVoyUBtiDJzX/re/yRV4fnHAtDHfrlHPR4pnbgOj5K5IUibpNoil+8Xzz6Ovft5/ub+lB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192054; c=relaxed/simple;
	bh=g81jBx5R64ofCs/+zCq5N7Um6JZR0CPZvNzSfSj4qFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9Rg04n3FseMpaa6O2FwrrSPT/Z1htsIswNjulnMk36fBAVFsLjq9jzT/jwQodSuTyjlBQT0X5aiEmplAN98x/9NaNmum99O3AuhtOlNYudQJNV4/Y7gNcUsQdXzkRANAMRSea0CSrEYNtWYEbOz4rBd/JRkQmMbtqzJlu2zyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGjmLeiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGjmLeiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF43C4CEE1;
	Mon,  6 Jan 2025 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192054;
	bh=g81jBx5R64ofCs/+zCq5N7Um6JZR0CPZvNzSfSj4qFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGjmLeiURNXmHa2AE4peDuREnuTW8zRsFNpulcMswaELc6PGc9Thi5MSy4pRcfEzn
	 prnaEukjxB4D2DBQAqTf0n6CLUxIb2pnX8x4ylZ4KCCPuJPq5STZ0By3fzSMwpjBA2
	 kxXFjcPHlxZqKc6Xf1DNVnauc8ZNUSUh7Qr2wUZvcklzHpPmy4Dxf5qEpt0Uo5r7zx
	 y9kZng7r2YoCsAMCI5ulud68kZpexiwHJkwhRgiGByRa1kVWNtkgQ08Oohzh9NOXou
	 T5uHsUNn4nhnGX/zzC9QsM5FA9KXZdf+iMcfG6jeZNwrFbWLWGQu7yjSMrVnStIHrw
	 h+QOw4chsZINQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/16] mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action
Date: Mon,  6 Jan 2025 11:33:51 -0800
Message-Id: <20250106193401.109161-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_STAT action handling of paddr DAMON operations set implementation
is simply ignoring the region-internal DAMOS filters, and therefore not
reporting back the filter-passed bytes.  Apply the filters and report
back the information.

Before this change, DAMOS_STAT was doing nothing for DAMOS filters.
Hence users might see some performance regressions.  Such regression for
use cases where no region-internal DAMOS filter is added to the scheme
will be negligible, since this change avoids unnecessary filtering works
if no such filter is installed.

For old users who are using DAMOS_STAT with the types of filters, the
regression could be visible depending on the size of the region and the
overhead of the installed DAMOS filters.  But, because the filters were
completely ignored before in the use case, no real users would really
depend on such use case that makes no point.

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
