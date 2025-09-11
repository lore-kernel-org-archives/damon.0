Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A3311594
	for <damon@lists.linux.dev>; Thu, 11 Sep 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589109; cv=none; b=RiHC0HSXiyAbrH7gl4C74yaCQXWilmYR5kFJTVBCiabsKeRVAtY+XobBQ3URRXQWbX0MTsLmOPZkrcyPVHu5TiP2sdB6mbO1vVvM9+2r5NFIbXM0l+tu2Lk1jV1Y4WtGO71Pur1UZfZZxoKUZB6g2GKrsVCltoX8cNibs4Z8uz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589109; c=relaxed/simple;
	bh=ZUH+tMoTUJYwd65jUEfLy0Lppo/4pU83bUnbcy+fV1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY00tHoOE+vEOHF5MBJ1t+OMK8VOSKQi87zz7fVL62rCIUHG6a4bx6Zwn5TuFW8teeQVJV84spI/wIRNIeyPayopras5fnxdrfz+ovrMMECRxCLqmm1I3K8KoC+JCcdkro97HhWQBchxd09Zfk1EUaKNg5do34p7n6PGLfzIrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9eEUmXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9eEUmXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757589105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnoZL9IlsM4I8snaZrLtF+NT0iFbOyLl7iwd0dyctVo=;
	b=O9eEUmXWoqQ41fyUaO5ts3c2SZEu5wwGB6m+JyGIWOoWTYWP4r7nelGdk/7yM/SVJoN6JH
	hyJiPRyP9Ljl9zb7z+E9ktZ2iqlgBLhoXU11sR6yQhJiJ5RnTXtSausPZlAauXz3QaJlAu
	OGcS8CYUGfWLvIegC39SXr+Zw6FXdtc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-qe69BrxCMreha_i-h3yJHg-1; Thu, 11 Sep 2025 07:11:44 -0400
X-MC-Unique: qe69BrxCMreha_i-h3yJHg-1
X-Mimecast-MFC-AGG-ID: qe69BrxCMreha_i-h3yJHg_1757589103
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-56c497dcf0aso472129e87.2
        for <damon@lists.linux.dev>; Thu, 11 Sep 2025 04:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589103; x=1758193903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnoZL9IlsM4I8snaZrLtF+NT0iFbOyLl7iwd0dyctVo=;
        b=ZHDEYFG8do77lm4dbL433eBaNL2m4W7q0JHZpZyuj+4k+hJf14mSj7kwT6mvjCIvCN
         88T9YzrU5nMdfzV0SHlGWeiL6yaNm2Ki7Q20HNg4Em2Bujrri52MsERKO2Br/I59Llg3
         W2BKmDMKZSUQf590HoDPelbg3ikN+sdbjnVwm9XeOVuxFeX9e9OIJWqZwqaP1/VqClKj
         bO7jrCj29MS7c/zaHinlQZXMfSJtX8tNzt1mghNS2f1riPJk0JLF3DZzTQxnf7uZ2o1P
         QJj0N6pMz4Xe1K19SJf2tv3eGR57Kcm0N3xoakaCpDF/rwOTUbaFjSpIUt9OEt93ZmjM
         87TQ==
X-Gm-Message-State: AOJu0Yx8KsmRMdeivw9w/blU1DPTkSDJ6tJb5VOMB//vrdBw8p+ugOnR
	NFP8+ZBtLWT6Ny36Gjk2asNE61l/YgAdwCe+zM9VNmalH2dpmTnM/n/nVowN1tAVj2eM4plEgkP
	86UWluDbikLrXKW6sb76Q9TmH5DyW4rbEJO2YjQN05bBylh42TgJqEWU=
