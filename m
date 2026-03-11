Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E62E4257
	for <damon@lists.linux.dev>; Wed, 11 Mar 2026 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234678; cv=none; b=rn58yLhZ0kr6lUPhKKCfUaEEl03BX4sJpaVZ9v4ovTUCwYVyJW2EOSIX565OmaSlkziWshaU99GnMZj9LlDZea/0ar4i0OrkKQL0/RCK+FPB6Gc61oKiBaLLXJP0rJJ5bqgTkraLbmORUg4N71ponUH01R5ddpBO6w4z4fLzjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234678; c=relaxed/simple;
	bh=R4WSLec3kNaoCTi/RDjqiyY0W6wWpnHoxb7mZ0ae5gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OdYJixQKKQzeUe66iW1om3+4hkOT22Blrmk8s9rNenAif1dkDX85m6EPgNXRQQeGIcmF/Lo2VsDoP65E2wrwGwY5JI2XVlDMhd7pUuf5TFY7HgTXUT/46k1cAA129QiIHci0iBjB3FFFs2Y0+6lW9O1DNYiNBlEJV5RD9ZgUmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWB1v2vZKzJ46Yd;
	Wed, 11 Mar 2026 21:10:27 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id A1FA440086;
	Wed, 11 Mar 2026 21:11:13 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 16:11:13 +0300
Message-ID: <0c3068da-4dcb-4bc7-a762-2f529cb5abc2@huawei-partners.com>
Date: Wed, 11 Mar 2026 16:11:12 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] mm/damon: Support for synchrounous huge pages
 collapse
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260311010222.90548-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260311010222.90548-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 3/11/2026 4:02 AM, SeongJae Park wrote:
> On Tue, 10 Mar 2026 16:24:18 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Please add more descriptions of the change, including the motivation.
> 
> I assume the motivation is similar to MADV_COLLAPSE that aims to make
> synchronous and therefore faster huge page collapsing impacts copared to
> MADV_HUGEPAGE?  It would be nice to make it clear here.  Also, if my assumption
> is not wrong, adding a test results showing the benefit of DAMOS_COLLAPSE over
> DAMOS_HUGEPAGE here would be nice.

You are right. I will make it more clear in the cover letter for the next
version.

> 
>>
>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
>> ---
>>  include/linux/damon.h | 1 +
>>  mm/damon/vaddr.c      | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index a4fea23da857..a9cf17b9e8fa 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -142,6 +142,7 @@ enum damos_action {
>>  	DAMOS_LRU_DEPRIO,
>>  	DAMOS_MIGRATE_HOT,
>>  	DAMOS_MIGRATE_COLD,
>> +	DAMOS_COLLAPSE,
>>  	DAMOS_STAT,		/* Do nothing but only record the stat */
>>  	NR_DAMOS_ACTIONS,
>>  };
>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>> index 729b7ffd3565..36791a9a1094 100644
>> --- a/mm/damon/vaddr.c
>> +++ b/mm/damon/vaddr.c
>> @@ -969,6 +969,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
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
> The code looks good to me.
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

