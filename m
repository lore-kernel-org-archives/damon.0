Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C226298241;
	Thu, 19 Jun 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370439; cv=none; b=mKM26DhjzyEiE/IxzG9jhyVKwDMQ1zUilI2YStirBqeYuFZYir9oxENi+EJq8pPJ6GKW6bSEjqOoxumISiJhDecJ6Fgy1OjoEg8q+BHDeM8FLnpFVW5yHvl4+WPm/qLPWXPBJEiKiqTaKxP/Z8sP7hzf1uU67MIsMXt4YZ+l3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370439; c=relaxed/simple;
	bh=lRIYfv6d9ZUagG+D/Ljb9Zv5CaI6stHZpkxzrSwoTP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkBCPcnKi2NLedoMYSl1txk8AqBkUU6GNwCB0ah8iEFjj8KGCfXq8ktfVlW763+6al6HenFH7F10/9EYTFytmp/sy+5FDRyBRJ+6fJ/QVr1oSQXBjMKs0bP9dW/BnegwycZJPoguSMwTDHQt0Umslc0nQxLuAOUHDV08FZP7Ioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7i+0ApA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7i+0ApA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DECC4CEEE;
	Thu, 19 Jun 2025 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370438;
	bh=lRIYfv6d9ZUagG+D/Ljb9Zv5CaI6stHZpkxzrSwoTP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7i+0ApAUZMon9H3bfHfx/w0HiENvgxYh8bpDLqXcE3QzNvILJeAaklXWmcveR6cj
	 w733RFwBA1ZaxKtWGGsFacjR78XdEE0C81GHpaj7GZA8IEKusclmYq0LoLMpJtVmdu
	 MF3LkeWkwFlTTvNlmMz45bpdPYIYXtugtMdqCEKnMPC0Cbb4aIoLcRdvSwQU+MrecU
	 zlvKNCzaz5QqVPRhsWSR063BfKUqg/HOLOMSRRhJCq5Kv6TN97aj15r9ohNshsz3FU
	 31Ti5Of6gyHHwZZfzIzTQ2uL4S48VxfN+dmkaNx2mZqniGlONQUg90LD1wTXOdJh0j
	 j+JsiFqqCpAWg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/11] mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_FREE_BP
Date: Thu, 19 Jun 2025 15:00:21 -0700
Message-Id: <20250619220023.24023-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the core part of DAMOS_QUOTA_NODE_MEMCG_FREE_BP to get the
real value.  The value is implemented as the entire memory of the given
NUMA node, except the given cgroup's portion.  So strictly speaking, it
is not free memory but memory that not used by the cgroup.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1481b43f2710..ee3d6d4b3c9b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2028,7 +2028,7 @@ static unsigned long damos_get_node_memcg_used_bp(
 {
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
-	unsigned long used_pages;
+	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
 	rcu_read_lock();
@@ -2042,7 +2042,11 @@ static unsigned long damos_get_node_memcg_used_bp(
 	rcu_read_unlock();
 
 	si_meminfo_node(&i, goal->nid);
-	return used_pages * PAGE_SIZE * 10000 / i.totalram;
+	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+		numerator = used_pages * PAGE_SIZE;
+	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+		numerator = i.totalram - used_pages * PAGE_SIZE;
+	return numerator * 10000 / i.totalram;
 }
 #else
 static __kernel_ulong_t damos_get_node_mem_bp(
@@ -2092,6 +2096,7 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 		goal->current_value = damos_get_node_mem_bp(goal);
 		break;
 	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 		goal->current_value = damos_get_node_memcg_used_bp(goal);
 		break;
 	case DAMOS_QUOTA_ACTIVE_MEM_BP:
-- 
2.39.5
