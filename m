Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7040E8FE
	for <damon@lists.linux.dev>; Fri,  5 Jun 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667278; cv=none; b=QLdjlji7V3LQ+fvgM36vhVo1vAroJhJzjnNG0NCz2VNGaeQGqXcpgH80gzuXYKIMv6D6M8yb4jrOKxnArrZevivSEoapHd4sy8GMwEEzyhvWsI/w0wUzc5f2lDyb00fiOZzmg9GnBo9jYs+51KyqF7snWhbXV3Lr3qaf+LQoQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667278; c=relaxed/simple;
	bh=NN/rc8yKHX+dd8QCtm8RvGWiemW2bGlK2xdphnyQaNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qkwZtQIZWqluH1D6Hm6v3ERta8abRAGZ6IJj7pf2v4HqrRqgu10Nj7rwLWnRWnz3F8b/o8OyARI19cFaWVfeG4nsq4xzQ6qinJKr61ZXlGj+iYpxm4pxF2wSJfm/sMwQXtTl5F0uSmKaoP9z7T6P/6rN3Tb0RFGxMc1F01nbcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gX2mF2YyTzHnGk9;
	Fri,  5 Jun 2026 21:46:53 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id E8EC040571;
	Fri,  5 Jun 2026 21:47:48 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jun 2026 16:47:48 +0300
Message-ID: <71dd8dd8-f30f-436d-93d9-fb812ed7a2eb@huawei-partners.com>
Date: Fri, 5 Jun 2026 16:47:47 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260605010620.83004-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260605010620.83004-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/5/2026 4:06 AM, SeongJae Park wrote:
> On Thu, 4 Jun 2026 15:03:36 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> This patch introduces a new DAMON module (SAMPLE_DAMON_HUGEPAGE)
> 
> Could we make the name shorter, to look more consistent with other sample
> modules?  E.g., SAMPLE_DAMON_HPAGE?
> 
OK, I will change the name.
>> which collapses hot regions into huge pages.
>>
>> SAMPLE_DAMON_HUGEPAGE operates in the virtual memory space, for a
>> specific task. The user is expected to supply the PID of the task
>> that is going to be monitored through the monitored_pid module
>> variable.
>>
>> SAMPLE_DAMON_HUGEPAGE uses the hugepage auto-tune mechanism to
>> increase or decrease the aggressiveness of page collapsing. User
>> autotuning is also available for additional tuning aggressiveness
>> control.
>>
>> The module also includes changes to the DAMON compilation, so that
>> the module can be enabled or disabled.
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> ---
>>  mm/damon/Makefile              |   8 +-
>>  samples/damon/Kconfig          |  12 ++
>>  samples/damon/Makefile         |   2 +
>>  samples/damon/hugepage.c (new) | 350 +++++++++++++++++++++++++++++++++
>>  4 files changed, 368 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
>> index d8d6bf5f8bff..16459ce40304 100644
>> --- a/mm/damon/Makefile
>> +++ b/mm/damon/Makefile
>> @@ -1,9 +1,9 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -obj-y				:= core.o
>> +obj-y				:= core.o modules-common.o
>>  obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
>>  obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
>>  obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
>> -obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
>> -obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
>> -obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
>> +obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
>> +obj-$(CONFIG_DAMON_LRU_SORT)	+= lru_sort.o
>> +obj-$(CONFIG_DAMON_STAT)	+= stat.o
> 
> This is for letting the new sample module use the code in ops-common.o, right?
> I'd like to keep sample modules simple and isolated under samples/ directory.
> Could you please make the sample module simpler and remove the above change?
> 
Correct. To be honest, I didn't know it this was the correct way to do it.
Thanks for the feedback, I will just create the context manually in the
module.
>> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
>> index cbf96fd8a8bf..512f150aaabb 100644
>> --- a/samples/damon/Kconfig
>> +++ b/samples/damon/Kconfig
>> @@ -40,4 +40,16 @@ config SAMPLE_DAMON_MTIER
>>  
>>  	  If unsure, say N.
>>  
>> +config SAMPLE_DAMON_HUGEPAGE
>> +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HUGEPAGE)"
> 
> Can this be more consistent with other sample modules?  E.g.,
> 
> DAMON sample module for auto-tuned THP collapsing ?
As mentioned before, I will change the name.
> 
>> +	depends on DAMON && DAMON_VADDR
>> +	help
>> +	  This module monitors a certain PID provided by the user through
>> +	  monitored_pid attribute. Hot regions are determined by DAMON-based
>> +	  sampling. Collapsing occurs according to the quota goal using total
>> +	  memory usage to huge page usage ratio. The ratio is set by the user
>> +	  through a module attribute.
>> +
>> +	  If unsure, say N.
>> +
>>  endmenu
>> diff --git a/samples/damon/Makefile b/samples/damon/Makefile
>> index 72f68cbf422a..f90845faec85 100644
>> --- a/samples/damon/Makefile
>> +++ b/samples/damon/Makefile
>> @@ -3,3 +3,5 @@
>>  obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
>>  obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
>>  obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
>> +obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE)	+= hugepage.o
>> +ccflags-$(CONFIG_SAMPLE_DAMON_HUGEPAGE)	+= -I$(srctree)/mm/damon
> 
> As I mentioned above, let's not mix samples/ with mm/damon/
OK.
>> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
>> new file mode 100644
>> index 000000000000..e24562c92348
>> --- /dev/null
>> +++ b/samples/damon/hugepage.c
>> @@ -0,0 +1,350 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2026 HUAWEI, Inc.
>> + *             https://www.huawei.com
>> + *
>> + * Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> + */
>> +
>> +#define pr_fmt(fmt) "damon-hugepage: " fmt
> 
> Apparently this module's source code is following patterns of reclaim.c and
> lru_sort.c.  That's for non-sample modules.  Could you please rewrite this
> sample module following patterns in sample modules, like that for wsse.c or
> prcl.c ?
> 
Ok, I will do it.
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

