Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839923D7DF
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220589; cv=none; b=KoKIb1uKMwZ/EplxQ0rSwX6L69Och55tTp9rkV7jYQzn56X4nSaaMHZc5U1/wcQTGdoZ6Jlr9ABtHUKCKwHmtXeB0tfUUB+Fya59TGKkyqx7MtZj2yYOWEMq5iHmBoYGXf7dQDsRMgOKszjK7h/nCt/v+Eaz6MkxT8De2Mlr48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220589; c=relaxed/simple;
	bh=//GyvyX6riGM0X0z8ZOBBvjyPLJHGdWB1r9rjis2RI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RLKLF585So7SvEdxoVJ4CZHZK/UqMPmGt82wL27bkUnGmjWN6g37RxXrnHG4ChDB9rEKqeex1UDfTvUwxyNt61RFd2qYBLgCtlu6FS/5If2VwEbXLX48XZadix6T+YOfZetgURGFx6/K1Pou05ayxSkMKABNXxaPLIH4RfdjtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTfvYh01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTfvYh01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFC8C2BCB5;
	Wed, 15 Apr 2026 02:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776220589;
	bh=//GyvyX6riGM0X0z8ZOBBvjyPLJHGdWB1r9rjis2RI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZTfvYh01NkNwvmETSPWLSC/wcxmAA6IgPykw0Fc6Tzn2mUWh047CXPtA6E/1tXYiv
	 aTgh2YWwpCMA+faEdWzzyUW/TKJ/S/RzR7biOfiEXehiKkBFDg5lkP53zft5k1uMbp
	 SUrfR3i5xH3LHRq1G8b3g2POHjpgh0qV+dvjW3L4cwvW5zWKQojagfEKi9ep9JJcMb
	 qpqsCPDHXttovC2TQHEcz+NgWinsLnHkwuZHvD+DbeSWslW5/97cVjz0Ts675CW4+h
	 BI19VYnhsngeH3gxaPWCEvTrBZYyB6KtfpiMlcaZ/TaRXYV6Mk+XI/s1uPxNB0itZf
	 iaQKykL0uzIeQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/7] mm/damon/lru_sort: cover all system rams
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260415012048.76508-4-sj@kernel.org>
References: <20260415012048.76508-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 02:36:28 +0000
Message-Id: <20260415023628.DDFC8C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 3 potential issue(s):
- [High] Monitoring the bounding box of all System RAM resources encompasse=
s massive physical address holes, fundamentally breaking DAMON's sampling-b=
ased access check on sparse memory systems.
- [High] Applying schemes to the newly-enlarged bounding box can cause a so=
ft lockup panic due to unbounded page iteration without yielding.
- [Low] Misspelled 'phyiscal' in module parameter documentation.
--

commit 11d2e4765abf8999777a27c53c055f1c43ca53bf
Author: SeongJae Park <sj@kernel.org>

mm/damon/lru_sort: cover all system rams

This commit updates DAMON_LRU_SORT to cover all system RAM instead of
just the biggest System RAM resource. The default monitor region start
and end parameter descriptions and initializations are modified to
reflect the entire physical memory space.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d729760..7f8c26890ffb2 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -140,7 +140,8 @@ DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_lru_sort_=
mon_attrs);
>   * Start of the target memory region in physical address.
>   *
>   * The start physical address of memory region that DAMON_LRU_SORT will =
do work
> - * against.  By default, biggest System RAM is used as the region.
> + * against.  By default, the system's entire phyiscal memory is used as =
the

This isn't a bug, but there is a typo (phyiscal) here.

> + * region.
>   */
>  static unsigned long monitor_region_start __read_mostly;
>  module_param(monitor_region_start, ulong, 0600);
> @@ -149,7 +150,8 @@ module_param(monitor_region_start, ulong, 0600);
>   * End of the target memory region in physical address.
>   *
>   * The end physical address of memory region that DAMON_LRU_SORT will do=
 work
> - * against.  By default, biggest System RAM is used as the region.
> + * against.  By default, the system's entire phyiscal memory is used as =
the

There is another typo (phyiscal) here as well.

> + * region.
>   */
>  static unsigned long monitor_region_end __read_mostly;
>  module_param(monitor_region_end, ulong, 0600);

[ ... ]

> @@ -336,7 +338,7 @@ static int damon_lru_sort_apply_parameters(void)
>  	if (err)
>  		goto out;
> =20
> -	err =3D damon_set_region_biggest_system_ram_default(param_target,
> +	err =3D damon_set_region_system_rams_default(param_target,
>  					&monitor_region_start,
>  					&monitor_region_end,
>  					param_ctx->addr_unit,

Will monitoring the bounding box of all System RAM resources encompass mass=
ive
physical address holes on sparse memory systems?

Because DAMON estimates access frequency by sampling uniformly at random fr=
om
the region:

r->sampling_addr =3D damon_rand(r->ar.start, r->ar.end);

If the bounding box spans across terabytes of address gaps between NUMA nod=
es,
would the overwhelming majority of samples hit unpopulated holes?

Since sampling a hole returns no folio, does this artificially dilute the
apparent access frequency of valid hot RAM within the region and misidentify
it as cold?

Can this also cause soft lockups during scheme application?

When applying a scheme, the region is iterated page-by-page. For unpopulated
gaps, the folio check is skipped and the address is incremented:

while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
    folio =3D damon_get_folio(PHYS_PFN(addr));
    if (damon_pa_invalid_damos_folio(folio, s)) {
        addr +=3D PAGE_SIZE;
        continue;
    }
    ...

Since there is no cond_resched() inside this tight loop, and because valid
folios are not found (meaning quota variables don't increment to abort earl=
y),
could iterating over terabytes of unpopulated gaps trigger the soft lockup
watchdog on PREEMPT_NONE or PREEMPT_VOLUNTARY kernels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415012048.7650=
8-1-sj@kernel.org?part=3D3
