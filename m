Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968554;
	b=J1jm1IyF6IrRkmnAGSsh3FApR8oGq/gwJxTtPTjVj5yMgb6Lwy+j5s+42ldLRzfFJyqW
	 32NbXYgi0G5GvPP+myqgKO8XZlKjilMJqloLCcK/BfonEql98QuDB7hPxG0y7XmkSU2VT
	 IBBRtyXespF+hUzxj4YhJYdLPXrxfm6Vc1IqWalQ/7LJ6rGxWkX4m35wa0YLUr3euimeY
	 VIV23U4LFWr7FhMYPq0cjAxg7V7B0TpAkxd7d1iNqiaoKWsVnkvYIhR+AcVNaO6HEnWGi
	 icyhZ8Pc8e8O9Ls3q16stmcKVMYQ2tI197OAWamXEzsDFPgySCIBxI7Fhopak5fppEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0fbCgdlmQEcNgh0aS+DhL0N4RVPNO26toOvZeF/1e4=;
	b=PLhXIp4AiaMHdypAO9nXECoNKL5L5bgBKoaM3X0kLsC5Yh8ZCxuFZc7oacGZPJKaO+IB
	 0XNvG0ANc7njmLMN7sVO2+666jTRmEyF1CFGcM6YqQvyEdW3VYj+MBxvJ/EgMyuVFrIty
	 FkX+r9UNDoj+jWANv4P94CyqyktsDOc0FRdHjxXPuNqnG8O1HV74fPw2GXmjRodIT7F0u
	 O878VGl0jwb+ezgRmW00rS1nVKpaUpXZ3Dz0LSAAQ497It9sA6noFZKsBrGmQQ3/unv0O
	 CF9ygrFx+piQMf+b2zC32XCrk3hLWe2QMfEHcZnCoMMqefSb2Pk38UKxePNgOSV2+gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVjTxzhz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F7606A33F;
	Wed, 18 Nov 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVjTxzhz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294EB1F000C9;
	Wed, 18 Nov 2026 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968554;
	bh=K0fbCgdlmQEcNgh0aS+DhL0N4RVPNO26toOvZeF/1e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVjTxzhzbtFvwoYZAdRvO/peR73ZJ/y7OYDyK6itHj4eYZstjmtC7u6qF3r+xkVBJ
	 ePkxCsN6b8HVFQT35Z15bgTYAGHcwXlijoh4dR8PlaPTJ7oCOr2AXDzAFhYvTQVhDM
	 RFClRsrwSDbJ3fuiKE51O8x6e+k5/y6BVRgf4FMoCwvT/bzlIrUUU8JKhkHos5xb9V
	 zhJ1zOpTPmxQMM8e9XJzLpRlQfeR62LKg5grSAOjh0u9FBzNQWcIha5k+Bsk7v3oRH
	 elD8RZXnI+HOVfrlNywZp7NJTRduWj4wT07VeFdumpAuvqnOphnhBRpclmEd5MJ6mJ
	 jsRF+DgGZIPhQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/27] mm/damon/sysfs: add reports/producers/ directory
Date: Tue, 17 Nov 2026 18:22:00 -0800
Message-ID: <20261118022225.100659-6-sj@kernel.org>
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
