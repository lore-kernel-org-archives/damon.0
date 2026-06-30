Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33343DFC88
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792510; cv=none; b=gjJkKb0rBI0+onH3mklSBEpcvoA9weZL3q8Hg0/KHFisF+zxtcZZGIvDiWRB2lfUpLUK/TkKkQ1wz1weGBMik4PouwlAPeSJ/OCGARu3QzqqYUwUIbdcBSQQvAEWHlE0FkNRKOaYPefSt3lqx8qteSxbuWMpxIQ3gKCMZsrGUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792510; c=relaxed/simple;
	bh=vOh2MS4ezaD5cgfNwOn7pHibY+ylMGgstT8AoqQo7sY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pPtT2Hlp3rHQhmm6M5VPT1QEx61Hf5NfHIy9Q/4dKG25B3f5U6mFJMMf459X3LrYBa/L3QY2oInSOBRlr7isyag0DLEw2NBlJM5/lZUOoFDKnP8jUfW3WI2PQgiSVuPyzEasQSHFSZmemCXmds8ThL21nN9iir5k9XKdwCBQZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPy6wzIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPy6wzIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F11F000E9;
	Tue, 30 Jun 2026 04:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792508;
	bh=4jlHYpcI80yEm5FSA0iT0JxqNvI4i5FoTVlP4nwgzCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPy6wzIEUOKPECdl42o9+4I3Xn8OUqfYkQYsIHuTiAmcjSgX73rPuGPI4XlgkjAIs
	 il5brnndP9x8PJ1MHO18mJW0GGEhgOauOnsIFHoaFSpi7bEyXLpOFeRkXUXpUhM8+g
	 s3Vg96CHTDhRbYq/EWF57ag9wre54JhVvZaJ8mxBMMCNhLHRJpiVeivyXDUydGMpKi
	 Ui32rKa857x/2Jjf7YAkSjtpa3wwg9coQt/nvLVLg1PaANl+l7sg7ks5Zq9PBhhRpd
	 d6PSq0ppnBLQOemyDcNaK3uGdQuFPOv/14LvJVZ4u6rJvXmqXJrf1zTI2R5hhpF7Xq
	 VZUmvxvF1u+3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: validate ranges in damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260630035221.146458-1-sj@kernel.org>
References: <20260630035221.146458-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 04:08:28 +0000
Message-Id: <20260630040828.9D1F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The introduced validation logic in `damon_set_regions()` is flawed=
 and fails to prevent the `WARN_ONCE` and divide-by-zero crashes it intends=
 to fix. Distinct valid regions within the same alignment block bypass the =
check, leading to duplicated overlapping regions, inverted hole regions, an=
d a kernel panic.
--

commit 79a8d61a7b1112d3a6da1cff84b7f4a28c66e465
Author: SJ Park <sj@kernel.org>

mm/damon/core: validate ranges in damon_set_regions()

This commit attempts to fix a zero-length region issue that could lead to
a WARN_ONCE and a divide-by-zero crash in DAMON. It adds a validation
loop in damon_set_regions() to reject empty or invalid target regions
before they are processed.

Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RE=
CLAIM)")
Cc: <stable@vger.kernel.org> # 5.16.x

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 027250e43c66f..3dd2750c2ef20 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -356,6 +356,12 @@ int damon_set_regions(struct damon_target *t, struct=
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

[Severity: High]
This is a pre-existing issue, but does this validation fully prevent the
divide-by-zero crash?

If a user provides two unaligned regions that fall within the same
min_region_sz block (for example, [10, 20] and [20, 30]), this check will
evaluate ALIGN_DOWN(10) >=3D ALIGN(20), which becomes 0 >=3D 4096. This all=
ows
them to bypass rejection.

Because they pass, damon_set_regions() inflates both regions to [0, 4096],
creating identical overlapping regions in the list.

If a subsequent update covers these regions (like [0, 8192]), the
intersecting boundaries are adjusted but first->ar.end is left at 4096 and
last->ar.start at 0. This leads to damon_fill_regions_holes() creating an
inverted hole region:

mm/damon/core.c:damon_fill_regions_holes() {
    ...
		if (r->ar.end !=3D next->ar.start) {
			newr =3D damon_new_region(r->ar.end, next->ar.start);
    ...
}

Calling damon_new_region(4096, 0) triggers the WARN_ONCE(start >=3D end) and
results in a region with a negative size (ULONG_MAX - 4095).

When damon_merge_two_regions() eventually tries to merge [0, 4096] with
[4096, 0], the combined size underflows to exactly 0, causing a panic here:

mm/damon/core.c:damon_merge_two_regions() {
    ...
	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
			(sz_l + sz_r);
    ...
}

Should the alignment check be stricter, or does damon_set_regions() need
additional logic to merge or reject identically aligned overlapping blocks?

>  	/* Remove regions which are not in the new ranges */
>  	damon_for_each_region_safe(r, next, t) {
>  		for (i =3D 0; i < nr_ranges; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630035221.1464=
58-1-sj@kernel.org?part=3D1
