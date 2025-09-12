Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A844207A
	for <damon@lists.linux.dev>; Fri, 12 Sep 2025 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655524; cv=none; b=gGWYqCE9Z5i1J27XhzPU7LnB48ULMkeFPDyslSXCD6aXzVhV5cnvgZBdMmhahJR/WjxMurwCeJeIRsMILubA3M6h5gAXNW1lMFtS3cpELgBQJWiX+L87yRjLOzJDGCa43M2OtjAgi6VtTIQVlp932fRnTZDlAueZlm6A8L7GCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655524; c=relaxed/simple;
	bh=vCvPfv84bnne7DwNnPKxiZjFOR9mFsWn3OXhKxx1V8Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=axo4QjbVuAuatMV13QYID6iSE1q+iHRvsJ3hrDevfBSUnM4aB6MmuXPElZBoX2ZDOkrkzSrpVENfJdPo4vkiEyuXPFZC66ewvUPGwnvquDEwH/58Pn2X3TfGpXqZ3CrujVUrgnt84joUsQhEljCRX5TFHgI0RAzvOG4RNxOLSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/zlw6hl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/zlw6hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757655521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/fMTw17wcHtqFRGn0LVfXt45GBXrdFjvwip8q4HpKI=;
	b=E/zlw6hlB2dP8QeBk2QRA35rP3j1wAOYNCd+1OHzaL231p+kkRi8PpxMSHCqi9fJ7W3Ix9
	txGFKFP+28knnoZ6gR6W3b0gsrVih7uA3i3BVANSp4Y86vMuZqSKqepz/xg2vFzEPbNd17
	OMyZDXB43AyvtSOQZVBTh+UztFwbOk8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-ZaXMBQvmNRCLXzSk_brOVw-1; Fri, 12 Sep 2025 01:38:40 -0400
X-MC-Unique: ZaXMBQvmNRCLXzSk_brOVw-1
X-Mimecast-MFC-AGG-ID: ZaXMBQvmNRCLXzSk_brOVw_1757655519
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-56089d79c97so1034589e87.1
        for <damon@lists.linux.dev>; Thu, 11 Sep 2025 22:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757655518; x=1758260318;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/fMTw17wcHtqFRGn0LVfXt45GBXrdFjvwip8q4HpKI=;
        b=HkdNWj0jTQGlNslB/LGN3vShI/2QLxepPma5Ci4L3K2cNCkxgJQdb1nFfBivadA2Sc
         M+sRwXrhlyS3D/IOUfRyJbGegdmeXYSsRvLOz5QqUO5jHbupiuWF+LTU00ew3CsaC19w
         IYvM16vafGGRbg+muEaYPQ2DaH+OWXcQF1ncbx1K4nCpfoNQOBIoIDrWDXafuAn/giFN
         8C+Mtbe6dLCCIaWz1XGnDfaLQdNIX9WYpxUJC5FrlOC+Tqze9E4pqhCvWCBGmYYmBNVC
         SUyAEkk77dL6JgTJZhQROX0qdXFALQRldGPkvEPF0jaWfC2zZWH+myEWmdDX8oG+wrqK
         iZYA==
X-Gm-Message-State: AOJu0Ywgc7YuaU1j/LuqNKAL/cCnTG9HyXYCfdmjUx6JaXeH0+SPqb1y
	aKkJrkWizB0ZOApN0BoRlWqNC7JS6bKGaSJg+krTbn7tVf19nUMaumpgvCXcZQlTLMa8rDD6ANI
	WgIbmt9smk55hoo4kUCD/tEMvwEIV2vVe5q6gbVx6elcvrbhj7T5Cimc=
X-Gm-Gg: ASbGncuVX3nwVLLMNEoHhmEHhBgZVkLmWwMSr04eaJol5mLvK9aFsUNqGx3taRWQXIZ
	mExeUG+EjsSaxcMeSLYr02xdDeGvUldrhMt9UZ6DQwM6n6qMeOpnDisZdVzHMH1SXqbUz8F1WAY
	efSlhc5/bNub8J8d17M52gO/cN1weT4n0fbXydmpaC4ZYXWMFAMGEc5MUdzGxOPmeSG+OCeqDCX
	GSigwq92TPNNm4cYyI+q/9QEbhZgSxhPuySjLIVQjwfMYxxNqVoZW7tjpsfRV5BNVAhHTRmEjwT
	O/jebko7UziOfOOdw5ySJletk9OwY8o06rzT+cQ8fTc/bGWvPjZuXoSCHNQqX/PFpcSpvqTxg7n
	q1hsagaicLg7CDRpOpt1BDyJwLrDLPVxyz0s3GQTcgvoInhPZyYLr
X-Received: by 2002:ac2:51d4:0:b0:571:75c8:43a5 with SMTP id 2adb3069b0e04-57175c845b8mr65108e87.1.1757655518531;
        Thu, 11 Sep 2025 22:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe3otVU1/RsO3+BWrCGouA69nfgwLCHLM+77KekXiYcNhrEbv3mMPoDIbeIVC1KQsturvUHg==
X-Received: by 2002:ac2:51d4:0:b0:571:75c8:43a5 with SMTP id 2adb3069b0e04-57175c845b8mr65076e87.1.1757655518018;
        Thu, 11 Sep 2025 22:38:38 -0700 (PDT)
