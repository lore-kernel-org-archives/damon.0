Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381826CE25
	for <damon@lists.linux.dev>; Thu, 25 Sep 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793999; cv=none; b=isb1nzH8TuGo7o2zTbQ2EBOYTwO50iBJwo8yzSTuTFowAHAHViEq/FcZK84TgsIjTD1eJLBzAphnCOXQdw+rvSIdjDY7PBmhfORodt9awRglPQglacu3kolbA7cbIm/jzMqHbYtLN2bz239c18Fg4JHxxZKQj1KhMgBSoKZTntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793999; c=relaxed/simple;
	bh=2UZNMKHGpeYxjhLNIO9PhtmEAC2fZU89xTZT5YErSLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smrf5elOfC8ysgZMJu1XcqVrz8oSsYhM43bWPxx7MuJIyga0FpF04lbL1hjesl20NWhoZWxGk45l9K+J4BQsi5wdMo3ZY7T6RQtuNhK3lokq3lG2Nr/tVJKLXmHk6g3FwM/gd6aXHKQjd4d+wUqEd/qu7v+Cx7+Gz6ZoPfyk2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikBzFBPY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikBzFBPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758793994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5IZ5ZyHPjVPn/a1sUZGku96Q30DI6b1ntIDJki2HPWc=;
	b=ikBzFBPYlTlvZos5314dyIqwZp2RTw07UCtM7IrxOeQK0OhUI+frUcMKXkpB8gVkUaWuCY
	p3G6HKZnPld+Uv/KyD8xp6PXL3GblyrbrRjCILiVAJXKbSU85turZzl//XAK7sC7bCu642
	vEK546Lmv61i8dROPxAh9wlKTh8N/rw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-D7gGbvDON_S5ipRIdfc8nQ-1; Thu, 25 Sep 2025 05:53:13 -0400
X-MC-Unique: D7gGbvDON_S5ipRIdfc8nQ-1
X-Mimecast-MFC-AGG-ID: D7gGbvDON_S5ipRIdfc8nQ_1758793992
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46dee484548so4388985e9.2
        for <damon@lists.linux.dev>; Thu, 25 Sep 2025 02:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793992; x=1759398792;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IZ5ZyHPjVPn/a1sUZGku96Q30DI6b1ntIDJki2HPWc=;
        b=Owi/EKiLR1KxuTY/kkOPCjV3tY0oadHbF+VsoaQzVGVXiRjz6m5AXCP8wCjCpWw6Ic
         7xJr/gpYvEyqcs9CQZaF1uH9G3yc+TxI2xgXvlXdrW7bgVL/zmPQA9FHu47oC8hyBZ/G
         WWVvf5vZmtpdJ3s2XFh7c50pL9PZgVVeac+CdI058L8gs0rT0SUuejsj0TBycgSOck/N
         5unb0iZEYxvK4zFteIG+jnvkSkLqMxQx2tR6yCXAB7hhKRdsTA1lZz0hTkgPgZ39j8lz
         A6d76GoyUMnX5zBQgpwviFdcnS93cISGUdPSZPrCcOtM8ixwzXmYt3PlGgmyhr+ewCdO
         7Fmw==
X-Forwarded-Encrypted: i=1; AJvYcCWWtn65TvuQGVLbgpSpXQp9Qt3MrkcCTtvy565FhoVlqcnK6w9GGNPPkTscF1dgveEBoqwx6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyfkpf3yJrEB9yUzNCmLuBO7MhIBb4M2N/Bcga+BZQfxNAyx/BP
	8iPe+Ykicrzg/BSijeXQqPiVG+Cnxw3cf2kul5+rs7tmzWfiaJiazHZjeKooBpIMb54JsAR2Bk4
	YvN6It4LxzNfxTLkWlA2oWfaCAjLWGmtJezpnsoMd+CnYHSuRlHJLEbcx
X-Gm-Gg: ASbGncthhfIEWC8fg9NJrRqs8KywextNYDfNlvasi/Q/uDkvU0dbE77YNcX4FNejSPj
	KUPgxLrsctArrVVforPAc/+q9ciab/u+Abn3Zq85esxCfjpKYnEB6C/MJZ/P7rttVl3f1U/LiMh
	m25Y4P+X/QOOYbzn+NuJ4COi9d2i3S2lsEdUbrutf35qhhEMWBmgzEdh5iwONwRnSsWRFUPYLoW
	ge93TLV0qR8akwIUvGK8xJzDcfcAUFRdohEkoJMb3xQohe2KzzIt1BUYGAC2mMhWHXEJC06Xptc
	rdtYHSNO9smhLwJErxH0IIZheBAoFbcl/UlG5txpTFpVvFiBkCjxwk64FthPz6aB3oWWdHx2Fzi
	wwuwFN/t4S2Z3Qo+yQgrJWgcFL27+ZPjSdZk7r7k9Qd2zqh9Dqh1KbqHCreIWXCsXIevU
