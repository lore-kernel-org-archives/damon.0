Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C002F0C7C;
	Sun, 26 Oct 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502945; cv=none; b=P3Y9TbZMKpOhlKrYBbVMr86ZK3tYkCWL2sZVbGKS1vZ5i9SMU/rQHUxhrYHeGiAqp1FLLiWXYe5pQjmCeRBWHmW78td9xoi0U1rrBJCmg5ZeVZ9yDR14Jd1oDD22ZLwcMyssI0ibUSnjDlDlB2+SOnj7FLVXN8XSV8YXp/PZ0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502945; c=relaxed/simple;
	bh=Ye9gPfLydwxtuswRkRjGLaZyg7wyJw5BXTXb4LCA/9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzOcv0akjS3ErLmlPuEmtbvrT8kjCITS8QhmdxzWf3SI1spQmlXJtxzSvc+cWIwDufAGTiJ4iDPdD+xSPUF7lCfAEWnmmX40j/puX8bC7ymopjx1LUPKrwAAJT2jdU+IMIBOI+lyLPl/9LDAb/w3n5ryNAaJ5N9Erk52nhRNqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4iaAqhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4iaAqhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0960FC116B1;
	Sun, 26 Oct 2025 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502945;
	bh=Ye9gPfLydwxtuswRkRjGLaZyg7wyJw5BXTXb4LCA/9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4iaAqhwB5JvVaVfwkYNA5j7yeVP+XbXRkVweDT6FKg34mWaD7CCR+yBJ+JHF23Sp
	 GlxkkRonxGlH0NjNs5HuLLO2OBxbsOz2Jaz2k/HnLBlMOtcR3VOnw43j96aauZd1/C
	 23xcOPBr4ETIG0JTrPFHFJZb+VgolCm39vTsqNgsXfg9GR7IbAntrIsG8DLxDZeX0d
	 LxX9F132MxbbKEYAur+rGu21J4TJqQNeTCd7ypogaBVJse3HzcJ+LdQr4AUVKlfBML
	 ZuJ7XARQDRwvVdzKKb3cf4JBRGUZvSaqV0Vdmc0sqJOVSL3GWVfZH3VTGkKcEBIsVl
	 oC7o9uQY5iHzw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] Docs/admin-guide/mm/damon/lru_sort: document addr_unit parameter
Date: Sun, 26 Oct 2025 11:22:11 -0700
Message-ID: <20251026182216.118200-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026182216.118200-1-sj@kernel.org>
References: <20251026182216.118200-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for
DAMON_LRU_SORT") introduced the 'addr_unit' parameter for
DAMON_LRU_SORT.  But the usage document is not updated for that.  Update
the document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../admin-guide/mm/damon/lru_sort.rst         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 7b0775d281b4..72a943202676 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -211,6 +211,28 @@ End of target memory region in physical address.
 The end physical address of memory region that DAMON_LRU_SORT will do work
 against.  By default, biggest System RAM is used as the region.
 
+addr_unit
+---------
+
+A scale factor for memory addresses and bytes.
+
+This parameter is for setting and getting the :ref:`address unit
+<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_RECLAIM.
+
+``monitor_region_start`` and ``monitor_region_end`` should be provided in this
+unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
+``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
+Then DAMON_LRU_SORT will work for 10 KiB length of physical address range that
+starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
+
+Stat parameters having ``bytes_`` prefix are also in this unit.  For example,
+let's suppose values of ``addr_unit``, ``bytes_lru_sort_tried_hot_regions`` and
+``bytes_lru_sorted_hot_regions`` are ``1024``, ``42``, and ``32``,
+respectively.  Then it means DAMON_LRU_SORT tried to LRU-sort 42 KiB of hot
+memory and successfully LRU-sorted 32 KiB of the memory in total.
+
+If unsure, use only the default value (``1``) and forget about this.
+
 kdamond_pid
 -----------
 
-- 
2.47.3
