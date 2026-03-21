Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAC175A80
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112786; cv=none; b=fV97OrZpWesyLcLV1eb2V2JZuS+iAsK63xGpOKmdCrC8ZwyDA7F/KN334uGghv1DNCssrR7XG88gxc1GK5Hr5+mVxiGlbHxMs/C7X2Cwb2zt1g0jRiwWqUGf+svjORGFw8Wz/VX2qpi63qtUU2aCcsRWT9Ap4JNDig6NqRFlAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112786; c=relaxed/simple;
	bh=0zSg2d5xtZ4jTHhBSNs+uwXApZmV7XKUPMr6CJQqSRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrJ3CFqT/TsPR2Fj1OwubdfJEFNN9UGqPYiNoAS+3vbcA3bVGwGKbw0l0KKnrTcnNUqsmQbsoQTYGATQZdabl4YcmbWUN2ALV9rCAaTGU5Ad1xJIoHtgybFUZ56YfswJD/fwjZ1qM3yfAH/JhJZEdPKrbU7ST24q81gUhcg3YWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNbvBs9E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNbvBs9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C51C19421;
	Sat, 21 Mar 2026 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774112785;
	bh=0zSg2d5xtZ4jTHhBSNs+uwXApZmV7XKUPMr6CJQqSRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNbvBs9EFfhezdV8+SZlR1YUMGvLg4e+gb+pYmDE5sa/MzP1+IukHTlUCDZ/z9YED
	 7eUXn4AZDFcCi2abUF4cHQwbeXzu4Re+1rzgSSEpqjemJZCBa4EXvuKpVatnqQslIm
	 LJ56adId9xDBIBq2ZdB7MR+t/ROvSyxxZhSCFUMcRn7XtEBeTr8RBT6u7XwxdsWit0
	 UDrGW9ZJ2kAmwxn7I9IMFBmhpXGy7fR2tEbfB1eUWqfI36wBSzBZo6EGBD2GTJ9tuc
	 ciP0/K3rjKi1ovRFCLgi7qFNB45bKfbVR0ABEq41fs/sSv/thb9OWoXpNKPVvWspjE
	 lZthCnKlAxJug==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: (Sashiko) Re: [RFC v2] mm/damon: add synchronous validation for commit_inputs
Date: Sat, 21 Mar 2026 10:06:22 -0700
Message-ID: <20260321170623.84638-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321140926.22163-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing the discussion on the mailing list.

# review url: https://sashiko.dev/#/patchset/20260321140926.22163-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 05e8b12e4fe302bfaf2b30ee9c0d38b036fc1c5e
Author: Liew Rui Yan <aethernet65535@gmail.com>
Subject: mm/damon: add synchronous validation for commit_inputs

This commit adds synchronous validation to the sysfs commit_inputs parameter
for the DAMON lru_sort and reclaim modules. It aims to return immediate
feedback to userspace if the provided monitoring attributes are invalid,
rather than failing silently in the background.

Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..22136486e745 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -751,6 +751,27 @@ static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
>  	return true;
>  }
>  
> +/**
> + * damon_validate_attrs() - Check if the given DAMON attributes are valid.
> + * @attrs:		attributes to be checked
> + *
> + * Return: 0 if valid, negative error code otherwise.
> + */
> +int damon_validate_attrs(struct damon_attrs *attrs)
> +{
> +	if (!damon_valid_intervals_goal(attrs))
> +		return -EINVAL;
> +	if (attrs->min_nr_regions < 3)
> +		return -EINVAL;
> +	if (attrs->min_nr_regions > attrs->max_nr_regions)
> +		return -EINVAL;
> +	if (attrs->sample_interval > attrs->aggr_interval)
> +		return -EINVAL;

Does this validation fully prevent silent asynchronous failures?

If a user writes 0 to sample_interval or aggr_interval, the check 
attrs->sample_interval > attrs->aggr_interval will pass (since 0 > 0 is
false), returning success to the shell.

Since the daemon's actual application logic requires non-zero intervals,
will this still fail silently in the background for zero values?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(damon_validate_attrs);

Is this EXPORT_SYMBOL() necessary? 

Since both DAMON_RECLAIM and DAMON_LRU_SORT are built into the kernel and
cannot be compiled as loadable modules, does this need to be exported to the
global symbol table? None of the other DAMON core functions in this file
appear to be exported for this reason.

[ ... ]
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..883860721d3b 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
[ ... ]
> @@ -361,6 +360,39 @@ static int damon_lru_sort_handle_commit_inputs(void)
>  	return err;
>  }
>  
> +static int damon_lru_sort_commit_inputs_store(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	struct damon_attrs attrs;
> +	bool yes;
> +	int err;
> +
> +	err = kstrtobool(val, &yes);
> +	if (err)
> +		return err;
> +
> +	if (commit_inputs == yes)
> +		return 0;
> +
> +	if (!yes)
> +		return 0;

If a user writes 'N' to the sysfs parameter, yes evaluates to false and this
returns success without updating commit_inputs.

If commit_inputs was previously 'Y' (waiting for kdamond to process it),
does this prevent administrators from aborting a pending parameter commit?

> +
> +	attrs = damon_lru_sort_mon_attrs;
> +	err = damon_validate_attrs(&attrs);

Will this synchronous validation reject valid configurations if
autotune_monitoring_intervals is enabled?

The actual parameter application logic in damon_lru_sort_apply_parameters()
overwrites sample_interval and aggr_interval with hardcoded defaults when
autotuning is on. 

Because this validation happens before those overrides are applied, will a
user who leaves sample_interval > aggr_interval receive a false -EINVAL error
even though the configuration would be safely overridden?

> +	if (err)
> +		return err;
> +
> +	commit_inputs = yes;
> +	return err;
> +}
[ ... ]
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..6ea44b02cc76 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
[ ... ]
> @@ -267,6 +266,39 @@ static int damon_reclaim_handle_commit_inputs(void)
>  	return err;
>  }
>  
> +static int damon_reclaim_commit_inputs_store(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	struct damon_attrs attrs;
> +	bool yes;
> +	int err;
> +
> +	err = kstrtobool(val, &yes);
> +	if (err)
> +		return err;
> +
> +	if (commit_inputs == yes)
> +		return 0;
> +
> +	if (!yes)
> +		return 0;

Similar to the lru_sort module, does returning 0 here without clearing
commit_inputs prevent users from aborting a pending commit by writing 'N'?

> +
> +	attrs = damon_reclaim_mon_attrs;
> +	err = damon_validate_attrs(&attrs);
> +	if (err)
> +		return err;
> +
> +	commit_inputs = yes;
> +	return err;
> +}
[ ... ]


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260321140926.22163-1-aethernet65535@gmail.com
