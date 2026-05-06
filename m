Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F848BD43;
	Wed,  6 May 2026 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085426; cv=none; b=LnF3QXzTdg9gF+y4/nEW0bvhTIQ8zXoeMKATwgUTtP9SZXvthPYDQcQ/O5wqUJYWvZuO2LUsOw3vjaT6bmA4wiDOxZQH9euZkHnAkhGvt9r3PE6xblF+wGoTl72cHXsO7sWm8scx+U9iwEaIDte8HagHfdm+veptGPr82wH7AUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085426; c=relaxed/simple;
	bh=VwuzcDo/M8l3F+D0/joF1sxuSTpVoiJuVAJ5yOeJ4b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9VUOp4nxDlll02sQbWc5YL8aivX8uRgLHcXgykvL6Wpa65t5IC/tsWS03Zn9aUjOCaNfL6OIh6iltBO+ZompsFg+HHZIKOv6Q9MO80N+rfAIrSLtSmbm3b6NW8xwy8UPjfRoM+dE34Zu71eJkUmCOXtVX3odcwa2ZRjyaotxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHTrrfeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHTrrfeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC35C2BCC7;
	Wed,  6 May 2026 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085426;
	bh=VwuzcDo/M8l3F+D0/joF1sxuSTpVoiJuVAJ5yOeJ4b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHTrrfeT4OL3IQ8X06TgzDQcRFY0o9S3WHVBH8jNnazDoRUbJxNYXmck8XiAZMLBF
	 TwwxAY23Z2ralePvItMXUIGRGwIhJkYOqloSzQqIWdS/M2fkUxPWSgNLT7SFQtko2g
	 3EdiYfsyZD2+HVEcBbp290jWKoHWWtpHTyoOnkweThjPhXINXsiObVPu62vgtXLw2I
	 O9RpunDiNdM7eRncL9W5RtOhLCq394Ci2x9wtnZ/oie/6srXrCMEK0XVgoNfqyGehn
	 qI8tTEHhgyklddRfCXV7USaMQsUd6jnTCpiviwdiGkOceisj7OowmcKkpJkq1iQLF1
	 U5jfy4DjWdtcQ==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: replace damon_rand() with a per-ctx lockless PRNG
Date: Wed,  6 May 2026 09:37:00 -0700
Message-ID: <20260506163701.6288-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505145212.108644-1-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jiayuan,


Thank you for posting this second version!

On Tue,  5 May 2026 22:52:06 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> damon_rand() on the sampling_addr hot path called
> get_random_u32_below(), which takes a local_lock_irqsave() around a
> per-CPU batched entropy pool and periodically refills it with
> ChaCha20.  At elevated nr_regions counts (20k+), the lock_acquire /
> local_lock pair plus __get_random_u32_below() dominate kdamond perf
> profiles.
> 
> Replace the helper with a lockless lfsr113 generator (struct rnd_state)
> held per damon_ctx and seeded from get_random_u64() in damon_new_ctx().
> kdamond is the single consumer of a given ctx, so no synchronization
> is required.  Range mapping uses Lemire's (u64)rnd * span >> 32 on the
> fast path;

Could we add some links to the algorithm?  I found a blog [1] from Google and
guessing that is what you're saying, but I'm not really sure since I failed at
finding time to thoroughtly read it.

> for spans larger than U32_MAX (only reachable on 64-bit) the
> slow path combines two u32 outputs and uses mul_u64_u64_shr() at 64-bit
> width.  On 32-bit the slow path is dead code and gets eliminated by
> the compiler.
> 
> The new helper takes a ctx parameter; damon_split_regions_of() and
> the kunit tests that call it directly are updated accordingly.
> 
> lfsr113 is a linear PRNG and MUST NOT be used for anything
> security-sensitive.  DAMON's sampling_addr is not exposed to userspace
> and is only consumed as a probe point for PTE accessed-bit sampling,
> so a non-cryptographic PRNG is appropriate here.
> 
> Tested with paddr monitoring and max_nr_regions=20000: kdamond CPU
> usage reduced from ~72% to ~50% of one core.
> 
> Link: https://lore.kernel.org/damon/20260426173346.86238-1-sj@kernel.org/T/#m4f1fd74112728f83a41511e394e8c3fef703039c

