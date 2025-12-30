Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43624113D
	for <damon@lists.linux.dev>; Tue, 30 Dec 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085357; cv=none; b=AlOs8zkTPvTSJmLHCc1rbUUGAxzZvPqb7+nGlzlXoGf3NTE/NPeg2O53wWnGtQQrFCg658/XQtEjD52DL+nQOAsFP3h/zF0NYTwdH+nTpIke0USyFXOQ4Avk8YoCCNGx92ojM51WoxyaLYYd19pH2oTyPY3QFQv5zzlaXvzUcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085357; c=relaxed/simple;
	bh=oIHIw9R92ThylUY5a6yUj28fPzrkw+/rollyJxFxpqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lKGuVAZRs0YZRmzt9sJWsAD0PBwwTGuYmOOxi4bQdHinehotmMpQOV/Gl/ghtT6PA1No2Sl8on5g8Lxo7JvdB9wXwh4LzN/+i1vf84wQT7+gQCs3UDk8gcNYgRuq6VouS+hKI4lE1j9NW6GDjeIgMvmE0nkzZLvLCZnfsVb1rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dgRsd6mtDzJ46fG;
	Tue, 30 Dec 2025 17:01:41 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 4021940565;
	Tue, 30 Dec 2025 17:02:32 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 12:02:31 +0300
Message-ID: <4b367446-2248-4936-99b6-e9ee93298eb5@huawei-partners.com>
Date: Tue, 30 Dec 2025 12:02:31 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>
References: <20251229152250.78975-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20251229152250.78975-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 12/29/2025 6:22 PM, SeongJae Park wrote:
> Hello Asier,

Hi SeongJae,

> 
> Thank you for sending this patch!
> 
> On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> 
>> This is a minor patch set for a call_controls_lock synchronization improvement.
> 
> Please break description lines to not exceed 75 characters per line.
> 
>>
>> Spinlocks are faster than mutexes, even when the mutex takes the fast
>> path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> 
> But call_controls_lock is not being used on performance critical part.
> Actually, most of DAMON code is not performance critical.  I really appreciate
> your patch, but I have to say I don't think this change is really needed now.
> Please let me know if I'm missing something.

I was just reviewing the code and I noticed this. Yes, you are right, the performance 
is not critical.

>>
>> Initial benchmarking shows the following results
>>
>>
>> # bpftrace -e 'kprobe:kdamond_call { @start[tid] = nsecs; }
> 
> Commit log shouldn't start with '#'.  Please consider indenting the above
> command and below outputs of it.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

Thanks a lot for the review!

-- 
Asier Gutierrez
Huawei

