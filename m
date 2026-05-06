Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B72F12B3
	for <damon@lists.linux.dev>; Wed,  6 May 2026 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110892; cv=none; b=DpL4/SvgAwm7cHRIfrgitJS8KPG84NS+ClR4DCF/I/pV7m+2H6qEkxgRHQJXsUcUTTSF1/ilWdHu8zRp85mnI+5ntSceWipwRlvzcWU/NDqrEq8Rwn8iG3EVIE3evLcgy8N8V3nUtuzi/iIFK1+TMDhpdrYxjckS7GVccUJdnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110892; c=relaxed/simple;
	bh=Z+zBaej/FyigjTpwQiVFttZWIC02vE9TUPUWpcRfUyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBDtpBItD2RteqZGsOruxmK6pBU62pyz/gTWJgPvgwlK55o4n+7kFNCKHEh6kTs8/v+UotxPRDKdYwQAhtx8C27DfPQ6gQuXHgJK9yeYSIOXXqdT3FRnQm0GwE75sh2ijE1oOYjdcpdqLyzp101uhsRhw+dUItH86Ukt8k/0L1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lfDG9GYN; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lfDG9GYN"
Message-ID: <d053e344-7643-4504-b766-a04f2b4a6569@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778110886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omVYK4AEUjq1NlglCNUDwEXuCT4cUd1OTwfgXBB1ZSY=;
	b=lfDG9GYNsBLSSa6BBxZLdmHXeWhCEXgQa0PcMxEdMKqaf44VfYzoj51TdMh5CLlgL/pHl9
	70zeg195xegmAVMnIUB/5/C8LzpYJy0JTa7/SPMYsOScxHKkap+zBlFJm2yfqHRqjLQunk
	2f86OH0VHxznwzNhWWkyszxSrfL+JDw=
Date: Thu, 7 May 2026 07:41:11 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/damon: replace damon_rand() with a per-ctx lockless
 PRNG
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Jiayuan Chen <jiayuan.chen@shopee.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shu Anzai <shu17az@gmail.com>,
 Quanmin Yan <yanquanmin1@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260506163701.6288-1-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260506163701.6288-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hello SJ,


On 5/7/26 12:37 AM, SeongJae Park wrote:
> Hello Jiayuan,
>
>
> Thank you for posting this second version!
>
> On Tue,  5 May 2026 22:52:06 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> damon_rand() on the sampling_addr hot path called
>> get_random_u32_below(), which takes a local_lock_irqsave() around a
>> per-CPU batched entropy pool and periodically refills it with
>> ChaCha20.  At elevated nr_regions counts (20k+), the lock_acquire /
>> local_lock pair plus __get_random_u32_below() dominate kdamond perf
>> profiles.
>>
>> Replace the helper with a lockless lfsr113 generator (struct rnd_state)
>> held per damon_ctx and seeded from get_random_u64() in damon_new_ctx().
>> kdamond is the single consumer of a given ctx, so no synchronization
>> is required.  Range mapping uses Lemire's (u64)rnd * span >> 32 on the
>> fast path;
> Could we add some links to the algorithm?  I found a blog [1] from Google and
> guessing that is what you're saying, but I'm not really sure since I failed at
> finding time to thoroughtly read it.



The link covers a related family of techniques, but I don't
think we need an external reference.  The pattern is just the
multiply-shift fast path that the kernel already uses in
__get_random_u32_below() (drivers/char/random.c) -- (u64)rnd *
span >> 32 -- which the existing comment there calls "traditional
reciprocal multiplication". Of course I can add simple comment like

"traditional reciprocal multiplication, similar as get_random_u32_below()"

>> for spans larger than U32_MAX (only reachable on 64-bit) the
>> slow path combines two u32 outputs and uses mul_u64_u64_shr() at 64-bit
>> width.  On 32-bit the slow path is dead code and gets eliminated by
>> the compiler.
>>
>> The new helper takes a ctx parameter; damon_split_regions_of() and
>> the kunit tests that call it directly are updated accordingly.
>>
>> lfsr113 is a linear PRNG and MUST NOT be used for anything
>> security-sensitive.  DAMON's sampling_addr is not exposed to userspace
>> and is only consumed as a probe point for PTE accessed-bit sampling,
>> so a non-cryptographic PRNG is appropriate here.
>>
>> Tested with paddr monitoring and max_nr_regions=20000: kdamond CPU
>> usage reduced from ~72% to ~50% of one core.
>>
>> Link: https://lore.kernel.org/damon/20260426173346.86238-1-sj@kernel.org/T/#m4f1fd74112728f83a41511e394e8c3fef703039c
> Why are you adding the above link?  It would be good to add description of the
> link on the commit message.
>
> Other than that, commit message looks good to me.

Will move it to the patch changelog (after ---) instead of the
commit message


>> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>> ---
>>   include/linux/damon.h       | 27 +++++++++++++++++++++------
>>   mm/damon/core.c             | 12 ++++++++----
>>   mm/damon/paddr.c            |  8 ++++----
>>   mm/damon/tests/core-kunit.h | 28 ++++++++++++++++++++++------
>>   mm/damon/vaddr.c            |  7 ++++---
>>   5 files changed, 59 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index f2cdb7c3f5e6..e16012a7f41a 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -8,8 +8,10 @@
>>   #ifndef _DAMON_H_
>>   #define _DAMON_H_
>>   
>> +#include <linux/math64.h>
>>   #include <linux/memcontrol.h>
>>   #include <linux/mutex.h>
>> +#include <linux/prandom.h>
>>   #include <linux/time64.h>
>>   #include <linux/types.h>
>>   #include <linux/random.h>
> Maybe we can remove random.h?

