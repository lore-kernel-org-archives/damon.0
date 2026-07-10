Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D232AD3F
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644412; cv=none; b=HBCuNHB66CJDQRE068UlCN4WCwOw/FQ6JjmYs4ofO/7Ss34NDC4aAiA/UokMdXLQK+JTYtALvIi1G6X3sbp5ZWXbxYWCJFp52BWf2qWdf6l6QjuoYJKAEBt0RAPcbAp8HOARImF5coKDenRixfwq19ax2VPjL5NaeIELMEK0unU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644412; c=relaxed/simple;
	bh=lQdbcHGB8GfPBhHbWhvdvBaRt5f1BDZ41kMtztMCtdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Krqu9mBr/5hpW30eoXEABsDq1DP+nDH+5JzQIdP2WUdb9Ogvq6B5WGx7E4M+taCbf4R1oa55XR3sr6HjRtZ22G/0HBH9HEzSTMM3AccthCP6VliQ1PYEPO/q/m0GO3eBHbuT3BAx62o5tcLozKwHe5YGKaNczhyeBhK+toh3Zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJDO10N7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJDO10N7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09281F000E9;
	Fri, 10 Jul 2026 00:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644410;
	bh=FzCCDSrgX6Rf4tCtStAz+YSmGisjVHdj44jSpxHou+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJDO10N7ach0LHnu07BPg2yDxaYKoJEhIBCcvdTOeYpcTssIpAcxWnfuGMY4OsG5g
	 Mnyej63QKqeNdOnRCOkMDwKvaiaw6yu9CHV8VY/FvFwOkXe80N5GQvlyrsaKb+k+/c
	 bfZJZAgB7nn92xXKI9Cb6TuQ5zoQaQTGlc7rRnt1XnQdOTpOqNUZXa9QDaxvR2BlOf
	 VrvVCs6Gis3Ftd0GxqABcao+IZvVd1j/WacUuEbGkUT5LjfyEbKqtoyuOpqLyvR9L0
	 8+sroaRVoHHwnHG+9uycPRzYg3WZI5Y4e/53I9YKvqPL6lYAhwXR1AnHo4cL0POKjO
	 CLvrs2mAaKkIA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 15/19] mm/damon/core: implement
 damon_has_probe_weight()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710002349.111414-16-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
 <20260710002349.111414-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 00:46:50 +0000
Message-Id: <20260710004650.B09281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] When probe weights are enabled, `damos_apply_target()` aggressivel=
y merges adjacent regions regardless of their `probe_hits`, permanently los=
ing monitoring data.
- [High] Setting probe weights on unsupported operations backends (like DAM=
ON_OPS_VADDR) silently disables all memory monitoring, breaking the DAMON c=
ore logic.

Pre-existing issues:
- [High] Calling `damon_call()` on an inactive DAMON context leads to an in=
definite hang in `wait_for_completion()`, allowing a local DoS via sysfs.
--

--- Patch [15]: [RFC PATCH v1.3 15/19] mm/damon/core: implement damon_has_p=
robe_weight() ---
commit 55c8b58c370f614fee60cf04b8ed7e90eb167302
Author: SJ Park <sj@kernel.org>

mm/damon/core: implement damon_has_probe_weight()

damon monitors only data attributes when probe weights are set.
However, the function for detecting it is intentionally returning false
always. Complete the mode detection function so that the mode can really
start working.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 91964336ce31e..806a67d02a6e9 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, st=
ruct damon_ctx *ctx)
> =20
>  static bool damon_has_probe_weights(struct damon_ctx *c)
>  {
> +	struct damon_probe *p;
> +
> +	damon_for_each_probe(p, c) {
> +		if (p->weight)
> +			return true;

[Severity: High]
Does returning true here cause adjacent regions to be aggressively merged in
damos_apply_target(), resulting in the loss of monitoring data?

When access_check_disabled becomes true, nr_accesses remains 0. In
damos_apply_target(), regions with identical nr_accesses and age are merged
to repair quota-induced splits:

mm/damon/core.c:damos_apply_target() {
    ...
    prev_r->ar.end =3D r->ar.end;
    damon_destroy_region(r, t);
    ...
}

Since damos_apply_target() unconditionally merges these regions without
combining the probe_hits arrays, does this permanently destroy the
fine-grained probe_hits data?

[Severity: High]
Can returning true here also silently disable memory monitoring if the
operations backend does not support probes?

If a backend like vaddr or fvaddr is used, damon_valid_probe_params() does
not verify if ctx->ops.apply_probes is implemented before allowing probe
weights.

When this function returns true, standard access checks are bypassed:

mm/damon/core.c:kdamond_fn() {
    bool access_check_disabled =3D damon_has_probe_weights(ctx);
    ...
    if (!access_check_disabled && ctx->ops.prepare_access_checks)
        ctx->ops.prepare_access_checks(ctx);
}

Because ctx->ops.apply_probes is null, neither standard accesses nor probe
accesses are evaluated. Will the kdamond worker thread spin without
recording any memory activity?

> +	}
>  	return false;
>  }

[Severity: High]
This is a pre-existing issue, but is there a risk of an indefinite hang when
calling damon_call() from sysfs?

Looking at the sysfs store functions for reclaim and lru_sort, they invoke
damon_call() without verifying if the kdamond thread is actively running:

mm/damon/reclaim.c:damon_reclaim_commit_inputs_store() {
    ...
    if (!ctx)
        return -EINVAL;

    err =3D damon_call(ctx, &control);
    ...
}

If commit_inputs is written to while the module is disabled, damon_call()
will enqueue the request and block indefinitely on wait_for_completion()
because there is no kdamond thread to process the queue. Could we check
damon_is_running() before calling damon_call()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710002349.1114=
14-1-sj@kernel.org?part=3D15
