Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03B81F09B6
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360072; cv=none; b=qIDAOQMxlaVcoX2oktKs28nMnjtQpT78oI3UYm1uWfkIbVtFCeSKiAESeMghijNkEEg1gAMOyfZ7Wo7DVJQzjhUJxM/Mcz+xTqu1CqERALENAs4LYlrfiiulnHym9pgPXiTlQZflilw9MFPbhm6PcL5MUsgzG3Y2kPhyem5YZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360072; c=relaxed/simple;
	bh=TcJDRCy2YRDnqox1Wxw7tyraONe0LQN9BSKHDNITpCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBaXSkjSQcNVbiBtYu82ALcUPWat992n9AITWl4RM24nPcexqE5q4pCsoM7g5KVgJUSAXRvkvgOCaAIwnHV3kYLKBx7yRCwx34FjFdxPeSfM50CBVer1iwDwWmy0EjGDAm3o+RhnuRTVjUkDfuhJCpjYhtpcAmWv4rjA3NWTUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-79-6863a23dd9db
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: [RFC PATCH 2/2] samples/damon: add `migrate_hot` and `migrate_cold` knobs
Date: Tue,  1 Jul 2025 17:54:17 +0900
Message-ID: <20250701085417.1734-3-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250701085417.1734-1-yunjeong.mun@sk.com>
References: <20250701085417.1734-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsXC9ZZnka7touQMg5dTLS3mrF/DZvHk/29W
	i8u75rBZ3Fvzn9Xi8Nc3TA6sHptWdbJ5bPo0id3jxIzfLB4vNs9k9Pi8SS6ANYrLJiU1J7Ms
	tUjfLoEr49Ovv+wFHfIVa1afYmxgPC/ZxcjJISFgIjFx33omGPvzl4usIDabgIbEwUMnmUFs
	EQFBif7HM4DiXBzMAnMZJY6cec8IkhAWCJKYeP08UBEHB4uAqsTsx1EgYV4Bc4nrf6cwQszU
	lGi4dA9sPqeAhcSJmc/A4kJANff/zmeHqBeUODnzCQuIzSwgL9G8dTYzRO8cNokvTeIQtqTE
	wRU3WCYw8s9C0jILScsCRqZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIGBuaz2T/QOxk8Xgg8x
	CnAwKvHwzjiZlCHEmlhWXJl7iFGCg1lJhJdPNjlDiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/R
	t/IUIYH0xJLU7NTUgtQimCwTB6dUA6PMDHeHUGWdnaIhyleW/9hrP2GOH/Pzi99+3uG6nHyP
	fe++nbMrZ8lufn6q/MK1FMnZh1fa9Udcvf5uqdi5AJtOJ5n9ehprLqb+uOvQqW3kc2PfjEeS
	9za8L8lX2/rpv+XaO9371gqeqUwyyjK4cK/5yWkNh3X6FX4N+1S6j1VfjAgoOlHzanaTEktx
	RqKhFnNRcSIAZ+lwLkgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXCNUNWR9d2UXKGwaIPGhZz1q9hs3jy/zer
	xednr5ktDs89yWpxedccNot7a/6zWhz++obJgd1j06pONo9Nnyaxe5yY8ZvF48XmmYwe3257
	eCx+8YHJ4/MmuQD2KC6blNSczLLUIn27BK6MT7/+shd0yFesWX2KsYHxvGQXIyeHhICJxOcv
	F1lBbDYBDYmDh04yg9giAoIS/Y9nAMW5OJgF5jJKHDnznhEkISwQJDHx+nmgIg4OFgFVidmP
	o0DCvALmEtf/TmGEmKkp0XDpHhOIzSlgIXFi5jOwuBBQzf2/89kh6gUlTs58wgJiMwvISzRv
	nc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQJDb1ntn4k7GL9cdj/E
	KMDBqMTDa5CXlCHEmlhWXJl7iFGCg1lJhJdPNjlDiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9X
	eGqCkEB6YklqdmpqQWoRTJaJg1OqgfERu657xuXi72cVH97I+d6lsIJp+7X91zzVbVL5nx65
	wdL7p2qS1t3ylFlTzj3Y/P/nErPTBdvedxdsLV7Ct5uXS+WS/N5PZ7wXNHO+7Vi+hpnP5bOT
	659VfUr9jP4Hf+x1nffJTnyi4nKxCd7pJuxVK5at33cjKTPiDtP7Jsn5YUL1Lvu3dj1WYinO
	SDTUYi4qTgQAgu2CGDkCAAA=