Right !


>> @@ -19,12 +21,6 @@
>>   /* Max priority score for DAMON-based operation schemes */
>>   #define DAMOS_MAX_SCORE		(99)
>>   
>> -/* Get a random number in [l, r) */
>> -static inline unsigned long damon_rand(unsigned long l, unsigned long r)
>> -{
>> -	return l + get_random_u32_below(r - l);
>> -}
>> -
>>   /**
>>    * struct damon_addr_range - Represents an address region of [@start, @end).
>>    * @start:	Start address of the region (inclusive).
>> @@ -843,8 +839,27 @@ struct damon_ctx {
>>   
>>   	struct list_head adaptive_targets;
>>   	struct list_head schemes;
>> +
>> +	/* Per-ctx PRNG state for damon_rand(); kdamond is the sole consumer. */
>> +	struct rnd_state rnd_state;
>>   };
>>   
>> +/* Get a random number in [@l, @r) using @ctx's lockless PRNG. */
>> +static inline unsigned long damon_rand(struct damon_ctx *ctx,
>> +				       unsigned long l, unsigned long r)
>> +{
>> +	unsigned long span = r - l;
>> +	u64 rnd;
>> +
>> +	if (span <= U32_MAX) {
>> +		rnd = prandom_u32_state(&ctx->rnd_state);
>> +		return l + (unsigned long)((rnd * span) >> 32);
>> +	}
>> +	rnd = ((u64)prandom_u32_state(&ctx->rnd_state) << 32) |
>> +	      prandom_u32_state(&ctx->rnd_state);
>> +	return l + mul_u64_u64_shr(rnd, span, 64);
>> +}
>> +
> I was unable to find time to thoroughly read the link I found, or understand
> the algorithm with only the code, so tested by myself like below.
>
> '''
> $ cat ./foo.c
> #include <stdio.h>
> #include <stdbool.h>
> #include <stdlib.h>
> #include <stdint.h>
>
> int main(int argc, char *argv[])
> {
>          unsigned long span;
>          int i;
>
>          if (argc != 2) {
>                  printf("Usge: %s <span>\n", argv[0]);
>                  return -1;
>          }
>          span = atoi(argv[1]);
>
>          for (i = 0; i < 1000; i++) {
>                  uint64_t rnd = rand();
>
>                  printf("%lu\n", (uint64_t)((rnd * span) >> 32));
>          }
>          return 0;
> }
> $ gcc ./foo.c
> $ ./a.out 10 | sort -n | uniq --count
>      195 0
>      194 1
>      188 2
>      223 3
>      200 4
> '''
>
> So I expected the program to generate number 0-9 randomly with similar
> proportions.  But it is generating only numbers 0-4.  I confirmed doubling
> 'span' value makes it work in my expected way.  Should we do that here, too?



I wrote a kmod to verify.  The helper is a verbatim copy of
damon_rand() from the patch:

   static inline unsigned long damon_rand_test(struct rnd_state *state,
                                               unsigned long l, unsigned 
long r)
   {
           unsigned long span = r - l;
           u64 rnd;

           if (span <= U32_MAX) {
                   rnd = prandom_u32_state(state);
                   return l + (unsigned long)((rnd * span) >> 32);
           }
           rnd = ((u64)prandom_u32_state(state) << 32) |
                 prandom_u32_state(state);
           return l + mul_u64_u64_shr(rnd, span, 64);
   }

   static int __init damon_rand_test_init(void)
   {
           struct rnd_state state;
           unsigned long counts[SPAN] = {0};
           unsigned long i, v;
           int j;

           prandom_seed_state(&state, get_random_u64());

           for (i = 0; i < ITERATIONS; i++) {
                   v = damon_rand_test(&state, 0, SPAN);
                   if (v >= SPAN) {
                           pr_err("out of range: %lu\n", v);
                           return -EINVAL;
                   }
                   counts[v]++;
           }

           pr_info("damon_rand_test: span=%lu iterations=%lu\n",
                   SPAN, ITERATIONS);
           for (j = 0; j < SPAN; j++)
                   pr_info("damon_rand_test:   %d -> %lu\n", j, counts[j]);

           return 0;
   }

dmesg output (span=10, 1000 iterations):

   damon_rand_test: span=10 iterations=1000
   damon_rand_test:   0 -> 99
   damon_rand_test:   1 -> 107
   damon_rand_test:   2 -> 79
   damon_rand_test:   3 -> 94
   damon_rand_test:   4 -> 97
   damon_rand_test:   5 -> 97
   damon_rand_test:   6 -> 94
   damon_rand_test:   7 -> 100
   damon_rand_test:   8 -> 114
   damon_rand_test:   9 -> 119

All 10 buckets get hits, roughly uniform.

Looking into the usrspace test program, the issue is that libc rand()
returns a value in [0, RAND_MAX].  On glibc RAND_MAX is
2^31 - 1 (not 2^32 - 1), so the upper bit is missing and
the multiply-shift only fills the lower half of the output
range.  prandom_u32_state() returns a full u32 in [0, 2^32),
so the in-kernel formula behaves correctly without doubling.

> [...]
>
> Other than above, code changes look good to me.
>
> [1] https://lemire.me/blog/2024/08/17/faster-random-integer-generation-with-batching/
>
>
> Thanks,
> SJ
