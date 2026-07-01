Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB6360EFF
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921860; cv=none; b=O4zS4J5W3RQf4B5A2jeFHX/1YgO6bGw0FJyGYbb3J42dV9SDYdPfQXHI0aFZeaXzbYrSnW0Eq4eZ/vZTNhovF4/q5IBLRhmInXlYHjfslSI/uuIuzyfkjQjQhUcZJGW07fVxRPCSGTWn/0lETq+9mmymSvBaD4Zt/UWV9WZfb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921860; c=relaxed/simple;
	bh=KssrPyWuSOevoq03hU6aSCyRYduLbHMTUGk7Ms/NtP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iHN2ON+xvNydg2Gnx8iis64OQzz7DB+fxxgbN3BkgumMayvsyC5sa9Ats9slWCOM6GMjQJpdFfng63EqhT6Ky//P/i3O5NbbGm5F/zg+0irSWOZt2/FeFHR1Uq7WbJMAYox51EFhEiTyuD0XRNZsaZFPJ9TQqDd5pkiwdNkWz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWi9gYYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWi9gYYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A40B1F000E9;
	Wed,  1 Jul 2026 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782921859;
	bh=XJ/K7rvOA1MswZpnRGe03X6KrEVjgbi41O6LaY67nOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWi9gYYk/V8mKDclf0G/M8jh8N+jIlsVbjqwXnW0XPQhbVaCXyU6mf8QIL3T2ywFI
	 /1QcYjTZerGl6OWrbJ+g4zGpQTWXGmwclGn4bhsuAtv9D7NOWbEIXPIw5YW4kM4blw
	 Bpvy7ha6rDL1ZmE3bO9g/QTFhKHVtfH/KZNbNLmZaE3X6TLgoI07FDlTBXWZYpXlNJ
	 ZE+mkDtyou/sXMnKWVxi/sfspwvtawxtC6vzv908y95O8Q1hoyVQwGRYlkbJXqyOhg
	 ZL/JRH3ENkGodAoa16kwByppQKr58nm7ZRveRmcdJTW4ACqXPhTYSLjN+Wf4UyaR5o
	 S2/bB+zwnlIlw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/8] mm/damon: document region size validation in
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-7-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:04:18 +0000
Message-Id: <20260701160419.4A40B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The documentation incorrectly claims `damon_set_regions()` validat=
es region sizes, which led to the removal of input validation in callers, r=
esulting in a kernel OOM panic when negative-sized regions are processed.
--

commit d4cdfb1871ad152ec6d79d41fca7f1497b7467a0
Author: SJ Park <sj@kernel.org>

mm/damon: document region size validation in damon_set_regions()

This commit updates the documentation for the damon_region struct. It
clarifies that callers can pass any values for region addresses because
damon_set_regions() validates that regions have a positive size.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -51,7 +51,8 @@ struct damon_size_range {
>   * @list:		List head for siblings.
>   * @age:		Age of this region.
>   *
> - * For any use case, @ar should be non-zero positive size.
> + * For any use case, @ar should be non-zero positive size.  damon_set_re=
gions()
> + * does the validation.

[Severity: High]
Does this documentation accurately reflect the implementation?

Looking at damon_set_regions() in mm/damon/core.c, it lacks checks for
start >=3D end before passing boundaries to damon_new_region():

mm/damon/core.c:damon_set_regions() {
    ...
			r =3D damon_new_region(
					ALIGN_DOWN(ranges[i].start,
						min_region_sz),
					ALIGN(ranges[i].end, min_region_sz));
    ...
}

If a region is created with start >=3D end, would damon_sz_region() underfl=
ow
to ULONG_MAX?

This enormous size could trigger an infinite memory allocation loop in
damon_apply_min_nr_regions() which repeatedly calls damon_split_region_at():

mm/damon/core.c:damon_apply_min_nr_regions() {
    ...
			while (damon_sz_region(r) > max_region_sz) {
				damon_split_region_at(t, r, max_region_sz);
				r =3D damon_next_region(r);
			}
    ...
}

Since a subsequent patch in the series (mm/damon/sysfs: remove region size
validation) relies on this guarantee to remove the validation from sysfs,
could a user writing a region with start >=3D end to the DAMON sysfs interf=
ace
trigger an Out-of-Memory kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D6
