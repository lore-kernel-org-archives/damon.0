Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32259268698;
	Wed,  5 Mar 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213670; cv=none; b=V78IMzTkG1f4xu/Su8woP8YkQThlt+7h73WQCjtI5ywVE8e510vdkAc23tPudGHN7Uw9V+2+bQpBjsNvtPl8AL2MYG6wGOASgyTpmp2ngHrgQaclrWjkYdn92twk6uOfCl17iHRwVBhjiHCNsTIa/OLB4zYML0II2jidySczZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213670; c=relaxed/simple;
	bh=47X+eEoNM4cXPe501kkxrph0V2B2kHrGH6GZrrO40z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4uzysONpOq36TvqMrjiCISqrFRVA1OPtGbTbYOfYW82IY9zoVFoAN7i5VlRdN3V+HvvDi7DNlaHmw93ek3Usap/m/fCGiohsaLS08kgc3OyAHnzuX6rUEGPpBt8aT2vBIxpA2tzqaOMNMA/10tIT/S6lJSfyrnB0rbj+NVq47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/8GAGHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/8GAGHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAA9C4AF09;
	Wed,  5 Mar 2025 22:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213670;
	bh=47X+eEoNM4cXPe501kkxrph0V2B2kHrGH6GZrrO40z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/8GAGHVWwEyJKU9fX+3btSUYqcbCJkD5n70OIIlgDwm2SUWpPrPDbgxWw2cz96Es
	 +WQAAgzNt4rpfKnvi2yeWDbQQc4vdZwg4Lr+Vuyi2vdRaSeakhTMsAIsJVw4iGjauD
	 sRwiK15hqLuulWufZxCON720EA5i0DGS51il9e1f7VKcKWK5nYGkjos/8WRuZLonUg
	 l2berudzd46p8iz7wleIwOxOdVYSNf2dVbJlSkUSs87VPX9Jj1bHydurGROmUaA5VU
	 LF8KlS867WeivAEb9gS1mQbal5hzEOwS4i0X9B2bSr2ukZnVtnljz3Wh+iPGoTT9V0
	 unPes/owhWHpg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] Docs/admin-guide/mm/damon/usage: update for {core,ops}_filters directories
Date: Wed,  5 Mar 2025 14:27:33 -0800
Message-Id: <20250305222733.59089-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305222733.59089-1-sj@kernel.org>
References: <20250305222733.59089-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document {core,ops}_filters directories on usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 31 ++++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index de549dd18107..ced2013db3df 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -83,7 +83,7 @@ comma (",").
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
-    │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
+    │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
@@ -307,9 +307,10 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, five directories (``access_pattern``, ``quotas``,
-``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and three files
-(``action``, ``target_nid`` and ``apply_interval``) exist.
+In each scheme directory, seven directories (``access_pattern``, ``quotas``,
+``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``stats``, and
+``tried_regions``) and three files (``action``, ``target_nid`` and
+``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -420,13 +421,24 @@ The ``interval`` should written in microseconds unit.
 
 .. _sysfs_filters:
 
-schemes/<N>/filters/
---------------------
+schemes/<N>/{core\_,ops\_,}filters/
+-----------------------------------
 
-The directory for the :ref:`filters <damon_design_damos_filters>` of the given
+Directories for :ref:`filters <damon_design_damos_filters>` of the given
 DAMON-based operation scheme.
 
-In the beginning, this directory has only one file, ``nr_filters``.  Writing a
+``core_filters`` and ``ops_filters`` directories are for the filters handled by
+the DAMON core layer and operations set layer, respectively.  ``filters``
+directory can be used for installing filters regardless of their handled
+layers.  Filters that requested by ``core_filters`` and ``ops_filters`` will be
+installed before those of ``filters``.  All three directories have same files.
+
+Use of ``filters`` directory can make expecting evaluation orders of given
+filters with the files under directory bit confusing.  Users are hence
+recommended to use ``core_filters`` and ``ops_filters`` directories.  The
+``filters`` directory could be deprecated in future.
+
+In the beginning, the directory has only one file, ``nr_filters``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each filter.  The filters are evaluated
 in the numeric order.
@@ -435,7 +447,7 @@ Each filter directory contains nine files, namely ``type``, ``matching``,
 ``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, ``min``, ``max``
 and ``target_idx``.  To ``type`` file, you can write the type of the filter.
 Refer to :ref:`the design doc <damon_design_damos_filters>` for available type
-names and their meanings.
+names, their meaning and on what layer those are handled.
 
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
@@ -455,6 +467,7 @@ the ``type`` and ``matching`` should be allowed or not.
 For example, below restricts a DAMOS action to be applied to only non-anonymous
 pages of all memory cgroups except ``/having_care_already``.::
 
+    # cd ops_filters/0/
     # echo 2 > nr_filters
     # # disallow anonymous pages
     echo anon > 0/type
-- 
2.39.5
