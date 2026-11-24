Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534607;
	b=d3zgb4tTF4HLkxYbZMs31zYMlYrY35oKwBFtSrMHpqZ+j3hgg4KBBeOZpKZHttOM8cOb
	 jEbsXk0FeeHNWf7sbL0eK3LXYHwE0svk+BLtwziLF5RsG+e6SW53TyXRCb1DCnJCmMA73
	 vbhTPxe/Nz5rrjUD06vcP4u5X0fOwl9ibrHOMIT1IGRMLeCvMlzALwZZyyENFwsDu/AeU
	 FhyVsbktjR+WAkViYSbb1w5wU/cStja3M55TkVAn6DqVCgq5qZ45suPA7DBgV0bbe3/g7
	 HOublbJg1Fl5RyqeVzaVWKlcy/+fDHxzDNARHxq6YI9oRDuA9LNMDnqxOYvaW2v00zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qirt3ZX0FbMTabmEssD6ikj1DbvFkhAbJB6fB/k07m4=;
	b=APmly6Vm1YfGFTxQNlypTY4hVyC52rnGejmCbbBnlQoV49Pyv2EkkA/EIe+wSRDmW15B
	 PDKgnXMQzD9eLCv91VNO+hvfhgQjwNOaXEcyqZPZm8YhN9j5funlYY7PEZB41XrIcKqKe
	 zNdJ01M6cEvihDnxz8X5dR1HLeqjw7LubjrScpT1tT/+YLAEI9F9DrfO5wE3+GgdyJQ5y
	 Fzj7B7NC0IYsgLaffXx+qYgZBvukrFHUWrrxUgMBwhmef802qV8phGy8FlshNReyp6xbB
	 MmkKIYJc3MJfXNmpEh7yFYZpIhej8iqxLM3NYvbDTnsns7pJwR84zA6SrGDUT+FcQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/uP0SPS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845F606A323
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/uP0SPS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75131F000C0;
	Tue, 24 Nov 2026 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534607;
	bh=qirt3ZX0FbMTabmEssD6ikj1DbvFkhAbJB6fB/k07m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/uP0SPSZYWh7cqUQXUP7KpPGGqYnsyVXKKi2eQAuYb4D5GjN9ztBQY/GvbAoMVlT
	 M9pSuMOZdnpndkGM3fWw/PAdtsOHGG+4UXRhXJAWwcIchbrtNFWqCTXknC7HBj+s7g
	 z3FV0j5X13yaQRhqXR2mN+QP8EHjY1lJnvLQAFDsZUeEpnTS5yVH+XxrJsGp5xLl08
	 70gYEtlI/QS/b1AQyP+OSEJxQxx0AnB8ItZJqdelTKJU5RcbbIwLg8fkSwfYTJeSMI
	 QuEFf2mhk+b2RuQlS1FZD6/h3zQ489ema1FpjGZk5G9ydaP626dmVT597Ue7Gqocli
	 iHV2LnLkNq63g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 04/27] mm/damon/sysfs: add admin/reports/ directory
Date: Tue, 24 Nov 2026 07:36:10 -0800
Message-ID: <20261124153636.91854-5-sj@kernel.org>
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

Add a new sysfs directory, reports/, as a place holder for sysfs files
that will be used for controlling the data attribute report system.  Put
the directory under the admin/ directory, next to kdamonds/ directory.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
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
