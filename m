Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2A2E2F1F;
	Wed, 20 May 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240086; cv=none; b=C5bNTQHldqLTc5gbEl06NxDT4jSIXyuKxNowpRJcl/Y/ju5tU7FZbXtPK7b9LBzLB3iry/bczn9g3VSGA7N6LFbyQ89DZ66CSdHJ3EmqzCB12BqxDGKf9toNFClYcyDbg9sjC3KPAYC9hiDw325z4Y3KWxnV4jUEiISKEV+byDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240086; c=relaxed/simple;
	bh=+08MHU28qO1q0LHSMCgNkl884KAY47ubATRBlMdBI7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmH/qxI8kP0qWjgfvqt5xiyV3uOvBbVVkmYX4R/YFESRw+BuSzeohoCQT+zu6gjTsRgN6pv9kXKAmBkOUK9rUdVQmz4nMtn3E0EPWo7E0zkCMdgeYNtG8dwYAYBsgnI6s7gbmqTXezkk638moyiYbQZPVls+HFbSy2+0mujk45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMZT4khY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMZT4khY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DE41F00896;
	Wed, 20 May 2026 01:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240085;
	bh=g5SUdvctEA/oc8IEKBcOiY6OqbBfPvmo8ZaU8y8FY94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DMZT4khYbL3aVRqpSOJtNVRlGSXVDkWy1zEBu++LgurjzZELzjwQDXrgRzBwBHMIK
	 UCWteVanQ2vhP4Ol10ibWnCkC9nQIvwNUNllXshjXRe38hn2df2u5d0/oDB8UxM4QT
	 D3wUN5aw075C59UpGegQRCqJIkJSk0zmcjkxGzyI4snr9r0lRzwQ5nS9UUnREz8XXx
	 c8zeDtLpZzBCVxVangUULH0Q+UoQRvgYRPXDwl1GbcZ/EiMfi1fJHw6OGkNuomjFjl
	 S77eIOaNN9zjRUSFfBB6IRfyAXJkBxVSEkMzbdfQt5eeNr4oFHtZvqwcjxwmqyHV/j
	 11/ezJpP0UEQA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zenghui Yu <zenghui.yu@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND 3/3] Docs/{ABI,admin-guide}/damon: fix various typoes
Date: Tue, 19 May 2026 18:21:01 -0700
Message-ID: <20260520012104.93602-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520012104.93602-1-sj@kernel.org>
References: <20260520012104.93602-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zenghui Yu <zenghui.yu@linux.dev>

``damon_target_idx`` was wrongly written as ``target_idx`` in the docs. Fix
it all over the place, as well as the wrong directory count, grammar, etc.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260517182624.7167-1-zenghui.yu@linux.dev
- Collect Reviewed-by: tag.
- Rebase to latest mm-new.

 .../ABI/testing/sysfs-kernel-mm-damon          |  2 +-
 Documentation/admin-guide/mm/damon/usage.rst   | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index ee29d4e204ffa..b73e6bc28ea5f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -452,7 +452,7 @@ Description:	If 'hugepage_size' is written to the 'type' file, writing to
 		or reading from this file sets or gets the maximum size of the
 		hugepage for the filter.
 
-What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/target_idx
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters/<F>/damon_target_idx
 Date:		Feb 2025
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	If 'target' is written to the 'type' file, writing to or
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 0d6a27dc97b0a..d46875e603d86 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -97,7 +97,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
@@ -374,7 +374,7 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, eight directories (``access_pattern``, ``quotas``,
+In each scheme directory, nine directories (``access_pattern``, ``quotas``,
 ``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
 ``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
 and ``apply_interval``) exist.
@@ -492,7 +492,7 @@ given DAMON-based operation scheme.
 Under the watermarks directory, five files (``metric``, ``interval_us``,
 ``high``, ``mid``, and ``low``) for setting the metric, the time interval
 between check of the metric, and the three watermarks exist.  You can set and
-get the five values by writing to the files, respectively.
+get the five values by writing to and reading from the files, respectively.
 
 Keywords and meanings of those that can be written to the ``metric`` file are
 as below.
@@ -500,7 +500,7 @@ as below.
  - none: Ignore the watermarks
  - free_mem_rate: System's free memory rate (per thousand)
 
-The ``interval`` should written in microseconds unit.
+The ``interval_us`` should be written in microseconds unit.
 
 .. _sysfs_filters:
 
@@ -528,9 +528,9 @@ in the numeric order.
 
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
@@ -540,7 +540,7 @@ files, respectively.  For ``hugepage_size`` type, you can specify the minimum
 and maximum size of the range (closed interval) to ``min`` and ``max`` files,
 respectively.  For ``target`` type, you can specify the index of the target
 between the list of the DAMON context's monitoring targets list to
-``target_idx`` file.
+``damon_target_idx`` file.
 
 You can write ``Y`` or ``N`` to ``matching`` file to specify whether the filter
 is for memory that matches the ``type``.  You can write ``Y`` or ``N`` to
@@ -731,7 +731,7 @@ show results using tracepoint supporting tools like ``perf``.  For example::
 
 Each line of the perf script output represents each monitoring region.  The
 first five fields are as usual other tracepoint outputs.  The sixth field
-(``target_id=X``) shows the ide of the monitoring target of the region.  The
+(``target_id=X``) shows the id of the monitoring target of the region.  The
 seventh field (``nr_regions=X``) shows the total number of monitoring regions
 for the target.  The eighth field (``X-Y:``) shows the start (``X``) and end
 (``Y``) addresses of the region in bytes.  The ninth field (``X``) shows the
-- 
2.47.3
