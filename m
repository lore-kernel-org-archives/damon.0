Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659857;
	b=Xgw/1kZwNKvxJ4eEHm4SXDHBXXvSGHQabcj3IP0Rw0/IKBSTJ85b2u2IKxwmWI24SH4E
	 5pXckdJ0WbsBfSIBUG47nZlO7l+aPDXiUJilEup3ixhv08ayi0hSRkMtk4xvA9gYJgZ3H
	 rMpiwbA+lSjPXnXb+Gdn1q9L/UfR76DiHaoM3gwaEsiBLufOQgXrVR5PjI7Y1WnJzjdpA
	 8lhIYxVOrk92IkXCM+4E+Zb53C94/8F4uipcHKJS+ke6GnZ2cGsSghydICcFZ0g9GBbjM
	 xgPl0BdfU2NTfJx9mX1/1PnR1wQ/a9rV6Rc2KUCagD0L5W0Jd6Prqy26G6RCCtD9ytg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JZOd5uUgyv72utWzP1shduuWDKjucDdTZdv55Qn50b8=;
	b=LykYNTwgEcoCP24FkQzubk4UB489Dbu6aNrrB0ogrY69sXPGcIxBa7lZTfxu0cj6rAqG
	 zfaIshrxGATQbK5IuAFg2E2HOaQ54WZ4h8Sv6WMlnx4FzW3XJuXmPYJhfgippqXm3mK6n
	 AC6SzmgQpj/9weRNbs0xmMc7db3/FKiL07nv0ajEEQVzLOt1MufU94YuokCeL811o29Wx
	 SGXNjtAdzbtRogjJxo3sBMrHWXoaRjN0e+WnJl/ZJBpziEzB6I4IoWeffe/RFvKKaEjMY
	 3eKF4wXE2OzplRPqdnYqt7PBX1DzYuxKXth9sdSACXSnAK0kMC/3i28wGXIVmxB/YHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U7jwBGCx;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE6606A326
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 22:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57DE6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U7jwBGCx
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8ad98c3fb15so30277157b3.2
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659856; x=1794264656; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JZOd5uUgyv72utWzP1shduuWDKjucDdTZdv55Qn50b8=;
        b=U7jwBGCxOJz7fkMCi5XtzfgWM5VYwewEYz2JLOq/VDnrKrQpilx03vcrqcvtslCPIL
         ScbAxp4i98iyzDW6ZPwV0LBG/IjiWut88FcoWhAVukjO4846SFeekOY/dd+NHK6JCEk/
         RgXhzsBjJ7lSESSHgRB7E6LbmKR5D0nI3JUaEOISYVexh7srtQRmjVR25oMl1rUdaiaf
         a32q0ecvrE+ZhLcbbvbunWlYx2NyAVKazyukFvqK6WUsymyvUawyMNSFxC0cNVKTHJxT
         c3horE1Uf3GderDL4GEwBosI0Ln1XP5chvmscaxK0gLLt3JiTr2LO6HWk3UPpSRH2bbU
         oGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659856; x=1794264656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JZOd5uUgyv72utWzP1shduuWDKjucDdTZdv55Qn50b8=;
        b=J4EfUR8JrK+XRGImC37Bc11oOKSbAZhOFQlGx9NXXnBL+DjP/x8O/+WliEs13X4lXH
         WI45E3MDc7XoTvCNxTrvsf43X3D9z8t+aODE//Ify9306w8Q+wZ822mMa7p1yuZPTvvf
         ApV3uyQykq3Ga8dXvUSgkD17G7JXm+YY/TIfOjwQFKCQetvQL6wHqr8n6zgNxccLWZpu
         OPD/NMspi/XByld7SWIQG1JfaLgmfqrML1YimTfwmorfm4jiTRZUbrT2JGgOTcszW4BW
         JakpT9sjcIKX82xxOo6TFH9Czy4hXdtthNGg/VP10PP6FC21TCKCzwHtEzWQayjdP7At
         LWvA==
X-Forwarded-Encrypted: i=1; AKwUvBwfoMP00g4xz9h5E0kIrPlf/IIyW2k8LQZjVuGoqxnEncyjKzBkvuH4rjyVWpM8RV+0wqr3vA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+jTm8tgRh4tYsqPUdjoHjxyf5UXSNYgSnt0w53qjDK4yu5iRrB
	IeVYCkljgGXhLDU1LC+kQuuTNKXjwoHvj2zOYRoYL2JoR46tngHzKp6t
