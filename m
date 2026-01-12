Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B08314B7C
	for <damon@lists.linux.dev>; Mon, 12 Jan 2026 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213986; cv=none; b=A61V3mNUg/iB55PbjzOKCBfCD/pmugHvx4YEpffNFaBEgSg/hTd9RCUn3Ed/LAFGFibMALYijiQ4X5HQfBmbkNVot7JCjsemDa1zuomSkhkWDZvVHm5SAuNq69eLQYjWwdSAG0LA8w0XIetnQVjYHdxSvq2jwFxEYz5G11ejUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213986; c=relaxed/simple;
	bh=qlod3jO1d8b5KUjcPCe053EzuqSCLaoZHQyDuQeWWUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YDZ4WNYNcXgq47GTGGaDWXAswyVP6x52ALbYxDAGPlE9NQRQcJLSeIblO+7GHHNMST7W3w8uZ+GxpNsg/rPaHhTn56JAqpsfF58tXfGETgIdg5OST7ND8po7/Zsy+WdeEmO4syqlXKUAfVK2jGmEzyg3PQB9az3V6VYLJdYUKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dqTGn1pKBzJ46F8;
	Mon, 12 Jan 2026 18:32:49 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 772AE40539;
	Mon, 12 Jan 2026 18:33:00 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 13:32:59 +0300
Message-ID: <909dbaad-f0da-4372-a151-a393619da6ec@huawei-partners.com>
Date: Mon, 12 Jan 2026 13:32:59 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
To: JaeJoon Jung <rgbi3307@gmail.com>, SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>
References: <CAHOvCC4FhpLrknhvWbDd=cxaLUyxHFkFxBDYSC3waeg4FC+TBg@mail.gmail.com>
 <20251231045948.77624-1-sj@kernel.org>
 <CAHOvCC6ZPyi=tMK9YhcuWPEzdnTje1ADCWzhs7uJCwHh3SMHpg@mail.gmail.com>
 <CAHOvCC602B=SSU+4HQ-Q6fuFEfxuA08G9zLLQy64gPfMK=mY-Q@mail.gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <CAHOvCC602B=SSU+4HQ-Q6fuFEfxuA08G9zLLQy64gPfMK=mY-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 12/31/2025 10:51 AM, JaeJoon Jung wrote:
