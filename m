Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379763C2786;
	Wed, 24 Jun 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310840; cv=none; b=NQYMK40KLL6qckrwp7bvI9yo6wChbw1Z2gGlHgLebXSDuQyVonjorNq91TYkXixecRTc8S/Y8FWHq3zdhny7OztpXlv65MIKCAgO5NNNwh9UxLVbWAPZkhtA8zyqwWIdk+levEKAFnRDrF4k5kV3kMHFfgEeJXFQw52rIB5ClwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310840; c=relaxed/simple;
	bh=OVTsqZ2jkSaidm28F7w4AusPk51ulN6SVjOhir/G2p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi47qi8q52aXfBrlgmAQGaJvwjSeEO0jOq7DEDpieEVM8dM/dv+CwK1ORFsY8CxSVKBbVWOOH0cuCMzmw+hoL3PYuU14JTzmxWhMUazeVb2g0qj2wdLczseu97uNOzyl/XYmLMxiQOqd3Odjr7XSjSI+IW8r/EXxoMrVF6GOJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3bN8dry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3bN8dry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6E91F00A3F;
	Wed, 24 Jun 2026 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310837;
	bh=ylwB5zdu1NHhRReJOXLk7elKhlAtTFYQ/4nqZ6xirqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b3bN8dryW7lpe9N75LEbz7v99EVRjLVRpRFWHC6iUyCR64+VbmlHXGZVPxt1agkNI
	 pVXmot8z5C1u1EwNwEnjop1lpMEnfJSpdKivn3TXJ/Rjadr4UgozMuOLJSbCFgXK8a
	 lkbU3EAF+O1+NrMRjynA3Iq9hEONjQ0Ue8SoAvGjNjEtKtUPJdR1JTtnbUjL/UamoN
	 IBU1v6WMZ5TlA8Lc2Iy+rQSzkkyeZfUBEnDPqjhTN0LIaOOA2D20EeoP+KpsJ5sqTI
	 +OzsxhvEXYBB4UdrBinAPPIKzZclbjJiBr0pzsRZ5+K9EhQaClqtyjtYsXkEAv136q
	 io4+K8JKMk5Hg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/11] mm/damon/sysfs: fix typos in probe_{add,rm}_dirs: s/attr/probe/
Date: Wed, 24 Jun 2026 07:20:07 -0700
Message-ID: <20260624142008.87180-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
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

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 92de341827cab..9f9262c9b99ba 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1075,7 +1075,7 @@ static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_probe);
 }
 
-static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
+static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 {
 	struct damon_sysfs_filters *filters;
 	int err;
@@ -1083,22 +1083,22 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
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
