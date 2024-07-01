Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8EA17164D;
	Mon,  1 Jul 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862035; cv=none; b=EG2Z+fmV2y5513kj8geTT0yICeYvid1PtGP1vko8cU06jZo8BRcEqmh7NfvQZXN7VvV3YxIotXN7Jmltmp/XzPY859gzqmvm2bb3g/g1LJnA43DyQRE6UpGSfJl2ylTNImWJ/cFdJ8KubeNMlD8bsh9/qIE7eOymjnVyZeNIRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862035; c=relaxed/simple;
	bh=rJ3ulbTwJLxSK96iYt4sNzwcCfFFXn8buJECo4dQpTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Et4xpd+0HzaH0zm98Tkaqbz4Zf5iU6k83YUQEMyj6vl0SdnwXo87h0zDgwxSx4Fcg/QZji31Mys3Jegt0Pj4RPt9a17iYNbNPZFUUEAAdmRG0FPYYDehVH5f5tpPd7TVLJgUqj27O2cCeXuckTQRjOfSJ5qkyyrJ94TaWwqai3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqTrsWas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqTrsWas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E82C4AF0F;
	Mon,  1 Jul 2024 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862034;
	bh=rJ3ulbTwJLxSK96iYt4sNzwcCfFFXn8buJECo4dQpTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqTrsWasCO9YZQkdSM3QfYQxJG7JeXh+GPBfrnWwYuEEdvLsLiSebNb3Vh4KqQSq/
	 9qow/oTaq2r0k/ubIKn3M0y2bStvbP2Qso3zi0Vaph0JxWnymFBzLpAMR/JzZhpLLB
	 pBWXrLejrCSlPIc6OUeaVSlHVootzYshYHLiK5Mh1pnjpYt4ZTKK7rPG5FPnO1TbDI
	 mGi/kniviA+TRPt6uqcyDG8A0KixgKd9/4Gw8obiLKK3feCcMjBeGaRZG2dkMKBHpu
	 6YSvOTk+G/13Qxe+GJE/+NR/RVCVhfypcxfcMgdsVaEH76ADaNYIJipHKgE5oPawLk
	 D/qaDN0re7N1A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] Docs/mm/damon/design: move 'Configurable Operations Set' section into 'Operations Set Layer' section
Date: Mon,  1 Jul 2024 12:27:02 -0700
Message-Id: <20240701192706.51415-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Configurable Operations Set' section is for providing a description of
the pluggability of the operations set layer.  Just after that,
'Operations Set Layer' section, which is dedicated for the entire things
of the layer, follows.  The layout is odd, and some descriptions are
duplicated.  Move 'Configurable Operations Set' section into 'Operations
Set Layer' and re-write some of the detailed descriptions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 47 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 991839200f80..f7029bc840ce 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -33,30 +33,6 @@ DAMON subsystem is configured with three layers including
   layer.
 
 
-.. _damon_design_configurable_operations_set:
-
-Configurable Operations Set
----------------------------
-
-For data access monitoring and additional low level work, DAMON needs a set of
-implementations for specific operations that are dependent on and optimized for
-the given target address space.  On the other hand, the accuracy and overhead
-tradeoff mechanism, which is the core logic of DAMON, is in the pure logic
-space.  DAMON separates the two parts in different layers, namely DAMON
-Operations Set and DAMON Core Logics Layers, respectively.  It further defines
-the interface between the layers to allow various operations sets to be
-configured with the core logic.
-
-Due to this design, users can extend DAMON for any address space by configuring
-the core logic to use the appropriate operations set.  If any appropriate set
-is unavailable, users can implement one on their own.
-
-For example, physical memory, virtual memory, swap space, those for specific
-processes, NUMA nodes, files, and backing memory devices would be supportable.
-Also, if some architectures or devices supporting special optimized access
-check primitives, those will be easily configurable.
-
-
 Programmable Modules
 --------------------
 
@@ -72,11 +48,32 @@ used by the user space end users.
 Operations Set Layer
 ====================
 
-The monitoring operations are defined in two parts:
+.. _damon_design_configurable_operations_set:
+
+For data access monitoring and additional low level work, DAMON needs a set of
+implementations for specific operations that are dependent on and optimized for
+the given target address space.  For example, below two operations for access
+monitoring are address-space dependent.
 
 1. Identification of the monitoring target address range for the address space.
 2. Access check of specific address range in the target space.
 
+DAMON consolidates these implementations in a layer called DAMON Operations
+Set, and defines the interface between it and the upper layer.  The upper layer
+is dedicated for DAMON's core logics including the mechanism for control of the
+monitoring accruracy and the overhead.
+
+Hence, DAMON can easily be extended for any address space and/or available
+hardware features by configuring the core logic to use the appropriate
+operations set.  If there is no available operations set for a given purpose, a
+new operations set can be implemented following the interface between the
+layers.
+
+For example, physical memory, virtual memory, swap space, those for specific
+processes, NUMA nodes, files, and backing memory devices would be supportable.
+Also, if some architectures or devices support special optimized access check
+features, those will be easily configurable.
+
 DAMON currently provides below three operation sets.  Below two subsections
 describe how those work.
 
-- 
2.39.2

