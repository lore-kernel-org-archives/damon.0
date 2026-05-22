Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973ED47F2EC;
	Fri, 22 May 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464437; cv=none; b=ozmOH7/WRk5C+tNoDxS7hoEtDknBGo5sM8Ml1zmPh+LTvmxqbzxGKHi4nNeARx3Xm+8RXX7gma2/VBjGqh+INYgrenQZ0FXYJM2wM6v/6bR8OtLoTYlE+ZxSUGcJsPcS2DIywW8+HJXL2aBPLZmOctFSYeBMCwK6MiWjTtyo28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464437; c=relaxed/simple;
	bh=FuUa5xt2se46JzutG7EYPDaZrQIXdRb0E12Me/sqoS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+U+iawcIvWNr/kHqESM8dUP6eUapNnkten+B1Ygqdwy79kV1ZVNt2hHK9qwBHlkU+bT5ipHbEsjr5b+1cPTN21tAu1tWCKMWGrxXwCGHZxKSLiFaOg4670WtIs5f1m/t7eKKedNWRRNkWkp9uoi4aa4BXCHzPOaibQG4t4ulBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdslDMQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdslDMQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DD51F000E9;
	Fri, 22 May 2026 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464436;
	bh=IeG1YpmdwoxV7AhFJBWoBRuaRnNiqLlSgdb3KPs/hX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QdslDMQImV+uHeiZSojuQBuFR8IkIcTGjyombaOwDJVaukQK6eNdRLjYZy+ctmHk2
	 xVe5F/IxXjNCKJwZzYylmQRBNo5LXWcfRr3LlLtwN7DiOeaFbL1/I23GOQsMsiCwBo
	 kNb1dxpo+BsXmkrAdpCHUMuEK62z57VKTGDjO2m+A1Ruj/qfv/y8gCdMje9VlgVQfg
	 fEpagFaFdNILiWMhfx3Qwa5njDXdnxz/pwpcYPqgaPa/wnrpaZmEqkwTUNtwLZe1Lk
	 Ie++/QpqVXZIbpgcGmZwmLqnMKFNLRCvZDY/oISmJxYMNNfEHaMWDMKB6rlmXpjyoo
	 +t7Tqy9VWZ5MA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/14] mm/damon/core: hide damon_add_region()
Date: Fri, 22 May 2026 08:40:16 -0700
Message-ID: <20260522154026.80546-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_add_region() is being used by only DAMON core, but exposed to
DAMON API callers.  Exposing something that is not really being used by
others will only increase the maintenance cost.  Hide it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 mm/damon/core.c       | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 08c4aaa690fa8..6ba80dff56946 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1024,7 +1024,6 @@ static inline void damon_insert_region(struct damon_region *r,
 	t->nr_regions++;
 }
 
-void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e8cf3632115e5..7d1de6ff54eba 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -250,7 +250,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	return region;
 }
 
-void damon_add_region(struct damon_region *r, struct damon_target *t)
+static void damon_add_region(struct damon_region *r, struct damon_target *t)
 {
 	list_add_tail(&r->list, &t->regions_list);
 	t->nr_regions++;
-- 
2.47.3