X-CFilter-Loop: Reflected

This patch introduces two new konbs for promotion/demotion:
`migrate_hot` and `migrate_cold`. It receives node ids for migration in
a comma-separated format as `<src,dst>`. The usage is as follows:

    # demote pages from nid 0 to nid 1
    $ echo 0,1 > /sys/module/mtier/parameters/migrate_cold
    # promote pages from nid 1 to nid 0
    $ echo 1,0 > /sys/module/mtier/parameters/migrate_hot

Susggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
---
 samples/damon/mtier.c | 68 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index ba6938a89c21..55d2edb84d7e 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
 
 static unsigned long node0_mem_used_bp __read_mostly = 9970;
 module_param(node0_mem_used_bp, ulong, 0600);
@@ -18,6 +19,32 @@ module_param(node0_mem_used_bp, ulong, 0600);
 static unsigned long node0_mem_free_bp __read_mostly = 50;
 module_param(node0_mem_free_bp, ulong, 0600);
 
+static int get_migrate_hot(
+		char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops migrate_hot_ops = {
+	.set = param_set_charp,
+	.get = get_migrate_hot,
+};
+
+static char *migrate_hot __read_mostly = "";
+module_param_cb(migrate_hot, &migrate_hot_ops, &migrate_hot, 0600);
+MODULE_PARM_DESC(migrate_hot,
+	"Specify source and destination node id as a comma-seperated pair");
+
+static int get_migrate_cold(
+		char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops migrate_cold_ops = {
+	.set = param_set_charp,
+	.get = get_migrate_cold,
+};
+
+static char *migrate_cold __read_mostly = "";
+module_param_cb(migrate_cold, &migrate_cold_ops, &migrate_cold, 0600);
+MODULE_PARM_DESC(migrate_cold,
+	"Specify source and destination node id as a comma-seperated pair");
+
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp);
 
@@ -37,6 +64,30 @@ struct region_range {
 	phys_addr_t end;
 };
 
+static int parse_migrate_node(int *src, int *dst, bool promote) {
+	char *comma;
+	char buf[32];
+
+	if (promote)
+		strscpy(buf, migrate_hot, sizeof(buf));
+	else
+		strscpy(buf, migrate_cold, sizeof(buf));
+
+	comma = strchr(buf, ',');
+	if (!comma)
+		return -EINVAL;
+
+	*comma = '\0';
+	comma++;
+
+	if (kstrtoint(buf, 0, src))
+		return -EINVAL;
+	if (kstrtoint(comma, 0, dst))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int numa_info_init(int target_node, struct region_range *range) {
 
 	if (!node_online(target_node)) {
@@ -64,6 +115,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
 	struct region_range addr;
+	int src, dst;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -94,8 +146,10 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 		goto free_out;
 	damon_add_target(ctx, target);
 
-	int ret = promote ? numa_info_init(1, &addr) : numa_info_init(0, &addr);
-	if (ret)
+	if (parse_migrate_node(&src, &dst, promote))
+		goto free_out;
+
+	if (numa_info_init(src, &addr))
 		goto free_out;
 
 	region = damon_new_region(addr.start, addr.end);
@@ -171,6 +225,16 @@ static void damon_sample_mtier_stop(void)
 	damon_destroy_ctx(ctxs[1]);
 }
 
+static int get_migrate_hot(char *buf, const struct kernel_param *kp)
+{
+       return scnprintf(buf, PAGE_SIZE, "%s", migrate_hot);
+}
+
+static int get_migrate_cold(char *buf, const struct kernel_param *kp)
+{
+       return scnprintf(buf, PAGE_SIZE, "%s", migrate_cold);
+}
+
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-- 
2.34.1

