Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E13489868
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588682; cv=none; b=sRDjAxNHVjHCV3aS/sVB11zRv5h0rNg/kOAvULD1YzvIfKG+ITy2bxBgp2gImQKGVFRLJl39MIuJZ7lBHV9nchmUkIf8XWh1mkh5K090E97wJ9OZh+dP3dnxbtyUgVj5ygg+9hgYzdggmGqKCO4Ty23+k/FzZSrSel5AHm4hNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588682; c=relaxed/simple;
	bh=hLLrJJaTZGHBMiCpNBmPcXSwMrsucpdI3Bngsi1u0l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LnwV23QyeJMTzdN6QHjtSW2AZWM2EG0cfWiygYRY1IWTqdsIk1aVcWCi8RKJgwRYVhK5xeU7/nwIyk7tZqIPJh6c8jOuTc+RV/4cNcJIQvJWCVPACSOUXPbFz8zvqipOA0NC23I/U+AcPSeKi2rNIlOO6FgYwDl9PRNNZ4GQ/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZvLO/Cy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZvLO/Cy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108CE1F00893;
	Mon, 28 Sep 2026 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588681;
	bh=BU8CFoLd9Qmb7vN05mPSC851s51G/OFRfPVnUotNo8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZvLO/Cyk65elT/wwgwhIpd0yuj882PSlt5NrhYD22PTl6pe/7ju3NwrSDC9jTOBr
	 hNfyKITs66NtU7yinu73B+KoKRvTzDnDICJBzSpg15Vt3i77U87h6VRLsdRlD28loB
	 P6jDTZsyJMJO8HMC6eqkeoh6We5JDzGmCFbEw3wZ08zUeb0i/u4lmTDpnQpHyeW2aE
	 BqH2ZDNXtoLMTtbcb8snMpW0TOnrFQloLl3Ozx0hLkhq+hQWrQOvzUpiTge7CjlBnU
	 X2UBVzRZnSrW3g8sj9hFZ2xVbos/rj4uHODVpGukRbhR+FGLhglCwvWgTVLf/2rkQB
	 ytBehbNbPp6aQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 1/8] mm/damon/core: introduce
 damos_quota_goal->complement
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-2-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:44:40 +0000
Message-Id: <20260928094441.108CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm/damon: integer overflow in damos_set_psi_current_val on 32-bit s=
ystems
--

commit 2c98b9664c0f8cdd559874386842cae96a9ea8cb
Author: SJ Park <sj@kernel.org>
mm/damon/core: introduce damos_quota_goal->complement

This commit introduces the complement flag to damos_quota_goal, allowing the
system to use the complemented value of a target metric. It adds the field
to the data structure and implements support for it during quota goal commi=
ts
and metric value retrievals.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 733025b367457..270ce9c85a2ce 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi=
_total,
>  		struct damos_quota_goal *goal, struct damos *s)
>  {
>  	u64 last_psi_total =3D goal->last_psi_total;
> +	unsigned long val;
> =20
>  	goal->last_psi_total =3D now_psi_total;
>  	if (last_psi_total !=3D U64_MAX) {
> -		goal->current_value =3D now_psi_total - last_psi_total;
> +		val =3D now_psi_total - last_psi_total;
> +		if (goal->complement) {
> +			if (val < s->quota.reset_interval * 1000)
> +				val =3D s->quota.reset_interval * 1000 - val;

[Severity: Low]
Does this multiplication risk an integer overflow on 32-bit systems?

On 32-bit systems, unsigned long is 32 bits, with a maximum value of ~4.29
billion. If a user configures reset_interval via sysfs to a value larger
than 4,294,967 (about 71.5 minutes), the multiplication
s->quota.reset_interval * 1000 will overflow unsigned long.

This causes the auto-tuning goal complement metric to evaluate with a
truncated, incorrect value. While 32-bit systems running DAMON with 71+=20
minute intervals are extremely rare, could this cause unexpected behavior
when long intervals are configured?

> +			else
> +				val =3D 0;
> +		}
> +		goal->current_value =3D val;
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D1
