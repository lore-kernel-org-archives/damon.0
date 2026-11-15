Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774544;
	b=bDM2VAiSx/M0YL8r0/lMScHoKuFOl49CFkUT/RquPw/8owkIo2+eE7LbZb6FU4nDaddo
	 qm2kFRlDde9l47rs4fKhTjiFnCUKWVaXQO1hi2+iolZ6GeidAG9ijL9jgctihRTd0OaXA
	 cb/V4Bzyg/buZy2+BQhRmQIpqfLuBZuTzlkmNt8NLsqX4FSXPimznqn8R9sSW+S1QRw35
	 U2Y5l2yK4+G7ZzNVgT1aDcIz0jAI5mhLEFayhANwonDxUEhFfR/WdYIDAaVsR/YO1N+Lh
	 HNkrssQr7EkSaecCNkVNtSr92sefq0ghJTWabCIc0N7O0hkn7i/YADDyNfaTWWtnCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5c6monTkHFptnJUFGVWxm0WfYIjXGBI118GDWY/b424=;
	b=3kPuxPH0FalvlORDlYLR+bE2nURTKavd1XdPN+Zfzsxqc/EnP2f5VRC/NMcyFMmSviBk
	 bLr0K7ke7JMjDcUYtOzLfZEqUTGZBEdI/Bl4LnYVNmutpM6QkT9/ga26CGItKlzOuaSd7
	 IF2YOyCmh1ojzVAWi42fc9/CRsnexyh3WbB4a4i+XRSwYQuqGdNY4j3a6rg8wFnTTuLqq
	 Uy6wqa7c81/ccHfmZ5fv7NneSavofYjZamhfNi7FEr3NAvi5KeqVwUvEace13QR33jKbR
	 L+5PbjlPYrNOZMDzuk5L3YJSlaQM/aASaWOvtJgEHtkRfNp28kRoiglqJNzY+SUqlqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDYv5s3x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0C606A896;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDYv5s3x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43A31F000C4;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774543;
	bh=5c6monTkHFptnJUFGVWxm0WfYIjXGBI118GDWY/b424=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDYv5s3xbVH+cAMBWN79DdYCzSB1wVAZmOj53dHrzr5tNpMNBN8VMPY/t/DEKrB+Y
	 hRb2v0BwOAudikrb9NOLGgDn7KSP6tU8HwzKzjvqNFMugk9iWRxAduZoT2mKJyeU9k
	 +JPPgRRCxeOLge5Z+hRVNqQ1JyMROQWRu0kvbBcib8nlf7MpgbASGKZFAxuKsUo2Tb
	 dH3uO12QBC+BEomWN/1FPZMMAeGacQcogy/XnDw7k1tXJVzVwjXKv4+iFlVaTC3B72
	 fzduUMIihIzqRmwvxGjwER2CpCBEpxYQGHTuQZSyG01kExlmKkf2q/wH2yiCAz+IWh
	 ZUerOJnoJge0Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/27] mm/damon/sysfs: add admin/reports/ directory
Date: Sun, 15 Nov 2026 12:28:22 -0800
Message-ID: <20261115202849.99134-5-sj@kernel.org>
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
