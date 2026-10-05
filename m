Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120E42641B
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190945; cv=none; b=TFGf87xjkwsmncCNnAR1n/QllF8pxX2wZExALfFlt7nqx31iZV+a8f0BQEETVCKD9yibETlU5+4Ia1m/vwJ60fvwSkzQDLi4rMxzXumtaxsAJpeJZNvzcZXmvK33hayUruprsOoiSUMEvfu5v3yyTJbrbat74ndbDInVua+RAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190945; c=relaxed/simple;
	bh=poGqL6oX14wXIDqxTdJT8lyycuhVVmxpnpiHC8zLo+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bxAxWhtXF5IG3GrJzwjbAdMT+karTPHFcyx+SFvOUpcYc40HcOS5Lu4bZRnZ7BOe8BNjQw2k/1tjqvHxak2XmjQucdei12k+32wcRq9/6oH+we6mF6PwWptu/2k9vK/+7cuGrORjtOYjNirseRDe9adJPvhKhXC6r309qv87EAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPels97B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPels97B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BE81F000FF;
	Mon,  5 Oct 2026 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190944;
	bh=2ftdYX3xC1Eax7LOZIGUF0AqNX6lMCD3hc6UT9w2Xv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hPels97Bzkc507Fm+7vUsmg+32EhZmyJEczbgHeBmIZnOMgVya/za4zCNiZoQYGB5
	 JG7FpVt5k9FEtPLwmaVBphCELyJMtqmBWnO4WUl5e53vmDgFifxKWKnyfu2J+TioQK
	 ysyPok/T63MWicXToyCjocwX3cvGISlxr7Bh7xyUgbNFhzTdp8Y2NHeEWs7zkhj8g6
	 0DB4RCHvv4TRcrxd3sNYJU13VISUkmavL22Z3rAQr8WVkVtHnlpln6JvhzpvQ8x7/b
	 UPLcMxxpBP3cMOT/EgWtbwnunrsPJiYeEqVmglX411INIQnjCVnD54Uv/zJXDS81z5
	 132ogREwjbW8Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 5/9] mm/damon: add perf_event prep type, core
 lifecycle, and PMU arm/disarm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-5-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-5-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 09:02:23 +0000
Message-Id: <20261005090224.66BE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm/damon: PMU configuration bypasses perf_event_open security chec=
ks
- [Medium] mm/damon: perf_priv is permanently lost on kdamond stop
- [Low] mm/damon: uninitialized heap garbage in newly added damon_prep obje=
cts
--

commit bb2fe5a24d18d1ea5740c8beef1d58359ce0c535
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: mm/damon: add perf_event prep type, core lifecycle, and PMU arm/di=
sarm

This patch adds a new DAMON_PREP_PERF_EVENT preparation action to allow DAM=
ON
probes to be event-driven via a hardware PMU. It updates the core lifecycle
to manage PMU arming/disarming and handles both per-CPU and single-instance
models.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9fc536238c2f0..c2acae6e19ec5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2016,6 +2040,7 @@ static int damon_commit_targets(
>  static void damon_commit_prep(struct damon_prep *dst, struct damon_prep =
*src)
>  {
>  	dst->action =3D src->action;
> +	dst->perf =3D src->perf;
>  }

[Severity: Low]
Does this commit path properly initialize new damon_prep objects?

While the above handles updating existing prep objects, damon_commit_preps()
adds newly allocated prep objects for any new entries:

	new_prep =3D damon_new_prep(src_prep->action);
	if (!new_prep)
		return -ENOMEM;
	damon_add_prep(dst, new_prep);

Since damon_new_prep() uses kmalloc_obj() without zero-initialization, the
newly allocated object will contain uninitialized heap garbage in its perf
struct because the src_prep->perf values are never copied into new_prep.

[ ... ]

> @@ -4913,6 +5032,23 @@ static int kdamond_fn(void *data)
>  done:
>  	damon_destroy_targets(ctx);
> =20
> +#ifdef CONFIG_DAMON_PERF_SOURCE
> +	/*
> +	 * Release perf-event probes here so a stopped kdamond leaves no event
> +	 * firing overflows into its report ring, and holds no PMU ownership.
> +	 */
> +	{
> +		struct damon_probe *p, *next_p;
> +
> +		damon_for_each_probe_safe(p, next_p, ctx) {
> +			if (p->perf_priv) {
> +				damon_perf_probe_teardown(ctx, p->perf_priv);
> +				p->perf_priv =3D NULL;

[Severity: Medium]
Can a stopped DAMON context ever be safely restarted?

When kdamond stops, this teardown path permanently nulls out p->perf_priv.
If a core API user subsequently restarts the context via damon_start(), the
context is left without its PMU configuration and will silently fail to
monitor any events.

While sysfs users aren't affected because they rebuild the context entirely
on restart, this breaks the core API's ability to reuse stopped contexts.

[ ... ]

> diff --git a/mm/damon/perf_source.c b/mm/damon/perf_source.c
> index 65bbfe850e708..4baa8aebcfa82 100644
> --- a/mm/damon/perf_source.c
> +++ b/mm/damon/perf_source.c
> @@ -285,12 +269,51 @@ int damon_perf_probe_setup(struct damon_ctx *ctx,
>  	perf =3D kzalloc_obj(*perf, GFP_KERNEL);
>  	if (!perf)
>  		goto release_owner;
> +	event->priv =3D perf;
> +
> +	/*
> +	 * A system-wide PMU is a single hardware unit rather than a per-CPU
> +	 * counter, so it needs exactly one counter: the cpuhp fan-out below
> +	 * would run one redundant sampler per CPU against the one device and
> +	 * corrupt its shared state.  Pin that counter to a fixed online CPU
> +	 * and bypass cpuhp.
> +	 *
> +	 * A kernel counter with no task must name a CPU.  If that CPU goes
> +	 * offline the counter stops and is not migrated.
> +	 */
> +	if (event->attr.single_instance) {
> +		struct perf_event_attr attr;
> +		int cpu =3D cpumask_first(cpu_online_mask);
> +
> +		damon_perf_event_init_attr(event, &attr);
> +		/*
> +		 * Pass @event as the overflow context, as the per-CPU path
> +		 * (damon_perf_cpu_online()) does: damon_perf_overflow() reads
> +		 * event->ctx via smp_load_acquire() for the teardown barrier.
> +		 */
> +		perf->single_event =3D perf_event_create_kernel_counter(&attr,
> +				cpu, NULL, damon_perf_overflow, event);

[Severity: High]
Does this allow userspace to bypass perf_event security policies?

The attributes copied in damon_perf_event_init_attr() (such as type, config,
and exclude_kernel) originate directly from user sysfs inputs.

By passing these raw user-supplied attributes directly into
perf_event_create_kernel_counter(), standard perf security checks like
perf_event_paranoid and LSM hooks are bypassed.

This could allow a user with sysfs write access to configure arbitrary PMU
counters and monitor kernel memory accesses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D5
