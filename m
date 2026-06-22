Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1D3BB109
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138983; cv=none; b=BywmCp5PhG9SBYFhc5ml9Gh6A7dhCvK07uMqTGbfbj6eeWdv4IQVrx++Kr3f9PcoB6Y4/Nzb7veEBg1T4ZxfmvrvDei54onMnpl+OzeHzDtI/Y5q9BPzSl8ZVGD/gM5moo7Zem3Punbw58wVW1rd5E0Av+SkPao3Wkj13/JK8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138983; c=relaxed/simple;
	bh=PNLP3xGe+1PSCiUiP4tzWWwRDIt/uWU5LyTiuQ2zdM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jt+riYOzAqrDrBxPE6XP/QMI8iy97uTC5V9E+APpFIH/VZAjGRd/uwvLN85IbJORi+TeNBiMNDx/9eBCSEHyfjG8sEYk9jIIPeyY8NsRbEqtGDyuB1pgVtM4GYcHDg7u0WEuVuHf31L1CL7b3SZ2NyjfvJ2+9JV5k5Iqi5kSjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsJ2aJvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsJ2aJvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B9D1F000E9;
	Mon, 22 Jun 2026 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138981;
	bh=aKuUbsCM2ucq+2oFlW2XqFJask7DEek0pnwpRMomN4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsJ2aJvZCnDBmWtlKsVQYoIwJIKTfh7jqe7wJSmmeR3RbC+mGe5AnUL55Pu15ieu8
	 Onh7OrR6g2/hdkCef8/c7GVy6MM3SXwDPtjCLb5WK4gD4R+acQhzPNhbtW7eHYZRDy
	 6g3vekndzKjMTfrqszJrKdj5tsLT0BMnFbjM1+MHlNnATIJTAuaYzsjk0hQnBsMyqW
	 GIyp+j8cdbXdlNlv0/rCu600elIE+1XGdo80+ZP8a5aB+3oy5H+AJrs0PffFknlgWO
	 WMhjXMBjWMVmr4o1wv7lvH+zeflYIaAVfQfI3D26vbvMhiBtQ8nOGlICnRqcG45CVz
	 DXVRVLtMVClMQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 07/18] mm/damon/sysfs-schemes: use
 damon_nr_accesses_mvsum() for damo regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260622142139.30269-8-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
 <20260622142139.30269-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:36:20 +0000
Message-Id: <20260622143621.84B9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Integer overflow in `mult_frac` on 32-bit architectures when calcu=
lating `left_window_bp` in `damon_nr_accesses_mvsum()`.
--

commit 3dcb4c6bbc65644874c65412bf73b8673d929524
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions

This commit switches the DAMON sysfs interface to use damon_nr_accesses_mvs=
um()
instead of nr_accesses_bp for scheme-tried regions. The new function is cho=
sen
to be simpler and more tolerant to errors.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..e648b0f809332 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -167,7 +167,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_=
scheme_region_alloc(
>  		return NULL;
>  	sysfs_region->kobj =3D (struct kobject){};
>  	sysfs_region->ar =3D region->ar;
> -	sysfs_region->nr_accesses =3D region->nr_accesses_bp / 10000;
> +	sysfs_region->nr_accesses =3D damon_nr_accesses_mvsum(region, ctx);

[Severity: High]
By switching to damon_nr_accesses_mvsum(), does this expose a 32-bit
integer overflow when calculating left_window_bp?

Inside damon_nr_accesses_mvsum() in mm/damon/core.c, the mult_frac(x, n, d)
macro evaluates (x % d) * n / d using typeof(x), which is unsigned long for
left_window:

mm/damon/core.c:damon_nr_accesses_mvsum() {
    ...
    left_window_bp =3D mult_frac(left_window, 10000, window_len);
    ...
}

If window_len (derived from aggr_interval / sample_interval) exceeds
429,496, multiplying (left_window % window_len) by 10,000 can exceed
4,294,967,295. On 32-bit architectures, this silently overflows the
unsigned long maximum value.

This corrupted count would now be exposed to sysfs here, and it also affects
DAMOS scheme applications in __damos_valid_target(), potentially leading to
incorrect memory reclaim or migrations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622142139.3026=
9-1-sj@kernel.org?part=3D7
