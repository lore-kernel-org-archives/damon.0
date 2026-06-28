Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458E231827
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782636709; cv=none; b=InNon1XOyR3k5rbDAA1JGNKmB97sfMECE+M2pqnWVJ9TOGSKf8QOXy7QRrZVW9iEZ99xDNZCfODTCfV1Uv02G17bR0qn5d2le1kixSbkgRX0raKHb8Ghl4NKxYWSZTFChg+YC/cyG2ekJvhNUoOcnld6UcL3EAlItrWsZ82YyQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782636709; c=relaxed/simple;
	bh=3I03iszsElSbVq8HV/vYQajP30IhSZkhlvPmdTaaAGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkqc+2eqOExf/6oUZLRq6Iid9vkMNrQP26CPedXKMWqm4D1KVqDZExqaw0GtEUgI2Ii/0vzXSL2NxIftOymw/T/YxIuzUW9q1pngTgZL1VJGejDID8fceuKIo12Zkbr1Pog6hdnnKq83wAkEI/fN1qpo7U12Bs9ZcFbooDCCzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFNYE69R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFNYE69R"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c81d799ef2so9868345ad.3
        for <damon@lists.linux.dev>; Sun, 28 Jun 2026 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782636708; x=1783241508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohO+OwbdAfufkBqI6zk4RS/rHxcAGR+JiWSi+OVMae4=;
        b=JFNYE69ROunwzCtfNUFFnS4JQr8peQcIoruaNI/rzCa+EMLmyenhDKmExJfPSVO415
         7jizfI19V0U3qMPniOkvtzbqheMR/x7I95OZl158VBR1+q83TyQwyO5UUfDsZAC8xCgB
         TbJglL80shuBSQzvzZPdEGLagQKXkfCRIC4F1OI3YyLrxjs+pvq7VzPLmwpGD4KE3RVn
         BnEvn30mf/a9eM5fgGv0y4A+RlcDhLkT/Jt0VeON1zPklVzvLu3EP1lrxvbLRKswiqwz
         5IljviUQ4I/O+Lo7k2a4dCkzKwDJPBjGT6+e5fPsXhoNy12l0H6RJyKxGRnnQhx945W9
         O6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782636708; x=1783241508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohO+OwbdAfufkBqI6zk4RS/rHxcAGR+JiWSi+OVMae4=;
        b=PYeVfOitQb5rZpVLYoQ5M7HPJmGohTTmxhk7oOXJXSxKnljqIPUhDjEYToCJHuXT6B
         e6v0V+LUGZBKDBI9+8W+Q+XkZVDEH+fUY7Ik6GvDEVFtRh+OdZTY/gpLCy22bbcXnbxu
         sS6Oi6LJc4ry3WDbm0yCuTxw3rprVcsAJRbWkib0HdFmycasmvHzZuRH5KCNqtigiEZ8
         hlzPoDrO9Uud8ezS9gS7Q5fHD2MYVLBE1Js3/eoJt9V5EasXt92EL+SQa3vrUMn+d9YG
         raMAPcjMz6Zp3E3UpdlJHcEvBU1k3LIzpB3oFQGdTs1CACokE2uAchVrB972cjAwEUAF
         SOhQ==
X-Gm-Message-State: AOJu0YxbBHsX5QPenoMae8GWv2Cp+2eeV8ZdSVUFy3zGRYARYyQmLxYP
	uZepICTSjqid/bwaXTlrxSPo7ZMHs9WiZPGs9CMAXMAR7vYh8usoEDB+IawHtA==
X-Gm-Gg: AfdE7cmhSoG4OmJVNCOkIDpcOksXcWJvoe7IEAC3pF0wyzMAK+6xYbVyMdyxfxADBXu
	V3j/qc2YzvcS1reDttHFprS5H8zBqg4g52NqOkIjwnwR5LzmpFySodxBtphDUYVGz4XYB5xN+6j
	FDfC/SoX7Tf+3KRsNSFxJBI+V+KEHR4p9smcYGMVicAJhFY7+QuY/LS1XztTYJELm0B8Z1ZMt2c
	Y2EtuLFte8NhYY/zH2Tl69LyWj66G1XapF6rA/uY2rYeoolXCWUq41gBYPfFDxDAuGumQqWD5J5
	IfGGBvJxOALVctltlmtqVr4qyn8FP7pENMLzavhzxXmSNLReUzN3ZWqNLcufgXiKV1/9q7o9Ksh
	sovV8gAvbDnfb2zUaILUNcywcOeCtF42Wcc+3KaFNW3Xb9RwWTPfnhghUbukZamLsvO2rYP3/4i
	ULkM9TqbWLvPt/DKXahgAVb/OHGMS8ru+gt582573gC+pJLi/fAyU=
