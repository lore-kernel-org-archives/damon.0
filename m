Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF6378833;
	Sat, 25 Jul 2026 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013359; cv=none; b=IWuzlDLpe1XIwGqf96xF05kjf9NXGUDjeSzauzF0uQmmR89GOk12nmjIHWZGOaH66Qt9o9XZ6ieC9y009HmI8V5VuQWzVtp+1j4Kw1qheRGa700YHcS1pFsCtaEDpzpr35WiFtPF9j2H0RJW5q9MdlRhj+OPHc9g1bGdK0/bqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013359; c=relaxed/simple;
	bh=NajOXiFY6T8wdAbKy0A+kHHT7P17Ah4qcxo/Kn7Twa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vzv9hN/a5QUzGaQ2woV7D7Ja7DZPgHfHlXQ/GYD1+TJudg/WnHsqdeG4EYA7pbE8w2TcT39Dco86NsD+klxKnQcDxltLHjd825ggamNYovZMdUZgLDMsIn1FeAtJ4DXIBLGRiyZt+gYAsaljEjAo2VoOpkCujYnO2SSU3IgRcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiZMyBl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiZMyBl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF621F00A3F;
	Sat, 25 Jul 2026 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013358;
	bh=UduVFa2f9m90XMStvUkd2JUFPgh2VQgxt8rOrBb+Gjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GiZMyBl152MTY65nBUjhdwJYsLmBRP2br0p6tqhKfU4Zf94TVQ0K8cnr6yz9X2i5w
	 jYHxFXwbetlDxvGFsiAwRk4++NdbCZM5eZ71DASe9PrxxF++jE+44CBtvNf9BBlfZb
	 k1o7leRxvCtOJuPPQiMVTIYhL46W4gNYJm6SvEAQ7L8Bj1GXP3t/oUXySMKZuMUBiS
	 w+M2K1oqeagPnvcBe5MMfgIj/FRDe4IZIslPZoXFzzozpxBuqchC/tasMz8rNoJKMV
	 sdHxDP0g13PxCSCTFteFmcodC3fGBdzq7FSW3BGMx2UJmY3ZRPWrjtxtXaOezt7Zo8
	 TRywa9UoaSyFA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/17] mm/damon/sysfs: create probe preps directory
Date: Sat, 25 Jul 2026 14:02:14 -0700
Message-ID: <20260725210225.129944-11-sj@kernel.org>
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

Create probe preps directory when the probe directory is generated.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7b971bfd1169f..6d3ed80fb2eb1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -759,6 +759,16 @@ struct damon_sysfs_preps {
 	int nr;
 };
 
+static struct damon_sysfs_preps *damon_sysfs_preps_alloc(void)
+{
+	return kzalloc_obj(struct damon_sysfs_preps);
+}
+
+static void damon_sysfs_preps_rm_dirs(struct damon_sysfs_preps *preps)
+{
+	preps->nr = 0;
+}
+
 static int damon_sysfs_preps_add_dirs(struct damon_sysfs_preps *preps,
 		int nr_preps)
 {
@@ -1138,6 +1148,7 @@ static const struct kobj_type damon_sysfs_filters_ktype = {
 struct damon_sysfs_probe {
 	struct kobject kobj;
 	unsigned int weight;
+	struct damon_sysfs_preps *preps;
 	struct damon_sysfs_filters *filters;
 };
 
@@ -1148,25 +1159,50 @@ static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
 
 static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 {
+	struct damon_sysfs_preps *preps;
 	struct damon_sysfs_filters *filters;
 	int err;
 
-	filters = damon_sysfs_filters_alloc();
-	if (!filters)
+	preps = damon_sysfs_preps_alloc();
+	if (!preps)
 		return -ENOMEM;
+	probe->preps = preps;
+
+	err = kobject_init_and_add(&preps->kobj, &damon_sysfs_preps_ktype,
+			&probe->kobj, "preps");
+	if (err)
+		goto put_preps_out;
+
+	filters = damon_sysfs_filters_alloc();
+	if (!filters) {
+		err = -ENOMEM;
+		goto del_preps_out;
+	}
 	probe->filters = filters;
 
 	err = kobject_init_and_add(&filters->kobj, &damon_sysfs_filters_ktype,
 			&probe->kobj, "filters");
-	if (err) {
-		kobject_put(&filters->kobj);
-		probe->filters = NULL;
-	}
+	if (err)
+		goto put_filters_out;
+	return err;
+
+put_filters_out:
+	kobject_put(&filters->kobj);
+	probe->filters = NULL;
+del_preps_out:
+	kobject_del(&preps->kobj);
+put_preps_out:
+	kobject_put(&preps->kobj);
+	probe->preps = NULL;
 	return err;
 }
 
 static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
 {
+	if (probe->preps) {
+		damon_sysfs_preps_rm_dirs(probe->preps);
+		kobject_put(&probe->preps->kobj);
+	}
 	if (probe->filters) {
 		damon_sysfs_filters_rm_dirs(probe->filters);
 		kobject_put(&probe->filters->kobj);
-- 
2.47.3
