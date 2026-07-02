Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376D38E8B9
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027197; cv=none; b=TOjfRV+WI10m/RmzIkELexZphOXP3qmx5wd1ximwhNWbOngmoal2vAIUONzdk83VEcgYPVZINJGymv1m5sQs8tQPdW61piMNvRDjN5gk7bjhf+aPYVPRW+bwEAjmlTz/Tmb9mPjRk5be7OBRllaHuRBiJMMjUdkyLp4ZoyR4xAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027197; c=relaxed/simple;
	bh=Y7gz1TA5X5AsOG1V82RRisQWpFuE22JzcyprmCIsZQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKLhF2d/s2RNc6DJ428iTPlRcD3SRMEdLocjAjdLWm+P67G4SIq28Dw5M4+Wr+hPeW8kEJwb4x4cnqc6CF4zgdBL7glF/01vWZODeitGlZ4w55FUmmfKz9rZng6oVucWTCQqOGKDxYin72WB6VLC0AdYLY8+ZrOggO+b/bBIE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULNiswpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULNiswpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794F81F000E9;
	Thu,  2 Jul 2026 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027194;
	bh=uwmS7eYv6WLta77nbE9lNmmOAujDm+iFPyAyudVo90M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULNiswpNE4Av5b16ejPZ8hzA/oO5rOZPBMPYZrsnKGpTcshjWjhplBNdq7CFh6Wd9
	 A8dx0vfMsAHZqY2aCwfqoY6Sg9ivl1pGCXo8kfGQC84jXpOZr/kaz2BEUaVEiM489S
	 f+PbOmzQB4fEIXlC2113cJ6D9f/phzIJ4MFrX7X+G0bapnJtlsy6NeaH3M/J5LHsE0
	 nOD/fV/S5ByL5YeiqooKPDegf6y1DMuzEk8CDvghTam90xiYt7yHNrV4z3Avvf9hbT
	 b4b1xF0gcdopjok6sWfB0Hxkq/bUQNSHXFLGj6h8MZA/Ah6LI2Oi8iCfedfCkobc8c
	 d2MhYiSHEudxA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 6/8] mm/damon: document region size validation
 in damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702210551.95167-7-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
 <20260702210551.95167-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:19:54 +0000
Message-Id: <20260702211954.794F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `damon_set_regions()` creates duplicate and overlapping regions if=
 input ranges share aligned boundaries, corrupting DAMON's internal state.
- [Medium] `damon_set_regions()` inconsistently bypasses size validation, s=
ilently accepting and re-aligning negative-sized (`start > end`) ranges ins=
tead of rejecting them.
--

commit ded29c13e7c58ad791814e55b8139da57477556b
Author: SJ Park <sj@kernel.org>

mm/damon: document region size validation in damon_set_regions()

The kernel doc comment of damon_region clearly specifies every region
should have positive size. But it is unclear who should verify it.
damon_set_regions() is the recommended DAMON core function for setting
regions from the callers, and has the verification.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 805e089ff4f2f..b3c0ac5bf9b88 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -49,7 +49,8 @@ struct damon_size_range {
>   * @list:		List head for siblings.
>   * @age:		Age of this region.
>   *
> - * For any use case, @ar should be non-zero positive size.
> + * For any use case, @ar should be non-zero positive size.  damon_set_re=
gions()
> + * does the validation.

[Severity: High]
This is a pre-existing issue, but if callers rely on damon_set_regions() to
do the validation, can it create duplicate and overlapping regions when inp=
ut
ranges share aligned boundaries?

If userspace passes multiple valid non-overlapping ranges (e.g., [0, 100] a=
nd
[100, 200]) that align to the same min_region_sz (e.g., 4096), and the targ=
et
is empty, the loop in mm/damon/core.c:damon_set_regions() blindly adds
aligned ranges without checking for previous alignments:

mm/damon/core.c:damon_set_regions() {
...
			r =3D damon_new_region(
					ALIGN_DOWN(ranges[i].start,
						min_region_sz),
					ALIGN(ranges[i].end, min_region_sz));
			if (!r)
				return -ENOMEM;
			damon_add_region(r, t);
...
}

When regions exist, the iterator is not reset per input range:

mm/damon/core.c:damon_set_regions() {
...
	r =3D damon_first_region(t);
	/* Add new regions or resize existing regions to fit in the ranges */
	for (i =3D 0; i < nr_ranges; i++) {
...
		/* Get the first/last regions intersecting with the range */
		damon_for_each_region_from(r, t) {
...
}

It advances past the first intersection, fails to find the same region for =
the
second range, and creates a duplicate [0, 4096] region, which corrupts
DAMON's internal lists.

[Severity: Medium]
This isn't a bug introduced by this patch, but does damon_set_regions()
actually fully validate the size?

The validation check in mm/damon/core.c:damon_set_regions() uses aligned
boundaries:

mm/damon/core.c:damon_set_regions() {
...
		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=3D
				ALIGN(ranges[i].end, min_region_sz))
			return -EINVAL;
...
}

If a user writes a reversed range (e.g., start=3D4000, end=3D1000) via sysf=
s,
since 0 >=3D 4096 evaluates to false, wouldn't the invalid input be silently
accepted and transformed into [0, 4096], bypassing the intended size
restrictions?

>   *
>   * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval a=
nd be
>   * increased for every &damon_attrs->sample_interval if an access to the=
 region

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702210551.9516=
7-1-sj@kernel.org?part=3D6
