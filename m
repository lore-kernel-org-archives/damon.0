Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91D1FC7C5;
	Fri,  3 Apr 2026 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775175824; cv=none; b=lTxXVqwH+94M67GdxCh8ZNZ7RMyxLeZPeSD0xO0wfS7/287xUdx6KAmwkpipD82zHErPHdxfZIae2c29bx67jPxjRKOfL/AGRKLVJ+1IidIMi1IFjR7r/KOiv6hXVtP4TX72YwA7hTxluUAEeQwNx52A560N25OK11u1T4iNHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775175824; c=relaxed/simple;
	bh=9qp9nWLMF6bx5eFIYhMlWNqj58aGJrCruOeJrkADFtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxPJeFLxx3MPNuMRCOWd5OIg3g0Ina3XZ9YLGeRQHVdBEiFAId6+t7fi61RC1FqTJeZWJ6EC09Sgg4bhSWHZlfID1243LNaBAONt0qcE1ejxGFMRQKhywXzZ8uCxDZo015ffFKLIdxJDY58Txph8mTUoFnsIvYWpYKvcRge/qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkS3gNYg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkS3gNYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D97C116C6;
	Fri,  3 Apr 2026 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775175824;
	bh=9qp9nWLMF6bx5eFIYhMlWNqj58aGJrCruOeJrkADFtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkS3gNYglurK0mCpjTEHZ/9Oj3xnLCxpWH6ktD59IkY7q3vxybcCMpIVHOooGk7Jw
	 yT6HKfCedJv8d0VezXASTPLZbXKkOfSxsLqqgwjoTQ2mu8lUIdhj52tOZUbmMfzO4T
	 a4YpgIzKczHoyqom0to8NTXQ+KloT2PISunlwnCNYDCAg8QjWeB414034KeZVxNHr7
	 NonVEG/tfQ2lbajwfAbTbuC+uS8ay5RHn1dFOknPuoJDaD+YTwEVPXFUABdTQJX5GO
	 mHJCTXlbnUYr9h138D8jMuakyXSoc8CMujga+CE1IeMyrMcV0+WTkiFfHwMXiuJXwS
	 gBRZJMYKXEugQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/damon: add synchronous commit for commit_inputs
Date: Thu,  2 Apr 2026 17:23:41 -0700
Message-ID: <20260403002342.46476-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402155733.77050-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Apr 2026 08:57:30 -0700 SeongJae Park <sj@kernel.org> wrote:

