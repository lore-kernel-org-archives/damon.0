Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650D2D97BB
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782668434; cv=none; b=Q0b9f2po8bL6LfJL0Lbl/nYJefc7o9pr7IvldQ+MbGhkp5rlLKiqWi1VRCTbt0+2oJ4RMGQ/yIbyOIzsuTNM6ZbKHDp3m1jETbM/qAvcV2XLpC1fPatMBqCS4r3p0AZrLGzBRUjC2loGNfkuzuYBRHcLsJjYKMi4e3oQHqL48ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782668434; c=relaxed/simple;
	bh=/+J17ClIbeluBW6MK/Kb1Z2lOuO/a0Q4pLlVQdXBPRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qviyTDavD3vFWtid22Cxw8Bv0anyYFX9oVge1955O3wJ1YcLTAHF4AumYkK1OKeCgwXR/LVtfcmhSyc9ZUXYEqklXAFD8zKjLIOzADT6K2+U5jsl7RC8aTgAXeUh+kACh1sjqyvHxjLHxmoaa9UJdna8i/B7h8chDDBNFOP8m5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8BOQTjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8BOQTjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296A31F000E9;
	Sun, 28 Jun 2026 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782668432;
	bh=X492CazohEDIrysYPyjWNujCAUVKtzPN+lVmXPUFWeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H8BOQTjpl4vQJat1op/HyAD0tDxQFxNnhyDukq4i52MycYYWi00gVk93hu/vGcHz7
	 L9vAbzo4jKcW/damYxUPd3UHcn8/aTzAWVSQ2rfBibjtVXeXVD6elEh7FkXgnTf4NH
	 1xJQDncaUqJg84Ubnrnoaii1VIA4yIoshyE3HPjhiEM+qtxi/qQBzD8syiYQFVBCI7
	 ag88Xw7absnzr8DnAMeBYjuS9eYAP6dJ1M3H01ws1CRkkPVBsmvsvo9ldtHRY/b6fR
	 IGQtl8XwXHil+80qasLFwa+gOie9O/HHSz2yG4qu8xC/I/Ly6iVyz42G66yTWm2lyz
	 SP8SPO3lXJg7A==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] dama: userspace DAMON_RECLAIM min_age autotuner
Date: Sun, 28 Jun 2026 10:40:28 -0700
Message-ID: <20260628174029.88333-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628085155.20828-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 16:51:55 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi DAMON Community,
> 
> I've been working on a userspace program that autotunes the 'min_age'
> parameter of DAMON_RECLAIM, aiming to reduce unnecessary proactive
> reclaim. I call it DAMA [1] (DAMOS Autotuner/Assistant).

Interesting idea!  DAMON is designed to be friendly to both user space control
like this, and kernel that just works on its own.  Happy to see another user
space control approach.  To my understanding, Micron is also doing [1] this
kind of user space control for their memory bandwidth solution.

I'm curious why you use DAMON_RECLAIM instead of DAMON_SYSFS, though.
DAMON_SYSFS provides full DAMON features, so you could do same thing with it.
I just found I wrote a blog post [2] for describing how you can do DAMOS
auto-tuning.

Also, DAMON_RECLAIM is more focused on helping people who prefer the kernel to
just work without user-space controls.  It also provides a PSI-based
self-tuning [3] feature.  I believe user-space controls could be more optimized
for given workloads, and therefore I don't discourage developing user space
controls, though.

