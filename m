Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E98479
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737400701; cv=none; b=afAHKBeZE6bYLtnBoIZuyj0iotI8lb/kwCgCG5h34XkZhn67/akyuDSPGTUrw9PMWuq8Rris/yM5t0RCuAZw6Ly++i92hMYKmXQ7SwQhfwTY/G3tlBUVxXN7JQXAaNFDg4NJ6bsliwOsC+i6RU8HAHtKu6vb02q3pQEdAaNVy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737400701; c=relaxed/simple;
	bh=V2j+Hm8XONx7n4DYRWGuFXi72kBdOt+RLZJDff6NYV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD0vVnRQ9qXNiKp37MtL+72wkZZ0ngrBqj6Xj5dPEk7cXkdbSfG4WUbPu0cCkGOe0Lo3CxHfXuaqvnc2tEdtHBuFTxzZRaAYsNRsWfsFNBSA8caEWk0COWL/ceXEn3OYwMQdD3UN8WIhIH0j28wmOvzWrhHFUJynhg5RS5l22Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMymZnvG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMymZnvG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso30863675e9.1
        for <damon@lists.linux.dev>; Mon, 20 Jan 2025 11:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737400698; x=1738005498; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUH9pwbs8CFBUnUkxuN57HjTrhd0kAeHEUeC0s3fh4U=;
        b=FMymZnvGsAj0jPlC4ojuNgkL+H2yHaOJWlPBFCEtkqErMv44W4eX6Y8xMmTRbcQ6/M
         lPBtfhmjMFOvo5Kloq3b9xfi67elRzCmkbPhUJwYSVGErvb+Qa59Yk5NLDEoLIE3JFRt
         QcvfBHsgH3bnrTzufzte8aMgt29UktBNWcGR0f0pS+qxJvxHTHc77C6y60/rVptTxuPE
         agUUDYexi4qOy0ePhwrLbrWHoY7TUH1wKBVmhB2B9OxwF7NcvBw2896ykT5UHk+yVpRQ
         zvGA896OklkjidJOw7SgYq8oTUYjyPOm4vFm05EUvdq+StRLRHsxqzsBlV/ata11WyAj
         M11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737400698; x=1738005498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUH9pwbs8CFBUnUkxuN57HjTrhd0kAeHEUeC0s3fh4U=;
        b=YLF+19EQUZ5V4Qxu6y87rutKjfXsYl2tzmGals+8PTGioeYoRtbzeamcTH4B3xLS4h
         APfoikhfhNb2GSFWl2351L7VvBM2o0yk6Jhp/Xdtdzq7BMTCbUCWz3Iqg27CJWgjrR2F
         B7MSAHDO/0olRNLfqV+6ERbTx8s7ZMB/aiwJAfoRgFkyOt2/c3NMNLdqZaek/qDkCima
         GCqQ1Cu3Q9qgmPUso9+xpZyj9yC4LLjwLMCgHnp2gvp13Bg1XghxXyIpAJgIAaMG0O/V
         iUd2AQicFmFnTVPkm54BaqhCPEBIyW4Pm3pT3fGIfa8z8nxOzlZPBjeKifhehvygJcAh
         VhpQ==
X-Gm-Message-State: AOJu0YyB2PB8mi7x/KaIE91uBkt40b0vM40uh7Q1EethY+cTjqhy140B
	5q2b07W64u3YPTiCwORecUYlMPyDkPs/wBGmKuH7H7TOaj0gjv0x
X-Gm-Gg: ASbGnctXed/BDE8F0nIbBuvQ5I/nnowyrMZon8T2ViAxL7uNtZZlpxEnKQb7eKNNuNM
	wfAlp72piiqV71cdSCU/ZjUeq0enHjhQa70jHWzgmliMWDgGhTXUbx6YYElwnpPUR9xZfI7O6U/
	R8lYWOERjYzb1515p4Hc6eTAMp32/KUoa1gVkU9m+9wa1kfF/lwUfPQLbX+B6wXNeOMyTXmzwxw
	v9OpHnNko9qMODcuIUfR2o9goMa7f58PAVqR5IVXpkOBDin61Xkl5olvmr52R+BQSyz922Xw2bo
	Uk+RGGq1qJztV+vNkhC348cMBiBqLobIeK06dHj7qKFUqEBIUK0xYLGih+gD1ag=
X-Google-Smtp-Source: AGHT+IE8CFZ93qPjvmjhysvqFDSbOyzpgQiClaQKNuTcROHAlz4tyRyDeTm4P40FO98apqePnAz74A==
X-Received: by 2002:a05:600c:5029:b0:436:1b77:b5aa with SMTP id 5b1f17b1804b1-437c6afdbd9mr193477265e9.8.1737400698064;
        Mon, 20 Jan 2025 11:18:18 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438a3805614sm88288835e9.22.2025.01.20.11.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:18:17 -0800 (PST)
