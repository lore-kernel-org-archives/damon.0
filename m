Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616197;
	b=KjIhUZEYARL26FbT5w0grwxJtYF9ythwWyaQ9d0bp/FZp9mKZVqLW3L1FB+UKV6MK1dL
	 /g4OZvf/GKYikRIoYuQ1yVGdzZ1wvZpedU3Ok68haaVXMIiW3MsExNkW4aOJGqh+5CqMU
	 /gcpOA4413KM4VgIvkgll4/A0Rm1NxE1/xNGbKFVjSPv3+Na64mGgXQv7f2XR6R5P4j95
	 LX1wPsw+YSI7WG17vqcVvvyp0+Hm6n/eHES5ecUMlAZ508xeUx3XmnODT0LgpJgN4PqbH
	 tTu9rIkumZ3IjPbCVL05dlZN3nkR9f5u9QaarEqFtxL0tcwhT0TQ44PWU2qN6nIOljw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5FJmlfLnnVicFf7gaLIa4+dhDlQzv/f7mdEhi2RvUz0=;
	b=s3wKF00RMCsoBmi9pCKa7SKelEN/TR9JlDnKV+Jcu2us0Xl+RsxVkstiwlEu43JkSfAy
	 ivM2XG9etmdRTAuAABrk8Kw7/OGRIKUwmBGd8o6MD+7fHZOn506OQkw3y0U7OK0gyqOkZ
	 Gj1IPQkG8jPPBouqsjs5fgGX/iKUqf6Amjo6wTtwoZ67yhLTdUUUJNcK2i4XAp7VInu2n
	 L+znJ3x9OtzkLyOnYg1ZyBFCh7lcVmp6o9k4UY872O2OEQBqW9vFTEsGsplSTsZHzZtom
	 gfehv/z6HszPlGNIuPjBbSsof+hlEM2ffMA2oTeQ6dGUfWJKRVK7sdFGeseiD1crrLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGsesSau;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE4606A331
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DFE4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGsesSau
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b0dba37a7fso17369317b3.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616195; x=1795220995; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FJmlfLnnVicFf7gaLIa4+dhDlQzv/f7mdEhi2RvUz0=;
        b=yGsesSauBg8ugXxEZJELjbKj0XhuO+ZE9k+AqceV7gf3rX6AqXVArhfNkK7xQmuhVE
         2uSykHWf/GLgTRl9DKgPdnIGy4j5cAgR6Fi8PAaSPSiZwljypyBqHY0kUCZJyW80It+D
         1VxAgoE6R3qkKgJNhaRs+MezUC5MhSL1VHNzthZdw/ZuoBWRpVhOhpesCS1AJfzo2AS/
         GutNhkUIA3YoTqOmiVC8zZTL28P9V4mvNil1ioRGyMu+NvdZU+qjOEgH3OQHTscz3c5d
         UdEahu+NAcXkS3IC8fqO/CqB3u3fqKZYQYaXgMU9RobpyNew4d+8INwFS8aaKJfqEI63
         sFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616195; x=1795220995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5FJmlfLnnVicFf7gaLIa4+dhDlQzv/f7mdEhi2RvUz0=;
        b=K0ReDD06n77e98ieSFcG7gwKJpp5l3tTrJVL6dyrSNpAg+p+yGM/LFnv2dH/Fepdth
         2I6x/f9op+oJuWFJuz0+jcWQqyNf0m2rw8iy86IBzwiKJbc4LqEDWLwYkKEiDYsKyd0q
         Lr2b3oGt9+ULpcwk9kt063AOjMvz8VkwAAkqQx3bTOOTTTZO1uoyw8rTNbeaf7APtfYK
         1Za/aIvxCuex9eJn/5wp1ATgur+QWZAOBhn3/ZjZ3zqWogAZUaM2p1kXfW8Rz04tlkvb
         wlX+B2b9WI6MxwpSaZN1g5JfOV0z65I7FNUOQfNgPVShUuF6EDvPcFArKyf2PJKPrAAI
         b2tw==
X-Forwarded-Encrypted: i=1; AL+hErHSoztrXbOm2kO6eGQvmK3aVWs+zxiJAItmBb5+wlk1wx68wja1ttRzFlibo4aS5UitO5s/LQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9eGppiyOD8bR2TZUCXXync6O9s0MylSVlrwXAA13asojsbiGVn
	/5aBFvC7gssq72eQi0ORLnU9OrWNW20Eob+CkeA1jZ8qVTy8jufUgKGN
