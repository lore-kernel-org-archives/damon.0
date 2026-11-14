Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616194;
	b=SOHPbTv22CSipIc85P3abQSg3ey9IGiMj44M777ln0zlN7lU9bt4JB2JjWr1qzXAs5cb
	 twHccbKjNoif1PZSdBFIRn4kNvrTreMFJi1Y0ugT3DgOWQ1speL/zPtT+bDE2fgabHucT
	 tgKih8gMVFHt8D0JQAY05MQAxfH8BCHfx3P+h4EHBiMWx1fzgE8+5DweSvqhCgP8QAqaW
	 9rXn4JLs427RBatUtSxZn/f44BI8MkKv60uHsst0KD6MaqtHqhNg9+AzBJn8s+bYTGAc1
	 PwtZc2+SgGzHR3Va0RWSPg3XOPySsyhvAUkbWUOWG9cPj6eKboWBb6q1RsovjpiZY/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Iq2xOf7brzRimqeh3kCSIQaM8aaawwKdufuiU04kk44=;
	b=nFbNG78yuOe72ynpmsuqBhc9e/9uU3RxgL6aF6mNuBRnMBpCJoI/l4NT5QXHsmCAKZOA
	 FL6sj7nWevZKcktvTBeCmDnvdod4AXk0g0fXt59WRWSWUzUJdMUtjRK0hMqZinZkL4ogA
	 xD7kIlSxHEplgN4zKKgd3n3sqDl10k2ctIs8v1/wGcEF4SwYbkt2k2Wy9fAm04tieO/rF
	 fJCaS8HD46VQmjpNUHV5O9jD4Fwpf/GbdQ/FAIv+EQ/N1DHkrVTAEOWekiDE7DXsuulXR
	 8It1K6uoN61JJ97Tnbzj8BJ2calT+Jc6mvUvounOnJttM29154pOu7z4nh8Xy6ybmUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEcOyrA0;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB74606A336
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB74606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEcOyrA0
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67c58f18765so1293391d50.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616192; x=1795220992; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iq2xOf7brzRimqeh3kCSIQaM8aaawwKdufuiU04kk44=;
        b=xEcOyrA0T6Wn5TS3XST6GemTO4d4cUUgl8h++nXyXhc8jeZNyLc5gGBB0eKdmQHVAG
         Px5lb/KkRGY9hc/sZWCFNHtj9mMGYVjf8UkFkOkwOfEh0YuOqNXR2IHDJOHishrnUraH
         c2M+U63X842EKxPb7/tzYYRgXoyyamk1247plMjRQMw6NGJpi+wCRfYp3tiHsTsmhGQS
         ING2UT2LulagrbEXhPF+7YK3rA2VCrZcKsZuXuxhaSHaWvI/5jSLsIzBF01sA1rpDenO
         AMzGBbP2k8LH9WbQaxXzq6EsIiE4vSDdRlS1l0HlCmaOm1rhrvTvCQv9306lm5htF0u/
         ltYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616192; x=1795220992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iq2xOf7brzRimqeh3kCSIQaM8aaawwKdufuiU04kk44=;
        b=NFtMF07cu1B2tR56mAA0UZTKShv/X/B9xTm1/OpeoMAVyvCM83T0O0nB8Kwe81zzra
         hSHf12k/eTfs8mO2YH+UIZSEmkZ51olr3DVUkNBue6NeWZDot9Zczm0pc4W0b84CVuU7
         pxZv9bq3eEtg+rAOFMTvHcXx6pCAxNaYjw/vXK/ts+Xhkb0Y162WkPEHWM3EZaihC4MU
         pUIo5UuLM1nxBVG89N2WXYP81l01HqffOg4YtlAU12aQ/SAdp3STdBVbzrt671BYsrcv
         tm7/Kn0NnY7QD0pb5PONPetbKHi9/vYIQKRYJM0Mw1S/+qq1EHXV8GblMP6Zc2M04vwh
         /7KQ==
X-Forwarded-Encrypted: i=1; AL+hErE5R76DpKkevuljA3u6pnUfk0rW6Bb2y1zCYwjT4qqmTShIG/SzGEIoaBGVoc3sAHTE+qsZYQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9x+rPUVMg5kg8z2+A8BhhPHcLCBNSMTUuk53gHwAmlSiNHgz4Q
	hWkIE9uLbE2JuF63J3RYg937P7vv5W4vglKZEcWXBZWiT0PqhU67TXEQ
X-Gm-Gg: AYBFou38Ya8HzHeM1XGSDBOIA9pa24zbE+4hs/OohX2y5yyAI7tFVAzZ3j9y6p7ms9B
	ZLV5BwtX5HEO8b/oh5DRwWVHgAEJK4KHsp8EF2LlqyV3arr+Z2aFAsAXH6YBy5quV2U/i5C8Vz7
	zIAHbHI8wQj5bzGi40hxbWAFASEk7YRr0mkjZ+iB3TeuZkt4seJrkNfUou2ZJf3vcZKAFB1bNMC
	p9DJOcceqe6Ft8tsBCmArSa2iOkAq1lkGZ5C8UOyEDqLX1jYPadkI58yLOVW4/edULMtRaJvwDS
	X8BFkBrT6xkgDe9SeCkSyvfjlMCP7VyuCsj+ueZTwWGgBoDAbE1v6k0KyrRmxT+zd1EHMeoiVqh
	Eaw0ayJ5pXYvrZ5r7L9Lv+HgdL8TOXuWrOvxla/N7JofoBtJh3N7GbfMteIVMImDv3DphcQvHBG
	IfDy0NB3OuDwL3w4JhzW9W2GKe+z/VftFq0EcI+s3FXRr5r9p5PQQAuvzVCX3QVEARrKOlfKyWt
	Ic0Q3D1jcXTQo/KZckWNFP3pm3QnpHqOVaMyuS7Fqke255lNk/LID2n+6We1k+esXMabcsd7+m8
	0MoXrFLSM9nABaNFyPqtS4ng1DQkJkldQbTWtXjE/b6i7iR8+aislP/pwSaGaDxKFs9vFH0zVua
	Fx2xx7pnEMOSwufxslTWkD1gGT3o=
X-Received: by 2002:a05:690e:b83:b0:67d:9d2b:91b7 with SMTP id 956f58d0204a3-67d9d2beba2mr161001d50.93.1794616192402;
        Fri, 13 Nov 2026 16:29:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a59f1afsm3447586d50.9.2026.11.13.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:29:51 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: yosry@kernel.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	ljs@kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH v3 0/4] mm: read root memcg stats from global counters instead of flushing
Date: Fri, 13 Nov 2026 16:28:18 -0800
Message-ID: <20261114002822.1043378-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.1
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

Changelog
---------
Changes since v2 [3]:
- Change from denylist (patch 2) to allowlist (Sashiko, me, Michal)
- Add SJ's reviewed-by from v1 for the damon patch, which I forgot to add to
  v2

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
[3] https://lore.kernel.org/linux-mm/20261110015321.611093-1-joannelkoong@gmail.com/

Joanne Koong (4):
  mm: zswap: fix shrinker count for the root memcg
  mm: memcg: read root lruvec stats from the node counters
  mm: workingset: skip the root memcg flush in workingset_test_recent()
  mm/damon/core: use node counters instead of flushing the root memcg

 mm/damon/core.c |  7 +++++-
 mm/memcontrol.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++--
 mm/workingset.c |  5 ++++-
 mm/zswap.c      |  7 ++++--
 4 files changed, 71 insertions(+), 6 deletions(-)


base-commit: 31a696f9c37defab0f28f774e00ac7f135889ec3
-- 
2.52.1

