Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EC377560
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923699; cv=none; b=ZSnvRy+W7W+7An3LUe4lbmY1VMp4IHpDXph4nym5Sc0qKKxd9EtnlSuVCXioT0VqcCcRYBj03lEfHuVoGy3tRMmz3Nld4cOwCXv3H9EhK6IESyykaoN1/8Zu3tuy9ImxII5WrYNd2KudEroKHaLS0J7cszetNCZv7OtVg3fDSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923699; c=relaxed/simple;
	bh=NAs6iUu/TmOV4fwJ2Aip3ZqWm7fReLIZlz2iVgvrHR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnmtQw9HjntZu2rtlhpcWcm+K82AoCHEgn1VvuP/x8ZO0ih2jPwaR6BNhkubs7bB5s9tkDO7+tL/0jSSrOgse0WQf1Q1T/IW9smNRtvNvpF6LecFSLuzcYN24fkjZRy18fAyXRNtjDF2/rLhNlRhDt1hT4NjSk+N6IW/WdbRJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv5kKKrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv5kKKrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526421F000E9;
	Wed,  1 Jul 2026 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923695;
	bh=fjJ5xV/bqeAJ9ScC61oY1o33605R1CY62lQJ82sPWsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vv5kKKrNrm3c4iGY5dxG+hORUc1E/OQSDo3jI1H/WjPA9kxYAMaPv4tgNL5gNvEEn
	 e2qI3QzPhH5m6356ooJAdRcxvyYpTzRT+LN0CanI+3Sdqafu26U/tQILjrq3sCYqxl
	 ot2whogQjbOLkqkYCC75Byu+gxGIM4qPGjfmlOzpCK4RUxC2VslHXZbWpgyaX60PNO
	 J23eYNhIp0eZB2mvUpjCRFeMGcsclfHnJnlqdBYrRgurEwz1Ovn4kHdgtmTDNHarNS
	 LdLWAw/OhJ/ocWJ21GdZxaa2r4Ikq4kJcapvYQPcDAFqjOFnPcxa+de37JUfSTcaoi
	 fTJbaL8W+ITdQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/8] mm/damon/sysfs: remove region size validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-9-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:34:54 +0000
Message-Id: <20260701163455.526421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `start > end` validation allows users to configure mo=
nitoring regions with negative sizes, causing integer underflow in region s=
ize calculations. This leads to infinite memory allocation loops (OOM), pot=
ential list corruption, and CPU soft lockups during DAMON region splitting =
and scheme operations.
--

commit 013d66b2108372ca2ada7fc6fcfd5e07f93fd78c
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: remove region size validation

This commit removes the region size validation in DAMON sysfs that checks
for negative size regions. The commit message states that the validation is
incomplete and that damon_set_regions() already performs complete
validation.

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
The commit message mentions that damon_set_regions() does the complete
validation, but looking at damon_set_regions() in mm/damon/core.c, does it
actually validate that start <=3D end?

mm/damon/core.c:damon_set_regions() {
	...
	r =3D damon_new_region(
		ALIGN_DOWN(ranges[i].start, min_region_sz),
		ALIGN(ranges[i].end, min_region_sz));
	...
}

If a user configures a region where start > end, wouldn't this cause an
integer underflow when calculating the region size later?=20

For example, could this underflow lead to an infinite memory allocation loop
in mm/damon/core.c:damon_apply_min_nr_regions():

	while (damon_sz_region(r) > max_region_sz) {
		damon_split_region_at(t, r, max_region_sz);
		r =3D damon_next_region(r);
	}

Could this loop evaluate the underflowed size and attempt to allocate new
regions repeatedly until an OOM occurs?

Additionally, for newly split regions where start < end locally, could this
spin over a massive address range without yielding and cause a CPU soft
lockup in mm/damon/paddr.c:damon_pa_pageout():

	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
		...
	}

>  		ranges[i].start =3D sys_region->ar.start;
>  		ranges[i].end =3D sys_region->ar.end;
>  		if (i =3D=3D 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D8
