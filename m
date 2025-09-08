Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018021B19D
	for <damon@lists.linux.dev>; Mon,  8 Sep 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304851; cv=none; b=Hy5p+Cyiw4oZSsvS2BAxIu2Tg932MmexFJdszIVT03oEWoaUgg96oghECDs80/7+RptyxPvsBngbioWyE6TYoK1sFsZdcC4suc2zyICz08vMINRUbDnYr1dBJR5DqvEDew3c9LDIve+2tHjw5gahMmH6N6yUMubrq8eji7Sb14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304851; c=relaxed/simple;
	bh=pl18FtxmRQkEuk8/U2WKz5seSMT0xb0I2q75aWzNVjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bN+m3rhNCj7FaxT4M0D2pgjiSRe5K/TM0Hwxc/gTsFPUhxKp1mRmCXnFvb57Zq82PgD/INQ8CZLP8kYtHirJQBy1moDeRyR1tkELerZK8uIOVj/7nIdvCjZdLVYwtghKwr25ovv14V6KCvRxfnzoM8iTUlgUZtmN/uqgF90cS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMWSqTjs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMWSqTjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757304848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJsCe6eTTTGDK/V3oOGv4fFA8SBbBbHuaXgk/m4NaJ0=;
	b=HMWSqTjsiZM0MnGz6HyrdAWFmkzjc7WJpEbmRLkJZDvRtN+vSHWH6yTYE5wzIC5Ii92wTI
	d8Sz47QhE1M6Xv0VBfu+YN4EkiALuez8vRT4/HoC6OCakDxJW6hwuGh3FBwqqcMghNq3+9
	Tx8PipirggEZ5DKL171Oate6YvOnSds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-sqVxjJD8PbybWQ2WfrtgcA-1; Mon, 08 Sep 2025 00:14:07 -0400
X-MC-Unique: sqVxjJD8PbybWQ2WfrtgcA-1
X-Mimecast-MFC-AGG-ID: sqVxjJD8PbybWQ2WfrtgcA_1757304846
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45ddbfd44aaso15766745e9.2
        for <damon@lists.linux.dev>; Sun, 07 Sep 2025 21:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757304846; x=1757909646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJsCe6eTTTGDK/V3oOGv4fFA8SBbBbHuaXgk/m4NaJ0=;
        b=or/wU0riqg9zNlcCYfE3cVQUm42nC1MZfYyOYJ3IyykfwaP7lCKsRKGHtmkoi89RsB
         3HDSBKrS6GcfHPC+jidCp6Y6QAdEqh6ZMzpxTJhN3/VkoA+GzKw0nQpVEm/k4OyTih3M
         bAlbKEK5jBmgLUzAIigPyliYdSq50reIedQjIe0ZwjAzyRgWfFluPIkANi4T3uc8Zlae
         MVLDPSspEztIY+3RoXEqZBeYYu4G8PNJ1doZB80anW25y1X1LxDN4KhKn05n5lDauKsj
         zmaIQi3CdptF7Qwijxh47aRmnNwCWXViRjo58mtePxTQjZHMn9bCk0Y/KLduodLEvR3s
         uUwg==
X-Gm-Message-State: AOJu0YwIrqTyq7hUrRYSbVSL643b0NSHrKKa2kMt/hDp0xPKhaTUQ63p
	uNho/4p/b4cbY54qnhEQLvp3g2vRfPILfp7gs1jRkiLVwaobuGdeR+PGkgVkf9jc/zDNbbH2wvZ
	j298FAwvQP7HMiuKzkMlZClCyDK1VHYRGhUTWajybhK0cBUY6w3gGBcc=
X-Gm-Gg: ASbGncvhC0/RfGzFCkwQTJV1uyjeiz19F6dCnYraVhs9R7gBtsA62ytUN6uqKKsdG6J
	/fcJObeX8st4NPH3UvPjhTCcnhQRQgJq1vlPzJ7Vu/rdzeETCWEkdZtTTIJhrju1nKqWRl0/+4N
	slAOq/Fq+p2u9oGfbMQRZRMUEq1zACOs0qmenNFxZTr3y3wdq4gNVKAPFuRurTppJK0nLWJRXGF
	nvw8z70AWG+ZM1Y9Z9pZqCGA3mH7F/gAxfkmHSBobMBK+5mRAlUPWRNSbM2VGw8TxKSTraL0XTp
	dmVNklifEODXhzxxo2Zkt0OgbTexAK5KHurfB7UO4dLJUHGsBqHMQj7n7HfeDE1HMw==