X-Received: by 2002:a17:90b:37d0:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-37f9ce1744bmr4556248a91.32.1782636707462;
        Sun, 28 Jun 2026 01:51:47 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9a5:e298:5467:317e:e807:794b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fd2bd0e49sm1712595a91.0.2026.06.28.01.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:51:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC] dama: userspace DAMON_RECLAIM min_age autotuner
Date: Sun, 28 Jun 2026 16:51:55 +0800
Message-ID: <20260628085155.20828-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi DAMON Community,

I've been working on a userspace program that autotunes the 'min_age'
parameter of DAMON_RECLAIM, aiming to reduce unnecessary proactive
reclaim. I call it DAMA [1] (DAMOS Autotuner/Assistant).

Test Setup
==========

I wrote a synthetic test using Masim. The workload runs for 30 minutes
with two repeating scenarios:

Scenario 1
----------

- Full access (100% of region A) for 30s, then only 10% for 30s,
  repeating.
- Theoretical optimal min_age: > 30s.

Scenario 2
----------

- Cycle through four regions {A, B, C, D}, accessing 95% of each for 30s
  before moving to the next. A region is revisited every 90s.
- Theoretical optimal min_age: < 90s.

(Note: because DAMON default configuration does not partition regions
with high precision, the theoretical bounds are not strict in practice.)

Results
-------

I compared DAMA (starting min_age = 10s) against three configurations:

  - Default : DAMON_RECLAIM with 120s fixed min_age
  - Custom  : 60s fixed min_age
  - System  : no DAMON (kswapd + direct reclaim only)

All reclaim/refault counts are in pages. PSI values are averages. Fault
numbers are per-second rates.

    |-------------------------------------------------------------|
    |           | DEFAULT   | CUSTOM      | DAMA      | SYSTEM    |
    |-------------------------------------------------------------|
    | RECLAIMED | --------- | ----------- | --------- | --------- |
    | DAMON     | 0         | 27 648      | 669 274   | 0         |
    | KSWAPD    | 4 876 306 | 5 259 842   | 1 817 669 | 5 341 815 |
    | DIRECT    | 12 670    | 19 697      | 1 479     | 20 114    |
    | PSI       | --------- | ----------- | --------- | --------- |
    | CPU       | 0.06      | 0.06        | 0.06      | 0.06      |
    | I/O       | 0.00      | 0.00        | 0.00      | 0.00      |
    | MEM       | 0.22      | 0.23        | 0.08      | 0.23      |
    | REFAULT   | --------- | ----------- | --------- | --------- |
    | ANON      | 4 462 273 | 4 858 679   | 2 015 817 | 4 915 695 |
    | FAULT     | --------- | ----------- | --------- | --------- |
    | PGFAULT   | 1 317.48  | 1 428.33    | 575.10    | 1 443.96  |
    | MAJFAULT  | 1 239.70  | 1 349.85    | 560.25    | 1 365.70  |
    |-------------------------------------------------------------|

DAMA significantly reduces system reclaim, refaults and major faults
while keeping memory pressure low.

Masim Script
------------

In short, four regions share 8 GiB:
user_A_sysadmin (40%), user_B_student (20%), user_C_drive (20%),
user_D_bad (20%). The two access patterns above are looped to fill 30
minutes.

