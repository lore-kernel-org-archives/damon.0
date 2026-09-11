Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DCCA6B
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089770; cv=none; b=RrIc5eLb1w412v2PY1a5MY/RnhtjNwLBgCUh2hLnYOOK6U/Y1hjCwkIL4IvdKdW8w46+Tcb/guM3/tZdI76fV5zoT7fBayOJN7vSWG9ikxveoOSSUeuzRkZH7PEpDlTYZUGnbODSR9/od3QF3tPNeMp0TqJz5LVFKAGrIMUrTj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089770; c=relaxed/simple;
	bh=y7CNgVSg4/q7IyXf2enRTruN8y5wI3TLkIFHGZkyf3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s6p2n5kXCt8spB+hUCstOEIXL7O0i4z5hd4nEU2rLtUWP6eyKMf9LwlgIYHoFutJAf/OcOClCU+98JT2cGm7iabpBMBAR7KWhcqLbSbWUHrB0xnkIyZAK2loF3HbZfGur164XUheuw3qDZrLd9syQX6a70+/xQEhw9fkBu3sCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKMhr8p8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKMhr8p8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541D21F000FF;
	Fri, 11 Sep 2026 01:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089769;
	bh=bHwa2uogmEKSRArSlU0k2/OU8o7TWr0mIBaXaJKJXg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GKMhr8p8EiZp0tnzGNhlJp3a4H1AFir6ewYxqI73gT7d0nimJcRpkfA5orhuj6hvu
	 K0OllpE5Vd3Sd5A0JmT4/TleP2JaDVtYjftTxtKY5qIO7xfreHPgqqQpi74NMz0vsV
	 gBeYFP0YVq3vUrB3GfC5s2kH+OGryufryUNYVKOa1wdqkFBrR32+yvpMYYm7xAmN6T
	 ljEXZjENGhJ18JzGcRXy4yn5MfDcHHyNuyM5H39q1Z8cjpQdo2vCu4DcK2vX+OX9Se
	 tLqZj1MYHZnfA8hB92k4RYSlJ9KndcBxKAlJ8cDVmNcKe1EjT/JCU67gceZ98tK0Tm
	 DzzE2Ca4GNG2g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 3/7] mm/damon/core: support probe_hits_wsum
 damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911011330.93678-4-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
 <20260911011330.93678-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:22:48 +0000
Message-Id: <20260911012249.541D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing test coverage for new DAMOS_FILTER_TYPE_PROBE_HITS_WSUM =
filter type.
--

commit 6772f4f420525d4fa844eff78fb5f202b6550013
Author: SJ Park <sj@kernel.org>

mm/damon/core: support probe_hits_wsum damos core filter

Implement probe_hits_wsum DAMOS core filter support in the core layer
by updating filter operations, argument commits, and match handlers.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e9630f41e51fe..d9d56f4be1a97 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1332,6 +1333,10 @@ static void damos_commit_filter_arg(
>  	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
>  		dst->sz_range =3D src->sz_range;
>  		break;
> +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> +		dst->range_min =3D src->range_min;
> +		dst->range_max =3D src->range_max;
> +		break;

[Severity: Medium]
Should this new filter type also be added to the kunit tests in
mm/damon/tests/core-kunit.h?

Looking at mm/damon/tests/core-kunit.h, damos_test_commit_filter_for() has a
switch statement verifying that filter arguments are copied, but it lacks a
case to verify range_min and range_max for DAMOS_FILTER_TYPE_PROBE_HITS_WSU=
M.

Similarly, damos_test_commit_filter() invokes tests for all other filter ty=
pes
but seems to omit the newly added DAMOS_FILTER_TYPE_PROBE_HITS_WSUM.

Could test coverage be added for this new filter type to prevent future
regressions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011330.9367=
8-1-sj@kernel.org?part=3D3
