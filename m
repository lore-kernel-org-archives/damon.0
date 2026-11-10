Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275631;
	b=UOf17WMt0rbNILTYCPR8LRNZqgfSyk/XmZNUdztmy6DvJvBJ/Gqin96E8o6NsbRoYyLy
	 uyf3u4O0Aa1kMPb+O4koIB3QP04ovs4a81/Dmh9L7RZFzJQkuN3fLb8WArEzPjRJc0Kf0
	 cETzAwSemVc8xzEc5XKW5mqQ9l4Ao31ybD+GoqQtdZ0L61fzNkR/IuN3LtDsHT2Ondi7M
	 ElGWGyBnVJlbsEmEeIwcvgbmKnbfdjFT833fs1SXCaOCIheqMq37jG5YDvEpv5tBli9Wd
	 MgIP9z8h5ldGFfIrOQZguOzgLVQhVVF610QLW0BJCGkXB8n61v6dYbLk3BPSun6qn+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1b9Gm52IiM/h9OrZZh1jFEopd/R8VOMTojmLWfiROik=;
	b=bomHe9Zy48RcecoykAfRuUrP29vJAyP1Fj6fxfJu3m4RdN+bRG14Z7zo0+YfomUpbnbY
	 P5A3i/3CCKkgW06M2kgkc5jpZJI/ypRz8ghXZT+77ohOyio9VxwVVWKxX8W9eJU0cirRA
	 q5ZVapFcMv2wn/jRnxF+2YbQ3C6d4IkVr15lcLEyV4NBpk/Rb+bC4vNYDA+PCnO9sbeat
	 pQnt0H0zRm3rspuJtuO9jS5toUVKC5hMx+kRDGLma1T76c6fE/jESrwL0R+NFWS9DcRum
	 x0BgZ3axUs0t2QTpu6dETw5DO8as1NZk9dFz16Ix7xfThlQxly8HNBlWtTqkjkysPAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E8mfmcFR;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95779606A31C
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95779606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E8mfmcFR
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed0890476fso8055015ad.0
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 17:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275630; x=1794880430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1b9Gm52IiM/h9OrZZh1jFEopd/R8VOMTojmLWfiROik=;
        b=E8mfmcFR2w9iGpa0zqxgFyBi1QL5bsG9BVsJEgtzinKoRLO59M79QzYFkUuXvGw2Kq
         W52PibdtdIKuoT6mR5ThKuHQgFEHyzZmyJ9PgQS2l1YE87YTomz8kKmzTclV8A7u5G+4
         IVnxYSa8kXa7nTBpYjHp8DRC/kRzkuO9BO1Ckcs67UeZ82wPaZfU2mAoZzdGzwgzHXcS
         9vSYEU3c8cM9B3JUZCdpfIF0Sa2gMfR1lxxYLhdnNa7VG0scCXDJgZhZIUbLX///Bw1x
         dUZMglzDXQfWgL77vDKV2S1/vvYHdtZGF+8DAVzT74pUHPIofDHq1jQ4KG3pjPrs2VbG
         TRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275630; x=1794880430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1b9Gm52IiM/h9OrZZh1jFEopd/R8VOMTojmLWfiROik=;
        b=2PTLhw/naKVWhMxOXjwMzEoIcdh6zah0ldDUWVXxv+NneBaXRr6/NZIkVEe3stnO69
         3XUmWaA7mdAxUuolZND6uIQSPSdoWjk6gPR2feNW8NRpXOQEPDPULPI4dfyUhw+D4qWj
         X5KdOnPTDka9XLFKuSGLREjayjiFFXu5yeN8XlRAYGxBPobh4WfSmQCHwKUWHqBofpuO
         1tN3zFVkTUIuZVG3HIwUjoKH/t5YS3uPlIxrtQ4ylc2lgJKbIyuxRYLu32k6ODk02KQQ
         vS4aHRQEFmQWP9SREsoCY0T8oUbCsO7L971V8z2a2Rs94soH2fX0tP4e2ZrXHE9gwohe
         RVFg==
X-Forwarded-Encrypted: i=1; AL+hErHrvvx9Plqsg12UNEEYh7ZwRQyWvhkjT+lNdCDfs096d84ZrVe9lUNLuAze83acgJMnX5EuaA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Pq7CAm+ke5/R+nv+mEwlIdS2urUIN/huOpyTjBl03pvN3+PME
	k+CSFzhhYjNUeCYoEEWYYuFRBtBQRt6C3o0rT2PQwy15PjPpi55WeNsr
