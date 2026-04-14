Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF743396D28
	for <damon@lists.linux.dev>; Tue, 14 Apr 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164908; cv=none; b=ehe+tZDP+X+3h/z9iAG/EbzDKH/B9Jep2MAaBE4LpEgo09yGaaAY7WqWT3V4LtSu5DFW4fDBiXESZFtXLkSrfLRpDXiZji/b4ExZm0/nGHigozN7StsN0B74BUcoWrBjk/9GIQ2tIDm4V0zd2yNkN1fPy6Sx/OE5BTwzlK4m+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164908; c=relaxed/simple;
	bh=w1EI/5IsvIZb+F/Exu+h+7SitWNsnrwn5ZEYV7wje7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rp2tZIYBecXxY3qKaXuU/qz8md9gSDdkEf1/oKVL/TX6DCoCNGAyeA9579KdgCDMP8zsUNgwEvOXO4f1plIIvvapXNO+Tv0BUTHrvDNat72hWODXSqvoay6RQM0VTs/LyvO26UmTlA4TUN5EWkq6VVNksS/qquDtmIKH71Hq+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fw1j46KR5zHnGgW;
	Tue, 14 Apr 2026 19:08:08 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id CF6ED40569;
	Tue, 14 Apr 2026 19:08:22 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 14:08:22 +0300
Message-ID: <90f923fd-a521-44d8-9d7d-d137b0119002@huawei-partners.com>
Date: Tue, 14 Apr 2026 14:08:21 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] mm/damon: generalize ctx_target creation for
 damon_ops_id and add vaddr support
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260414004739.83961-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260414004739.83961-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 4/14/2026 3:47 AM, SeongJae Park wrote:
> On Mon, 13 Apr 2026 14:59:43 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> This patch adds a new function damon_modules_new_vaddr_ctx_target.
>> Since ctx_target creation for vaddr and paddr is almost identical,
>> the logic is extracted to a new function,
>> damon_modules_new_ctx_target, and vaddr and paddr functions are left
>> just as interfaces.
>>
>> This change was suggested earlier[1] and it is needed to allow
>> developers to create DAMON modules that use DAMON_OPS_PADDR targets.
> 
> You mean DAMON_OPS_VADDR?

Right, I missed that.
 
> And I agree this can be useful if we will make a DAMON module that runs for
> virtual address spaces.  But we don't add new functions without their callers.
> So this patch should be submitted only together with the caller of the
> function.

Fair enough. I will carry on working on the module for hugepages autotuning,
which will use this function. I will resubmit this along with the caller.

>>
>> [1]: https://lore.kernel.org/damon/20260311005759.90440-1-sj@kernel.org/
> 
> 
> Thanks,
> SJ
> 
> [...]

-- 
Asier Gutierrez
Huawei

