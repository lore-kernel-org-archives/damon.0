Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5340DFAA
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102177; cv=none; b=OjR20ptVZXjm8CZnp/Vlofvhp0jYzPq/n2pgNtnDfXGPDF8rv02+cfXkI0nBnFDHojsRU0cLW07T8xNIecloiSDvAJHerF6hyVn30q5wwW7EZtnN+hTu+4EoMtpaWrzu40LS9JQoPzCveqeo7LOfCHmom4PiZhFqZCGpQk6F/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102177; c=relaxed/simple;
	bh=VZ6evFNdd971Ba44nmGwK0sEFRh5oT+tTxpcoINzvhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBCA+FjBwQU+S/DfG11INCV103kqkxd12EZOspwxQ1sNdyGg4INUwqd7EU1q0NtQTjUijEUe3Apx81yyvDdQ12oADd1+4CaUE0lVwhi028iBzmbOsj2uDT0tabxAlB2CQHxhYzXubYTXNzBS06yTr0TOF3IHWafbsIBxmxsQOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix2PWRAx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix2PWRAx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b056b7f783so14127825ad.1
        for <damon@lists.linux.dev>; Sat, 21 Mar 2026 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102175; x=1774706975; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qYuRLOkVEr0vMq2UyeWKGNVMl1LS0aZ8xRKS/OadUGE=;
        b=Ix2PWRAxbTrgMelCZD8RpLdgm3V4Ss2OsWERBx/g9zxE/1AqponG8Rss9cQjx1Pbc/
         CZI5hTcz8pVYYVilWc0Ks+XsfBn2Vrm3U8whqglauMxHqc21SwRm+gHVmImd0ntz2dTP
         lepgKEDaD7GskK3RZyEXi732x9AHadM+lbzEV8rjXpoK1ebN9IecvE+4FesDrZi2LWDF
         D3SggVS/dzDpxMxDhEiXVLputX0VtDqeU5lxSXkC7YHoVIVEXo0JPxPfxn/WNQ3xRzx6
         WWta70Umwrp5jerLQ4dGZUOvn3al5Ru1Cztrm+q7zJuRciNt90YuB0I8y5Bzjbp4lHcY
         Zvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102175; x=1774706975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYuRLOkVEr0vMq2UyeWKGNVMl1LS0aZ8xRKS/OadUGE=;
        b=s7Gtm33pG6OeV8/iwT8fxpHC1inyxCHt6sxiLZvi10v4zVJf8da60NjvSsycfLyd/X
         ghM3cFQPLWaWBgSO0du08kIImmPcx8Lb1hk5UKAUXE7LGC1328YxLn6NLOqBaMvjp6/o
         pzf5Nm1MZ5cSARNKGQvQHe5wOdS3sIRoo+ap5aRV1fxdjt+uifL9NP9G1rUfjlUGlnUP
         Atc/3HFHQqhYnnm4TocG5kA/ZvU3ks2RY9zaJUoJ2miKtIKwxOzAmS1vCB1mBqv7jISQ
         YlP6TCGK/dzJLu6VFOkXX8A49sRDk2UFT/VIt9pdWFddR/2txSqbv22W2JEpzjiLmEyS
         bZFw==
X-Gm-Message-State: AOJu0YxMi4CVdoZ2eYuBPrnNHJ4WBuXZdTENqBHXK2+a9DesC12MJmy8
	dD2wTZlo9iGgx0GqJOifGyXZOuW7vHgbnw/5brlPmXULxX2FM8X3FqFN
X-Gm-Gg: ATEYQzzdCgwPJvq62GYooOc6rsGsHqEaCMyYNIDY6+8Uzmdt191bDaQpIEmLVve6fte
	37FIiTEdqZExuDsGabox17zPEDOP1M6WIw2vqAIWOdEyjkeJwR3lw19RqTB9SWZ+M2lMiC0OfdF
	9YJSyMf1Kt7nrLKvVWlF2K6iQd15706QAwbI65J0eSgbS8ubdCpCWg2gXv/HMRZn2tXZbNJB+2v
	W6dZYyO0S3IrIEuOwMAAKGI1k/aNJi3us7pHMEL7rcNBeZqEu4aGE9NekQtE6WWOqvy4jU9g3Sn
	V11GKwfD/O9ICkLDNIe2elrMf05isd5x5RQPfDKELycsyYGoYM2pF0rKjkHN/1DD6zKrBMTGhXF
	ZaE/Ao2xyosHUq8DFlygNMJ7tihm3EKy61LaqOx9icwZLX+/3uD2clYEm8wX/GGC5iy0dEOgrpB
	lKyw5GYgo0iH/TrveIzs3qMdpIfc25pU3zrIfYGXUObOvB5MWoXRA=
X-Received: by 2002:a17:903:b84:b0:2b0:4446:5a34 with SMTP id d9443c01a7336-2b07724f804mr84505275ad.27.1774102175434;
        Sat, 21 Mar 2026 07:09:35 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083683a8fsm49609995ad.66.2026.03.21.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:09:34 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC v2] mm/damon: add synchronous validation for commit_inputs
