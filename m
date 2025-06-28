Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30121B9C0;
	Sat, 28 Jun 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129509; cv=none; b=fqWu1OgfU/Qr/moImbYk5orLHfIxeXPxxwq4El8unymrVEFahlqD99kJN8NIrG11pxKkHeFk6YRXVYHsn7txH7HQVKTiAnhaGJP+AlEHkp3rIPYmpHUJdq4QYIiaJ2ev2wrH6PwhCzM9dLzVPB6KTMLVR+Rw13mjJLOZQ2LZA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129509; c=relaxed/simple;
	bh=Loco/3F4VYCbvXX7GgEUHxvF0e1mZosYux21IhMdVz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVCB/PR2carbo1izJ3XK/vx6jJZkm/Hbv0dPSA36zCVSP+BTZklcTTlQUmf2Ex26jisdwBzFzKradlBepE9TcZ2g3U+GR0r7a4q14O4hNrTde2NCwxRu0EafsagghH4C6N00KLMSwGOOxluFX71PCANw/9VdaIo5qfbjIWvK8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHjz8Uih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHjz8Uih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48B3C4CEEF;
	Sat, 28 Jun 2025 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129509;
	bh=Loco/3F4VYCbvXX7GgEUHxvF0e1mZosYux21IhMdVz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHjz8Uih4qDgGK6aYn4YHtpyrrbbBdXqJyFN8sMQjmuayAtj6VAYGa9pE3DJUKhcA
	 o5zosE9OXkUeRPMcFvXm2LeoZR6x8G4DmzIR+HEL0NlEUNyL2dryZHJ4q/H/edrw6B
	 pk9n1sSHV7g5lEiPa0kP1pvHvr7nEyxBevUnnxYkTzTzvpOO+/XEU3vYCKZRt9pQ8A
	 Olm+K0MhGrjFL4AnhyC8Y4kgJx+O5uaV0G/Fy5S01uMYyYZPTROE4qj3jaGqpXfdrC
	 IzWHt8tcoNnNnnbG2rafMXdhVE+oNd09Eu+quEC6l7RFUlFNcdBzd4TJ3iQfxqfkQz
	 AvmnA62YHrOdw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/11] mm/damon/core: introduce [in]active memory ratio damos quota goal metric
Date: Sat, 28 Jun 2025 09:51:34 -0700
Message-Id: <20250628165144.55528-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_LRU_[DE]PRIO are DAMOS actions for making balance of active and
inactive memory size.  There is no appripriate DAMOS quota auto-tuning
target metric for the use case.  Add two new DAMOS quota goal metrics
for the purpose, namely DAMOS_QUOTA_[IN]ACTIVE_MEM_BP.  Those weill
represent the ratio of [in]active memory to total (inactive + active)
memory.  Hence, users will be able to ask DAMON to, for example, "find
hot and cold memory, and move pages of those to active and inactive LRU
lists, adjusting the hot/cold thresholds aiming 50:50 active:inactive
memory ratio."

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  4 ++++
 mm/damon/core.c       | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 517f48ffe782..c2fc6c8cbbe4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -179,6 +179,8 @@ enum damos_action {
  * @DAMOS_QUOTA_SOME_MEM_PSI_US:	System level some memory PSI in us.
  * @DAMOS_QUOTA_NODE_MEM_USED_BP:	MemUsed ratio of a node.
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
+ * @DAMOS_QUOTA_ACTIVE_MEM_BP:		Active to [in]active memory ratio.
+ * @DAMOS_QUOTA_INACTIVE_MEM_BP:	Inactive to [in]active memory ratio.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -188,6 +190,8 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_SOME_MEM_PSI_US,
 	DAMOS_QUOTA_NODE_MEM_USED_BP,
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
+	DAMOS_QUOTA_ACTIVE_MEM_BP,
+	DAMOS_QUOTA_INACTIVE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 02493d71460c..88ffc826a118 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2027,6 +2027,23 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 }
 #endif
 
+/*
+ * Returns LRU-active memory to LRU-inactive memory size ratio.
+ */
+static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
+{
+	unsigned long active, inactive, total;
+
+	/* This should align with /proc/meminfo output */
+	active = global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_ANON) +
+		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
+	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
+		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
+	total = active + inactive;
+	if (active_ratio)
+		return active * 10000 / total;
+	return inactive * 10000 / total;
+}
 
 static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 {
@@ -2046,6 +2063,11 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		goal->current_value = damos_get_node_mem_bp(goal);
 		break;
+	case DAMOS_QUOTA_ACTIVE_MEM_BP:
+	case DAMOS_QUOTA_INACTIVE_MEM_BP:
+		goal->current_value = damos_get_in_active_mem_bp(
+				goal->metric == DAMOS_QUOTA_ACTIVE_MEM_BP);
+		break;
 	default:
 		break;
 	}
-- 
2.39.5