> 
> Test Setup
> ==========
> 
> I wrote a synthetic test using Masim. The workload runs for 30 minutes
> with two repeating scenarios:
> 
> Scenario 1
> ----------
> 
> - Full access (100% of region A) for 30s, then only 10% for 30s,
>   repeating.
> - Theoretical optimal min_age: > 30s.
> 
> Scenario 2
> ----------
> 
> - Cycle through four regions {A, B, C, D}, accessing 95% of each for 30s
>   before moving to the next. A region is revisited every 90s.
> - Theoretical optimal min_age: < 90s.
> 
> (Note: because DAMON default configuration does not partition regions
> with high precision, the theoretical bounds are not strict in practice.)
> 
> Results
> -------
> 
> I compared DAMA (starting min_age = 10s) against three configurations:
> 
>   - Default : DAMON_RECLAIM with 120s fixed min_age
>   - Custom  : 60s fixed min_age
>   - System  : no DAMON (kswapd + direct reclaim only)
> 
> All reclaim/refault counts are in pages. PSI values are averages. Fault
> numbers are per-second rates.
> 
>     |-------------------------------------------------------------|
>     |           | DEFAULT   | CUSTOM      | DAMA      | SYSTEM    |
>     |-------------------------------------------------------------|
>     | RECLAIMED | --------- | ----------- | --------- | --------- |
>     | DAMON     | 0         | 27 648      | 669 274   | 0         |
>     | KSWAPD    | 4 876 306 | 5 259 842   | 1 817 669 | 5 341 815 |
>     | DIRECT    | 12 670    | 19 697      | 1 479     | 20 114    |
>     | PSI       | --------- | ----------- | --------- | --------- |
>     | CPU       | 0.06      | 0.06        | 0.06      | 0.06      |
>     | I/O       | 0.00      | 0.00        | 0.00      | 0.00      |
>     | MEM       | 0.22      | 0.23        | 0.08      | 0.23      |
>     | REFAULT   | --------- | ----------- | --------- | --------- |
>     | ANON      | 4 462 273 | 4 858 679   | 2 015 817 | 4 915 695 |
>     | FAULT     | --------- | ----------- | --------- | --------- |
>     | PGFAULT   | 1 317.48  | 1 428.33    | 575.10    | 1 443.96  |
>     | MAJFAULT  | 1 239.70  | 1 349.85    | 560.25    | 1 365.70  |
>     |-------------------------------------------------------------|
> 
> DAMA significantly reduces system reclaim, refaults and major faults
> while keeping memory pressure low.

Cool!  The test scenario looks quite artificial, though.

> 
> Masim Script
> ------------
> 
> In short, four regions share 8 GiB:
> user_A_sysadmin (40%), user_B_student (20%), user_C_drive (20%),
> user_D_bad (20%). The two access patterns above are looped to fill 30
> minutes.
> 
> Here's the full Python script to generate Masim script:
> 
>     from masim_config import Region, AccessPattern, Phase, pr_config
> 
>     KiB = 1 * 1024
>     MiB = 1024 * KiB
>     GiB = 1024 * MiB
> 
>     SEC_MS = 1000
>     MIN_MS = 60 * SEC_MS
> 
>     total_mem = 8 * GiB
> 
>     regions = [
>         Region('user_A_sysadmin', int(total_mem * 0.4), 'none'),
>         Region('user_B_student', int(total_mem * 0.2), 'none'),
>         Region('user_C_drive', int(total_mem * 0.2), 'none'),
>         Region('user_D_bad', int(total_mem * 0.2), 'none'),
>     ]
> 
>     phases = []
>     
>     # Scenario 1
>     # ==========
>     #
>     # Loop 30s full access + 30s partial access.
>     #
>     # Total time: 30mins ((30s + 30s) * 30 loops)
>     #
>     # The 'min_age' should not be too small, otherwise it will cause many
>     # unnecessary proactive reclaim.
>     #
>     # Ideal 'min_age': > 30s
> 
>     for i in range(30):
>         phases.append(Phase(f'scene1_high_{i}', 30 * SEC_MS, [
>             AccessPattern('user_A_sysadmin', False, 1024, 100, 'rw'),
>         ]))
>         phases.append(Phase(f'scene1_low_{i}', 30 * SEC_MS, [
>             AccessPattern('user_A_sysadmin', False, 1024, 10, 'rw'),
>         ]))
>     
>     # Scenario 2
>     # ==========
>     #
>     # Looping {A, B, C, D} with alternating 95% access.
>     # Each region is re-access every 90s.
>     #
>     # Total time: 30mins ((30s * 4 times) *  15 loops)
>     #
>     # The 'min_age' should not be too large, otherwise it will cause many
>     # system memory reclaim (kswapd/direct).
>     #
>     # Ideal 'min_age': < 90s
> 
>     region_names = ['user_A_sysadmin', 'user_B_student', 'user_C_drive', 'user_D_bad']
>     for i in range(15):
>         for r_name in region_names:
>             phases.append(Phase(f'scene2_{r_name}_{i}', 30 * SEC_MS, [
>                 AccessPattern(r_name, True, 0, 95, 'rw'),
>             ]))
> 
>     pr_config(regions, phases)

