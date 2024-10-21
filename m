Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0541C6E
	for <damon@lists.linux.dev>; Mon, 21 Oct 2024 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482972; cv=none; b=G78DBXFj39mJsOjrsZHThzuJeNTD7RJdCl8eCd4nzTCXfKfJ0bGI2CzbNCliYmKTwqXDNVMLs6I7O6JTQ9gUvNvD9lWoHCnH9+Os51OR8bymSx0Qk9VZwrnnILisENmwefsL3/9QKHy2dpSSFY8UsYSifS7X1QyJwdDA1ZAq910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482972; c=relaxed/simple;
	bh=kBqCZzbNxcL+xsaUefm00m5wwFJMJrBOEZgyIDb/0Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhnGHppGF2ZZ6W82UejQX3/yWvWOrATQGPsqSICcr8yctd/A1szEwZUENFmP4iiOaSm5O+5mP0dxg/Ru80s+8fkvfzKC1QfCTsrtQx5KCHeBcjj8+1pqNVDTINJEyRNjxLvH5v9n1HmyFiKw7L2baJD7Q/ChjFD8IbwboiSvFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XX1gS1qn6z4f3jR6
	for <damon@lists.linux.dev>; Mon, 21 Oct 2024 11:55:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 93B861A06D7
	for <damon@lists.linux.dev>; Mon, 21 Oct 2024 11:56:05 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8fU0BVnymy6Eg--.5509S3;
	Mon, 21 Oct 2024 11:56:05 +0800 (CST)
Message-ID: <186f770b-925f-3541-2ca7-fa6ee6f0caf6@huaweicloud.com>
Date: Mon, 21 Oct 2024 11:56:04 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/damon/vaddr: Fix issue in
 damon_va_evenly_split_region()
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, sieberf@amazon.com, shakeel.butt@linux.dev,
 foersleo@amazon.de, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ye Weihua <yeweihua4@huawei.com>
References: <20241018183310.115850-1-sj@kernel.org>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20241018183310.115850-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH+8fU0BVnymy6Eg--.5509S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3CF4fGryxWryfGF17KFg_yoWxtr45p3
	93WFWfKF4ktFyIv3ZxZ3Z5ZrnayrW8tr1UGryfJF18tF1vgFyDKFWUJ3yYyFyUuFWxZa1r
	Z3W0qrZxWF98Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/10/19 02:33, SeongJae Park wrote:
> Hi Zheng,
> 
> 
> Thank you for sharing this nice finding and fix!  I have a few comments below.
> 

Thanks for your review!

> On Fri, 18 Oct 2024 11:53:04 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
> 
>> According to the logic of damon_va_evenly_split_region(), currently at
>> least following split cases would not meet the expectation:
>>
>>    Suppose DAMON_MIN_REGION=0x1000,
>>    Case1: Split [0x0, 0x1100) into 1 pieces, then the result would be
>>           acutually [0x0, 0x1000), but NOT the expected [0x0, 0x1100) !!!
> 
> Nice finding!  However, as long as DAMON_MIN_REGION is respected, [0x0, 0x1100]
> region could not be created.  So, the problematic case cannot happen in real?
> Please let me know if I'm missing something.

Currently when DAMON_MIN_REGION is defined as PAGE_SIZE, and both vm start
and end are commonly page-aligned, then the [0x, 0x1100) could not be created,
but I'm not sure either.

> 
> And, why would someone call the function with nr_pieces 1?
> 

damon_va_evenly_split_region() is called in __damon_va_init_regions(), and nr_pieces
is calculated by:

   `nr_pieces = (regions[i].end - regions[i].start) / sz;`

Above regions[i].start/regions[i].end/sz is determine at runtime, and sz can beaffected
by minimum number of regions, user can change that, am I right? Then nr_pieces can be 1 !
On the other hand, I think damon_va_evenly_split_region() itself should handle
the 'nr_pieces == 1' case, or if we make sure that case is unreal, would it be better to
add some assertion?

