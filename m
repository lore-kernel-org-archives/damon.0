Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E3280A56
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026941; cv=none; b=TKOAW5np7r1+MObcFPmKQrvMLOdFLZtpWO9XdGFIkAWx7RVkmeEiTrUnmPmIpFhojtLFoLLoUNT0MSgXOGXOVEKPRpLCd72wRa2GjbB0z4rjeXG7llQ0S05Oo89N9ihJGfHPQCEY43jvXtpvzzetGaUJVMiCGFNOj7Q9cH+i76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026941; c=relaxed/simple;
	bh=Sn1TJVfHFKjIXtAft2+PPHUMUDP7ho4XvPt4J1R3Jmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YO5AGOjfYlgF523e7Bt/DV+N/MLpM1bhhr8Th87S25cZk93Pi+s1hPN8ZzHNgwDc63x+YoMt5f6yJJA1KYiCcr9siqNhRmsTbF84cRsiNX7S0jfs3UUB6juyc0Zqe1/Jikl1GHsMGf9T8jFAlXxNbtY2pio99LEQK7ztHudFjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUxHGO6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUxHGO6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DA01F000E9;
	Thu,  2 Jul 2026 21:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026940;
	bh=5BHgwO/I8JS3HlQpf4nX1Ay4zDYTWNPGYHY4pyIkLSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OUxHGO6D1QsICpf/qEKOz9hYAEt3izjcZwSBMp+ONf3CEI8PS+IcalKbtFgnZd1uk
	 YZbP5rfDMJDqjOm7cPcDda8HaYqttAybmEzsGqK8IZEJoLza8YpC1jqFgOy2WXQvEu
	 IsP01ulPy/oe8GEwxYQFPeSDNMScRrhU5FrmEm9KNKM97PluPl0/IbGGPEe79IdlLL
	 /jgbinScBu1aBZvTpT0livAqp/7zZzrSqFaUiaddHnCgiO3EzaGjqSGjamP+Ezb9oa
	 yCuzRXFkOZ4pQ5aA1zwpIYjPmPYNwq/+CfukvrAp0/6PQR/RoQEZMirx+wYXiaQGzI
	 PR7fryqmJvidw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 8/8] mm/damon/sysfs: remove region size
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702210551.95167-9-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
 <20260702210551.95167-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:15:39 +0000
Message-Id: <20260702211540.07DA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `start > end` validation allows negative-sized region=
s to bypass subsequent validation, resulting in overlapping regions and eve=
ntually negative-sized regions in the DAMON core, leading to unbounded memo=
ry allocation (OOM).
--

commit d23d0a5af36c320aac75064c21548cc9de76c4f1
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: remove region size validation

DAMON_SYSFS validates user inputs for monitoring target regions to
disallow negative size regions.  DAMON core assumes only positive size
regions, though.  The validation is incomplete.  Fortunately
damon_set_regions(), which is eventually used by DAMON_SYSFS, does the
complete validation.  Remove the incomplete and unnecessary validation.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index e666dddf1feba..b65651498e0d1 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1987,9 +1987,6 @@ static int damon_sysfs_set_regions(struct damon_tar=
get *t,
>  		struct damon_sysfs_region *sys_region =3D
>  			sysfs_regions->regions_arr[i];
> =20
> -		if (sys_region->ar.start > sys_region->ar.end)
> -			goto out;
> -

[Severity: High]
Does removing this validation allow negative-sized regions to bypass the
subsequent overlap checks in damon_sysfs_set_regions()?

If we have an inverted region (e.g., start=3D2000, end=3D1000) followed by =
another
region (e.g., start=3D1500, end=3D3000), the overlap check in
damon_sysfs_set_regions() evaluates:

	if (ranges[i - 1].end > ranges[i].start)

Which results in ranges[0].end (1000) > ranges[1].start (1500).

This is false, meaning the inverted region bypasses the overlap check.

Will this inverted region also bypass the alignment-based bounds check in
mm/damon/core.c:damon_set_regions()?

mm/damon/core.c:damon_set_regions() {
	...
	for (i =3D 0; i < nr_ranges; i++) {
		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=3D
				ALIGN(ranges[i].end, min_region_sz))
			return -EINVAL;
	}

If the regions fall within the same alignment block (e.g., start=3D2000 and
end=3D1000 with min_region_sz=3D4096 align to 0 and 4096), the check evalua=
tes
0 >=3D 4096, which is false, passing the invalid input to the core.

When the negative-sized region reaches mm/damon/core.c:damon_apply_min_nr_r=
egions(),
can this cause an out-of-memory loop?

mm/damon/core.c:damon_apply_min_nr_regions() {
	...
			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}

The inverted region size would underflow to a very large number, which appe=
ars
to cause this loop to continuously split the region, allocating region stru=
cts
until the system runs out of memory.

>  		ranges[i].start =3D sys_region->ar.start;
>  		ranges[i].end =3D sys_region->ar.end;
>  		if (i =3D=3D 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702210551.9516=
7-1-sj@kernel.org?part=3D8
