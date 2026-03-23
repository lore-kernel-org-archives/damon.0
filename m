Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BB3B95FD
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278352; cv=none; b=bUQQqxKzF4h8yHW8rG3z9KyCfu+ztc+R40wxEfNyWvjBfUK1PM9Ja6HUegMGBhVoisT6vaJaZD0Kq+aFn5EAqxwYd6he2jIlGIjLV3JUMUFXa3TsAMDlSBDPD50JQhyOUAyUHHlOguVCAAAg9FQ10wZKdo6yAqChI4N/0HNe+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278352; c=relaxed/simple;
	bh=Dw+7MMaMQYVgrLVNbToYkgZbnN09PQLsaBBhAF1dW7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUQfTPm/BKFxkpQyBIeuEZSpm9+uXYeCNFMVeM7NCl93osci6fxIdiZtuy2cEbuwqi35aYajiBmxvSO2HkKj6c/tmDAcWxN8S2o2ODHKw8qh6rTl/RV7jEy4Te5uJiM4mAIX8O/6tJnpkw2FWOLaFq+xifpyT6wD9sXFWSOoxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4zgnloD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4zgnloD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9D1C2BCB5;
	Mon, 23 Mar 2026 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774278352;
	bh=Dw+7MMaMQYVgrLVNbToYkgZbnN09PQLsaBBhAF1dW7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4zgnloD5Ld9sxjTmn1ZucqqjF073qyBWmlVhmGnQNrp+pkN2vbGr8wQRGsnfRsfr
	 5Ph7dKosRX92Y10jcxpl86kUSET6Flb6skBME6HgpusGLi17Z0azIVraApT8exZ64r
	 eqlbHtwE0Qvh5Pj7xQswycB2rwMK7wSqr1McPPtoB6Wtxx3ImOKLT4LTzx3u02QjSm
	 JHYhKY4xD/W/uUnnQKmTJX2LDLuVIl5QoPd2/CUGygzHfCNWJovxR+OMo11RI4gVAk
	 g5BuGNZA8mgeUJMBw8T/mz41V0/cMEpx54N2ri2WIRLxWxNoVN4vuKqwBaB5QyN99b
	 oqbMl5YDnZATg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 08:05:43 -0700
Message-ID: <20260323150544.81042-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323021648.6590-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 10:16:48 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

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
> Changes from RFC-v3:
> - Added checks for 'ctx' and 'damon_is_running()' to prevent NULL
>   pointer dereference during early boot. (Found by Sashiko.dev)

I'd prefer archiving sashiko question on the mailing list so that others can
also read it without have to visit the web site.  Please consider doing so.

FYI, because such sharing is not very comfortable for now, I developed new hkml
features [1] for helping such sashiko review sharing, and I'm using the
feature.  Please fee free to use it if you think it can help you, too.

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#sashikodev

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

Thank you for adding the detailed revision changes.

But, please consider waiting about one day before posting a new version, so
that we have enough time to discuss on the previous version.  If you find
something you want to change on the next version, you can comment that to the
current version of the patch and give time for others to comment about the next
revision plan if they have any opinion.

> 
> Changes from RFC-v1:
> - Remove question from commit message area.
> - Added synchronous validation for DAMON_RECLAIM.
> - Rename damon_valid_attrs() -> damon_validate_attrs().
> - Exported a new function damon_validate_attrs() and declared it in
>   damon.h.
> - Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com
> 
>  mm/damon/lru_sort.c | 49 +++++++++++++++++++++++++++++++++++++++------
>  mm/damon/reclaim.c  | 49 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 86 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..37b3c897e822 100644
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
> @@ -349,18 +348,56 @@ static int damon_lru_sort_apply_parameters(void)
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
> +	bool yes;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_lru_sort_commit_inputs_fn,
> +		.data = ctx,
> +		.repeat = false,
> +	};
>  
> -	if (!commit_inputs)
> +	err = kstrtobool(val, &yes);
> +	if (err)
> +		return err;

I was not very sure what 'yes' means.  How about renaming it, say,
'commit_inputs_request' ?

> +
> +	if (commit_inputs == yes)
>  		return 0;
>  
> -	err = damon_lru_sort_apply_parameters();
> +	if (!yes) {
> +		commit_inputs = false;
> +		return 0;
> +	}

I'd prefer doing !yes check before 'commit_inputs == yes' check.  That
eliminates false request case earlier, make my brain cleaner.

> +
> +	commit_inputs = yes;

We will anyway set this 'false' after damon_call().  Before returning this
function, users cannot read commit_inputs parameter since this callback is
protected by param_lock.  I think we don't need to change commit_inputs value
at all?

> +
> +	/*
> +	 * Skip damon_call() during early boot or when kdamond is idle
> +	 * to avoid NULL pointer dereference or unexpected -EINVAL.
> +	 */
> +	if (!ctx || !damon_is_running(ctx))
> +		return 0;

damon_call() handles !damon_is_running() case.  So I think you should check
only !ctx.

Also, this exposes commit_inputs true.  Next 'Y' write to commit_inputs will
make no effect?  Again, it seems we shouldn't change commit_inputs at all.

> +
> +	err = damon_call(ctx, &control);
>  	commit_inputs = false;

Again, seems this is not really necessary.

> -	return err;
> +
> +	return err ? err : control.return_code;
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
> @@ -374,7 +411,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
>  			damon_lru_sort_cold_stat = s->stat;
>  	}
>  
> -	return damon_lru_sort_handle_commit_inputs();
> +	return 0;
>  }
>  
>  static struct damon_call_control call_control = {
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..441d5d9f9eab 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

Similar comments should be applied to DAMON_RECLAIM part changes, too.


Thanks,
SJ

[...]