X-Gm-Gg: ASbGncsOWelJe3X10rqzAMDKPCO9RHLWtncJgtqkWHye5P5EPQ2uN5giZgN/15Zr23Q
	Z5nqV7YlLvuihOZGwzP5B312+mdEvW8tahrY6dupSTki/jz3BwmAkxfCYM8rZOfKIscTR8mTxMC
	PR+xUwhg/TZZV5VX9VMQ4NYZVvIGGs4nnasu8iW+C1xqLm7cQcsObWgu2YGFrSKo2kemDeg6ejx
	2yvHUIMq9s7RYgNia6qIJYqax1qzAo7wskXDN7aoPSW3pmXr8rrg6SaL9V9MPiiM6p9cFRBzE1R
	47WqGKdypxutZB9Lcu/BE3Dd6KoOrezIYRH6IqiSk+aKrudZeMwm1ldy5jCMosmWGCvqzx+/BFQ
	E8P9dDidwZPxrPWiFkwc3pq783rV6YzsqG66seL0hI2kb+1RKSA==
X-Received: by 2002:a05:6512:1593:b0:55f:3faa:7c2e with SMTP id 2adb3069b0e04-5625f535a77mr5703533e87.22.1757589102508;
        Thu, 11 Sep 2025 04:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHndKi4ZUjcu5xTRlvMfXjlXFcDZdujE+IlsZ0U4neE95H5mnTNxQ6YofItgf/sP/wsePXmQ==
X-Received: by 2002:a05:6512:1593:b0:55f:3faa:7c2e with SMTP id 2adb3069b0e04-5625f535a77mr5703497e87.22.1757589101977;
        Thu, 11 Sep 2025 04:11:41 -0700 (PDT)
Received: from ?IPV6:2001:999:704:9310:43e6:e14c:406:e339? (n7kwfhcd2z0e9u7cxfd-1.v6.elisa-mobile.fi. [2001:999:704:9310:43e6:e14c:406:e339])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6002sm364013e87.28.2025.09.11.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 04:11:41 -0700 (PDT)
Message-ID: <9047198d-7b35-435b-a933-ff7b1357919b@redhat.com>
Date: Thu, 11 Sep 2025 14:11:40 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 06/15] mm/migrate_device: implement THP migration of zone
 device pages
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250903011900.3657435-1-balbirs@nvidia.com>
 <20250903011900.3657435-7-balbirs@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250903011900.3657435-7-balbirs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TPsS9M06SonRJkLTaabi1Vmp7lKmP9WbXXd4ZvT2WSw_1757589103
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/3/25 04:18, Balbir Singh wrote:

> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
> device pages as compound pages during device pfn migration.
>
> migrate_device code paths go through the collect, setup
> and finalize phases of migration.
>
> The entries in src and dst arrays passed to these functions still
> remain at a PAGE_SIZE granularity. When a compound page is passed,
> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
> representation allows for the compound page to be split into smaller
> page sizes.
>
> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
> and migrate_vma_insert_huge_pmd_page() have been added.
>
> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
> some reason this fails, there is fallback support to split the folio
> and migrate it.
>
> migrate_vma_insert_huge_pmd_page() closely follows the logic of
> migrate_vma_insert_page()
>
> Support for splitting pages as needed for migration will follow in
> later patches in this series.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  include/linux/migrate.h |   2 +
>  mm/migrate_device.c     | 456 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 395 insertions(+), 63 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 9009e27b5f44..40e1c792eb54 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -134,6 +134,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>  #define MIGRATE_PFN_VALID	(1UL << 0)
>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>  #define MIGRATE_PFN_SHIFT	6
>  
>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> @@ -152,6 +153,7 @@ enum migrate_vma_direction {
>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>  };
>  
>  struct migrate_vma {
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index e58c3f9d01c8..aba0cd7856da 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swapops.h>
> +#include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
>  
> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	if (!vma_is_anonymous(walk->vma))
>  		return migrate_vma_collect_skip(start, end, walk);
>  
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> +						MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages] = 0;
> +		migrate->npages++;
> +		migrate->cpages++;
> +
> +		/*
> +		 * Collect the remaining entries as holes, in case we
> +		 * need to split later
> +		 */
> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +	}
> +

seems you have to split_huge_pmd() for the huge zero page here in case of !thp_migration_supported() afaics

>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
>  		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>  		migrate->dst[migrate->npages] = 0;
> @@ -102,57 +120,150 @@ static int migrate_vma_split_folio(struct folio *folio,
>  	return 0;
>  }

--Mika

