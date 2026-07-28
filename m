Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053804657CD
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268049; cv=none; b=qgONOIy12Pas0qL/CI6ahVEmN2rIRoeIntbeNd3tgubcqmpd93tQMPvf2UHUNNfmqXP5UMq6ueJ+ZsPGPNf3NGcJi2ObbMtTH0FXYnDXB1uKY7kPkneJlE+F8PC1txHlYRhHGoT0P2srGVs3ZwjPL2wU21Pu0N+Zwl+gPTSsQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268049; c=relaxed/simple;
	bh=IK8bhalTgcn89FsoJhNsDE34YEq3nhk+YmitLrNz4WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfgqCIUiMMATZ/uyogIGDu7bT2XtU5qRYcLvztLlV7YimENickUR6F28pnhTMKJu8yD0j+yel5W9jTVMzpWNyLmapYzp5rmPJboPiaRn8bFppDDD/ElaaujuFiIQYg6iIrhjhBtIrtmBEU1JlunLoyL1em9YzJZM1wgrmmUUobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tE9j+jwA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tE9j+jwA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e6a434cabso16671885a.1
        for <damon@lists.linux.dev>; Tue, 28 Jul 2026 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785268046; x=1785872846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jqMrLj14znUg+sEtuaSkWx5HGI/GWtvDstY3+0sa+Dw=;
        b=tE9j+jwAgYW3xMW4AIUlOcLHkEr/VuhLq0fYBeXCZV0uhJ48BGhIzjG1WQ5xn7doh+
         nY5GnqyuPU/FgEblaVIfimCU7i7HL2IKBGsyfN9xm/ry8glUAT+vrqke2or73DhxRekv
         NFVpVV9wqpIJ4AU6/NhzfSeyBdcH2PfTyK5Vd8JbA1AyFi4PooJ68Rz9K8Tf+jIfe5pe
         /DNAB6nCymp3x4Cl36V5QfTR55g04e5OlIkYtODzDGdtRh4HgfRfgEvE8qBa2dvQECio
         rXSLwitVD83gIqEbrAUqSD1+zjfg0WaB6xFLY+DFC5FUtyVRZgN0bUM+d7PnOocUNGLp
         aDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268046; x=1785872846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jqMrLj14znUg+sEtuaSkWx5HGI/GWtvDstY3+0sa+Dw=;
        b=eTJEukgfEOVKww6/ulWrN68QOA6vskFaLXTuewhRf1HLd7TN/MkLqAV0pjXOo57zuv
         iTOIc/UtYBzp7CI+zz4ZvA/y3NZSa6oLV2LBcTkodcxnYE+y88EWlgAs7eUzlWh5Q1V7
         VvBBwyoE2NfpfpctRnVoxeuPETWphl301rvNFoQne8SCZ0sSpqmMCBadDcW7yRZiZcce
         thqq2HV6fvVogACw/ftTT3xG0Kq0aJt4R72WMsGGUNoeT6ZC7oRgH7CZaY5gldLrK090
         oedgijgtp7hITghO4YkqGtzJ37afyaSWUDl34tQGpgi+3qFov0N3Iv3azWbB80L+clKG
         bGYg==
X-Gm-Message-State: AOJu0YxB6X/94qPqf6o8Yoi2DfhL6/R+10PtI68mfc0s8yCVhCIwbIHV
	1AzDFz2e9Jd1eYyFqRA7hrupRW77JmmZVyzpOfiDzfCqdUGgfTP18xxhuRTXtboM+es=
X-Gm-Gg: AR+sD10VzOmmy8+z3xgXGl7vpKbeWo6c+OI5Zk07BHo54aYOgQfyEROw/b0jKNwh0c+
	iEYQenl0J9yAS3ROfmmREQHdezmvdh6XCjySPmOgHzboQjnzOoYosHA0g67wim2GqNO/DX8CDFS
	k51Wb6i+hxA0UsnyDqYPbnHPBQKAK0tupnDfLYJkUghLQkMDFI5KZxU/HsN45DGpn7bAICUP7f9
	utdzZLi/iaPmvy6enjst2tvtj8DZPCeJz4xACj83E8p6q6OYlJF0N/Dp21YnlE/1LQ6IeLdj402
	ZnuWcGXCPPubdCkOcRIMkCjyddaGgox7gxewTbTHGd2HnG1Ijnu2f9mKDYp1JPzTZbU3P0vJa7s
	b46jivzALO0iD1B7JqTnE4hYuenOy3WwkYnO03PRzt828xcz9nFNWqMn19HC5UmHrVwT0aqdyqo
	YgI7St9btadg3r73I/fiA9U3JJLhFsWoKvNPQoZg8SM75QjpCSEGATEVXM2d/Z8iSHFN1GbA/K/
	MqRNMFgq2sYCmqOGbNMYsiigwpM/LB4wug9qQ3iCj5mM/wG5w==
X-Received: by 2002:a05:620a:40c2:b0:92e:caf1:7705 with SMTP id af79cd13be357-933027a9447mr385229585a.49.1785268045825;
        Tue, 28 Jul 2026 12:47:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd6b539sm6700176d6.41.2026.07.28.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:47:25 -0700 (PDT)
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
Subject: [PATCH 3/4] mm/madvise: skip zone device folios in cold/pageout PMD range
Date: Tue, 28 Jul 2026 15:47:13 -0400
Message-ID: <20260728194714.3713735-4-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728194714.3713735-1-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

madvise_cold_or_pageout_pte_range() resolves the folio backing a PMD
via pmd_folio() and ages or reclaims it without checking for zone
device memory.

The surrounding guards do not cover every zone device case:

  - can_madv_lru_vma() excludes VM_PFNMAP and VM_HUGETLB VMAs
    (so device DAX is filtered)

  - !pmd_present() branch above rejects device-private and
    migration entries, which are non-present.

  - A present zone device PMD - e.g. a device-coherent THP - is
    not filtered by any of these, nor by pmd_folio() (unlike
    vm_normal_page_pmd(), it performs no special/pfnmap check),
    and would be aged or paged out here.

Skip ZONE_DEVICE folios explicitly during MADV_COLD/PAGEOUT.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/madvise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 07a21ca31bad..ffd6a68320a8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -395,6 +395,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		folio = pmd_folio(orig_pmd);
 
+		if (folio_is_zone_device(folio))
+			goto huge_unlock;
+
 		/* Do not interfere with other mappings of this folio */
 		if (folio_maybe_mapped_shared(folio))
 			goto huge_unlock;
-- 
2.55.0