X-Received: by 2002:a05:600c:8b71:b0:46e:2d0d:804c with SMTP id 5b1f17b1804b1-46e329ae509mr28235965e9.11.1758793991630;
        Thu, 25 Sep 2025 02:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQdx4XV7EntPUilqRyAJNwUvFZd26RTmvdykMXr/gjLo1hfbQKEF9ym8IJ49CBAyUk65IGGg==
X-Received: by 2002:a05:600c:8b71:b0:46e:2d0d:804c with SMTP id 5b1f17b1804b1-46e329ae509mr28235655e9.11.1758793991123;
        Thu, 25 Sep 2025 02:53:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996d7dsm72815125e9.4.2025.09.25.02.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:53:10 -0700 (PDT)
Message-ID: <df1e62e6-57ac-4a5f-bf62-71fea47481af@redhat.com>
Date: Thu, 25 Sep 2025 11:53:08 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 02/15] mm/huge_memory: add device-private THP support to PMD
 operations
To: Alistair Popple <apopple@nvidia.com>, Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-3-balbirs@nvidia.com>
 <azcaqmqwdslvoei7ma4obtpxcdv7jdqfdc3ny4sylgwelwhfvo@okwd6y2oq5q4>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <azcaqmqwdslvoei7ma4obtpxcdv7jdqfdc3ny4sylgwelwhfvo@okwd6y2oq5q4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I4EHVcCOGffrYAJ5D_WsPxaLxrStS7c2iGfEWPmMKGc_1758793992
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.09.25 02:25, Alistair Popple wrote:
> On 2025-09-16 at 22:21 +1000, Balbir Singh <balbirs@nvidia.com> wrote...
>> Extend core huge page management functions to handle device-private THP
>> entries.  This enables proper handling of large device-private folios in
>> fundamental MM operations.
>>
>> The following functions have been updated:
>>
>> - copy_huge_pmd(): Handle device-private entries during fork/clone
>> - zap_huge_pmd(): Properly free device-private THP during munmap
>> - change_huge_pmd(): Support protection changes on device-private THP
>> - __pte_offset_map(): Add device-private entry awareness
>>
>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>> Cc: Rakie Kim <rakie.kim@sk.com>
>> Cc: Byungchul Park <byungchul@sk.com>
>> Cc: Gregory Price <gourry@gourry.net>
>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Mika Penttilä <mpenttil@redhat.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Francois Dugast <francois.dugast@intel.com>
>> ---
>>   include/linux/swapops.h | 32 +++++++++++++++++++++++
>>   mm/huge_memory.c        | 56 ++++++++++++++++++++++++++++++++++-------
>>   mm/pgtable-generic.c    |  2 +-
>>   3 files changed, 80 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>> index 64ea151a7ae3..2687928a8146 100644
>> --- a/include/linux/swapops.h
>> +++ b/include/linux/swapops.h
>> @@ -594,10 +594,42 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>>   }
>>   #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>>   
>> +#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
>> +
>> +/**
>> + * is_pmd_device_private_entry() - Check if PMD contains a device private swap entry
>> + * @pmd: The PMD to check
>> + *
>> + * Returns true if the PMD contains a swap entry that represents a device private
>> + * page mapping. This is used for zone device private pages that have been
>> + * swapped out but still need special handling during various memory management
>> + * operations.
>> + *
>> + * Return: 1 if PMD contains device private entry, 0 otherwise
>> + */
>> +static inline int is_pmd_device_private_entry(pmd_t pmd)
>> +{
>> +	return is_swap_pmd(pmd) && is_device_private_entry(pmd_to_swp_entry(pmd));
>> +}
>> +
>> +#else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
>> +
>> +static inline int is_pmd_device_private_entry(pmd_t pmd)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
>> +
>>   static inline int non_swap_entry(swp_entry_t entry)
>>   {
>>   	return swp_type(entry) >= MAX_SWAPFILES;
>>   }
>>   
>> +static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
> 
> I can't think of a better name either although I am curious why open-coding it
> was so nasty given we don't have the equivalent for pte entries. Will go read
> the previous discussion.

I think for PTEs we just handle all cases (markers, hwpoison etc) 
properly, manye not being supported yet on the PMD level. See 
copy_nonpresent_pte() as an example.

We don't even have helpers like is_pte_migration_entry().

>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 567e2d084071..0c847cdf4fd3 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -290,7 +290,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>>   
>>   	if (pmdvalp)
>>   		*pmdvalp = pmdval;
>> -	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
>> +	if (unlikely(pmd_none(pmdval) || !pmd_present(pmdval)))
> 
> Why isn't is_pmd_non_present_folio_entry() used here?


I thought I argued that

	if (!pmd_present(pmdval)))

Should be sufficient here in my last review?

We want to detect page tables we can map after all.
-- 
Cheers

David / dhildenb

