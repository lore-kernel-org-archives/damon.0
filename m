Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616202;
	b=EqdjkxO9VmW/L+zHha9yrRbA4z5NnhjNwPFhKiBWW2MBF0wonGVTLi2AtTLr94trMW7J
	 OKqxkpP2fqxL4zGaczPBmYR+NOmH5m+LP8CwsOHUfvrLARPEZ/+gu0gkARvho2DlVitux
	 3hJHTk6Ap7eSseeluLOPJsyf0T8BB3+LWWKr8pi3+UAalv+o6Ke/P7v8Gw+jzxGQEV8tX
	 rHw8egCGIzKS2QYMmsf4jFmgjhUYUeZ02hkG9ApIZXdGmouBiO1TbmeiUAQ4c45oE1xxL
	 tJjkS+2Gy6PYltJXe539xhSpgiWnta7leol3skzMJS4LQxHpj+W7ilsWT/mqjr+P/7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JBroOjocv6eBCvG1grylAnibv/9seMQfy8rDwVLFt1I=;
	b=x5pf13ORDTsAgXbE01hfoUwySJE576QnGtNnWicnad8s8A5GFLAnLfPO4V/wa/kWmC9w
	 YWMZiCdwUf5ezAysyEWlO8QFwcwrfR94t29c114h2KyOLuYJvhUy9wyqU9ILCzi1a43A1
	 DgKo81ZrSpZz+ME5z1MYGDo5kViVTCS8sHXuWn5R+sCkqf2LsRPnkIZmqeJ8UHwzZdFPC
	 CSsrcrpm/30bVqmMO+rgOOGcRV/+QwXxSbeBelolnarBDsvwzgBQaB01iKX5xgnHGQCod
	 fU0SjEjTE9FJEb2L95uJVg6q4gC2i2DopUi+FNtr1PCRaA8xFKbeRgLzkE6y1DV7GFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYHWIhOa;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4984606A338
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4984606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYHWIhOa
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0dba37a7fso17369557b3.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616201; x=1795221001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBroOjocv6eBCvG1grylAnibv/9seMQfy8rDwVLFt1I=;
        b=LYHWIhOayeG2SGzDxv9ByCoV3HtYR7GyDq96kjB5wzuUFeKjQh+EjWPzWRrhOVNjr/
         XdckKWpmfEoK7boKP2QB9XQr1rQY2NrrhrnmLjypmlXZKRV+55AcLv2lm+AF+czOx/qD
         vMmBAYcf7qVot2WF3ki/pxylJRB47zpeFJfPzD7GcjxugLbWdeg1yLTc4Ut7BvbZwvky
         rnvwoicgQeptexe6jreRSPHC3JayZNYxGMmp4mnj2R0LSutCUlPl01mea2mjukkVST5j
         ROSH1jcJLmIv0gpDwbwCgeNaeuIh/lxVsrUggYbm/OLxHwvt7q6IX2kBeblNtEGqFa2h
         MQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616201; x=1795221001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBroOjocv6eBCvG1grylAnibv/9seMQfy8rDwVLFt1I=;
        b=Am4MMl4mkK11zW2QXIGXw2fjwoG5Wbj80U3DxMWGklyU74OlTBRp4xwp4dXAvs+yqN
         jk9MyeZqMYwfjd6tHUnvyPolRUmCZqiPb8vpHpgiU1DjgMS92N+9CFvtWuNnZYH6uiwW
         DusU3EhHvAtI2nRwsG2C7Y38eYpkJQ8cxZLERGZ7WqKZFjTXHGh8vn7ofhYXQ6Rx0CYz
         h8e5uCmKcgFXhTi9jYWfVicwrxarB35P063RLveisPdEJHuJlGckCOsfKW7g5jcnD6rD
         UA6/UmR2rmvk0C3ZHRzPAHTur47oB93ZoU28J2WUewUOxKK0eGnj6DeSpwp5+rd5PWfU
         qChQ==
X-Forwarded-Encrypted: i=1; AL+hErFtjGeWNOwICs8E+cn25vDJ4tnLbwdj5ISkjScFHcZRLaOgFoYKnRvdOYt6Rvash9X3po3EGw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Eaj9QmLKbuxAR/vYId3tcXVWXRYAEsrJyj9kDI8KlRq/OCYks
	jlUNDDNWg8qkv/+e3VVW/PZyh2yacRs+S6R0qbSjdRuaU3gLwdz+qQVe
X-Gm-Gg: AYBFou2BNIx6SXqVFtlr+J0lEoryOHj7qhnktIMKOd5gh22YPEsRplHrM7vGHeMhkHS
	AJXRCQZdlxvouFhsLQXD8YHIKSOwfvtwSQb4JNDY2tMVMwnSSZIXprBM9H7tTBAPTTVpRl32KKq
	MW+AmtRODekwTP/EoaLzd622Wjlo4hnRJKiryTj7veyqVlHRF/HIsuS4CRJxxoZZFuEqhTz8jn1
	8+xLe9fHkWQVSAx31w7LazHD1xVirUUEEUDzumeZYrjNeuHypPSLQ2LL9B4mZkVF5gd0bYfq9if
	AqKuA//CfTJ8JfWJNAHjuQpRd2FaEw/2JPuJQzBV5deLjMGRe5FEYYrQU3aS0R7OUehMKk8FIGF
	hsMiH6c/TdTa/HMdAl2M/qhoWezfAJiO83b9c5pW4k+S1tCgGx+4iswUOHH12ohCnZkGdjHQDNd
	jR1pFXoNg9fj5fk4yH+Tls2akyR0ukSlZIg2X0SdObdPkutE5zKX3EE4M7qx69O12sCDpzc8A1S
	OCLVVdJy9DgNhoP1osDj8j6q+WRTqbL92eSdP7hqCnckpeUH4ZRIl0TZkilPJgf1dFdLDl7ePVr
	+lJPfDcg2N8X48w99zlKa6OOK+9sIPk3nWwlXbBDM4L6AHA3zd+jsc9YMnrdLNwjbaKFDL63q5V
	X9U0ja32V2AlQbVTBeFTdlBe/dss=
X-Received: by 2002:a05:690c:e251:10b0:8b3:23f3:134d with SMTP id 00721157ae682-8b4aa2b33a1mr16832317b3.42.1794616200944;
        Fri, 13 Nov 2026 16:30:00 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa96b441sm33820597b3.23.2026.11.13.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:30:00 -0800 (PST)
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
Subject: [PATCH v3 3/4] mm: workingset: skip the root memcg flush in workingset_test_recent()
Date: Fri, 13 Nov 2026 16:28:21 -0800
Message-ID: <20261114002822.1043378-4-joannelkoong@gmail.com>
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
2.52.1

