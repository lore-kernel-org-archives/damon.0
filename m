Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105F2C0296
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286154; cv=none; b=lk+rUPAaXv1xLAYQMEbtWkt5HUQ41F2+lKsHjpRAciPjNvG4RG9crjCR6tKoyz6DyjAS5Uj1SuLM5QzPZs+ilFTKmy6LstHAp91VKTIlS7jbdSTIy9zddajB5+b2WPFsTQK2JzX1wFVC9AWxYNW/gdE+qidCf4ESz4666UfT6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286154; c=relaxed/simple;
	bh=EZ4eFBW3BbPI08oF0iCgVaBC3X3c/TvJwwyfOypv43Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NcjVO41a8lkF4enok/Ym+yVGkfRNV7IlxU8Q2xDptkP/jnlvghmZr8K0HVHXKOtQtId2SJ7nOLHWxhPJ6mRHwYikbIo7e0snAV1Z3+/FRjsrrgPNUh57iEr/U7ngpO3ID1RUqwH9HKEUbY2lDwQdCd2x1g4PF6vXdDfyjIGEfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpZu7JeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpZu7JeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F701F000E9;
	Sun,  5 Jul 2026 21:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783286153;
	bh=8e9tn26HLjTti/P2IVVIBFdnUFr31BMiYCrRByZGmZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WpZu7JeY2SVPoiRRhw12bG3/HzjvmjtZVMzw/zWiUmwUlrHNoOLEekugnbh0veM6Z
	 oULG1YnJmPMY/4V5ZrKaEMofu6/SF21hK9zOaK6q4Qz3S2xFPJSpE7XwLzX1kOAN8k
	 H/26omzdCw7NtfEkzD+pbhYnrZmiBTQ6MlQZHt8toAMkDgVhltGvxe552VBwQzKlX9
	 5hLaJvafAVU6i+OyAZKjRFM5ZsWVWwKjxuM+YG7BP8mg3KifnmIN+yecvpy6YKCkKB
	 a3dAM8+nlBIvzuaD3Jk2aZjEITcJR2WIi2zIs5PyeQ4FcWJ9pY0fa5dBsag9hY6/xy
	 HJjscUb3IokUw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 12/16] mm/damon/core: implement
 damon_has_probe_weight()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-13-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:15:52 +0000
Message-Id: <20260705211553.25F701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] `damon_has_probe_weights()` returns `true` even for DAMON contexts=
 that do not implement the `apply_probes` operation callback (e.g., `vaddr`=
 and `fvaddr`), causing DAMON to silently bypass access checks and complete=
ly stop monitoring memory.

Pre-existing issues:
- [High] Integer overflow in `abs()` macro usage with large unsigned probe =
scores breaks DAMON region merging.
- [High] Multiplication overflow in `damon_merge_two_regions` when calculat=
ing merged probe hits and access counts on 32-bit systems.
--

commit 4b421534e3283ef89ac2afef3f02956b0510da1e
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement damon_has_probe_weight()
   =20
DAMON monitors only data attributes when probe weights are set. However,
the function for detecting it is intentionally returning false always.
Now all the building blocks are made. Complete the mode detection function
so that the mode can really start working.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7a070cfb7cd1b..c7de55865b9c9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)
> =20
>  static bool damon_has_probe_weights(struct damon_ctx *c)
>  {
> +	struct damon_probe *p;
> +
> +	damon_for_each_probe(p, c) {
> +		if (p->weight)
> +			return true;
> +	}

[Severity: High]
Does this code need to check if the underlying ops struct supports probes?

If a context like vaddr or fvaddr has a probe weight configured via sysfs,
this will return true. This causes access_check_disabled to be set to true =
in
kdamond_fn(), which skips check_accesses():

mm/damon/core.c:kdamond_fn() {
    ...
    bool access_check_disabled =3D damon_has_probe_weights(ctx);
    ...
}

Because ctx->ops.apply_probes is NULL for vaddr, the apply block is then
skipped and max_merge_score remains 0, which causes kdamond_merge_regions()
to aggressively merge everything with a threshold of 0.

>  	return false;
>  }

I also noticed a couple of pre-existing issues in this file:

[Severity: High]
This is a pre-existing issue, but does this code overflow the 32-bit
boundary on 32-bit systems?

mm/damon/core.c:damon_merge_two_regions() {
[ ... ]
	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
			(sz_l + sz_r);
[ ... ]
	for (i =3D 0; i < DAMON_MAX_PROBES; i++)
		l->probe_hits[i] =3D (l->probe_hits[i] * sz_l + r->probe_hits[i]
				* sz_r) / (sz_l + sz_r);
[ ... ]
}

If a region size reaches around 42MB on a 32-bit architecture and
nr_accesses is around 100, the multiplication nr_accesses * sz_l could
exceed 4.2 billion and silently overflow the 32-bit unsigned long,
corrupting the memory access statistics for merged regions.

[Severity: High]
This is a pre-existing issue, but can the absolute difference of two large
unsigned integers be evaluated incorrectly here?

mm/damon/core.c:damon_merge_regions_of() {
[ ... ]
		score =3D damon_merge_score(r, false, ctx, use_probe_hits);
		last_score =3D damon_merge_score(r, true, ctx, use_probe_hits);

		if (abs(score - last_score) > thres)
			r->age =3D 0;
[ ... ]
}

If a user configures a large probe weight via sysfs such that the weighted
sum exceeds INT_MAX, score - last_score produces a large unsigned int. The
abs() macro explicitly casts unsigned types to signed types, which would
wrap into a negative signed integer and then be negated into a much smaller
positive value. This could bypass the greater than threshold check and
prevent regions from resetting their age.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D12
