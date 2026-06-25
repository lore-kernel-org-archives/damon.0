Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E237FF6D;
	Thu, 25 Jun 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397498; cv=none; b=n8kOR7M28ynf7Hzz3vPH1pjKZASI1p0u5mR0qSu9pVg1wKRnhKSPzZEgchQe0FNKl7/uNqavxHSNkejkjgD12gl0AbBTrLldZ7WkKvTAsJmCJ5qqj70SzxS9incEBIbMbvQPgWwsWNAfbL7K+ICyE0M5NykoXhsKfRv0M9xhEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397498; c=relaxed/simple;
	bh=nOMs+/z/SrAEJ4IqmwwKaSHP52fTwHkyEWdYdhRQTMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGFEvYiOwSzIJiN2DeBsDDByVPKhv3ADqtynQGBk+ywXKOYWMm/g67GOTeGZkKd8xCl0rY85572lhyt60srhTf34egSapfz4N0YiesTYobYJjiqek9ElO7c9K174JPOMYbVrA6viUCBkbUZLzvd4NcqQT0PdJ7ZIfqt9RIN35a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRu6XGK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRu6XGK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FC1F00A3E;
	Thu, 25 Jun 2026 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397497;
	bh=sQV3GfOG7VWGJtv7W6ZwKyzWFgMIO6rC7OdU4Z34lgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HRu6XGK/qCH+dKSN5MszLTK92Z1d/NPfPB2x7DBDMM1CgMtQx7HErEfemIgaBfioC
	 cI4L9vQeWDKIEmkQGvxta3Up0cDBe8ewcQLVDuv61CCH69qBCPJG7aMXVBKIF37ufZ
	 xnhrk3fsMvZq5pda+HfgF7v0so7Th9GXVn4PvHq2SHScvYQAApvdE7p4AgHLvmhnKh
	 q8bdbLYxbuZwQHbvefJ6O27h/idEG7VsLBvnlIq97g6h8J6WcpGSZ3eD97eBQqLQte
	 9pSopfDti6CnyNIYGTZv0P9XP3ZwV9zsFyujmZ0xz/70x3flybnvnq3bbgpCEFpgQg
	 PC+SoymK/NUUg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 11/11] mm/damon/sysfs: fix typos in probe_{add,rm}_dirs: s/attr/probe/
Date: Thu, 25 Jun 2026 07:23:56 -0700
Message-ID: <20260625142357.103500-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
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
index f3bb146b204df..36d71f1675426 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1068,7 +1068,7 @@ static struct damon_sysfs_probe *damon_sysfs_probe_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_probe);
 }
 
-static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
+static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *probe)
 {
 	struct damon_sysfs_filters *filters;
 	int err;
@@ -1076,22 +1076,22 @@ static int damon_sysfs_probe_add_dirs(struct damon_sysfs_probe *attr)
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
