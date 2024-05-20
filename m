Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D8136E20
	for <damon@lists.linux.dev>; Mon, 20 May 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215469; cv=none; b=rHw9xotxUSuzMi8K2NEJetYKi8HJRJBv1Owf2GWeFQ9J9k7Q/Y7NakSNKWNX7OXNgq0BfQKdUEiJP/KExloBlxYPl99UvDYA3EpU6oKr/qAlqJeeHPjaZVxM5oMe+gfXOk/+l4u/aLMAowBEolu0b1BjeHozcE7LCQF85ozuKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215469; c=relaxed/simple;
	bh=Vark2tHasfjiq5qm7fVNYZJGTwQjSUnZIgp4elkLUqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otXcPkZZKzVd+v7hcJOsG6vTLjF4fqXYm60+7Y3AkXprxVvT6jPE8MlvxP8Qa1faZmbysG9bdCvgDofbvvgCRF/ehdw7lvJu1hzeAP4hf1mkZK9tsuYFDoSh/LVhBYsJp+vEOMhIB+rR/wnZPQPcsf95z9ZLqESXIqieXi4ngQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=vZtOdzg3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="vZtOdzg3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f47787a0c3so149917b3a.0
        for <damon@lists.linux.dev>; Mon, 20 May 2024 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716215466; x=1716820266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNZVb3aalyckzv+MvkSwf98x3ypuajbAEW8swaTd5w8=;
        b=vZtOdzg3N0m+s8m7rtKUiJCQg/yx4jitt5TC/oDUL4o2Une36YKqmNnt3RNYbD2oBx
         gO7kL4mRLa2YiCG4P1E5rcvzZNEV+1Z1954IZ7nEKt4hTj/sCYhu/Dq0KywXHpOf5Slk
         L5sSjJqNzdCr+U7T7eYqUfU5I/BzrV2d7DDqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215466; x=1716820266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNZVb3aalyckzv+MvkSwf98x3ypuajbAEW8swaTd5w8=;
        b=QEpdd8hrdZQoG7EO8hOvrHFjQ8Du0p3n5n2tIlnvc+TSov2ctvDVbaJA5EKalaFWS3
         m0QLfpra4IRVaun4yixQHhDSnXpKWeY3ATQAGNsk0gebKJBTcrlUDJAMFjMZ0wVwlUKQ
         3BMgnYN5t8HMfvn2a/5eC5OoeQwtCEWGfQT21srw4lnSil+Tn8q3LugycnyvbLFMjM7t
         Zmxm4dIDkNMEP+CEDTH/VENFPZEh7z9cjgWP/6lsuyGf2rVI7D+4iXupfde9qXbZXXwl
         SHq/WbOZc5xjHxmBZvp81lux7i8WrXToF/G6bFyBE9NRoh4CDeBBFF6FS68epBBnXMWB
         0QJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4dvdebCXwl/AONAWarl/8tEdEkw5PKYl3hGpxfpF9RSmYoE8KhhpaNUuXLes/1MYz5HsIkSWaA5Kjk5qP4Wzbtb79hSM=
X-Gm-Message-State: AOJu0YwC7PdYTbL1wcS27MHnihp6dTgz6sXMECq5dqNboHZTVKgZ6LBD
	BvQNTVf9r75c5G8ESEfKz556QQQgHvptqN/ue4VBomQ4mcnY7dqHE4nUMX47kEU=
X-Google-Smtp-Source: AGHT+IGTqWX6KLCAkFgNmkNZOQ7jdXH7YUcuBwf3ViNWwc7ehoGXbRn6Xn9m06QND/xMKX5Gz7ws0g==
X-Received: by 2002:a05:6a00:b4f:b0:6f3:b041:716d with SMTP id d2e1a72fcca58-6f4e0296f83mr37942698b3a.17.1716215466453;
        Mon, 20 May 2024 07:31:06 -0700 (PDT)
Received: from swarm07.ajou.ac.kr ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm19714531b3a.96.2024.05.20.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:31:06 -0700 (PDT)
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [RFC PATCH v2 3/3] mm/damon: add NUMA-awareness to DAMON modules
Date: Mon, 20 May 2024 14:30:38 +0000
Message-Id: <20240520143038.189061-4-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520143038.189061-1-tome01@ajou.ac.kr>
References: <20240520143038.189061-1-tome01@ajou.ac.kr>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the 'target_nid' parameter of DAMOS watermark, both DAMON_RECLAIM and
DAMON_LRU_SORT modules can set the monitoring range to a specific NUMA
memory node.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 mm/damon/lru_sort.c | 13 +++++++++++++
 mm/damon/reclaim.c  | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3e25a52de..ed136ccba 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -238,6 +238,19 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(ctx, &hot_scheme, 1);
 	damon_add_scheme(ctx, cold_scheme);
 
+	/* Set monitoring range from target node */
+	if (hot_scheme->wmarks.metric == DAMOS_WMARK_NODE_FREE_MEM_RATE) {
+		int target_nid = hot_scheme->wmarks.target_nid;
+
+		if (target_nid == NUMA_NO_NODE)
+			return -EINVAL;
+		monitor_region_start = PFN_PHYS(node_start_pfn(target_nid));
+		monitor_region_end = PFN_PHYS(node_start_pfn(target_nid) +
+				node_present_pages(target_nid) - 1);
+		if (monitor_region_end < monitor_region_start)
+			return -EINVAL;
+	}
+
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,
 					&monitor_region_end);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 31b8830a8..9c0c0096b 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -192,6 +192,19 @@ static int damon_reclaim_apply_parameters(void)
 	}
 	damon_set_schemes(ctx, &scheme, 1);
 
+	/* Set monitoring range from target node */
+	if (scheme->wmarks.metric == DAMOS_WMARK_NODE_FREE_MEM_RATE) {
+		int target_nid = scheme->wmarks.target_nid;
+
+		if (target_nid == NUMA_NO_NODE)
+			return -EINVAL;
+		monitor_region_start = PFN_PHYS(node_start_pfn(target_nid));
+		monitor_region_end = PFN_PHYS(node_start_pfn(target_nid) +
+					node_present_pages(target_nid) - 1);
+		if (monitor_region_end < monitor_region_start)
+			return -EINVAL;
+	}
+
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,
 					&monitor_region_end);
-- 
2.34.1

