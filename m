Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E4171AF
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248012; cv=none; b=aV6a6lyXNgj8csYTFeecb3k07s9Uo/wLv156Y16mzmHU5+RWuN9rPPAN1YzBRPYIE52eTJQHYDrWoYqBTj9WeP+rpphPjt5qdeT+jlkWH/yt2dMGbTTtyGypNM8CWRJDxh30xW3g7EZkuAxpnZ4JQAPIw//dR01rgE7BcVRyK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248012; c=relaxed/simple;
	bh=tT/Ze44QBlKBc3tY7OXBEfmW287aZPD/LkRNLsv7I/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbVXeLZURr398cevbe6Bl9yqCGXKsFld0bnpc70HLLHlqswFOFelicUIhrlFRYznPCg7zEldGvThhiIncRNyQJeKwAna5xHQPWBTXkjo/xdY+CmQqeiBT3khw3uB34hbaVvbpNib7g8POPCqbeV+1zGINqZdKVh7hzNDTRdFr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWENdj4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWENdj4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E772C2BCAF;
	Mon, 27 Apr 2026 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777248012;
	bh=tT/Ze44QBlKBc3tY7OXBEfmW287aZPD/LkRNLsv7I/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aWENdj4mO1FlJJbojWaAMIgST4zHVaNLIquuLAbbwmBO7bkZLBB3pFjFwpRCcE/wI
	 TpVHr3nvYZT1qyuRTg5nAZ0iIBa+MFhmxvjH8xtDB1WurMdIEAfgAzutyApECmu+n9
	 IQTYFQtiQLVZ/NcUY7cU498fAvW43rC2BkBcTBqDJEUtczgfVOZAXXsJJjq7cTIfrw
	 zavY74Vqg8FXwR9XS0tj25wHey04PsPWcjNT2DZkgJ9b0dDzb4ELC6sWyJSqWczNk4
	 S1QsjXtebhdWAd/eGTfpRlMMcVgY5XyejnQNl00eoZF4PYk5IpZ4H0MR1srUiGg+xI
	 olLbqjX9XYwZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] mm/damon: add synchronous commit for
 commit_inputs
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260426231619.107231-4-sj@kernel.org>
References: <20260426231619.107231-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 00:00:11 +0000
Message-Id: <20260427000012.7E772C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Writing to the `commit_inputs` sysfs parameter before the DAMON wo=
rker thread (`kdamond`) is started causes the writing task to hang indefini=
tely in an unkillable D-state.
--

commit 43a70e5ab295c21c0b94eddd32d886c9d0eba3fa
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: add synchronous commit for commit_inputs

This commit changes the commit_inputs_store() callback to use damon_call()
to synchronously commit parameters in the kdamond thread's safe context.
This ensures validation errors are returned immediately to userspace.

Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.c=
om

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..641af42cc2d1 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -349,18 +348,51 @@ static int damon_lru_sort_apply_parameters(void)
>  	return err;
>  }
> =20
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
> +	struct damon_call_control control =3D {
> +		.fn =3D damon_lru_sort_commit_inputs_fn,
> +	};
> =20
> -	if (!commit_inputs)
> +	if (!val) {
> +		commit_inputs_request =3D true;
> +	} else {
> +		err =3D kstrtobool(val, &commit_inputs_request);
> +		if (err)
> +			return err;
> +	}
> =20
> +	if (!commit_inputs_request)
>  		return 0;
> =20
> -	err =3D damon_lru_sort_apply_parameters();
> -	commit_inputs =3D false;
> -	return err;
> +	/*
> +	 * Skip damon_call() if ctx is not initialized to avoid
> +	 * NULL pointer dereference.
> +	 */
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	err =3D damon_call(ctx, &control);

If the module has not yet been enabled (e.g., enabled=3DN) and the kdamond
thread is not running, does this call to damon_call() block indefinitely?

Since ctx is allocated during initialization, the ctx pointer is not NULL.
damon_call() then queues the control request and calls wait_for_completion(=
).

Without the background thread running to process the queue and signal
completion, it seems the sysfs writer task is placed into an unkillable
D-state forever.

The damon_call() documentation indicates it should only be called after
damon_start() has succeeded, otherwise it could fall into an indefinite wai=
t.

> +
> +	return err ? err : control.return_code;
>  }

[ ... ]

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..4fc4a54b5e54 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c

[ ... ]

> @@ -255,18 +254,51 @@ static int damon_reclaim_apply_parameters(void)
>  	return err;
>  }
> =20
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
> +	struct damon_call_control control =3D {
> +		.fn =3D damon_reclaim_commit_inputs_fn,
> +	};
> =20
> -	if (!commit_inputs)
> +	if (!val) {
> +		commit_inputs_request =3D true;
> +	} else {
> +		err =3D kstrtobool(val, &commit_inputs_request);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (!commit_inputs_request)
>  		return 0;
> =20
> -	err =3D damon_reclaim_apply_parameters();
> -	commit_inputs =3D false;
> -	return err;
> +	/*
> +	 * Skip damon_call() if ctx is not initialized to avoid
> +	 * NULL pointer dereference.
> +	 */
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	err =3D damon_call(ctx, &control);

Could this exhibit the same hang as in damon_lru_sort.c? If the worker
thread has not been started, does writing to commit_inputs block forever?

> +
> +	return err ? err : control.return_code;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426231619.1072=
31-1-sj@kernel.org?part=3D3
