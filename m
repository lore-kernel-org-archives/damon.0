Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6C286D4D
	for <damon@lists.linux.dev>; Sun, 17 May 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042422; cv=none; b=lawJweOrQN9lI92aDw1dTjCMSvhHBYGIM9/xixN8PxqY25o3VabDcgma0ONIqf5XgmMSFvToio+KO8YA77QXdXOONxDL1iuVQTcvZSz+aG0bqI/8Kf0Si98vTBq4LYwzIfkiyxqp4vrWpTLtVUAbgwUgMDI5nkk+ZFfgOHb3DQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042422; c=relaxed/simple;
	bh=vXM9Wu6Q6FwlpT7rufba8YKh8vMGByrc/DR7vm33zao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKwTXJYYemWcx4QZwQYU1n9FY73tL9J7JNEkrh6vWKNAkJgI6JueqUjSIg/n7OVzeZFPZi3HGG35xApCb7p6nphPAUcnFpFymDsb15fCKRdWIyMyZXy3rXcMwAjguk+40O5QviCKMigVmSnNhlBCIuE906QOCCyV6n/SLyXYpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcCW8HRZ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcCW8HRZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779042406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V9vGbDjxgZyPY7/BSXSX99pspMvi9Dnp2FUzlVWZm1Y=;
	b=RcCW8HRZzzfzqL9uy3GAt1LQZN1SwBPn6GHQb4hzkJKTmYk9RPTR2w8wnRSp2DayqU02jy
	R779rFWkXjHEFULIPuoOVaWVz+OAvGz+bvwB4ZXqr3GQMo26J21+yACfBuXQ9SnA/WPqAp
	iuhtFExuagWeoV+mPjASSal5KPm/220=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] Docs/{ABI,admin-guide}/damon: fix various typoes
Date: Mon, 18 May 2026 02:26:22 +0800
Message-ID: <20260517182624.7167-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

``damon_target_idx`` was wrongly written as ``target_idx`` in the docs. Fix
it all over the place, as well as the wrong directory count, grammar, etc.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 .../ABI/testing/sysfs-kernel-mm-damon          |  2 +-
 Documentation/admin-guide/mm/damon/usage.rst   | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2424237ebb10..40c8843a82a4 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -428,7 +428,7 @@ Description:	If 'hugepage_size' is written to the 'type' file, writing to
 		or reading from this file sets or gets the maximum size of the
 		hugepage for the filter.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/target_idx
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/damon_target_idx
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'target' is written to the 'type' file, writing to or
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 534e1199cf09..cae622b959db 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -89,7 +89,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
@@ -337,7 +337,7 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, eight directories (``access_pattern``, ``quotas``,
+In each scheme directory, nine directories (``access_pattern``, ``quotas``,
 ``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
 ``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
 and ``apply_interval``) exist.
@@ -447,7 +447,7 @@ given DAMON-based operation scheme.
 Under the watermarks directory, five files (``metric``, ``interval_us``,
 ``high``, ``mid``, and ``low``) for setting the metric, the time interval
 between check of the metric, and the three watermarks exist.  You can set and
-get the five values by writing to the files, respectively.
+get the five values by writing to and reading from the files, respectively.
 
 Keywords and meanings of those that can be written to the ``metric`` file are
 as below.
@@ -455,7 +455,7 @@ as below.
  - none: Ignore the watermarks
  - free_mem_rate: System's free memory rate (per thousand)
 
-The ``interval`` should written in microseconds unit.
+The ``interval_us`` should be written in microseconds unit.
 
 .. _sysfs_filters:
 
@@ -483,9 +483,9 @@ in the numeric order.
 
 Each filter directory contains nine files, namely ``type``, ``matching``,
 ``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, ``min``, ``max``
-and ``target_idx``.  To ``type`` file, you can write the type of the filter.
-Refer to :ref:`the design doc <damon_design_damos_filters>` for available type
-names, their meaning and on what layer those are handled.
+and ``damon_target_idx``.  To ``type`` file, you can write the type of the
+filter.  Refer to :ref:`the design doc <damon_design_damos_filters>` for
+available type names, their meaning and on what layer those are handled.
 
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
@@ -495,7 +495,7 @@ files, respectively.  For ``hugepage_size`` type, you can specify the minimum
 and maximum size of the range (closed interval) to ``min`` and ``max`` files,
 respectively.  For ``target`` type, you can specify the index of the target
 between the list of the DAMON context's monitoring targets list to
-``target_idx`` file.
+``damon_target_idx`` file.
 
 You can write ``Y`` or ``N`` to ``matching`` file to specify whether the filter
 is for memory that matches the ``type``.  You can write ``Y`` or ``N`` to
@@ -677,7 +677,7 @@ show results using tracepoint supporting tools like ``perf``.  For example::
 
 Each line of the perf script output represents each monitoring region.  The
 first five fields are as usual other tracepoint outputs.  The sixth field
-(``target_id=X``) shows the ide of the monitoring target of the region.  The
+(``target_id=X``) shows the id of the monitoring target of the region.  The
 seventh field (``nr_regions=X``) shows the total number of monitoring regions
 for the target.  The eighth field (``X-Y:``) shows the start (``X``) and end
 (``Y``) addresses of the region in bytes.  The ninth field (``X``) shows the
-- 
2.53.0