> On Wed, 31 Dec 2025 at 15:10, JaeJoon Jung <rgbi3307@gmail.com> wrote:
>>
>> On Wed, 31 Dec 2025 at 13:59, SeongJae Park <sj@kernel.org> wrote:
>>>
>>> On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>>>
>>>> On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
>>>>>
>>>>> Hello Asier,
>>>>>
>>>>>
>>>>> Thank you for sending this patch!
>>>>>
>>>>> On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
>>>>>
>>>>>> This is a minor patch set for a call_controls_lock synchronization improvement.
>>>>>
>>>>> Please break description lines to not exceed 75 characters per line.
>>>>>
>>>>>>
>>>>>> Spinlocks are faster than mutexes, even when the mutex takes the fast
>>>>>> path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
>>>>>
>>>>> But call_controls_lock is not being used on performance critical part.
>>>>> Actually, most of DAMON code is not performance critical.  I really appreciate
>>>>> your patch, but I have to say I don't think this change is really needed now.
>>>>> Please let me know if I'm missing something.
>>>>
>>>> Paradoxically, when it comes to locking, spin_lock is better than
>>>> mutex_lock
>>>> because "most of DAMON code is not performance critical."
>>>>
>>>> DAMON code only accesses the ctx belonging to kdamond itself. For
>>>> example:
>>>> kdamond.0 --> ctx.0
>>>> kdamond.1 --> ctx.1
>>>> kdamond.2 --> ctx.2
>>>> kdamond.# --> ctx.#
>>>>
>>>> There is no cross-approach as shown below:
>>>> kdamond.0 --> ctx.1
>>>> kdamond.1 --> ctx.2
>>>> kdamond.2 --> ctx.0
>>>>
>>>> Only the data belonging to kdamond needs to be resolved for concurrent access.
>>>> most DAMON code needs to lock/unlock briefly when add/del linked
>>>> lists,
>>>> so spin_lock is effective.
>>>
>>> I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
>>> locking usages.
>>>
>>>> If you handle it with a mutex, it becomes
>>>> more
>>>> complicated because the rescheduling occurs as a context switch occurs
>>>> inside the kernel.
>>>
>>> Can you please elaborate what kind of complexities you are saying about?
>>> Adding some examples would be nice.
>>>
>>>> Moreover, since the call_controls_lock that is
>>>> currently
>>>> being raised as a problem only occurs in two places, the kdamon_call()
>>>> loop
>>>> and the damon_call() function, it is effective to handle it with a
>>>> spin_lock
>>>> as shown below.
>>>>
>>>> @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
>>>> damon_call_control *control)
>>>>         control->canceled = false;
>>>>         INIT_LIST_HEAD(&control->list);
>>>>
>>>> -       mutex_lock(&ctx->call_controls_lock);
>>>> +       spin_lock(&ctx->call_controls_lock);
>>>> +       /* damon_is_running */
>>>>         if (ctx->kdamond) {
>>>>                 list_add_tail(&control->list, &ctx->call_controls);
>>>>         } else {
>>>> -               mutex_unlock(&ctx->call_controls_lock);
>>>> +               spin_unlock(&ctx->call_controls_lock);
>>>>                 return -EINVAL;
>>>>         }
>>>> -       mutex_unlock(&ctx->call_controls_lock);
>>>> +       spin_unlock(&ctx->call_controls_lock);
>>>>
>>>>         if (control->repeat)
>>>>                 return 0;
>>>
>>> Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
>>> Can you please elaborate why you think so?
>>>
>>> [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
>>>
>>
>> The above code works fine with spin_lock.  However, when booting the kernel,
>> the spin_lock call trace from damon_call() is output as follows:
>> If you have any experience with the following, please share it.
>>
>> [    0.834450] Call Trace:
>> [    0.834456] [<ffffffff8001b376>] dump_backtrace+0x1c/0x24
>> [    0.834471] [<ffffffff800024e0>] show_stack+0x28/0x34
>> [    0.834480] [<ffffffff80014f4c>] dump_stack_lvl+0x48/0x66
>> [    0.834493] [<ffffffff80014f7e>] dump_stack+0x14/0x1c
>> [    0.834503] [<ffffffff800032c6>] spin_dump+0x62/0x6e
>> [    0.834511] [<ffffffff80087376>] do_raw_spin_lock+0xd0/0x128
>> [    0.834523] [<ffffffff80de9378>] _raw_spin_lock+0x1a/0x22
>> [    0.834538] [<ffffffff80255c0c>] damon_call+0x38/0x100
>> [    0.834548] [<ffffffff8025f022>] damon_stat_start+0x10e/0x168
>> [    0.834558] [<ffffffff80e21ab4>] damon_stat_init+0x2a/0x44
>> [    0.834568] [<ffffffff800157c0>] do_one_initcall+0x40/0x202
>> [    0.834579] [<ffffffff80e015f6>] kernel_init_freeable+0x1fc/0x27e
>> [    0.834588] [<ffffffff80de0a9e>] kernel_init+0x1e/0x13c
>> [    0.834599] [<ffffffff8001716a>] ret_from_fork_kernel+0x10/0xf8
>> [    0.834607] [<ffffffff80deab22>] ret_from_fork_kernel_asm+0x16/0x18
>> [    0.943407] NFS: Registering the id_resolver key type
>> [    0.948996] Key type id_resolver registered
>> [    0.953614] Key type id_legacy registered
> 
> The above occurred because spin_lock_init() was not performed.  The problem
> is that spin_lock_init() was not added while deleting mutex_init().
> Please refer to the contents below.
> 
> @@ -539,6 +539,7 @@ struct damon_ctx *damon_new_ctx(void)
> 
>         mutex_init(&ctx->kdamond_lock);
>         INIT_LIST_HEAD(&ctx->call_controls);
> -       mutex_init(&ctx->call_controls_lock);
> +       spin_lock_init(&ctx->call_controls_lock);

Right, my bad.

I can submit a new updated patch with this small change. However,
I believe, as discussed before, that the improvement in general will 
be small and it may not be worth it.

>         mutex_init(&ctx->walk_control_lock);
> 
>         ctx->attrs.min_nr_regions = 10;
> 
>>
>> Thanks,
>> JaeJoon
>>
>>>
>>> Thanks,
>>> SJ
>>>
>>> [...]
> 

-- 
Asier Gutierrez
Huawei

