Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF9331A63;
	Thu,  7 May 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141407; cv=none; b=UOAUGWrkZKbky1YGhr98zda4MrbuNvT81Rtp3YdjBdfxdjM9uuke7r5b+xNWolNNIJ84B+T1izLeaEOnwW/+fAlFmC25F7XdPX5uEH3TAlrDdTYdb4IGWmzVyn7kXKbl4TKwkZilz2cg/FLFAGFQ3T7QQCSUrBM70c9y8xLsPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141407; c=relaxed/simple;
	bh=wznC1/DjH80ACv9BktGFOg6DgVpw8UaggCBEOgh/FWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIu2ctqwwFqzaxe5rUfFoZSd6bdIbDRgd/n/F7LUiSiwZCsAGe4ABxxN9voOi3Bps5y7YDc2Aj2wr4rIh7dSm0JcmOtPo7irN44U4KSvjtsV7UiI2H60XIXN96MLHnV5peJFDG45UENwiD2lJwWbja0pl+ottauPvooLYYUBzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S48tYFtb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S48tYFtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678EEC2BCB8;
	Thu,  7 May 2026 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778141406;
	bh=wznC1/DjH80ACv9BktGFOg6DgVpw8UaggCBEOgh/FWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S48tYFtbp9N0Alm9+cBQpFN2IPDOnrNOHfarS8PKslYCpwMwkObBP9RCgAWjJBcm0
	 QvPY/EySe6t/Af031bef8Gx9zq3ujaZ34n6JHMfwp4Vrp86QGgV+ua6g6XL4UME32X
	 GmSarj+TcOrfD1GhStz9aaBpE08g+a07yJPEKI8Mc/prwAB8lznA8qVs2IX5ZQZGLI
	 2HzQOCAif1DXZ+9yFyIKDJzQYzMremz1G6ozKtixP76lSgExyZBuN5wEK+y/hgCoik
	 eM42lpG9GqOTsqEupPM7WgqdGHKCSRWMx7SYXzlr0jeC6SE67qob9JOVDKVjOO2C39
	 x9326DbwwVY9w==
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
Date: Thu,  7 May 2026 01:10:00 -0700
Message-ID: <20260507081001.11427-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d053e344-7643-4504-b766-a04f2b4a6569@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 7 May 2026 07:41:11 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> Hello SJ,
> 
> 
> On 5/7/26 12:37 AM, SeongJae Park wrote:
> > Hello Jiayuan,
> >
> >
> > Thank you for posting this second version!
> >
> > On Tue,  5 May 2026 22:52:06 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
[...]
> >> is required.  Range mapping uses Lemire's (u64)rnd * span >> 32 on the
> >> fast path;
> > Could we add some links to the algorithm?  I found a blog [1] from Google and
> > guessing that is what you're saying, but I'm not really sure since I failed at
> > finding time to thoroughtly read it.
> 
> 
> 
> The link covers a related family of techniques, but I don't
> think we need an external reference.  The pattern is just the
> multiply-shift fast path that the kernel already uses in
> __get_random_u32_below() (drivers/char/random.c) -- (u64)rnd *
> span >> 32 -- which the existing comment there calls "traditional
> reciprocal multiplication". Of course I can add simple comment like
> 
> "traditional reciprocal multiplication, similar as get_random_u32_below()"

Makes sense, thank you for enlightening me!  And yes, your suggestion looks
very good to me!

[...]
> >> Link: https://lore.kernel.org/damon/20260426173346.86238-1-sj@kernel.org/T/#m4f1fd74112728f83a41511e394e8c3fef703039c
> > Why are you adding the above link?  It would be good to add description of the
> > link on the commit message.
> >
> > Other than that, commit message looks good to me.
> 
> Will move it to the patch changelog (after ---) instead of the
> commit message

Oh, so the intention was the patch changelog.  Yes, let's add a formal
changelog on the commentary area [1] from the next time.

[...]
> >> +#include <linux/math64.h>
> >>   #include <linux/memcontrol.h>
> >>   #include <linux/mutex.h>
> >> +#include <linux/prandom.h>
> >>   #include <linux/time64.h>
> >>   #include <linux/types.h>
> >>   #include <linux/random.h>
> > Maybe we can remove random.h?
> 
> Right !

Thank you for confirming!

