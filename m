Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092554;
	b=RvFcM0KveIxLvsFLSm/vAQN+P/f2UkHbskz5vwtupatv6gpR9l2fMP10jGnZse/yvWRn
	 6X/kEdZNKwytRAIPacndQKrZ7H/t8UakYGdqLkHuk1WqBiEe0BbMyEPVKWs9OK3yjuS7C
	 pptnP8oQ5XuShjyqmqaQHABD2c4uXDBZLTvR4gWEQHAmljaSSjiyBqD94Lr005NpWfHPP
	 t2DsK0tuaemNr0wkMdUenldfLSSUybgcXAOY8zUXNEDi1AxV2DvlB/kHZ6GrFyo5reacd
	 71z6LpkDJkFPjTUXCauUlhXAVfscQ2H2ZLgAy8Fk7vBbkqdyohxQNbDK3F4z4A2hALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ODEFshzPsmt6jbffRU5HBwlLEZaxy7bDLgcL+MuZrvU=;
	b=kErjRdsSsoaNxgfBVaQ8ofpHpiAZJCnXawT74if/17siJXtA8og7H4P3gSnOHSZPBkJk
	 WONHnj6Sw9/IVU53km9xDgih3p0/LZvlsz+C8Du822i/b+cxxcTg6/hXGkuu8J93w4g2m
	 nw8SLIzgY6xfsPrh3QYaunccf/MMlR34SU91IVGfCflOoEGZDwj2htr1FwPDIi9qnpT2i
	 0MILTc+WKgF93UqMdGxkhjQoz5+Sdv6anXUJOuTfr9embVsyJiebBTQvy8gCC1mF/7ygK
	 4tCCBoKMlYeeRQVhQ3UwUX9zWGITfWiZGSBwqJPxaGthv5iohd6LNNGmgcIffS3TIKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M9AuTeG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B755606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9AuTeG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08041F008A6;
	Sat,  7 Nov 2026 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092553;
	bh=ODEFshzPsmt6jbffRU5HBwlLEZaxy7bDLgcL+MuZrvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9AuTeG/5QA2dxBfiho8NEnGkYULK83353V4lE3dS8j8G+gYWcLz6c0n/vrXb72eh
	 M2Cy8LPWUQ/fF9QPxhKLYUixevq8FHamYQuguYjmytZ13Da+Q4bza5TpYWTAAoZijp
	 ejdlFEgq+vzVROJefnRaSFgCcJ7xGo00NxKtpUoNCXddvlrBLq3qfNnkyU2bBmapE9
	 ab0G57PUgjNsucNKQDpuEqa5+9s/LC5sIJI1Cj8WlUfwfdUYMWsT31M5zyvFTKP1pq
	 es3tlJ60t/bQvKdDAG9onqyp5GjEFgP1dneSUrw1Jo8PxonEC2c+ARaXC3e43aHMUV
	 GRLROXcaGVZQQ==
Message-ID: <sashiko-outbox-203374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.1.y 2/2] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261107224800.340250-3-sj@kernel.org>
References: <20261107224800.340250-1-sj@kernel.org>
 <20261107224800.340250-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 23:02:33 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm/damon/core: stale charge_target_from ABA reuse when scheme
  is inactive
--

commit 853b3e89da132f2ce03750bcf6dfc1f62a70d261
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove unreachable damos charge_{target,addr}_from

This commit adds damos_fix_stale_charge_pointers() to clear
quota->charge_target_from and quota->charge_addr_from when the referenced
target has been removed or no longer has any regions.

Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9206737d05ae7..01f93146b92fe 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -860,6 +860,26 @@ static void damos_set_effective_quota(struct damos_q=
uota *quota)
>  	quota->esz =3D esz;
>  }
> =20
> +static void damos_fix_stale_charge_pointers(struct damon_ctx *c,
> +		struct damos *s)
> +{
> +	struct damos_quota *quota;
> +	struct damon_target *t;
> +
> +	quota =3D &s->quota;
> +	if (!quota->charge_target_from)
> +		return;
> +	damon_for_each_target(t, c) {
> +		if (t =3D=3D quota->charge_target_from) {
> +			if (damon_nr_regions(t) > 0)
> +				return;
> +			break;
> +		}
> +	}
> +	quota->charge_target_from =3D NULL;
> +	quota->charge_addr_from =3D 0;
> +}
> +
>  static void kdamond_apply_schemes(struct damon_ctx *c)
>  {
>  	struct damon_target *t;
> @@ -890,6 +910,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  			damos_set_effective_quota(quota);
>  		}
> =20
> +		damos_fix_stale_charge_pointers(c, s);
> +
>  		if (!c->ops.get_scheme_score)
>  			continue;
> =20

[Severity: Medium]
Can quota->charge_target_from match a newly allocated target due to slab
address reuse if the old target was freed while the scheme was inactive?

kdamond_apply_schemes() skips inactive schemes at the !s->wmarks.activated
check before reaching damos_fix_stale_charge_pointers(), and
damon_sysfs_set_targets() frees removed targets via damon_destroy_target()
without clearing charge_target_from.  If an online commit removes the
target stored in charge_target_from while the scheme is deactivated by
watermarks and a later commit allocates a new target at the same address,
damos_fix_stale_charge_pointers() will see t =3D=3D quota->charge_target_fr=
om
with regions present and leave the stale charge_target_from and
charge_addr_from in place.  When the scheme reactivates,
damon_do_apply_schemes() will skip targets before the new target and
regions up to the old charge_addr_from.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107224800.3402=
50-1-sj@kernel.org?part=3D2
