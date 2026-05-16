Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4237D105
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778965453; cv=none; b=klUXLDsLhCae+/RuxY5uHgP+aH/HktiC71REzIRYRylXiSaFMd+NR/OndF/6BP7151VkQymq5CqHGCaFQlCW3McZQXluyibJ8niDdbT8VY4FXjn5z5HRexMdMX+myXbPoqYUy5Vz9ORtRkxamaLP7ZJ3Nd7/mj232Q3OvNrbfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778965453; c=relaxed/simple;
	bh=GEYyugiLC/39SzrjBwPLIt1vcjzzwMWmrLt7pnxaa/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkh8e9NV2O456/rEunRR1SB8Sen7RbeKwB++wTY9nAEi2nWzXrCS/4XvXPz5Dd8qDaMnv8ObcBWYRlDZMnzMIeBO2pFknA4/ySo0LTZIYyRRVXGWanB3hyQSqn4MojgSA+GdrmdKKcw2HyzXC/z3eTGSJJKEi3Pk9GQ8skZncGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmGerb3I; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmGerb3I"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-65c364b893aso1293333d50.0
        for <damon@lists.linux.dev>; Sat, 16 May 2026 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778965450; x=1779570250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zii2AWb8oMGGjdpxDAORttiwCSLXiloFVUhqxIkFOU=;
        b=HmGerb3IC7ah5KJzaFjWz8XH9e0mcH9CALOFQUoGpC68wPc1bI5KmUTekFkaamBIR4
         Yz36pcXq1gH/vdCBmMVq7GIcRYvo0uBghDnI6eUtLKwg+XI3ahWLp0Qy5pdFjKuP22qQ
         QSS1QUf0V79uyN1oGwpaZ1VPFXmpSeonZrvf9+aV6ywSCUnIyThYXtF6AlxAvV/GqRj/
         GYW/ci0LBIzsuGuIAybbqJlNPs7aGY94jqQlJNOERqDf8WEAPWPj1zc0SQA8WamDKRh+
         /cEXjg7UwITh2MXX+BNyxQcXjOI8g9lDbV5o3VNLyCb6jwD8YWES+jESFv9UVzjVnUXe
         7P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778965450; x=1779570250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zii2AWb8oMGGjdpxDAORttiwCSLXiloFVUhqxIkFOU=;
        b=WCm0PT2pNFa3lnSVJmfxCi/8pkDakss3eTuYvl0zbIHOi64u66zoatgMQ3sN89mcz3
         X0YQlhX1kueBv2i75RdXrtFcEukYGYFc1tpOJFNLq/kcu9RQvXxoy3d9p6Whwlm17qFU
         4cgCFsat4GJ34LrF+UysyU1tJuepiiUKRne7rh32gNz82ckhNXbDZEWNTlMrz9EEOPAi
         5zuFcZtXw4FgtW1qfB6gh8f/Jp+Eb3qItq9unmM14jpkpwA0iAw49SPbjeUBemln+0Lp
         STTFaO7vwQJFa+R86X3dct3OVoYmszxxCxVVIDYjWaez1uk5jGMY+am/scFcuopnDkcf
         1nAg==
X-Forwarded-Encrypted: i=1; AFNElJ+FmGPX1fF7S1OMf9K1Dd4FDw5oIr2Neqo+PlYyf4Rz9ANdpytfRMUqgxw+CTxgG+Z7knACCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvbDce0pJp28BPloByFfA3VJoobtAypvmsqT2NFcG2Aa3Eco7m
	Bpclh0W3+48cC9l/uzt+bxNnsYEKdVnF6uPikRb75EdegkzX07g16i8=
X-Gm-Gg: Acq92OEWqC8MnE98FlMcLNH01OTsySdiyhHQwqgoqEnKeK4R/zS6fTEAsVbwa2dh7Kt
	3yKDurlX8u0umuMXykM3yo1j/1GPaMSDp4G2VTaJKEKyPCvZBrO5jHRa6JG9ZltoOQMPkIm0X91
	FsCXkStVf+NgKpSfKSNfr1+ZP4AyQ5Aghn0g+B4s9bXUarSdCPCEhUydcqancmq8s+8T+9x2+X8
	y4720d5nieBi63lN4/fl6gswxd7KMIogClHFYF7VuvV6RLijBbDfn0cWIfhJ9lUU+55jl0E1to3
	0OXexHPuTba3spMpUxxjRqTqKTDEeGmAQNjdfexHRiL6Dzfx5b3bdUzJfUS5QMj7I1cahoQ7m1K
	R3vR24r/QURBHKwMWSVPeHs0qUF/kWdFPRAYVfvIDYWkAl+dmd1CMhRecZvGyhcUYxGGWv8th0k
	cBBkOEutTIF9ELiQf6LOaKR16qHBB0v+tHAzkwRj6Dm6MdYrsC3WPWZRxhKlKMNM6MLGb4U6hRa
	g==
X-Received: by 2002:a05:690e:191b:b0:65e:c81:3a6c with SMTP id 956f58d0204a3-65e226dcb9dmr9397203d50.15.1778965450383;
        Sat, 16 May 2026 14:04:10 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86c850sm4349204d50.1.2026.05.16.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:04:09 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 4/5] mm/damon/paddr: skip free pageblocks in migration walk
Date: Sat, 16 May 2026 14:03:56 -0700
Message-ID: <20260516210357.2247-5-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516210357.2247-1-ravis.opensrc@gmail.com>
References: <20260516210357.2247-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_migrate() walks every PFN in a region linearly, calling
damon_get_folio() for each one.  On sparse physical address spaces
(e.g., CXL-attached memory), a single DAMON region can span hundreds
of gigabytes where most memory is free and sitting in the buddy
allocator.  Most page lookups are fruitless and dominate kdamond
tick time.

Check at pageblock boundaries (2MB on x86_64) whether the block is
entirely free.  If the first page of a pageblock is a buddy page at
pageblock_order or higher, the entire block is free and can be
skipped.  Similarly skip pageblocks where pfn_to_online_page() returns
NULL.

This reduces the iteration from O(region_sz / PAGE_SIZE) to
O(region_sz / pageblock_sz) + O(populated_pages).

buddy_order_unsafe() is used without zone->lock.  A transient false
positive (block becomes non-free between the PageBuddy and order
checks) costs at most one tick of missed candidates on that block;
the next tick re-scans.  No correctness consequence as DAMON walks
are best-effort.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/paddr.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index c4738cd5e221e..e844c990987b9 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -258,13 +258,32 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	phys_addr_t addr, applied;
+	phys_addr_t addr, end, applied;
 	LIST_HEAD(folio_list);
 	struct folio *folio = NULL;
+	unsigned long pfn;
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
-	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
-		folio = damon_get_folio(PHYS_PFN(addr));
+	end = damon_pa_phys_addr(r->ar.end, addr_unit);
+	while (addr < end) {
+		pfn = PHYS_PFN(addr);
+
+		/* Skip pageblocks that are entirely free. */
+		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
+			struct page *page = pfn_to_online_page(pfn);
+
+			if (!page) {
+				addr += pageblock_nr_pages * PAGE_SIZE;
+				continue;
+			}
+			if (PageBuddy(page) &&
+			    buddy_order_unsafe(page) >= pageblock_order) {
+				addr += pageblock_nr_pages * PAGE_SIZE;
+				continue;
+			}
+		}
+
+		folio = damon_get_folio(pfn);
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
-- 
2.43.0