> From: Liew Rui Yan <aethernet65535@gmail.com>
> 
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
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Changes from v2
> (https://lore.kernelorg/20260329075415.36775-1-aethernet65535@gmail.com)
> - Rebase to latest mm-new.
> Changes from v1:
> - Restore the KERNEL_PARAM_OPS_FL_NOARG flag to keep the compatibility.
> - Link to V1: https://lore.kernel.org/20260328084524.5451-1-aethernet65535@gmail.com
> Changes from RFC-v6
> - Removed unnecessary assignment (repeat) in commit_inputs_store().
> - Change the return value; if an error occurs, return the error code.
> - Removed the RFC tag.
> - Link to RFC-v6: https://lore.kernel.org/20260327062558.66392-1-aethernet65535@gmail.com
> Changes from RFC-v5:
> - Removed unnecessary assignment (data) in commit_inputs_store().
> - Return -EINVAL instead of -EBUSY when 'commit_inputs' is triggered
>   while kdamond is not running.
> - Link to RFC-v5: https://lore.kernel.org/20260325013939.18167-1-aethernet65535@gmail.com
> Changes from RFC-v4:
> - Rename the 'yes' variable in commit_inputs_store() to the more
>   understandable 'commit_inputs_request'.
> - Return -EBUSY instead of -EINVAL when 'commit_inputs' is triggered
>   while kdamond is not running.
> - Link to RFC-v4: https://lore.kernel.org/20260323021648.6590-1-aethernet65535@gmail.com
> Changes from RFC-v3:
> - Added checks for 'ctx' and 'damon_is_running()' to prevent NULL
>   pointer dereference during early boot. (Found by Sashiko.dev)
> - Removed handle_commit_inputs() and its associated polling logic as
>   they have become dead code after moving to the synchronous damon_call()
>   approach.
> - Ensure the 'commit_inputs' is properly updated.
> Link to RFC-v3: https://lore.kernel.org/20260322231522.32700-1-aethernet65535@gmail.com
> Changes from RFC-v2:
> - Removed damon_validate_attrs(), now using damon_commit_ctx() for
>   synchronous validation in the kdamond context.
> - Following DAMON_SYSFS pattern for synchronous commit via damon_call().
> - Link to RFC-v2: https://lore.kernel.org/20260321140926.22163-1-aethernet65535@gmail.com
> Changes from RFC-v1:
> - Remove question from commit message area.
> - Added synchronous validation for DAMON_RECLAIM.
> - Rename damon_valid_attrs() -> damon_validate_attrs().
> - Exported a new function damon_validate_attrs() and declared it in
>   damon.h.
> - Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com
> 
>  mm/damon/lru_sort.c | 46 ++++++++++++++++++++++++++++++++++++++-------
>  mm/damon/reclaim.c  | 46 ++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 78 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..641af42cc2d1 100644
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
> @@ -349,18 +348,51 @@ static int damon_lru_sort_apply_parameters(void)
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
> +					      const struct kernel_param *kp)
> +{
> +	bool commit_inputs_request;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_lru_sort_commit_inputs_fn,
> +	};
> +
> +	if (!val) {
> +		commit_inputs_request = true;
> +	} else {
> +		err = kstrtobool(val, &commit_inputs_request);
> +		if (err)
> +			return err;
> +	}
>  
> -	if (!commit_inputs)
> +	if (!commit_inputs_request)
>  		return 0;
>  
> -	err = damon_lru_sort_apply_parameters();
> -	commit_inputs = false;
> -	return err;
> +	/*
> +	 * Skip damon_call() if ctx is not initialized to avoid
> +	 * NULL pointer dereference.
> +	 */
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	err = damon_call(ctx, &control);
> +
> +	return err ? err : control.return_code;
>  }
>  
> +static const struct kernel_param_ops commit_inputs_param_ops = {
> +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> +	.set = damon_lru_sort_commit_inputs_store,
> +	.get = param_get_bool,
> +};
> +
> +module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
> +
>  static int damon_lru_sort_damon_call_fn(void *arg)
>  {
>  	struct damon_ctx *c = arg;
> @@ -374,7 +406,7 @@ static int damon_lru_sort_damon_call_fn(void *arg)
>  			damon_lru_sort_cold_stat = s->stat;
>  	}
>  
> -	return damon_lru_sort_handle_commit_inputs();
> +	return 0;
>  }
>  
>  static struct damon_call_control call_control = {
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..4fc4a54b5e54 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -39,7 +39,6 @@ static bool enabled __read_mostly;
>   * re-reading, DAMON_RECLAIM will be disabled.
>   */
>  static bool commit_inputs __read_mostly;
> -module_param(commit_inputs, bool, 0600);
>  
>  /*
>   * Time threshold for cold memory regions identification in microseconds.
> @@ -255,18 +254,51 @@ static int damon_reclaim_apply_parameters(void)
>  	return err;
>  }
>  
> -static int damon_reclaim_handle_commit_inputs(void)
> +static int damon_reclaim_commit_inputs_fn(void *arg)
>  {
> +	return damon_reclaim_apply_parameters();
> +}
> +
> +static int damon_reclaim_commit_inputs_store(const char *val,
> +					     const struct kernel_param *kp)
> +{
> +	bool commit_inputs_request;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_reclaim_commit_inputs_fn,
> +	};
>  
> -	if (!commit_inputs)
> +	if (!val) {
> +		commit_inputs_request = true;
> +	} else {
> +		err = kstrtobool(val, &commit_inputs_request);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (!commit_inputs_request)
>  		return 0;
>  
> -	err = damon_reclaim_apply_parameters();
> -	commit_inputs = false;
> -	return err;
> +	/*
> +	 * Skip damon_call() if ctx is not initialized to avoid
> +	 * NULL pointer dereference.
> +	 */
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	err = damon_call(ctx, &control);
> +
> +	return err ? err : control.return_code;
>  }
>  
> +static const struct kernel_param_ops commit_inputs_param_ops = {
> +	.flags = KERNEL_PARAM_OPS_FL_NOARG,
> +	.set = damon_reclaim_commit_inputs_store,
> +	.get = param_get_bool,
> +};
> +
> +module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
> +
>  static int damon_reclaim_damon_call_fn(void *arg)
>  {
>  	struct damon_ctx *c = arg;
> @@ -276,7 +308,7 @@ static int damon_reclaim_damon_call_fn(void *arg)
>  	damon_for_each_scheme(s, c)
>  		damon_reclaim_stat = s->stat;
>  
> -	return damon_reclaim_handle_commit_inputs();
> +	return 0;
>  }
>  
>  static struct damon_call_control call_control = {
> -- 
> 2.47.3

Sent using hkml (https://github.com/sjp38/hackermail)
