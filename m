Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCD25CC5E;
	Tue, 19 Aug 2025 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584483; cv=none; b=jsMxk4pS1zxU1lKzk6u34+lPEtIayekhPpieFhtW4bMHbtixeu2wxbfD2k7jYYD76aqFGD+vuUpgEi26avaczVcoVYCNQhCMXVf6/rwZQ0yVyjgfAW6CSn9cBG1idN5mYBeSNC3mfV6TL1IQpQst99RfTEh0WU2Xuqd28PQN2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584483; c=relaxed/simple;
	bh=pK6z1L1/qDmQzrg1OPWWIWzBYUAMhdhzZuy4QSxU5Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbz2kttaGHpnLieqbJAlVrGqgSRMj3XP3AX484TWSEp8NH2j/DNmyfNDnBpWLjdw3GvAQMvFOVrYfjGcgt2RkVvZd5O20dW+5kuVsfzMqr0TnR2MUbBcuIheVyZ4JOuYiUfrbxtazZ+e0sO9nt6RBrHToUseJaLZA9AKJ2ZvfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsDE1Quq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsDE1Quq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581E8C113CF;
	Tue, 19 Aug 2025 06:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584480;
	bh=pK6z1L1/qDmQzrg1OPWWIWzBYUAMhdhzZuy4QSxU5Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsDE1Quqw4qHQJ5SjoAEnnm3JcfpezfrbeW1TXMyTgdL8BxySsQZmeXLkxX46SsTv
	 rI2L+9ka80CC9uM5d07yraLnDOsczECvhb819Fr9/FyXfh0QLtPuPVPSlLFuJyltp8
	 fe8SC5C7FiR7mP0xknSkk8ZGKd6/ZJ0zmnw+lPkGD8no0TM5T4WV7kTQJLRpacvHJo
	 P6VIeUt5BKJ25oayTQVELmIE0rylJR3ck4b1vSy/hDQ2Jtng7oNmA3pyvzvY19/lWL
	 ukxbsvBsdqvXsqM82xqnp1qBywU5F+NCg+PCsXgDFKc9VHIHFdQzufTsSUwT80vmIv
	 ZhWLGR7g/+QVg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 05/16] mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
Date: Mon, 18 Aug 2025 23:21:16 -0700
Message-Id: <20250819062116.39593-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-6-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Quanmin,

On Wed, 13 Aug 2025 13:06:55 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD
> action handling from the DAMOS operation implementation for the physical
> address space.

As I suggested on another reply[1], please squash attaching patch to this one
when you post next version of this series.

[1] https://lore.kernel.org/0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch

[...]


Thanks,
SJ

==== Attachment 0 (0001-mm-damon-paddr-set-DAMOS_MIGRATE_-HOT-COLD-stat-in-c.patch) ====
From f491a6a940444799dfe1e76433234d1849a21c58 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 13 Aug 2025 21:27:59 -0700
Subject: [PATCH] mm/damon/paddr: set DAMOS_MIGRATE_{HOT,COLD} stat in core
 address unit

Operations layer should set DAMOS stat in core layer address unit, but
paddr is returning that for MIGRATE_{HOT,COLD} in paddr address unit.
Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index bb3b149b75ba..0305e59818da 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -247,8 +247,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	phys_addr_t addr;
-	unsigned long applied;
+	phys_addr_t addr, applied;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
 
@@ -263,7 +262,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
 		else
-			*sz_filter_passed += folio_size(folio);
+			*sz_filter_passed += folio_size(folio) / addr_unit;
 
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
@@ -275,7 +274,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 	applied = damon_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
 	s->last_applied = folio;
-	return applied * PAGE_SIZE;
+	return applied * PAGE_SIZE / addr_unit;
 }
 
 static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
-- 
2.39.5