[...]
> >> +/* Get a random number in [@l, @r) using @ctx's lockless PRNG. */
> >> +static inline unsigned long damon_rand(struct damon_ctx *ctx,
> >> +				       unsigned long l, unsigned long r)
> >> +{
> >> +	unsigned long span = r - l;
> >> +	u64 rnd;
> >> +
> >> +	if (span <= U32_MAX) {
> >> +		rnd = prandom_u32_state(&ctx->rnd_state);
> >> +		return l + (unsigned long)((rnd * span) >> 32);
> >> +	}
> >> +	rnd = ((u64)prandom_u32_state(&ctx->rnd_state) << 32) |
> >> +	      prandom_u32_state(&ctx->rnd_state);
> >> +	return l + mul_u64_u64_shr(rnd, span, 64);
> >> +}
> >> +
> > I was unable to find time to thoroughly read the link I found, or understand
> > the algorithm with only the code, so tested by myself like below.
> >
> > '''
> > $ cat ./foo.c
> > #include <stdio.h>
> > #include <stdbool.h>
> > #include <stdlib.h>
> > #include <stdint.h>
> >
> > int main(int argc, char *argv[])
> > {
> >          unsigned long span;
> >          int i;
> >
> >          if (argc != 2) {
> >                  printf("Usge: %s <span>\n", argv[0]);
> >                  return -1;
> >          }
> >          span = atoi(argv[1]);
> >
> >          for (i = 0; i < 1000; i++) {
> >                  uint64_t rnd = rand();
> >
> >                  printf("%lu\n", (uint64_t)((rnd * span) >> 32));
> >          }
> >          return 0;
> > }
> > $ gcc ./foo.c
> > $ ./a.out 10 | sort -n | uniq --count
> >      195 0
> >      194 1
> >      188 2
> >      223 3
> >      200 4
> > '''
> >
> > So I expected the program to generate number 0-9 randomly with similar
> > proportions.  But it is generating only numbers 0-4.  I confirmed doubling
> > 'span' value makes it work in my expected way.  Should we do that here, too?
> 
> 
> 
> I wrote a kmod to verify.  The helper is a verbatim copy of
> damon_rand() from the patch:
> 
>    static inline unsigned long damon_rand_test(struct rnd_state *state,
>                                                unsigned long l, unsigned 
> long r)
>    {
>            unsigned long span = r - l;
>            u64 rnd;
> 
>            if (span <= U32_MAX) {
>                    rnd = prandom_u32_state(state);
>                    return l + (unsigned long)((rnd * span) >> 32);
>            }
>            rnd = ((u64)prandom_u32_state(state) << 32) |
>                  prandom_u32_state(state);
>            return l + mul_u64_u64_shr(rnd, span, 64);
>    }
> 
>    static int __init damon_rand_test_init(void)
>    {
>            struct rnd_state state;
>            unsigned long counts[SPAN] = {0};
>            unsigned long i, v;
>            int j;
> 
>            prandom_seed_state(&state, get_random_u64());
> 
>            for (i = 0; i < ITERATIONS; i++) {
>                    v = damon_rand_test(&state, 0, SPAN);
>                    if (v >= SPAN) {
>                            pr_err("out of range: %lu\n", v);
>                            return -EINVAL;
>                    }
>                    counts[v]++;
>            }
> 
>            pr_info("damon_rand_test: span=%lu iterations=%lu\n",
>                    SPAN, ITERATIONS);
>            for (j = 0; j < SPAN; j++)
>                    pr_info("damon_rand_test:   %d -> %lu\n", j, counts[j]);
> 
>            return 0;
>    }
> 
> dmesg output (span=10, 1000 iterations):
> 
>    damon_rand_test: span=10 iterations=1000
>    damon_rand_test:   0 -> 99
>    damon_rand_test:   1 -> 107
>    damon_rand_test:   2 -> 79
>    damon_rand_test:   3 -> 94
>    damon_rand_test:   4 -> 97
>    damon_rand_test:   5 -> 97
>    damon_rand_test:   6 -> 94
>    damon_rand_test:   7 -> 100
>    damon_rand_test:   8 -> 114
>    damon_rand_test:   9 -> 119
> 
> All 10 buckets get hits, roughly uniform.
> 
> Looking into the usrspace test program, the issue is that libc rand()
> returns a value in [0, RAND_MAX].  On glibc RAND_MAX is
> 2^31 - 1 (not 2^32 - 1), so the upper bit is missing and
> the multiply-shift only fills the lower half of the output
> range.  prandom_u32_state() returns a full u32 in [0, 2^32),
> so the in-kernel formula behaves correctly without doubling.

Thank you for kindly checking all these details and sharing with me.  All make
sense to me.

Reviewed-by: SeongJae Park <sj@kernel.org>

I added this patch to my damon/next tree with small modifications including
removal of random.h include, simple range mapping description update, and
adding my Reviewed-by: tag.

I will repost my version for mm.git inclusion soon (maybe within 1-2 days)
unless Andrew picks this into mm.git or you send a new version before.  My
reposting plan is only for a case involved people dropping a ball, so please
feel free to make action before my reposting if you want and don't mind.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/tree/patches/next/mm-damon-replace-damon_rand-with-a-per-ctx-lockless-.patch


Thanks,
SJ
