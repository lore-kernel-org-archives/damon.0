Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294823;
	b=LTnws/JKTNprqafMLbXpEL7C/WblHdU/pAqZr3wblqNIU35uoU3Bnu4r6WE62kBVex08
	 iNpgttuXD3GT4FjcInkynja02Cfkii668w+c3Fir0QMzOgRuSZxwW1gT6JG9kQiELlhK7
	 XezygOQVQprcHScvtKt5IOQPI8WtGqJmEUQm+BZUgC+KYcUrXf9u8Yv4Nh+oMAwJh2KBl
	 FIykCk3y/JwywsjKUNsOtvQsCnTLQASSdqC7D7lo9kFAOhx4yaxuTU4k/5IdFR50JCTJL
	 /w3E7jghriwC5OaokzAftBo2G6XOnZ0Qr/jbIP6+W3O7skPLvpvKGSfoRFSCxYuRetA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=en0GKVo205/sJ+JMMbLGyOQzR+GcMBoehXLNhDIZG2Q=;
	b=WBG23Mbhi2sugQvsaU5oXwful6JVdX8lJb9UovV6AUUwAgrlQV9AU+A6/958931OMoGG
	 j4qjzKOQj84UYUHUZJ2jhG3DtBZ4TIy7WiShW9VCa4Cvh9g9GOeighYWx73K7gzu97VT5
	 hbhpr8jzjiJGmxWL9JWrG5tqQdR+SBqfjMh6aj2+Nc7BcuI5qV6/yuhSOjwFAieXYyxrL
	 ipCukBvKYLBd6ubTZpz0QZLTx8OrAvV7wbc1e2ZVvdJgWSXBUItOxnAbcISCElyBxhOQL
	 XmgAEL0Q1jYOGVAi5PIxSR6m+v5/GcoBMxXOb/3eLpKyBcH0FIlqMTd++UEJCylVMlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5pop92d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC87606A330
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5pop92d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C181F000C6;
	Sat, 21 Nov 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294823;
	bh=en0GKVo205/sJ+JMMbLGyOQzR+GcMBoehXLNhDIZG2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5pop92dcE5WGRfHwBuE8uAp8IlzVeCeVs8FUv+3/BhFyFlFYfuegkHQwHt4tpdQ0
	 VpQPDfqkPi0hZMRwoJGQOYxDBgO7F+vyP3e1l79ZsfTBMPz96CRre8x9to2IyVFKEF
	 WalKAuO6MWrriiv9OW4r7/3256O/b7uhAGaY4Cd3l9vMk8MJp1sXXAPquf1fCH2YX5
	 y5CPgfnORJN8RlMWwZPJrTyeM6QKfe3l515EH6h4vkOUxbdw9XVoGNoPhMI+G4cdwZ
	 gSAjFn5nfjh1Ux7+eRyvW+1VB1LzaeHGYVVN5NgOdXSOyJgVNApfsGmvNe/dTyQ1zK
	 5oxmy3jPjLLHA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 07/27] mm/damon/sysfs: implement report producer directory
Date: Sat, 21 Nov 2026 12:59:51 -0800
Message-ID: <20261121210013.130397-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a sysfs directory for each report producer.  Create and remove
the directories for reports/producers/nr_producers file writes.  It is a
placeholder for sysfs files that will be used for controlling each
report producer.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d3a7cb170975a..7c6bc30c12125 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2979,10 +2979,40 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 	.default_groups = damon_sysfs_kdamonds_groups,
 };
 
+/* producer dir */
+
+struct damon_sysfs_producer {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_producer *damon_sysfs_producer_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_producer);
+}
+
+static void damon_sysfs_producer_release(struct kobject *kobj)
+{
+	struct damon_sysfs_producer *producer = container_of(kobj,
+			struct damon_sysfs_producer, kobj);
+	kfree(producer);
+}
+
+static struct attribute *damon_sysfs_producer_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_producer);
+
+static const struct kobj_type damon_sysfs_producer_ktype = {
+	.release = damon_sysfs_producer_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_producer_groups,
+};
+
 /* producers dir */
 
 struct damon_sysfs_producers {
 	struct kobject kobj;
+	struct damon_sysfs_producer **producers_arr;
 	int nr;
 };
 
@@ -2994,14 +3024,53 @@ static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
 static void damon_sysfs_producers_rm_dirs(
 		struct damon_sysfs_producers *producers)
 {
+	struct damon_sysfs_producer **producers_arr = producers->producers_arr;
+	int i;
+
+	for (i = 0; i < producers->nr; i++) {
+		kobject_del(&producers_arr[i]->kobj);
+		kobject_put(&producers_arr[i]->kobj);
+	}
 	producers->nr = 0;
+	kfree(producers_arr);
+	producers->producers_arr = NULL;
 }
 
 static int damon_sysfs_producers_add_dirs(
 		struct damon_sysfs_producers *producers, int nr_producers)
 {
+	struct damon_sysfs_producer **producers_arr, *producer;
+	int err, i;
+
 	damon_sysfs_producers_rm_dirs(producers);
-	producers->nr = nr_producers;
+	if (!nr_producers)
+		return 0;
+
+	producers_arr = kmalloc_objs(*producers_arr, nr_producers,
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!producers_arr)
+		return -ENOMEM;
+	producers->producers_arr = producers_arr;
+
+	for (i = 0; i < nr_producers; i++) {
+		producer = damon_sysfs_producer_alloc();
+		if (!producer) {
+			damon_sysfs_producers_rm_dirs(producers);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&producer->kobj,
+				&damon_sysfs_producer_ktype, &producers->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&producer->kobj);
+			damon_sysfs_producers_rm_dirs(producers);
+			return err;
+		}
+
+		producers_arr[i] = producer;
+		producers->nr++;
+	}
 	return 0;
 }
 
-- 
2.47.3
