Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294823;
	b=ePWD9USevQEhsi7E0nmOEv9ut0s/5x/6FwjtvnX646tzuMo4ImBCJEdwHIcnVLvebHXM
	 yHHVUBaEOs262sk4+8jG3Yn3E3ml6Z8AcBwWWYGGMWCd1guwzuczNXCoq7m5PjK2cf5X0
	 tel112+vAEq16k8L/0FiGw+aMBIgyv/LNPNZE2g47UmrMwJzySbON3rb5JoOUqZk8rbTI
	 nX0IItdCOP7bGNH6z9U6bDyd6o1fIDB9WzakgcJLNtvabi+AdFFHELZMyQHprlJfYPAmg
	 xf/b56OFuV2D2EXBn47MNwgZx2z3YTyBOumgxxH/dLwzvDmho/sQjCjnMBQlK/I3GLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0fbCgdlmQEcNgh0aS+DhL0N4RVPNO26toOvZeF/1e4=;
	b=IWXwdjJFJoxL2A7SeT7TXpt2rTTNieB9x2y9mAum+1GKTa/2/nR0OPz7EgQYX5Q7vhmq
	 GVrAvv33JdOOY8qgnZnN6RqrFpcGgN2yF+a4gNFyUtBPONhTCTZKW1BH6OTQgqYWZNl+k
	 jCuzCG4M+yMr2exWTh8SLX0Uc3Wjj+RDqsHxKmN6K0eOzw5aTMXvHpbHlNi2ct0DgHNrY
	 4yF59f2+4SpaLWHiHwEWNo+5d+4S5E4RvkPdjePGhA0fyL/wRPom0L9HnBNyhy1lgkhfK
	 MgB3IqFMgZ8c6I2/Xzsk/ccucDTfZOQ/d9BPtOWJ6GuS48yjwJsmXyT+8rmSdvWGl3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G31lUkYi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D78606A334
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G31lUkYi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DBB1F000C6;
	Sat, 21 Nov 2026 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294822;
	bh=K0fbCgdlmQEcNgh0aS+DhL0N4RVPNO26toOvZeF/1e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G31lUkYiM7RSguSM5A+wq7uDAC5yYL2rCZeF9Sz3m4NZmjQtyeevALKpDzBWdEBBj
	 hxSG6F/taqg8InowVcMsAmvKZbOPXfgM4hGhHIM2HYse+0/XBrBlu9QTcPR/0CeY6V
	 ZelTFDDoUT/Khp+E6o1KtoJk+UtdR00q5F4rtMnH1tBdKPn7D1/Xb8k5M73RCI56mA
	 mMEFeFQk3+OvPN0Vcslh0jPPVT1Jb6MdMuXWrcEzFyuQTlWKmaxCYAgFOm3dpIdi9G
	 RnCfdngXCEA4Cxupv2nmnFqr2KuzvTw6BKluvHcg+559B8k3hO/9m3ZJYpTAY7kTzr
	 fRtFmsVFyQMkg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 05/27] mm/damon/sysfs: add reports/producers/ directory
Date: Sat, 21 Nov 2026 12:59:49 -0800
Message-ID: <20261121210013.130397-6-sj@kernel.org>
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

Add a new sysfs directory, producers/, under reports/ directory.  It is
a placeholder for files that will be used for controlling DAMON report
producers.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 76850a4b5b5a7..75701ed662222 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2979,10 +2979,38 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 	.default_groups = damon_sysfs_kdamonds_groups,
 };
 
+/* producers dir */
+
+struct damon_sysfs_producers {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_producers);
+}
+
+static void damon_sysfs_producers_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_producers, kobj));
+}
+
+static struct attribute *damon_sysfs_producers_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_producers);
+
+static const struct kobj_type damon_sysfs_producers_ktype = {
+	.release = damon_sysfs_producers_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_producers_groups,
+};
+
 /* reports dir */
 
 struct damon_sysfs_reports {
 	struct kobject kobj;
+	struct damon_sysfs_producers *producers;
 };
 
 static struct damon_sysfs_reports *damon_sysfs_reports_alloc(void)
@@ -2992,7 +3020,25 @@ static struct damon_sysfs_reports *damon_sysfs_reports_alloc(void)
 
 static int damon_sysfs_reports_add_dirs(struct damon_sysfs_reports *reports)
 {
-	return 0;
+	struct damon_sysfs_producers *producers;
+	int err;
+
+	producers = damon_sysfs_producers_alloc();
+	if (!producers)
+		return -ENOMEM;
+	reports->producers = producers;
+
+	err = kobject_init_and_add(&producers->kobj,
+			&damon_sysfs_producers_ktype, &reports->kobj,
+			"producers");
+	if (err)
+		goto put_producers_out;
+	return err;
+
+put_producers_out:
+	kobject_put(&producers->kobj);
+	reports->producers = NULL;
+	return err;
 }
 
 static void damon_sysfs_reports_release(struct kobject *kobj)
-- 
2.47.3
