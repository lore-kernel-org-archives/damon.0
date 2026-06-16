Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34544104F
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623301; cv=none; b=FD9dVyKPtOtsoLqsJf8dTslsPVNyGFBE+jwPUiffB/GTl9NV4YYolMNCbcnppN6GS7OGa9n0HoLkGt0TG2w/7q54P6TPbLddd/Vv5QP3oksmZw+dbxf/1SqlyCrcaTM+OjEo4vZ3ZQv5WR8/8RpUv5lWEF6qB8Fk5jtt3a6sKlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623301; c=relaxed/simple;
	bh=psIeumb1wADLgkjIPmno+Hux5pwuVqvA/pqulW5e/Fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+bHzXG4eY5TWuoHdjAWBqHOAMqI371wyYPVOA45Ly8+HT+D1medmdUx5OwwEMUuAgegTorlLWW7nBMcvVO4+4lrCUBxmtRoVeQSASBf1HO6fgp65+kAEdOOuoRC5HxrSRdO43is0kQwyRVQ6sRkjWLv9TD4K7xu5VwA4HAwuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMFU3q5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMFU3q5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9648D1F000E9;
	Tue, 16 Jun 2026 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623300;
	bh=CDItKCT5XhZQo44ney8IfGQGIAzTmF1i25kaRgvh1BI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMFU3q5GkQPlm+girjCa44tywksyM4KETlc0MmjRy7CgSIUWGOMlKide4mycQc4dN
	 RQDuFK43e05jJ6SgR0GvBiXzgIAenFpOmJyCSmoBGSWiK6owziHAPtejIwNYt5uoe0
	 2jSFan1BBFSmCXKkqxKWRT+1G2f78cnCPV+aNu2yJ1b+I9NVPiOAb19vUqdof2SOQQ
	 GfYwuhi9fjFHafaNLv+TnFQoHu9sP2iLm0pk9G9HybcjEofNYLDeCq0D8BVqMmlWtQ
	 9JSLcli52yHccJ3cGA63Vu1KGLba570H+dlQthxpWbXhMhLZqkMc72rlTN58wmpuYp
	 1xLelL4FtKoYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150316.580819-3-gutierrez.asier@huawei-partners.com>
References: <20260616150316.580819-3-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:21:39 +0000
Message-Id: <20260616152139.9648D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `DAMOS_QUOTA_USER_INPUT` goal tuner feedback mechanism is st=
atically stuck because `current_value` is never dynamically updated.
- [Medium] The scheme applies the DAMOS_COLLAPSE action to all regions incl=
uding completely cold ones, contradicting the patch description.
- [Low] The module cannot be compiled due to a naming mismatch between the =
Kconfig symbol and the Makefile variable.
--

commit 7e15caa860a55beb8439fc6bb5f299c5c42fb138
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing

This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
which collapses hot regions into huge pages. The module monitors
a specific task using DAMON-based sampling and applies collapsing
based on memory usage.

> diff --git a/samples/damon/Makefile b/samples/damon/Makefile
> index 72f68cbf422aa..a348dc74ddcb1 100644
> --- a/samples/damon/Makefile
> +++ b/samples/damon/Makefile
> @@ -3,3 +3,4 @@
>  obj-$(CONFIG_SAMPLE_DAMON_WSSE) +=3D wsse.o
>  obj-$(CONFIG_SAMPLE_DAMON_PRCL) +=3D prcl.o
>  obj-$(CONFIG_SAMPLE_DAMON_MTIER) +=3D mtier.o
> +obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE) +=3D hpage.o

[Severity: Low]
Does this prevent the module from building?=20

The Kconfig file defines the configuration option as SAMPLE_DAMON_HPAGE,=20
but the Makefile evaluates CONFIG_SAMPLE_DAMON_HUGEPAGE. This mismatch=20
means the build system might silently skip compiling hpage.o.

> diff --git a/samples/damon/hpage.c b/samples/damon/hpage.c
> new file mode 100644
> index 0000000000000..ebbe5e1be1a1d
> --- /dev/null
> +++ b/samples/damon/hpage.c

[ ... ]

> +	scheme =3D damon_new_scheme(&(struct damos_access_pattern) {
> +				.min_sz_region =3D HPAGE_PMD_SIZE,
> +				.max_sz_region =3D ULONG_MAX,
> +				.min_nr_accesses =3D 0,
> +				.max_nr_accesses =3D UINT_MAX,

[Severity: Medium]
Will this apply the collapse action to completely cold regions?=20

The commit message states this module collapses "hot regions", but setting=
=20
min_nr_accesses to 0 instructs DAMON to apply the action to all regions=20
that meet the age threshold, including those with no accesses at all.=20

Should this be set to a value strictly greater than 0 to only target=20
heavily accessed regions?

[ ... ]

> +	if (quota_autotune_feedback) {
> +		goal =3D damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
> +		if (!goal) {
> +			damon_destroy_ctx(ctx);
> +			return -ENOMEM;
> +		}
> +		goal->current_value =3D quota_autotune_feedback;
> +		damos_add_quota_goal(&scheme->quota, goal);
> +	}

[Severity: Medium]
Is there a missing mechanism to dynamically update this feedback value?

Since the module parameter is assigned to current_value exactly once at=20
startup, without a dynamic update path while running, the auto-tuner will=20
receive a constant error value.=20

Won't this continuously push the quota aggressiveness in one direction=20
until it hits the limits, rather than forming a proper feedback loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150316.5808=
19-1-gutierrez.asier@huawei-partners.com?part=3D2