Message-ID: <f8e95ec8-f800-495d-a723-53edd0d487f5@gmail.com>
Date: Mon, 20 Jan 2025 19:18:17 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
To: David Hildenbrand <david@redhat.com>, sj@kernel.org,
 akpm@linux-foundation.org
Cc: damon@lists.linux.dev, linux-mm@kvack.org
References: <20250120181959.2564362-1-usamaarif642@gmail.com>
 <20250120181959.2564362-2-usamaarif642@gmail.com>
 <9257fbb9-d26d-4028-896f-fb8cfad3ddad@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <9257fbb9-d26d-4028-896f-fb8cfad3ddad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/01/2025 18:57, David Hildenbrand wrote:
> On 20.01.25 19:19, Usama Arif wrote:
>> This is to gather statistics to check if memory regions of specific
>> access tempratures are backed by hugepages. This includes both THPs
>> and hugetlbfs.
>> This filter can help to observe and prove the effectivenes of
>> different schemes for shrinking/collapsing hugepages.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>> v2 -> v3:
>> - expose hugepage via sysfs even if the kernel is
>>    built without hugepage support. DAMON will just
>>    just return 0. (SJ Park)
>>
>> v1 -> v2:
>> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>>    CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)
>> ---
>>   include/linux/damon.h    | 2 ++
>>   mm/damon/paddr.c         | 5 +++++
>>   mm/damon/sysfs-schemes.c | 1 +
>>   3 files changed, 8 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index af525252b853..1d94d7d88b36 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -326,6 +326,7 @@ struct damos_stat {
>>    * @DAMOS_FILTER_TYPE_ANON:    Anonymous pages.
>>    * @DAMOS_FILTER_TYPE_MEMCG:    Specific memcg's pages.
>>    * @DAMOS_FILTER_TYPE_YOUNG:    Recently accessed pages.
>> + * @DAMOS_FILTER_TYPE_HUGEPAGE:    Page is part of a hugepage.
>>    * @DAMOS_FILTER_TYPE_ADDR:    Address range.
>>    * @DAMOS_FILTER_TYPE_TARGET:    Data Access Monitoring target.
>>    * @NR_DAMOS_FILTER_TYPES:    Number of filter types.
>> @@ -345,6 +346,7 @@ enum damos_filter_type {
>>       DAMOS_FILTER_TYPE_ANON,
>>       DAMOS_FILTER_TYPE_MEMCG,
>>       DAMOS_FILTER_TYPE_YOUNG,
>> +    DAMOS_FILTER_TYPE_HUGEPAGE,
>>       DAMOS_FILTER_TYPE_ADDR,
>>       DAMOS_FILTER_TYPE_TARGET,
>>       NR_DAMOS_FILTER_TYPES,
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index c0ccf4fade24..224308140441 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -222,6 +222,11 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
>>           if (matched)
>>               damon_folio_mkold(folio);
>>           break;
>> +#if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
>> +    case DAMOS_FILTER_TYPE_HUGEPAGE:
>> +        matched = folio_size(folio) == HPAGE_PMD_SIZE;
> 
> 
> Can we directly embed in the name and the comments/docs that we are only talking about PMD size (both, THP and hugetlb)?
> 
> DAMOS_FILTER_TYPE_PMD_HUGEPAGE or sth. like that.
> 
> 

I always think of gigantic page as PUD size, hugepage as PMD size (and not anything smaller), mTHP as smaller than PMD :)
But I don't think thats the official term or standardized across the kernel.  

I can send a v4, or maybe Andrew could apply the diff below?

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1d94d7d88b36..261c0741dd0f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -326,7 +326,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:    Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:   Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:   Recently accessed pages.
- * @DAMOS_FILTER_TYPE_HUGEPAGE:        Page is part of a hugepage.
+ * @DAMOS_FILTER_TYPE_PMD_HUGEPAGE:    Page is part of a hugepage (THP/hugetlb).
  * @DAMOS_FILTER_TYPE_ADDR:    Address range.
  * @DAMOS_FILTER_TYPE_TARGET:  Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:     Number of filter types.
@@ -346,7 +346,7 @@ enum damos_filter_type {
        DAMOS_FILTER_TYPE_ANON,
        DAMOS_FILTER_TYPE_MEMCG,
        DAMOS_FILTER_TYPE_YOUNG,
-       DAMOS_FILTER_TYPE_HUGEPAGE,
+       DAMOS_FILTER_TYPE_PMD_HUGEPAGE,
        DAMOS_FILTER_TYPE_ADDR,
        DAMOS_FILTER_TYPE_TARGET,
        NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 224308140441..e374ea952308 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -223,7 +223,7 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
                        damon_folio_mkold(folio);
                break;
 #if defined(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
-       case DAMOS_FILTER_TYPE_HUGEPAGE:
+       case DAMOS_FILTER_TYPE_PMD_HUGEPAGE:
                matched = folio_size(folio) == HPAGE_PMD_SIZE;
                break;
 #endif

