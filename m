Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088698;
	b=nR3qQF2Es9A8MLoXYhPTZUH2ha8fiQwMJcxQnNc8vT2fYNo2DhbVSo2jppebMkGs0kQ2
	 Z9TdsJM855mmHfInbFOSqfU0Fbkba5lNHAdyUB1VE6ea4R5zYQaHHn8FIV8w/NQgHiK48
	 rKrWO5bTvWxshzGDMcpriplziYV0VOEMqJ9x7kL/dnLZXlhElGSUebbt+D5XDa1W+aiIn
	 Q5sdsCYwn0pBui8RDITT7jhnonR+5EZB9qzIwdrIZwNhEpXAjWv/YrQfmrkduxE7Byor2
	 0ddW2qOionzz22N2kSBbP2jQHbKJgC1j/uYU0cveEQXDxh1QM66oLlUmRWbFb/LzaKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6TrikrwQyh4DkStXHhkZyFBHAXRA0BcKw44gzNrj3jE=;
	b=kfBJ1l7SH5d4GbFdQfvEWifWDOMMfzQYUnBcf6/LRDuHC3xr4Ho+B13K8M9JIfMtYXTN
	 kGBC/fpL+fi7dhsNegaqfND7AWaGDN1j2WhEOY5YfSKfuzuOI9hGkzFE9I9Qa2MTlkk+E
	 fNMlz6SMAiStUkLYFrXKBDSHH4ck3MmVaK7M4F4+xHHiT3qGEmfB3iO61wFg3KVveOjug
	 Tfjh2YUWCShV5yA5ZrAa8vJzv7A3TpR4Kg5OupyqlOKl75NvKMPKFM41y+ogWnSINgkkl
	 W3TX8Ngz8kiwwysfUbuw0Uwani54EL8p1YASpSHjSlfE/iABq3GvqdQVEB0t3jXcZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=haum5AZO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AE606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=haum5AZO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE71F0089F;
	Sat,  7 Nov 2026 21:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088698;
	bh=6TrikrwQyh4DkStXHhkZyFBHAXRA0BcKw44gzNrj3jE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haum5AZOBQBMcXJfv6OHeBqjEXed5HZFCRl9Fs60Zw+rj3j2HU44g+sy7byDWT233
	 TTSoHTNnTZXDfjCT+gVL2Z2o8HEE3dvry3bYVOyoYDk18+S+TbTXUv5jD0VtXITT90
	 /vGpfSomDfM6IAeFlrDLAvKyut6GpUFsWy3oB59Jz+nKrKNWPJeNDGpVxwCxAdfR7I
	 +SsskeAWRqLp/efxMCpEqblDaHaMTa9eqA0RQ/IIrwaTUfoOUpN4Tr6LwzelLjip2c
	 sHEGMm4ttz+cQypaYTePcmh13rG4abth0/ZBnz3wubwD8lJoq8cXaQJTBQjJ4l62O6
	 Ne3tUBkkR9YQw==
Message-ID: <sashiko-outbox-203351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y 5/5] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261107214525.304638-6-sj@kernel.org>
References: <20261107214525.304638-1-sj@kernel.org>
 <20261107214525.304638-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 21:58:17 +0000
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
- [Medium] mm/damon/core: dangling charge_target_from ABA reuse in
  damos_adjust_quota()
--

commit 6429d6d07b9e92711137f889d5332896002d4342
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove unreachable damos charge_{target,addr}_from

This commit adds damos_fix_stale_charge_pointers() to damos_adjust_quota()
to clear quota->charge_target_from and quota->charge_addr_from if the
target was removed or has no regions left after a runtime parameter commit.

Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 046c07b86a6e7..badd0628e5eb2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1686,6 +1686,26 @@ static void damos_set_effective_quota(struct damos=
_quota *quota)
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
>  static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  {
>  	struct damos_quota *quota =3D &s->quota;
> @@ -1714,6 +1734,8 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>  		damos_set_effective_quota(quota);
>  	}
> =20
> +	damos_fix_stale_charge_pointers(c, s);
> +
>  	if (!c->ops.get_scheme_score)
>  		return;

[Severity: Medium]
Can damos_fix_stale_charge_pointers() match a different target if
quota->charge_target_from is left dangling until damos_adjust_quota()
runs?

When damon_commit_targets() removes a target via damon_destroy_target(),
it frees dst_target without clearing quota->charge_target_from, and
damon_commit_ctx() then calls damon_set_attrs() ->
damos_set_next_apply_sis(), deferring damos_adjust_quota() to a later
interval.  If a newly committed target reuses the freed slab address
before then (or if damon_commit_target() overwrites dst_target in place
with a different target), t =3D=3D quota->charge_target_from matches the new
target and leaves the stale charge_target_from and charge_addr_from in
place whenever damon_nr_regions(t) > 0, causing damos_skip_charged_region()
to skip targets and regions up to the old address.

Clearing charge_target_from and charge_addr_from directly in
damon_commit_targets() when a target is destroyed or updated would avoid
comparing a dangling pointer later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107214525.3046=
38-1-sj@kernel.org?part=3D5
