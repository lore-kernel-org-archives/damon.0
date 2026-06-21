Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B545039
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782058266; cv=none; b=LI9ngHaVf4xRQYZ6c/luMU2adw8Tqt7OozIrgwBNmJO7nF4slo22RuhN3xVnL4mVxoQBGxqPm8QyTOI+wYsO/jyWCihVdkdiAEaIUH5tIJP5OjQhqNvJp3uaqaAC26A0ztIdz59Z6Tep9UHw5mwYNzeK7y9bchx+tLIDWuuOzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782058266; c=relaxed/simple;
	bh=ZX81v4qDc352DT8e8F8dcXtyQdkIkUGFkCqqSnmni6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A5z4jlNTmrYpwyskq1UiwQpVseyDqYVVGkr9WMyW8GrwxBhdF8iAyQ/0C4/izdJgBABzH5d6fbIgn85rRcE0K0fVJAucRUBPD6AVdfuaD+IFCXOPdNIDdS3kuLoSWACOLsy6RE2qBZ2FqrSY4FJ/forY+eAVDb6iGSo+rr7eGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlS1Y45H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlS1Y45H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5D61F000E9;
	Sun, 21 Jun 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782058265;
	bh=bT5AME4zTvOcLYIwBdjKLfTRWYRKvJNsnm54SLD3M0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XlS1Y45H6eXsZsHq2zLSqP4UNwzdrx0gdN36PlcmdMMOtEpsrlDNN7rX8dJrwpPcp
	 aAkUpX89UFUmtdBjOh3DCUWKyetSAph93KGzZ9MApM8vdtAN9zq85R/uDmrOJarQWV
	 5LmWquY4pTeInVtx0D/eTJ5uNhuDyt0ngYyc16U5O5HW2cTuOjt6P4I0c2r3nwZtpd
	 /4xuhW1qABEzO6P1wYxgZdV+JSS35VWgHveuce5bnttU6T5BFvGpRWkZGIadimeFDS
	 U4+UGqsaiwjbqZdgZRIwRvs15kHyXUObCKD7dZAuVKKtrL2z41iDbr/5+5aDFoWj/W
	 mdjRqM9Zhc80g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 03/17] mm/damon/core: always update
 ->last_nr_accesses for intervals change
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260621155715.87932-4-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
 <20260621155715.87932-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 16:11:04 +0000
Message-Id: <20260621161104.DB5D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Arithmetic overflow in DAMON access scaling functions when interva=
l ratio is large.
- [High] The patch attempts to fix a 'wrong value' returned by `damon_nr_ac=
cesses_mvsum()`, but misdiagnoses the root cause and leaves a major double-=
counting bug unresolved.
--

commit 6636564dd42488eb260d7102569887a00bdd3d71
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: always update ->last_nr_accesses for intervals change

This commit modifies damon_update_monitoring_result() to unconditionally
update last_nr_accesses when aggregation intervals change. It aims to
prevent incorrect calculations in damon_nr_accesses_mvsum() that could occur
if called with a stale last_nr_accesses value alongside a fresh aggregation
timestamp.

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
This is a pre-existing issue, but does this scaling trigger an arithmetic
overflow when the interval ratio is large?

When damon_nr_accesses_for_new_attrs() is called, it performs 32-bit
arithmetic in damon_nr_accesses_to_accesses_bp() and
damon_accesses_bp_to_nr_accesses().

Specifically:

mm/damon/core.c:damon_nr_accesses_to_accesses_bp() {
    ...
    return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
}

mm/damon/core.c:damon_accesses_bp_to_nr_accesses() {
    ...
    return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
}

If the ratio of aggr_interval to sample_interval exceeds 429,496 (for
example, a 1s aggregation and 1us sample), the intermediate multiplications
like r * 10000 inside mult_frac() are computed as 32-bit unsigned int,
which overflows the 32-bit maximum.

Can this silently corrupt the region access counts upon attribute updates,
leading to completely incorrect monitoring results?


[Severity: High]
This isn't a bug introduced by this patch, but does scaling
last_nr_accesses fully resolve the incorrect values returned by
damon_nr_accesses_mvsum(), or does it leave a double-counting flaw intact?

The commit message notes that damon_nr_accesses_mvsum() can return the
wrong value. However, the root cause appears to be a state desynchronization
rather than just a stale last_nr_accesses.

When damon_set_attrs() is called, it advances ctx->next_aggregation_sis
into the future:

mm/damon/core.c:damon_set_attrs() {
    ...
    ctx->next_aggregation_sis =3D ctx->passed_sample_intervals +
                                attrs->aggr_interval / sample_interval;
}

If a subsequent call to damon_nr_accesses_mvsum() evaluates this future
timestamp, it assumes it is at the start of a new interval, meaning
left_window_bp evaluates to 10000.

mm/damon/core.c:damon_nr_accesses_mvsum() {
    ...
    return damon_mvsum(r->nr_accesses, r->last_nr_accesses, left_window_bp);
}

Because kdamond_reset_aggregated() has not yet executed, r->nr_accesses
still holds the fully accumulated count of the just-completed interval.
This means damon_mvsum() adds two full intervals' worth of access counts
together, effectively calculating:
r->nr_accesses + (r->last_nr_accesses * 10000 / 10000).

Does unconditionally scaling last_nr_accesses merely adjust the second term
of this sum while preserving the underlying double-counting logic flaw?

>  	if (!aggregating) {
>  		r->nr_accesses =3D damon_nr_accesses_for_new_attrs(
>  				r->nr_accesses, old_attrs, new_attrs);
> @@ -884,8 +886,6 @@ static void damon_update_monitoring_result(struct dam=
on_region *r,
>  		 * interval.  In other words, make the status like
>  		 * kdamond_reset_aggregated() is called.
>  		 */
> -		r->last_nr_accesses =3D damon_nr_accesses_for_new_attrs(
> -				r->last_nr_accesses, old_attrs, new_attrs);
>  		r->nr_accesses_bp =3D r->last_nr_accesses * 10000;
>  		r->nr_accesses =3D 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621155715.8793=
2-1-sj@kernel.org?part=3D3
