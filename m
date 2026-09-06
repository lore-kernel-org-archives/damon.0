Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4E3BB689;
	Sun,  6 Sep 2026 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720266; cv=none; b=AqaXMfwhKNOx0K4O4zVRDm+CWBgEFMB5hGBSKi/Pq85Q3adinAEA6k12WX2JxhdfF88Z+C4QxScm7XiQDM7NvrMfTWFGfFNHbxxxQjoMLID5VMUIagcXnOj6ED5Q7F8JFC4HD1wkvUlS6bSuzS2O6vPV3pXLN8vnOS9LNdVdBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720266; c=relaxed/simple;
	bh=pBJFOlatllz+K9zXmVwpamK+Ho2uRvOnLoGDxXKoCUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL/57rx7Eza8Z3pOy8Z1EcDpz7F6kZ4wd+41haGiCRMdNZ4FPUhKGiAM3+OXvaLxzl4Q7O381wPYRwTGCRqfyTWItkAAiG6CB3fn8UYFQ33GdUjoqiVy14gdjE85fqWiHzwgIT5XFZ/kYIKZnY6fyFSb2jQPRU5kUBU9e3y4KMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K77of3bg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K77of3bg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E271F00A3F;
	Sun,  6 Sep 2026 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720265;
	bh=Fn4wlsJY/z4XEr5TrccoXyN8K/aFxzX6vlLK3FGYk8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K77of3bgH2ETgg79GvBfvqsk1Fhipjvt+l4yf40emKaiJHOInR8qE1A6kKWuky9J0
	 aWM/HflKvFn8nFjOEnA/ewjjn0rhytHaFhF+tviRvMjr9zV34lfHSdiXfco1qXePhL
	 le3nhBAwGjJhrEoAylAN3EyJUp8F5UlDsXejZznILXL/tGfyomMXUVmbZhComT+Dk3
	 1PMVQNlntAVu2ZxDh0O3nHGd+jOJFaMttIwc+BAa9r8HL/RtFOJmOOpCgqXYpjzHq5
	 aF86moZ1oX9KUG3s+X82uojElKLZkzJh/sP+yoNLgNf6zpeZMWXf6BAkmsjL71gD5Z
	 4S6pRmNd5nw4A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] mm/damon/paddr: move probe filter handling to ops-common
Date: Sun,  6 Sep 2026 11:44:12 -0700
Message-ID: <20260906184417.96621-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906184417.96621-1-sj@kernel.org>
References: <20260906184417.96621-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe filter matching logic for anon and memcg type filters in DAMON's
physical address space operation set (paddr) can be reused by virtual
address space operation set (vaddr) in future.  Prepare the future by
moving the code to ops-common.c

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 32 ++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 23 +----------------------
 3 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 441d45679eaf2..76b663a4be610 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -524,3 +524,35 @@ bool damos_ops_has_filter(struct damos *s)
 		return true;
 	return false;
 }
+
+bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
+{
+	bool matched = false;
+	struct mem_cgroup *memcg;
+
+	switch (filter->type) {
+	case DAMON_FILTER_TYPE_ANON:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		matched = folio_test_anon(folio);
+		break;
+	case DAMON_FILTER_TYPE_MEMCG:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		rcu_read_lock();
+		memcg = folio_memcg_check(folio);
+		if (!memcg)
+			matched = false;
+		else
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
+		rcu_read_unlock();
+		break;
+	default:
+		break;
+	}
+	return matched == filter->matching;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 172f0f17c4a84..ee27058251005 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -31,3 +31,5 @@ bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
 
 bool damos_ops_has_filter(struct damos *s);
+
+bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d2173a448d0b0..d7c81829445ba 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -143,29 +143,8 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		struct folio *folio)
 {
 	bool matched = false;
-	struct mem_cgroup *memcg;
 
 	switch (filter->type) {
-	case DAMON_FILTER_TYPE_ANON:
-		if (!folio) {
-			matched = false;
-			break;
-		}
-		matched = folio_test_anon(folio);
-		break;
-	case DAMON_FILTER_TYPE_MEMCG:
-		if (!folio) {
-			matched = false;
-			break;
-		}
-		rcu_read_lock();
-		memcg = folio_memcg_check(folio);
-		if (!memcg)
-			matched = false;
-		else
-			matched = filter->memcg_id == mem_cgroup_id(memcg);
-		rcu_read_unlock();
-		break;
 	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
 		if (!folio)
 			matched = false;
@@ -173,7 +152,7 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 			matched = damon_folio_young(folio);
 		break;
 	default:
-		break;
+		return damon_ops_filter_match(filter, folio);
 	}
 	return matched == filter->matching;
 }
-- 
2.47.3
