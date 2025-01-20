Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3B7DA82
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396962; cv=none; b=rp6EiJ6Qu0h8i9uTskdQ96g4371BL0WGEIeVZ76QVg9LoUh6SY/MtM9Ff6oiZSM5xgSfGnU6cm43v8Dvt5ZBAbQv1n8TwQBduA8yuhwaHgjnT1NIme+mt5MSL7WVs86hBLEeuoEpdnOvDtjV7NCSsHYTTEUMdoxD948B2fwIcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396962; c=relaxed/simple;
	bh=+OFHlKjbrMjW5FEVMn/ppbtU4aXEduhHHKnNdTQlOJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrWdSEpQAWvrCKw76LeJbg2Ul3aWjNjZkAGAGLYkTlAgiuf1XA+nbn0Vmk5BbouWsYsVFEiDtcNrzqfvwL2r+dpefmRvWfWAj6aphIRCgCEcYGyLKJKbzlZzAw6++zeiv7EmUHFvhrwKITn7jguTpSBlMXVoWV1VVrk0VH3SkCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us3ueO+r; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us3ueO+r"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so49080205e9.1
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737396959; x=1738001759; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvuRDwF15l3eeDRVUWSXFRuYOtgA+kolXETBWpGp7WM=;
        b=Us3ueO+r6acQRjXF831AUPpY/8vogzRGvx5q+FbWYNRV6ezTBaJECMG9C5d1dILKnE
         Vk1EbHMGzgNxi9wScVwBFIAEFHbwED1CP57AHUcyIe3lmug2dFdgjXXVu2HcLBfI+g1h
         N2/XGLi4CEZ+7kd9r2i77tWGfoiFAToZVeWUMxXgq/hSD3pClXmHsqw+fS1u7fcUIAWe
         q96foKSmw2SDtRncmCg8nS3OFNh5P5sG7fic21tBAfpeHyHm4/+n9gmVj2QdOcjaDWVW
         AUIcRtCgpWq1EnWaAqsYXqI4zGGPPFugUrwteCAwn+5JIY4HQ+JvSP6ix5n/rpPUrphY
         q4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737396959; x=1738001759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvuRDwF15l3eeDRVUWSXFRuYOtgA+kolXETBWpGp7WM=;
        b=KaOXMrbpUOmbTJp25ayDOVMVle9IyFZF2AGxWm2e32dcFfVmToHGOnIoLKyB2fA/dJ
         MlRJlOFTqa4pBKF7Y1jD7YI6TckJfesDqtyJAnQmjjdxBoqprsxs+FUtsnYlkEvQlKjY
         czjz/+2hSa+NQFEutM5eVupRH4KP0lVF88APcXN6srxEkYTrZYwxRweU1t53hlr5se6P
         QZjlW3DfnBEQh3tYiHcmPLU1IhnuXPdZeBr2+G51eIaukHFEKNgvPJThewAcy0JwnIcI
         IKB2EOTz1n6Pqrv0uyjpuerfGBxuGrQNsRJHjMdUt7meSO5IuNpNkTspoMf3FwcYN5I2
         A+rw==
X-Forwarded-Encrypted: i=1; AJvYcCU20JZB36uY69RhIJs0HJ8Y/xPS3LWITTKMOjVau6pbUE0nbmDzQ226+2tbF6nnhTCH9/al4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTKabGZtq9L5ivKldg6Z2a6RCmUznUHyoJj0U55cVtOXOA3EVW
	NpUK5R9/otNtxbLTqdCGagpU3jA75fB3DsxsnZMKGASsuU3lPBAyT4kYkK05
