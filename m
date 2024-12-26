Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206911A238A;
	Thu, 26 Dec 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251310; cv=none; b=uyDkugCgLjnfijd5q3W4viKouutVITwfXaIUAsIz9fA8epx00cPoIAWh/gCUOMeruysaT9clYU8a0DWMiBNKjMoY6gLY5BE1I2s/FBM9C4IB0o6CqR30Lq7F6LRwHGpOBJ84SpQo7cWgf6OvDtu/9whZQySV8xLqR5zk34Ur9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251310; c=relaxed/simple;
	bh=HT0LgniPNFcsw7wjoUpvnZv1QsdPFkRx75obGWvCxP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrqXN6yvNGRu/eEoG4MIhPI2Kkm/SeszNyWCBSKhFSdKD050EYT17KnBpO5G6dY99lB+Rwd+swUaLwqPhOYYfTtWWKKIBuGwYBpFAXRFRLBcWiD6UcFzGol/qWc1khZYn3HtjojM5tFdZm0nqS4oKQZ52YNMb9gh2wlM7elcbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiFtleYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiFtleYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D459C4CED7;
	Thu, 26 Dec 2024 22:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251309;
	bh=HT0LgniPNFcsw7wjoUpvnZv1QsdPFkRx75obGWvCxP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiFtleYHZx2N3jjzQK6mvKWSmXakMJYqF2WgASexsinNgIeXFu2I9zmBYgi+WTcXt
	 wA2oNmJZcnpDU3HMGTFzs+uoOqb8jYVn8EhVDR6qbFrwx5fpRghRjdVB5eEgVj0I0J
	 M5MMPngoMLlPMnqUPC7V45dAI0sILUxI494Nt3IXdoOhU/XxTCtjrAGACnscAtkao7
	 nc7cMXTqRdHPB+neSgZ31SVYlSeSshFPdgvtC27yKlkQxs1L5lZTodsP+kDE6sM/iU
	 RnUXRL2D8tLLdauASaT+6FLS9RGFVj/y6cvWKx9spf8PJ7VP4rJ5tOYVVzPMFvH2Hd
	 o4ltyfydy4XlA==
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
Subject: [RFC PATCH 10/10] Docs/admin-guide/mm/damon/usage: document DAMOS filter 'pass' sysfs file
Date: Thu, 26 Dec 2024 14:14:45 -0800
Message-Id: <20241226221445.78433-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
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
     \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/target_metric,target_value,current_value
     \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`filters <sysfs_filters>`/nr_filters
-    \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/type,matching,memcg_id
+    \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/type,matching,memcg_id,pass
     \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd \ufffd\ufffd\ufffd 0/start,end,nr_accesses,age,sz_filter_passed
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
