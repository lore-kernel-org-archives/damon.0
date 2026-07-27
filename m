Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEF3F7867
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146110; cv=none; b=nkQzb/kEUEI+eb2KU0qhouVBMAMvLhIYkkSfPAWxEmIXLbbvAyJ4886uVqtXKMrwij9WT1sXFZNzcF+cnK2yRAbPNN/Tk/1ZdgqrUGm0DtsUcrZjQwfgT4X04dYgsBBijup236j9CVY4XUBTCSNgXypJpMsd69aQIPXamcSmqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146110; c=relaxed/simple;
	bh=rDVLz3bWreK/4dapCvsP8ARazvVf2gy6zVnH2aMeQLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTD2/qXYPk7P/GNcqXVxaqmf3MiRudbJOe5zlYSTU952av+zjUSM1Nj2v7dS+e7WmXzs5mzMkk3eT99w3OYgitiCZgYNW8LtXz6Zz3vsyMA3sXYo90vKfFS/YlQTuPKLuVgymxJ3fzRCqydmvTpq5bUmtYBA+gHJROs3IaH3qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r8PrvI/x; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r8PrvI/x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785146102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4S2hz6V8QOq2FoxNPi2D/VAkz7DZY9JJoq6y4/9kAtM=;
	b=r8PrvI/xfkIOMDWzLyjbYwMOybQXPbwReqifnm5e4usOGvTfzjWTwFn+6BRKZGFs8MP7Ag
	73gL588KcsHdk3RjF1vXvm2lRz9kGW2YAU453d9xjIz68SLSIFx1IMz1AlGfN4jT/gBp32
	o+TmU35e1u0qUH9uzlNp9u1wXCi56A0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/sysfs-schemes: report the number of tried regions
Date: Mon, 27 Jul 2026 17:54:23 +0800
Message-ID: <20260727095429.143527-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260727095429.143527-1-jiayuan.chen@linux.dev>
References: <20260727095429.143527-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

The 'tried_regions' directory of each DAMON sysfs scheme exposes the memory
regions that the scheme's action has been tried to be applied to, as
per-region subdirectories.  It also has a 'total_bytes' file that reports
the total size of those regions without materializing the per-region
subdirectories, so that users can cheaply retrieve the aggregated result.

The number of the tried regions is another useful aggregated metric.  When
the scheme's access pattern is not restrictive, it approximates the number
of the adaptive monitoring regions of the context, which users may want to
watch, e.g., to see how well the monitoring is refined under a given
max_nr_regions, or to feed fleet wide access pattern dashboards.
Retrieving it currently requires materializing all the per-region
subdirectories (via writing 'update_schemes_tried_regions') and counting
them, which is unnecessarily expensive for users that only need the count.

Add a 'nr_regions' file to the 'tried_regions' directory.  Like
'total_bytes', it is updated by both 'update_schemes_tried_bytes' and
'update_schemes_tried_regions', so it can be read as a lightweight counter
without materializing the per-region subdirectories.

Suggested-by: SeongJae Park <sj@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 10 +++++++
 Documentation/admin-guide/mm/damon/usage.rst  | 27 ++++++++++---------
 mm/damon/sysfs-schemes.c                      | 23 +++++++++++++---
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 786be4537da1..a6e8f5036555 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -622,6 +622,16 @@ Description:	Writing a number to this file sets the upper limit of
 		nr_snapshots that deactivates the scheme when the limit is
 		reached or exceeded.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/nr_regions
+Date:		Aug 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Reading this file returns the number of regions that
+		corresponding DAMON-based Operation Scheme's action has tried
+		to be applied.  The number is updated together with
+		'.../tried_regions/total_bytes' by writing 'update_schemes_tried_bytes'
+		or 'update_schemes_tried_regions' to the relevant 'state' file, and
+		hence can be read without materializing the per-region directories.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/total_bytes
 Date:		Jul 2023
 Contact:	SJ Park <sj@kernel.org>
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index f6048fc04263..9152ce09de9d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -108,7 +108,7 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
-    │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
+    │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/nr_regions,total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ │ probes
     │ │ │ │ │ │ │ │ │ │ 0/hits
