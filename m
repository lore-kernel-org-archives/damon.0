Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968554;
	b=qzS3uv4kywnnt0VE4xHjNam5oclAxVrdQJNSL9lBxDxC4e6XM8mpUUlNm86IGVTpoIit
	 CdLrI1IursIHsFKjgWhng6y35F6PLpn/gcptE3/2tEPImdaW67tAvPOQ7bOtIRj1g9vMY
	 TBfjnxO8HskbiFCmml95BO1x3z3HpNBmczvLgHLAo9D+D/MXsL68eg6yKVSGQJNWqOHOS
	 rJ2YzQYxzD9bQle3g1vyfXgQd99lJg1x7yd5agSaaDuByXaj8WhLuMvAk0MqCRndTmmfK
	 I9Vhq1lMW00tztNoThe9sK4iaPqCkltKfSI5fQZ11RsF92QQQ5Hu2CWJpjnh5EYW03w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5c6monTkHFptnJUFGVWxm0WfYIjXGBI118GDWY/b424=;
	b=xpp7vbd2axUZmzrOhF9Jh8VPfW6CnSRsfqcxC0PO+o94S/omLEKtsj0KkcEF6KgpmAqC
	 1DlYCEkiTUIUtyWy9UtWssgztMs2c8xSrCIXcrpz/w4vd2deABY6cBQ9Ac4bxBHWHruT2
	 OG07KeOt4xwxFqgDXEz6yckwgIL+Tcnvd1aznZrYApNV+eq+wZaSkuhbK+l0OYdUmJvov
	 tzunzAQAMxSJ+kbZEbMiCqjwB2eB3VL+LokGDd+JcmOwsyMxCHXzjw+dLrljME4rguvaX
	 xZzwuU78NggVdhLMKN8wtROCCRbHM+HwG8VwPpL8ieFMrKHZeyJvEVFV5HLkEB6MMBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIt4nj4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAF606A88C;
	Wed, 18 Nov 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIt4nj4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9831F000CB;
	Wed, 18 Nov 2026 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968554;
	bh=5c6monTkHFptnJUFGVWxm0WfYIjXGBI118GDWY/b424=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIt4nj4E8yhNZYSrWL7LUfPh0eTnD5O0HrQDKf9hNsDD1Exo7ima8se/J3MpMxKBm
	 3S3Txs6RYRWZ+2XD3QChjua8POhdgfHnHdHFaqi2+tLCxkeheiTq9LH2zM5onggHSs
	 rDc69DOH5/HhAnmjYYozmN9buXJPYGeRzXu00ohYahiFM0xM/QYqJvoiRdQKx3cBsP
	 UbzkItuNhYVWxDG/LxZGzqHX8q7hrRw8hhFpIatfpG95oaFXB3FAnWbhLGqXbVZ/Jj
	 /MhGM270sygx5zKjbvhGGI7WgXh4CuEOz2rfZgA0r1cHP/MhcH0t7MdeeHLlXOUS8h
	 DfvTyr9UvTQMg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 04/27] mm/damon/sysfs: add admin/reports/ directory
Date: Tue, 17 Nov 2026 18:21:59 -0800
Message-ID: <20261118022225.100659-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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

Add a new sysfs directory, reports/, as a place holder for sysfs files
that will be used for controlling the data attribute report system.  Put
the directory under the admin/ directory, next to kdamonds/ directory.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 779c98205a94b..76850a4b5b5a7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2979,6 +2979,38 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 	.default_groups = damon_sysfs_kdamonds_groups,
 };
 
+/* reports dir */
+
+struct damon_sysfs_reports {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_reports *damon_sysfs_reports_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_reports);
+}
+
+static int damon_sysfs_reports_add_dirs(struct damon_sysfs_reports *reports)
+{
+	return 0;
+}
+
+static void damon_sysfs_reports_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_reports, kobj));
+}
+
+static struct attribute *damon_sysfs_reports_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_reports);
+
+static const struct kobj_type damon_sysfs_reports_ktype = {
+	.release = damon_sysfs_reports_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_reports_groups,
+};
+
 /*
  * damon user interface directory
  */
@@ -2986,6 +3018,7 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 struct damon_sysfs_ui_dir {
 	struct kobject kobj;
 	struct damon_sysfs_kdamonds *kdamonds;
+	struct damon_sysfs_reports *reports;
 };
 
 static struct damon_sysfs_ui_dir *damon_sysfs_ui_dir_alloc(void)
@@ -2996,6 +3029,7 @@ static struct damon_sysfs_ui_dir *damon_sysfs_ui_dir_alloc(void)
 static int damon_sysfs_ui_dir_add_dirs(struct damon_sysfs_ui_dir *ui_dir)
 {
 	struct damon_sysfs_kdamonds *kdamonds;
+	struct damon_sysfs_reports *reports;
 	int err;
 
 	kdamonds = damon_sysfs_kdamonds_alloc();
@@ -3005,11 +3039,32 @@ static int damon_sysfs_ui_dir_add_dirs(struct damon_sysfs_ui_dir *ui_dir)
 	err = kobject_init_and_add(&kdamonds->kobj,
 			&damon_sysfs_kdamonds_ktype, &ui_dir->kobj,
 			"kdamonds");
-	if (err) {
-		kobject_put(&kdamonds->kobj);
-		return err;
-	}
+	if (err)
+		goto put_kdamonds_out;
 	ui_dir->kdamonds = kdamonds;
+
+	reports = damon_sysfs_reports_alloc();
+	if (!reports) {
+		err = -ENOMEM;
+		goto put_kdamonds_out;
+	}
+	ui_dir->reports = reports;
+
+	err = kobject_init_and_add(&reports->kobj, &damon_sysfs_reports_ktype,
+			&ui_dir->kobj, "reports");
+	if (err)
+		goto put_reports_out;
+	err = damon_sysfs_reports_add_dirs(reports);
+	if (err)
+		goto put_reports_out;
+	return err;
+
+put_reports_out:
+	kobject_put(&reports->kobj);
+	ui_dir->reports = NULL;
+put_kdamonds_out:
+	kobject_put(&kdamonds->kobj);
+	ui_dir->kdamonds = NULL;
 	return err;
 }
 
-- 
2.47.3
