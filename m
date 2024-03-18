Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2C4DA0D
	for <damon@lists.linux.dev>; Mon, 18 Mar 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768278; cv=none; b=DjuZlN7wHHjUGOlS4n2fCHeqZ5SmM3vq6ReKQyd/WP7F0sIU+H6a5eZfD7A6GdlBljzD/8OJPvhmzrrYx/3SLg7qWVF9OIlYWwY5SBTzDZ0jzJC4XFUqxK78NxkBb/Ai5bqMRWFTd7knw7BIsd+6u6Hs1i+e+syQbeOlo2SewuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768278; c=relaxed/simple;
	bh=uGFUoH8Waa+J7z1fmC561WGAlEYBZGb45Er8B07BwhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGB1msVqAapKnZ8dP+fKaKynSrrTK8L7J+EvCy7rxiX8+7NScWfc8wKhGEo5FRedoXH/pBUjXTZFjnxHDB0ckq7iXwWFStCgU2UH4oZJIpGM8uf0Ud6lCiyzt7xwzrfhUD2GDiaVktYrmqNkz9gevCXf3nP2kw9x+KmqUBOneZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMtKch29; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMtKch29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710768275; x=1742304275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uGFUoH8Waa+J7z1fmC561WGAlEYBZGb45Er8B07BwhE=;
  b=OMtKch29PXKs7hfHqLHyg/4sjGnMpwJhUGQZLm7DAnFFvHplZT1SrCzY
   /6DAHE3oHOJ0Yjc25E1VQhfg6tAbKxHgh4OEFmS3FfyftrxekcTQz7T63
   zA/561xjUIngvLjgf0vmqCt3a7HuIBuCdK8iTD8yQ0m10NPu0wfVh6zaA
   IXv7HhgDuJy3/uF0APSuN6bQyJnSurw8f5EQNnTPbfg/vDzU5tzdHvLhR
   9+gp8sCuaPnCQhuIx+hzmapS01og2k6XRogIoBF4oeM3uda/PQiZiIznq
   US8/n08CqW01UYSW7PcLhpADlAj0yi03iKaLN32hxqPr1LGZlrvBP5Ck/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="23037999"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="23037999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="14102868"
Received: from adr-par-inspur1.iind.intel.com ([10.223.93.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:31 -0700
From: Aravinda Prasad <aravinda.prasad@intel.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	linux-kernel@vger.kernel.org
Cc: aravinda.prasad@intel.com,
	s2322819@ed.ac.uk,
	sandeep4.kumar@intel.com,
	ying.huang@intel.com,
	dave.hansen@intel.com,
	dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com,
	antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com
Subject: [PATCH v2 3/3] mm/damon: documentation updates
Date: Mon, 18 Mar 2024 18:58:48 +0530
Message-Id: <20240318132848.82686-4-aravinda.prasad@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240318132848.82686-1-aravinda.prasad@intel.com>
References: <20240318132848.82686-1-aravinda.prasad@intel.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the kernel documentation.

Signed-off-by: Aravinda Prasad <aravinda.prasad@intel.com>
---
 Documentation/mm/damon/design.rst | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5620aab9b385..59014ecbb551 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -139,6 +139,48 @@ the interference is the responsibility of sysadmins.  However, it solves the
 conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
+Profiling enhancement for virtual address space
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For virtual address space tracking, relying on checking Accessed bit(s) only
+at the leaf level of the page table is inefficient. Hardware architectures
+have supported Accessed bit(s) at all levels of the page table tree by
+updating them during the page table walk. Hence, DAMON dynamically
+profiles different levels (PMD/PUD/P4D) of a multi-level page table tree.
+
+DAMON leverages the following key insight: a data page that is accessed
+should also have the Accessed bit set at PMD, PUD, P4D, and PGD entry.
+Similarly, if the Accessed bit in a PGD entry (or a PUD/PMD entry) is
+not set, then none of the data pages under the PGD entry (or PUD/PMD
+entry) subtree are accessed. DAMON profiles Accessed bits at the highest
+possible level of the page table tree to identify the regions that are
+accessed.
+
+For example, consider a region and the sampling address (SA) in the below
+figure. The address range of a PUD entry corresponding to SA is within
+region bounds and hence PUD is picked for checking and setting the
+Accessed bits. However, this not true if P4D is picked for profiling.
+Hence in this case PUD is the highest possible level that can be picked
+for profiling.
+                         .......
+                         + P4D +
+                         .......
+                        /       \
+                       /         \
+                      /           \
+                     /             \
+                    /               \
+                   /  .......        \
+                  /   + PUD +         \
+                 /    .......          \
+                /    /       \          \
+- - - - - +-----*---*--+====+-*------+- -*- - -
+          +            # SA #        +
+          +            #    #        +
+- - - - - +------------+====+--------+- - - - -
+
+          | ----- DAMON region ------|
+
 
 Core Logics
 ===========
-- 
2.21.3

