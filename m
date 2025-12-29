Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFF329C74
	for <damon@lists.linux.dev>; Mon, 29 Dec 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767020153; cv=none; b=WPtBSxTa6ssZFw5F0/lemg5yc4tgXS50j8MLK8dDGuB0dum/Yw2EMGzRk2ThOXbGmXOj/Y+8N2QAb0gNPcQ687wKOc/1uZJB7x9E3tnjwvjxCiDQ/0VouG4UXFIC9p7er6j1lEX2GlqfU1ttN8hfkjyuSFaZC6O49eibIOwwBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767020153; c=relaxed/simple;
	bh=jPBSnc1RpG/FnqNzwMij/WFXFe4qK6H+FMVDp0qDC80=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XnaQkve8ZmN2YY/MbBGx5lq0TZ6NxkzsAA++y9sgJlG6NTAdxaTgLVQFb+kTq7wyBDQKpyq2JbLOuDUOKoXH2TsRxCCo/O79vex6J4kyAC7y+Y1W9958M7g4joxPR4AGeKoEdnekOVqREbww8uu8AEkYSd9WGoYiY2gBPZiL1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dfzlg1dy2zJ46DY;
	Mon, 29 Dec 2025 22:54:55 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A3DD40570;
	Mon, 29 Dec 2025 22:55:44 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Dec 2025 17:55:43 +0300
From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <sj@kernel.org>,
	<akpm@linux-foundation.org>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
	<artem.kuzin@huawei.com>, <stepanov.anatoly@huawei.com>
Subject: [RFC PATCH v1] mm: improve call_controls_lock
Date: Mon, 29 Dec 2025 14:55:32 +0000
Message-ID: <20251229145533.2437293-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

This is a minor patch set for a call_controls_lock synchronization improvement.

Spinlocks are faster than mutexes, even when the mutex takes the fast
path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.

Initial benchmarking shows the following results


# bpftrace -e 'kprobe:kdamond_call { @start[tid] = nsecs; }
    kretprobe:kdamond_call /@start[tid]/
    { @ns[comm] = hist(nsecs - @start[tid]); delete(@start[tid]); }'

@ns[kdamond.0]:
[16K, 32K)            22 |@@@@@@@@@@@@                                        |
[32K, 64K)            90 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[64K, 128K)            0 |                                                    |
[128K, 256K)           1 |                                                    |

@ns[kdamond.0]:
[16K, 32K)            19 |@@@@@@@@                                            |
[32K, 64K)           118 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[64K, 128K)            0 |                                                    |
[128K, 256K)           1 |

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 include/linux/damon.h |  2 +-
 mm/damon/core.c       | 17 ++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3813373a9200..43665e63a498 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -801,7 +801,7 @@ struct damon_ctx {
 
 	/* lists of &struct damon_call_control */
 	struct list_head call_controls;
-	struct mutex call_controls_lock;
+	spinlock_t call_controls_lock;
 
 	struct damos_walk_control *walk_control;
 	struct mutex walk_control_lock;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9fc0375890a..a929bdf3bc7b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -539,7 +539,6 @@ struct damon_ctx *damon_new_ctx(void)
 
 	mutex_init(&ctx->kdamond_lock);
 	INIT_LIST_HEAD(&ctx->call_controls);
-	mutex_init(&ctx->call_controls_lock);
 	mutex_init(&ctx->walk_control_lock);
 
 	ctx->attrs.min_nr_regions = 10;
@@ -1457,9 +1456,9 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	control->canceled = false;
 	INIT_LIST_HEAD(&control->list);
 
-	mutex_lock(&ctx->call_controls_lock);
+	spin_lock(&ctx->call_controls_lock);
 	list_add_tail(&control->list, &ctx->call_controls);
-	mutex_unlock(&ctx->call_controls_lock);
+	spin_unlock(&ctx->call_controls_lock);
 	if (!damon_is_running(ctx))
 		return -EINVAL;
 	if (control->repeat)
@@ -2549,10 +2548,10 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 	int ret = 0;
 
 	while (true) {
-		mutex_lock(&ctx->call_controls_lock);
+		spin_lock(&ctx->call_controls_lock);
 		control = list_first_entry_or_null(&ctx->call_controls,
 				struct damon_call_control, list);
-		mutex_unlock(&ctx->call_controls_lock);
+		spin_unlock(&ctx->call_controls_lock);
 		if (!control)
 			break;
 		if (cancel) {
@@ -2561,9 +2560,9 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 			ret = control->fn(control->data);
 			control->return_code = ret;
 		}
-		mutex_lock(&ctx->call_controls_lock);
+		spin_lock(&ctx->call_controls_lock);
 		list_del(&control->list);
-		mutex_unlock(&ctx->call_controls_lock);
+		spin_unlock(&ctx->call_controls_lock);
 		if (!control->repeat) {
 			complete(&control->completion);
 		} else if (control->canceled && control->dealloc_on_cancel) {
@@ -2577,9 +2576,9 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 			struct damon_call_control, list);
 	if (!control || cancel)
 		return;
-	mutex_lock(&ctx->call_controls_lock);
+	spin_lock(&ctx->call_controls_lock);
 	list_add_tail(&control->list, &ctx->call_controls);
-	mutex_unlock(&ctx->call_controls_lock);
+	spin_unlock(&ctx->call_controls_lock);
 }
 
 /* Returns negative error code if it's not activated but should return */
-- 
2.43.0


