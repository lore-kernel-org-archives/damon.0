Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A42571B8
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783189921; cv=none; b=pZoQnel4qf5Ew6b2K/LJdNRJSJF2iFi0I92nVn3DaWPhfeH7XhUn9ssjuqz1hpFTxj794pTr0Go29YW3F5GRTWbhbquydDIa2RHsS+/272T4yc67mgSIfvskR6sN9+j+0T+SELTSKdxoylh1VplW8nWNxs2CtK3B3xRX73mGbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783189921; c=relaxed/simple;
	bh=P6WXw2RcV5Z6R3uD9nzg0Ov1uJuV8DNsmhWDXXCoKME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=loEHRau7ASgnpDhCHr7ZBjQ4j5Agb3Ca14/KbCq5b5E40kqyFXAI51RejPK1Rk7lXQXy8J3qnLqeV+VwtCEZ6b4vgmg2e9RobRLfBXgexL7jWcRVe/MMifNylimHjL1dBGvDdgR6UbePhva6z44MOO9oxsBleFJBrJ0n1StvPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb57tLQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb57tLQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D791F000E9;
	Sat,  4 Jul 2026 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783189920;
	bh=Zc0m7+Vsbg7GO5eykF44TftMKzYv2Gdr4vjqNhoyw5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fb57tLQx4Bwti8PNF5HsdqgYV2q07tooydA94gUmsMFwGex2J9ey1UknIOo0Ejrxd
	 uKxgMbl/4GYRG0hACbBWU75Vuy6ndIS3N6nHsy3FjBiXb2lszKMdX9PgaViKMr/4Ks
	 5I27w9314BHAUqBVuv+TGA6PTbIBj+WteYOT7oEtDQ/SN7XTPxea021aiMcSk9+ODd
	 ATW7th96KkUbg+aipsyECG6UjNIufVr2kArYoHm2aErOWVB/8F7WRWOuoDcZ7u+ZH9
	 m1Jh4DUKNIzDqecz3NFcLXr1purwcmpZRM4TkQpBb82bNNt8ADWXLpAImwBw2qQE+H
	 kVWHM761Bly3Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/11] samples/damon/wsse: do not stop ctx for
 damon_call() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260704181135.132956-11-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
 <20260704181135.132956-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:31:59 +0000
Message-Id: <20260704183159.E0D791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A self-deadlock occurs in `damon_start()` if a subsequent context =
fails to start.
--

commit 2f9c1f0eae64d458e95f8baff7b56262e634bb2f
Author: SJ Park <sj@kernel.org>

samples/damon/wsse: do not stop ctx for damon_call() failure

This commit modifies the error handling path in damon_sample_wsse_start()
when damon_call() fails. It removes the explicit call to damon_stop()
because damon_call() is updated to stop the context on its own.

> diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
> index ff5e8a890f448..37fd5da201588 100644
> --- a/samples/damon/wsse.c
> +++ b/samples/damon/wsse.c
> @@ -93,10 +93,8 @@ static int damon_sample_wsse_start(void)
>  	}
>  	repeat_call_control.data =3D ctx;
>  	err =3D damon_call(ctx, &repeat_call_control);
> -	if (err) {
> -		damon_stop(&ctx, 1);
> +	if (err)
>  		damon_destroy_ctx(ctx);
> -	}
>  	return err;
>  }

[Severity: High]
Does this code expose a self-deadlock in damon_start() if a context fails to
start?

When damon_sample_wsse_start() calls damon_start() earlier in the execution,
it iterates over the contexts and calls __damon_start() to spawn a kdamond
thread for each, all while holding damon_lock. If __damon_start() fails, the
error handling path calls damon_stop() to tear down the already-started
contexts:

mm/damon/core.c:damon_start() {
    ...
    mutex_lock(&damon_lock);
    ...
        err =3D __damon_start(ctxs[i]);
        if (err) {
            damon_stop(ctxs, i);
            break;
        }
    ...
}

damon_stop() internally calls __damon_stop(), which invokes kthread_stop_pu=
t()
to synchronously wait for the running kdamond thread to exit.

However, when the exiting kdamond thread finishes its main loop and cleans =
up,
it attempts to acquire damon_lock to decrement nr_running_ctxs:

mm/damon/core.c:kdamond_fn() {
    ...
    mutex_lock(&damon_lock);
    nr_running_ctxs--;
    if (!nr_running_ctxs && running_exclusive_ctxs)
        running_exclusive_ctxs =3D false;
    mutex_unlock(&damon_lock);
    ...
}

Because the original thread executing damon_start() is still holding
damon_lock while waiting for the kdamond thread to exit, can this result
in a permanent ABBA deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704181135.1329=
56-1-sj@kernel.org?part=3D10