Here's the full Python script to generate Masim script:

    from masim_config import Region, AccessPattern, Phase, pr_config

    KiB = 1 * 1024
    MiB = 1024 * KiB
    GiB = 1024 * MiB

    SEC_MS = 1000
    MIN_MS = 60 * SEC_MS

    total_mem = 8 * GiB

    regions = [
        Region('user_A_sysadmin', int(total_mem * 0.4), 'none'),
        Region('user_B_student', int(total_mem * 0.2), 'none'),
        Region('user_C_drive', int(total_mem * 0.2), 'none'),
        Region('user_D_bad', int(total_mem * 0.2), 'none'),
    ]

    phases = []
    
    # Scenario 1
    # ==========
    #
    # Loop 30s full access + 30s partial access.
    #
    # Total time: 30mins ((30s + 30s) * 30 loops)
    #
    # The 'min_age' should not be too small, otherwise it will cause many
    # unnecessary proactive reclaim.
    #
    # Ideal 'min_age': > 30s

    for i in range(30):
        phases.append(Phase(f'scene1_high_{i}', 30 * SEC_MS, [
            AccessPattern('user_A_sysadmin', False, 1024, 100, 'rw'),
        ]))
        phases.append(Phase(f'scene1_low_{i}', 30 * SEC_MS, [
            AccessPattern('user_A_sysadmin', False, 1024, 10, 'rw'),
        ]))
    
    # Scenario 2
    # ==========
    #
    # Looping {A, B, C, D} with alternating 95% access.
    # Each region is re-access every 90s.
    #
    # Total time: 30mins ((30s * 4 times) *  15 loops)
    #
    # The 'min_age' should not be too large, otherwise it will cause many
    # system memory reclaim (kswapd/direct).
    #
    # Ideal 'min_age': < 90s

    region_names = ['user_A_sysadmin', 'user_B_student', 'user_C_drive', 'user_D_bad']
    for i in range(15):
        for r_name in region_names:
            phases.append(Phase(f'scene2_{r_name}_{i}', 30 * SEC_MS, [
                AccessPattern(r_name, True, 0, 95, 'rw'),
            ]))

    pr_config(regions, phases)

Algorithm
=========

DAMA's "DAMON_RECLAIM's min_age" algorithm is a periodic feedback
controller (core.c:reclaim_min_age_calc()) that balances DAMON_RECLAIM
and system reclaim to keep refaults low.

1. Accumulation & Decay
   Each cycle, DAMA reads the delta of DAMON-reclaimed pages, system
   reclaim (kswapd + direct), and refaults (anon + file). These deltas
   are added to two independent "remaining" counters:
   - damon_remaining  (for DAMON reclaim)
   - pgsteal_remaining (for kswapd + direct reclaim)

   Simultaneously, the same deltas are accumulated into long-lived
   metrics and continuously decayed by a fixed factor to smooth out
   short-term spikes.

2. Threshold Gating & Hysteresis
   An adjustment is only allowed when one of the remaining counters has
   built up enough "credit":
   - If damon_remaining >= DAMON_THRESHOLD and DAMON reclaimed pages in
     the current cycle, the controller considers _increasing_ min_age.
   - If pgsteal_remaining >= PGSTEAL_THRESHOLD and system reclaim is
     non-zero, it considers _decreasing_ min_age.

   Once a threshold is met, the _opposite_ remaining counter is rapidly
   decayed (multiplied by NOT_WORKING_FACTOR) to prevent the controller
   from oscillating between the two directions.

3. Decision
   - Increase min_age: compute (weighted_refault * 100) /
     damon_reclaimed. If this percentage exceeds INCREASE_THRESHOLD,
     DAMA assumes DAMON is evicting active pages and raises min_age
     proportionally.
   - Decrease min_age: compute (weighted_refault * 100) / (kswapd +
     direct reclaimed). If the percentage is below DECREASE_THRESHOLD,
     DAMA assumes system reclaim is missing cold pages and lowers
     min_age proportionally.

   After every adjustment, the refault counters are zeroed and the
   metrics continue to age, so the next decision is based on fresh,
   representative data.
   
Question
========

Synthetic tests have clear boundaries, so I'd appreciate your thoughts
on how to make the benchmark more representative of real production
workloads. What memory access patterns or workloads do you usually
consider when evaluating DAMOS self-adaptive capabilities?

I'd also love any feedback on this userspace autotuning approach or
suggestions for real-world testing.

[1] https://github.com/aethernet65535/dama

Best regards,
Rui Yan
