Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F43D8127;
	Sun, 26 Jul 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087589; cv=none; b=lKMweASOi6IIp9zZnku4zz3Kuimphd5/TxaHWF5NQ4vWfnlgFxwz36nhfKnhZ56Ju1gglqu8TsMhUZeRaLaF+dIUmW2sCnDELB69p8zRt+hR/KTae/qFyaZlcEt6PZ6qBC6IXLQmo/GEQYdGIDJJ81fQNwLHwiPXAy+EcG12Ygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087589; c=relaxed/simple;
	bh=dUyNyGHoAjagVsViNZoWoPmtjvkwuQwduMR+IpT6o1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEJh5KbpkGFK/HNm96o1nZU/RtlJNHZCysVjgeKyWn1NKeSzUtwfRx8uyAloPf00qfOoa+V2RNfNTyzUCD2OUsb5fd9Y2eNG+biTzeQ4VnpDvWGYiRGlAoDoXh5cne0fX/e3FwRMf/c/5pozguBcp60xRzJbwmx9/NxMIpf4LX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGt9oWV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGt9oWV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9583D1F00A3D;
	Sun, 26 Jul 2026 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087587;
	bh=NW04Ik3DgSNfNvyKbAbVk3ac4IvNSq5SmgWKpuJrQTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGt9oWV75l5KF+YsDjwm1Ffgls3T3/EXZ4bmxwXAUWJ9BwDJh+jlb02I7v9LMz2XD
	 W8GEzq9wTQAcbDLlAkujdN6D+inoaX0+UlxaYynBBn0e/y4PfeCMSSAgmQPn6/gXI7
	 Bdovx9r+MV3d9kSkzPZN2d+ZSI4xb4fZ7h0GkOg6zynJzeq3vieO1Nx1Lr2VLnrxtg
	 LbAq2VcqTSbU6tMrT2PixWq0roeVphMPRfSQ4aBkb2c/6aysTOH7DOzSFy5hzt6j6g
	 uA8aBg7giE1uizJ/sNn6FX7GZPNj94ZcAdoSJGJkfQnPQo3JbdwKIUzNK/Cs3IKZ6l
	 QJHighYDzT4PQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 10/17] mm/damon/sysfs: create probe preps directory
Date: Sun, 26 Jul 2026 10:39:26 -0700
Message-ID: <20260726173935.94046-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
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
 mm/damon/sysfs.c | 50 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0e4d7a50545e1..6d3ed80fb2eb1 100644
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
@@ -812,7 +822,7 @@ static struct attribute *damon_sysfs_preps_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_preps);
 
-const struct kobj_type damon_sysfs_preps_ktype = {
+static const struct kobj_type damon_sysfs_preps_ktype = {
 	.release = damon_sysfs_preps_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_preps_groups,
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
