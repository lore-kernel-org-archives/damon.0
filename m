Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B93A9620
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898471; cv=none; b=efQ9HPlArRjo70Id/TpPfeihY90qyBX3N5J5bePP1vvOiJfkzDydK8PZQimUgBc34kj79gUy/64PmyWg6plrnV5dad/H8rJoMAVF6amERigFu8b9wwcHuJ8PUPhgRQEA2qe7TEnESplpcDuSPTwVheZo/k3F3Omy1wMoV8nJqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898471; c=relaxed/simple;
	bh=sRPgw9TPrynR6WBXb+eAyqgQTDMW5ngaD59lRR3v+cU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AutVzLLbR753Smjc1ioG7wDl1/Wp3xutygAgTv/nnLl3jo9Z3i/3yvW0/xkPsQtJx4UvQiG9V47tETGnbv5GIzRsUevFGdd4dKVpzvFxFzJVf/4u0CaLCVxp3itieBuU8UvpOKAJqTn7vMOxO5ay3uJA0fP39r3CK/DB09dJVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEt4nqzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEt4nqzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361EA1F000E9;
	Fri, 19 Jun 2026 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898465;
	bh=7HEAOpSJQ2bilw+P9NF3EwLDnri3SyUrOx1C6IxkGKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AEt4nqzUVNt6vuC9ikUcExWrmwrAJ9+g/Dt7R2k2KgHGQLJZPMiPhROxl7DPbEQeJ
	 5zXADkhQZkRSkI3rpYG4QYJ3v9Fuiq93is5WElaSSLO+PbmcmQ15GEFArlv0M0ioth
	 aQw8VharuAOOCFtDtIVhlTjno7YMKPWvkhnXhVuNp7ScVmUJqYWuNkoLt8DMVgKv6h
	 2/7DJu90uOkte9icjd0A3mJFzCjECksYqsyYApP4Ixz2/1aGvGT14lZ/BRrAnDbNws
	 6KFELHvyGDVvE6gy6HuKR5zc6C2RkyPRYVbRc3OVShgdSVVtMjwPsR34VzKgelp7Uc
	 pzaoMytN3NrjQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/13] mm/damon/core: remove
 damon_warn_fix_nr_accesses_corruption()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619193415.73833-7-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
 <20260619193415.73833-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 19:47:44 +0000
Message-Id: <20260619194745.361EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] damon_nr_accesses_mvsum() causes a divide-by-zero kernel panic=
 if aggr_interval is configured to 0.
--

commit 6a4a453ed1f9a5204defaea4d03c5096a0240cc8
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()

This commit removes the damon_warn_fix_nr_accesses_corruption function
and its call site in kdamond_reset_aggregated. This removes the
corruption detection and fix logic for nr_accesses_bp since it is no
longer used.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a7b45b3cad508..35a4f22a35f7e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2046,7 +2033,6 @@ static void kdamond_reset_aggregated(struct damon_c=
tx *c)
>  			trace_damon_aggregated(ti, r, damon_nr_regions(t));
>  			trace_damon_region_aggregated(ti, r,
>  					damon_nr_regions(t), nr_probes);
> -			damon_warn_fix_nr_accesses_corruption(r);
>  			r->last_nr_accesses =3D r->nr_accesses;
>  			r->nr_accesses =3D 0;
>  			for (i =3D 0; i < DAMON_MAX_PROBES; i++)

[Severity: Critical]
This isn't a bug introduced by this patch, but by a previous patch in the
series (mm/damon: introduce damon_nr_accesses_mvsum). Does the
damon_nr_accesses_mvsum() function cause a divide-by-zero if aggr_interval =
is
configured to 0?

In damon_nr_accesses_mvsum(), window_len is calculated as:

    window_len =3D ctx->attrs.aggr_interval / sample_interval;
    left_window =3D ctx->next_aggregation_sis - ctx->passed_sample_interval=
s;
    left_window_bp =3D mult_frac(left_window, 10000, window_len);

If a user configures aggr_interval to 0 (and sample_interval to 0, which
passes the sample_interval > aggr_interval validation in damon_set_attrs()),
window_len evaluates to 0.

Because mult_frac() directly performs a division by this parameter, wouldn't
this result in a divide-by-zero exception and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619193415.7383=
3-1-sj@kernel.org?part=3D6
