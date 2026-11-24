Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534608;
	b=QBG7+Zqteg6HTC8+zVHw+GYhrIgf/+6jvLz/LUpJyoNL935tC0RBKc4Sz6pe/VcNNDxH
	 Q9zS2+BSB31O5iURa7UbaDPPGJKvriox7plR3Bdz8K5vme5GByvzSUs06QwKQfBD2cOva
	 CapziA99dT4b/PPmOGQj4Sec/JKk3oYh7Rw+qENsorDbtd8EY0l3bnmF1qkg8OsVPfO3z
	 1BkBQ8Diuh/v2l+GmAKWxA6eXRsHIvwcM6lHOIHTA6dPrZnsuWNVqYTSvsOrzNgxTXOlC
	 FWR5zZkQ/BzZNS7r95Gw1TuqU03M/SS+x/rJwD1+1cxkOeSNtSCOrdNd+yuvrSZ9Jxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jluGUFf39U7y2mDECHz3t0tayGa6/18eFwFEuC7VXRM=;
	b=uRN6L7pexwi3V6NBvJpbo+piAhLlVpLQuj2CxCM9gdqy2nQHGqVZCzBlLQ8eFGNG+UzQ
	 XvdBJCgRyF9Pw8MjUzbNpprXPXv60fd4Xi895OYWTW4w0bfUzfZJn+2yHoCAzAcAgWK/V
	 O6dD1ORgCECuV7SCtGRs0ZnkAidPYh3qkIIx9EhPAx8uJbUOnRx+T6HS6sXfGib2N2yo5
	 rbKuB4oEYRisB3lD52mx3CRmM9XdyFNxE/0NNgSLgAN+Cy0hHVoTAJBi0N5rpHxGDa0+i
	 1VuZKOPtU7Epg3N47Y2U00F+ZuklA2UrXPJxvT/9hxUIMUKYiYEU78m7xzM8jeA8qBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fiigvl55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23516606A321
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fiigvl55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C05B1F000C6;
	Tue, 24 Nov 2026 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534607;
	bh=jluGUFf39U7y2mDECHz3t0tayGa6/18eFwFEuC7VXRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fiigvl55OzJtZ4ml30yEPa6qu8WqYEuwNGgSxJaXRGioXJB9PIcfnU4+qsrfeXdNy
	 YCvXl0KUwu5Ah6Sy4824M5AmBQvbJCzz8TpjQHJpEVeO2TVWUglMobwFVSnSE/5K+H
	 ReEcWPGkpGpYJ6XhQFnT2KtBLtd7ao8qSzLwIzLy8y9vlkmmo3WB3acwfb/TN+XuTV
	 DY6ZDUEx484nf7F+o0+Ny+U5LcY8b91t6d1z9YQSLcZxVVJ1+VtFCQIiyVHwcFLz/0
	 CckPlCFqtGtoyyV28nou3dbkfmXNvKKmMw4TLRpAfYSF3qzoaLF1DGH2Mz1UA4eA9k
	 lys4s4d5t9nlQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 05/27] mm/damon/sysfs: add reports/producers/ directory
Date: Tue, 24 Nov 2026 07:36:11 -0800
Message-ID: <20261124153636.91854-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
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
