Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659866;
	b=x9W2hEXatoCJywe9hl+PEC0ayN0tqEWI0tc4gFn2VQsjNRDux9CtVCyrAtqYWMqrKuAM
	 VS9Wpol8d3oK6d4X7hArCyPjOj7+35knI4VySnKOZ493zLBnfUfm614qiroDx2463ZnSd
	 YizwrF4TvtoUpyA0gRvaSzC6ljkk6yEOHTCUMmCfvSF9amxY0HYm4q6YICxcrflKb9J8x
	 xcQtYAL5y4Ge9tPliSMkMy0Aog1jloGifpnCECZMANpmF/qw+/y4CjFESHWnsY+4+XAun
	 VeoGHE3pevRnccoReyxzVW2z9Zu3Fw4NXwMotuh7t3edshbKGG1Da73rqLFaorl0z5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YsIHlK7moF+Sg9EM5XQG5yakBii09xJE59b2g1kveUQ=;
	b=Gga/153sOshuTS1lJUo+ZRpGULQJdGjhBjpS4va46VvxkrvLI1OLvn35oWxKHU0wTYT4
	 4y4/AWhhiufM9Z4YtWCIh0ixgEJrHbXU3DlSYbm5qkK8kh11BIQf9jYPxQMwZh9SnXFvs
	 FoV8+xqCO5k2pRTOoCItqAEIoy90IeRElFfWozhcYQBMRBXSgFpZufqkqjXd6c04ZgJJj
	 SIJUKmlgGW3baHVjEhmGhdLiGl4jPk1myUImF+IHmw2nWGW4KAkkmk0ov806FAb+oAd3Q
	 faBVDuBoxx+hIr4SXYKRgY1Qwk7/R7gmkvRv7PLFY7IcjDioqEsmM+MY70iZY8r9TbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RMT7xhbd;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29640606A327
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 22:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29640606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RMT7xhbd
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6798d4ab549so3283825d50.0
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659865; x=1794264665; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YsIHlK7moF+Sg9EM5XQG5yakBii09xJE59b2g1kveUQ=;
        b=RMT7xhbd1DFre/s5Z24UevsJ3Tcl9TCYFy7vnGGQzz4lMeItqw85xt+2CKRsm8j6b5
         gZi5ttQaKnhGhB+CUgzyEU56Hpv55H/ZHDmF7ebUSUH8tjlQXKTu3vr/Zb0iNQCIV/fr
         +q5M/+32T+LsOtWjbx9ePyFelvrgdS2mehHLDwzAvVmWxfZo48Oahk1V1NZoTm0ZcC8X
         Xj3K7uxkZEi7zjaiIJp/UhdETddjysb7+4RhPLufpuqLh3Dd0u+ovoir/xG6I6WO9wrD
         Z9Pq/Zd6xghemXzmXsig7JA9XEtXsECkAsCFWFgg04JHqwbvccWxUtx1QJ9pLRi5CY+C
         HZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659865; x=1794264665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YsIHlK7moF+Sg9EM5XQG5yakBii09xJE59b2g1kveUQ=;
        b=BHbtxXuIjxtbkA5J1UgV3jUJd+NV6hoAnfGay8/1dzi5GGowxoRK9MYgMkzBhnSw8p
         /GeQdJKaZushaBaitmTUXT8HfZ2hi/ULMSRUd/CLgzT9+Z/Mx6FrUmdEdxqE3bePYv1Y
         tVBk8fYzulCA7vh/vKHIgvf3QBmBEw9ANbSd+zpp4ZJR4YnnugMkY7mSqaaUcpkUXFux
         grY+sroadJs0Fvm8ufZ3XVTyuMnL3qKQ7iQ4HgW5CyGjY77gmq813PTM0RGCj5AsdD2n
         MEWgvbu6noUujxTvYB3rOQMlqmkFadl6EpuRRRvTicH8KSAk4xN875yCeDRazwZ9pi7D
         0bHQ==
X-Forwarded-Encrypted: i=1; AKwUvBx73jzasUs9lQj9BQ57nFIN8IZaQqBjOlDMFSdcxN2v+6t6esNi3vR4pjJCIdaFS9wv4DCQsg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Fo3LqsbGgxg7KKAMyrWYnseQ11oBJcQMMfL6L/qxBVHSXlzUi
	lAjAbsGswaj6bL6UYlJLFmkDAgq9CRkg40ih3HkVMANkXtGLjCGmiY+r
