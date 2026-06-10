Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BC221277
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054990; cv=none; b=etS1wOhikm+TgIaZYw+kOSH3muD83p3/49FL91iPb8dx+z01yZ1orwnTV25Q4IUeNPZsBh3vpxgNJYS55SN3oHMnlfbrcfUEkaCUsSJNIFEhznIjam9sTjMxXC4V2h1D6hV2OKmP8UNkezNxWnFWOCVsLwXTViTZIfVsBPIpa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054990; c=relaxed/simple;
	bh=RofuGc1zYnqPEhgK1v1AQHZkKZNNZgoN9SKEDjY18Q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XINJJfDhh9dG628X/DHpbT+gmdZETsRDHfe57DwL94rU0sYZYWVhlpAXwka/XqAa7elyCw0Bd3vqN3UB27gjqNZaTIplrIZPFTAi92BnGixM10ap1yNsqD/xrQTPpAEwZLEAHZbSI9q8r+18YB7c/0pLPVFS9ePwpNgVc8LRobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAX+PSpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAX+PSpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724B21F00893;
	Wed, 10 Jun 2026 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054988;
	bh=c8LX+cLRtFURkRk0VZ9+sCw88K3tGVXYssRUDUw81a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aAX+PSpcihqNPe5slxaAIRdkiCeWI/oOw4/EloM1Tgk+oqcujpom5/ULEE5XgtTYi
	 T1KJoJuyrT/4dS5F8kR5j1jO2CnLiOAohWbqPS0aQ03ETgq35ctylGckBb1vNKWpVE
	 TR5POB/WyAweAa6YInbsv2ptt+Y3Q6AGaAIpmR9VDlpkb/j3mVJ30R1odQg/eg2Jda
	 xd8JzUxCPHzIrqSRnO+nR1vqySO/as1zFp96uGmIz6EslkqG82VutAUjqF+Uo5jZCB
	 WX8pbnPgGb/G9fc/Rg2Vh8ej2kOInc3BgkXWf1jJsk4IG3cYeDxgpRi4l7utSr4Lr2
	 zWtkuHcamIE9A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/4] samples/damon/prcl: handle damon_start()
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260610011420.3018-3-sj@kernel.org>
References: <20260610011420.3018-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:29:48 +0000
Message-Id: <20260610012948.724B21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Loading the module dynamically with the `enabled=3DY` parameter ca=
uses a permanent DAMON thread and context leak.
- [Medium] The DAMON context, targets, and schemes are leaked if `damon_cal=
l()` fails in `damon_sample_prcl_start()`.
--

commit 66049e90074b43852fd5c6e982d320d3e8718fb4
Author: SeongJae Park <sj@kernel.org>

samples/damon/prcl: handle damon_start() failure

This commit fixes a memory leak in damon_sample_prcl_start() by destroying
the Damon context if damon_start() fails. This addresses an issue where
the context is leaked when the module fails to start in exclusive mode.

Link: https://lore.kernel.org/20260609145814.70163-1-sj@kernel.org

> diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
> index b7c50f2656ce7..0db2598946911 100644
> --- a/samples/damon/prcl.c
> +++ b/samples/damon/prcl.c
> @@ -106,8 +106,10 @@ static int damon_sample_prcl_start(void)
>  	damon_set_schemes(ctx, &scheme, 1);
> =20
>  	err =3D damon_start(&ctx, 1, true);
> -	if (err)
> +	if (err) {
> +		damon_destroy_ctx(ctx);
>  		return err;
> +	}
> =20
>  	repeat_call_control.data =3D ctx;
>  	return damon_call(ctx, &repeat_call_control);

[Severity: Medium]
This is a pre-existing issue, but does this function also leak the Damon
context, targets, and schemes if damon_call() fails?

If damon_start() succeeds, it spawns the kdamond thread. If the newly spawn=
ed
thread terminates early, for example due to a memory allocation failure for
regions_score_histogram in kdamond_fn(), it sets call_controls_obsolete.

If this happens before damon_call() acquires the call_controls_lock:

mm/damon/core.c:damon_call() {
    ...
	mutex_lock(&ctx->call_controls_lock);
	if (ctx->call_controls_obsolete) {
		mutex_unlock(&ctx->call_controls_lock);
		return -ECANCELED;
	}
    ...
}

Because damon_sample_prcl_start() returns this error directly to the caller
without cleanup, the caller receives the error and disables the module. This
permanently bypasses damon_sample_prcl_stop(), meaning damon_destroy_ctx()
is never executed.

[Severity: High]
This is also a pre-existing issue, but does loading the module dynamically
with the enabled=3DY parameter cause a permanent Damon thread and context l=
eak?

During module load, the kernel parses parameters and invokes the module's
parameter callback before executing the init function. If enabled=3DY is
passed, the callback successfully calls damon_sample_prcl_start(), which
allocates the context and starts the kdamond thread in exclusive mode.

Then, do_init_module() executes damon_sample_prcl_init():

samples/damon/prcl.c:damon_sample_prcl_init() {
    ...
	if (enabled) {
		err =3D damon_sample_prcl_start();
		if (err)
			return err;
	}
    ...
}

Because the enabled flag is still true, damon_sample_prcl_init() erroneously
calls damon_sample_prcl_start() a second time. This unconditionally allocat=
es
a new ctx, overwriting the global ctx pointer and losing the reference to t=
he
original context.

The second damon_start() call fails with -EBUSY because the first thread is
already running in exclusive mode. The original kdamond thread is left
running forever and its context pointer is permanently lost, locking out any
other Damon instances on the system until reboot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610011420.3018=
-1-sj@kernel.org?part=3D2
