Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12926ADC
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479716; cv=none; b=VaG/WFmn+a0BhduyHiti3jI7DQRxQz9Z9ihyjjpVN4XH2J5dDhNHSTLMfI7l8WVk5WTuT3+RYsmipadx65567fBk7AMGAtfBkjKHogBX9Bc8LiC1gUWjjymjlWqtUSRc4uMMclwRiHoasE1BQqNwRV0q+rsEGN//O0mNBaZbPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479716; c=relaxed/simple;
	bh=AMWKtalljSrvdeD9knLMAba4zsKcknMmuh6OdHpiGAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K8QlvPwaQvBFFuOUXf/DpM/cqLHkByMWAw+q522MiQsWVPxexE2da409wKrn2OX0CFuvHd89avOLhQ0R9G1OObjmymb8YS214tWqU7ZcXygC+f1yHtAGfaJs4g1Lr9/XlXLAV1iZ4eVNPsGE6y5/JShKQh3sy0t2742wGsr+AZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWtgY2VR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWtgY2VR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C441F000E9;
	Wed,  8 Jul 2026 03:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783479715;
	bh=br0QE4Kq4gthWD0skGPVP1F84r8+y4KQ4ITMU5H5k8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWtgY2VRcdlaC49WGttwZVQUXwZblB1LaYwK21yJzcG/g7ypuEPUG9+RnmwPFI5mL
	 pgBNk2zQKdySI108AYbCCcPIojMjBl/4W3Zu1SpMnzRBhtWFbflxABjzsy7xdHf1Gk
	 i1t3Gj58ApymaaSsPPeGcnNsl44ycZkH3sd85h/Lg6SwKCyELkMXE74RPSk0eWN+Rb
	 Q9DYKRTxi9V2fhfB55JJWjU+PMgT5n8HszDM32hMCn4OlGaQAW8AoP4SPPTD27nPDQ
	 PvyZU13ewvax6VAUajULOnTr8Xy/HUx4fQ/HSVIQmQD01tU4cfbItbppWR3oZJ+4kA
	 kWFxyfGf4H0wg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 5/7] mm/damon/core:
 s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708024855.116614-6-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
 <20260708024855.116614-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:01:54 +0000
Message-Id: <20260708030154.C6C441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in sample scaling functions `damon_sample_=
bp_to_count` and `damon_sample_count_to_bp`.
--

--- Patch [5]: [RFC PATCH v1.3 5/7] mm/damon/core: s/nr_accesses_for_new_at=
trs/nr_samples_for_new_attrs/ ---
commit 9db3c90e1f930b4b71612a504362560074396989
Author: SJ Park <sj@kernel.org>

mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/

damon_nr_accesses_for_new_attrs() can be used for not only nr_accesses
but also any positive sample count, like probe_hits.  Rename to be able
to be used for such general uses without confusion.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 718268df27fa7..800ff6b6d2473 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -890,22 +890,21 @@ static unsigned int damon_sample_count_to_bp(
>  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can the 32-bit unsigned
integer multiplication here and in damon_sample_bp_to_count() overflow?

When a privileged user configures an aggregation to sample interval ratio
greater than ~429,496 via sysfs (e.g., 10s aggregation and 10us sampling),
the mult_frac() macro performs a 32-bit multiplication of the remainder
by 10000. This could overflow when the remainder exceeds 429,496.

Similarly, in damon_sample_bp_to_count():

mm/damon/core.c:damon_sample_bp_to_count() {
	...
	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
}

The expression bp * damon_nr_samples_per_aggr(attrs) is performed as a
32-bit unsigned int multiplication, which could overflow 4.29B.

Could this overflow silently corrupt region access counts, causing DAMON to
make incorrect memory management decisions like paging out actively used
memory?

> =20
> -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_acce=
sses,
> +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {
>  	return damon_sample_bp_to_count(
> -			damon_sample_count_to_bp(nr_accesses, old_attrs),
> -			new_attrs);
> +			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708024855.1166=
14-1-sj@kernel.org?part=3D5
