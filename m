Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D218E743
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401162; cv=none; b=WHg8u8xYtj8nU2kCgb/1jWpk2UY4g2ejjt96lpaD4JNX2PODPJtCGufvrtwqkZGVSqy69/dZiYekjnswmac3QSWxftrNI7Wc86A//3RiIpkHrn+M8R/4UARpW9wikSfI5gR6SfQ3klNRwu3gupV7p4baQF3d7dRjaHwUDLLxmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401162; c=relaxed/simple;
	bh=nK9zHAxVGZnMkeSjoS8VWgVGRCHCv8xQ3g7oGI94M6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuyBPkRKdjiv6swhHPaVyc4KP7mdPtw5SEysTio+r9nYOSlrMHOcsTyJ2Zv4YT5Hjm9zY3Oogwl6bD/UZJbSgSAx99MWmg30m1RNbwXS4BeDnIDlhCVVG/A9rSKlS4ZcIv/FaD4wQoOXf7f2iM6F3gmAVTHDc3XF+sZJQ/+p2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayVM5RQ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayVM5RQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737401159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xx95InjbhG+pZJG2egrRkTXKGZsVIpuvXDQLmykKmsc=;
	b=ayVM5RQ3eF1uPBgJxZWmmjcnDfuS1lUzGMD8A9+8kYhF+gNp4OysBQWH/WFpazclzUZ7Ss
	iqu+IIT5xQfkqyNXqmqjcxh4Xzuhb2mwa3AE9UKDiIfhSkQRWnFX0lS+b3VcM/fdCj7YLX
	XhBLb9sWyma2xsSPssR83hWIb1MivL8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-c7aN-3GbMrGEB-Pj-lIrhA-1; Mon, 20 Jan 2025 14:25:57 -0500
X-MC-Unique: c7aN-3GbMrGEB-Pj-lIrhA-1
X-Mimecast-MFC-AGG-ID: c7aN-3GbMrGEB-Pj-lIrhA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so25213155e9.2
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 11:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737401156; x=1738005956;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xx95InjbhG+pZJG2egrRkTXKGZsVIpuvXDQLmykKmsc=;
        b=JJLWpnTnROkBp2h4F8C7l9PLKaX8mxxhx6OmUTJttV3tE+CV2D8qiUQYnpjdJzkwby
         uHfm9bLlktQRHQQqZENksOrbQ/8hclfjACJGoMZ/mpbMzAsYcsa8N1mbrCNIZfuX3IhZ
         uhTagHpZ3DJc6fRGW2ifEwaB/qK6gJrSCdVo83+y5UXh1cKSTmnc8U9Ve2smdlqxQUcH
         z5+dDguUvHgS8QDQCJ0yvtXKHWrh6WEMUFCibAn+mVswNKjvU6Uy2xdH4KJAbo/wTP0b
         kj3ImmI8TM1MG+24Jjosn5BhJD/LT7YQBlfc5Y7vnRPsk8awWmw4mj37q6kmBQvMda2v
         ElDg==
X-Gm-Message-State: AOJu0YzLsFB1YFpomR7zLmNfVCyhjjXRKDOVMCXoN2JEgUQkkaqrnWmF
	9PXV1QXceH2Kgp87PLbGdkftT8Aq5yxliZ30NmvMXFRkU3WT8Ft5O+M16zUQTvF7bbDMWbgDFnd
	eaNjZadfAckdMg3H2gACR79Z427vQIShusvTpJtvkq8X9IVUKZ+KPE3veud/A
X-Gm-Gg: ASbGncvbZYvPz9xZV1TJiMvOiWoWhky6k0q8CSqHmsSZ8um0240YV/QSPGELBhFfnah
	n18i5PY56iOHKLSqCBlKrt3qShvK5jmYTs9xtnzBqbSBOlgmlVxf12tXHDhz6h29NhFjn2xmN/H
	i3Rl2FmWrrQ9shXXxgrRMkosyoPYRYevR19UIUEjNoJdiAKziTXTEwbrxI5hW5PUBjEzFaF8paS
	zFbwjEv1uI89fQCHcIUbX63znVyQ64YxkQmxWO2pY5l0I+dX8vlUK+XZYqZiN2/pz+2+w7cEcrY
	klP5oZvPuH/YptOGO77GqxgD+C9euFPg2BchkclYv71T3GjF/yFeLFopcYeKjpTnoTN2+eqh98I
	eYKB/HF2qa64eNp1bm8ORCA==
X-Received: by 2002:a05:600c:3149:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4389144e70fmr140409645e9.29.1737401156649;
        Mon, 20 Jan 2025 11:25:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV9+jmqmaIoZ04Lg5OT1s6kFlmHP6sSBnuyNEoRWp1lWelnk3T6qiIXqvCAq0EfZhhFAGhIw==
