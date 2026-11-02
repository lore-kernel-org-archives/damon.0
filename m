Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659861;
	b=wJB7gJMeALqoX8K4DsFFpQ9/3xxQJNuHrEpni7obKThNdlQsoIGElSPMw5A2rCrLqyS2
	 ldhCwlg7NYzSroeC145eIL/CBhvsq7pvUzeZ8KppJHBsfxdll+//+BM8VJoxkl1Bc5WSZ
	 SnpY4BivowVHMegZOl21Wo5UpBdpW2IlvvuOmvtNYLM6+caDddAPEi4r8PytFoWw1ySKC
	 KbJdXXKd0RyME4uiLCHIeFNJE0UyhjumbARE4tJKrJKHwQPVEAAtbSEtXGs//EAE2VVPB
	 Yd5Szh8fcABTnLME3F/fNqSgs92m9eBvfP6C8JUh6EdsejQwYm45wjTExnUWi+9S8aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EN7S1V6hsPYuJ8/hHPqk/DKDGgJqqDJKvPrCgDVd4b8=;
	b=Dz77u3a+KX7+t+B2Wh09tTT4jKOUXtuI5FY9y7QL+YSfQCr1XSJ30oB2OpiApbgw5n3g
	 B5y5eDFTFl0UpUAyJLy8qwVAi/LeMnoPd1v11NQXf88f3bhsavROqPNbBSJcUfdS/Jc2u
	 tlIsGCT3wd1RsSFxcenZA6l/POWSwjH/omGFsRX4xThA8KZh0xafQlmFaDEBxZgxOIoaP
	 9pbEi42a8wiJa0nrBcH/cM1yXkuQYgiPlqFSXkn0ZIgYyG69uEAk4h+4w1xRb8RkIpoOq
	 KCJ155dCuGU5KdF433YWgHkMZ6we1N8hJAwasKIWFO9tSj1Ycd5OL+7nfjMbjEAJROA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HP/tkSqj";
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D09606A326
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 22:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D09606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HP/tkSqj
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab395abf79so30966907b3.0
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 14:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659860; x=1794264660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EN7S1V6hsPYuJ8/hHPqk/DKDGgJqqDJKvPrCgDVd4b8=;
        b=HP/tkSqj141l3opOYJqNRNJG4K2TokzTNzQwzCzBY00ur31OcyjWT1K0BToB5ITVd6
         b18UeuOAbC7X0KlL2Q2ChYGEs8KVHBomKisJ7IF2dxF3SHuOkCNN0EJu/PDzeArLhq40
         871vp5/mT4SmbyKJW2ywYvHr1M2CkTCvAWqQY2forUszZuA5WzYnl6zOfblqgyIwZwTF
         +LK9MdhP7X1xocmTHBqqxSzEIdxEq480m+ZQhiOnsnGvheH/H0c4STa5f+LBComXz2Ty
         1y0hfMReZVX2cBh+2VaSqSm5ffiOKNGGNislb6hn70Wprn8ouqZ4UJ8hds7kVdKdfWhI
         tBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659860; x=1794264660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EN7S1V6hsPYuJ8/hHPqk/DKDGgJqqDJKvPrCgDVd4b8=;
        b=quxeowEoQ+9aAWmpkMYbCiq8cUSSgDEH6841y/bLrV47C8E2NGDcKW7hh1q5wJ8fQl
         wyX4BA7TRiIo4tWbRsHOhYruSlzIxSUOpBaCAQrRwIAZ+QslZFQ75SoKMoaN5zLdX2dV
         858lp8OS0llT0tF9b3d7RnD+vGtk3G4iuzSSgaOWcL3+wxjDR0JvE2WugFjYmUGW/3fD
         CttmhG0olyl/NYZlSgjYLIJj1d6xBulHNifm3QAggVPcTRx5uxo1Qwp8LzRmAvayyNbZ
         8d5tIqNYk1l7h75+/eGnbk1mlZNV2zDGyNH7petmx04wm2MHAkYpvewFHEaTOPkva7IM
         NBdg==
X-Forwarded-Encrypted: i=1; AKwUvBzEzG9jNHBO1dDn2R8wDIIpxrlWFgkE8etaqPtmK48q14qXyXmgIlick6NHjTOutsdT5+x/mQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z837jpoPN/AtVxZdOUOvWib9RxaydMzpzZ0I8RkKNqdEJEqI2vM
	WG7f1LQS/M6+Gshl+8kj3I2dxL/FmPEqDCXKM0wocZ4zYN8dqYRJ3S3+
X-Gm-Gg: AYBFou03bH0Hj8F8RFBQuDse08nMwIvFY3+gjGButIwGX08uM+XN5B9D0Q7sP5xtTOq
	DvOKOD+I8kUL/OxRXAIHlJB7JfEnJXHQRK4glDEuU4Wn51ET1GmtjmdIn7qSFe7jJYJt5cTOFfb
	lOj0p8JTtkbCLBmmuPkhg/MmRY6j2vc+5UWsxWVfZdqCeLk6SwwzQ7P0PPDmSTwGRpJeuBBpG0p
	ZdyP9bD6ATjS1JqKJDg91+165qmsUSrHfB8UcqVvlVnQ/aOMTLPO8rIoXxDonixk0FNf/JcmlIZ
	Ru8TVkAryxMDAhTS2cZ41hWVZbtN5+ynDgMKmJ6Pt+E3jSnOeoVAxH/XomcqDxgS2I2yxRYS49D
	lMtwdCvuqaeb6FMWNhq0JiuyK0O/l/YLRtZ0U0q7j0dR5iVPXbVhhfjl83GAV/XBBNd5mtczUJA
	MM62sVWruQiZvGKs6wSjf1hM/hlcGBwqlZeHuswDLdjXrJcPuDHdbu675w4S8/PYg+fro9Hl3yg
	TjcN2yfcnBgm4+sUwgDPfibiN6u7yNy+LwNL3Q9PoMzg2kSSv3aexhhEB8xFdQrBlhySe876qlC
	iVL92bS3jcT4bxDdk4NrGb90bJf3uzgVIC7u3B31NRJmh8CeG8GwSqvbADQrPMIfQaWDjhRe1Va
	PxWjo1Q==
X-Received: by 2002:a05:690c:dd5:b0:8b1:7072:a61b with SMTP id 00721157ae682-8b2b67323c3mr92119087b3.22.1793659859510;
        Mon, 02 Nov 2026 14:50:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bdafsm61225847b3.19.2026.11.02.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:50:58 -0800 (PST)
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
Subject: [PATCH v1 1/3] mm: zswap: fix shrinker count for the root memcg
Date: Mon,  2 Nov 2026 14:50:28 -0800
Message-ID: <20261102225030.2743129-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261102225030.2743129-1-joannelkoong@gmail.com>
References: <20261102225030.2743129-1-joannelkoong@gmail.com>
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

