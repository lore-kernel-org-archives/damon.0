Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A933469E0
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608537; cv=none; b=stxCtlNbTm52X2geyL+Q3EAiD/Wp1YUERmbveJxlo2g/SWe2WCJm6MvaN41on/bJs3D/jDc6PrWBe8lm6drGoWP/A6C90KyJ/wF8/0r5HnnwkYhHZigcFWockhAUPZtJvIYdwh/+TMdcq6e26GrUZ5UEPW3WMvbX6+dtjCVdsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608537; c=relaxed/simple;
	bh=HSlyfH1o3NfT+NsarmU2jMUTOznDMG84wsUMeL2pYSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sk17d3WMtEe5LBuEbqx1QnNCs+XsFL0AxrArJIiInVKF4UDFK7TDpjt7DFjNv52XWRLKpbG1pHse8y+i2+m/zywptZpOI9N91AkXqSJFUPDZJgYtfCKOi1m0STA46Xi8GUqxpCDwa66tvTtBLB2d4w1rVMRzDcnQImg7GnlpWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo5sk34n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo5sk34n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C811B1F00A3A;
	Thu,  9 Jul 2026 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608536;
	bh=IIPD94esHB8he5vce+mKaQJS8zNK/j1lv7eZ7H16vwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oo5sk34nWVj5ev7QbrAgbhsRhW+U/OnZftp1n6TvewLjL0dchr/u57EMC6oKb9UUq
	 7X5IUbztf/MyMWnvNoauDiTeCjqszS7VNXOTeqU6o2zgMmLeZX0wDvVVBlLrSOdk0h
	 yGZYgLuzA439zyERqh0oqSweqo+BO3u/uj+fnkoi7t4SfJxLWX2cPtixjP4gQgjHxR
	 s4Poz1fp0Lc8AD8fLxFziYj563/kPvnOKXL9jQRuCg+u9eYT3IrWJzOmYsF3TQ6d6I
	 PijcCY/GXyH0KhYkQH2L22WITwE1eaijPvQ5hrCmp0e7EMW+eOfyjVf1plNaO6GVv2
	 WMOjyDccsWK6w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 12/19] mm/damon/core: set samples in
 apply_probes() if probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260709140600.90950-13-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
 <20260709140600.90950-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:48:55 +0000
Message-Id: <20260709144855.C811B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] When access checks are disabled, `max_nr_accesses` is not update=
d but is still used for the region merge threshold. `apply_probes()` is inc=
orrectly called without requesting or capturing the maximum weighted sum.
- [Medium] Setting probe weights on a context whose operations do not imple=
ment `.apply_probes` (e.g., `vaddr`) silently disables all monitoring.
--

--- Patch [12]: [RFC PATCH v1.2 12/19] mm/damon/core: set samples in apply_=
probes() if probe weights are set ---
commit ffce494dcbbb1125634a81b14be56b2f89aefe7e
Author: SJ Park <sj@kernel.org>

    mm/damon/core: set samples in apply_probes() if probe weights are set

When probe weights are set, the prepare_access_checks() ops callback is
not invoked, so sampling addresses of regions are unset.  Ask
apply_probes() to set those together in the case.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e250b7080708d..f1be748e9a674 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3777,7 +3777,8 @@ static int kdamond_fn(void *data)
>  		if (!access_check_disabled && ctx->ops.check_accesses)
>  			max_nr_accesses =3D ctx->ops.check_accesses(ctx);
>  		if (ctx->ops.apply_probes)
> -			ctx->ops.apply_probes(ctx, false, false);
> +			ctx->ops.apply_probes(ctx, access_check_disabled,
> +					false);

[Severity: Medium]
When access checks are disabled, check_accesses() is bypassed and
max_nr_accesses is not updated.

Later in this function, kdamond_merge_regions() uses max_nr_accesses to
calculate the merge threshold:

		if (time_after_eq(ctx->passed_sample_intervals,
					next_aggregation_sis)) {
			kdamond_merge_regions(ctx,
					max_nr_accesses / 10,
					sz_limit);

Since apply_probes() is called with return_max_wsum=3Dfalse, it doesn't
update or return a max weighted sum.  Will kdamond_merge_regions() use an
invalid or stale threshold (often 0), breaking the merge algorithm?

[Severity: Medium]
If a user sets probe weights on a context whose operations do not implement
.apply_probes (e.g., vaddr), access_check_disabled will be true and
check_accesses() will be bypassed.

Since .apply_probes is not implemented, this block is also skipped.

Could this completely disable all monitoring for the target with no error
feedback to the user?

Validation in damon_valid_probe_params() successfully validates this state:

mm/damon/core.c:damon_valid_probe_params() {
...
	if (!damon_has_probe_weights(ctx))
		return true;
...
}

Should damon_valid_probe_params() check if ctx->ops.apply_probes is support=
ed?

> =20
>  		if (time_after_eq(ctx->passed_sample_intervals,
>  					next_aggregation_sis)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709140600.9095=
0-1-sj@kernel.org?part=3D12
