Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275638;
	b=up996qoaROtrAAoPXiz84Cf0CH7WlWaAqZP/WtHGfr87pTBMUiwXzYpzhWwwf9QK/vj6
	 S2abe8dR7RDS+qDtw1QI9XXYemKYze6iF/1jM41eVl/ynTSXpjNwC8n2xmghbvECpgpy0
	 UThkbKP42Q3mbcuVamM57mwkLqgrJR7tSmDtf1pBh3GUODl5gVrnCW4PGeW6g7QSUwFjy
	 S+Opqx5rWoeb+Q+q1zl9vtr4K1v8IMajhDPDQOVOJbOl3NL6kok9Pu9xeNgOh2vxfDXpu
	 Mzi9XY9SFCrr1kLDtWmi+k9PK0LD8dCAFphTiMzaCPaY8Z/3Elu+dPCqHTk2urZjOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8I8d+hDMqZ6xVmUygiM+c57kytjFuIQN7v7mSubiZXE=;
	b=Fnd0KY/UW9usW2GpaUXryrVdh1SnIdpyAg5VeaAoHD6UFZAgAVR3u6/6Cf0NHTg5S+ir
	 6KKFBQfNW02UZxSLc7PZf35qHxUk5OaOhcfIUgP+zZkFzkJvHLWne3vINHSsbV5+9/OZS
	 T7fzI8yiUb4Txh5kUzGKGbqj/bEYEL+K5/XHnO105wqbgFDIeSy40MT7pgnY1zDEnlTAX
	 9+aVQtT/LWlu2ZO4O1gjbwiBn1SifxdSTbq4jtKvDV9GblDj9dRVfy6MSCZcieNKFSx5p
	 gX0jlUp476OQXNYGZn73K503/WQmRLhkF5UxzRhI3YnrZMkH0O9e7EXUnHlbYpFhwew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l2hyqros;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502C606A31C
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A502C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l2hyqros
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so958841a91.0
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 17:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275637; x=1794880437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I8d+hDMqZ6xVmUygiM+c57kytjFuIQN7v7mSubiZXE=;
        b=l2hyqros29aKgRDhxKwCfYO8Mg4lKWsU52BBnZ3pw15hC+MaAGdGvC5UL1oZmtrFjV
         31RSgbfIN4huVDzBnChkcxhN7GdS1Truw94H9j7LbaBioJP2LIrph0ltXPHqUuA3zZ7t
         6c6V6fgQKTshpKVJ9ZBwViBJ1UNN6ldvB5k1REkZRPr7h3cFMzHHJkMKHBiJRoeyho1W
         X0NW8YLLvUtSHnPY7nAZ1d4FGj97hf7XlTLULo9fm1hfMtrEgq2yD2/iMTqWo+Hrdpae
         CnMteb2pqNAuROiThWT/cvlPye9LiWLeehj6JIKMyo2je6XrfVUW3RSoTq5m8Z1YuLqu
         /Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275637; x=1794880437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I8d+hDMqZ6xVmUygiM+c57kytjFuIQN7v7mSubiZXE=;
        b=is/GZDI5W0ArK+/BYqrLRXFT1FRWYlvg1MqkZx3YRk0AR0mHFf9Pp0X13UH0XN8Sj0
         uq0b2t6CUcqeU0z18Yh00TETv8Qfq8cJbk5nRv/cKDzURBS73M5Kxm7wgtJ2Fe2KUx6L
         O/xTdtR8QdbgJDNacMr6HR35VWt7siGgfw1D/E0WtTOuTNUjKGvTXORvrOaiopCoI2S1
         SAvLCtKH86VozynZvfMwVd9D/zfMaf8uVrJ1D9s0rfvwoEROJ3q0N0/PJOv52vaQTdfo
         A5clpmnbnOydmxiCQKl5xqQgGTSFJT/6r8wy8gJKq+QSckW2P02DQIMORHIYvVjck5d1
         rz8Q==
