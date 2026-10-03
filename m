Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C22882AB
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062451; cv=none; b=GeK3Y8Qhn82yQXa0Bv2la/4LwvKuWcSGU5qVo8vr4DGABvaCdQve1Neh6TTjvTxrDdkJnJW8FFt/9VBmrtegx7iZrz3HcW2QuvnvOw4AvzQ9+RXmTjWuxR19R9OIuErZKp16UKcgGh1th+p6u4u/JrmGoxBVRkCDD10AsLXm6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062451; c=relaxed/simple;
	bh=abvqCZV3yHvgwOam8EycI+cyK/AaVJT//me9vdsbtZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sgzbv5BxV0LLUUXHQpGGVg8t5PFrYfOkA6o+JB7CWCWiSwya1TN5yEeyCHdCVJnIeTFR4sIDukJHHjcq49oCtroMlZQJY66U39BPVZxHNMJlRLYrXuwQPTxqmOqKS6fHiUycBR9WkereGfoC/qGrvgOfL2IQyg871jYHPEqLVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX+QBkOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX+QBkOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C61F0089B;
	Sat,  3 Oct 2026 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062450;
	bh=HBTpMySOjbdGxEjEg/B1vA7UfmiDQVKVML17NSEriwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IX+QBkOwVCnMtTEnkpXM1B3qNZqdfDIbqThv04oxswRmxwkFL7GQlgCq6W7Og752k
	 zICInzs7g32bxnvMczA+36ns+lbi3xWhh9dM5tZA2LUXQs3N56jbo6/pBwhkSirzvf
	 9ebvENyaliTc8zjJVMvSe8IYOZrPiJCWXLI/k/ezyK3hQw/A8U9crC8YSymz8ZRM+T
	 TU9M7lJbcFEoaYkjs7vw3FQrwYm3xzEBmsc4IYCDuNcgk+fdV3D5ZsUsmw+ZMWZB8k
	 EmHt4aDhpTe51q7vCwMj5OJdFKBtK/KjhQjwix5iZ1P3fisynRVdn/bt1chDjqKTxj
	 SKWPCWQUsCCVw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 9/9] mm/damon/core: allow both primitives
 disabled when a perf probe is present
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-9-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-9-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:20:49 +0000
Message-Id: <20261003212050.213C61F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: destructive silent clearing of PTE accessed bits
- [High] mm: uninitialized sampling_addr read leads to out-of-bounds PFN lo=
okup
--

commit 73703d94b2ed32c7f44c1db6e359a4902509dc91
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/core: allow both primitives disabled when a perf probe is present

The sample control validation requires exactly one software access check
primitive, page_table or page_fault, to be enabled.  A context carrying a
perf-event probe needs neither: the probe drives the access signal
through its report ring and the drain, so region access rates and ages
update with both primitives off.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c2c74d0daf957..04a1cccbc2f5d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2390,6 +2387,14 @@ static int __damon_commit_ctx(struct damon_ctx *ds=
t, struct damon_ctx *src,
> =20
>  	if (!damon_valid_probe_params(src))
>  		return -EINVAL;
> +	/*
> +	 * A probe-driven context needs no software primitive.  Validate this
> +	 * before anything is committed to @dst, so a rejected configuration
> +	 * cannot leave a live commit with its PMU events already armed.
> +	 */
> +	if (!damon_has_event_driven_probes(src) &&
> +	    damon_primitives_enabled_invalid(&src->sample_control.primitives_en=
abled))
> +		return -EINVAL;

[Severity: High]
Does this short-circuiting unintentionally allow both primitives to be enab=
led
concurrently when a probe is present?

Because damon_primitives_enabled_invalid() checks if both are enabled or
both are disabled, bypassing it allows both configurations.

If both page_table and page_fault are enabled, does this permanently destroy
system-wide page access history and break LRU memory reclaim algorithms?

In kdamond_fn(), the page_fault primitive takes precedence during the check
phase:

mm/damon/core.c:kdamond_fn() {
    ...
		if (ctx->sample_control.primitives_enabled.page_fault)
			max_merge_score =3D kdamond_apply_zero_access_report(ctx);
		else if (!access_check_disabled && ctx->ops.check_accesses)
			max_merge_score =3D ctx->ops.check_accesses(ctx);
    ...
}

Because the 'else if' is skipped, the hardware PTE accessed bits cleared
earlier by ctx->ops.prepare_access_checks() are never read back.

[Severity: High]
Does this relaxation also introduce an uninitialized read that leads to an
out-of-bounds PFN lookup?

If a context is configured with both primitives disabled and an event-driven
probe with a weight of 0, damon_has_probe_weights(ctx) returns false, which
causes access_check_disabled to evaluate to false.

Because page_table is false, ctx->ops.prepare_access_checks() skips
initialization, leaving r->sampling_addr completely uninitialized.

Since both are disabled, kdamond_fn() forces the execution of the access ch=
eck
primitive:

mm/damon/core.c:kdamond_fn() {
    ...
		else if (!access_check_disabled && ctx->ops.check_accesses)
			max_merge_score =3D ctx->ops.check_accesses(ctx);
    ...
}

This calculates a physical address from this garbage memory in
__damon_pa_check_access():

mm/damon/paddr.c:__damon_pa_check_access() {
    ...
	phys_addr_t sampling_addr =3D damon_pa_phys_addr(
			r->sampling_addr, addr_unit);
    ...
}

Can this lead to out-of-bounds PFN lookups, unpredictable behavior, and
potential kernel crashes or information leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D9
