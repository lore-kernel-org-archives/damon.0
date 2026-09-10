Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42672242D67
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013809; cv=none; b=fScgMIfHuTFLyIWLpoUNVK8efZJWQPNNwdIjwL1jyceporgdOyi3bbbcxTVXagxk87e9IkaJN/TMRAi/gppWizftt8N9YW5QDamgZbVTWGXf5byszoSDUc0VuF/FtZNZ3eYURR6VTXF4/JD0dDDcHxKGqFonIaBb25yAndgdbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013809; c=relaxed/simple;
	bh=9xPRHxGgdngSgHl4yLfC9KDJ4nPWUEMq47zT8Ok5e6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEUy1/lbxIlgK0d8A1nFBYAinwOeium31cDN83+69GohIf8aIhlURtcznHKjJDea/5hE6AUAMiexsN8FlWX6P7YV5QWaoJR6KN1Zxixq4W1tgKIWKP4WP8lqjUWs8BbQQxplo/C67fZtfYYHKAXYx9Z5NE/HR/9WsTLGTJM/sDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA/VY1Y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA/VY1Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE271F000FF;
	Thu, 10 Sep 2026 04:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013807;
	bh=KIylFeMfL7lf5oLA+63fuEk6y5usiOVkhdytt9FGi2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OA/VY1Y+OsUyBxpyw0zQCRdx8zvVK0Ag0ZC0b+1jfyEQ4h/VIE++d/6dQRP/glNCs
	 esx53WG3XYLqtkpaI/mORI7FkNImuQJvgTVui7DqRG6VSEIw4O9cBfs32kqvw8PrjP
	 qArbcMH90jEBSraIlaCALtdsdN/8nK7Gey6X//1SZuc8g9ysq8Mztim4miPK+hJQRi
	 w1lZf+mcbLM5mpxdhgquW2kQEuDmljWXhGuyc9wEnt970z5K+yKv4PgAMfioLDS0ui
	 tOpb5y0tjPnhcL4O6JGwOlUTIzahUvc4MZ+UKYpwuInb7/Lr3o3iO3EB1RKgk1vXOC
	 NvTBtxhIgpqog==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 3/7] mm/damon/core: support probe_hits_wsum
 damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040319.147037-4-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
 <20260910040319.147037-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:16:47 +0000
Message-Id: <20260910041647.9CE271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing kunit test coverage for the newly added DAMOS_FILTER_TYPE_P=
ROBE_HITS_WSUM filter.
- [Low] The kerneldoc for `enum damos_filter_type` was not updated to refle=
ct that `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` is a core layer filter.
--

commit 3af974fc20158a639272fd766ad727c8d30c0f3e
Author: SJ Park <sj@kernel.org>

mm/damon/core: support probe_hits_wsum damos core filter

Implement probe_hits_wsum DAMOS core filter support in the core layer.
Make three small changes for the support: update damos_filter_for_ops() to
treat probe_hits_wsum filter as core filter, update destination
damos_filter->range_{min,max} for probe_hits_wsum, and extend
damos_filter_match() to handle the new filter type.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e9630f41e51fe..d9d56f4be1a97 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -658,6 +658,7 @@ bool damos_filter_for_ops(enum damos_filter_type type)
>  	switch (type) {
>  	case DAMOS_FILTER_TYPE_ADDR:
>  	case DAMOS_FILTER_TYPE_TARGET:
> +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:

[Severity: Low]
Does the kerneldoc for enum damos_filter_type need to be updated to reflect
that DAMOS_FILTER_TYPE_PROBE_HITS_WSUM is a core layer filter?

include/linux/damon.h:enum damos_filter_type {
 * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
 * are handled by the underlying &struct damon_operations as a part of sche=
me
 * action trying, and therefore accounted as 'tried'.

The documentation here explicitly lists only ADDR and TARGET as exceptions,
failing to update the list with the newly added PROBE_HITS_WSUM core filter.

>  		return false;
>  	default:
>  		break;

[ ... ]

> @@ -1332,6 +1333,10 @@ static void damos_commit_filter_arg(
>  	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
>  		dst->sz_range =3D src->sz_range;
>  		break;
> +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> +		dst->range_min =3D src->range_min;
> +		dst->range_max =3D src->range_max;
> +		break;

[Severity: Low]
Is there missing KUnit test coverage for the newly added
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter?

The copying logic for the new filter type's arguments (range_min, range_max)
is left untested, which could hide future regressions.

In mm/damon/tests/core-kunit.h:damos_test_commit_filter_for(), the switch
statement verifies filter argument copying but is missing the case for
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:

	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
		KUNIT_EXPECT_EQ(test, dst->sz_range.min, src->sz_range.min);
		KUNIT_EXPECT_EQ(test, dst->sz_range.max, src->sz_range.max);
		break;
	default:
		break;
	}

Additionally, in mm/damon/tests/core-kunit.h:damos_test_commit_filter(),
the function enumerates all filter types for testing but fails to include
instances of DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:

	damos_test_commit_filter_for(test, &dst,
			&(struct damos_filter){
			.type =3D DAMOS_FILTER_TYPE_TARGET,
			.matching =3D true,
			.allow =3D true,
			.target_idx =3D 6,
			});

>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040319.1470=
37-1-sj@kernel.org?part=3D3
