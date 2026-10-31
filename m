Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478383;
	b=lTrsgthYRLTjKcOvWVih9IYdcNQe8xUuX8Eea5hAhGXsWEZrsnoI/ttmAFVm3Y+lO9KY
	 XUU/X8LjQJMtVWFH5jo0vwMfU5Sza2mpVLgFF09AduyfS75SynMNRZ25vd9HUJO/jgRnL
	 EZuXfErB8BRkkmiThg0l4jplQhkCJYWeXC+AJFi95re/0Fb2jWh5/h9nYRu5F51oSrQHk
	 4N8PSDT7N11pqYkHacRU9UMqzEJLui4qJ8urvjNwo9kK2Uky2lsHWbLR64Jt4tlQrXgfo
	 v/D1+CeC65T38HjJMOTX7g1UY41QO8UzRz+bLQ4Xwy45m8++THMFy9nGVjpB6AmSubA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kOWWL3M+VZ5r98aKn5hrniliEJVp1VQubbGhe+wLkOI=;
	b=T04OkkFx/8M6LrwzGhYqgHxnpxfVjo4lSsx8a/Kh0bzaCUfVU3Xk5qdOPbC+3qPyUrGk
	 iixC6Nb2nEmZbh+WuOL9FY+oKJpwbZMUDDNWEVYi3UF6neOmTFqqw1IdpwxwGeAVX9zCu
	 j/7N72nzYJGDgVKJJlLuL+5A6byA/+YPev7cdJc3YoFgFdLZtldyy0J/+iENfcF8ma4p3
	 jvT1GTYDKY1cMyeJsqSuXr/+sxKmDhe4m4ISysjnbIuHBmAy4pcxdR2IoYq1OupWA5h/n
	 uYOXQUqLvzXRLCNx5hOeRA5e6xYMjXe8+3SOv/vCUhOwmbEK6V0QXH5vLzKIjOxgLCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwUuj8bJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68037606A323;
	Sat, 31 Oct 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwUuj8bJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F9B1F00A15;
	Sat, 31 Oct 2026 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478383;
	bh=kOWWL3M+VZ5r98aKn5hrniliEJVp1VQubbGhe+wLkOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwUuj8bJhrOGolYSTqKBJpONRcCmYDmwI/dbDHKggPP3UnwuRI1Whwuv/2KWvgDgj
	 OKnKP3ulpyV5d7iqrRdeWpE5RimU6BKA8uPisfPOUx8TqfFhPOOVsN7rw9dbPoxSbb
	 T3RLoE5bLCIo1geXJMPfW/HUGza3al88kA5YbokU0d98ZYQeSbi+RY/++2uRgKbuJf
	 BR1VIImWdvjeA3lwElWJ7DGVrToZRyDOytPnABYUhiuHhz8sQPXfXVXuYatfvdiZxK
	 ivSJgz3VwyJX4pa604MJW85gSZh7c+yuRu0Kd+lQ8hVmWeOZoQLUMAyHGf0SS67PH1
	 WRMNkItbY50zA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/6] mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold} action
Date: Sat, 31 Oct 2026 13:26:10 -0700
Message-ID: <20261031202614.96036-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031202614.96036-1-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support of DAMOS ops filter and sz_filter_passed support is up to each
operation set.  DAMON_VADDR supports both for only damos_stat action.
It intentionally does not support those for madvise-based actions
because applying filters could make it unnecessarily complicated and
expensive.  The vaddr implementation of migrate_{hot,cold} action does
support DAMOS ops filters but sz_filter_passed.  There is no real reason
to not support sz_filter_passed.  Add the support.

Pass the sz_filter_passed pointer to the filter applying logic and
accumulate the number.

Closes: https://sashiko.dev/#/bug/linux-986e8b64-8e65-4e32-970f-4d3ebdf8206e
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c271b6d63c027..112095c2d53fd 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -776,6 +776,7 @@ static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
 struct damos_va_migrate_private {
 	struct list_head *migration_lists;
 	struct damos *scheme;
+	unsigned long *sz_filter_passed;
 };
 
 /*
@@ -840,6 +841,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct damos_va_migrate_private *priv = walk->private;
 	struct list_head *migration_lists = priv->migration_lists;
 	struct damos *s = priv->scheme;
+	unsigned long *sz_filter_passed = priv->sz_filter_passed;
 	struct damos_migrate_dests *dests = &s->migrate_dests;
 	struct folio *folio;
 	spinlock_t *ptl;
@@ -858,6 +860,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			goto huge_out;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
 			goto huge_out;
+		*sz_filter_passed += folio_size(folio);
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
 huge_out:
@@ -885,6 +888,7 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		nr = folio_nr_pages(folio) - page_idx;
 		if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
 			continue;
+		*sz_filter_passed += folio_size(folio);
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
 	}
-- 
2.47.3
