Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB542E004;
	Tue, 30 Jun 2026 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829074; cv=none; b=tRXGMw9UH1S19+fmbHA8xr2/XxSK5tXdzx9LsM2zVD6kyeEpFoJMmoPO+L1LHtNanUxcdgM1OOQDYL5G3np3vfLeQDXDDUbBp3qn9nMCJG3kdKMyWhEqinfSP6WKmI4U3Iq9Y3NLyDZBcYsEqZ05ynWzr2jx4LsqqAFTyUU0Wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829074; c=relaxed/simple;
	bh=neHHjunVZZcJYZGka9GDjW0aXNw1zD0+JhTPLlvuVZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLb+6mLnC4firTvCfBJsHQ7R09l4prOCnMe7Wn5gn9U9qDkoCiLMlVqrFL5kIeKrgo2v9AdmETiZLTs+GSrxyK/m6uQyfbTH/jSoVOJeMZ5blnLWp9AJC+pAxE0KkAINROUX7JOTQRDD6dRF5ryRgDmk4VAtOO2271X7dSr60yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz/LToBM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz/LToBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536D31F00A3A;
	Tue, 30 Jun 2026 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829073;
	bh=1jHOfEbKPidZLAY+bFapF4i2vITVSQIXVAPEhh+0hhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fz/LToBMBiIU0dTtYMuOu1omoRZUmMba6sk3xwiWQ+2FlTbc4NT/i6KAp+qJezenZ
	 KzCA11SA1VTDR8nwaETWW88mX9V86UuvFnbIXHY6vt+FPrNntkTRkPU7xbG5caEFNI
	 mgrdtFJf96a0cWhPaZrhVUtCUEKpiFMh0VMX7Fv8EgoVZmb0fVY1s12b72lDc7SNFF
	 7jsrxtiunnjIscevZfDMmqrhom7j1ceHahl8gf4aYGrKAsCaIDbAvbejzza7P/ESBI
	 N2iCEPXfoVbplhTSfbUHX8L65L1w5CgCleHGC20NE+NWC3GaF0ZMdqQr9R6oJgTZg4
	 FE9dt4tMtLgKg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/11] mm/damon/sysfs: fix typos in probe_{add,rm}_dirs: s/attr/probe/
Date: Tue, 30 Jun 2026 07:17:25 -0700
Message-ID: <20260630141726.92246-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_probe_{add,rm}_dirs names a variable for damon_sysf_probe
as 'attr'.  Probably a trivial copy-pasta error, but it makes the code
not pleasant to read.  Fix those.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5b2ae2fe948fa..6710b6d019bf5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1073,7 +1073,7 @@ static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_probe);
 }
 
-static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
+static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 {
 	struct damon_sysfs_filters *filters;
 	int err;
@@ -1081,22 +1081,22 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
 	filters = damon_sysfs_filters_alloc();
 	if (!filters)
 		return -ENOMEM;
-	attr->filters = filters;
+	probe->filters = filters;
 
 	err = kobject_init_and_add(&filters->kobj, &damon_sysfs_filters_ktype,
-			&attr->kobj, "filters");
+			&probe->kobj, "filters");
 	if (err) {
 		kobject_put(&filters->kobj);
-		attr->filters = NULL;
+		probe->filters = NULL;
 	}
 	return err;
 }
 
-static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *attr)
+static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
 {
-	if (attr->filters) {
-		damon_sysfs_filters_rm_dirs(attr->filters);
-		kobject_put(&attr->filters->kobj);
+	if (probe->filters) {
+		damon_sysfs_filters_rm_dirs(probe->filters);
+		kobject_put(&probe->filters->kobj);
 	}
 }
 
-- 
2.47.3
