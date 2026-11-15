Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774544;
	b=4MC/5OGsVd/eyKm3cy/tb2Z8Q4xjqB+FmxA6WhA7PzBOWegmR7TItMLl1EdnTkrXnE9a
	 J9SPxtpKxUs2pJQSfwxGWGCIy1CtswZ9kTaGIfeRK6qSe+yJCxGm75x77B/K+aoyEC22d
	 J/CRLx3y6RZZVqGFXZteACayi7ExijJ5JlaARwHmJpgMdCgvsHar8/2q2gugOqSjET8tP
	 im4T+qVg2ePFbFT1TztNV9mwlc5oN2zkg4pjlbx32GNoq4KQZvFlokW6UBzFwgGG/2a/k
	 bkMPjdgz5DKE7GE46y2wbuy+2J+Zg2YKJ1GBZPcqpuscpwlYSQeAOFXJGBBYzCicdPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0fbCgdlmQEcNgh0aS+DhL0N4RVPNO26toOvZeF/1e4=;
	b=2MQoWtTNHjT0pw5UG5Lru6yPdSkKKwbDC8QqHZrdT87KSfSlwjiJxFX2dcB3gQvtbDzp
	 hbeVuzbEwUAumRKPv/peIasoowPAvb67kvRsRk9pGe3C4T8vxGu9GJ2iF1+xPNg/ZFsOF
	 XoepE6fmK7+KM6TubwRG/5VwFyunTEtNOMgMu/+V8ogC6XHK4ZiSd90w4JhhOX11dohoS
	 fhjH732supru7zJjKBMy6usXEmyzcmvzmELN0E+g4Sc6wFCxwFOrjr7NfCp/vJXMv2V+r
	 jgEiM2mP3H92O8FpUnBrW/4RQFjdXm9oLdOfFNrcts6B3FqxgXmFTmIENoOAFVm/n6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3GgOZyM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45622606A89F;
	Sun, 15 Nov 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3GgOZyM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B4E1F000CC;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774544;
	bh=K0fbCgdlmQEcNgh0aS+DhL0N4RVPNO26toOvZeF/1e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3GgOZyMP6N/oz6lt2qijgoWYHq37lYMDfbWcrg8BxhsUdjpLKjmXAMrxXBz6Xp6x
	 xGUxbmFLIaObe0nNMftjAuDBS4Ep4RpRwFk42FryRNh0gU6y8vz5iJ1eJ6nT+CulGk
	 aXkwsj8ewU4uEfEiUzfU0ksPfudeom5F5+QB2Z+6I1Zf6+i/PTLTY7rcFj1+DW0BXV
	 2Abt5l8UB9HMr6JYDhhiGpSL5enKDSSNe1lA7Sec+Hr29VYf8/RKdipLeXMNgB/gir
	 JqjFUc+3dmzc0V6yQ+/xpZQJ4p3VvTYmhkhemoBirSes1iXCCRd2OBQR16DBL6MtCB
	 pXZP1r+kLK72A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/27] mm/damon/sysfs: add reports/producers/ directory
Date: Sun, 15 Nov 2026 12:28:23 -0800
Message-ID: <20261115202849.99134-6-sj@kernel.org>
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
