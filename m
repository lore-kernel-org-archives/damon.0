Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E0364045
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474962; cv=none; b=XfQTjIXUYH5J4F5w3m6R4Rz7bNpNJxm0s8ce1fFtC8+aqinxTGfg7+vBzsUfpf9wsP5jrgrloKkys/bRAiNyKiPc8A4KhbkhwwpMkodU2dcpRFvjHYDSW7ktXZZDRVILxJ5C28zSAfeVvgg36SVg9uZssxW0ogn5pZPeGSmIck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474962; c=relaxed/simple;
	bh=MgQ9WccAV3uGjhb0SbyKYNaAa+obvyqxeaDnLtmKyM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vh9R+gRCmZi863OP/WJ2ql7YK8a3AwbmCO/FFKpyGQySFANs9ejbMwshB71SfyfD35asbLDkJqR4dCFDI8fKFBTQDetn4BnkXYa7uCzrbKeXMHnBhtzAdiBKyg+DTFjIN9dAPM8V7lIodcx56MIYe5wqxD+TxV7W/LpiS1biBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRPpItuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRPpItuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346731F000E9;
	Wed,  8 Jul 2026 01:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474961;
	bh=xKBzOEzaQKTacpLJ2OaFJ+scFRxUb8NEIvb2U1w6dcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRPpItuHKsP2gk6zL/5lOxSYBXMTaRXJD0Yn5i+iTwfGxXgPgTFJtdDlanChPzOkF
	 /ik0/6iHKwWI6oL/iJlU5ttyZ0px54LfBG4+6I44NCL2sHjcotpxEOY+M8wKIVDWPU
	 u5kSTZHMWiV+U4CjrCUCuQ6KJNtzczuQKbunlpGqXFt1cWroDAwjPcU9PbLiREvKMY
	 a5S6pILmlXmnPOn4ChO2Hk7422mGOHKpA7GCngtnGsqynzLKA+YONK3h/LfStffvo2
	 u1AqMnLeWejX4ntGrXbO6wFaFVhHpByAHvt7cL3UP/dH5oAmrjojcZo3QUIFs5QJjC
	 QB3c9AapAhuKg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 3/7] mm/damon/core:
 s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708013252.95888-4-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
 <20260708013252.95888-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:42:40 +0000
Message-Id: <20260708014241.346731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The calculation of sample counts and ratios in `damon_sample_bp_to=
_count()` and `damon_nr_accesses_to_accesses_bp()` can suffer from a 32-bit=
 integer overflow under extreme interval configurations, leading to corrupt=
ed DAMON metrics.
--

--- Patch [3]: [RFC PATCH v1.2 3/7] mm/damon/core: s/accesses_bp_to_nr_acce=
sses/sample_bp_to_count/ ---
commit e8ec17a3e305676513352140eeb31c1b75063618
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/

This commit renames accesses_bp_to_nr_accesses() to sample_bp_to_count()=20
to better describe its actual behavior. The function converts a positive=20
samples ratio into a count.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -876,11 +876,11 @@ static unsigned int damon_age_for_new_attrs(unsigne=
d int age,
>  	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
>  }
> =20
> -/* convert access ratio in bp (per 10,000) to nr_accesses */
> -static unsigned int damon_accesses_bp_to_nr_accesses(
> -		unsigned int accesses_bp, struct damon_attrs *attrs)
> +/* convert sample ratio in bp (per 10,000) to count */
> +static unsigned int damon_sample_bp_to_count(
> +		unsigned int bp, struct damon_attrs *attrs)
>  {
> -	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
> +	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
[Severity: High]
This is a pre-existing issue, but can the 32-bit unsigned arithmetic here
silently overflow under extreme configurations?

If an automated tool configures DAMON via sysfs (for example, with
sample_us =3D 1 and aggr_us =3D 1000000) such that the ratio
aggr_interval / sample_interval exceeds 429,496, the multiplication
bp * damon_nr_samples_per_aggr(attrs) would exceed 32 bits.

This could return a heavily truncated count, potentially corrupting access
metrics and causing flawed memory management decisions.

A similar overflow appears to happen in the calculation of the ratio in
damon_nr_accesses_to_accesses_bp(). When it calls mult_frac, the parameter
nr_accesses is an unsigned int, causing nr_accesses * 10000 to overflow
and wrap around when evaluating the remainder multiplication.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708013252.9588=
8-1-sj@kernel.org?part=3D3
