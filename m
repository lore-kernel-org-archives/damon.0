Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776638D
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788072429; cv=none; b=KxsOw1hmqT+y2SUngN1kgbQSIHX/C7I4M17XD3OR9x2BUgGIbiFOnrA2JkVBvnETc4q3/f9kc0ZF+VUzmIXGNMBbjgyd68B2oZSZKM+g6JTpB4J8pZQGDbyndaZ+quNzLvl0kpRzu/4DsOQF14IoD3XxGavGJIgTF1Cf5re4p08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788072429; c=relaxed/simple;
	bh=cpZX6K1d8oUY1I1yv/zoH5NjaoP4G9ozNcickaR91NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPMlcOMrNpRAIpn8D+RdEqDVHKmACwFQJOnqtN5jx3Q1BY0f7KcNSNkCGDbLNRWNTUopVIQsVN8RfBrUJk/RODBKs38uo49HHEn04x7VvKk4de2sUZ1kZn/mR4nWh2u+i+xKLZ3NjEdgrV/cnRaes6Ob2o798c87kYh40oSxCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNfgYfRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNfgYfRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CA61F000E9;
	Sun, 30 Aug 2026 06:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788072428;
	bh=FELE/c/sudXDpdzqH5scEjs6bIMh4GHjn7Bef5bIhSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNfgYfRMqesQMIxRJu1dMI49EDXUCWddCrOBZ43EZQAreGRtIR3HR5Ua0S1UMTws3
	 eFlhDqeSlWb+NUXXeWM/FBvAq9d2hc6eYtM7TjEcJFjdgSePVbvHrAtzyXf/XNXIsP
	 /hV/4spylyJzFmMCuqdd7g2yxBqWYJwkn3p1V/+jZShHWbEjT3KxuswvSS616Af9AG
	 /HpEtqKocsPGAWM7f9R5KrjzyY9fHJFhe8WPcGlEPxh9SVwUN5X+ZcjHJ7xYXdWBIm
	 jeu0qzn02fOslJR86YRKheBcSQ8SIM5TSxNDmgPIHENp6RMPw+8Sbp6OcRtMt8svcy
	 vs01flCWZcHMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260830063159.6347-1-aethernet65535@gmail.com>
References: <20260830063159.6347-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 06:47:07 +0000
Message-Id: <20260830064708.40CA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A preexisting bug causes DAMOS scheme application to permanently s=
tall for all subsequent targets if `quota->charge_target_from` points to a =
target that becomes invalid or loses all its regions.
--

commit 630d73d512e66245612cbdfe5c49647aa6ed2874
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: fix unconditionally skip last region

This patch fixes an issue where the last region of a tracked target could
be unconditionally skipped and reset without being processed when a scheme
quota is exhausted. By modifying the reset logic, it ensures the last region
is appropriately handled rather than always skipped.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..fb76b530bbc68 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2342,36 +2342,39 @@ static bool damos_skip_charged_region(struct damo=
n_target *t,
>  {
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long sz_to_skip;
> +	bool skip =3D false;
> =20
>  	/* Skip previously charged regions */
>  	if (quota->charge_target_from) {
>  		if (t !=3D quota->charge_target_from)
>  			return true;

[Severity: High]
This isn't a bug introduced by this patch, but does this logic cause all
subsequent targets to permanently stall if the target currently stored in
quota->charge_target_from becomes invalid?

If the monitored process dies before the next window, kdamond_apply_schemes=
()
appears to bypass it without clearing the saved target:

mm/damon/core.c:kdamond_apply_schemes() {
    ...
		if (c->ops.target_valid && c->ops.target_valid(t) =3D=3D false)
			continue;
		damos_apply_target(c, t, max_region_sz);
    ...
}

Because the target is skipped entirely, we never call damos_apply_target()
and never reach the clearing mechanism inside damos_skip_charged_region().

When this happens, wouldn't all other valid targets continue to evaluate
(t !=3D quota->charge_target_from) as true here, permanently skipping scheme
applications?

It appears a local user could reliably trigger this by setting a restrictive
quota on a memory-intensive process they own, waiting for the quota to
exhaust, and then terminating the process.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830063159.6347=
-1-aethernet65535@gmail.com?part=3D1
