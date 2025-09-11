Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113C1A2387
	for <damon@lists.linux.dev>; Thu, 11 Sep 2025 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592273; cv=none; b=OVjrZ9ZPxgg0Hzt+0vhMb/6eGs9gQmuOmk6qEjulTn6kLyBrzl4Raha1a2RIBUzbhJzm5g5ncsR2G4fvyL6SPDFgpo1kuNXGZX2qv8GSu9DW3drpcTkurYI7hHSNB7jrF7Q7VNQDnrpi/3vufpZwcDrdCideAAiu77ymCHlRhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592273; c=relaxed/simple;
	bh=Wt0bC5mvDF/uHEWIdzjdJu0LeGAa2X3RPBVPJei0lk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuLSROuwCoddnt1Myw3a1/NJnkuCj0gIZUrpQQQVZU3PH4FVCGP5+iwyfjPdfgHebK4ti6Gz07F0EvCGg0el8HzR0aFVvFNbapVWAyDPw/joHU8YTew1P1v2E0Xfcg035NCDYXphjDe8DKQgHWJdYBTn7rm8sOcVrceJiFrPGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEICEPI+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEICEPI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757592270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EuZPErlVPfP4Zi7OehwAoScM8rfscgPVz8IjeFSlZfc=;
	b=BEICEPI+XKEA1tgJ61XnCtifDdNA0RJaEhVHg29X8Jyr5qs1Wv+sDcCzgWLKCp9JhVzO90
	6Uz977rR0LxC9CTD5IjrmA+4B1llAZnpQIn5Zv5ueAoNUru6FC0UW6DFTBMaYRNDOGc4Ld
	t2IB/ET8P35zeVNZ1a8Q+rqgEgNNLdA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-E-fzqaw2MOG2Uqe3f_CzDA-1; Thu, 11 Sep 2025 08:04:29 -0400
X-MC-Unique: E-fzqaw2MOG2Uqe3f_CzDA-1
X-Mimecast-MFC-AGG-ID: E-fzqaw2MOG2Uqe3f_CzDA_1757592268
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so3783655e9.0
        for <damon@lists.linux.dev>; Thu, 11 Sep 2025 05:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757592268; x=1758197068;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuZPErlVPfP4Zi7OehwAoScM8rfscgPVz8IjeFSlZfc=;
        b=fk4fMPYJ9lII/YWbhHorAUU0+K3SaRUV7kqmNUfQTCRAr+C99W31LDug5DdluxGTrg
         9i3UR9O3IaIheWXqDS3tE5njqEd6T6WmBUUS50WYhX1FK5wqu05WiJyy4/pRg4vA7R5i
         57FCJ6kqZRWyxcICA4gBc8BWJw1/rW7/RwLdV8+wdrlQzC5TGQlvCcm7vffFBv9pgKdI
         OdXXbvSDTTquBUvXKf1d/yWeOsPOCJOh4gLZLJXbvcFMKdbdqfNPx53O3LtzMIQFnVfa
         bA00hwkAhJc0+0ZMYJfqQ6Rj2de9hGCZb7ihvw2AMhc5a/KC/O6+p2AifSWkmNwtxHKe
         l7kg==
X-Gm-Message-State: AOJu0YzSCIv8AAxGL8fiMzt2VSShC5tAluYOssnvtS5Jr5L2HkRbAqEx
	J+igFNFRAxzkwNlmlKmLnZLUqFEwC9jPxq77oZlX/7LXF+wf59zkljGqKlINc4bbuTwkIm9M8lL
	u1UAEzil8YQq0ADUu68dKt+It23yZrQr2ZsqFcblABCULlFaIMjgKCob1
X-Gm-Gg: ASbGnctuSoOY1UWAcLvupZ5iURtNLiMpEQhr1t6JoGbgNhoZq7n0asbSNAMPZXFcqfx
	CObyrLkVqpSj843nKVBLuGwf7i9X6tZh4+0eaPNRiZdxdJ5l5koFQ0ebXeDfBEmw/JgzLQrA3GG
	7ToGTcylOHq936Pzj7LoRmOE5CKR/oqmBHF9NgscSO0Mv+d3jwo24kqRPb9d6KXbPmY9b9CKHXI
	7rHjMYn+02Ylq4IofsE8dkoyufCbKFrziAKfc8hhuZAAupklF57xKq1SfQUUYHFo5eH0LbT0LRG
	hqI8yd/lcfzJz8/+fwPKWSkD4baqD2sa+JyyoymAvvSzReXuGYznbA8/KC/VyjIpw6K9nyKV75Z
	dA4UiPGAMpCTf+ymAD3XTCAF/ZVI0Jq+PCZaj/zok5xAbX2XkzQBzfc1CkIwNm/NuPqc=