>>    Case2: Split [0x0, 0x3000) into 2 pieces, then the result would be
>>           acutually 3 regions:
>>             [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
>>           but NOT the expected 2 regions:
>>             [0x0, 0x1000), [0x1000, 0x3000) !!!
> 
> Nice finding!
> 
>>
>> The root cause is that when calculating size of each split piece in
>> damon_va_evenly_split_region():
>>
>>    `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`
>>
>> both the dividing and the ALIGN_DOWN may cause loss of precision,
>> then each time split one piece of size 'sz_piece' from origin 'start' to
>> 'end' would cause:
>>    1. For the above Case1, the 'end' value of the split 1 piece is
>>       aligned but not updated!!!
>>    2. For the above Case2, more pieces are split out than expected!!!
>>
>> To fix it, in this patch:
>> - As for the expect to split 1 piece, just return 0;
> 
> As mentioned above, I think this is not needed, since the problematic case is
> unreal.

I think this case exists, as above reply.

> 
>> - Count for each piece split and make sure no more than 'nr_pieces';
>> - Add above two cases into damon_test_split_evenly().
> 
> Thank you for adding tests!
> 
>>
>> BTW, currently when running kunit test, DAMON_MIN_REGION is redefined
>> as 1, then above ALIGN_DOWN cases may not be test, since every int
>> value is ALIGN-ed to 1.
>>
>> After this patch, damon-operations test passed:
>>
>>   # ./tools/testing/kunit/kunit.py run damon-operations
>>   [...]
>>   ============== damon-operations (6 subtests) ===============
>>   [PASSED] damon_test_three_regions_in_vmas
>>   [PASSED] damon_test_apply_three_regions1
>>   [PASSED] damon_test_apply_three_regions2
>>   [PASSED] damon_test_apply_three_regions3
>>   [PASSED] damon_test_apply_three_regions4
>>   [PASSED] damon_test_split_evenly
>>   ================ [PASSED] damon-operations =================
>>
>> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
>> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
>> ---
>>   mm/damon/tests/vaddr-kunit.h |  2 ++
>>   mm/damon/vaddr.c             | 13 +++++++++----
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
>> index a339d117150f..b9a03e4e29e5 100644
>> --- a/mm/damon/tests/vaddr-kunit.h
>> +++ b/mm/damon/tests/vaddr-kunit.h
>> @@ -300,6 +300,8 @@ static void damon_test_split_evenly(struct kunit *test)
>>   	damon_test_split_evenly_fail(test, 0, 100, 0);
>>   	damon_test_split_evenly_succ(test, 0, 100, 10);
>>   	damon_test_split_evenly_succ(test, 5, 59, 5);
>> +	damon_test_split_evenly_succ(test, 4, 6, 1);
> 
> If my above assumption (the first problem is unreal) is not wrong, maybe this
> test is not needed?
> 

As an unit test, damon_va_evenly_split_region() itself should be able
to handle the 'nr_pieces == 1' case, right? I think this testcase can
be added in case something goes wrong one day.

>> +	damon_test_split_evenly_succ(test, 0, 3, 2);
> 
> Nice.
> 
>>   	damon_test_split_evenly_fail(test, 5, 6, 2);
>>   }
>>   
>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>> index 08cfd22b5249..1f3cebd20829 100644
>> --- a/mm/damon/vaddr.c
>> +++ b/mm/damon/vaddr.c
>> @@ -67,10 +67,14 @@ static int damon_va_evenly_split_region(struct damon_target *t,
>>   	unsigned long sz_orig, sz_piece, orig_end;
>>   	struct damon_region *n = NULL, *next;
>>   	unsigned long start;
>> +	int i;
> 
> Purpose of this variable is counting the number of splitted regions, and
> comparing it against 'nr_pieces', right?  Because nr_pieces is 'unsigned int',
> let's make this 'unsigned int' type, too.
> 

Well, yes, I'll do it in v2 after all the discussions for this version are complete!

>>   
>>   	if (!r || !nr_pieces)
>>   		return -EINVAL;
>>   
>> +	if (nr_pieces == 1)
>> +		return 0;
>> +
> 
> As mentioned above, I don't think this is not needed.
> 



>>   	orig_end = r->ar.end;
>>   	sz_orig = damon_sz_region(r);
>>   	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
>> @@ -79,9 +83,11 @@ static int damon_va_evenly_split_region(struct damon_target *t,
>>   		return -EINVAL;
>>   
>>   	r->ar.end = r->ar.start + sz_piece;
>> +	/* origin region will be updated as the first one after splitting */
> 
> I don't think this comment is easy to understand.  Let's just remove it.
> 

Thanks, I'll remove it in next version!

>> +	i = 1;
>> +	n = r;
> 
> Why we need this? for 'nr_pieces == 1' case?  If so, I don't think we need to
> take care about the case for the above mentioned reason.  Please let me know if
> I'm missing something.

Yes, this is for 'nr_pieces == 1' case, and if we have above `if (nr_pieces == 1) return 0;` line,
then this is not needed since nr_pieces > 1, and following loop will at least two times

> 
>>   	next = damon_next_region(r);
>> -	for (start = r->ar.end; start + sz_piece <= orig_end;
>> -			start += sz_piece) {
>> +	for (start = r->ar.end; i < nr_pieces; start += sz_piece, i++) {
>>   		n = damon_new_region(start, start + sz_piece);
>>   		if (!n)
>>   			return -ENOMEM;
>> @@ -89,8 +95,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
>>   		r = n;
>>   	}
>>   	/* complement last region for possible rounding error */
>> -	if (n)
>> -		n->ar.end = orig_end;
>> +	n->ar.end = orig_end;
> 
> Maybe this change is related with the above 'n = r' line?  But, I don't think
> we need that, as commented there.

Yes, they related.

> 
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.25.1
> 
> 
> Thanks,
> SJ

-- 
Thanks,
Zheng Yejian

