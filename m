Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FB2DECCB
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612954; cv=none; b=V9LOTaBEL9vN3VqOmdt02RDtt9Cs+ipKijcF+tAaMTKov9hE2AaXGyJzCrhB5SyHuKV9oXT3MJD9ax1ZdoHjxTkWnhI/8smjwd6ERL0ajRvfNdqWUFmnuqKqqpPCSDGpDEEYnALRHQHTS3QvHueSzzO/NP0V3daxmWPIb9WOiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612954; c=relaxed/simple;
	bh=EKewqfL+vFYpG2oL5ZoGQ0V7PSG9+ksBYKRDtSkHrnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bm715kB/B6iWeWImA+wBUJ01HK5Oi+g2Myf0q4U9MDEp7emYn3+NE3Sxi5s0tADo2o85xPe52JrjMtgw+4XozY26v0YYW4TUGyqORA51fSFL0PbsOZ9umeXN1umT5QXhXDLqq/NQBqcYTvFOUXbdF03zsmaON/J11ZMxpNP6h+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQoONeXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQoONeXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBF81F000E9;
	Tue, 21 Jul 2026 05:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784612953;
	bh=rzt9qbhTVapRoh4NT9EZCVW2di9B1JuURitvGvXBanw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQoONeXdtBOECbHYtta/ZFucibxqA3/9BdLHUvcVbzMtsMTxy4Q83YlIaaKucl2y9
	 2ULg0CVzl+8cZ/CTws2y21X3Z6jqzQ6mjIlSCIZxT/hNSHhsWF11Hf8L6obID7Cocc
	 6fymP3QIe1WL8CcFR7F5+lj/jb7/0X7Um+2MoRoUbT1alyOofAtus/Qprx+fu0dIHS
	 vM56LdLzJKj1o2BG68ZMMrXlPTNQjWA8B28ENm8kZws/HKhIeany8SaS9Dv7KbIlDY
	 kwMZUNcE9uYEqtxCIMjcbEX07WzDvuVUTxGB9dDyuBE6VfNW/qp6YXKOSJPyf3j3xI
	 1OUVNklQaFHDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.1.y] samples/damon/mtier: fail early if address range
 parameters are invalid
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260721053953.181336-1-sj@kernel.org>
References: <2026072007-eldercare-amusing-37b4@gregkh>
 <20260721053953.181336-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:49:12 +0000
Message-Id: <20260721054912.EFBF81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Resource leaks (memory, kthreads, struct pid) on failure paths in =
DAMON sample modules.
--

--- Patch [1]: [PATCH 7.1.y] samples/damon/mtier: fail early if address ran=
ge parameters are invalid ---
commit 999f01f2d7c2530ae577d445b6761ac7a2a10e77
Author: Zenghui Yu <yuzenghui@huawei.com>

samples/damon/mtier: fail early if address range parameters are invalid

This commit prevents a WARN_ONCE() trigger in the damon mtier sample module
by validating that node{0,1}_{start,end}_addr specify a valid region
before passing them to damon_new_region().

Link: https://lore.kernel.org/20260629144432.133962-1-sj@kernel.org

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 775838a23d935..7f84367ad3e58 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx=
(bool promote)
>  		addr.end =3D promote ? node1_end_addr : node0_end_addr;
>  	}
> =20
> +	if (addr.start >=3D addr.end)
> +		goto free_out;
> +
>  	region =3D damon_new_region(addr.start, addr.end);
>  	if (!region)
>  		goto free_out;

[Severity: High]
This is a pre-existing issue, but does damon_sample_mtier_start() leak memo=
ry=20
and running kthreads on failure?

Looking at samples/damon/mtier.c:damon_sample_mtier_start():

	return damon_start(ctxs, 2, true);

If damon_start() succeeds for the first context but fails for the second, t=
he
error is returned directly. This leaves the first context running
indefinitely, leaking both the damon_ctx objects and the started kthreads.
This would hold the damon core's exclusive flag, preventing future exclusive
monitoring on the system until reboot.

A similar issue appears in samples/damon/prcl.c:damon_sample_prcl_start():

	err =3D damon_start(&ctx, 1, true);
	if (err)
		return err;

	repeat_call_control.data =3D ctx;
	return damon_call(ctx, &repeat_call_control);

And in samples/damon/wsse.c:damon_sample_wsse_start():

	err =3D damon_start(&ctx, 1, true);
	if (err)
		return err;

	repeat_call_control.data =3D ctx;
	return damon_call(ctx, &repeat_call_control);

If damon_call() fails, the functions return the error immediately without
stopping the started threads or destroying the contexts. This also bypasses=
=20
damon_destroy_ctx(), leading to a struct pid reference leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721053953.1813=
36-1-sj@kernel.org?part=3D1
