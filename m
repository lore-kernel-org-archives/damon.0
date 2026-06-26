Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BB257851;
	Fri, 26 Jun 2026 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433036; cv=none; b=WCPnZVWTAITUISnA4pK8/GefVSUIhwMgN2MAw3RNlVLl/N5PrSfGPMBuNUHqoqP8TWmEIz98AMTxObWkCKz7uJCtMk5bf4v+LpUgV196Bzw+FdO21qIAeqiV1Vxwg68hOdQt56k2r1nCnbYTvhljAVubxWd7YrDDWhUHj74fBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433036; c=relaxed/simple;
	bh=nOMs+/z/SrAEJ4IqmwwKaSHP52fTwHkyEWdYdhRQTMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpwNWzMMmkkJU5gqrdjiOMdkwm+4k9lh8PE8KX7XuGRyk4+ShbC3FWe34QQivz3Hb51Ubi2YjCfa5k9bkMC9fzGsCIJiWJBPdDgqh34kEOFKcF54giiJ8Mggl8celKkEAXIFmPH4EpFdq3sfKWL52f7azh/yI0OwxuHcEa6lv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrvUaBIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrvUaBIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78661F000E9;
	Fri, 26 Jun 2026 00:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433035;
	bh=sQV3GfOG7VWGJtv7W6ZwKyzWFgMIO6rC7OdU4Z34lgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrvUaBIzRwEe+uBwfCC7oIufVS51AeykE2X0QEdFZSp1HOJZzP1e4BHyYmv0SmjqJ
	 EU3PUAhRB2BBFMHspLiM2bM44Cg1GpfcKXlbans/6qQudaCQRBKsIlGwfLWBQnXkVX
	 WhbTJ6A7DFntoc+YdRX3cBh3hzKZzsgDWhEKVwoR18ATJ902hMCh2VyCs9Re4TWd2b
	 0KLy09RhK5aJPwKGbhx0oUneDF5/b6IzXrdJpMBg9j1lZcR2UJVeiW1fvsKk/Buzo4
	 4fqJUaTwcLYXp6awVscjY9g4odiBap8t8DIFjGm8Fwhh++HB2DlZAhRTiOoPv0eNig
	 XI5OgZQmu5OmA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 11/11] mm/damon/sysfs: fix typos in probe_{add,rm}_dirs: s/attr/probe/
Date: Thu, 25 Jun 2026 17:16:42 -0700
Message-ID: <20260626001644.85825-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626001644.85825-1-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
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