Received: from ?IPV6:2001:999:408:6576:1142:7350:b6c5:671e? (n4ctkw60s7hbahed3xa-1.v6.elisa-mobile.fi. [2001:999:408:6576:1142:7350:b6c5:671e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63cc6sm914214e87.66.2025.09.11.22.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 22:38:37 -0700 (PDT)
Message-ID: <06a0e258-2c68-43ee-ab53-313a13ed0d68@redhat.com>
Date: Fri, 12 Sep 2025 08:38:35 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 06/15] mm/migrate_device: implement THP migration of zone
 device pages
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
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
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-7-balbirs@nvidia.com>
 <d35eea42-ed32-481f-9dcf-704d22eb8706@redhat.com>
 <49039b9d-4c42-480f-a219-daf0958be28e@nvidia.com>
 <4cc2ba18-e7de-448f-aaee-043ed68dc6e3@redhat.com>
In-Reply-To: <4cc2ba18-e7de-448f-aaee-043ed68dc6e3@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uMrmJ9TpNFloCRgrWk8j1FKjMHpqZyUtC-bIPKpNi4o_1757655519
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/12/25 08:28, Mika Penttilä wrote:

> On 9/12/25 08:04, Balbir Singh wrote:
>
>> On 9/11/25 21:52, Mika Penttilä wrote:
>>> sending again for the v5 thread..
>>>
>>> On 9/8/25 03:04, Balbir Singh wrote:
>>>
>>>> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
>>>> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
>>>> device pages as compound pages during device pfn migration.
>>>>
>>>> migrate_device code paths go through the collect, setup
>>>> and finalize phases of migration.
>>>>
>>>> The entries in src and dst arrays passed to these functions still
>>>> remain at a PAGE_SIZE granularity. When a compound page is passed,
>>>> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
>>>> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
>>>> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
>>>> representation allows for the compound page to be split into smaller
>>>> page sizes.
>>>>
>>>> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
>>>> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
>>>> and migrate_vma_insert_huge_pmd_page() have been added.
>>>>
>>>> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
>>>> some reason this fails, there is fallback support to split the folio
>>>> and migrate it.
>>>>
>>>> migrate_vma_insert_huge_pmd_page() closely follows the logic of
>>>> migrate_vma_insert_page()
>>>>
>>>> Support for splitting pages as needed for migration will follow in
>>>> later patches in this series.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>>> Cc: Byungchul Park <byungchul@sk.com>
>>>> Cc: Gregory Price <gourry@gourry.net>
>>>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>>> Cc: Nico Pache <npache@redhat.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Dev Jain <dev.jain@arm.com>
>>>> Cc: Barry Song <baohua@kernel.org>
>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>> Cc: David Airlie <airlied@gmail.com>
>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>
>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>> ---
>>>>  include/linux/migrate.h |   2 +
>>>>  mm/migrate_device.c     | 456 ++++++++++++++++++++++++++++++++++------
>>>>  2 files changed, 395 insertions(+), 63 deletions(-)
>>>>
>>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>>> index 1f0ac122c3bf..41b4cc05a450 100644
>>>> --- a/include/linux/migrate.h
>>>> +++ b/include/linux/migrate.h
>>>> @@ -125,6 +125,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>>>>  #define MIGRATE_PFN_VALID	(1UL << 0)
>>>>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>>>>  #define MIGRATE_PFN_WRITE	(1UL << 3)
>>>> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>>>>  #define MIGRATE_PFN_SHIFT	6
>>>>  
>>>>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
>>>> @@ -143,6 +144,7 @@ enum migrate_vma_direction {
>>>>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>>>>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>>>>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
>>>> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,
>>>>  };
>>>>  
>>>>  struct migrate_vma {
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index f45ef182287d..1dfcf4799ea5 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -14,6 +14,7 @@
>>>>  #include <linux/pagewalk.h>
>>>>  #include <linux/rmap.h>
>>>>  #include <linux/swapops.h>
>>>> +#include <linux/pgalloc.h>
>>>>  #include <asm/tlbflush.h>
>>>>  #include "internal.h"
>>>>  
>>>> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>>>>  	if (!vma_is_anonymous(walk->vma))
>>>>  		return migrate_vma_collect_skip(start, end, walk);
>>>>  
>>>> +	if (thp_migration_supported() &&
>>>> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
>>>> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
>>>> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
>>>> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
>>>> +						MIGRATE_PFN_COMPOUND;
>>>> +		migrate->dst[migrate->npages] = 0;
>>>> +		migrate->npages++;
>>>> +		migrate->cpages++;
>>>> +
>>>> +		/*
>>>> +		 * Collect the remaining entries as holes, in case we
>>>> +		 * need to split later
>>>> +		 */
>>>> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
>>>> +	}
>>>> +
>>> seems you have to split_huge_pmd() for the huge zero page here in case
>>> of !thp_migration_supported() afaics
>>>
>> Not really, if pfn is 0, we do a vm_insert_page (please see if (!page) line 1107) and
>> folio  handling in migrate_vma_finalize line 1284
> Ok actually seems it is handled by migrate_vma_insert_page() which does
>
>         if (!pmd_none(*pmdp)) {
>                 if (pmd_trans_huge(*pmdp)) {
>                         if (!is_huge_zero_pmd(*pmdp))
>                                 goto abort;
>                         folio_get(pmd_folio(*pmdp));
>                         split_huge_pmd(vma, pmdp, addr);   <----- here
>                 } else if (pmd_leaf(*pmdp))
>                         goto abort;
>         }
>
While at it, think the folio_get(pmd_folio(*pmdp)); is wrong for here,
we split the pmd for huge zero page.

>> Thanks,
>> Balbir
>>
> --Mika
>

