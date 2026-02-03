Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F1340DB0
	for <damon@lists.linux.dev>; Tue,  3 Feb 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127502; cv=none; b=lWYlfNOiQ2F4lL5WRYbackkblBkizXiZ0zCTtJ6ScIfc6TkAFvztBtAjIgd9taWXHou9ExMuDRZEPZNtCXbjZPqOhSWPiM4vGs3gqtDyr7UNY5gA+NJl152dxehKPtRnhZL/8C77hMMtHw+sTWaTqUUNrMzkv7w/Np86ITE57Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127502; c=relaxed/simple;
	bh=bKAYvr03hVLEyvwwLgiQr982bS7w29xb6k+DOFs4JXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iimwkFC0Kxf17zB4VR0OHAcFzxeUzc/1cAx7rEfx0j1Dz5D4UXYjmmU3ZaU+rWNram5qkZXXAqsMm7s76/KmMl/3gJM4xvm7XJ09cPg7WwYMipmM1P6TP6IC/pqA3W6NBQ6noNdTVqZDd2i0ul5aY7uk4hOGOryRJqQZIp571FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f54wD03yfzHnGkL;
	Tue,  3 Feb 2026 22:03:56 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 707E140573;
	Tue,  3 Feb 2026 22:04:55 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Feb 2026 17:04:54 +0300
Message-ID: <5f4edc60-691a-4dbc-93db-794f11f7b942@huawei-partners.com>
Date: Tue, 3 Feb 2026 17:04:54 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/4] mm/damon: Support for synchrounous huge pages
 collapse
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260203012304.67686-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260203012304.67686-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 2/3/2026 4:23 AM, SeongJae Park wrote:
> On Mon, 2 Feb 2026 14:56:47 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> * Support for huge pages collapse, which will be used by
>>   dynamic_hugepages module.
>>
>> * Include the new module for compilation
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
>> ---
>>  include/linux/damon.h | 1 +
>>  mm/damon/Kconfig      | 7 +++++++
>>  mm/damon/Makefile     | 1 +
>>  mm/damon/vaddr.c      | 3 +++
>>  4 files changed, 12 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 3813373a9200..de5a994f92c2 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -142,6 +142,7 @@ enum damos_action {
>>  	DAMOS_LRU_DEPRIO,
>>  	DAMOS_MIGRATE_HOT,
>>  	DAMOS_MIGRATE_COLD,
>> +	DAMOS_COLLAPSE,
> 
> Please update the kernel-doc comments for this new action, by the time you drop
> the RFC tag from this patch series.
> 
>>  	DAMOS_STAT,		/* Do nothing but only record the stat */
>>  	NR_DAMOS_ACTIONS,
>>  };
>> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
>> index 8c868f7035fc..2355aacb6d12 100644
>> --- a/mm/damon/Kconfig
>> +++ b/mm/damon/Kconfig
>> @@ -110,4 +110,11 @@ config DAMON_STAT_ENABLED_DEFAULT
>>  	  Whether to enable DAMON_STAT by default.  Users can disable it in
>>  	  boot or runtime using its 'enabled' parameter.
>>  
>> +config DAMON_HOT_HUGEPAGE
>> +	bool "Build DAMON-based collapse of hot regions (DAMON_HOT_HUGEPAGES)"
>> +	depends on DAMON_VADDR
>> +	help
>> +	 Collapse hot region into huge pages. Hot regions are determined by
>> +	 DAMON-based sampling
>> +
> 
> Apparently you wanted to introduce the above change on the next patch, but
> mistakenly added here?
> 
> I'm also feeling the name might be better to be simpler.  What about... say,
> just DAMON_HUGEPAGE?  We might want to extend that for general access-aware
> huge pages.

I will move the build stuff into a different commit for the next RFC series.

I agree with the name change, I will do it.

>>  endmenu
>> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
>> index d8d6bf5f8bff..998bddc17819 100644
>> --- a/mm/damon/Makefile
>> +++ b/mm/damon/Makefile
>> @@ -7,3 +7,4 @@ obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
>>  obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
>>  obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
>>  obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
>> +obj-$(CONFIG_DAMON_HOT_HUGEPAGE)	+= modules-common.o dynamic_hugepages.o
> 
> Ditto.
> 
>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>> index 23ed738a0bd6..4acbc1a6a5be 100644
>> --- a/mm/damon/vaddr.c
>> +++ b/mm/damon/vaddr.c
>> @@ -970,6 +970,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>>  	case DAMOS_NOHUGEPAGE:
>>  		madv_action = MADV_NOHUGEPAGE;
>>  		break;
>> +	case DAMOS_COLLAPSE:
>> +		madv_action = MADV_COLLAPSE;
>> +		break;
>>  	case DAMOS_MIGRATE_HOT:
>>  	case DAMOS_MIGRATE_COLD:
>>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
>> -- 
>> 2.43.0
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