Date: Sat, 21 Mar 2026 22:09:26 +0800
Message-ID: <20260321140926.22163-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
silently (no error returned to shell), because the validation happens
aynchronously in the kdamond.

Solution
========
To fix this, I proposed adding synchronous validation in
damon_lru_sort_commit_inputs_store() and
damon_reclaim_commit_inputs_store() before setting the 'commit_inputs'
flag. This allow users to receive immediate feedback (e.g., -EINVAL) if
the parameters are invalid.

Changes
=======
1. Added damon_lru_sort_commit_inputs_store() and
   damon_reclaim_commit_inputs_store() to handle parameter validation
   before setting 'commit_inputs'.
2. Added damon_validate_attrs() to centralize validation logic.

This change is motivated from another discussion [1].

[1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
Changes from RFC-v1:
- Remove question from commit message area.
- Added synchronous validation for DAMON_RECLAIM.
- Rename damon_valid_attrs() -> damon_validate_attrs().
- Exported a new function damon_validate_attrs() and declared it in
  damon.h.
- Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com

 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 34 +++++++++++++++++++++++++---------
 mm/damon/lru_sort.c   | 34 +++++++++++++++++++++++++++++++++-
 mm/damon/reclaim.c    | 34 +++++++++++++++++++++++++++++++++-
 4 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d9a3babbafc1..00ca58dbe978 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -997,6 +997,8 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long addr_unit,
 				unsigned long min_region_sz);
 
+int damon_validate_attrs(struct damon_attrs *attrs);
+
 #endif	/* CONFIG_DAMON */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4dae03a37f9a..a459cdcaaed2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -751,6 +751,27 @@ static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
 	return true;
 }
 
+/**
+ * damon_validate_attrs() - Check if the given DAMON attributes are valid.
+ * @attrs:		attributes to be checked
+ *
+ * Return: 0 if valid, negative error code otherwise.
+ */
+int damon_validate_attrs(struct damon_attrs *attrs)
+{
+	if (!damon_valid_intervals_goal(attrs))
+		return -EINVAL;
+	if (attrs->min_nr_regions < 3)
+		return -EINVAL;
+	if (attrs->min_nr_regions > attrs->max_nr_regions)
+		return -EINVAL;
+	if (attrs->sample_interval > attrs->aggr_interval)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(damon_validate_attrs);
+
 /**
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
@@ -778,16 +799,11 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	struct damos *s;
 	bool aggregating = ctx->passed_sample_intervals <
 		ctx->next_aggregation_sis;
+	int err;
 
-	if (!damon_valid_intervals_goal(attrs))
-		return -EINVAL;
-
-	if (attrs->min_nr_regions < 3)
-		return -EINVAL;
-	if (attrs->min_nr_regions > attrs->max_nr_regions)
-		return -EINVAL;
-	if (attrs->sample_interval > attrs->aggr_interval)
-		return -EINVAL;
+	err = damon_validate_attrs(attrs);
+	if (err)
+		return err;
 
 	/* calls from core-external doesn't set this. */
 	if (!attrs->aggr_samples)
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..883860721d3b 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -361,6 +360,39 @@ static int damon_lru_sort_handle_commit_inputs(void)
 	return err;
 }
 
+static int damon_lru_sort_commit_inputs_store(const char *val,
+		const struct kernel_param *kp)
+{
+	struct damon_attrs attrs;
+	bool yes;
+	int err;
+
+	err = kstrtobool(val, &yes);
+	if (err)
+		return err;
+
+	if (commit_inputs == yes)
+		return 0;
+
+	if (!yes)
+		return 0;
+
+	attrs = damon_lru_sort_mon_attrs;
+	err = damon_validate_attrs(&attrs);
+	if (err)
+		return err;
+
+	commit_inputs = yes;
+	return err;
+}
+
+static const struct kernel_param_ops commit_inputs_param_ops = {
+	.set = damon_lru_sort_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_lru_sort_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..6ea44b02cc76 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -267,6 +266,39 @@ static int damon_reclaim_handle_commit_inputs(void)
 	return err;
 }
 
+static int damon_reclaim_commit_inputs_store(const char *val,
+		const struct kernel_param *kp)
+{
+	struct damon_attrs attrs;
+	bool yes;
+	int err;
+
+	err = kstrtobool(val, &yes);
+	if (err)
+		return err;
+
+	if (commit_inputs == yes)
+		return 0;
+
+	if (!yes)
+		return 0;
+
+	attrs = damon_reclaim_mon_attrs;
+	err = damon_validate_attrs(&attrs);
+	if (err)
+		return err;
+
+	commit_inputs = yes;
+	return err;
+}
+
+static const struct kernel_param_ops commit_inputs_param_ops = {
+	.set = damon_reclaim_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_reclaim_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
-- 
2.53.0

