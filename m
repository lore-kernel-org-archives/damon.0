Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D03D904C
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268045; cv=none; b=LD+PhgDEUUzasQIhguH1SDKwEei50X4GlNAb569BS5D8DXBZtvKrzaQr3YkhDRF2fivGSvOyfN1g3hEtR0+nx916U2FNNfqvbcDhBdNvNZmNR4EMqwQn4YKmoeuyycGQMKtxRG4RZCp1gzSgo6NkO7DVDmsfALr8NptykdpRl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268045; c=relaxed/simple;
	bh=PuZnS2PBpT4z1QK6GdIo33xJLX9UDaRIoEWclhh/glE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3GPOOeeZwCl1ng3NEMq7g9bqVaGk5WtV7xHdpivoG91KRpeI39kgx6qsKzYHSiDCBourQwXoND/ABjmanVJlRn+2XuIKc47jq51G1USjfFYBOkq78WP0HGq5ZPawyHo4L3j4Jcn4M5U+D6G31xeGMJ205b88pxCg6fbX2fIdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kipuCaVM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kipuCaVM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso12430166d6.1
        for <damon@lists.linux.dev>; Tue, 28 Jul 2026 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785268041; x=1785872841; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kyqcd3FBVuM2mNP4trmIDwWU9GQiAMQYkdXDbyMf08Y=;
        b=kipuCaVMbEM2k8GHFrvutQWniuzf4astL/InPWqCkMKreUiiZ38lRtuhJyPXLhS8aJ
         xULobNEw5z3hDctV+wOlabBonwMa4+ZQy7kV53uuYRkgXZrPcG8Fa/PbUSmt4kTRZ2JH
         xXn6Erz2SXkHKEKNC75giEdjV8GSZDWeB96jyrH/Q2/5GWKqqtVp7gEoHEbuiROHEJMU
         WHw7MKUflNhpFJO1d9hw9uhJlomfaY/CrQzvmSx5uuqmoeAGVsuI9ZGLBHO0Yha4c9S5
         A9xUUxJMSwBqZW3nk8a7WLdwZ0RMFWDQhcJsTXKMoTfkGR9DBCX96+BH9PlzlFatHKH3
         ltEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268041; x=1785872841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kyqcd3FBVuM2mNP4trmIDwWU9GQiAMQYkdXDbyMf08Y=;
        b=KDdv8JTfTkboheUwQ3RvWb50GVXzDq8gtOmZhaQYYNuGRLXNtg2Mo3QLzfm0sEoq/I
         7Mpt0IegqJiO2jdw0XWeGKyy8PIy/bJ3r5Ir4VvrzOf/RDFut9pYEtBAEkI8aFrpv8yQ
         fS7pTtr2l+Gv8J8pz2MBKI/Nn0OKADS1AoAKhd0XWiWSesOTTVmMuj9ERY+weDdiZFst
         o64ZE3Kbb4gVHDYOPZmWn5BQxHrTrCuuw56xziq3HrEoQwCeoGVTA6fcpO4ah38x0IXh
         pHs+TIhKsNHwpZAa0BnzKm9qWnHq8HQz3cKZ6DvNj/BU1Y8tadHfODVqalO8zQWPS+u9
         K3gg==
X-Gm-Message-State: AOJu0YxztyI3OU9h4aWKaR0cKJheLdYgr6y/ZYBRSS/rzkS7aXOehybT
	Kcz+DYQDKpbmfGpeLkEpByN/wmnL2TW38sgCUsTjASR33+QTQjqpuDPUHb5TQvTP3Mg=
X-Gm-Gg: AR+sD12FSk0GzRPOSO5eGfXzLddpZn981ET5LgGkh37Q1nr/u+zbq63PjUPiBLDSxc/
	RtAGxP35zZ1PlEOnTEIQE6jJpUbGH4IEz1+SgZPYbZGCJ3I5uS6Xu42gz0499mQ+ZxvqcG26bjC
	0tCKMZ2W1Y04WdjpezfUNjogglLeQcSHkPBV1MDUqQHujwIZu2tu/NDx7inlEPpfjt8r5JMSm7/
	rrBsmwxvkzzINw811e8LUtyX5lhYT6G3nAt4OhKMsic2vdmtDGS5y6WsFpajqRUMR7U/2vz7h7t
	xMBZaFxk1mfCJWFbfFwhdHuXJe6Xomqmd9J+a3lBZr7UqgdnDY5B0j5Xtzluxy+/ciZ6ugH6yqX
	x13EKYGjhqHMvqMKIT1/cyHWU1lLvgkzczflb79MPLRws6z75k71J/YylrzUrmP+UhGplVtQ31w
	SqeQktxtqYIYH/F/ys1elSksLvix0MvbEx65p/KZNScB8rBeV/iTTpvcu5GfgT/FtvkBW14LiMh
	coHGqx0lOSDpsjLwvFM7QQWPh7g0SDDLoKg3MyC0t+UzqkHGg==
X-Received: by 2002:a05:6214:2dc4:b0:8f1:4bff:24dd with SMTP id 6a1803df08f44-90816fe5139mr44135256d6.5.1785268041215;
        Tue, 28 Jul 2026 12:47:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd6b539sm6700176d6.41.2026.07.28.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:47:20 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com
Subject: [PATCH 0/4] mm: reject zone device folios in more folio walkers
Date: Tue, 28 Jul 2026 15:47:10 -0400
Message-ID: <20260728194714.3713735-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several LRU-oriented mm walkers resolve the folio backing a PMD/hugetlb
entry (or a physical pfn) and then reclaim, age, migrate, or lazyfree it
without ever checking for ZONE_DEVICE memory.

This series adds missing folio_is_zone_device() rejections, matching
the checks that comparable walkers already perform.

The changes fall into two groups:

1) Genuine gaps:

 - mm/huge_memory, mm/madvise: the !pmd_present branch above these sites
   only filters device-private entries (which are non-present).

   A present zone device PMD (e.g. device-coherent) would still reach the
   folio and be lazyfreed / aged / paged out. Add an explicit check.

 - mm/mempolicy: queue_folios_pmd() can see a present zone device PMD
   (e.g. device-coherent) and queue it for migration.


2) Defensive / consistency:

 - mm/damon: damon_get_folio() already excludes zone device memory
   implicitly (pfn_to_online_page(), lru checks).  The explicit check
   is added in the single damon_get_folio() chokepoint so every DAMON
   caller is covered uniformly and the guarantee is stated explicitly.

 - mm/mempolicy: queue_folios_hugetlb() cannot see zone device memory
   (hugetlb folios are never ZONE_DEVICE).  We add the check to keep
   all three mempolicy walkers consistent.

No crash reproducer - this is a correctness/hardening cleanup found by
inspection. All checks are placed after the folio is resolved and before
it is acted upon, on paths that already hold the relevant page-table lock,
so no locking or refcount changes are involved.

Gregory Price (4):
  mm/damon: defensively skip zone device folios in damon_get_folio()
  mm/huge_memory: skip zone device folios in madvise_free_huge_pmd()
  mm/madvise: skip zone device folios in cold/pageout PMD range
  mm/mempolicy: skip zone device folios when queueing folios

 mm/damon/ops-common.c | 3 ++-
 mm/huge_memory.c      | 4 ++++
 mm/madvise.c          | 3 +++
 mm/mempolicy.c        | 4 ++++
 4 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.55.0

