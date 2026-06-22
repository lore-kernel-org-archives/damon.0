Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C73BB109
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139035; cv=none; b=lWu/FWexgJBSIv090PRbF11NU3YK5FsTIJ2RAAOkfXq3x9U/N48sYuSaJQ0chb5pGnJogDCIve7IBuPq2rA9aVVRn/RlAJa1j8YLE7mvZTYisd08GGact637yuc8BXbKf1sZfAyxSRvgU1S6DJJvl2wBtXfSzk3mk8aXucqsegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139035; c=relaxed/simple;
	bh=0jq3Y5fOmcxDJrMIYalaheHZ4TCMS7oBZccjhOH8yKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mbN5w7b16HuRIKt3E7eifvuf9MjKW9+Xb3htSLe7NaINRxD8At2jm8QvZVU/9l1VGpqxerJV3bXreMJTV+0u2VmNxBf96YpSHn184X2/vfEorwe7CKzdJWBjbqUQTKFXhYVuDLMdw3zVIe+RsT7bq+Cepbgficzneb34Qe0O+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApXhPUCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApXhPUCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED1C1F000E9;
	Mon, 22 Jun 2026 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139033;
	bh=8Mbcv7lI3VxoMrAn1/6/TgAOYhPaHn85MdicaZvPMgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ApXhPUCmkIYXbi4urTR9zoo4L6HD4sqyN0zetM3oIN9SkK0XmeUwiFselrYHdGZjW
	 rIAn6lPbYZ5rYRZq2v5JpXEJHKqyuOvxAVkbu9HGltyihSRkg5ksvaDs1zdk8QNVbk
	 I5QFXN/3u4NvqtP65MWwKIS3bFz20FJTV8l4waKbuQSgJ4v0Ypi6YULPZi67X5OyKo
	 iU8XPUnQ93/ixY1dWsc6tqsvh8HkeisdhEqMSBDLz9tNBQEAzue1XziyL3KJ4ltg0N
	 eJ+SpKuI2OGtABTBM4qmvPAv5uXd0Q9xf+Vv1EYhgh1wkYX9HhOp5prvMl40VdRFG2
	 XQL8lE0voouKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 03/18] mm/damon/core: always update
 ->last_nr_accesses for intervals change
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260622142139.30269-4-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
 <20260622142139.30269-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:37:13 +0000
Message-Id: <20260622143713.7ED1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in `damon_accesses_bp_to_nr_accesses()` an=
d `damon_nr_accesses_to_accesses_bp()` when interval ratios are large.
--

commit d0875d13ff723f48c4ed975ef9fd7e92fde65c11
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: always update ->last_nr_accesses for intervals change

This commit ensures the last_nr_accesses value in a damon_region is always
updated when intervals change to prevent stale values from causing incorrect
calculations. It updates damon_update_monitoring_result() to unconditionally
scale last_nr_accesses using damon_nr_accesses_for_new_attrs().

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index addd14e4e70bf..bc40a6d10f277 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -873,6 +873,8 @@ static void damon_update_monitoring_result(struct dam=
on_region *r,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
>  		bool aggregating)
>  {
> +	r->last_nr_accesses =3D damon_nr_accesses_for_new_attrs(
> +			r->last_nr_accesses, old_attrs, new_attrs);

[Severity: High]
This is a pre-existing issue, but does this calculation in the underlying
functions risk a 32-bit integer overflow?

The new call to damon_nr_accesses_for_new_attrs() relies on
damon_accesses_bp_to_nr_accesses() and damon_nr_accesses_to_accesses_bp().

Looking at damon_accesses_bp_to_nr_accesses():

mm/damon/core.c:damon_accesses_bp_to_nr_accesses() {
    ...
    return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
}

If a user configures a small sample_interval (e.g., 5ms) and a large
aggr_interval (e.g., 3600s), the ratio calculated by damon_max_nr_accesses()
is 720,000. For an accesses_bp of 10000 (100%), the multiplication yields
7,200,000,000, which exceeds the 32-bit unsigned int maximum and silently
truncates.

Similarly, in damon_nr_accesses_to_accesses_bp():

mm/damon/core.c:damon_nr_accesses_to_accesses_bp() {
    ...
    return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
}

The mult_frac macro uses the type of nr_accesses (unsigned int) for its
internal calculations. Can this cause a similar 32-bit overflow when
multiplying the remainder by 10000 if the remainder exceeds 429,496?

>  	if (!aggregating) {
>  		r->nr_accesses =3D damon_nr_accesses_for_new_attrs(
>  				r->nr_accesses, old_attrs, new_attrs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622142139.3026=
9-1-sj@kernel.org?part=3D3