Thank you for sharing this detail!

> 
> Algorithm
> =========
> 
> DAMA's "DAMON_RECLAIM's min_age" algorithm is a periodic feedback
> controller (core.c:reclaim_min_age_calc()) that balances DAMON_RECLAIM
> and system reclaim to keep refaults low.
> 
> 1. Accumulation & Decay
>    Each cycle, DAMA reads the delta of DAMON-reclaimed pages, system
>    reclaim (kswapd + direct), and refaults (anon + file). These deltas
>    are added to two independent "remaining" counters:
>    - damon_remaining  (for DAMON reclaim)
>    - pgsteal_remaining (for kswapd + direct reclaim)
> 
>    Simultaneously, the same deltas are accumulated into long-lived
>    metrics and continuously decayed by a fixed factor to smooth out
>    short-term spikes.
> 
> 2. Threshold Gating & Hysteresis
>    An adjustment is only allowed when one of the remaining counters has
>    built up enough "credit":
>    - If damon_remaining >= DAMON_THRESHOLD and DAMON reclaimed pages in
>      the current cycle, the controller considers _increasing_ min_age.
>    - If pgsteal_remaining >= PGSTEAL_THRESHOLD and system reclaim is
>      non-zero, it considers _decreasing_ min_age.
> 
>    Once a threshold is met, the _opposite_ remaining counter is rapidly
>    decayed (multiplied by NOT_WORKING_FACTOR) to prevent the controller
>    from oscillating between the two directions.
> 
> 3. Decision
>    - Increase min_age: compute (weighted_refault * 100) /
>      damon_reclaimed. If this percentage exceeds INCREASE_THRESHOLD,
>      DAMA assumes DAMON is evicting active pages and raises min_age
>      proportionally.
>    - Decrease min_age: compute (weighted_refault * 100) / (kswapd +
>      direct reclaimed). If the percentage is below DECREASE_THRESHOLD,
>      DAMA assumes system reclaim is missing cold pages and lowers
>      min_age proportionally.
> 
>    After every adjustment, the refault counters are zeroed and the
>    metrics continue to age, so the next decision is based on fresh,
>    representative data.

I'm not very expert to feedback loop, but sounds good and reasonable at a
glance.

>    
> Question
> ========
> 
> Synthetic tests have clear boundaries, so I'd appreciate your thoughts
> on how to make the benchmark more representative of real production
> workloads. What memory access patterns or workloads do you usually
> consider when evaluating DAMOS self-adaptive capabilities?

Good question.  The real production workloads are the best.  I know not
everyone has the privilege to test their kernel against the real production
workloads, though.  In the case, using some public benchmarks that are known to
represent realistic workloads could be a way.  I used to use PARSEC 3.0 quite a
lot, for the early days of DAMON.  The performance tests in DAMON tests suite
[4] is using it.  The performance tests are nearly broken now, though, since
PARSEC 3.0 website has gone, and I don't run the tests nowadays.  I also used
Meta's Taobench [5] for DAMON-based memory tiering [6] evaluation.

In the era of AI, using some AI workload benchmarks would also be interesting,
in my opinion.

> 
> I'd also love any feedback on this userspace autotuning approach or
> suggestions for real-world testing.

I hope my above comments give you some feedback.

> 
> [1] https://github.com/aethernet65535/dama

Thank you for sharing the code!

[1] https://dl.acm.org/doi/10.1145/3814942.3816137
[2] https://damonitor.github.io/posts/damo_autotune_example/
[3] https://origin.kernel.org/doc/html/latest/admin-guide/mm/damon/reclaim.html#quota-mem-pressure-us
[4] https://github.com/damonitor/damon-tests/tree/master/perf
[5] https://github.com/facebookresearch/DCPerf/blob/main/packages/tao_bench/README.md
[6] https://www.phoronix.com/news/DAMON-Self-Tuned-Memory-Tiering


Thanks,
SJ
