Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8938736B
	for <damon@lists.linux.dev>; Thu, 14 May 2026 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757237; cv=none; b=G8E4XVzOZZl2ZDkfYKzsBJeIMgjVUK3596ZkDZPlS6/YquGhe7vARrmGftrdAzhIDT6wZz64WPFDH5j/JNo+6XoZR/jY/I+67Zis1mRNGIreyHw2qL46eeNPS0x7/veq47uHrkrbPRNGcQf2adey+ids6OfqBDGoXshx+yw1Xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757237; c=relaxed/simple;
	bh=mI7I50FIU5lLHeY8TFWR+Fx85LdzY8k0K3HoOj7zZBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XVCve3Ch8rrVStY0YF5bKYZNELMAWiuLG6ypU1/KWzgdp+JJ6X/xYq20OudFWEXDCVEm2tYT3V7wvQe6JZlEEYUcoDogmizc2eQ1LCNHxb8nAbK7d7kQD2SW9HO3X4a5qnVMQtIOFlOoRwrj7FsRTY9Bz+m1U/xq3YinY070POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3UhhzCy4; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3UhhzCy4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eLdzmnS4HlCcjbg1+JnOr4mOcjOgGssYgMzS57rsRiw=;
	b=3UhhzCy4h7tYEBC4ieDPO7HikB2GMa+xGd27ppz7l/FFfoM4wwTFEaqkBvQODZkW4gM/e0hz3
	QikUtC5RTb6uT/+gVbxjaQegM1Na57rlVEO+nIT35NMvN+cr0RcHJ3wWOtZDMMuitveu/Fe531/
	RSIf97Cln71haEAeiTAKTOU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gGSDy0YH8z1cyPt;
	Thu, 14 May 2026 19:06:10 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 9060F402AB;
	Thu, 14 May 2026 19:13:46 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 May 2026 19:13:45 +0800
Message-ID: <f98b2773-cf0c-4e63-a600-76e79755a336@huawei.com>
Date: Thu, 14 May 2026 19:13:44 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/damon/vaddr: attempt per-vma lock during page table
 walk
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <sunnanyong@huawei.com>
References: <20260514020059.149541-1-sj@kernel.org>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20260514020059.149541-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 5/14/2026 10:00 AM, SeongJae Park wrote:
> On Tue, 12 May 2026 23:15:23 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> Currently, DAMON virtual address operations use mmap_read_lock
>> during page table walks, which can cause unnecessary contention
>> under high concurrency.
>>
>> Introduce damon_va_walk_page_range() to first attempt acquiring a
>> per-vma lock. If the VMA is found and the range is fully contained
>> within it, the page table walk proceeds with the per-vma lock
>> instead of mmap_read_lock.
>>
>> This optimization is particularly effective for damon_va_young()
>> and damon_va_mkold(), which are frequently called and typically
>> operate within a single VMA.
> 
> Maybe this is not only making DAMON faster, but avoid DAMON blocking others.
> 
Yes, this is exactly what per-vma is for.


> And because we don't have performance measurements, how about making this
> sentence less assertive?  E.g., "This optimization is particularly expected to
> be effective for ..."

Fine to me.

> 
> I guess Andrew could make the adjustment when he picks this into mm.git.  If
> not I will repost this with the trivial change if you don't mind.
> 
>>

Sure

>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 

Thanks

>> ---
>> v2: avoid handling VMAs with the VM_PFNMAP for per-vma path, found by
>>      Sashiko review.
> 
> This patch helped Sashiko finding [1] yet another DAMON bug (impact is minor
> imho).  The bug is orthogonal to this patch so there is no blocker for this
> patch.
> 
>> v1: https://lore.kernel.org/linux-mm/20260511132546.1973270-1-wangkefeng.wang@huawei.com/
> 
> [1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

