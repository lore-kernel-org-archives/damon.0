Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D30239E9A
	for <damon@lists.linux.dev>; Fri, 24 Apr 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776997816; cv=none; b=OEzk7ZH0SfPWUa0OWBAM1UXh7yTMddh/10ESyC6CZHIT2CvwIjRGYcrMIjlNkGL2XNdMxcEebspEM11pQ/ElT+B5gFQvND3OinD09a3CryJW7XWkqvD/zRzN8Y8hk6+suXnCcB96TXxHzjZA3+glEVGmtfmZqvGKjb1QgZjA8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776997816; c=relaxed/simple;
	bh=zgCzKWx4+JepXHWimtLmoZQPmZLfpc3mUvLfICxpSyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/kT+Hb8S280V0T8HSduD76+RAcVgMieUhfdlmoWNSBAan0JCQ1s4r3KT1a9ouUzqRWDXR2p24UwB6iIY8w4jqsZOxYlyKv6mx44BgRGT3qeLSSWZoyTxMTxTbYQyaaswnf7WAN+izUxJrNzfdwOkYJeD9VQPepvOfeIvY8FY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YIdZCov6; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YIdZCov6"
Message-ID: <eb215ae6-bead-47ef-9c3a-3f4c80d39361@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776997812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTzVObsTgjPyebBtAz0CydyHn0WqV/3sHEsRDFpTpG8=;
	b=YIdZCov6euTzkkQemuooEt8m5udPXFPoCJVGnqEJ5Lroxn6vbEG9eoAizO8MV/U6ATEf5a
	vPwUr4vT7AVOae13PmFcw5kpbgdLBN60OL5kY7IzUfUa2J+i4KZzoCx1Ts74AHtIF5nnW7
	iLV+5t7CvvWhH+IIfeQYLGFYgPO7vSc=
Date: Fri, 24 Apr 2026 10:29:58 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/damon: introduce damon_rand_fast() for per-ctx
 PRNG
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Jiayuan Chen <jiayuan.chen@shopee.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260424013621.983-1-sj@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260424013621.983-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hello SJ,

Thank you for the review.

On 4/24/26 9:36 AM, SeongJae Park wrote:
> Hello Jiayuan,
>
>
> Thank you for sharing this patch with us!
>
> On Thu, 23 Apr 2026 20:23:36 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> damon_rand() on the sampling_addr hot path calls get_random_u32_below(),
>> which takes a local_lock_irqsave() around a per-CPU batched entropy pool
>> and periodically refills it with ChaCha20.  On workloads with large
>> nr_regions (20k+), this shows up as a large fraction of kdamond CPU
>> time: the lock_acquire / local_lock pair plus __get_random_u32_below()
>> dominate perf profiles.
> Could you please share more details about the use case?  I'm particularly
> curious how you ended up setting 'nr_regiions' that high, while the upper limit
> of nr_regions is set to 1,0000 by default.

We use DAMON paddr on a 2 TiB host for per-cgroup hot/cold page
classification.  Target cgroups can be as small as 1-2% of total
memory (tens of GiB).

With the default max_nr_regions=1000, each region covers ~2 GiB on
average, which is often larger than the entire target cgroup.
Adaptive split cannot carve out cgroup-homogeneous regions in that
regime: each region's nr_accesses averages the (small) cgroup
fraction with the surrounding non-cgroup pages, and the cgroup's
access signal gets washed out.

Raising max_nr_regions to 10k-20k gives the adaptive split enough
spatial resolution that cgroup-majority regions can form at cgroup
boundaries (allocations have enough physical locality in practice for
this to work -- THP, per-node allocation, etc.).  At that region
count, damon_rand() starts showing up at the top of kdamond profiles,
which is what motivated this patch.


> I know some people worry if the limit is too low and it could result in poor
> monitoring accuracy.  Therefore we developed [1] monitoring intervals
> auto-tuning.  From multiple tests on real environment it showed somewhat
> convincing results, and therefore I nowadays suggest DAMON users to try that if
> they didn't try.
>
> I'm bit concerned if this is over-engineering.  It would be helpful to know if
> it is, if you could share the more detailed use case.


