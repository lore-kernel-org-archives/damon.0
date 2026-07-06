Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BDE298CA3
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347710; cv=none; b=KHX25MjrusJzc7RXUE5Q7pbOoHTVHjE/ZmFCx2gB0ZYsTz1MQvpjwRxAyzDMNZreaX7vvU2oj7sS2I8/sQbDw55GjIpom574PT0Nfxk+GBdX1iWSkpS48yjRSDeHtp/hg+0EErrC2Lj+NbveE0kMGeKRsWxMEtD1dWhjGm+8HC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347710; c=relaxed/simple;
	bh=zUPugoWgBCjLLmKGR4wur7kdZsLbjbrLTtrHypmPtvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GZHW41SnJa37Wa5Tn+y7z0DN69vP5JulihLqE0K3EFVow9nL/zJVCn/tfiXQ1tSK1tUQSdZhyZMNm0akY2Hcp4VjOj5ViddUWz8M9w5B3tr+xj6dG6B3dfmYqePJFs2M7XIPJuoklgmfwQKJI8GhFRb6Ti5PwRBH7lj/Uh5+dXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwXJX6Zz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwXJX6Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B1A1F000E9;
	Mon,  6 Jul 2026 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347708;
	bh=2ATynKvldxvAla4FKbs12N2DZMWV8t9uZHtpxnTO2Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwXJX6ZzSyy+gM0LpoEqOwKtkCeZA/2lGPhykXO3J3CaaxYctmifWP6+vo3SJBuKE
	 RESyT3CQqJ05uAF+O1wvh+18L/Om3/ebP1TLy1BB6Nhaf425iNhMlajBYjW72fR+Zq
	 G6w6fSq80wNuY7tc5jjma9BSA6ZQfu5RP0iWRYqvjezTpl3te8U3zbdQtZzR9VYImM
	 MBqgH4EB3DOOIAeiacp2DeF0xOWCmvrXj39J7uSkQh0VJwT6kWnB8fp9AJP4TVlSxX
	 mmyuqi/xdfyrfCXM4wGSLLphWHQ6bCdU15MSW/avwhM73GLCqKijHoPcg1Lo4cubBG
	 NY5CEgXQ6MyGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] samples/damon/mtier: stop all contexts with
 single damon_stop() call
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260706140628.87414-9-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
 <20260706140628.87414-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:21:47 +0000
Message-Id: <20260706142148.B2B1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing synchronization between module initialization and the modu=
le parameter sysfs store callback can lead to Use-After-Free and NULL point=
er dereference.
--

commit dbce89ab1942b321167e83b5cb17dfd9002ce893
Author: SJ Park <sj@kernel.org>

samples/damon/mtier: stop all contexts with single damon_stop() call

This commit refactors damon_sample_mtier_stop() to use a single
damon_stop() call to stop all requested DAMON contexts. The previous
implementation used two separate calls because damon_stop() could
theoretically return a failure, but it now always stops all contexts
successfully.

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 90881e8bd441f..ac9c24b92ead8 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -200,8 +200,7 @@ static int damon_sample_mtier_start(void)
> =20
>  static void damon_sample_mtier_stop(void)
>  {
> -	damon_stop(ctxs, 1);
> -	damon_stop(&ctxs[1], 1);
> +	damon_stop(ctxs, 2);
[Severity: High]
This is a pre-existing issue, but could a concurrent sysfs write
trigger a use-after-free and null pointer dereference here?

When the module is loaded with the enabled parameter set to true,
damon_sample_mtier_init() attempts to initialize the ctxs array. If
initialization fails, such as failing to allocate ctxs[1], it destroys
ctxs[0] but leaves it as a dangling pointer.

Concurrently, a userspace process writing to the enable sysfs parameter
triggers damon_sample_mtier_enable_store(). If this write observes the
global enabled state as true before the initialization failure resets it
to false, it proceeds to call damon_sample_mtier_stop().

When damon_sample_mtier_stop() calls damon_stop(ctxs, 2), it loops over
both array elements, calling __damon_stop() on them. This dereferences
the pointers to lock ctx->kdamond_lock, potentially causing a
use-after-free on ctxs[0] and a null pointer dereference on ctxs[1].

>  	damon_destroy_ctx(ctxs[0]);
>  	damon_destroy_ctx(ctxs[1]);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706140628.8741=
4-1-sj@kernel.org?part=3D8
