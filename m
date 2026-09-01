Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0F33F8B2
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261168; cv=none; b=XD9MoDCiIW1wFXxDDlu9EqEaHONBQW+DiC/tw9pXXnH54ouLNBJFW1M0kurTQXBa4t9Ap3A0SsnxuWingR+ZTWBJ6oAbaGJjMktfKAmm/hP96lFPeaeoqJOJHY0wgAgiN9VPe5L3gcLQ/4saxfGUjRJVvn01uMCWm3/0fD4Os58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261168; c=relaxed/simple;
	bh=pBDTtYpo4VqLYxFTKOzfIm79kSRSKbUifvG0oP0iAFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tNVLTUBqMG8o4U4OcsSVPe8u/algdebVXuX9V04lYInzN6L/HEV684gFjN0nQvkMHY1cGBqzjgJEqExtkPPLpbWkEUP+vUWeqjomkfcPp4/L/PJY2EuqjVw5lb+lZLPVX/rX7m671i7JZOo07kyArRA3A7sZSjPNlnoLh62Yrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5f2oSiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5f2oSiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907BA1F000E9;
	Tue,  1 Sep 2026 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261167;
	bh=tC/4mjItFamkN0elPv5R19cGVkTkWvj6iWntaRobJrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5f2oSiUQPJLppyeoB7zkZ7nNBsLuAc6ZETm5lXGGwts/yE9qWGvEShFj7Lp9tpMF
	 //sXeFbgMzHpAIHQ4QE92UOUGYotYjX00cy4SvWKHyRKDvDsPDdt0ierKwjqpmhrRV
	 pHfol6wv/w8zPHRjQxL889jfOv1FSQyb0trDNpxFiuGIfwl0v6BEpc7k/h2uecaow6
	 aNScFk1VaLbQ26t1A26RUcuKhI9ViWcPGQPSX1SraOfqisrHiF4tLte0szKbrPStiD
	 qJv5/iBENCtDeRyhrw5gs0QdRuzOvBrRiwKgjmP3YmoskqoJfUAsSLsWkPQwcuBBQK
	 66GLg/f4aOYPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: always return false when esz is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901105925.106186-1-aethernet65535@gmail.com>
References: <20260901105925.106186-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:12:47 +0000
Message-Id: <20260901111247.907BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch breaks the O(1) early bailout for schemes with a zero =
quota, causing O(N) evaluation of all regions, significant CPU overhead, an=
d corruption of the 'nr_tried' statistic.
--

commit dd8f74f4c9d96719d46a1466acabcc4d814aadc9
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: always return false when esz is zero

This patch modifies damos_quota_is_full() to return false when the effective
quota size (esz) is zero. This prevents qt_exceeds from increasing
unexpectedly when a temporal goal tuner achieves its target and sets the
quota to zero.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3f89cfdf5f022..012e8970f154f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2551,6 +2551,8 @@ static bool damos_quota_is_full(struct damos_quota =
*quota,
>  {
>  	if (!damos_quota_is_set(quota))
>  		return false;
> +	if (!quota->esz)
> +		return false;

[Severity: Medium]
When a scheme's goal tuner achieves its target and sets the quota to zero,
does returning false here unintentionally break the early bailout in
damon_do_apply_schemes()?

When this function returned true, damon_do_apply_schemes() used it to skip
the scheme entirely:

mm/damon/core.c:damon_do_apply_schemes() {
    ...
		/* Check the quota */
		if (damos_quota_is_full(quota, c->min_region_sz))
			continue;
    ...
}

If it now returns false when esz is 0, doesn't that cause the loop to
evaluate every region via damos_valid_target() and damos_apply_scheme()
instead of skipping the scheme?

If the scheme is not skipped, it appears damos_apply_scheme() will calculate
a zero sz and jump to update_stat:

mm/damon/core.c:damos_apply_scheme() {
    ...
		if (damos_quota_is_set(quota) &&
				quota->charged_sz + sz > quota->esz) {
			sz =3D ALIGN_DOWN(quota->esz - quota->charged_sz,
					c->min_region_sz);
			if (!sz)
				goto update_stat;
    ...
update_stat:
	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
}

Will this cause s->stat.nr_tried to be incorrectly incremented in
damos_update_stat() for every bypassed region?

>  	if (quota->charged_sz >=3D quota->esz)
>  		return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901105925.1061=
86-1-aethernet65535@gmail.com?part=3D1