Thanks for pointing to intervals auto-tuning - we do use it.  But it

trades sampling frequency against monitoring overhead; it cannot
change the spatial resolution.  With N=1000 regions on a 2 TiB host,
a 20 GiB cgroup cannot be resolved no matter how we tune sample_us /
aggr_us, because the region boundary itself averages cgroup and

non-cgroup pages together.

So raising max_nr_regions and making the per-region overhead cheap
are complementary to interval auto-tuning, not redundant with it.

>> Introduce damon_rand_fast(), which uses a lockless lfsr113 generator
>> (struct rnd_state) held per damon_ctx and seeded from get_random_u64()
>> in damon_new_ctx().  kdamond is the sole consumer of a given ctx, so no
>> synchronization is required.  Range mapping uses Lemire's
>> (u64)rnd * span >> 32 to avoid a 64-bit division; residual bias is
>> bounded by span / 2^32, negligible for statistical sampling.
>>
>> The new helper is intended for the sampling-address hot path only.
>> damon_rand() is kept for call sites that run outside the kdamond loop
>> and/or have no ctx available (damon_split_regions_of(), kunit tests).
>>
>> Convert the two hot callers:
>>
>>    - __damon_pa_prepare_access_check()
>>    - __damon_va_prepare_access_check()
>>
>> lfsr113 is a linear PRNG and MUST NOT be used for anything
>> security-sensitive.  DAMON's sampling_addr is not exposed to userspace
>> and is only consumed as a probe point for PTE accessed-bit sampling, so
>> a non-cryptographic PRNG is appropriate here.
>>
>> Tested with paddr monitoring and max_nr_regions=20000: kdamond CPU
>> usage reduced from ~72% to ~50% of one core.
>>
>> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>> ---
>>   include/linux/damon.h | 28 ++++++++++++++++++++++++++++
>>   mm/damon/core.c       |  2 ++
>>   mm/damon/paddr.c      | 10 +++++-----
>>   mm/damon/vaddr.c      |  9 +++++----
>>   4 files changed, 40 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index f2cdb7c3f5e6..0afdc08119c8 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -10,6 +10,7 @@
>>   
>>   #include <linux/memcontrol.h>
>>   #include <linux/mutex.h>
>> +#include <linux/prandom.h>
>>   #include <linux/time64.h>
>>   #include <linux/types.h>
>>   #include <linux/random.h>
>> @@ -843,8 +844,35 @@ struct damon_ctx {
>>   
>>   	struct list_head adaptive_targets;
>>   	struct list_head schemes;
>> +
>> +	/*
>> +	 * Per-ctx lockless PRNG state for damon_rand_fast(). Seeded from
>> +	 * get_random_u64() in damon_new_ctx(). Owned exclusively by the
>> +	 * kdamond thread of this ctx, so no locking is required.
>> +	 */
>> +	struct rnd_state rnd_state;
>>   };
>>   
>> +/*
>> + * damon_rand_fast - per-ctx PRNG variant of damon_rand() for hot paths.
>> + *
>> + * Uses the lockless lfsr113 state kept in @ctx->rnd_state. Safe because
>> + * kdamond is the single consumer of a given ctx, so no synchronization
>> + * is required. Quality is sufficient for statistical sampling; do NOT
>> + * use for any security-sensitive randomness.
>> + *
>> + * Range mapping uses Lemire's (u64)rnd * span >> 32 to avoid a division;
>> + * bias is bounded by span / 2^32, negligible for DAMON.
>> + */
>> +static inline unsigned long damon_rand_fast(struct damon_ctx *ctx,
>> +					    unsigned long l, unsigned long r)
>> +{
>> +	u32 rnd = prandom_u32_state(&ctx->rnd_state);
>> +	u32 span = (u32)(r - l);
>> +
>> +	return l + (unsigned long)(((u64)rnd * span) >> 32);
>> +}
> As Sashiko pointed out [2], we may better to return 'unsigned long' from this
> function.  Can this algorithm be extended for that?

Sashiko is correct that (u32)(r - l) truncates spans greater than 4 GiB.

