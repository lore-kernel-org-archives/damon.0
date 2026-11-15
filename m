Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774545;
	b=068a2oN0S4t8GX01+Gl/R5ifJ9f9PhOVP9Yb1IgFaKcEvTK8gZcdJTNtRi6gWQPD/coj
	 yuRCisFwDcwSVxMPPCeOa/ALzVurfO9xh1L2ihfH9UkITB6C3JjO3z2dUVfMfmP5tptMZ
	 HU0X7OxI6e6CSMTPXHD/0bIOWG9A0j8KV7zz5dvWOWkrpbmbhz5k7mlNHzQt5n5NCYUCY
	 IgjoIPap+ficnXA7qZsshs9wJdQuN0SExZETjCsMgROJyplUeLIi7ZbwEN1q3XJTqbSEW
	 8bpFROJSLYJClK1AbjOTeyBisicnGV9q2EEH/FBCZT8bhZtTIDP5NbltAi2fsuq2Wtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=en0GKVo205/sJ+JMMbLGyOQzR+GcMBoehXLNhDIZG2Q=;
	b=gz2yeS+++5YGEqcmGPzzwg7MesSlT4f5ByeBBdjbASZTFRIAISfggsTTglXOS/4Yy7uY
	 RaE5NTlYuTWr+tzDuWY54DsRggtwy80sXGvKa1/vACO9ZymCoV35AnRcHGlEOq8Y5Ofb2
	 WgQVBnwQGj+8g+bbc4Li5Z5mgzHAzh6iKlL+np5HhOv7bk9mJBgNXLQhEXuyQ1YZd0QdV
	 ZIpUlqD3jKAbJMhioGwzKHD2JtXdMcZZLbj6QHBv5SUM3OnxuX8gHcAD/lf9dGUDVHsU7
	 FndGLt40pemR80eCpdYDFZUjcipIZGKqIaHSG5guXrK08HzTgjOjjthsC0TniIa+K2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJuxqnA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9B606A8BF;
	Sun, 15 Nov 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJuxqnA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8661F000C4;
	Sun, 15 Nov 2026 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774544;
	bh=en0GKVo205/sJ+JMMbLGyOQzR+GcMBoehXLNhDIZG2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJuxqnA7vCp+b7FmpsTnPT/ZETKdJLtT8hzrwGWgawQU0wSHI4xPt2MYGec7EVwhZ
	 Ambag9w6oVGrZDBczUmsfZKfv/U36LKWQW3yl1ycxMx2TOzgpxacqCW6Qu09V1A9kt
	 iUPB2YbdfJ8vgTQdatGiXmt+nuMTHm2svueCjB2uTI79tITU2caVy6DHS7iQHbLVE1
	 T10wYQqQvcEJUW7tvnT53Y9wtpPQW08nAJDIn3K77siU1ZFV0wEcfbITs7PbOm7l0r
	 7YfSQ2P6CL+3yv475+wiZpoDN9puFN/TZfLw2QNZAr+tmh83uYOn0SGeSSt7YRYFuv
	 1Zplg2L46BODA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/27] mm/damon/sysfs: implement report producer directory
Date: Sun, 15 Nov 2026 12:28:25 -0800
Message-ID: <20261115202849.99134-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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
