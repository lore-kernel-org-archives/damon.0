Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC551465AC
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284882; cv=none; b=s91uGg/klSFWzF0gRICKN1pO+iQIn/iXDFrTO0V0Oh8hhL2HQUCeqPuoMPOPstuFhMaxBUxeUyHzRGjUvRte3bSSmpk5YinR4surUKRMyUaUyukBp2Y/Va0kcA3b+BI5bguWZIgNFudxHN+t/jWzieTBtL+iEU7Bv+r+x8HkWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284882; c=relaxed/simple;
	bh=/fG6BOMu3pDqWuzCvSk+FHfqzO4oGlow/E9AiQiJ9Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLe3xweF+gaaS01fdbMudWJk10I8q2T1eXsqcoyovOtjd2E+RUk2kS4tRcmtOX+oYzhog6BNaNh5jYeH+XkNdJVKojds8jZ4bSpAuZp106lu+qJO659pSW4UQfdPleDFtjyi6fHhSdz0SYwDVUnNXvynA9tdGywFFugkn7OsrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-52-666af24bc2a6
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
Subject: [PATCH v5 6/8] mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion
Date: Thu, 13 Jun 2024 22:20:53 +0900
Message-ID: <20240613132056.608-7-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: <20240613132056.608-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnoa73p6w0g3knxCwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6MnUefshbsk6i4sPgsawNjp0gXIyeHhICJxKXF81lh7MM3V4PZbAJqEldeTmLq
	YuTgEBGwkpi2I7aLkYuDWeAas8Tu7pPMIDXCAhES0zqmgdWzCKhKrDn/AMzmFTCV2LF9NRPE
	TE2Jx9t/soPYnAJmEo/mvmIDsYWAamb8uMoMUS8ocXLmExYQm1lAXqJ562xmkGUSAu/ZJK5c
	n8UIMUhS4uCKGywTGPlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAKFhW+yd6
	B+OnC8GHGAU4GJV4eD2eZaUJsSaWFVfmHmKU4GBWEuGdtRAoxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgXFVyOTfTw12H1t76cWrrGRFS+aPL5K8frC9
	DD0X0vLmn/a8xFznjrUKK6N+Gk2+19bzOt/YcNJaXW/m/4FJqonSS+a9aH0RMfeGTlNyfoG4
	jdp0tVuV9W8WLT5Y5GJ10Ycna8sV54zD9lbftv6p0VlvcvSGRifjee1l3t3XWt9apPwRuG9f
	dVKJpTgj0VCLuag4EQBhSAIkfgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXCNUNLT9f7U1aawY0OLouJPQYWc9avYbO4
	/+A1u8WT/79ZLRqaHrFYfH72mtmi88l3RovDc0+yWlzeNYfN4t6a/6wWR9afZbHYfPYMs8Xi
	5WoW+zoeMFkc/vqGyYHfY+npN2weO2fdZfdo2XeL3WPTqk42j02fJrF7nJjxm8XjxeaZjB4b
	P/5n9/h228Nj8YsPTB6fN8kFcEdx2aSk5mSWpRbp2yVwZew8+pS1YJ9ExYXFZ1kbGDtFuhg5
	OSQETCQO31zNCmKzCahJXHk5iamLkYNDRMBKYtqO2C5GLg5mgWvMEru7TzKD1AgLREhM65gG
	Vs8ioCqx5vwDMJtXwFRix/bVTBAzNSUeb//JDmJzCphJPJr7ig3EFgKqmfHjKjNEvaDEyZlP
	WEBsZgF5ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmC4L6v9
	M3EH45fL7ocYBTgYlXh4PZ5lpQmxJpYVV+YeYpTgYFYS4Z21ECjEm5JYWZValB9fVJqTWnyI
	UZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAqJRSWrOBZ839/fr7GQJDP0hFebF8ON1y
	2X6D//4ZX53UWdd6dh9Rnu308rBU8ma/V3b/N/+qM0jW2KSUGDTlbGq6R9zni/UXLHaqivot
	9o7c2/z4xJrLLW92Kqx9/Ek692mSqUPsBz22VsOyzUrnea4XrK3RyBJ8KvRZ0zay+bPeqQlN
	ywX1lViKMxINtZiLihMB/G8Z9XMCAAA=
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