@@ -671,21 +671,24 @@ relevant ``kdamonds/<N>/state`` file.  Refer to :ref:`kdamond directory
 schemes/<N>/tried_regions/
 --------------------------
 
-This directory initially has one file, ``total_bytes``.
+This directory initially has two files, ``nr_regions`` and ``total_bytes``.
 
 When a special keyword, ``update_schemes_tried_regions``, is written to the
-relevant ``kdamonds/<N>/state`` file, DAMON updates the ``total_bytes`` file so
-that reading it returns the total size of the scheme tried regions, and creates
-directories named integer starting from ``0`` under this directory.  Each
-directory contains files exposing detailed information about each of the memory
-region that the corresponding scheme's ``action`` has tried to be applied under
-this directory, during next :ref:`apply interval <damon_design_damos>` of the
-corresponding scheme.  The information includes address range, ``nr_accesses``,
-and ``age`` of the region.
+relevant ``kdamonds/<N>/state`` file, DAMON updates the ``nr_regions`` and
+``total_bytes`` files so that reading them returns the number and the total size
+of the scheme tried regions, respectively, and creates directories named
+integer starting from ``0`` under this directory.  Each directory contains files
+exposing detailed information about each of the memory region that the
+corresponding scheme's ``action`` has tried to be applied under this directory,
+during next :ref:`apply interval <damon_design_damos>` of the corresponding
+scheme.  The information includes address range, ``nr_accesses``, and ``age`` of
+the region.
 
 Writing ``update_schemes_tried_bytes`` to the relevant ``kdamonds/<N>/state``
-file will only update the ``total_bytes`` file, and will not create the
-subdirectories.
+file will only update the ``nr_regions`` and ``total_bytes`` files, and will not
+create the subdirectories.  Hence ``nr_regions`` can be used as a lightweight way
+to read the number of the scheme tried regions without materializing the
+per-region subdirectories.
 
 The directories will be removed when another special keyword,
 ``clear_schemes_tried_regions``, is written to the relevant
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 54ff196f8e24..b1df9f21c267 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -297,6 +297,7 @@ static const struct kobj_type damon_sysfs_scheme_region_ktype = {
 struct damon_sysfs_scheme_regions {
 	struct kobject kobj;
 	struct list_head regions_list;
+	int nr_region_dirs;
 	int nr_regions;
 	unsigned long total_bytes;
 };
@@ -311,11 +312,21 @@ damon_sysfs_scheme_regions_alloc(void)
 
 	regions->kobj = (struct kobject){};
 	INIT_LIST_HEAD(&regions->regions_list);
+	regions->nr_region_dirs = 0;
 	regions->nr_regions = 0;
 	regions->total_bytes = 0;
 	return regions;
 }
 
+static ssize_t nr_regions_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_regions *regions = container_of(kobj,
+			struct damon_sysfs_scheme_regions, kobj);
+
+	return sysfs_emit(buf, "%d\n", regions->nr_regions);
+}
+
 static ssize_t total_bytes_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -335,7 +346,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 		list_del(&r->list);
 		kobject_del(&r->kobj);
 		kobject_put(&r->kobj);
-		regions->nr_regions--;
+		regions->nr_region_dirs--;
 	}
 }
 
@@ -344,10 +355,14 @@ static void damon_sysfs_scheme_regions_release(struct kobject *kobj)
 	kfree(container_of(kobj, struct damon_sysfs_scheme_regions, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_scheme_regions_nr_regions_attr =
+		__ATTR_RO_MODE(nr_regions, 0400);
+
 static struct kobj_attribute damon_sysfs_scheme_regions_total_bytes_attr =
 		__ATTR_RO_MODE(total_bytes, 0400);
 
 static struct attribute *damon_sysfs_scheme_regions_attrs[] = {
+	&damon_sysfs_scheme_regions_nr_regions_attr.attr,
 	&damon_sysfs_scheme_regions_total_bytes_attr.attr,
 	NULL,
 };
@@ -3133,6 +3148,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 		return;
 
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
+	sysfs_regions->nr_regions++;
 	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
 	if (total_bytes_only)
 		return;
@@ -3144,13 +3160,13 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
-				sysfs_regions->nr_regions))
+				sysfs_regions->nr_region_dirs))
 		goto out;
 	if (damos_sysfs_region_add_dirs(region, ctx, r))
 		goto del_out;
 
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
+	sysfs_regions->nr_region_dirs++;
 	return;
 
 del_out:
@@ -3170,6 +3186,7 @@ int damon_sysfs_schemes_clear_regions(
 		sysfs_scheme = sysfs_schemes->schemes_arr[i];
 		damon_sysfs_scheme_regions_rm_dirs(
 				sysfs_scheme->tried_regions);
+		sysfs_scheme->tried_regions->nr_regions = 0;
 		sysfs_scheme->tried_regions->total_bytes = 0;
 	}
 	return 0;
-- 
2.43.0