X-Forwarded-Encrypted: i=1; AL+hErEJrRamM72TPfJhWa/38YQWLal0GMTrOenPTAZRwye72juBQk4CdCd7yWA70ZJSl7kcxtFX6w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/dDYnKSJiRHZ1tb883z07Fl1x1eBr7TCqOw/6T4pHG0SMZRHSW
	1S0jfIkUBj9CyZfwqrIBQVIGlXj5nIMCHUCfUPqk93M26TTtlF2Yx2ho
X-Gm-Gg: AYBFou3P8p1VIr3IGiPkdtW4E8cgoD6ZiUUdAO/u2VOVppar09hj+5rXfedba9PyMX9
	FQc746yjEXJEGHfYiXMu7zKrYdSyNMpvSjTV6f6RSola5X3HuXDFWJEqxpoGQlzCK0uEmrAIbks
	w4e0Z4VSrW85eiLxTW6FLCn5XIbtUrqajKuO+lQo+UZTY48ZPwuMSYAYL3p/xGxN4hS26r/z1Yf
	KBWjPy0BU4GPQkMjz4n9SyK9SKOK2Pq9xBpMJVzowlPg/gkfU5u15+x48CinmaT2GJx3PTgJqtO
	FapbU+b7iTwrxTs6ykMWcNEt74OAos3kCro99J2BqGCgUsRusYd2DqXSvZi4dYMUEepgch3K8Tl
	w17uDPQZdgqTyESt70kx47QTP/G8gnJH9dp6hr9iqnZFswc0rSAjnblqsxnEEjtHVp4wZVqMQ7B
	VpXGmY0ORFJhoffAAw7iwprDw46h07+OcngrNanT+VAHtNWt9OOFkpSQSLIrlePBWrv0xDxXl/C
	Ih+WmY4Sdm8kZXyjonjP5S9BqcCPynO1Yd6GUqL/6A8dmbbBGCLbYXKfiHjibIR4QHFyUDP6YUp
	FOvVi9nTLu96hHIUYa/E/jde/7+gOrv8XfWEayxF7+E48iwCUJmi02ZCANlydoVWE/8oaGYqJJL
	RE11dRw==
X-Received: by 2002:a17:90b:5848:b0:3b0:9976:c1c6 with SMTP id 98e67ed59e1d1-3b166e38ceemr1381590a91.66.1794275636884;
        Mon, 09 Nov 2026 17:53:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168acaf41sm564784a91.0.2026.11.09.17.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:53:56 -0800 (PST)
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
Subject: [PATCH v2 3/4] mm: workingset: skip the root memcg flush in workingset_test_recent()
Date: Mon,  9 Nov 2026 17:53:20 -0800
Message-ID: <20261110015321.611093-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261110015321.611093-1-joannelkoong@gmail.com>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
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

We can skip the rstat flush in workingset_test_recent() when the
eviction memcg is the root memcg. lruvec_page_state() now reads the LRU
sizes of the root memcg from the node counters, which are always up to
date, and workingset_test_recent() only reads the eviction memcg's own
lruvec. This avoids an expensive flush on the refault path, as flushing
the root memcg flushes every memcg in the system.

For reclaim however, we still need to keep the flush (for now) since
global and root reclaim also read the rstat stats of the child memcgs
they scan, which the flush is needed for in order to keep up to date.

On an 80-CPU machine, a root flush took 69us on average with little
cgroup activity and ~0.9ms with 128 memcgs actively allocating (wall
time, including waiting for the rstat lock). Reading a node counter
doesn't add any cost. It took the same amount of time as reading the
rstat counter (~150ns, which includes bpftrace probe overhead).

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/workingset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 1504f91cdca5..383f951eaad4 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -483,10 +483,13 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 	 * section (for e.g, in cachestat) - these callers need to skip flushing
 	 * stats (via the flush argument).
 	 *
+	 * For the root memcg, the LRU sizes are read directly from the node
+	 * counters (see lruvec_page_state()).
+	 *
 	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
 	 * still needed here?
 	 */
-	if (flush)
+	if (flush && !mem_cgroup_is_root(eviction_memcg))
 		mem_cgroup_flush_stats_ratelimited(eviction_memcg);
 
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
-- 
2.52.0