X-Received: by 2002:a05:600c:17d8:b0:45e:598:90b0 with SMTP id 5b1f17b1804b1-45e05989245mr12298595e9.9.1757592268216;
        Thu, 11 Sep 2025 05:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8gojWv48o7hPnSlLmGoQLH2lzL/OCbhuDjeyev+XCC7h++EYG0R0k7MthrD+iGwxnZwbgRA==
X-Received: by 2002:a05:600c:17d8:b0:45e:598:90b0 with SMTP id 5b1f17b1804b1-45e05989245mr12298135e9.9.1757592267679;
        Thu, 11 Sep 2025 05:04:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0187f0a7sm13295915e9.3.2025.09.11.05.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 05:04:27 -0700 (PDT)
Message-ID: <6f1857b8-45db-4017-b6e8-02ecfa2104a3@redhat.com>
Date: Thu, 11 Sep 2025 14:04:24 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 03/15] mm/rmap: extend rmap and migration support
 device-private entries
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
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
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-4-balbirs@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908000448.180088-4-balbirs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3OSR8XnP9xAUNJQv_2mjpQ8pFKTT6h1nwyscv-oqf_o_1757592268
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.09.25 02:04, Balbir Singh wrote:

subject:

"mm/rmap: rmap and migration support for device-private PMD entries"


> Add device-private THP support to reverse mapping infrastructure,
> enabling proper handling during migration and walk operations.
> 
> The key changes are:
> - add_migration_pmd()/remove_migration_pmd(): Handle device-private
>    entries during folio migration and splitting
> - page_vma_mapped_walk(): Recognize device-private THP entries during
>    VMA traversal operations
> 
> This change supports folio splitting and migration operations on
> device-private entries.
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

[...]


> +++ b/mm/page_vma_mapped.c
> @@ -250,12 +250,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>   			pmde = *pvmw->pmd;
>   			if (!pmd_present(pmde)) {
> -				swp_entry_t entry;
> +				swp_entry_t entry = pmd_to_swp_entry(pmde);
>   
>   				if (!thp_migration_supported() ||
>   				    !(pvmw->flags & PVMW_MIGRATION))
>   					return not_found(pvmw);
> -				entry = pmd_to_swp_entry(pmde);
>   				if (!is_migration_entry(entry) ||
>   				    !check_pmd(swp_offset_pfn(entry), pvmw))
>   					return not_found(pvmw);

Why this change? Looks unrelated.

> @@ -277,6 +276,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   			 * cannot return prematurely, while zap_huge_pmd() has
>   			 * cleared *pmd but not decremented compound_mapcount().

Reminder to self: cleanup compound_mapcount() leftovers

>   			 */
> +			swp_entry_t entry;
> +
> +			entry = pmd_to_swp_entry(pmde);

swp_entry_t entry = pmd_to_swp_entry(pmde);

> +
> +			if (is_device_private_entry(entry)) {
> +				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> +				return true;
> +			}
> +
>   			if ((pvmw->flags & PVMW_SYNC) &&
>   			    thp_vma_suitable_order(vma, pvmw->address,
>   						   PMD_ORDER) &&
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 236ceff5b276..6de1baf7a4f1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1063,8 +1063,10 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
>   		} else {
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   			pmd_t *pmd = pvmw->pmd;
> -			pmd_t entry;
> +			pmd_t entry = pmdp_get(pmd);
>   
> +			if (!pmd_present(entry))
> +				continue;
>   			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
>   				continue;
>   

If you just did a pmdp_get() you should use it in these functions as 
well. If not (cleanup later), do a straight *pmd like the others.



Apart from that nothing jumped at me.

-- 
Cheers

David / dhildenb

