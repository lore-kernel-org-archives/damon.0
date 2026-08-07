Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085543C2796
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096053; cv=none; b=laJtFkkd5hz8Jjgd7e+GtJG9UP8sEXEGpqjtFU4mBvCx1ScR6mWDlYTEBW8mSU6HfogBfFnJneuHPOrsnT9w62zENZTtw67NyF5c5Dp4Rpc+89MwFhwndR2d6ZDSEjiKZilzMZnVV2zkOwTFqBbdsWqX0LjiLTdoRuazg/QZX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096053; c=relaxed/simple;
	bh=fVWxNTc2DkjHcj6nM/Tt5YN8kLD6GGAmChuvCFS12ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYtX1qmqLLRdVzEGrpRGxMTf7b2P7XlPXfDNtAjQO+Ug29UGTgJO0EyAzMiQ+HNDFWjymQ4N+krxUqqm9AmsvONtvPEnWfw9WHKxqg35+mKrnM5Z29QWEKXK/FhmU+yaPZPcp6pEgId85WlE/WUY2koP/TZxGUr58pwzg1fvNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggVCXbWL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggVCXbWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9122F1F000E9;
	Fri,  7 Aug 2026 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096051;
	bh=s4TQeKTH1uFar/nkc+iMmLqah1YqoTjapvGfC//Gb4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggVCXbWLiw6V8r/qOTVIOqRRAEbYNKQHK/pUjfUOJ/fpcUL7n9plXiedXpibWlZQQ
	 k7PQY+AL6fKJ0pgAN9wmudNUUMvMdk1dEXYLjgbVZ0Qomfx/TzCIMndqpSKvUTztJL
	 aBgLI7nALAyhdFNKHE/MELi+B/x/nhGLn/c19D3pgcmDBSEnjUpdOwoyicwU8xVDW1
	 8SB2ww4JBu2E72zwxBMJNv6PyxmGAvzZn+AkMFpT4jIWvZRfEVcTcJXpEtL8Di/EjM
	 wXKHS40UjdY8Sorq3E/tzhfQ+aMdfBpuueGeYtBV3nNGWI1ZInAdCJN5ty1qZo1Sp5
	 O/ek8rSE0rIOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark
 checks and add fallback sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260807093526.183009-3-aethernet65535@gmail.com>
References: <20260807093526.183009-1-aethernet65535@gmail.com>
 <20260807093526.183009-3-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:47:31 +0000
Message-Id: <20260807094731.9122F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kdamond_wait_activation() traps kdamond in an infinite sleep loop =
when no schemes are registered, completely breaking pure access monitoring.
--

--- Patch [2]: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark =
checks and add fallback sleep ---
commit 7f4aa250c9a91aca4f1a7a02df1c14e1ab990d4e
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: skip deactivated schemes in watermark checks and add fallback sle=
ep

This commit modifies scheme evaluation to skip those deactivated either by
watermarks or max_nr_snapshots. It also changes kdamond_wait_activation()
to sleep for the sample interval as a fallback when all schemes are
deactivated.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3704,16 +3711,23 @@ static int kdamond_wait_activation(struct damon_c=
tx *ctx)
> =20
>  	while (!kdamond_need_stop(ctx)) {
>  		damon_for_each_scheme(s, ctx) {
> +			if (s->max_nr_snapshots &&
> +				s->max_nr_snapshots <=3D s->stat.nr_snapshots)
> +				continue;
> +
>  			wait_time =3D damos_wmark_wait_us(s);
>  			if (!init_wait_time || wait_time < min_wait_time) {
>  				init_wait_time =3D true;
>  				min_wait_time =3D wait_time;
>  			}
>  		}
> -		if (!min_wait_time)
> +		if (!min_wait_time && init_wait_time)
>  			return 0;
> =20
> -		kdamond_usleep(min_wait_time);
> +		if (min_wait_time)
> +			kdamond_usleep(min_wait_time);
> +		else
> +			kdamond_usleep(ctx->attrs.sample_interval);

[Severity: High]
Does this change cause a regression where kdamond becomes trapped in an
infinite sleep loop if no schemes are configured?

When a user starts DAMON for pure access monitoring without configuring any
schemes, the damon_for_each_scheme() loop is bypassed. This leaves
init_wait_time as false.

Because init_wait_time is false, the condition
if (!min_wait_time && init_wait_time) will fail. The function then falls
through to the new fallback logic:

    kdamond_usleep(ctx->attrs.sample_interval);

Since init_wait_time remains false on every iteration of the while loop,
kdamond_wait_activation() will never return 0. Could this permanently hang
the monitoring thread and prevent it from collecting any access metrics?

> =20
>  		kdamond_call(ctx, false);
>  		if (ctx->maybe_corrupted)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807093526.1830=
09-1-aethernet65535@gmail.com?part=3D2
