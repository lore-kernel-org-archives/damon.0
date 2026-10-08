Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A24E56FD
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473553; cv=none; b=MSIBBKGIBA0B0nC2nuHBWNKbUDRSrwe5Bz90SCMvR7a4S11malXmjJniu1Ff07X5HBhJdkQs21+dZt6v+PgHX6sAtm91HS5Jrb2VfRrMX4VM0hf+B0o9nNmTHn/r5N93eq7e2V1nNiEUAOCgFYIT2Hiu8Xc3LNz11RmQX6Pv0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473553; c=relaxed/simple;
	bh=qYZnVz0+NmkDJ+hoyQyl7DzoTZibE3vmdihfREk69GE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kZ7lVcm5oGp6GOYCaRFmY5y6tBqe/aBilgO7MFbd6CZdzTpIuJbYvAx2l/1M5BALAHrYRVYVx7hlCr2EVXpvJWTQ8X5mAQl2uZYKYcmA/cZ1sXigWM2DaM01LcFUXuCLxRhsRJCtAmbeAJw7YtXguAVSEcfxynLr5r+uP56Rkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adxkPnUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adxkPnUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329EC1F000FF;
	Thu,  8 Oct 2026 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473550;
	bh=RcYu5wpI6B91VNXPADdcJJOpswX9V3ghewqW6e2ryiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adxkPnUxMP+Nkvz8wd7/9Nhc4d+Nq+qEQx+TvtpfRWqeNBUln3W1rCoG6zFLsQ3bX
	 W+h9OmMCKdOuhplvW17RZbBeKvwI4sdzOBa+Ik7kfCoFuSfz5W/qalaXT/txSxUonC
	 032cW6fV+OaLPF9Ne9mrcIxboOK4Pcaj84f2xOQU0NHdpyJLt+4xZLTmJT0nS8u27w
	 wlV4vPrYQLdqcD7rEwFpFcsB4ZCijB2rgkymfrdOeJGyab9DEDQdnySDjy7riv7vF7
	 Kqlw2swpdj+uQPCpCdex2yDRpJ7yX5aaMFA63Bz4E78rlKPElbJdMkcrSEDhsmnhff
	 WPzJAxrZjT/sg==
Message-ID: <sashiko-outbox-164347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: Copy only installed probe in
 damon_split_region_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261008151944.113714-3-suhaas@s-joshi.in>
References: <20261008151944.113714-1-suhaas@s-joshi.in>
 <20261008151944.113714-3-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 15:32:29 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] mm: damon: performance degradation replacing memcpy with linked lis=
t traversal
- [Low] mm: damon: build failure in KUnit test due to missing argument in d=
amos_skip_charged_region()
--

commit 2a85f15b49d0115f937574a91868632edfb71225
Author: Suhaas Joshi <suhaas@s-joshi.in>

mm/damon/core: Copy only installed probe in damon_split_region_at()

This commit updates damon_split_region_at() to iterate only over installed
probes when copying probe hits, instead of copying the entire array. It
introduces a struct damon_ctx pointer parameter to the function to facilita=
te
this change. It also updates its callers to pass the new argument.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fc202f90991b0..9e5a19c2a19d0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3686,11 +3691,13 @@ static int damon_split_region_at(struct damon_tar=
get *t,
>  	new->age =3D r->age;
>  	new->last_nr_accesses =3D r->last_nr_accesses;
>  	new->nr_accesses =3D r->nr_accesses;
> -	/* todo: do this for only installed probes */
> -	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
> -	memcpy(new->last_probe_hits, r->last_probe_hits,
> -			sizeof(r->last_probe_hits));
> =20
> +	i =3D 0;
> +	damon_for_each_probe(p, ctx) {
> +		new->probe_hits[i] =3D r->probe_hits[i];
> +		new->last_probe_hits[i] =3D r->last_probe_hits[i];
> +		++i;
> +	}

[Severity: Low]
Since DAMON_MAX_PROBES is fixed to 4, the original memcpy() copied exactly
4 bytes and was typically optimized into a single register load/store.

Does replacing this with a damon_for_each_probe() linked list traversal
introduce unnecessary execution overhead in this hot path? The indirection
and branch checks to serve as an array copy counter might be a performance
degradation compared to the optimized memcpy().

>  	damon_insert_region(new, r, damon_next_region(r), t);
>  	return 0;
>  }

[ ... ]

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index ec953426b8403..a3dd31f3b112e 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> @@ -1868,6 +1899,7 @@ static void damos_test_filter_out(struct kunit *tes=
t)
>  	damon_destroy_region(r2, t);
> =20
>  out:
> +	damon_destroy_ctx(ctx);
>  	damon_free_target(t);
>  	damos_free_filter(f);
>  }

[Severity: Low]
The patch modifies the signature of damos_skip_charged_region() to accept a
new struct damon_ctx pointer as its first parameter, but it looks like the
invocation in damon_test_last_region_quota_reset() was missed:

mm/damon/tests/core-kunit.h:damon_test_last_region_quota_reset() {
	...
	skipped =3D damos_skip_charged_region(t, r2, &s, min_region_sz);
	...
}

Will this cause a build failure for too few arguments when the kernel is
built with CONFIG_DAMON_KUNIT_TEST=3Dy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008151944.1137=
14-2-suhaas@s-joshi.in?part=3D2
