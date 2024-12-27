Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12C1F2C45;
	Fri, 27 Dec 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333718; cv=none; b=M6rR9eShTGQzB09rGMJmpawhZbrS1VEmqzzF1v5iCOKCRoelVgYA6EtWfrnk/yaKW5bXJsgD9Na3Wo1hc4FYAzTOHvO+6JNfyjLM5oqPeKOAXhHktKGVaBiOpg8IB8iM7RxTyM0S4lca6sylkhjYxtDqD0rD/FXYo7fCDOwxIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333718; c=relaxed/simple;
	bh=ZbbHwYTvObdK/b1twjLv8JU3nRNHBdenJ+FrDPH80HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2TdYhDB2wklZk6253leLwY+MorHyfp6MMJ0qfPqVMfdBKP9hl9LzO8grGchUTilwySHqjNvnVVSiEs5rQh4su6P+Zu3NwH8z/xWHs4apujL1l42Dh0IEGyjFj9o9jeDzBV5AvtLljz3z+DOBK+uKVNIZPh8pihuwlN1ui1mOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5jlTrkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5jlTrkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C85C4CED6;
	Fri, 27 Dec 2024 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333717;
	bh=ZbbHwYTvObdK/b1twjLv8JU3nRNHBdenJ+FrDPH80HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5jlTrkx5zTKZTuesqU5n+9f0OdlVA6hmzTbZPvQ5JKsJVX4iiWKvrhvlnTRd7OI1
	 jMg2scciox/wPAFbbig/SR6u3qijlgCxEEwgwM3B/YUnHK4It0ucwis2zE64g0yKnl
	 O4Pk/AaoN0liR3uJS5oabbMQA8hX1kHsOca2EXsUNaG05xng6BhB7HbMJfnxS2fkme
	 swIsyhbsbQT8JA67gSg8xulL9WxUmLaRtujGTryjBLHFdZl7HSd2+JrJi0koki9Y/Q
	 gX59WWnzh00P4rEsKygPW7X7H0VMXN9ENEovOPWSQWlGqR5Ex+JT/AMUvxB1TUnanB
	 9kZE6ytcH8XLA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 10/10] Docs/admin-guide/mm/damon/usage: document DAMOS filter 'pass' sysfs file
Date: Fri, 27 Dec 2024 13:08:19 -0800
Message-Id: <20241227210819.63776-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added 'pass' sysfs file for
DAMOS filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 34 ++++++++++++--------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index fa8a5e4199b1..ab343d6ac771 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -89,7 +89,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
+    │ │ │ │ │ │ │ │ 0/type,matching,memcg_id,pass
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
@@ -412,13 +412,14 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each filter.  The filters are evaluated
 in the numeric order.
 
-Each filter directory contains six files, namely ``type``, ``matcing``,
-``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.  To ``type``
-file, you can write one of five special keywords: ``anon`` for anonymous pages,
-``memcg`` for specific memory cgroup, ``young`` for young pages, ``addr`` for
-specific address range (an open-ended interval), or ``target`` for specific
-DAMON monitoring target filtering.  Meaning of the types are same to the
-description on the :ref:`design doc <damon_design_damos_filters>`.
+Each filter directory contains seven files, namely ``type``, ``matcing``,
+``pass``, ``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.  To
+``type`` file, you can write one of five special keywords: ``anon`` for
+anonymous pages, ``memcg`` for specific memory cgroup, ``young`` for young
+pages, ``addr`` for specific address range (an open-ended interval), or
+``target`` for specific DAMON monitoring target filtering.  Meaning of the
+types are same to the description on the :ref:`design doc
+<damon_design_damos_filters>`.
 
 In case of the memory cgroup filtering, you can specify the memory cgroup of
 the interest by writing the path of the memory cgroup from the cgroups mount
@@ -428,25 +429,30 @@ specify the start and end address of the range to ``addr_start`` and
 you can specify the index of the target between the list of the DAMON context's
 monitoring targets list to ``target_idx`` file.
 
-You can write ``Y`` or ``N`` to ``matching`` file to filter out pages that does
-or does not match to the type, respectively.  Then, the scheme's action will
-not be applied to the pages that specified to be filtered out.
+You can write ``Y`` or ``N`` to ``matching`` file to specify whether the filter
+is for memory that matches the ``type``.  You can write ``Y`` or ``N`` to
+``pass`` file to specify should this filter let the memory that satisfies the
+``type`` and ``matching`` pass though (allow) or be blocked by (reject) the
+filter.  Allowing means the scheme's action will be applied to the memory.
 
 For example, below restricts a DAMOS action to be applied to only non-anonymous
 pages of all memory cgroups except ``/having_care_already``.::
 
     # echo 2 > nr_filters
-    # # filter out anonymous pages
+    # # block anonymous pages
     echo anon > 0/type
     echo Y > 0/matching
+    echo N > 0/pass
     # # further filter out all cgroups except one at '/having_care_already'
     echo memcg > 1/type
     echo /having_care_already > 1/memcg_path
     echo Y > 1/matching
+    echo N > 1/pass
 
 Refer to the :ref:`DAMOS filters design documentation
-<damon_design_damos_filters>` for more details including when each of the
-filters are supported and differences on stats.
+<damon_design_damos_filters>` for more details including how multiple filters
+of different ``pass`` works, when each of the filters are supported, and
+differences on stats.
 
 .. _sysfs_schemes_stats:
 
-- 
2.39.5
