Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A903C98AF
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051417; cv=none; b=D3hYUSyKAHs4PnMITdzJKQtdaLRZg6LgTExl1F7iz7HoNiZp3WObmbUWcVYc6jLPst2ZEaAHAJc0PVZipMl2dBTi8MTD9cdhs/s2jbo14zkfm2FzNx4/I6+hzPdm2xPCr/vcUDY69FCk7JGjSDLZFH8uVayGBngmkPWVymVlf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051417; c=relaxed/simple;
	bh=b61+3fyOERZ9f5Xbs+cr+nOQtGr/r9ON3IHlU27ngQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1ectgOXvZJVb1NLmzkI7vwEcJd2hZBc/NmGAgnaSu3ZhA4D4yqpshg9uLPuZCbD0tLT4fcUfooO0EU2azl0ovXL0KKci0MHFnZIa2/H/G3DE2ki5A0mSPpqAzThxnsRXucsvj0N6VhRbimOmKTjdPZNJfYVHfPBjRPFvXweEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5LbwybC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5LbwybC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D261F000FF;
	Thu, 10 Sep 2026 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051415;
	bh=Hnx6+c+dZ77/2bQ6Roqgm5q6FoIgzy7WrpT43s+UoyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5LbwybCaD3fzJW3NK3ug+JIpt85dKfQv0RVWO6oZ6ySry0XCAkYZx0hPMz1pvQhX
	 XOFphZdLbu1ZzwDnHGeil5jg9QMR3VsuQlL+YkQCkWsGQzPb/LH+jRQ6I7dFYb4Z7b
	 x6Yn9Ly7u7di4h2xxDQx7onM1vWDo/Y0YIaN34AyH2Vh/IM0mcezn3sBmhXxdccgvD
	 Mjyzm1072pjRe2dZ/pJznrc0gl706TEGF7KA7CrigkVXB6We0UO8dsBfdn6xSYn0Vr
	 65sYtlPvFN7kHPRmhW7LheTyrzGJzXqWhkGT9AL1wYo7xpyFQpjhJF2ahL3V/sc0iw
	 wgubVX75DwSRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/core: reset invalid
 quota->charge_target_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910142846.172957-1-sj@kernel.org>
References: <20260910142846.172957-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:43:34 +0000
Message-Id: <20260910144335.04D261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DAMOS scheme processing permanently stalls if a valid target has z=
ero regions, reproducing the exact lockup the patch intended to fix.
--

commit be23af6d135629bfa902e51163989385be75b34b
Author: SJ Park <sj@kernel.org>
One-line subject: mm/damon/core: reset invalid quota->charge_target_from

This commit fixes an issue where DAMOS can suddenly stop working if a target
process that the quota is fully charged on is terminated. It handles this
corner case by catching the invalid target and resetting the charge target
pointer.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 645cb367019ae..06cf2ab7e97d7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3393,8 +3393,15 @@ static void kdamond_apply_schemes(struct damon_ctx=
 *c)
>  	max_region_sz =3D damon_region_sz_limit(c);
>  	mutex_lock(&c->walk_control_lock);
>  	damon_for_each_target(t, c) {
> -		if (c->ops.target_valid && c->ops.target_valid(t) =3D=3D false)
> +		if (c->ops.target_valid && c->ops.target_valid(t) =3D=3D false) {
> +			damon_for_each_scheme(s, c) {
> +				if (s->quota.charge_target_from !=3D t)
> +					continue;
> +				s->quota.charge_target_from =3D NULL;
> +				s->quota.charge_addr_from =3D 0;
> +			}
>  			continue;
> +		}
>  		damos_apply_target(c, t, max_region_sz);

[Severity: High]
This is a pre-existing issue, but does this incomplete fix leave DAMOS
vulnerable to permanently stalling when a valid target has zero regions,
or when using operations where target_valid() is not implemented?

If a DAMOS quota is exhausted while applying actions to a target, saving its
pointer to s->quota.charge_target_from, and before the next apply interval
all regions of that target are dynamically removed but the target itself is
kept valid, kdamond_apply_schemes() will process the target here.

Because the target has zero regions, the loop inside damos_apply_target()
is bypassed:

mm/damon/core.c:damos_apply_target() {
	...
	damon_for_each_region(r, t) {
		...
		damon_do_apply_schemes(c, t, r);
		...
	}
}

Consequently, damos_skip_charged_region() is never executed to clear
charge_target_from.

When evaluating all other targets, damos_skip_charged_region() will check
the stale charge_target_from pointer and unconditionally return true,
skipping all actions and permanently stalling scheme processing.

Could we ensure charge_target_from is cleared even if the target has no
regions, or if the target_valid() operation is missing?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142846.1729=
57-1-sj@kernel.org?part=3D1
