Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF690285CAA
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407205; cv=none; b=Wyq46AZAMTczQUwXeOwlbOCGVvw3ChJUPJy0/p9DSbaPjNVpd/sJzkqDgCDKjUA39FaigAAxti8py/+mdozLGADMSX+b5wmKRYLbShZ5SNOECZ1AsL3jJWXVrz9cM45xAOtCxlsPGganOFWzbHd+ySYXY2Ca0yX4rS6I1UL+1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407205; c=relaxed/simple;
	bh=9WOf1K1dbf9+9pgjiz2eJYCj8xI0zOxa68b/VvHN8pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/GcZAB/8QnPYG5AoCWriDkTjScZFu2+CQkjIIc3li0e8Iv6LkZcBJ0ZFgM7niAYthdB3ugtbqEwf4/VtAhweGgJ70wOxjSQDlJa4CCYHyxK9MJPDzUM3Iza2u7dkqu2cZfq3nmEuMimZX2F+s3I27IhT0f6rJFfZmuQjnFfB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmYINUJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmYINUJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765AC19424;
	Wed, 25 Mar 2026 02:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774407205;
	bh=9WOf1K1dbf9+9pgjiz2eJYCj8xI0zOxa68b/VvHN8pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmYINUJveBPg4slR9ROjzQYgRJRo99Y/c7i2+uUXgMjwyOZ0mvozj/EVQcelfzYN3
	 LTySjyzYVF3e7oibxnjJGzQhoREJMYKEvJ/cpQWYSUbF5HyFWCJR6GqMqMoc28muE9
	 LG1MlvNcUYUJ7irscjqOWsaTkxQMradBgDrHDM1sgKHTwFUNntBT/MIO3/MKVN3GtH
	 kEw6Cd/2smwKJHbZ6F7NOz3lURDuniXWiXSHYGTo92vcWwKjSzFHrkdbeUMTf1B+2B
	 o2q3KJGT8gVa0DindVL2RnBQT9zRIXlZebvE+22n8k+Lf8NwLUU+AFt8VSGS/ZabIZ
	 MAmh6Gl8QlSNQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC v5] mm/damon: add synchronous commit for commit_inputs
Date: Tue, 24 Mar 2026 19:53:16 -0700
Message-ID: <20260325025317.86571-1-sj@kernel.org>
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

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260325013939.18167-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 60ccea4154b0c58741fae2323454a5a9496b67fa
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: add synchronous commit for commit_inputs

Writing invalid parameters to sysfs followed by commit_inputs=Y previously
failed silently. This patch uses damon_call() to synchronously commit
parameters in the kdamond thread's safe context, returning validation errors
immediately to userspace.

Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..a2410f648b51 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> +static int damon_lru_sort_commit_inputs_store(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	bool commit_inputs_request;
>  	int err;
> +	struct damon_call_control control = {
> +		.fn = damon_lru_sort_commit_inputs_fn,
> +		.data = ctx,
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

Can this sequence lead to a system-wide deadlock on kernel_param_lock?

Because damon_lru_sort_commit_inputs_store() is a sysfs .set callback, it
executes with the global kernel_param_lock held.

If kdamond_fn terminates (e.g., due to an invalid parameter like addr_unit=3
causing a non-power-of-2 min_region_sz), it processes its exit sequence by
calling kdamond_call(ctx, true) to flush pending requests. After flushing, it
eventually sets ctx->kdamond = NULL at the very end of the thread.

If a user writes to commit_inputs exactly in the window after
kdamond_call() finishes but before ctx->kdamond = NULL is set:

Thread 1 (kdamond_fn):
    kdamond_call(ctx, true);

Thread 2 (sysfs write):
    damon_call(ctx, &control);
        if (damon_is_running(ctx))
            wait_for_completion(&control.completion);

Thread 1 (kdamond_fn):
    ctx->kdamond = NULL;

Thread 2 will sleep indefinitely in wait_for_completion(). Because Thread 2
holds the global kernel_param_lock, this permanently freezes all module
parameter sysfs interfaces system-wide.

> +	if (err) {
> +		/*
> +		 * If kdamond is not running, damon_call() returns -EINVAL.
> +		 * Remap it to -EBUSY to better reflect that the operation
> +		 * failed due to the current state of the system.
> +		 */
> +		if (err == -EINVAL && !damon_is_running(ctx))
> +			return -EBUSY;
> +
> +		return err;
> +	}
> +
> +	return control.return_code;
>  }

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..4cbd67e08d56 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> +	/*
> +	 * Skip damon_call() during early boot or when kdamond is
> +	 * not running to avoid NULL pointer dereference.
> +	 */
> +	if (!ctx)
> +		return -EBUSY;
> +
> +	err = damon_call(ctx, &control);

Does this code share the same kernel_param_lock deadlock potential as
damon_lru_sort_commit_inputs_store() described above?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260325013939.18167-1-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260325013939.18167-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
