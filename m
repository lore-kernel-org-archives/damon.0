Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810513B0AE9
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448962; cv=none; b=I9kiqy/yS/cV2jTGMtu4iAORCgU56fMD4R6+mtkZ0JL/UpkzYGPX61gFzaFUlZyiwo+7LBoWbQHuukvmtXjX2HmqwnrCW3MUvnxJbi7wWZJz8LpxX3hxpRVUX4zq9u7WvjR/gvD8vPb0nfbcshgbcpQHQvyNGU/xUPCi6w5jmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448962; c=relaxed/simple;
	bh=zkNO+kmO7YyIbGFRyvNSq0hpZ0emcBw0JOFFgh57z4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeV7x840Y1nyZ7m8c6dq+5HS96aVpM4KIChVA6KgXki4f0i0660JPdWi7JJbG9XwL0ZcsswAzfC6DiRnJ4ZMqQNWm/JbmCeuzlYd9oDSFErhTNtpRuODzwAK7xvtRyxGqbuH80kVlMliTUm0HHEMumkfDoFZRRQfKlARsM0EVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAi1x6xe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAi1x6xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4551EC4CEF7;
	Wed, 25 Mar 2026 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774448962;
	bh=zkNO+kmO7YyIbGFRyvNSq0hpZ0emcBw0JOFFgh57z4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAi1x6xeD+KtwLZfVNtI59E5LVvL9fks5GhoESNiKYd6b45jJ4dZ8YE3M4SoS8hLZ
	 LLYbVrkgwqrQpgcLAck9wtTc7cot5keSQ0dxzckxwjD3w4MCI9XiSeLl57jhfy/Ntk
	 ZIYq58HVN/LWfIx7YvYA1svz/Zww5NPdO2B/p2UucHNVBXrsU6xd8ZCyzwp2WnkCk/
	 Ew1HB+Ym/LxdvN411rN0KHXL+ZiLpY14tgmMOECIacSfSQoGVUi9nLgiikCw6r/lgb
	 66bYWLM2dsaSfc8+B5VpqEEqqkZDQg0C0FZ/KeGNhWbvVleAMiFSfERW5uzNlX4lKH
	 rgkTT+p9LTpJw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Wed, 25 Mar 2026 07:29:20 -0700
Message-ID: <20260325142920.87299-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325013939.18167-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 09:39:39 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
> silently (no error returned to shell), because the validation happens
> asynchronously in the kdamond.
> 
> Solution
> ========
> To fix this, the commit_inputs_store() callback now uses damon_call() to
> synchronously commit parameters in the kdamond thread's safe context.
> This ensures that validation errors are returned immediately to
> userspace, following the pattern used by DAMON_SYSFS.
> 
> Changes
> =======
> 1. Added commit_inputs_store() and commit_inputs_fn() to commit
>    synchronously.
> 2. Removed handle_commit_inputs().
> 
> This change is motivated from another discussion [1].
> 
> [1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> Changes from RFC-v4:
> - Rename the 'yes' variable in commit_inputs_store() to the more
>   understandable 'commit_inputs_request'.
> - Return -EBUSY instead of -EINVAL when 'commit_inputs' is triggered 
>   while kdamond is not running.
> - Link to RFC-v4: https://lore.kernel.org/20260323021648.6590-1-aethernet65535@gmail.com
> 
> Changes from RFC-v3:
> - Added checks for 'ctx' and 'damon_is_running()' to prevent NULL
>   pointer dereference during early boot. (Found by Sashiko.dev)
> - Removed handle_commit_inputs() and its associated polling logic as
>   they have become dead code after moving to the synchronous damon_call()
>   approach.
> - Ensure the 'commit_inputs' is properly updated.
> Link to RFC-v3: https://lore.kernel.org/20260322231522.32700-1-aethernet65535@gmail.com
> 
> Changes from RFC-v2:
> - Removed damon_validate_attrs(), now using damon_commit_ctx() for
>   synchronous validation in the kdamond context.
> - Following DAMON_SYSFS pattern for synchronous commit via damon_call().
> - Link to RFC-v2: https://lore.kernel.org/20260321140926.22163-1-aethernet65535@gmail.com
> 
> Changes from RFC-v1:
> - Remove question from commit message area.
> - Added synchronous validation for DAMON_RECLAIM.
> - Rename damon_valid_attrs() -> damon_validate_attrs().
> - Exported a new function damon_validate_attrs() and declared it in
>   damon.h.
> - Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com
> 
>  mm/damon/lru_sort.c | 54 +++++++++++++++++++++++++++++++++++++++------
>  mm/damon/reclaim.c  | 54 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..a2410f648b51 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -39,7 +39,6 @@ static bool enabled __read_mostly;
>   * the re-reading, DAMON_LRU_SORT will be disabled.
>   */
>  static bool commit_inputs __read_mostly;
> -module_param(commit_inputs, bool, 0600);
>  
>  /*
>   * Desired active to [in]active memory ratio in bp (1/10,000).
> @@ -349,18 +348,59 @@ static int damon_lru_sort_apply_parameters(void)
>  	return err;
>  }
>  
> -static int damon_lru_sort_handle_commit_inputs(void)
> +static int damon_lru_sort_commit_inputs_fn(void *arg)
>  {
> +	return damon_lru_sort_apply_parameters();
> +}
> +
> +static int damon_lru_sort_commit_inputs_store(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	bool commit_inputs_request;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_lru_sort_commit_inputs_fn,
> +		.data = ctx,

You don't really use the data in the callback function.  Why don't you just
unset it?

> +		.repeat = false,
> +	};
>  
> -	if (!commit_inputs)
> +	err = kstrtobool(val, &commit_inputs_request);
> +	if (err)
> +		return err;
> +
> +	if (!commit_inputs_request)
>  		return 0;
>  
> -	err = damon_lru_sort_apply_parameters();
> -	commit_inputs = false;
> -	return err;
> +	/*
> +	 * Skip damon_call() during early boot or when kdamond is
> +	 * not running to avoid NULL pointer dereference.
> +	 */
> +	if (!ctx)
> +		return -EBUSY;
> +
> +	err = damon_call(ctx, &control);
> +	if (err) {
> +		/*
> +		 * If kdamond is not running, damon_call() returns -EINVAL.
> +		 * Remap it to -EBUSY to better reflect that the operation
> +		 * failed due to the current state of the system.
> +		 */
> +		if (err == -EINVAL && !damon_is_running(ctx))
> +			return -EBUSY;

In my opinion, EINVAL is a better return value.  It was failed not because
something is busy but just because DAMON is not running.  Committing something
to DAMON while DAMON is not running seems invalid operation to me.

> +
> +		return err;
> +	}
> +
> +	return control.return_code;
>  }
>  
> +static const struct kernel_param_ops commit_inputs_param_ops = {
> +	.set = damon_lru_sort_commit_inputs_store,
> +	.get = param_get_bool,
> +};
> +
> +module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
> +
>  static int damon_lru_sort_damon_call_fn(void *arg)
>  {
>  	struct damon_ctx *c = arg;
> @@ -374,7 +414,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
>  			damon_lru_sort_cold_stat = s->stat;
>  	}
>  
> -	return damon_lru_sort_handle_commit_inputs();
> +	return 0;
>  }
>  
>  static struct damon_call_control call_control = {
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..4cbd67e08d56 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

Comments for lru_sort.c apply here, too.


Thanks,
SJ

[...]
