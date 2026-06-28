Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E63B9DA4
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684600; cv=none; b=WehGK6aeU5j0KhMwtktiDDOp4ZZVp2G6/qoHu33E/ogDSzimPV2LXNH2z8vaupXBiYoQGqttiJpIai/DW/ijdJ0B5bgBH+/RPneMcElQWuL702O80SnstAbMB+K5IyHo4/YsaMGmhbktNT2QtMWMPlvjflFlsWhYP8Wcn2D6hY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684600; c=relaxed/simple;
	bh=W45K0Pef8V/8Zj0ZLvzaECEy3UI6C2Wa8xZccs50NNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HBx4Pvx7KNOmutp9bcXvJGjfL4ZeHw+QSjizqtAQ2BDjHOwNtJFlRRCsG6043IV9UDU7Y0naObvkTEzcxLMD6Tw2aJOM+UQnU0EThF1dL1V79J2WNwhT6acGUKDSICLMeNFaC6Swa4Xjs+tDgswBpXm/SrQVYwXtNodqhDTKO4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVDSxlbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVDSxlbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1971F000E9;
	Sun, 28 Jun 2026 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684597;
	bh=1lX0BmmOO4OYGWQFMViV0OIm5JYqsujvI2V54K643d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVDSxlbfUjQ/y++KDTW+CeGSuOfYRrnB6G8BL6bGr24/SrzS5u+wTmvAjFxOPhKPR
	 lMzL6QwlHnOf8RyIFTGmYgpxwtAtd1kJt1jFmS2TpIYS7Ud8D8qac/3tzEy63kJZjS
	 wHkrdLPiaKsTkbLyvCZOimMsV14aNFRx+Das1FVzNHzusfZnH2eJXcqeCdJM/W9s+A
	 65P9RgrpHZf39picN1q6n7Buay0k7ZeIbEg3cRHuO/Bns9Ikfpnqr0NYgZcdhZModr
	 g/nzwC9k9S6aoqBFsFh6UVaH1sZRjuQYU9SgJXNPaBbQY1lCh50DtwFrvyNAD4TYTv
	 eAnIyKaDZ93Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] samples/damon/mtier: handle damon_stop() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260628215447.96166-5-sj@kernel.org>
References: <20260628215447.96166-1-sj@kernel.org>
 <20260628215447.96166-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 22:09:56 +0000
Message-Id: <20260628220957.5C1971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of module initialization and sysfs parameter =
write leads to Use-After-Free and NULL pointer dereferences.
--

commit f7efff971c5dc6b095a484211734bb0e2a54f858
Author: SJ Park <sj@kernel.org>

samples/damon/mtier: handle damon_stop() failure
   =20
damon_sample_mtier_stop() assumes its damon_stop() call will always
successfully stops the two DAMON contexts. Hence it deallocates the two
DAMON contexts after the damon_stop() call.

Link: https://lore.kernel.org/20260609014219.3013-1-sj@kernel.org

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -199,7 +199,8 @@ static int damon_sample_mtier_start(void)
> =20
>  static void damon_sample_mtier_stop(void)
>  {
> -	damon_stop(ctxs, 2);
> +	damon_stop(ctxs, 1);
> +	damon_stop(&ctxs[1], 1);
>  	damon_destroy_ctx(ctxs[0]);

[Severity: High]
This is a pre-existing issue, but does this function have a concurrency race
with sysfs parameter writes during module initialization?

Sysfs parameter nodes are exposed before module_init executes. If a user
concurrently writes to the enabled sysfs parameter,
damon_sample_mtier_enable_store() can call damon_sample_mtier_stop() while
the module is still initializing:

samples/damon/mtier.c:damon_sample_mtier_init() {
        ...
        err =3D damon_sample_mtier_start();
        ...
}

If damon_sample_mtier_stop() runs before ctxs is initialized, couldn't this
lead to a NULL pointer dereference when we reach damon_destroy_ctx(ctxs[0])?

Alternatively, if it runs concurrently with damon_sample_mtier_start(),
could this cause a use-after-free since the module init function doesn't
seem to hold a lock to serialize with the sysfs store callback?

>  	damon_destroy_ctx(ctxs[1]);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628215447.9616=
6-1-sj@kernel.org?part=3D4
