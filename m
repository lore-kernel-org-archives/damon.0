Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A61A9F93
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619981; cv=none; b=ocRhjCHOJKM1iQPSRfFDak0Suc7EFACD4v0gieDH2WJl8+RA8cidHGyIJo5kF0ZqK1/+//G2XhPdSMAa6bQ1+MVP7nrcQKj5u6ixUDIHIS6X8fSJKXe0+Fg5SNze5wrnLtvLphAQ/B7IM+yTkpalo3wGoAnmh4JjazTtMYmxz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619981; c=relaxed/simple;
	bh=tgyKdpWmngsTLaAQMyDyCS7Kz3ujztVy3cpSjk1XSlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b28LfB7kDP2O9i1jn3+Hfdhq5ozxxVDAqywxaLdiQDIhEab0i8O/b59Ggwl1U4aKBi8Z5C2frFveFpwwibiVOQP3JtFkEyvnICB+i19fiqzSzObrHM26eaKJMZhQJZU0nxvMBxlRXXf44I8o0jlgKdAn+LRimCfgT/r/Max5FeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qecqNptH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qecqNptH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D686AC19423;
	Fri, 27 Mar 2026 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774619981;
	bh=tgyKdpWmngsTLaAQMyDyCS7Kz3ujztVy3cpSjk1XSlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qecqNptHMtRlwI6Q23NBhTSoSqWmvJUhM1iwbAU9rT0a7PDjS6DiszunK1elfMT8+
	 eKYpNOg2Gzw14Xr0Nxs295tyYPKBUhMjnAsvMR209NgkI16WfJ0QRlFlyToIOHOlOO
	 rLLyCxRC1i+OAmfRaeFU5+M/lLSNNRKWqXY1LaAl8p4gMKxOhkDHIK5F2pyn3Gp0zB
	 iFRb3aFnwJ3n4jbggG9gTtXUls5FBNDc0eLJ3PLZbHVIoZ0w6Sg6MT2oamtaG1F5Eg
	 Re7/AVvpCgmX9ZpzHDDj1suyyNbvwqVfIoAEbf9JPuJKrU/K8YneLJFs3Bug+ly7dc
	 vpULjqGpH123A==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v6] mm/damon: add synchronous commit for commit_inputs
Date: Fri, 27 Mar 2026 06:59:38 -0700
Message-ID: <20260327135939.4085-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327062558.66392-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

On Fri, 27 Mar 2026 14:25:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

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
> Changes from RFC-v5:
> - Removed unnecessary assignment in commit_inputs_store().
> - Return -EINVAL instead of -EBUSY when 'commit_inputs' is triggered
>   while kdamond is not running.
> - Link to RFC-v5: https://lore.kernel.org/20260325013939.18167-1-aethernet65535@gmail.com
> 
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
>  mm/damon/lru_sort.c | 42 +++++++++++++++++++++++++++++++++++-------
>  mm/damon/reclaim.c  | 42 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 70 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..453033f3cb3e 100644
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
> @@ -349,18 +348,47 @@ static int damon_lru_sort_apply_parameters(void)
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
> +		.repeat = false,

Undeclared fields are initialized to zero.  I don't think we need to explicitly
set repeat here.

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
> +		return -EINVAL;
> +
> +	err = damon_call(ctx, &control);
> +
> +	return control.return_code;

Shouldn't we return err if it is not zero?

[...]
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

Same comments can be applied to changes for this file.


Thanks,
SJ

[...]
