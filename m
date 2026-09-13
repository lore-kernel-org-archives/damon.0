Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFA2C21D9
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320483; cv=none; b=oH7Vt5Kbuwlomf5z0sfTgsJgstTfUqLzWZ7SjOWnS34K68q6OghvN2mxE5+wgIluF/fOgAOVSj+3RuGJhkWmTxvwj+N+qcUXdT5PDpZO0xCadtvNvAGfzzS8kDpbtCC1ubV0zbZMTy8HKnz37yjrtkdW5HHsU1bVwoYYAcpjVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320483; c=relaxed/simple;
	bh=MBSVDCHmLfd3SM4wmpyHG+kvwhnqck4luQebm5uN/Ck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r72+KFLiAzrjQg4YRJxxraXj9pgTJpO+LgSHajuDJ+l+2YKxlE1u7Q17gRUstBysFYiDbzy4EDODQFWSpHg4uPlSJYLi7TzTZpmoHzUrIu+3/uLyCrFNv+3/xGfaVE2m4MKxL3L7IMNTBqrpxFcA+Qz3YQ2+nOtZP8uYIz/WcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da/6vMIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da/6vMIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B131F000FF;
	Sun, 13 Sep 2026 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320482;
	bh=wTy9ygc/MY+7prZNeJJd3jaSncP0RvFRq09APsXO6WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=da/6vMIzKw847BB0QA7onX/g+Z8tqYyszzw/Ve0gnStdEsOQSFnHVI8e1XJvaw0pq
	 ZVGqsKZ37PlAweTB0Nvxrv+MaNDEsHrrtdB32GRgfFSIpCz07d9T6kVpN7c3jnz4VL
	 l+mdfzMHuTA6VuLKpryQZVRavB6PP36nLpJO/+SwWTgX+qrPMen1XojdAoeTLNJ2qr
	 k7tLCRuEtGkInGWFogJCCj3udP7YgGkd3r5gt2l9iWO5+Oo9hq1XglS5d7RjxP1S1s
	 YjAlqQzpn7KbOctY8WiM8qh/QsOh5glFH+pXQwBdIZxHGYlMwhQ+dinuATMYFlWlOB
	 bZPp8G0wvyb1A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 8/8] mm/damon/core-kunit: test invalid damos
 filter commits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-9-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:28:01 +0000
Message-Id: <20260913172801.C0B131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete implementation: missing test coverage for DAMOS_FILTE=
R_TYPE_PROBE_HITS_WSUM invalid commits.
--

commit d95c459dddaa5a1cc3be54d53b10942b9bd9ba9f
Author: SJ Park <sj@kernel.org>

mm/damon/core-kunit: test invalid damos filter commits

This commit adds KUnit test cases to verify the validation of damos filter
arguments at commit time.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 2b0931cf6fb32..527abc2570616 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1184,6 +1184,13 @@ static void damos_test_commit_filter(struct kunit =
*test)
>  			.allow =3D false,
>  			.sz_range =3D {.min =3D 234, .max =3D 345},
>  			}, false);
> +	damos_test_commit_filter_for(test, &dst,
> +			&(struct damos_filter){
> +			.type =3D DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
> +			.matching =3D false,
> +			.allow =3D false,
> +			.sz_range =3D {.min =3D 456, .max =3D 123},
> +			}, true);
>  	damos_test_commit_filter_for(test, &dst,
>  			&(struct damos_filter){
>  			.type =3D DAMOS_FILTER_TYPE_UNMAPPED,
> @@ -1197,6 +1204,13 @@ static void damos_test_commit_filter(struct kunit =
*test)
>  			.allow =3D false,
>  			.addr_range =3D {.start =3D 456, .end =3D 567},
>  			}, false);
> +	damos_test_commit_filter_for(test, &dst,
> +			&(struct damos_filter){
> +			.type =3D DAMOS_FILTER_TYPE_ADDR,
> +			.matching =3D false,
> +			.allow =3D false,
> +			.addr_range =3D {.start =3D 567, .end =3D 456},
> +			}, true);

[Severity: Medium]
Is a test case for DAMOS_FILTER_TYPE_PROBE_HITS_WSUM missing here?

Previous changes introduced range validation (max < min) for ADDR,
HUGEPAGE_SIZE, and PROBE_HITS_WSUM. While ADDR and HUGEPAGE_SIZE are being
tested for invalid commits, PROBE_HITS_WSUM seems to be omitted.

Additionally, if a test for PROBE_HITS_WSUM is added, does
damos_test_commit_filter_for() also need an update? The switch statement
verifying copied filter fields lacks a case for it and would fall through to
default, failing to verify the range arguments:

damos_test_commit_filter_for() {
	...
	switch (src->type) {
	case DAMOS_FILTER_TYPE_MEMCG:
		...
	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
		...
	default:
		break;
	}
}

>  	damos_test_commit_filter_for(test, &dst,
>  			&(struct damos_filter){
>  			.type =3D DAMOS_FILTER_TYPE_TARGET,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D8
