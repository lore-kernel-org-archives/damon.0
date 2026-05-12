Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021073A05EB
	for <damon@lists.linux.dev>; Tue, 12 May 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594380; cv=none; b=udCjSNzcUk9aifSriRYysV7cpQEH4ZDF293dLr0N60ISkgGy7oop8T+f1fRF65po8qr+D+a6biyNQLFf1Hutto5HaXPvFizetsQMet+tX4JwGzMQVOJ7puLlvuto6e6CgAEeXyPcPoPwpwzLlE6baLniG9E0B+rfi2Y4jXpc/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594380; c=relaxed/simple;
	bh=6rwi5Oyq1EeQUFIxFWOFOXFySDtgPAJDCKpAx1QkZkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B/uvmJp5RuR/uz87oMdadOAkH/dkfGbwQpDSwI9xCud2vaN0373rbc3CX8YVtOxRQVseLoRGVie6M72R6OsO7b/J32mbrBnLP51O81T9HLzsCAMyneii3L6iyvHhYfLk+f1tpV5Fk1uVXDCCWQCCQI+ym45MZhktD0vTzXeBFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BZh00c5k; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BZh00c5k"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xjBHpnrtr7TLQ5ApPzHZqIHU3mdRNFOc4hxIvr8BBVw=;
	b=BZh00c5kQpek7iEJf+pa1l7R5vnaN0BHDZahQdoGUW2q8mJtx42R7I4CAjy3+YKGirlEmmH4I
	tem5nRl57aI+6No+0FGmkRDT2Q7zyI58mNmxRswVrE7OvmwTpw3DweyoNcdDsX0xTZX6f876k1N
	sEeCR90d1G6g1/V8mZfCZK0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gFJ1n0nHnzpStD;
	Tue, 12 May 2026 21:52:29 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D04D40561;
	Tue, 12 May 2026 21:59:29 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 21:59:28 +0800
Message-ID: <618380f2-ea7b-4855-9dc5-d655dc30d5a7@huawei.com>
Date: Tue, 12 May 2026 21:59:26 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/vaddr: attempt per-vma lock during page table
 walk
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <sunnanyong@huawei.com>
References: <20260512013116.80435-1-sj@kernel.org>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20260512013116.80435-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 5/12/2026 9:31 AM, SeongJae Park wrote:
> On Mon, 11 May 2026 21:25:46 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
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
> Makes sense.  Do you have some measurements?

In fact, I do not have performance-related tests.

> 
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Looks good to me.  Nonetheless, because I'm not familiar with per-vma locking,
> I'd like to wait for Sashiko review.
> 

Sashiko review reports a issue about handling VMAs with the VM_PFNMAP
flag inconsistently[1]，We indeed do not need to handle the vma of
VM_PFNMAP for damon, so a quick fix is as follows,

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index eed2ae132a58..d27147603564 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -251,8 +251,11 @@ static void damon_va_walk_page_range(struct 
mm_struct *mm, unsigned long start,
                 goto lock_mmap;
         }

-       ops->walk_lock = PGWALK_VMA_RDLOCK_VERIFY;
-       walk_page_range_vma(vma, start, end, ops, private);
+       if (!(vma->vm_flags & VM_PFNMAP)) {
+               ops->walk_lock = PGWALK_VMA_RDLOCK_VERIFY;
+               walk_page_range_vma(vma, start, end, ops, private);
+       }
+
         vma_end_read(vma);
         return;

Any more comments?

Thanks.

[1] 
https://sashiko.dev/#/patchset/20260511132546.1973270-1-wangkefeng.wang@huawei.com?part=1
> 
> Thanks,
> SJ
> 
> [...]
> 