X-Gm-Gg: AYBFou0SF6bpILUVgnZcrFqccwLNitSWlHBgGBVpvDJHnja7zyMtj0bET2DtrtvdRS2
	fwTSsNgFUG3Z7BVeAupPMnM39rQqkq/UEtILo/zPuJ+YgJN53gy45QC47VslendPgKBywQWGO0j
	nYo6bwp9VTf7GWzhSoCJDGvoYnTDa9AHTcR0Q0COeDCLLFr665A5NP7B3u3eUEMihlqDYZicKY2
	DIKo6LRZ6VTE5J1EWdXgrb9lyo5MWRcj7yXn8kKI0hTf7alyHJXgY7/s3DbtMpVl7q0d9M0iU84
	Q8f13Zax5yQSBBcp9XHGwZfZpikANXQ0KmBZDFZrXFwmXg4nKMig3ZdyrVqa1bQNrl8NddVsOIn
	2lcrlQ+sgf7qmz+PRWuaeWYJDI+y//DX6iiTFUCWrsHUZA4G8xoFvfe4mcpiYNdWWRdTqXyDzr5
	qWUikgbaBGmqTPkifi0NIbsOt8kW4rhlINAKaTt7Frh22shAaAbJ7oYQM98sPOeEo2+rua1GLY7
	qagwiu8w5q/NNmcsZ1EVvPSuP0gSAtJiNlBkohqb/iA90ALvt0PNLDcEvbtfdI7jymmoIbuzrD9
	ORLlMIWbH1w4CNQTUwwMccFp/NKn6hVgtTI2bqt+cjBjjgTelXaWyMtVQnk+xbbsiyccPTbck/V
	pXAdVRz0cqthujCANnf4a2Lx88Mk=
X-Received: by 2002:a05:690e:14ca:b0:679:c4e9:b645 with SMTP id 956f58d0204a3-67ba4c90a9emr8088319d50.4.1793659865073;
        Mon, 02 Nov 2026 14:51:05 -0800 (PST)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf2b138bsm5940925d50.9.2026.11.02.14.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:51:04 -0800 (PST)
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
Subject: [PATCH v1 3/3] mm/damon/core: use node counters instead of flushing the root memcg
Date: Mon,  2 Nov 2026 14:50:30 -0800
Message-ID: <20261102225030.2743129-4-joannelkoong@gmail.com>
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

damos_get_node_memcg_used_bp() flushes the memcg stats before reading
the LRU sizes of the goal's memcg on the goal's node. For the root
memcg, that flushes every cgroup in the system. The flush is not
ratelimited, which means it happens every time the goal is evaluated.

For the root memcg, the node counters hold the same LRU sizes as the
memcg rstat stats, and they are always up to date. Use
lruvec_lru_page_state(), which reads the node counters for the root
memcg, and skip the flush for the root memcg.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/damon/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcb6395d9f66..61d92e572c53 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3049,12 +3049,17 @@ static unsigned long damos_get_node_memcg_used_bp(
 			return 10000;
 	}
 
-	mem_cgroup_flush_stats(memcg);
+	/*
+	 * The root memcg's LRU sizes are read directly from the node counters
+	 * (see lruvec_lru_page_state()).
+	 */
+	if (!mem_cgroup_is_root(memcg))
+		mem_cgroup_flush_stats(memcg);
 	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
-	used_pages = lruvec_page_state(lruvec, NR_ACTIVE_ANON);
-	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_ANON);
-	used_pages += lruvec_page_state(lruvec, NR_ACTIVE_FILE);
-	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
+	used_pages = lruvec_lru_page_state(lruvec, NR_ACTIVE_ANON);
+	used_pages += lruvec_lru_page_state(lruvec, NR_INACTIVE_ANON);
+	used_pages += lruvec_lru_page_state(lruvec, NR_ACTIVE_FILE);
+	used_pages += lruvec_lru_page_state(lruvec, NR_INACTIVE_FILE);
 
 	mem_cgroup_put(memcg);
 
-- 
2.52.0

