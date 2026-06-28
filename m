Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39532E5429
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666563; cv=none; b=IzhFjkaU85z06OKPeabgiYn+32Fuup6sndVrmgdC0+v3EXwBN09E/8LW9edJjQEgcypXaUknAMdCKB8n0qnDTQIzSN9b0UdAL54PoaE7/7/C7FXe9EAq3SQKTT49yeDEIaM73B8UEKCTbzbtDp5EawuPLO9JuJzB5PTQq1p3Vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666563; c=relaxed/simple;
	bh=XGuSAlyhE2uxddEA5f8DKDV3+xXSTfDAvM7JpWNDdis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fbNj7voDx9NGOT0NKR4kSmXgVgsj2oIcMpuoVzeidXYE3UJUog2yez71f1zWDkzXUNeYsCZq7ymUPM+vjo//2vEL+W9+jsDLaIW7YPLFxNg/9G+hoOY5uoOlPVG9iMtIlm+zc20YGZabVr1SqWSY+m1hIL4V5ZpVzQj5AtXLpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597F81F000E9;
	Sun, 28 Jun 2026 17:09:22 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2] mm/damon/core: validate ranges in
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260628165447.86217-1-sj@kernel.org>
References: <20260628165447.86217-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 17:09:21 +0000
Message-Id: <20260628170922.597F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Flawed Validation Logic for Empty and Inverted Regions
--

commit 663c371bd35c3a6e3044a1a0a7c4a31852e3924f
Author: SJ Park <sj@kernel.org>

mm/damon/core: validate ranges in damon_set_regions()

This commit adds validation logic to damon_set_regions() to ensure that=20
empty monitoring target regions are rejected. This prevents division-by-zer=
o=20
errors and sanity check warnings within the DAMON core logic.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -358,6 +358,12 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  	unsigned int i;
>  	int err;
> =20
> +	for (i =3D 0; i < nr_ranges; i++) {
> +		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=3D
> +				ALIGN(ranges[i].end, min_region_sz))
> +			return -EINVAL;
> +	}
> +

[Severity: Medium]
Does this validation logic correctly reject unaligned empty or inverted
ranges?

It looks like the alignment macros are applied before evaluating the bounds.
If a caller provides an unaligned empty range like [4097, 4097], ALIGN_DOWN=
=20
makes the start 4096, and ALIGN makes the end 8192. This evaluates to=20
4096 >=3D 8192, which is false, allowing the empty range to bypass the chec=
k=20
and silently expand into a valid monitoring region.

Conversely, a page-aligned empty range like [4096, 4096] evaluates as=20
4096 >=3D 4096 and is correctly rejected. Similarly, an inverted range like=
=20
[4000, 3000] would align to [0, 4096) and be accepted.

Should the raw input bounds (ranges[i].start >=3D ranges[i].end) be validat=
ed
prior to applying the alignment macros?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628165447.8621=
7-1-sj@kernel.org?part=3D1
