Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33714A088
	for <damon@lists.linux.dev>; Wed,  5 Feb 2025 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763561; cv=none; b=ppvsVur8wswupsurijrjQNd2JXft9aRL5lyXUMNBtqzWUqvXRPdbpw6Dl4hyPemYOIEWHRRlooaLQ5v09G/h8XUhVhEgoOQNUPcRi/cmg4uKNjMPjhR4WPNUmHgZyLCavTN5mQbZiXXI5jgl8ond8OB5Dgtp3t7db9KIjLUbKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763561; c=relaxed/simple;
	bh=V2rwOQHNYNjoJJnrcjSrjMTzj1gGqOLeNMFF0r97Yd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me5rPONAv/4J6BbGXLJpyijHzR3aaJZwMV128e0DMQdZsFwcbSWjMXd4VY8laE7S91puaY94l9qKDKTMnAhYzPIIOGcUz6d2vPI8GmV1iudVGZGlvkED7UTyL0LRd3/rsQoMsq09dVNOaY1O4Exxi9YxSQuRCi64VrKUcbV6zY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzrvweZr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzrvweZr"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38634c35129so5317363f8f.3
        for <damon@lists.linux.dev>; Wed, 05 Feb 2025 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738763558; x=1739368358; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWD6r14a+6y1+jsCe/HuBgbt1286kvG54IAM73Hoegw=;
        b=FzrvweZrvseH7y4gZqUbsYLnTkH7XmtuA4Tlnsc3GeiRg77Eaorjs4vApnFMK/NmrD
         oh1OsFsQizEtrs2pLflkkaalUDt4A/7lbyw+rQvCsyjif9GMpcOlfc0gNRFU0XkYuI/P
         pJP9thB17jIIL3L9GaLdsGCIfcx4CDUjTd/87tCkSlnp6vc5/SjTGG5P7GSFt0mrCf2Y
         6UatPmkuwuU5OkBxhiQUDoqwGRv3PocK1Fo8uTUEuhEx8Mix8+Of/b9/M6p7tgDcsQ9B
         6cQYDtn2k2nBKxNtC5HcJqHz3W2AXyOn+IiOF7/30kc6QyB91BoEV9+R24rJrt3BkkxB
         ld/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738763558; x=1739368358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWD6r14a+6y1+jsCe/HuBgbt1286kvG54IAM73Hoegw=;
        b=l220WAAiJ8O6L7jNpwXuZ05f6ySx5/Z5z8AtKCqemwmKc9zvuz6ZmoaJzzyzWQrC/k
         wU+xN0zWBz/wsGtAxQ32ZqaMdP7PUJ750Shf88peiOVl0vaqJTG5Rt8YrsDC61vXWmhP
         Q0ERGBs7owFSJF/mi0LkudYn5Dgx/jSSr5g3d8UZk7h7DJi9acWNcDAqr+wVREvNWN7l
         YwpJk8bqf0W7w3Au+yhG45jsr9KSPSajzFDjP3yGCWDo9Wv344B1HTJNo2odCwDYRK0p
         GIU2EIHm7N3926WDrcGX1UYaX6qV7npS0M4SPz8SjA19lF17Az9hFbjaE3JSUKc2A9Gj
         lVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx5vyObK68ZUdehQDVFyhS/oKWznlPFFoFiaA17YO/UoMNWbInFKu/QnKLAHdvgahMFiUE6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKzFVHN5Mci1wARVcu1YIWD/LjiO0Q2TgGb2Ky6pG1VhoRMDb/
	/XWXjtql1xr2SD/EGPIcLf9J6nQGddh/q3sUrOM6VRJlxVLtnW/N
X-Gm-Gg: ASbGncuGrmRKLU4v7pal2bPmLu1Czy3BmAhX1ceC2lpXoE5cVtzNUIvCIi6nqbwlIG1
	iO5Oq3MipH5vKbOIUvIqYwW3slJjCGJA2lB1hwSQ67nfl4CNftUYbqbayGyRfdQadnTVZKcYZF9
	jkQZatsaQIedssgTU/gXNxz9wvw+ApBNMZwiiCBVGTIyWMeQy/FbAg38M07NHw1hfudDoQHp8zX
	AQhGWczoqmNoKLvygLKVrqej+biy5Tjd/qNRN7bwlIg1ZRnFwXpkAwVt8lvwkoDKo1ECI0TBStT
	8xk3zHYiVXJ4pTlubSfsvzX5FJ6HI7SYCXdPKjgIg+f+ZYPKniJjimAJuAEhbP9XkhdzIJwonjB
	yJcs6pCGi
