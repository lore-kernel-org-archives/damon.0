Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E341862A3
	for <damon@lists.linux.dev>; Fri, 14 Jun 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334030; cv=none; b=aN8SuaxgjjB1H3tqDYK8IfpuGMcRFftyMIk+ZisNdVh9ZxGLGIWjA54U78njTUouyTP11RglIkK13W/Kc+w1ivLFqO5IcJ7APpFGV9OpjbSerZCOngaC2tMeTnQ+QihSRF3qhp1klVMvIiwjs6MpwJ8YziTPTadM0fPu88EgLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334030; c=relaxed/simple;
	bh=/fG6BOMu3pDqWuzCvSk+FHfqzO4oGlow/E9AiQiJ9Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd4MnANw0cg9h+0i2KGG+1opkcMMXB04rL0vgdKeAOawg2QGYR4BIwJWzIVKf/9fLlLqsvhjkC0vYH4+AZ5LJ4Eukzl83myRFKjV44kP4jVFpomy72syTl4PugchLbhmMkUvs+8xnPurShuvSDbcABcP6TYW1q2fgD2Xnk2HeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-4b-666bb2473bfa
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v6 6/7] mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion
Date: Fri, 14 Jun 2024 12:00:08 +0900
Message-ID: <20240614030010.751-7-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240614030010.751-1-honggyu.kim@sk.com>
References: <20240614030010.751-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnka77puw0g6Y9IhYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKxuLxrDpvFvTX/WS2OrD/LYrH57Blmi8XL1Sz2dTxgsjj89Q2TA4/H
	0tNv2Dx2zrrL7tGy7xa7x6ZVnWwemz5NYvc4MeM3i8eLzTMZPTZ+/M/u8XmTXABnFJdNSmpO
	Zllqkb5dAlfGzqNPWQv2SVRcWHyWtYGxU6SLkZNDQsBE4tacfSww9u5ry9hBbDYBNYkrLycx
	dTFycIgIWElM2xHbxcjFwSxwjVlid/dJZpAaYYEIifkr+8F6WQRUJQ5fawPr5RUwlTj+fjET
	xExNicfbf4LFOQXMJKYfuwcWFwKquXBlKxNEvaDEyZlPwOYwC8hLNG+dzQyyTELgPZtEd9M3
	RohBkhIHV9xgmcDIPwtJzywkPQsYmVYxCmXmleUmZuaY6GVU5mVW6CXn525iBEbBsto/0TsY
	P10IPsQowMGoxMPr8SwrTYg1say4MvcQowQHs5II76yFQCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MvWemTDFameYcdPxMOsfvclG7zvn7S/rULGvX
	nF6yWn9uEtP2WeaK/7xFuOV3z7DWP/Q6/Jqi0vUZwseZf5x8biJp83L6tLvBrg7aprMS4hjn
	iyoIiiyZui46pUZha8vVlEWX5L99+2GQ9JBjUsR36eu7LPpOrmSZ97xsg2tdzIfFCU2Ppk9X
	VmIpzkg01GIuKk4EAC1V+Nd+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXCNUNLT9d9U3aaQeM7TouJPQYWc9avYbO4
	/+A1u8WT/79ZLRqaHrFYfH72mtmi88l3RovDc0+yWlzeNYfN4t6a/6wWR9afZbHYfPYMs8Xi
	5WoW+zoeMFkc/vqGyYHfY+npN2weO2fdZfdo2XeL3WPTqk42j02fJrF7nJjxm8XjxeaZjB4b
	P/5n9/h228Nj8YsPTB6fN8kFcEdx2aSk5mSWpRbp2yVwZew8+pS1YJ9ExYXFZ1kbGDtFuhg5
	OSQETCR2X1vGDmKzCahJXHk5iamLkYNDRMBKYtqO2C5GLg5mgWvMEru7TzKD1AgLREjMX9nP
	AmKzCKhKHL7WBtbLK2Aqcfz9YiaImZoSj7f/BItzCphJTD92DywuBFRz4cpWJoh6QYmTM5+A
	zWEWkJdo3jqbeQIjzywkqVlIUgsYmVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEhvuy2j8T
	dzB+uex+iFGAg1GJh9fjWVaaEGtiWXFl7iFGCQ5mJRHeWQuBQrwpiZVVqUX58UWlOanFhxil
	OViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYyqDI+8Tt/P3Lv7nzRvW4dE2LW3iz4fLuG+
	rrJQsz8my+Rd9+sW3ach1rt1wqQsO9tur9zJv2vmbrkvDu/WPDus91bzXuWUQzpR0s925X/g
	dzc7qHQwLUs1c+deNpnNT1LfzY7wKXm9szDKu9LvQgV/5Y3Sq3/TBYxdX80KV0g6ufuTt2y2
	TJoSS3FGoqEWc1FxIgC08WiccwIAAA==
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch introduces DAMOS_MIGRATE_HOT action, which is similar to
DAMOS_MIGRATE_COLD, but proritizes hot pages.

It migrates pages inside the given region to the 'target_nid' NUMA node
in the sysfs.

Here is one of the example usage of this 'migrate_hot' action.

  $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
  $ cat contexts/<N>/schemes/<N>/action
  migrate_hot
  $ echo 0 > contexts/<N>/schemes/<N>/target_nid
  $ echo commit > state
  $ numactl -p 2 ./hot_cold 500M 600M &
  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  701 (hot_cold)     501      0    601  1101

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 3 +++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 56714b6eb0d7..3d62d98d6359 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -105,6 +105,7 @@ struct damon_target {
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
+ * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
  * @DAMOS_MIGRATE_COLD:	Migrate the regions prioritizing colder regions.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
@@ -123,6 +124,7 @@ enum damos_action {
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
+	DAMOS_MIGRATE_HOT,
 	DAMOS_MIGRATE_COLD,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 882ae54af829..af6aac388a43 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -486,6 +486,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
+	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, scheme);
 	case DAMOS_STAT:
@@ -508,6 +509,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_MIGRATE_HOT:
+		return damon_hot_score(context, r, scheme);
 	case DAMOS_MIGRATE_COLD:
 		return damon_cold_score(context, r, scheme);
 	default:
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 880015d5b5ea..66fccfa776d7 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1458,6 +1458,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"nohugepage",
 	"lru_prio",
 	"lru_deprio",
+	"migrate_hot",
 	"migrate_cold",
 	"stat",
 };
-- 
2.34.1