X-Gm-Gg: AYBFou27n6mfJeqkvqGU9KQgMsiGvTN5d4sVx2+aNYt1D2FUlA/43iW+5UpPEtmGIvR
	1E9IeXmOmtpNEuXDC1txAyxXs88Ey81kyH6a3z4ohF74JQMPm/YWtEuzznVUXieh/RXvSDZsBP9
	YhLMxSPEBW0yaQpiaypXURtBlBcGoQjkmJ1HCLgDsp5rXRV2fF2voAsnVdX0pxeJ4kfxFYWHa2T
	HkTW+A1VkAMPBhnN819vFJm0aQ8Kcue2pnv+W1sM7rb/4fVWuQTJgsxZtByp+Z1ZDD+c5EYPDEn
	NpMCGMhRTD8eCiaJkm25EeJQNlx0GgWs16OWT2HY4FZyknCiAioMsOv65uPuaVANR8ZE3Iy0ROd
	imLX3kAGEazy3OUWkri83LQMBIMEsAKOTwU4LreiHPna/5CbgT0SgJ+2HDHijI+KDcqqEIMhbe9
	yfK4LOan88iry2YU5dOcy/i7jUR6xCnVJxIAXcQsJZJkuHxPWmg+y6lJscEGb0+5/788c9wVEbC
	PJt+NBbCzK1jMmFW+wP4JwG4d7CMTW5sMVJ6yIh412GCzloj4Nsk4aN7Kfjs2DjZNn0B7JHDDg1
	+q4osYeU9Z9X2ZMOrcsubhNlDNNUO8Db0PPzV5GtiM7WPoBf3ZUD8MvNOG+vUJbV/hMM/2AAmU+
	4ZpDsIQ==
X-Received: by 2002:a05:690c:3181:b0:8ae:1acc:ad33 with SMTP id 00721157ae682-8b4aa305fd1mr20901977b3.58.1794616195554;
        Fri, 13 Nov 2026 16:29:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa958d0asm33763867b3.22.2026.11.13.16.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:29:54 -0800 (PST)
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
Subject: [PATCH v3 1/4] mm: zswap: fix shrinker count for the root memcg
Date: Fri, 13 Nov 2026 16:28:19 -0800
Message-ID: <20261114002822.1043378-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.1
In-Reply-To: <20261114002822.1043378-1-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
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

zswap_shrinker_count() scales the number of freeable entries on a
memcg's zswap LRU by the memcg's compression ratio. That compression
ratio is computed from the memcg's MEMCG_ZSWAP_B and MEMCG_ZSWAPPED
stats.

However, for the root memcg, the zswap entries owned by the root memcg
itself are never accounted for in the stats (obj_cgroup_charge_zswap()
skips the root objcg, and before the root memcg had an objcg, its
entries weren't charged at all). The stats only reflect the entries
owned by the root memcg's descendants. When the root memcg's descendants
have no zswap entries (eg when the whole workload runs in the root
cgroup), the shrinker reports nothing to reclaim for the root memcg, and
its zswap entries are never written back by the shrinker. When its
descendants do have entries, the root memcg's entries are scaled by the
descendants' compression ratio instead of a ratio that includes them.

Fix this by using the zswap pool-wide counters for the root memcg
instead. The zswap pool-wide counters cover every zswap entry, including
those owned by the root memcg.

This also gets rid of having to flush the root memcg's stats, which
flushes every cgroup in the system.

In a VM running a reclaim-heavy workload in the root cgroup with the
zswap shrinker enabled, the shrinker wrote back no pages before this
change (zswpwb stayed at 0) and 1016 pages with it.

Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Acked-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/zswap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a2e0314db1cf..6e1cd3e482f7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1330,9 +1330,12 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * runtime-disabled: we can get sc->memcg == NULL, which is ok
 	 * for the lruvec, but not for memcg_page_state().
 	 *
-	 * Without memcg, use the zswap pool-wide metrics.
+	 * Without memcg, or for the root memcg, use the zswap pool-wide
+	 * metrics. The root memcg's stats don't count the entries it owns
+	 * itself (obj_cgroup_charge_zswap() skips the root objcg), whereas the
+	 * pool-wide metrics cover every entry and don't need a flush.
 	 */
-	if (!mem_cgroup_disabled()) {
+	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg)) {
 		mem_cgroup_flush_stats_ratelimited(memcg);
 		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
 		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
-- 
2.52.1

