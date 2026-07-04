Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B1372ED7
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783189804; cv=none; b=RWmWqaDcTpgX4g7e6lll/itOf1On5tL1rwovBnVeBEcJ3G9d7MNyjlBREq/MiN9Br8Ij8SNNHKj9HyLHzBHYnGJLJaQo6TJ6aF037soA6SRO/IMB3/jrQon9muUteyH4auBK3sfmnbxqK5gpHak5aHul/OGhTkuOSxyijLCBuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783189804; c=relaxed/simple;
	bh=USZsIByY2F0SEkgcAv3ZY5Fij52ALQ4lzIcBUBj01nA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MkwM3TO8lCpIrtuDWz0Mzo/jt0Nkn4zOieJ6QQOQ8B1rhht1IukJeKghMXFLT3qdVbjJYWwBEP9RtVGYad4DTxH6oFUrEiGPObfqbS+WFpHMSkse7mQJCHyEZ3c2SW395wz2zASJ8z8pVmPs5zwQHPaWq/EV1iGe9SAANMVNMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt79MfCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt79MfCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219C81F000E9;
	Sat,  4 Jul 2026 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783189803;
	bh=2dNLcRjZBaOuo0XhgDhNbtpgFo+H6nz5DMhF8ZXvEXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dt79MfCJ1o/pHFbGm5G4yt3RIUEjM3/WuEeV9X3z/rrkeALyKT13etk5ZCWgF7Zxn
	 cNLHuozmkiYHQ9MK1SdT9cE245Nc8LDF7SBic94DoqZ8xneRAjO+/pjjtB09yFjPn6
	 oC+NPA2tCA8cj0fHHso4Wv//QvilcalDsgPC0M9IoqMvxvmNcoltyrg7bk6N6QOxYq
	 yI7snbdMqI1k/bHhC5I2lOAIReBxGalFFuNx4jP5gkPxa4fnOd53N4fILCggMQtHfD
	 HXXv/QyGcKBBJ59mObLyHyuTKrfEJN+0Jg2gd+3hpMRPTWh3XyO+vdKuxBQeM1FTsq
	 76aEsPjn3kyKQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/11] mm/damon/core: make damon_stop() never fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260704181135.132956-4-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
 <20260704181135.132956-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:30:02 +0000
Message-Id: <20260704183003.219C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] AB-BA deadlock in damon_start() error path when failing to start m=
ultiple contexts.
--

commit c787674782fb673ed8c1babcfb03eca187f10a1d
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: make damon_stop() never fails

This commit modifies damon_stop() and __damon_stop() to return void instead
of an error code. This simplifies the error handling in damon_stop() since
it no longer needs to break out of the loop on failure.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 45aa9acef4e30..0845d6b151f81 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1865,31 +1863,24 @@ static int __damon_stop(struct damon_ctx *ctx)
[ ... ]
>  /**
>   * damon_stop() - Stops the monitorings for a given group of contexts.
>   * @ctxs:	an array of the pointers for contexts to stop monitoring
>   * @nr_ctxs:	size of @ctxs
> - *
> - * Return: 0 on success, negative error code otherwise.
>   */
>  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
>  {
> -	int i, err =3D 0;
> +	int i;
> =20
> -	for (i =3D 0; i < nr_ctxs; i++) {
> +	for (i =3D 0; i < nr_ctxs; i++)
>  		/* nr_running_ctxs is decremented in kdamond_fn */
> -		err =3D __damon_stop(ctxs[i]);
> -		if (err)
> -			break;
> -	}
> -	return err;
> +		__damon_stop(ctxs[i]);

[Severity: High]
Does calling damon_stop() here result in an AB-BA deadlock during a partial
startup failure?

While this issue was introduced by an earlier patch in the series, it remai=
ns
present here. If damon_start() successfully starts the first context but fa=
ils
to start a subsequent one, it calls damon_stop() while still holding
damon_lock:

mm/damon/core.c:damon_start() {
    ...
    mutex_lock(&damon_lock);
    ...
    for (i =3D 0; i < nr_ctxs; i++) {
        err =3D __damon_start(ctxs[i]);
        if (err) {
            damon_stop(ctxs, i);
            break;
        }
        nr_running_ctxs++;
    }
    ...
    mutex_unlock(&damon_lock);
}

Inside damon_stop(), __damon_stop() calls kthread_stop_put(), which blocks
waiting for the running kdamond thread to exit. However, kdamond_fn() must
acquire damon_lock to decrement nr_running_ctxs before it can complete its
exit:

mm/damon/core.c:kdamond_fn() {
    ...
done:
    ...
    mutex_lock(&damon_lock);
    nr_running_ctxs--;
    ...
    mutex_unlock(&damon_lock);
    return 0;
}

Can this cause damon_start() and the kdamond thread to deadlock waiting for
each other?

> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704181135.1329=
56-1-sj@kernel.org?part=3D3
