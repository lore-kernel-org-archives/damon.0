Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294823;
	b=sA9tQX8Dv3BtrCzkT4PljykkLJIINv48x3pgcz2Tw773STiuCuuRryPwzOW/QCNvtVuJ
	 ncLujbKOo7++75EbQg8lKRhxEQT2n+OSPYkB0IB3evplPyhHcrfdQ3Lb/9yJ3GjXif0Uk
	 mjend2KlY04gTBXTwPyOBSJbZek5aDBQYPqCbVhqjsh2jMsBJpaEpoMHE3QIEC08hh40q
	 p6jKNXEAaSNolNOv4BOaTHVYn1Ax7Uy7wJoK2R8SmMjraMHNemflDjkMd+LdXrwYNS/VW
	 66fD6QrRMo9ZUwYRO8htgkorooJmSGd6ydzsLXRPRG7oFYi6Ag2SZAdXkH2Nr/ghc6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5c6monTkHFptnJUFGVWxm0WfYIjXGBI118GDWY/b424=;
	b=ZQbdvSDzjpWAOPVUavuE4zsjdpmT6Jf4WSl2Bfsc/+qdeJ56P1e8Zdi7rEbLELmScqUl
	 zyMt9JOo+7aDv53YbLAlvI42ytQvuDndYDElU49h3l8LLBeWvxcrvh/6Ah+RkgY72okIn
	 FygB9DlWum5Uq5Ey/GrO2ewnLtVdF6uzfVw+ck99w1BQC3xAE4Ox44Du/Soo/Xn3xhjFp
	 kcDRzlp6wHjNr8ZQyeMl+7e5NIsMQHLSLGTanA7clHAXGRFdTkIG9amnllOSuPMjQMU/Y
	 0zNUTK60fJiU6EdE5h99zinCW8lhAtX6os79odio+QjFq2CV/HCE4LVAWCA3U0jSmCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2Z1lxAE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67A5606A330
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2Z1lxAE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712761F000D3;
	Sat, 21 Nov 2026 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294822;
	bh=5c6monTkHFptnJUFGVWxm0WfYIjXGBI118GDWY/b424=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2Z1lxAEzydCKqSs3ZpORGFow7SsTZ3C1Qoq52359vyMJ5unfjscNLzdGdnYpMOz/
	 c58HUK6WUNkwGM+ELO+luxPVA3Cx09KoUY5f5gwcstuscEW/lduJvekVzyiin8VdNv
	 S5pL8oLVnuB1A/rW3cv5imBbDs6OmAVeBJWKpfowsAnytdsuDKK/ca8efgUvxBe+Yk
	 i9BrImICBg3BvpbZsv++9hh/zQ1HdpeBAnxWhItbwW6AMFx/U9fbTIJiJZlY5kNcjM
	 XBlGFL79MiURXpvXBwctqAet9B+SpYoCON7sjShyFGSvdCGjVZPT1t0K/YE6IRU27I
	 54CQYdgxBPrnQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 04/27] mm/damon/sysfs: add admin/reports/ directory
Date: Sat, 21 Nov 2026 12:59:48 -0800
Message-ID: <20261121210013.130397-5-sj@kernel.org>
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
