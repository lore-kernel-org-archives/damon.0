Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275633;
	b=iybEPJu3aGKDvovm9UU/H+ojgmJbHjWvtwd5j9O7vmuO+4HPYlPylhueyBF2mOQWk+dP
	 5jx8CrvaGqb7mIDif2r89N/yNxcunz137H5jsy57ysJksRQl/A04+f9ltDclh+ddtRVlS
	 +KwedqA2smeJ/5IPU3i8IakqynRWPzxiE6tFO00tYohmctMhJlXGHc/z7IZ6pC5O8bFSq
	 G83/vnsGJ/h68X/mujvg5FmrfXY7Bu44sG/WKP9ONB67qPE8NT4+DrPsFyyMqLJM7D0cT
	 FItjnTmNaVw5yg5DV7hgbMYF/O773PUynPO72dMQQWsCp4DrS3FRbgpLsQfNUj2iNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GdLDSDC+vsdZUjVsXlUGs2pDDNs9Duz5UHyhjDf0AK8=;
	b=m52MNF764fNXAGD6N69d6ZqtPMGL1sr+4Z4HqKxoHrDtgRMqrmSnVKfJpfucoaWGHazk
	 7QFvDjI+6Mb8sRkA0r92vWei6RDNYpMwHsll+n/x1/ObtHvUB2GR5fNvJm1rd/Dx+ERXd
	 8SBk21lvwez8/8SOGRemGdHBrke4QTnn9dnradQeug1y7takl8TG4wXQuvVeUtJKFMXCq
	 VY+fzTJQn9aEcYqqgcZfYGgIJZNWcIhbcQ4T5IyrYxJM+njcWS/qbOUkO9ycF7luhH7gl
	 C4QCn+dyUdigjHPS3dE1tUv9A2i4al9o2WPED5Nm1AK1ARN7dBSwXJuNXtxzyM933cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzH2DKto;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE63606A325
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE63606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzH2DKto
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so1010042a91.1
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 17:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275632; x=1794880432; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdLDSDC+vsdZUjVsXlUGs2pDDNs9Duz5UHyhjDf0AK8=;
        b=qzH2DKtoPM7BAFImCYMMLfMZH4GA791dH06UJcI/GpLVsnHFDoush4+5igw3DZYS5A
         I2cBWb1wyFz3xWz4zGE/7NiRJP26dWa6ZB+N3HGDgFgulsm+uttGGBcEhIW/r3nZisWN
         jNBktzAyGukAMRw409diu7Gi8nX+lKi5LSQ3D2YdlpAYsU8Z8i2YgGdzEvgStOdAB/BV
         qQ5ihQSJICZydY0oPtGepzqek4LB981GKaEljt+v79UE9OmIuGuDIBAwmpmlyuj4Fk8X
         eWVW6nMQEeVuU5Cn6Q6qN7Sm24YzXslTIg62ITzlgfBJY6m4aWLpOKf9nhm5QHw1dPzI
         Q+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275632; x=1794880432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdLDSDC+vsdZUjVsXlUGs2pDDNs9Duz5UHyhjDf0AK8=;
        b=dylvFnDE2ERGtmV6JXMTwDD2xrcpQpYmwvm2gagDe6e1MFU7+HVCitvV+ShVyTadOs
         X6Oz5tGLmt21YAs33GavFqpGQNs6ynttWst7GXdf5s6UWE0Z3InTSIRIk8PlpEomtnAh
         n/QuMirBaoWag2AlxO0iUFfzxJuE+Vuzg7oWLvRiucJgmyMqmhsL+xoyvMy/XV+gQdlu
         uW1/Y5cP3toLK9BEQBw87JQWwMfZeJCOcAmfQVh21NK5SAM7kra7BPdjQxl2AZ2aZLRm
         zCp63PCsmBWer0z8Af57O2iQ1170u6941An28DP/Xvso2NGN02p7uV/xm8kZlm8LNeu7
         Vidg==
X-Forwarded-Encrypted: i=1; AL+hErFWl/jRcKH8+DoUgwtd5MVHJHC4V1emabYUXSLgxwfdWDhAnTODJkvGs7do4vrxDbhdl/Moag==@lists.linux.dev
X-Gm-Message-State: APuU4Z+BEtdjxUSI5Nut8QmcTnClia33Wx9r2vh+MnKEZ3OsmgJ+cBMq
	BdlfZm5pG0w4wY11k86tJysybYK2yhnIOYw80zHXWxYThJpCzBII4Rrh
X-Gm-Gg: AYBFou228n8xt1f+5ZsDMuC4P1yq3znoG16GyUpQrnfQzwjph6l/v2JqsYdhMAlA1yg
	z/PFosmm6+2p1gewjN35hA7bxh6XU53f7VltZnTYoI5gZIDwrtnt9+JK4H7WSJey1FTwvfHyeo7
	cCCcETU4WvNDutihUQqbqrXFAymTNedTEo8HCGWaNMKCwgDKyyiZulKq7OF1LH7BJc1UI73x1dw
	1noiqgWYPdS+pxUhrKF1SGbVdkeMHOXx1b8RSdN04lmUXZw8Yp42dj1KxpCtPqB0hvdIP+jAa4/
	5sw2OQS9hHJy9DX1Fkc81Ehl0u74hiwy8tWDz/+8+Zz5hCPboua7na/5CEBqbo2x4NedTfhqMh2
	Kq0OSgdtWEcMEYONjHtWzEVW6Tu5rFm/izSG1wt32k9FtGTz+NNnsuNNL8J5zUkXtGo4x/U8kKg
	GC+ncEiIGsRxxnkZ3c259qVrQ4h8WEITioKWpJoKlGf7aV1RmRoFtUBDyByCs9bGBOS7vJjJwWo
	NbBC/lnTvHMMf6sWkuG1dooZpfj/WSn6nf8VLl+AWLG6Glfdijb93sBiolojSvuA6eyPnS+mD5p
	FpqOTTvODgfA+ITnpSTqlwyyXkqeMfHvFG5hzEUDG0Iper7e/olhKSXJUe6XiAyhB8GvYsL5iS9
	IoZw//w==
X-Received: by 2002:a17:90a:ec83:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3b166cecc28mr1377225a91.58.1794275631979;
        Mon, 09 Nov 2026 17:53:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b167970669sm1564096a91.13.2026.11.09.17.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:53:51 -0800 (PST)
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
Subject: [PATCH v2 1/4] mm: zswap: fix shrinker count for the root memcg
Date: Mon,  9 Nov 2026 17:53:18 -0800
Message-ID: <20261110015321.611093-2-joannelkoong@gmail.com>
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
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/zswap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37d217860a6b..c11cd2a6e24e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1332,9 +1332,12 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
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
2.52.0

