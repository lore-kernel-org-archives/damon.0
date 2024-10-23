Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B45588E
	for <damon@lists.linux.dev>; Wed, 23 Oct 2024 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646874; cv=none; b=CK6FeeIosQCvKA7pMH+qrAYQFte+O0WGw/9zGspuz9cj9IbSk7LvMIp1n37FF9p7UrRS1iF/Nc24sGM8PfhnUvbcYYBeMYE7EDCh0vqO9r6PyyUIXuFViX3mN2GCjL5rtg9NIs7t80lBcADFjp/TsKqAIuZpVXl+qeD47ftmZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646874; c=relaxed/simple;
	bh=Cd3w/qucgjkjHi54Wn7fHFRhzvTWQIR73dNejp0ctmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqZg6zmj7LgTX6DcpchhtFiJDgyeO3AO0+lABknr1C+O/H0aH9PvF4q3hxAp3OE4LV2OPaiYeoYs+wZgj1NKHc668/IfZQlIx43RbMocm5fiZQ4qVGq9DbDXKg7ckP5TOVA42xzpdoJyFiBXT1GXHFXq5Bs/yljdbnANLHBN200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYBHR4sbJz4f3jd2
	for <damon@lists.linux.dev>; Wed, 23 Oct 2024 09:27:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1AA631A018C
	for <damon@lists.linux.dev>; Wed, 23 Oct 2024 09:27:49 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8QTURhnBDttEw--.15426S3;
	Wed, 23 Oct 2024 09:27:48 +0800 (CST)
Message-ID: <69dc6dac-b353-b280-4874-68466e817299@huaweicloud.com>
Date: Wed, 23 Oct 2024 09:27:47 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/2] mm/damon/vaddr: Fix issue in
 damon_va_evenly_split_region()
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, foersleo@amazon.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 sieberf@amazon.com, yeweihua4@huawei.com
References: <20241022180537.42492-1-sj@kernel.org>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20241022180537.42492-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHR8QTURhnBDttEw--.15426S3
X-Coremail-Antispam: 1UD129KBjvJXoWrZr47WFy8GF43Xw48trW5Wrg_yoW8JF4Up3
	Z3Wa15tFyvkry8u3Wxua1av3Wkt3y8J345GFyUtrnYkwnYga4ayF1Igw4jk34UCry3C3W2
	va10qFZ3CFn5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/10/23 02:05, SeongJae Park wrote:
> Hi Zheng,
> 
> On Tue, 22 Oct 2024 16:39:25 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
> 
> [...]
>> To fix it, count for each piece split and make sure no more than
>> 'nr_pieces'. In addition, add above case into damon_test_split_evenly().
>>
>> And add 'nr_piece == 1' check in damon_va_evenly_split_region()
>> for better code readability and add a corresponding kunit testcase.
>>
>> Zheng Yejian (2):
>>    mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
>>    mm/damon/vaddr: Check 'nr_piece == 1' case in
>>      damon_va_evenly_split_region()
>>
>>   mm/damon/tests/vaddr-kunit.h | 2 ++
>>   mm/damon/vaddr.c             | 7 +++++--
>>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> Thank you for addressing my comments and posting this new patch series.  I
> added my Reviewed-by: tags with some trivial comments to the patches.
> 

Thanks for your review and comments !

> Btw, at least on DAMON mailing list, we usually post new revisions as new
> threads, rather than as a reply to the previous revision.  If you want to make
> sure involved people aware of the new series, you can send the lore link for
> the new series as a reply to the previous revision.
> 

Got it :)

> 
> Thanks,
> SJ

-- 
Thanks,
Zheng Yejian

