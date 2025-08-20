Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DDD52F66
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683680; cv=none; b=Pef4mampahl3cRxTKGP2PI8cZP2U2LdXfady2eXSLVMYIzutJTjTVILB63uYIFwXCbjpgVgmI9F4P8rFByt50GsTI6vDf3EWk/Bm07n/OOVjhfUYhoWaN1j9lwclw0G/aVH1IEnoem/+vZz/o3fnUU4ZPc2FZl6EwhJpDvB1Lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683680; c=relaxed/simple;
	bh=Ro4O2IAXbJWzCl8u5dQOjL01oCqqZnNtGpY+imAE7Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FmNwCbVZqJD52xCAKA+7qCM9J7Yo0Uz1cQwacf0tlv1FbU00lZXuzVSppvwFgW8xY57Z+AE4JnQWfzE+ou91EUmW/EAd9zPhdd/ZI8moidbC0KZir9DEn0ZRKfsBv4eETxXMchVKrTwFR0Klwkpy2A0FgEiT5q4C2Mc5EWQhGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c6MBG4XsmzPqXb;
	Wed, 20 Aug 2025 17:49:58 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 8271F14011A;
	Wed, 20 Aug 2025 17:54:34 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 17:54:33 +0800
Message-ID: <3b5a37a7-af37-4108-a0c5-bc147bb77842@huawei.com>
Date: Wed, 20 Aug 2025 17:54:32 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 15/16] mm/damon: the byte statistics data type
 in damos_stat uses unsigned long long
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250813171000.6345-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250813171000.6345-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/14 1:10, SeongJae Park 写道:
> On Wed, 13 Aug 2025 13:07:05 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> For 32-bit systems, damos_stat now uses unsigned long long for byte
>> statistics data to avoid integer overflow risks inherent in the
>> previous design.
> I suggested using the core-layer address unit on stat, and ask users to
> multiply the addr_unit value to stat values if they want bytes value.  If we
> agree on it, I think this patch wouldn't really be required.

Thank you for the guidance, I agree with your perspective. However, this patch doesn't actually belong in the addr_unit series, my apologies
for the confusion. It is actually intended to address potential overflow issues
in statistical data on 32-bit systems, and it is not directly related to addr_unit.
This patch has been dropped from the v2 series.

After introducing addr_unit, if it is set to a larger value, it can help mitigate
the overflow issue. However, under the default setting of addr_unit=1, statistical
data may still overflow after a sufficiently long runtime, for example, when sz_tried
exceeds 4GB.

Besides, please allow me to mention one point in advance: if addr is extended for
use in modules(e.g. DAMON_RECLAIM, LRU_SORT) in the future, the term "bytes" in
module_param_named(bytes_##try_name...), although multiplied by addr would yield
the actual byte count, might cause confusion due to its seemingly direct naming.

Overall, this patch isn’t critically important at the moment, nor does it offer a
sufficiently robust solution, but I’d still appreciate hearing your perspective on
the matter — I’m all ears.

Thanks,
Quanmin Yan

>> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
>> ---
>>   include/linux/damon.h     |  6 +++---
>>   mm/damon/modules-common.h |  4 ++--
>>   mm/damon/sysfs-schemes.c  | 12 ++++++------
>>   3 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index aa045dcb5b5d..d85850cf06c5 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -333,10 +333,10 @@ struct damos_watermarks {
>>    */
>>   struct damos_stat {
>>   	unsigned long nr_tried;
>> -	unsigned long sz_tried;
>> +	unsigned long long sz_tried;
>>   	unsigned long nr_applied;
>> -	unsigned long sz_applied;
>> -	unsigned long sz_ops_filter_passed;
>> +	unsigned long long sz_applied;
>> +	unsigned long long sz_ops_filter_passed;
>>   	unsigned long qt_exceeds;
>>   };
>>   
>> diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
>> index c7048a449321..ae45d0eb960e 100644
>> --- a/mm/damon/modules-common.h
>> +++ b/mm/damon/modules-common.h
>> @@ -36,11 +36,11 @@
>>   #define DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(stat, try_name,		\
>>   		succ_name, qt_exceed_name)				\
>>   	module_param_named(nr_##try_name, stat.nr_tried, ulong, 0400);	\
>> -	module_param_named(bytes_##try_name, stat.sz_tried, ulong,	\
>> +	module_param_named(bytes_##try_name, stat.sz_tried, ullong,	\
>>   			0400);						\
>>   	module_param_named(nr_##succ_name, stat.nr_applied, ulong,	\
>>   			0400);						\
>> -	module_param_named(bytes_##succ_name, stat.sz_applied, ulong,	\
>> +	module_param_named(bytes_##succ_name, stat.sz_applied, ullong,	\
>>   			0400);						\
>>   	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
>>   			0400);
>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
>> index 74056bcd6a2c..3c4882549a28 100644
>> --- a/mm/damon/sysfs-schemes.c
>> +++ b/mm/damon/sysfs-schemes.c
>> @@ -199,10 +199,10 @@ static const struct kobj_type damon_sysfs_scheme_regions_ktype = {
>>   struct damon_sysfs_stats {
>>   	struct kobject kobj;
>>   	unsigned long nr_tried;
>> -	unsigned long sz_tried;
>> +	unsigned long long sz_tried;
>>   	unsigned long nr_applied;
>> -	unsigned long sz_applied;
>> -	unsigned long sz_ops_filter_passed;
>> +	unsigned long long sz_applied;
>> +	unsigned long long sz_ops_filter_passed;
>>   	unsigned long qt_exceeds;
>>   };
>>   
>> @@ -226,7 +226,7 @@ static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
>>   	struct damon_sysfs_stats *stats = container_of(kobj,
>>   			struct damon_sysfs_stats, kobj);
>>   
>> -	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
>> +	return sysfs_emit(buf, "%llu\n", stats->sz_tried);
>>   }
>>   
>>   static ssize_t nr_applied_show(struct kobject *kobj,
>> @@ -244,7 +244,7 @@ static ssize_t sz_applied_show(struct kobject *kobj,
>>   	struct damon_sysfs_stats *stats = container_of(kobj,
>>   			struct damon_sysfs_stats, kobj);
>>   
>> -	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
>> +	return sysfs_emit(buf, "%llu\n", stats->sz_applied);
>>   }
>>   
>>   static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
>> @@ -253,7 +253,7 @@ static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
>>   	struct damon_sysfs_stats *stats = container_of(kobj,
>>   			struct damon_sysfs_stats, kobj);
>>   
>> -	return sysfs_emit(buf, "%lu\n", stats->sz_ops_filter_passed);
>> +	return sysfs_emit(buf, "%llu\n", stats->sz_ops_filter_passed);
>>   }
>>   
>>   static ssize_t qt_exceeds_show(struct kobject *kobj,
>> -- 
>> 2.34.1