X-Received: by 2002:a05:600c:3149:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4389144e70fmr140409465e9.29.1737401156308;
        Mon, 20 Jan 2025 11:25:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:e400:431d:9c08:5611:693c? (p200300cbc72ee400431d9c085611693c.dip0.t-ipconnect.de. [2003:cb:c72e:e400:431d:9c08:5611:693c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468480sm151106005e9.33.2025.01.20.11.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:25:55 -0800 (PST)
Message-ID: <68262ad8-a417-4183-af56-a3691002c3d1@redhat.com>
Date: Mon, 20 Jan 2025 20:25:54 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
To: Usama Arif <usamaarif642@gmail.com>, sj@kernel.org,
 akpm@linux-foundation.org
Cc: damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120181959.2564362-1-usamaarif642@gmail.com>
 <20250120181959.2564362-2-usamaarif642@gmail.com>
 <9257fbb9-d26d-4028-896f-fb8cfad3ddad@redhat.com>
 <f8e95ec8-f800-495d-a723-53edd0d487f5@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f8e95ec8-f800-495d-a723-53edd0d487f5@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eMGkcAq7zYj_SwJrQl_wwO4GAa55PP4LfznlQzY93OQ_1737401157
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.01.25 20:18, Usama Arif wrote:
> 
> 
> On 20/01/2025 18:57, David Hildenbrand wrote:
>> On 20.01.25 19:19, Usama Arif wrote:
>>> This is to gather statistics to check if memory regions of specific
>>> access tempratures are backed by hugepages. This includes both THPs
>>> and hugetlbfs.
>>> This filter can help to observe and prove the effectivenes of
>>> different schemes for shrinking/collapsing hugepages.
>>>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>> v2 -> v3:
>>> - expose hugepage via sysfs even if the kernel is
>>>     built without hugepage support. DAMON will just
>>>     just return 0. (SJ Park)
>>>
>>> v1 -> v2:
>>> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>>>     CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
>>> ---
>>>    include/linux/damon.h    | 2 ++
>>>    mm/damon/paddr.c         | 5 +++++
>>>    mm/damon/sysfs-schemes.c | 1 +
>>>    3 files changed, 8 insertions(+)
>>>
>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>> index af525252b853..1d94d7d88b36 100644
>>> --- a/include/linux/damon.h
>>> +++ b/include/linux/damon.h
>>> @@ -326,6 +326,7 @@ struct damos_stat {
>>>     * @DAMOS_FILTER_TYPE_ANON:    Anonymous pages.
>>>     * @DAMOS_FILTER_TYPE_MEMCG:    Specific memcg's pages.
>>>     * @DAMOS_FILTER_TYPE_YOUNG:    Recently accessed pages.
>>> + * @DAMOS_FILTER_TYPE_HUGEPAGE:    Page is part of a hugepage.
>>>     * @DAMOS_FILTER_TYPE_ADDR:    Address range.
>>>     * @DAMOS_FILTER_TYPE_TARGET:    Data Access Monitoring target.
>>>     * @NR_DAMOS_FILTER_TYPES:    Number of filter types.
>>> @@ -345,6 +346,7 @@ enum damos_filter_type {
>>>        DAMOS_FILTER_TYPE_ANON,
>>>        DAMOS_FILTER_TYPE_MEMCG,
>>>        DAMOS_FILTER_TYPE_YOUNG,
>>> +    DAMOS_FILTER_TYPE_HUGEPAGE,
>>>        DAMOS_FILTER_TYPE_ADDR,
>>>        DAMOS_FILTER_TYPE_TARGET,
>>>        NR_DAMOS_FILTER_TYPES,
>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>>> index c0ccf4fade24..224308140441 100644
>>> --- a/mm/damon/paddr.c
>>> +++ b/mm/damon/paddr.c
>>> @@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>>>            if (matched)
>>>                damon_folio_mkold(folio);
>>>            break;
>>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>>> +    case DAMOS_FILTER_TYPE_HUGEPAGE:
>>> +        matched = folio_size(folio) == HPAGE_PMD_SIZE;
>>
>>
>> Can we directly embed in the name and the comments/docs that we are only talking about PMD size (both, THP and hugetlb)?
>>
>> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
>>
>>
> 
> I always think of gigantic page as PUD size, hugepage as PMD size (and not anything smaller), mTHP as smaller than PMD :)

And cont-PMD ... hugetlb, cont-PTE hugetlb ... are ? :)

> But I don't think thats the official term or standardized across the kernel.
> 

We didn't know better when we designed some of the old interfaces, 
that's why I am hoping that we can do better with new interfaces. Either 
spell out the PMD size, or have filters for size lists / size ranges.

> I can send a v4, or maybe Andrew could apply the diff below?
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 1d94d7d88b36..261c0741dd0f 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -326,7 +326,7 @@ struct damos_stat {
>    * @DAMOS_FILTER_TYPE_ANON:    Anonymous pages.
>    * @DAMOS_FILTER_TYPE_MEMCG:   Specific memcg's pages.
>    * @DAMOS_FILTER_TYPE_YOUNG:   Recently accessed pages.
> - * @DAMOS_FILTER_TYPE_HUGEPAGE:        Page is part of a hugepage.
> + * @DAMOS_FILTER_TYPE_PMD_HUGEPAGE:    Page is part of a hugepage (THP/hugetlb).
>    * @DAMOS_FILTER_TYPE_ADDR:    Address range.
>    * @DAMOS_FILTER_TYPE_TARGET:  Data Access Monitoring target.
>    * @NR_DAMOS_FILTER_TYPES:     Number of filter types.
> @@ -346,7 +346,7 @@ enum damos_filter_type {
>          DAMOS_FILTER_TYPE_ANON,
>          DAMOS_FILTER_TYPE_MEMCG,
>          DAMOS_FILTER_TYPE_YOUNG,
> -       DAMOS_FILTER_TYPE_HUGEPAGE,
> +       DAMOS_FILTER_TYPE_PMD_HUGEPAGE,
>          DAMOS_FILTER_TYPE_ADDR,
>          DAMOS_FILTER_TYPE_TARGET,
>          NR_DAMOS_FILTER_TYPES,
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 224308140441..e374ea952308 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -223,7 +223,7 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>                          damon_folio_mkold(folio);
>                  break;
>   #if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> -       case DAMOS_FILTER_TYPE_HUGEPAGE:
> +       case DAMOS_FILTER_TYPE_PMD_HUGEPAGE:
>                  matched = folio_size(folio) == HPAGE_PMD_SIZE;
>                  break;
>   #endif
> 


-- 
Cheers,

David / dhildenb