Why are you adding the above link?  It would be good to add description of the
link on the commit message.

Other than that, commit message looks good to me.

> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  include/linux/damon.h       | 27 +++++++++++++++++++++------
>  mm/damon/core.c             | 12 ++++++++----
>  mm/damon/paddr.c            |  8 ++++----
>  mm/damon/tests/core-kunit.h | 28 ++++++++++++++++++++++------
>  mm/damon/vaddr.c            |  7 ++++---
>  5 files changed, 59 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f2cdb7c3f5e6..e16012a7f41a 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -8,8 +8,10 @@
>  #ifndef _DAMON_H_
>  #define _DAMON_H_
>  
> +#include <linux/math64.h>
>  #include <linux/memcontrol.h>
>  #include <linux/mutex.h>
> +#include <linux/prandom.h>
>  #include <linux/time64.h>
>  #include <linux/types.h>
>  #include <linux/random.h>

Maybe we can remove random.h?

> @@ -19,12 +21,6 @@
>  /* Max priority score for DAMON-based operation schemes */
>  #define DAMOS_MAX_SCORE		(99)
>  
> -/* Get a random number in [l, r) */
> -static inline unsigned long damon_rand(unsigned long l, unsigned long r)
> -{
> -	return l + get_random_u32_below(r - l);
> -}
> -
>  /**
>   * struct damon_addr_range - Represents an address region of [@start, @end).
>   * @start:	Start address of the region (inclusive).
> @@ -843,8 +839,27 @@ struct damon_ctx {
>  
>  	struct list_head adaptive_targets;
>  	struct list_head schemes;
> +
> +	/* Per-ctx PRNG state for damon_rand(); kdamond is the sole consumer. */
> +	struct rnd_state rnd_state;
>  };
>  
> +/* Get a random number in [@l, @r) using @ctx's lockless PRNG. */
> +static inline unsigned long damon_rand(struct damon_ctx *ctx,
> +				       unsigned long l, unsigned long r)
> +{
> +	unsigned long span = r - l;
> +	u64 rnd;
> +
> +	if (span <= U32_MAX) {
> +		rnd = prandom_u32_state(&ctx->rnd_state);
> +		return l + (unsigned long)((rnd * span) >> 32);
> +	}
> +	rnd = ((u64)prandom_u32_state(&ctx->rnd_state) << 32) |
> +	      prandom_u32_state(&ctx->rnd_state);
> +	return l + mul_u64_u64_shr(rnd, span, 64);
> +}
> +

I was unable to find time to thoroughly read the link I found, or understand
the algorithm with only the code, so tested by myself like below.

'''
$ cat ./foo.c
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
        unsigned long span;
        int i;

        if (argc != 2) {
                printf("Usge: %s <span>\n", argv[0]);
                return -1;
        }
        span = atoi(argv[1]);

        for (i = 0; i < 1000; i++) {
                uint64_t rnd = rand();

                printf("%lu\n", (uint64_t)((rnd * span) >> 32));
        }
        return 0;
}
$ gcc ./foo.c
$ ./a.out 10 | sort -n | uniq --count
    195 0
    194 1
    188 2
    223 3
    200 4
'''

So I expected the program to generate number 0-9 randomly with similar
proportions.  But it is generating only numbers 0-4.  I confirmed doubling
'span' value makes it work in my expected way.  Should we do that here, too?

[...]

Other than above, code changes look good to me.

[1] https://lemire.me/blog/2024/08/17/faster-random-integer-generation-with-batching/


Thanks,
SJ
