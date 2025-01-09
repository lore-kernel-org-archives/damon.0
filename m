Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB7200B95;
	Thu,  9 Jan 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445108; cv=none; b=taDw5wrgPdpF0ihjNY3p1jFLML5BtR0MczBUz1+8qZvgg6WnTXYEpT6uUIMwisjtVluMtmn14J5oov/Av/7IthGEt61rtn8zT7DoxKoZf0BzX/ILA54Z8w2vKrqHYPFJUE/t2kxCq5VPQUKbKL1LqYkb1cZhgVIVuji+QET16Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445108; c=relaxed/simple;
	bh=IPoCvtuIbYdm4duAoYfcI65fUkKJC3T/ANKcwt19fcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKclcyqkYLbt9gSCrynEhNmmyqfbqVr6uS4sCTtAv0pZUtaDO8BZlvBTnhKMkQRSayo0WXWZZu8OwhGvd82qiGakpSbLdSa837WiTWILgpFqWQmDt67xGlOd3/7Xg7ofzSKGfcX2QOTMb0JPUaFSqFD/WRsS6zt/bXYL24lprmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYYfWteP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYYfWteP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE000C4CED2;
	Thu,  9 Jan 2025 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445108;
	bh=IPoCvtuIbYdm4duAoYfcI65fUkKJC3T/ANKcwt19fcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYYfWtePMZTuxd4s2GRIBuHgMcxlCm6/g/nwHTX+qzJ7Q6oLzDb2N+B1qx/ANy6JG
	 L1b4uwDm3AKkYPa/sfWJjSAL66RbSTW3nLyZWT9jTaASpJ4cEXQ74jjvoyilcVQY1d
	 PP7mKtMt24H07N0YUyegP4mhDWuLcRUT9CUFr2gTBJQRpEUpGiCB83EIe8lfy2Xhzu
	 oTP6cwo+p9jhLLfM95fIY6vLvK5qkcacQKOoIytnlhKZccWnrLkiW12ZH6my+gSpAs
	 EQd6ed51aVz/lHT/cjkYTLpliY6WIn34vQifkLkZ5cCzCG4V6mPAg0TeF79cD7jOhU
	 yuOlq4RRSgFHw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 10/10] Docs/admin-guide/mm/damon/usage: document DAMOS filter 'allow' sysfs file
Date: Thu,  9 Jan 2025 09:51:26 -0800
Message-Id: <20250109175126.57878-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added 'allow' sysfs file for
DAMOS filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 33 +++++++++++---------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 8df3357dcfa3..f0d0c20711d6 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -83,7 +83,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
+    │ │ │ │ │ │ │ │ 0/type,matching,memcg_id,allow
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
@@ -406,13 +406,14 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each filter.  The filters are evaluated
 in the numeric order.
 
-Each filter directory contains six files, namely ``type``, ``matcing``,
-``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.  To ``type``
-file, you can write one of five special keywords: ``anon`` for anonymous pages,
-``memcg`` for specific memory cgroup, ``young`` for young pages, ``addr`` for
-specific address range (an open-ended interval), or ``target`` for specific
-DAMON monitoring target filtering.  Meaning of the types are same to the
-description on the :ref:`design doc <damon_design_damos_filters>`.
+Each filter directory contains seven files, namely ``type``, ``matching``,
+``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.
+To ``type`` file, you can write one of five special keywords: ``anon`` for
+anonymous pages, ``memcg`` for specific memory cgroup, ``young`` for young
+pages, ``addr`` for specific address range (an open-ended interval), or
+``target`` for specific DAMON monitoring target filtering.  Meaning of the
+types are same to the description on the :ref:`design doc
+<damon_design_damos_filters>`.
 
 In case of the memory cgroup filtering, you can specify the memory cgroup of
 the interest by writing the path of the memory cgroup from the cgroups mount
@@ -422,25 +423,29 @@ specify the start and end address of the range to ``addr_start`` and
 you can specify the index of the target between the list of the DAMON context's
 monitoring targets list to ``target_idx`` file.
 
-You can write ``Y`` or ``N`` to ``matching`` file to filter out pages that does
-or does not match to the type, respectively.  Then, the scheme's action will
-not be applied to the pages that specified to be filtered out.
+You can write ``Y`` or ``N`` to ``matching`` file to specify whether the filter
+is for memory that matches the ``type``.  You can write ``Y`` or ``N`` to
+``allow`` file to specify if applying the action to the memory that satisfies
+the ``type`` and ``matching`` should be allowed or not.
 
 For example, below restricts a DAMOS action to be applied to only non-anonymous
 pages of all memory cgroups except ``/having_care_already``.::
 
     # echo 2 > nr_filters
-    # # filter out anonymous pages
+    # # disallow anonymous pages
     echo anon > 0/type
     echo Y > 0/matching
+    echo N > 0/allow
     # # further filter out all cgroups except one at '/having_care_already'
     echo memcg > 1/type
     echo /having_care_already > 1/memcg_path
     echo Y > 1/matching
+    echo N > 1/allow
 
 Refer to the :ref:`DAMOS filters design documentation
-<damon_design_damos_filters>` for more details including when each of the
-filters are supported and differences on stats.
+<damon_design_damos_filters>` for more details including how multiple filters
+of different ``allow`` works, when each of the filters are supported, and
+differences on stats.
 
 .. _sysfs_schemes_stats:
 
-- 
2.39.5
