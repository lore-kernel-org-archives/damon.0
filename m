Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A138B;
	Tue, 19 Aug 2025 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584396; cv=none; b=bkQvAY+V2BdYHbnFX7lvadz2X5Hg2KLY2m6GY0VhykbAgSutmDBbrsarO1iRFCpeUHttuuOE/Px4ZJpvKu2eSHZj/WJnqa9U3IV+rKBkGcdE0rm49dVYi4W+YReEAMXy7eY9XU4Npg1MzZ6WoyvpVsiJiLb5cONZv/Gl47i05BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584396; c=relaxed/simple;
	bh=s5rBpCaCaXvNVfSMIqwRsPuPA1JvP0VWMtY/Ojlh4yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWukO4H3NwegXyrzyRRRu51M3VBJA1csjCsvGD7cAVohfowj5PxMJFaFh+Bs8kvGNgQkHbVQrKEeaX/u7XUlcGMdz+WbO7WUYcUiQ/MJHg7LUOJbGSgT48RnnPf2cB9FyFBoY8aMta4gZQhCaO2PY1HKDvAgnJd3GaaBksBKkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq/ughyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq/ughyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB88DC4CEF4;
	Tue, 19 Aug 2025 06:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584396;
	bh=s5rBpCaCaXvNVfSMIqwRsPuPA1JvP0VWMtY/Ojlh4yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yq/ughyr6tIXr2dcVNliYIQNkgvzfkzwCxxgvwkWaJ2SvqQ2WrXwNFUArlRQd9QLj
	 N9Cp1e0ix+PyDfbD1RmowghW2mU3e1wpDFgwDrvjh1BdkIUFWHUN13symnQhwoQlDD
	 FWWIkVvquapndDNi+337iI7sX/DLOoifCwcK6gWHol1bNjv9ZV8a/+Y4wRqF8QNaZf
	 239tadlTXO4O7OqpGFtDXaxXSZf/7kEo9RTbuosIhMadm0N8TgTwlKVG7pqdYEMwtS
	 f2q8eJ/FtsfCgYYcO5PhiYvqaULsUH0LfY57ZwljWw5wX5rjIZBFH4ajnKJXCzGCbZ
	 mNvSOdgrL/UMg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 04/16] mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
Date: Mon, 18 Aug 2025 23:19:52 -0700
Message-Id: <20250819061952.39429-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-5-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Quanmin,

On Wed, 13 Aug 2025 13:06:54 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_LRU_PRIO and DAMOS_LRU_DEPRIO action
> handling from the DAMOS operation implementation for the physical
> address space.

As I suggested on another reply[1], please squash attaching patch to this one
when you post next version of this series.

[1] https://lore.kernel.org/0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch

[...]


Thanks,
SJ

==== Attachment 0 (0001-mm-damon-paddr-set-DAMOS_LRU_-DE-PRIO-stat-in-core-a.patch) ====
From a05d13d152443f35b7a85e0bd5ccecf294b699c0 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 13 Aug 2025 21:26:48 -0700
Subject: [PATCH] mm/damon/paddr: set DAMOS_LRU_[DE]PRIO stat in core address
 unit

Operations layer should set DAMOS stat in core layer address unit, but
paddr is returning that for LRU_[DE]PRIO in paddr address unit.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6263dd58a2e7..ed71dd0bf80e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -198,8 +198,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		struct damos *s, bool mark_accessed,
 		unsigned long *sz_filter_passed)
 {
-	phys_addr_t addr;
-	unsigned long applied = 0;
+	phys_addr_t addr, applied = 0;
 	struct folio *folio;
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
@@ -213,7 +212,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
 		else
-			*sz_filter_passed += folio_size(folio);
+			*sz_filter_passed += folio_size(folio) / addr_unit;
 
 		if (mark_accessed)
 			folio_mark_accessed(folio);
@@ -225,7 +224,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		folio_put(folio);
 	}
 	s->last_applied = folio;
-	return applied * PAGE_SIZE;
+	return applied * PAGE_SIZE / addr_unit;
 }
 
 static unsigned long damon_pa_mark_accessed(struct damon_region *r,
-- 
2.39.5