This is a pre-existing limitation of damon_rand() itself, which
passes r - l to get_random_u32_below() (a u32 parameter) and
truncates the same way.  My patch makes that truncation
explicit but does not introduce a new bug.

We can restrict the region size when config or just allow spans greater 
than 4G.

static inline unsigned long damon_rand_fast(struct damon_ctx *ctx,
               unsigned long l, unsigned long r)
{
       unsigned long span = r - l;
       u64 rnd;

       if (likely(span <= U32_MAX)) {
               rnd = prandom_u32_state(&ctx->rnd_state);
               return l + (unsigned long)((rnd * span) >> 32);
       }
       rnd = ((u64)prandom_u32_state(&ctx->rnd_state) << 32) |
             prandom_u32_state(&ctx->rnd_state);

       // same as 'l + (unsigned long)((rnd * span) >> 32);'
       return l + mul_u64_u64_shr(rnd, span, 64);
}


>> +
>>   static inline struct damon_region *damon_next_region(struct damon_region *r)
>>   {
>>   	return container_of(r->list.next, struct damon_region, list);
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 3dbbbfdeff71..c3779c674601 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -607,6 +607,8 @@ struct damon_ctx *damon_new_ctx(void)
>>   	INIT_LIST_HEAD(&ctx->adaptive_targets);
>>   	INIT_LIST_HEAD(&ctx->schemes);
>>   
>> +	prandom_seed_state(&ctx->rnd_state, get_random_u64());
>> +
>>   	return ctx;
>>   }
>>   
>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>> index 5cdcc5037cbc..b5e1197f2ba2 100644
>> --- a/mm/damon/paddr.c
>> +++ b/mm/damon/paddr.c
>> @@ -48,12 +48,12 @@ static void damon_pa_mkold(phys_addr_t paddr)
>>   	folio_put(folio);
>>   }
>>   
>> -static void __damon_pa_prepare_access_check(struct damon_region *r,
>> -		unsigned long addr_unit)
>> +static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
>> +					    struct damon_region *r)
> Let's keep 'r' on the first line, and update the second line without indent
> change.
>
Thanks
>>   {
>> -	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
>> +	r->sampling_addr = damon_rand_fast(ctx, r->ar.start, r->ar.end);
>>   
>> -	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, addr_unit));
>> +	damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr, ctx->addr_unit));
>>   }
>>   
>>   static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
>> @@ -63,7 +63,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
>>   
>>   	damon_for_each_target(t, ctx) {
>>   		damon_for_each_region(r, t)
>> -			__damon_pa_prepare_access_check(r, ctx->addr_unit);
>> +			__damon_pa_prepare_access_check(ctx, r);
>>   	}
>>   }
>>   
>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>> index b069dbc7e3d2..6cf06ffdf880 100644
>> --- a/mm/damon/vaddr.c
>> +++ b/mm/damon/vaddr.c
>> @@ -332,10 +332,11 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
>>    * Functions for the access checking of the regions
>>    */
>>   
>> -static void __damon_va_prepare_access_check(struct mm_struct *mm,
>> -					struct damon_region *r)
>> +static void __damon_va_prepare_access_check(struct damon_ctx *ctx,
>> +					    struct mm_struct *mm,
>> +					    struct damon_region *r)
> Let's keep the first line and the the indentation as were, and add 'ctx'
> argument to the end.
>
>>   {
>> -	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
>> +	r->sampling_addr = damon_rand_fast(ctx, r->ar.start, r->ar.end);
>>   
>>   	damon_va_mkold(mm, r->sampling_addr);
>>   }
>> @@ -351,7 +352,7 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
>>   		if (!mm)
>>   			continue;
>>   		damon_for_each_region(r, t)
>> -			__damon_va_prepare_access_check(mm, r);
>> +			__damon_va_prepare_access_check(ctx, mm, r);
>>   		mmput(mm);
>>   	}
>>   }
>> -- 
>> 2.43.0
>>
>>
> [1] https://lkml.kernel.org/r/20250303221726.484227-1-sj@kernel.org
> [2] https://lore.kernel.org/20260423190841.821E4C2BCAF@smtp.kernel.org
>
>
> Thanks,
> SJ
