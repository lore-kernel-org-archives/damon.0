Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C316DED6
	for <damon@lists.linux.dev>; Thu, 11 Jul 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723736; cv=none; b=hYEPUUKgZvYbiDkyFQ3+4qQBcJtfneqnwrlo1tIwfEfn5DfDRbveTL24E5Vgkr81Bj0YblP6XH+WRiqxj9pde/7NzKQjyTy0eFvVM+emVckfn64Iqy/aO3P72yftpz+fqJjou/vNu9Gxtch96XqrWoaiP/A6PSE5QWyWhKDUiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723736; c=relaxed/simple;
	bh=HZmMVMTma2XXIZszaLwq1eL9tOiyVtkAgMbjpC3Prsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjhyM6oesa5VyOykhZhIoM+t8D9moPAjJAO+aAsMW1g9mjtHyeA3bIoc/8nymAGMKg78RCmTw0uHZwEI+V8BUYi+Q+kHYgBp0+dx9Lvzd3ktLbeRi2VDPmpIF+RnXDO+V1gnV0RDmLuHmU6ayMNV2noae50HmfKpx+w+k9cjR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSXAKyqN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSXAKyqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FE1C116B1;
	Thu, 11 Jul 2024 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720723736;
	bh=HZmMVMTma2XXIZszaLwq1eL9tOiyVtkAgMbjpC3Prsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSXAKyqNB/BLN0IzaMd7rSk5jILlkzOqcXZAL3OkOd3J8+FYU3ntdXGswr7NbF29a
	 cu6AzQfWTI0huCZwe+9ldhPJ7pWCkrL357uIPiA5YPvHqaeLcqPuONAqRoaM2qwZ/k
	 BFvUStlzrkk8NO2uw3fbDhoxSpWY31B/uyi4ur/db8CaYcr7dFtRHKLj/StEFp6uuR
	 oO1kStVHPtJfG2kKfjJhCTIvwfec01EaAw5OGRMmAotQZnhisYHJGoxDDBVerri8KI
	 /v54qWhHXrbYraJ2OyJZ8OkxwYCGp0Q7MFkpYPvdXRaBYcr0ULkzd8gwqbuPVeXyyi
	 cZsm607b0hDfg==
From: SeongJae Park <sj@kernel.org>
To: flyingpenghao@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH]  damon: using pointer to access globally defined structures
Date: Thu, 11 Jul 2024 11:48:52 -0700
Message-Id: <20240711184852.431746-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240711081051.66560-1-flyingpeng@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peng,


Thank you for this patch!

On Thu, 11 Jul 2024 16:10:51 +0800 flyingpenghao@gmail.com wrote:

> From: Peng Hao <flyingpeng@tencent.com>
> 
> When KASAN is enabled and built with clang:
> mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds limit (2048) in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
> static int damon_lru_sort_apply_parameters(void)
>            ^
> 1 error generated.
> 
> This is because using local variables to obtain some global structure variables
> takes up a large amount of stack space.

checkpatch.pl complains this as below:

    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
    #17:
    This is because using local variables to obtain some global structure variables

Could you please wrap the line?

> 
> Changing to pointer access can solve it.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  mm/damon/lru_sort.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Also, I'd prefer having 'mm/damon/lru_sort: ' as the prefix of the subject of
this patch, instead of 'damon: '.  I think it makes the commit log easier to
understand and be consistent with other commits for DAMON.

> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 3de2916a65c3..357ca0b1b7c7 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -148,10 +148,10 @@ static struct damon_target *target;
>  static struct damos *damon_lru_sort_new_scheme(
>  		struct damos_access_pattern *pattern, enum damos_action action)
>  {
> -	struct damos_quota quota = damon_lru_sort_quota;
> +	struct damos_quota *quota = &damon_lru_sort_quota;
>  
>  	/* Use half of total quota for hot/cold pages sorting */
> -	quota.ms = quota.ms / 2;
> +	quota->ms = quota->ms / 2;

This means that ->ms of damon_lru_sort_quota is changed.  If
damon_lru_sort_new_scheme() is called repeatedly before the user re-write the
field via 'quota_ms' module parameter, the quota will continuously be reduced.
Which is a behavior that the user would never expected.

The problem comes from the fact that we're allocating 'quota' as a local
variable on stack.  How about making 'quota' be pointer, but for a
'damos_quota' object that dynamically allocated here other than the global
variable?  Then we can copy damon_lru_sort_quota content to it like before and
make more modification on the copy without making change to the global
variable.

>  
>  	return damon_new_scheme(
>  			/* find the pattern, and */
> @@ -161,7 +161,7 @@ static struct damos *damon_lru_sort_new_scheme(
>  			/* for each aggregation interval */
>  			0,
>  			/* under the quota. */
> -			&quota,
> +			quota,
>  			/* (De)activate this according to the watermarks. */
>  			&damon_lru_sort_wmarks);
>  }
> @@ -169,20 +169,20 @@ static struct damos *damon_lru_sort_new_scheme(
>  /* Create a DAMON-based operation scheme for hot memory regions */
>  static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>  {
> -	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
> +	struct damos_access_pattern *pattern = &damon_lru_sort_stub_pattern;
>  
> -	pattern.min_nr_accesses = hot_thres;
> -	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
> +	pattern->min_nr_accesses = hot_thres;
> +	return damon_lru_sort_new_scheme(pattern, DAMOS_LRU_PRIO);
>  }
>  
>  /* Create a DAMON-based operation scheme for cold memory regions */
>  static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>  {
> -	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
> +	struct damos_access_pattern *pattern = &damon_lru_sort_stub_pattern;
>  
> -	pattern.max_nr_accesses = 0;
> -	pattern.min_age_region = cold_thres;
> -	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
> +	pattern->max_nr_accesses = 0;
> +	pattern->min_age_region = cold_thres;
> +	return damon_lru_sort_new_scheme(pattern, DAMOS_LRU_DEPRIO);

Again, above changes to two functions make damon_lru_sort_stub_pattern, which
is a global variable that read by the two functions to be updated by them
without awareness of others.

For example, if damon_lru_sort_new_hot_scheme() is called after
damon_lru_sort_new_cold_scheme(), the pattern's max_nr_accesses would be not
'UNIT_MAX' but '0'.  This is again not what user-expected behavior.

So I'd suggest to use dynamic allocation and stub's content copying similar to
above.


Thanks,
SJ

>  }
>  
>  static void damon_lru_sort_copy_quota_status(struct damos_quota *dst,
> -- 
> 2.27.0
