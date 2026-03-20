Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF21C2AA;
	Fri, 20 Mar 2026 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773973744; cv=none; b=kqG2hO7mGg3JXE5o2y2ILhTjhf1o61O6f/kAWEgvlpHv4Wusnx8qU+tXbjdP2qK7bQlZ1pFOxmFr2mKarx1X6M9SVxdxZrCSTSNSKfTErqqkjNUoeuCQQm+omoPfOgOpJj7Db5UH2tXg0h2cjGu11EMrvKQ5y0mBZAi2W/XE6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773973744; c=relaxed/simple;
	bh=tpGT9HIxfVro2qvhVyVnekgS2KunpsS2ClCk/o5mBAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyId7N05CR1nRqfjWd2cp/UL0UYazPNwRUXhXniBoG5hlJ/XJ4w8sRBa0/SvH0Kjm7ycCAMOnDBiQRnUjoovI9d+iLxqcWkBI8/QR24/mopHnehkNN7D/6JKI1H9HjaXUKgqs+uLvrS8R6AdXJUgH7xqWWSmRHwN5FUtPooNiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGF5eAg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGF5eAg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4827AC19424;
	Fri, 20 Mar 2026 02:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773973744;
	bh=tpGT9HIxfVro2qvhVyVnekgS2KunpsS2ClCk/o5mBAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGF5eAg51gxaSCwv03t28Y1RWmgpy1R7a0mHkHkusJwftawbe4qhBII3q10sQsiUd
	 8jad/EPLHnZ3WYpHCx5YMmSUaaVewlWiEbKsDPaw511sEWCvKXjl6LsZUsEJwmPHYg
	 FJqAzlT4pI+ZRNGR4sJWlymKvqwLrWAbq6E+81Ej/U7B5P3gOyYfZ/iwqGxJGYcZHe
	 rX161w6PBiLmOErh5qR97eFiN845YdWWfp1fT1sMpgtZ2TMTj+jXV18QwAymwRm++t
	 iDaTYA6AXcgaU4fDbif9fQ0F2V57SjwCzGn6u4iCLlviHL0QDxmol7bhJWQy11Mo5r
	 BWVvtXuXtVNRw==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/reclaim: reject non-power-of-2 addr_unit
Date: Thu, 19 Mar 2026 19:29:01 -0700
Message-ID: <20260320022902.1415-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319161620.189392-2-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 16:16:19 +0000 Josh Law <objecting@objecting.org> wrote:

> DAMON_MIN_REGION_SZ / addr_unit is used as min_region_sz, which is
> passed to ALIGN() and ALIGN_DOWN() in core.c. These macros require
> power-of-2 alignment. When addr_unit is not a power of 2 (e.g., 3),
> the division produces a non-power-of-2 min_region_sz, causing silent
> undefined behavior in ALIGN before damon_commit_ctx() gets a chance
> to reject it.

But the non-power-of-2 min_region_sz makes no effect or be used anywhere unless
damon_commit_ctx() is completed without the rejection.  So this is not a real
issue?  Am I missing something?

> 
> Validate that addr_unit is a power of 2 in the store function so the
> user gets immediate -EINVAL feedback instead of a silent failure.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  mm/damon/reclaim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

And, I'm adding Sashiko comment with my comments in line.

# review url: https://sashiko.dev/#/patchset/20260319161620.189392-2-objecting@objecting.org

> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 43d76f5bed44..9b55df304e51 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -321,7 +321,7 @@ static int damon_reclaim_addr_unit_store(const char *val,
>  
>  	if (err)
>  		return err;
> -	if (!input_addr_unit)
> +	if (!input_addr_unit || !is_power_of_2(input_addr_unit))
>  		return -EINVAL;

: This isn't a bug, but should <linux/log2.h> be explicitly included for the
: is_power_of_2() macro to avoid relying on implicit transitive includes?

Unless it causes a build error, I'd say no.

: 
: Does this same undefined behavior still exist in other DAMON interfaces?
: Looking at damon_lru_sort_addr_unit_store() in mm/damon/lru_sort.c and
: addr_unit_store() in mm/damon/sysfs.c, they appear to still only check
: (!input_addr_unit). Could a user writing a non-power-of-2 value to the
: lru_sort module parameters or sysfs interfaces successfully bypass validation
: and produce a malformed min_region_sz?

Josh already mentioned similar fix may needed on DAMON_LRU_SORT.  I am doubting
if this is a real issue, though, as mentioned above.

>  
>  	addr_unit = input_addr_unit;

: Since addr_unit is a global variable updated here without locks, could there
: be a race condition when it is read during parameter application?
: 
: For instance, in damon_reclaim_apply_parameters() and
: damon_lru_sort_apply_parameters(), addr_unit is read twice sequentially:
: 
:     param_ctx->addr_unit = addr_unit;
:     param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
: 
: If a concurrent write updates addr_unit between these two loads (e.g., from 2
: to 4096), could the context's addr_unit get 2 while min_region_sz gets 1,
: creating a mismatched configuration state? Should READ_ONCE() be used to
: securely cache the global state into a local variable?

Agree.  Nonetheless, orthogonal to this patch.  I will work on this.


Thanks,
SJ

[...]
