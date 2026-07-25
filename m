Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F637C906;
	Sat, 25 Jul 2026 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013360; cv=none; b=NeFrhyaaYgvDs9P44H0G6VOnjGCX8k+YE0by6cRuiRTu9yPLj2G+a3wi9CRP/F2/YkvndR1FNuekMsnUyrhzzjikJqAM01QE+xY0iLgAiZH2zs+Rrm7ZZDxy+viPE90rm2Jac5xG43KXtsRMbWd8jrPqC5gfB1Ul/c6SIChYAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013360; c=relaxed/simple;
	bh=sz0CjYvpt6aNz5JQVYSRvhMLrWbyeiH5bxS8pGC+h2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU6m/wkPYvIBKhQxU6PV88Zh0Txzv1OSwbFe1PZJefTwA+sf889fwe8yl7gAdOG7w5Pk1hj50piXt2kuRh0apnQ76WzK1kolseFb3jPYFavgfcXPwVuLzGl2ZMe3yDIsdEA87svXyYZVnV9lT171Y+I9KBIpDmOc7LUoiAWg/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBKBsr0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBKBsr0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832F61F00ACA;
	Sat, 25 Jul 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013358;
	bh=LmA3iKd/w3WhYo4qwFeV2q0iE2mBXogisOL0j6VtBhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TBKBsr0m37fHqDZv+bnQf0ZwWA0bMy5FfmqnyQ4nY0BSsjNvPa0UkKiBBJ8BtOaQF
	 2VPEAvztnLfYZRBsL1BxAqN9+VDKXe/smRPl/eZaFS5BSQsEl5y58ZoG++7evSp9pF
	 aCHsFkxQDEEVTsRTarEIPQQpYjefLIEKRlmlAIrQK82LQkDB3wUUc4YA6e5Ec5vdSH
	 yT66FY989zM3jIcbfkgzhlG6KxmS1WU/zEDtnfECbbSD1tmWa04KtykNj6FAykIeUK
	 7/q4iGI/3sDBYN4SIf3GTpHPLvdD9vGNSJZLbaeIyj5LnF3/xv56M2Lb1pa/IWWGUP
	 njXiLjA7GE4Vg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 12/17] mm/damon/sysfs: create probe prep files for preps/nr file write
Date: Sat, 25 Jul 2026 14:02:16 -0700
Message-ID: <20260725210225.129944-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement preps/nr file write operation to really create the probe prep
directories and their files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b15ec082109b7..f275a6f73eee1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -759,6 +759,17 @@ struct damon_sysfs_prep {
 	enum damon_prep_action action;
 };
 
+static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)
+{
+	struct damon_sysfs_prep *prep;
+
+	prep = kzalloc_obj(struct damon_sysfs_prep);
+	if (!prep)
+		return prep;
+	prep->action = DAMON_PREP_SET_PGIDLE;
+	return prep;
+}
+
 struct damon_sysfs_prep_action_name {
 	enum damon_prep_action action;
 	char *name;
@@ -839,6 +850,7 @@ static const struct kobj_type damon_sysfs_prep_ktype = {
 
 struct damon_sysfs_preps {
 	struct kobject kobj;
+	struct damon_sysfs_prep **preps_arr;
 	int nr;
 };
 
@@ -849,13 +861,53 @@ static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
 
 static void damon_sysfs_preps_rm_dirs(struct damon_sysfs_preps *preps)
 {
+	struct damon_sysfs_prep **preps_arr = preps->preps_arr;
+	int i;
+
+	for (i = 0; i < preps->nr; i++) {
+		kobject_del(&preps_arr[i]->kobj);
+		kobject_put(&preps_arr[i]->kobj);
+	}
 	preps->nr = 0;
+	kfree(preps_arr);
+	preps->preps_arr = NULL;
 }
 
 static int damon_sysfs_preps_add_dirs(struct damon_sysfs_preps *preps,
 		int nr_preps)
 {
-	preps->nr = nr_preps;
+	struct damon_sysfs_prep **preps_arr, *prep;
+	int err, i;
+
+	damon_sysfs_preps_rm_dirs(preps);
+	if (!nr_preps)
+		return 0;
+
+	preps_arr = kmalloc_objs(*preps_arr, nr_preps,
+				   GFP_KERNEL | __GFP_NOWARN);
+	if (!preps_arr)
+		return -ENOMEM;
+	preps->preps_arr = preps_arr;
+
+	for (i = 0; i < nr_preps; i++) {
+		prep = damon_sysfs_prep_alloc();
+		if (!prep) {
+			damon_sysfs_preps_rm_dirs(preps);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&prep->kobj,
+				&damon_sysfs_prep_ktype, &preps->kobj, "%d",
+				i);
+		if (err) {
+			kobject_put(&prep->kobj);
+			damon_sysfs_preps_rm_dirs(preps);
+			return err;
+		}
+
+		preps_arr[i] = prep;
+		preps->nr++;
+	}
 	return 0;
 }
 
-- 
2.47.3