X-Gm-Gg: ASbGncueIjbH8WMN5Eq3D6AgU+pYKFvYsk1py3fJcs6pZqWZieAn+Q0iEDMLcBSkeK+
	NN/xqs60RPE4Aq1xQ7+4Ys5pELVZeOv8KEzPDw825iYiTQPfKkpyo/9CCZpSPfnrp2mSRha8I6C
	jmX6RoKJOv77dQLASsZuqLZ4RH6SlBlaVererSXSewCjsEaYUdRRsEqUl8DTPVT48/4eqXSsM3D
	v53FI8q7DAjHKvEHL+aRpJTRzXqa3IbEP9dlLGeaKijYYAq83Ajcs4sjjfg88dOAh01Uj9gr3za
	VGbWU+ySIImBSSQxFtWZu95Xvd1WaospYEo0IwjMEy8mjzSTZfvi1hJdtaPZQrM=
X-Google-Smtp-Source: AGHT+IFNFvyw1hiWWtlTto7psqXvRt0zlzaIgT4u+Av0tJcYj0Y3g1Liqpw9dF5MwYtyM+/V/ku1xQ==
X-Received: by 2002:a05:600c:1c83:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-438913be56bmr136757005e9.5.1737396958801;
        Mon, 20 Jan 2025 10:15:58 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4388ebdefe0sm163724235e9.15.2025.01.20.10.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 10:15:58 -0800 (PST)
Message-ID: <58826a2b-5ab9-41dd-b33d-9d92e7ec7e11@gmail.com>
Date: Mon, 20 Jan 2025 18:15:57 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/damon: introduce DAMOS filter type hugepage
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120180815.36028-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250120180815.36028-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/01/2025 18:08, SeongJae Park wrote:
> On Mon, 20 Jan 2025 10:16:50 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> This is to gather statistics to check if memory regions of specific
>> access tempratures are backed by hugepages. This includes both THPs
>> and hugetlbfs.
>> This filter can help to observe and prove the effectivenes of
>> different schemes for shrinking/collapsing hugepages.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>> v1 -> v2:
>> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>>   CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
>> ---
>>  include/linux/damon.h    | 4 ++++
>>  mm/damon/paddr.c         | 5 +++++
>>  mm/damon/sysfs-schemes.c | 3 +++
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index af525252b853..b0dbf380ab76 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -326,6 +326,7 @@ struct damos_stat {
>>   * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
>>   * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
>>   * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
>> + * @DAMOS_FILTER_TYPE_HUGEPAGE:	Page is part of a hugepage.
>>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
>>   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>> @@ -345,6 +346,9 @@ enum damos_filter_type {
>>  	DAMOS_FILTER_TYPE_ANON,
>>  	DAMOS_FILTER_TYPE_MEMCG,
>>  	DAMOS_FILTER_TYPE_YOUNG,
>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>> +	DAMOS_FILTER_TYPE_HUGEPAGE,
>> +#endif
> 
> I'd prefer not enclosing this part with CONFIG_PGTABLE_HAS_HUGE_LEAVES, so that
> users can simply use it.  If the config is not set, damos_pa_filter_match()
> will just say nothing is hugepage, and hence will work sanely, in my opinion.
> 

I was going along the path of not even exposing it to the userspace in sysfs,
so that the user might not get confused about hugepages. But I agree the alternate
is good a well, with just 0 being returned. I will send v3 without it.


>>  	DAMOS_FILTER_TYPE_ADDR,
>>  	DAMOS_FILTER_TYPE_TARGET,
>>  	NR_DAMOS_FILTER_TYPES,
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index c0ccf4fade24..224308140441 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>>  		if (matched)
>>  			damon_folio_mkold(folio);
>>  		break;
>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>> +		matched = folio_size(folio) == HPAGE_PMD_SIZE;
>> +		break;
>> +#endif
> 
> This part looks good to me.
> 
>>  	default:
>>  		break;
>>  	}
>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
>> index 98f93ae9f59e..3eb3ec464591 100644
>> --- a/mm/damon/sysfs-schemes.c
>> +++ b/mm/damon/sysfs-schemes.c
>> @@ -329,6 +329,9 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
>>  	"anon",
>>  	"memcg",
>>  	"young",
>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>> +	"hugepage",
>> +#endif
> 
> Again, I'd prefer not enclosing this part.
> 
>>  	"addr",
>>  	"target",
>>  };
>> -- 
>> 2.43.5
> 
> 
> Thanks,
> SJ