X-Gm-Gg: AYBFou0+GzZC0fzRGFyNdAbI0A/GD+mdUGnRZ0S0MtQPwnmJS5sKthCAHV+3QrwDEcK
	BI5xgMl/iR6Pas9lC4gansr8wRhSQVh9qbAGYz6eIdZOUwY+MKRgBs2maHRwpXnY0N6ms6tZShF
	wwv40HwPVrEW+ODfevUUcZR4uwD7TdOWQc/fVqMFhx/zrnDjxtsceL7dxJ5ljufz0bzSWqVVHbq
	5AZW4uRykxgNR3zHcVDvqq5CoExdfydZpYf0o+BkIOl94D0Xk3OdQjra4grOOcj5QdsxR0u6ak5
	NOur0Sz4l+qqpTGtPD8YaWtUBYn727x8ICA1HFbmFUqAlqbMLJMz03C/yP5xMhInoHDHrA+vmUZ
	WFpPmLEhw9Yj7AV0G4Y1MFPuYKOL3hqkDe46M6aC9rXr60LuSQ4xfcuOJTdqqGVf8NgBbHxvOrD
	QXfQwdGjMSqqUKGTyfXM7sAR3aUZKXGFBgaAI9MKpslsUydZma8gF5pky7ctmRtp/+/TRiaaa8b
	0QFNtqVMA9LbUGgzB+SnpIfZZxxI58J6oygQpyaqqI7MSiiXzFprshdDCIIA8rkFeIbzfBiYsWM
	cTtGQL5Z8IqPjRsS6Grsne7xygz7HUYt7kgyWL9CudFk9o5jo1s7T8EPbaiTw5JQzn0f5j1W7C+
	d+B5iYznGDxR+5qlLYRo6tUaxpMNp
X-Received: by 2002:a05:690c:397:b0:8b0:9e81:8ba6 with SMTP id 00721157ae682-8b2b67967afmr88183357b3.44.1793659856054;
        Mon, 02 Nov 2026 14:50:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704dab5sm61260967b3.1.2026.11.02.14.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:50:55 -0800 (PST)
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
Subject: [PATCH v1 0/3] mm: read root memcg stats from global counters instead of flushing
Date: Mon,  2 Nov 2026 14:50:27 -0800
Message-ID: <20261102225030.2743129-1-joannelkoong@gmail.com>
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
root memcg (eg global reclaim), that flushes every cgroup in the system.
Most of these flushes are ratelimited today, but the stats they read can
be stale for seconds.

For the root memcg, the call sites can just directly read global counters
instead of going through rstat. Global counters are always up to date and
don't need flushing. For stats that only track memory charged to a memcg
(LRU sizes, workingset, rotation, and reclaim writeback counts), the root
memcg's hierarchical value equals the node counter.

Patch 1 is a zswap fix for the shrinker's count for the root memcg and
can be applied independently of the rest. It doesn't have the stable
tag, since the zswap shrinker is opt-in and the fix can change writeback
behavior.

Patch 2 adds lruvec_lru_page_state(), which reads the node counters for
the root memcg, and uses it in reclaim and workingset_test_recent().
workingset_test_recent() can then skip its flush when the eviction memcg
is the root memcg. Reclaim keeps its flush for now, since global and
root reclaim also read the stats of the child memcgs they scan.

Patch 3 does the same for DAMON's node_memcg_used_bp and
node_memcg_free_bp quota goals, whose flush is not ratelimited.

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
add any cost. It took the same amount of time as reading the rstat
counter (~150ns, which includes bpftrace probe overhead).

For more context on the background of this series, please see the
discussion about memcg stats flushing in [1].

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1aHdBm4CofvKfx7B3H-uF2xRXZUQs47J_4xeRmRZ4hcZg@mail.gmail.com/

Joanne Koong (3):
  mm: zswap: fix shrinker count for the root memcg
  mm: memcg: read root lruvec LRU stats from the node counters
  mm/damon/core: use node counters instead of flushing the root memcg

 include/linux/memcontrol.h | 16 ++++++++++++++
 mm/damon/core.c            | 15 ++++++++-----
 mm/memcontrol.c            | 44 ++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                | 36 +++++++++++++++----------------
 mm/workingset.c            | 19 +++++++++-------
 mm/zswap.c                 |  7 ++++--
 6 files changed, 104 insertions(+), 33 deletions(-)


base-commit: 0e02eb17f263e4a3ae6bf1fe45122c23361f0cf7
-- 
2.52.0

