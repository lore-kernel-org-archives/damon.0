Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702241C6FEC
	for <damon@lists.linux.dev>; Sat, 26 Jul 2025 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753499680; cv=none; b=cTRbBYxGmQVg0xx4pzVWjJ3eFi+O6i/TWFRXgquXtXFd01OIo4q5Q8h+VUOYVflxajs/W4FOuzZ71c4Q0MuqXHaRQQ+nAgPEES1q8sUyTvRRXPlcPhKKAjUi0ETyd99VowUm7uLxT2rkX4l2RnMSqkeuDmFATN2HbkHTVjUOnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753499680; c=relaxed/simple;
	bh=PXOmPmOIuPV6jG6NLMOF//C5D3ADCH0pr64KuDzWutw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TCemtXMuhgxPgZ277Qc0VN67mF93IqKAj+A6Gje9GhKQabM/7jO7V0+Xnum8oQDBdhsoAmznX9y7eTFXxvdTiC988UpgPRv4OxRGOYXQXbruvtXaTEtvOoNOUXlGdzO9XLpJGpllwXjtmpnmHGHy7zAi4R/lMbBPZ3wziCrq+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bpqZ52ypfztSkl;
	Sat, 26 Jul 2025 11:13:17 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id E666B18047C;
	Sat, 26 Jul 2025 11:14:20 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 11:14:20 +0800
Message-ID: <527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com>
Date: Sat, 26 Jul 2025 11:14:19 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring
 above 4GB
To: SeongJae Park <sj@kernel.org>, zuoze <zuoze1@huawei.com>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>
References: <20250725202230.49995-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250725202230.49995-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/7/26 4:22, SeongJae Park 写道:
> On Fri, 25 Jul 2025 11:15:22 +0800 zuoze <zuoze1@huawei.com> wrote:
>
>>
>> 在 2025/4/23 1:43, SeongJae Park 写道:
>>> On Tue, 22 Apr 2025 19:50:11 +0800 zuoze <zuoze1@huawei.com> wrote:
>>>
>>> [...]
>>>> Thanks for the patches - I’ve noted the RFC series and user-space
>>>> updates. Apologies for the delay; I’ll prioritize reviewing these soon
>>>> to verify they meet the intended tracking goals. Appreciate your
>>>> patience.
>>> No worry.  Please take your time and let me know if there is anything I can
>>> help.
>>>
>>> I think we can improve the user-space tool support better for usability.  For
>>> example, it could find LPAE case, set addr_unit parameter, and convert
>>> user-input and output address ranges on its own.  But hopefully the current
>>> support allows simple tests of the kernel side change, and we could do such
>>> improvement after the kernel side change is made.
>>>
>>>
>> Hi SJ,
>>
>> Apologies for the delayed response. We've verified your patch in our
>> environment and confirmed it supports LPAE address monitoring.
> No worry, thank you for testing that :)
>
>> However,
>> we observed some anomalies in the reclaim functionality. During code
>> review, we identified a few issues:
>>
>> The semantic meaning of damon_region changed after addr_unit was
>> introduced. The units in damon_addr_range may no longer represent bytes
>> directly.
> You're right, and this is an intended change.
>
>> The size returned by damon_sz_region() now requires multiplication by
>> addr_unit to get the actual byte count.
> Again, this is an intended change.  damon_sz_region() callers should aware this
> semantic and updated accordingly, if it could make a real problem otherwise.
> If you found such changes required cases that this patch series is missing,
> could you please list up?
>
>> Heavy usage of damon_sz_region() and DAMON_MIN_REGION likely requires
>> addr_unit-aware adjustments throughout the codebase. While this approach
>> works, it would involve considerable changes.
> It has been a while since I wrote this patch series, but at least while writing
> it, I didn't find such required changes.  Of course I should missed something,
> though.  As I mentioned above, could you please list such changes required
> parts that makes problem?  That would be helpful at finding the path forward.
>
>> What's your perspective on
>> how we should proceed?
> Let's see the list of required additional changes with why those are required
> (what problems can happen if such chadnges are not made), and discuss.

Hi SJ,

Thank you for your email reply. Let's discuss the impacts introduced after
incorporating addr_unit. First of all, it's essential to clarify that the
definition of damon_addr_range (in damon_region) has changed, we will now use
damon_addr_range * addr_unit to calculate physical addresses.

I've noticed some issues, in mm/damon/core.c:

  damos_apply_scheme()
      ...
      unsigned long sz = damon_sz_region(r);  // the unit of 'sz' is no longer bytes.
      ...
      if (c->ops.apply_scheme)
          if (quota->esz && quota->charged_sz + sz > quota->esz)
              sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
                      DAMON_MIN_REGION);  // the core issue lies here.
          ...
          quota->charged_sz += sz;    // note the units.
      ...
      update_stat:
          // 'sz' should be multiplied by addr_unit:
          damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);

Currently, DAMON_MIN_REGION is defined as PAGE_SIZE, therefore aligning
sz downward to DAMON_MIN_REGION is likely unreasonable. Meanwhile, the unit
of sz in damos_quota is also not bytes, which necessitates updates to comments
and user documentation. Additionally, the calculation involving DAMON_MIN_REGION
requires reconsideration. Here are a few examples:

  damos_skip_charged_region()
      ...
      sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
                      r->ar.start, DAMON_MIN_REGION);
      ...
      if (damon_sz_region(r) <= DAMON_MIN_REGION)
                      return true;
      sz_to_skip = DAMON_MIN_REGION;

  damon_region_sz_limit()
        ...
      if (sz < DAMON_MIN_REGION)
          sz = DAMON_MIN_REGION;

Now I can think of two approaches, one is to keep sz in bytes, this requires
modifications to many other call sites that use these two functions (at least
passing the corresponding ctx->addr_unit. By the way, should we restrict the
input of addr_unit?):

  damos_apply_scheme()
      ...
  -    unsigned long sz = damon_sz_region(r);
  +    unsigned long sz = damon_sz_region(r) * c->addr_unit;
      ...
  -    damon_split_region_at(t, r, sz);
  +    damon_split_region_at(t, r, sz / c->addr_unit);

The second approach is to divide by addr_unit when applying DAMON_MIN_REGION,
and revert to byte units for statistics, this approach seems to involve
significant changes as well:

  damos_apply_scheme()
      ...
      sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
  -                    DAMON_MIN_REGION);
  +                    DAMON_MIN_REGION / c->addr_unit);
      ...
  update_stat:
  -    damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
  +    damos_update_stat(s, sz, sz_applied * c->addr_unit, sz_ops_filter_passed);

These are my observations. What's your perspective on how we should proceed? Looking
forward to your reply.

Thanks,
Quanmin Yan

>
>
> Thanks,
> SJ
>
> [...]
