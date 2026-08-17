Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A9418344
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971230; cv=none; b=oVqBbS6jQJL6lwhchpSjb/CIecVDvPxo2u1+BfxxGPquBoHgvEze4U38k+EOEaLEjag1loMbiVhg0zbXl6DGY5gfNZxzb3Hb6IjZPqE34A9fidu/X7tZ+FXzVwir1+RtyOcGIzNY0XmtE6gcPPjghx0dcMNU72SyEef1wiEBR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971230; c=relaxed/simple;
	bh=zIci3W0ePBzOZ8EKy/gXzjuYTssAdhdLaZvbkzVxUds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzF0dOqnoiR/t/iwqMXdz6ake//oU47ZzfcyfSaE0TAm/nHmAqNUHGejsyNAxUfoDiq4Hz2/5GUqEEZ6lzrtnxTir1XQ/AduTT/DQAexvZ9wdYxmRp7AnBPYK1h/cGrLJQ2IalToMWv7dXVLvCNUrON11nfl5sD35takYh39w3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a87ee1169a3a11f19a56ed5b684f684d-20260817
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9d81e917-8b7e-4b49-bcdd-4cb416522e83,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:9d81e917-8b7e-4b49-bcdd-4cb416522e83,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:725b431d360468d5390744ffeb8ec87f,BulkI
	D:2608172052115L9JT3TD,BulkQuantity:1,SF:17|19|38|66|78|102|127|865|898,TC
	:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a87ee1169a3a11f19a56ed5b684f684d-20260817
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.210.10)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1187589918; Mon, 17 Aug 2026 20:53:35 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/core: introduce damon_set_target_pid()
Date: Mon, 17 Aug 2026 20:53:19 +0800
Message-ID: <20260817125319.888994-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic that finds the struct pid for a given pid number and assigns
it to a damon_target is duplicated in multiple places.  Including
damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
of the two sample modules, samples/damon/wsse.c and
samples/damon/prcl.c.  Add a function that does the work, and replace
the duplicated code in the places with calls to the function.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 12 ++++++++++++
 mm/damon/sysfs.c      |  6 ++----
 samples/damon/prcl.c  |  5 +----
 samples/damon/wsse.c  |  5 +----
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..a937aa55170b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1054,6 +1054,7 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
 
 struct damon_target *damon_new_target(void);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
+int damon_set_target_pid(struct damon_target *t, int pid);
 bool damon_targets_empty(struct damon_ctx *ctx);
 void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..82b196407ae8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
+#include <linux/pid.h>
 #include <linux/psi.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -795,6 +796,17 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
 
+/*
+ * Assign the struct pid of the given pid number to the given target.
+ */
+int damon_set_target_pid(struct damon_target *t, int pid)
+{
+	t->pid = find_get_pid(pid);
+	if (!t->pid)
+		return -EINVAL;
+	return 0;
+}
+
 bool damon_targets_empty(struct damon_ctx *ctx)
 {
 	return list_empty(&ctx->adaptive_targets);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e3858ffab4b2..3c81b4c91ac0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -3,7 +3,6 @@
  * DAMON sysfs Interface
  */
 
-#include <linux/pid.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -2035,9 +2034,8 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 		return -ENOMEM;
 	damon_add_target(ctx, t);
 	if (damon_target_has_pid(ctx)) {
-		t->pid = find_get_pid(sys_target->pid);
-		if (!t->pid)
-			/* caller will destroy targets */
+		/* caller will destroy targets */
+		if (damon_set_target_pid(t, sys_target->pid))
 			return -EINVAL;
 	}
 	t->obsolete = sys_target->obsolete;
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 842099bd6228..83ddf12811d5 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -32,7 +32,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_PRCL");
 
 static struct damon_ctx *ctx;
-static struct pid *target_pidp;
 
 static int damon_sample_prcl_repeat_call_fn(void *data)
 {
@@ -79,12 +78,10 @@ static int damon_sample_prcl_start(void)
 		return -ENOMEM;
 	}
 	damon_add_target(ctx, target);
-	target_pidp = find_get_pid(target_pid);
-	if (!target_pidp) {
+	if (damon_set_target_pid(target, target_pid)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
-	target->pid = target_pidp;
 
 	scheme = damon_new_scheme(
 			&(struct damos_access_pattern) {
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 37fd5da20158..53944aea8428 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -33,7 +33,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_WSSE");
 
 static struct damon_ctx *ctx;
-static struct pid *target_pidp;
 
 static int damon_sample_wsse_repeat_call_fn(void *data)
 {
@@ -79,12 +78,10 @@ static int damon_sample_wsse_start(void)
 		return -ENOMEM;
 	}
 	damon_add_target(ctx, target);
-	target_pidp = find_get_pid(target_pid);
-	if (!target_pidp) {
+	if (damon_set_target_pid(target, target_pid)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
-	target->pid = target_pidp;
 
 	err = damon_start(&ctx, 1, true);
 	if (err) {
-- 
2.43.0

