Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C940D579
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782608793; cv=none; b=lAOm64OZhR85d5MmyRFmkk4cGfObBBiqX+QMSGfcr7zNH5KaS8FkhtBqsnIit9IBCJcHQT7b/DeykyjceQSyFX6sYSOlGWZsrlipcaTNC6ojcRPw9A7sFABuQCnlXXcH6HO6rFAnK+8YCV6HcdhLyxWwGiNvnud3yo4eWyWtXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782608793; c=relaxed/simple;
	bh=LpiAcnmZrz7eo/eR7j0iK/XJA7ImMCxaNPwKaz2iGzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJX2MCLRRpLWNdyz6XK4amAQuiTQf1e+fKQ22d1HDZcFfpQqRc0qabjUEFOxCIqmIAFAAcQIoG26mViUm7ubBGo/0Fa8F0qVsq9/jTAwXttMvVKRDPahuQ2Ka6yINGLBMJC3QiKfzGrkEC/+VhIg5Jm++DEXK/NaopzVO3S6S8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrXr22UW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrXr22UW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E21F000E9;
	Sun, 28 Jun 2026 01:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782608791;
	bh=jLphXreoyli00Yevserf7nZHTgthxT8r02WjApiski0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrXr22UWo5mbj1QQJw7+OTTQpPo2ls/mhHzyAkVGs3PrE4FTl0EoieoIIb6FFIg9P
	 cdwJk33ZsVzkE85oHBHoyZpN1z9QVQkIOMrve3Q4SBXUAnZxf6jvDuwOILU5gIOQ3H
	 OFeJ9wBwwlYjqqAyFs3/eFf+uvKi03TwCdDnwmw7+QD9ypljvYX5zSaLPTHT/EOpZB
	 5K9APfHKyrPLlKFGMBz138breIjd6iHFVRUglr1+6ryBmL4wrw3PUmdaA6KthxNm6n
	 X3pmomiHBNIr1LNOBfcgHwpmKvlf55+3DwAOP8znYrSIjj74twoPWrJnhKDMj7Pv/f
	 KD9I9HppQJ6nA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1] mm/damon/core: validate ranges in
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260628005723.28549-1-sj@kernel.org>
References: <20260628005723.28549-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 01:06:30 +0000
Message-Id: <20260628010631.797E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The new validation logic incorrectly uses `ALIGN_DOWN` for the=
 region's end address, falsely rejecting valid sub-block monitoring regions=
 and breaking the user API.
- [High] Integer overflow in `ALIGN()` bypasses the newly added validation =
check, failing to prevent the creation of zero-length regions.

Pre-existing issues:
- [High] sysfs interface allows `addr_unit` to be set such that `min_region=
_sz` is not a power of two, breaking alignment macros and corrupting bounda=
ries.
--

commit a7d14189013c68fcb3a5a9644321f7f319e6fe5f
Author: SJ Park <sj@kernel.org>

mm/damon/core: validate ranges in damon_set_regions()

DAMON core logic assumes zero length regions don't exist, but API callers a=
llow
empty monitoring target regions. This patch adds validation in
damon_set_regions() to ensure start is strictly less than end after alignme=
nt.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..cbdf29d119c93 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -358,6 +358,12 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  	unsigned int i;
>  	int err;
> =20
> +	for (i =3D 0; i < nr_ranges; i++) {
> +		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=3D
> +				ALIGN_DOWN(ranges[i].end, min_region_sz))

[Severity: Critical]
Does this ALIGN_DOWN() on the end address incorrectly reject valid regions?

If a user configures a target region with start and end within the same
alignment boundary (for example, start=3D4096 and end=3D8191 with a
min_region_sz=3D4096), the check evaluates to 4096 >=3D 4096 and returns
-EINVAL. The previous behavior successfully expanded this to [4096, 8192)
using ALIGN(end). This seems to reject previously valid inputs.

[Severity: High]
Can an integer overflow here bypass the new validation check?

If a user specifies a region with an end address near ULONG_MAX,
ALIGN_DOWN(ULONG_MAX, min_region_sz) will evaluate to a large positive
value, which passes the start >=3D end check.

However, the region creation logic later uses ALIGN() on the end address:

mm/damon/core.c:damon_set_regions() {
    ...
		for (i =3D 0; i < nr_ranges; i++) {
			r =3D damon_new_region(
					ALIGN_DOWN(ranges[i].start,
						min_region_sz),
					ALIGN(ranges[i].end, min_region_sz));
    ...
}

ALIGN(ULONG_MAX, min_region_sz) overflows to 0, which means damon_new_regio=
n()
is still called with an end address of 0, bypassing this validation and
creating the exact zero-length region this patch intends to stop.

[Severity: High]
This is a pre-existing issue, but can min_region_sz be a non-power-of-two,
corrupting boundaries when passed to ALIGN_DOWN here?

The ALIGN and ALIGN_DOWN macros rely on bitwise masking, which requires
the alignment value to be a power of two.

Looking at how min_region_sz is calculated in damon_sysfs_apply_inputs():

mm/damon/sysfs.c:damon_sysfs_apply_inputs() {
    ...
		ctx->min_region_sz =3D max(
				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
    ...
}

If a user writes a value like 3 to addr_unit via sysfs, min_region_sz
becomes 1365 (4096 / 3). When 1365 is passed to ALIGN_DOWN here, the
macro produces garbage addresses.

> +			return -EINVAL;
> +	}
> +
>  	/* Remove regions which are not in the new ranges */
>  	damon_for_each_region_safe(r, next, t) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628005723.2854=
9-1-sj@kernel.org?part=3D1
