Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0953804;
	Sun, 12 May 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536498; cv=none; b=ngL2mn4KPxXJmvFnwiBa53Jip2bfRI5Tv40vrZXZt4TaeCJT7W6oGGPFmfouWqGniZ60tGwuql6zeOXJ0y+suvGmkOFe+l5YlyZZ9XXxOLkYClekl/fPYM99YU/aHp0aXQtABjQ7gJfxJWxVpLuCNI4BY73UlQyZDWFOTU6S20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536498; c=relaxed/simple;
	bh=HjyWpv2l8S24lCKx7/me+IFm1iDwuNsUj8wbeOXFYY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSRsFcKnnn6pv6w5sCjAUkfc0F8t/nIbTxgebOeeDyvJ7Ep7TmqhrNxg45XrCHW8ucbwc0IJ3LnZsquvVgeEILYJeezJTUG8gPLqnqvplb5dn/zynNQECtktVXdQwLAAkhnzVA8vNE3y9CHqkHuHzeZb6y+8zrcKGRNH6aKslXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOCDVk1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOCDVk1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9859EC32781;
	Sun, 12 May 2024 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715536498;
	bh=HjyWpv2l8S24lCKx7/me+IFm1iDwuNsUj8wbeOXFYY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOCDVk1p+QvsfPxFZGFuR7GWACBBP/DSQaaw966CnXovAR+eXd/oKQbhPIvBEGNJW
	 WTQHUMZ9Tir6K0G1me1gLjTnFp8gxKD5G54IzI7k95vWlEOnVljY1wuxU7/QDBBCl8
	 TDHLXrizha9Gkc88qZSd6RHLzJj7UZOJJ94y5SfZp0Bmlp1AxP2d6Ny1kiFKaOUi65
	 ZwJmbuljvTEJPIEv2qWLpvi27KZPbt50udjXkXo31GtgNtfkvlqK9vP6z8JLVmTpW/
	 +PKLUiobEZ0l3l+PoNCQZwFIZOS6ibjGA+OecvuI6B5vyICO5mrBbMg2/WaES2jZx9
	 gnXanyNFEMxhw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: Hyeongtak Ji <hyeongtak.ji@sk.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [RFC PATCH v4 5/5] mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion
Date: Sun, 12 May 2024 10:54:47 -0700
Message-Id: <20240512175447.75943-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512175447.75943-1-sj@kernel.org>
References: <20240512175447.75943-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index a468792d9162..81163206e70c 100644
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
2.39.2

