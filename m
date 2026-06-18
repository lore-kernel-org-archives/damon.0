Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BB32B981
	for <damon@lists.linux.dev>; Thu, 18 Jun 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794783; cv=none; b=mfUOLUcZtD2KtvLJCEQb1NxQsSTZoda7fNJRoscQm3qWyq0ydMDxKDmDB30KIYePFsdjYCyJPx2GxQGygZQ6kpCVElyinoj7OlUXyq4KqJSHv4bCDv3hrzhhCibNdXQ5nAqE4lCbW75tA1yUyNyoaGfo8NjSuIxlPb2tNQilZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794783; c=relaxed/simple;
	bh=0oJsuxA5K9lp6zdxJLe1BeL+dp9EJuT+lj7s6fao74c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mXstiUTsBv1wus9Ame8zRkOhW4jSysDyGYKIYDSYusdeR1YlY6VT2Kp7Uz0voMT1iUJtvP4vKmcjT1IRPPznnil5TPzH4ka9F5BtTVcub41WM9yGs8EXkjM1ECDrSYQZgCJefb4oqqQKt11JxQqMv1q8hdkjlY+c2VVLqK9JXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gh3lf4ZKJzJ468c;
	Thu, 18 Jun 2026 22:59:10 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 71FA840575;
	Thu, 18 Jun 2026 22:59:37 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Jun 2026 17:59:36 +0300
Message-ID: <4cefc3af-67eb-4bde-89f6-8c3ea3c93588@huawei-partners.com>
Date: Thu, 18 Jun 2026 17:59:36 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region
 hugepage collapsing
To: SeongJae Park <sj@kernel.org>
CC: <artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260618145734.4477-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260618145734.4477-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/18/2026 5:57 PM, SeongJae Park wrote:
> On Thu, 18 Jun 2026 14:51:42 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> 
>> Hi SJ,
>>
>> On 6/18/2026 3:16 AM, SeongJae Park wrote:
>>> On Tue, 16 Jun 2026 21:04:52 -0700 SeongJae Park <sj@kernel.org> wrote:
>>>
>>>> On Tue, 16 Jun 2026 15:03:15 +0000 <gutierrez.asier@huawei-partners.com> wrote:
>>>>
>>>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>>>>
>>>>> This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
>>>>> which collapses hot regions into huge pages.
>>>
>>> As I mentioned on the previous version of this series, this sample module looks
>>> much better than the initial shape to my humble eyes.  Much smaller and
>>> simpler.  I really appreciate Asier's efforts on making this.
>>>
>>> However... I was asking myself if this module is really needed last night, and
>>> still got not real good and confident answer.
>>>
>>> After all, this is a sample module.  The purpose is to show sample code thhat
>>> helps people understanding how they can use DAMON API.  Maybe we can argue this
>>> module can be helpful at understanding how DAMOS quota goal can be used.  But,
>>> mtier is already showing that.  So I cannot say what new advantage this module
>>> is really bringing.
>> You are right, the main goal was to show how this quota goal can be used. 
>>> Meanwhile, this patch adds ~200 lines of code.  It is a very small and simple
>>> sample module, but still we should maintain it.  I, to be honest, getting
>>> little bit concerned about the maintenance overhead now.
>> I understand your concerns. I know code need maintenance, and DAMON is already
>> growing significantly.
>>> So, if Asier has a good reason to add this module that I'm missing, I'd like to
>>> humbly ask to consider dropping of this module for now.  I'm so sorry for
>>> raising this concern this late.  But, Asier, may I ask what do you think?
>> So, are you suggesting to drop the module and upstreaming only the DAMOS quota
>> goal stuff?> 
> 
> Yes, if you don't mind.
Sure. I will do it a bit later.

Thanks a lot for your help reviewing the code so far.
> 
> Thanks,
> SJ
> 
> [...]
> 

-- 
Asier Gutierrez
Huawei