X-Received: by 2002:a05:600c:458d:b0:45d:d50d:c0db with SMTP id 5b1f17b1804b1-45dddea5102mr52603665e9.15.1757304845802;
        Sun, 07 Sep 2025 21:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFutUyjnY3i7VNpdhUwrQ7pqW1CmodIEYjJPgtpuIcj6TCRCx7EUrnPJPxT8ek+IEd6gcbzjw==
X-Received: by 2002:a05:600c:458d:b0:45d:d50d:c0db with SMTP id 5b1f17b1804b1-45dddea5102mr52603475e9.15.1757304845375;
        Sun, 07 Sep 2025 21:14:05 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm142588705e9.1.2025.09.07.21.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 21:14:04 -0700 (PDT)
Message-ID: <e6b795de-f522-4952-9ec3-00a2359c43a9@redhat.com>
Date: Mon, 8 Sep 2025 07:14:02 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 05/15] mm/migrate_device: handle partially mapped folios
 during collection
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
 <20250908000448.180088-6-balbirs@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250908000448.180088-6-balbirs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EPEJcMam20HVdr0Dgz-Bfq38Cn3WFsGuaPQjcsKN02c_1757304846
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/8/25 03:04, Balbir Singh wrote:

> Extend migrate_vma_collect_pmd() to handle partially mapped large
> folios that require splitting before migration can proceed.
>
> During PTE walk in the collection phase, if a large folio is only
> partially mapped in the migration range, it must be split to ensure
> the folio is correctly migrated.
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
>  mm/migrate_device.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index abd9f6850db6..f45ef182287d 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -54,6 +54,53 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	return 0;
>  }
>  
> +/**
> + * migrate_vma_split_folio() - Helper function to split a THP folio
> + * @folio: the folio to split
> + * @fault_page: struct page associated with the fault if any
> + *
> + * Returns 0 on success
> + */
> +static int migrate_vma_split_folio(struct folio *folio,
> +				   struct page *fault_page)
> +{
> +	int ret;
> +	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
> +	struct folio *new_fault_folio = NULL;
> +
> +	if (folio != fault_folio) {
> +		folio_get(folio);
> +		folio_lock(folio);
> +	}
> +
> +	ret = split_folio(folio);
> +	if (ret) {
> +		if (folio != fault_folio) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +		return ret;
> +	}
> +
> +	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
> +
> +	/*
> +	 * Ensure the lock is held on the correct
> +	 * folio after the split
> +	 */
> +	if (!new_fault_folio) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	} else if (folio != new_fault_folio) {
> +		folio_get(new_fault_folio);
> +		folio_lock(new_fault_folio);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +
> +	return 0;
> +}
> +
>  static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  				   unsigned long start,
>  				   unsigned long end,
> @@ -136,6 +183,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			 * page table entry. Other special swap entries are not
>  			 * migratable, and we ignore regular swapped page.
>  			 */
> +			struct folio *folio;
> +
>  			entry = pte_to_swp_entry(pte);
>  			if (!is_device_private_entry(entry))
>  				goto next;
> @@ -147,6 +196,29 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			    pgmap->owner != migrate->pgmap_owner)
>  				goto next;
>  
> +			folio = page_folio(page);
> +			if (folio_test_large(folio)) {
> +				int ret;
> +
> +				/*
> +				 * The reason for finding pmd present with a
> +				 * large folio for the pte is partial unmaps.
> +				 * Split the folio now for the migration to be
> +				 * handled correctly
> +				 */
> +				pte_unmap_unlock(ptep, ptl);
> +				ret = migrate_vma_split_folio(folio,
> +							  migrate->fault_page);
> +
> +				if (ret) {
> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +					goto next;
> +				}
> +
> +				addr = start;
> +				goto again;
> +			}
> +
>  			mpfn = migrate_pfn(page_to_pfn(page)) |
>  					MIGRATE_PFN_MIGRATE;
>  			if (is_writable_device_private_entry(entry))
> @@ -171,6 +243,28 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  					pgmap->owner != migrate->pgmap_owner)
>  					goto next;
>  			}
> +			folio = page_folio(page);
> +			if (folio_test_large(folio)) {
> +				int ret;
> +
> +				/*
> +				 * The reason for finding pmd present with a
> +				 * large folio for the pte is partial unmaps.
> +				 * Split the folio now for the migration to be
> +				 * handled correctly
> +				 */

This comment is still not changed, there are other reasons for pte mapped large pages. 
Also now all the mTHPs are splitted, which is change of behavior (currently ignored)
for order < PMD_ORDER.

> +				pte_unmap_unlock(ptep, ptl);
> +				ret = migrate_vma_split_folio(folio,
> +							  migrate->fault_page);
> +
> +				if (ret) {
> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +					goto next;
> +				}
> +
> +				addr = start;
> +				goto again;
> +			}
>  			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>  		}

--Mika

