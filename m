Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AE33B6F6;
	Mon, 18 May 2026 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147685; cv=none; b=Rh82I7POqI1Kwju5wHzN9MGIC3GrMrPHBHF+OezSZKmsbfXcWIWpii2nWrjkdLKblmiyS2N4hz+K9y8swHh7fCfGppFKY4G8FzYaQmAry53PfpH8EILTVkCdmZ8j/lhwlJLhozVbCgNrmtpAEOP6mkxqBie2F4DaOL9nulB9GFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147685; c=relaxed/simple;
	bh=IlAa+oqmEJU7Ymj9l5zZPzJiXY56Jh7uaI0GPCOUdHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1j+B0IfDUae4JXGOhU7d9BwI2NPOCv7GFI9cMYHTLcwmQkgmZL0oEgpiUCQankTRn1E1aqNvt4pJtwdwHEuqYY2eOK+wmcOZh82zopOA6lzU2difp0FSzawyN7pQivGl5bRCrZSKkBVWk/Sdy7jVlEldXfEZ9koeUlwy3laX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0aaBZ+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0aaBZ+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EEAC2BCC7;
	Mon, 18 May 2026 23:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147685;
	bh=IlAa+oqmEJU7Ymj9l5zZPzJiXY56Jh7uaI0GPCOUdHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0aaBZ+unVDLD6djSWl/RinRsUhT4XjzyZT+8HeKoPgKZFTIU3hPnRzNfN0tRHS5e
	 XM1/wiof5kJ4tPvwnaEKHbPjWBgIM0s/kVvxT0wwiLkePbg1ZAfloJ6vWZ2zWr5vwH
	 TVRU7dgoR43P6zQvZzYlLU19c/8Jt70XTejnr3o28qQvbwVALZvvHWGBPGQo7gfyD9
	 EOgavJelUGc2RYXHMFbmcZBPDiG12ZxETMmqARfJ8k6eYE9idwqiF38DFWsPsvH79e
	 EHfhcVcDfp4mFU8SSihbsBUU/rk/zDpiGxvFsoqZ80Cdr6WZpFESqm3s5GkpCvPdYO
	 wkes1E00GUpVA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/28] mm/damon/core: introduce damon_region->probe_hits
Date: Mon, 18 May 2026 16:40:53 -0700
Message-ID: <20260518234119.97569-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an array for the per-region per-probe positive samples count.  For
simple and efficient implementation, add a limit to the number of data
probes and set the array to support only the limited number of counters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  4 ++++
 mm/damon/core.c       | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f8b679dd944d9..3a30af119ac6e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -17,6 +17,8 @@
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION_SZ	PAGE_SIZE
+/* Maximum number of monitoring probes. */
+#define DAMON_MAX_PROBES	(4)
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
@@ -47,6 +49,7 @@ struct damon_size_range {
  * @nr_accesses:	Access frequency of this region.
  * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
  *			each sampling interval.
+ * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
@@ -75,6 +78,7 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned int nr_accesses_bp;
+	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
 	unsigned int age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 075d60a4749a3..6dd1bce81ec2a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -229,6 +229,7 @@ static void damon_verify_new_region(unsigned long start, unsigned long end)
 struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
+	int i;
 
 	damon_verify_new_region(start, end);
 	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
@@ -239,6 +240,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.end = end;
 	region->nr_accesses = 0;
 	region->nr_accesses_bp = 0;
+	for (i = 0; i < DAMON_MAX_PROBES; i++)
+		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
@@ -2983,12 +2986,17 @@ static void damon_merge_two_regions(struct damon_target *t,
 		struct damon_region *l, struct damon_region *r)
 {
 	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
+	int i;
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
 	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
+	/* todo: do this for only installed probes */
+	for (i = 0; i < DAMON_MAX_PROBES; i++)
+		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
+				* sz_r) / (sz_l + sz_r);
 	damon_verify_merge_two_regions(l, r);
 	damon_destroy_region(r, t);
 }
@@ -3111,6 +3119,8 @@ static void damon_split_region_at(struct damon_target *t,
 	new->last_nr_accesses = r->last_nr_accesses;
 	new->nr_accesses_bp = r->nr_accesses_bp;
 	new->nr_accesses = r->nr_accesses;
+	/* todo: do this for only installed probes */
+	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.47.3
