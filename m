Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E42773F7
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062553; cv=none; b=uquQxjjXsllTT96dzqosM1/ZEq+u9/dXIJsHlNMcPk3UQPlvqcb2VzpV+ifu23tzNp1ioG1bwtfrdA6q57f35FD2frbPI0RzaY2SHi9wE6nc5AQOz8hzVZrwpEOEzbm4pK2ZPGB1LYVyrWtY83z63JhAqJQ6naoKwaFocuowCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062553; c=relaxed/simple;
	bh=aD6nhrseP3jOQdaJHfmb2AkleU8fnadDad06GNUDtcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ysjq2nlZMV4Gpx54SEKtg5qbfA9SV5tDpmXKQ+m6hqKWQmW5oO494sJkdD99AMec2Ivp7qrRY9Ecy/iqyXj2PLUpF9z51Rjv96TpcS5nT7Jo51q8pkWWigcBL+x2hzPCF9649xgEBeWk4GT+XJPdleYEXEYVvHQ4n5rN//zSSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTB1O0jf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTB1O0jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303EB1F0089C;
	Sat,  3 Oct 2026 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062552;
	bh=0sppXAwjuYhn6PyWkRaaRHNpGIaGw5b8MyOm5ZQW+rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTB1O0jfSnoF64o3RUV5E3gYt0ojrxME4rRlrkrPoo37PSxdlUESCkypNU9nvU9Sn
	 VrNHUuqwEdYTGbeISK4XqXYzFKS95pnzqYIFY4Sn96141CjHEPKYJtZzZ9/hzoVrvk
	 k1Ok4rZAjCYZS8nwOiB9E+PTEe2vanYGemS15KlB9bFsSZE0mlexUhp/rfAsqdYnZB
	 UhVyugSLQQp5yqC4OFqTsGG5Sp5VNgTfLiDE5T+C8Kx6qN37kDlGkTFabxToh9bTIk
	 ZpWfD8Ze8IHG3Kp3Z2dSKn2ZN7J2YdDzlU1qzGrNAa68iCP20cPJvk9Qs1jQLDMMat
	 vJ8cm0ClZBf7Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/9] mm/damon/core: replace the access report
 buffer with per-context rings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-2-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-2-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:22:31 +0000
Message-Id: <20261003212232.303EB1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm: Off-by-one error drops valid reports for the maximum probe ind=
ex
- [High] mm: Preempt-unsafe this_cpu_inc() usage in preemptible kthread con=
text
- [Low] mm: Spurious target-lookup allocation failure warning when targets =
are zero
--

commit 8fff2ca2d88fc496c6ec48a611f9bfdad8cf1ae4
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon/core: replace the access report buffer with per-context rings

This commit replaces the global access report buffer with per-context, per-=
CPU
SPSC rings for NMI-safe access reporting. It updates the kdamond drain logic
to process these rings using a binary search over a per-target region snaps=
hot.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 886e068e78447..4fd1db12bc49b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> +static void __kdamond_drain_ring(struct damon_ctx *ctx,
> +		struct damon_target_lookup *tbl,
> +		struct damon_report_ring __percpu *ring_pcpu,
> +		cpumask_t *pending)
> +{

[ ... ]

> +		while (tail !=3D head) {
> +			unsigned long stale_before;
> +			int pidx;
> +
> +			entry =3D &ring->entries[tail];
> +			/*
> +			 * Use sample_interval (not aggr_interval) as the
> +			 * staleness window: entries older than one sample
> +			 * interval are from a previous monitoring tick and
> +			 * should not inflate the current aggregation window.
> +			 */
> +			stale_before =3D jiffies -
> +				usecs_to_jiffies(ctx->attrs.sample_interval);
> +			if (time_before(entry->report_jiffies, stale_before)) {
> +				this_cpu_inc(damon_samples_stale_drained);

[Severity: High]
Does this code trigger a BUG: using this_cpu_inc() in preemptible context
warning? __kdamond_drain_ring() runs in the kdamond kernel thread, which is=
 a
fully preemptible context, but this_cpu_inc() is preempt-unsafe without
explicitly disabling preemption.

> +				goto next;
> +			}
> +			pidx =3D entry->probe_idx;
> +			/*
> +			 * Every entry in this ring is a perf-event report
> +			 * (probe_idx >=3D 1); damon_report_access() drops any
> +			 * DAMON_PROBE_IDX_NONE report before it reaches a ring.
> +			 * Reject only out-of-range indices (>=3D DAMON_MAX_PROBES)
> +			 * and, defensively, any non-positive value.
> +			 */
> +			if (pidx <=3D 0 || pidx >=3D DAMON_MAX_PROBES)

[Severity: High]
Does this bounds check inadvertently discard reports for the 4th configured
probe? The probe_idx is 1-based, meaning valid indices range from 1 to
DAMON_MAX_PROBES (4). However, checking pidx >=3D DAMON_MAX_PROBES drops the
report if pidx =3D=3D 4.

> +				goto next;
> +

[ ... ]

> +static void kdamond_check_reported_accesses(struct damon_ctx *ctx)
> +{
> +	struct damon_target_lookup *tbl;
> +	unsigned int nr_targets =3D 0;
> +
> +	/*
> +	 * Build the sorted region snapshot once for this drain.  If the alloc
> +	 * fails, skip the drain this tick rather than falling back to a linear
> +	 * scan (a missed tick self-heals; a linear scan does not).
> +	 */
> +	tbl =3D damon_build_target_lookup(ctx, &nr_targets);
> +	if (!tbl) {
> +		pr_warn_ratelimited(
> +			"damon: target-lookup alloc failed; ring drain skipped this tick\n");

[Severity: Low]
Can this spam the kernel log with spurious warnings when 0 targets are
configured?

If a DAMON context is started with 0 targets, damon_build_target_lookup() s=
ets
nr_targets to 0 and correctly returns NULL if the lookup buffer was never
previously allocated. This code misinterprets the NULL as an allocation fai=
lure.

> +		return;
> +	}
> +
> +	if (damon_drains_ring_perf(ctx))
> +		__kdamond_drain_ring(ctx, tbl, ctx->perf_rings,
> +				&ctx->perf_pending);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D2