X-Gm-Gg: AYBFou2ViLkLNmD2EMT51vugzNtChAQSs0+xh8T6HlCl6jup9zIfr0Wa9Iv2ZpIpYd+
	qxEGQAbkKCdDpZmQKeXXcWSO7suidW+PCk4VFuKMarmpDFAk/R0b0mVIqpUVhA342MZfts5eKiD
	lQX46ZC2pwBgprX8m8Q13D/ErqV5rNlRCVYntkvPu0bl3xbeltJkMQWItbxznuzjGOE3nG7AXAt
	GcuVnv/0PSRa6+wGbypVREuhJmnuZIIC/1BwFGKlwZduUz8o44eNJBEshtlxk44zuBPuGzZQtxc
	1mlXtfFREvv1DWag+6+IvdXb6FD+OI+89TngE20TFkRgkr/h5CpysS7n9niI0HDQAJIYB4IKSXx
	OLD6SA3Ua4k5w3rTFhLK2Nw/sLS42MTQO97235QyXkTEFteHvfpPB76441lcNO4lgmw/HtwcHOt
	TXfwVLabVp7mC5Poe3I/4x35MK9riXLI66vmyorsyu2QGHbtC0efQZSVK9+iVMd9uP+OdBwTVIB
	kuqYvj7M0qBiznZtsxBjF6NqvxeXy99lcLk9UHpMvhyqkb3b0UrKjrpWtPIqFJOTwZFXtm0U7DL
	rrGesAzYfGxP5P/3tJmhtRSxHySZBbBwTKHQY41YevAPYeX8ycM5pJ2bUlUXphWnYWId81cvkjn
	LGLdPLM1Qnki6//RKXSqwvPPMZw==
X-Received: by 2002:a17:903:120b:b0:2e9:660a:7944 with SMTP id d9443c01a7336-2edb92c846bmr9971635ad.58.1794275629806;
        Mon, 09 Nov 2026 17:53:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm3307325ad.11.2026.11.09.17.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:53:49 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: yosry@kernel.org,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH v2 0/4] mm: read root memcg stats from global counters instead of flushing
Date: Mon,  9 Nov 2026 17:53:17 -0800
Message-ID: <20261110015321.611093-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reclaim, refault detection, the zswap shrinker, and DAMON quota goals all
flush the memcg rstat stats before reading them. When the target is the
root memcg (eg global reclaim), that flushes every cgroup in the system,
which is expensive. Most of these flushes are ratelimited today, but the
stats they read can be stale for seconds.

For the root memcg, the call sites can read global counters directly
instead of going through rstat. Global counters are always up to date
and don't need flushing. For stats that only track memory charged to a
memcg (eg LRU sizes, workingset, rotation, and reclaim writeback
counts), the root memcg's hierarchical value equals the node counter.

Patch 1 is a zswap fix for the shrinker's count for the root memcg and
can be applied independently of the rest. It doesn't have the stable
tag, since the zswap shrinker is opt-in and the fix can change writeback
behavior. With a workload running in the root cgroup, the shrinker wrote
back 0 pages before the fix and drained the whole pool after it.

Patch 2 makes lruvec_page_state() and lruvec_page_state_monotonic() read
the node counters for the root memcg by default, except for the stats
whose node counters also count memory that isn't charged to a memcg.

Patch 3 skips the flush in workingset_test_recent() when the eviction
memcg is the root memcg. Reclaim keeps its flush for now, since global
and root reclaim also read the stats of the child memcgs they scan.

Patch 4 skips the root flush for DAMON's node_memcg_used_bp and
node_memcg_free_bp quota goals, whose flush is not ratelimited.

Of the excluded stats, kernel stack, secondary page tables and
WORKINGSET_NODERECLAIM only differ from the node counters because
accounted kernel memory allocated by tasks in the root cgroup isn't
charged to the root memcg. If the root memcg's stats should include that
memory, then those could read the node counters as well. This is left
for a separate subsequent patchset though since that changes what the
root memcg reports and needs more upstream consensus.

Three root flushes remain. Reclaim also reads the stats of the child
memcgs it scans, and count_shadow_nodes() and filemap_cachestat() need
the root memcg's own (local) stats or the stats of arbitrary memcgs,
which means global counters can't be used as a substitute there. This
will be addressed in a subsequent patchset, as well as getting rid of
ratelimiting for most call sites.

On an 80-CPU machine running proactive reclaim on the root cgroup, a
root flush took 69us on average with little cgroup activity and ~0.9ms
with 128 memcgs repeatedly allocating and freeing memory (wall time,
including waiting for the rstat lock). Reading a node counter doesn't
add any cost: it took the same amount of time as reading the rstat
counter (~150ns, which includes bpftrace probe overhead).

For more context on the background of this series, please see the
discussion about memcg stats flushing in [1].

Changes since v1 [2]:
- Read the node counters for the root memcg by default in
  lruvec_page_state()/lruvec_page_state_monotonic(), with explicit
  exclusions, instead of adding lruvec_lru_page_state() helpers that
  callers opt in to (Yosry). As a result, the root memcg's memory.numa_stat
  now also reports the node counters for the non-excluded stats
- Split the workingset_test_recent() flush skip out into its own patch
  (patch 3)
- The DAMON patch (now patch 4) only skips the flush, as
  lruvec_page_state() reads the node counters for the root memcg
- Rebased onto current mm-new

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1aHdBm4CofvKfx7B3H-uF2xRXZUQs47J_4xeRmRZ4hcZg@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/20261102225030.2743129-1-joannelkoong@gmail.com/

Joanne Koong (4):
  mm: zswap: fix shrinker count for the root memcg
  mm: memcg: read root lruvec stats from the node counters
  mm: workingset: skip the root memcg flush in workingset_test_recent()
  mm/damon/core: use node counters instead of flushing the root memcg

 mm/damon/core.c |  7 ++++++-
 mm/memcontrol.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++---
 mm/workingset.c |  5 ++++-
 mm/zswap.c      |  7 +++++--
 4 files changed, 64 insertions(+), 7 deletions(-)


base-commit: b95f8bb86713c860ce8536d22a988b949b884d5f
-- 
2.52.0