X-Google-Smtp-Source: AGHT+IFkoEM5L2HsLoB1Y0gjWhTemzeu165bTNyyFWWwTYb+5WNQkW8pRBjDwZGrd730WNRQWGn9og==
X-Received: by 2002:a05:6000:1f89:b0:386:3262:28c6 with SMTP id ffacd0b85a97d-38db48a9b23mr2173380f8f.5.1738763557950;
        Wed, 05 Feb 2025 05:52:37 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d933a3esm23278275e9.5.2025.02.05.05.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 05:52:37 -0800 (PST)
Message-ID: <49382f59-afea-41b2-8ca5-1bec9fb179dc@gmail.com>
Date: Wed, 5 Feb 2025 13:52:37 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm/damon: introduce DAMOS filter type hugepage
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 hannes@cmpxchg.org, david@redhat.com, kernel-team@meta.com
References: <20250204231248.2729-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250204231248.2729-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/02/2025 23:12, SeongJae Park wrote:
> On Mon,  3 Feb 2025 22:55:31 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> This is to gather statistics to check if memory regions of specific
>> access tempratures are backed by hugepages of a size in a specific
>> range
> 
> nit.  A period is missed?
> 
>> This filter can help to observe and prove the effectivenes of
>> different schemes for shrinking/collapsing hugepages.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  include/linux/damon.h    | 2 ++
>>  mm/damon/paddr.c         | 7 +++++++
>>  mm/damon/sysfs-schemes.c | 1 +
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 6f30ceeff215..5ba6c2114e3f 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -336,6 +336,7 @@ struct damos_stat {
>>   * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
>>   * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
>>   * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
>> + * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
> 
> What about "DAMOS_FILTER_TYPE_HUGEPAGE_SIZE: hugepages of a given size range."?
> 
>>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>>   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>> @@ -355,6 +356,7 @@ enum damos_filter_type {
>>  	DAMOS_FILTER_TYPE_ANON,
>>  	DAMOS_FILTER_TYPE_MEMCG,
>>  	DAMOS_FILTER_TYPE_YOUNG,
>> +	DAMOS_FILTER_TYPE_HUGEPAGE,
>>  	DAMOS_FILTER_TYPE_ADDR,
>>  	DAMOS_FILTER_TYPE_TARGET,
>>  	NR_DAMOS_FILTER_TYPES,
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index 3f59a3fdc391..34fe1eb664cc 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -227,6 +227,7 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>>  {
>>  	bool matched = false;
>>  	struct mem_cgroup *memcg;
>> +	size_t folio_sz;
>>  
>>  	switch (filter->type) {
>>  	case DAMOS_FILTER_TYPE_ANON:
>> @@ -246,6 +247,12 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>>  		if (matched)
>>  			damon_folio_mkold(folio);
>>  		break;
>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> 
> I think we don't really need this macro?
> 
>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>> +		folio_sz = folio_size(folio);
>> +		matched = filter->folio_size.min <= folio_sz && folio_sz <= filter->folio_size.max;
> 
> We should also return 'false' if the folio is not a large folio (folio_sz ==
> PAGE_SIZE), if we agreed to my suggestion on the previous version of this patch
> series?

I think we could let users get PAGE_SIZE as well incase they wanted it? more on it below..

> 
> I'd also prefer calling filter->folio_siz as sz_range or size_range, so that we
> can reuse it for future filter types of size range.
> 
>> +		break;
>> +#endif
>>  	default:
>>  		break;
>>  	}
>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
>> index bc7ca43ca9c4..76aee3ab277e 100644
>> --- a/mm/damon/sysfs-schemes.c
>> +++ b/mm/damon/sysfs-schemes.c
>> @@ -330,6 +330,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
>>  	"anon",
>>  	"memcg",
>>  	"young",
>> +	"hugepage",
> 
> hugepage_size?
> 

So from https://lore.kernel.org/all/20250121200510.43645-1-sj@kernel.org/, my understanding
was you didn't have a preference between "hugepage" and "hugepage_size"?

I do prefer hugepage over hugepage_size. This is because this is a type of filter, I would
say hugepage_size is not a type, but hugepage is. For e.g. we have anon as type and not 
anon_number. And the "size" part is clear from the min and max which is documented in patch
5 and 6.

TBH my preference would be "folio". What I think we should do is let users input any value
for min and max, as long as max > min, even if its just 4K page. If the user just wants
to know how much of the region is 4K page, they will get it with this. But as David said,
folio is a kernel concept so might not be best to expose it as sysfs to userspace?

As folio might not be an option, my preference is going with hugepage, but as its not
an implementation detail and just naming, I am ok to change it to hugepage_size if
you have a strong preference for it.


>>  	"addr",
>>  	"target",
>>  };
>> -- 
>> 2.43.5
> 
> 
> Thanks,
> SJ

