Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880B1DFE22;
	Mon,  6 Jan 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192050; cv=none; b=T4p0Id5/xID7tz+rOIZCZCJlX4MkSwCg2Gl+SoCm07DpPo39J2NdeTeCGBQz8DDva+RwI4JhtVZ1T9yzFBKy7UnHU9Fof0BlHumqOc9LuxVUhkduA7W2yG0++cONjI0v8/htsSK86Nc9+dJvOsy938NV8ttedcID0Wj/4NeYT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192050; c=relaxed/simple;
	bh=DyNPqMVv1qWkL7drvuA1I9SW5htKBzMRMHtsO46tXdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N25y9OhEsNS1g9POJ81lbWl/BZeSj9Jw1327HB1t536UuW8tlDS7JzSdfRjLrQ34E7yvSJ/L3qwMcNTsXVEKfjdfZQ6CkeSPrkqrBW5xwWfPGN2DdrAbOWuqR4Abw3HkBjBz7PttcYXb9dNiHouJ4vW4pjIa69Msj+0AJ3o1/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed4MFfHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed4MFfHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD25C4CED6;
	Mon,  6 Jan 2025 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192050;
	bh=DyNPqMVv1qWkL7drvuA1I9SW5htKBzMRMHtsO46tXdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ed4MFfHgRDl2+cLT291VwyY3qps68Bad9io/5jDB13HhKMjE0QfVufeCR39v5mjLG
	 pIqzuFBY463MZ1efvzIt4UaUVWBLZAUv05VMd77Egy7FrOvQrVl8ua5lPKZ9pwTINH
	 DBkb6MDIiXD48pH7fGXjoUnt7ljp2L+GdFzB7OedYBHAYQLduZNvjXf9zOwhpNlhZl
	 ayF34YfrT+j2ZhwRNy/wC7Vlc8rfjXS0w4duRLoly1kuowElUXoJ59dBWTrpCH53pS
	 DxUvBVtrcm34LWbWvertf3KlnYIRBvvB38/hnxFvAh/7xF2qkLpOXANMzuSldUNHMM
	 iSefRCqGx86Bw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/16] Docs/mm/damon/design: add 'statistics' section
Date: Mon,  6 Jan 2025 11:33:47 -0800
Message-Id: <20250106193401.109161-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS stats are important feature for tuning of DAMOS-based access-aware
system operation, and efficient access pattern monitoring.  But not well
documented on the design document.  Add a section on the document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5385ea04c2fd..aa2e4694ee14 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -539,6 +539,44 @@ To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`filters <sysfs_filters>` part of the
 documentation.
 
+Statistics
+~~~~~~~~~~
+
+The statistics of DAMOS behaviors that designed to help monitoring, tuning and
+debugging of DAMOS.
+
+DAMOS accounts below statistics for each scheme, from the beginning of the
+scheme's execution.
+
+- ``nr_tried``: Total number of regions that the scheme is tried to be applied.
+- ``sz_trtied``: Total size of regions that the scheme is tried to be applied.
+- ``nr_applied``: Total number of regions that the scheme is applied.
+- ``sz_applied``: Total size of regions that the scheme is applied.
+- ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
+
+"A scheme is tried to be applied to a region" means DAMOS core logic determined
+the region is eligible to apply the scheme's :ref:`action
+<damon_design_damos_action>`.  The :ref:`access pattern
+<damon_design_damos_access_pattern>`, :ref:`quotas
+<damon_design_damos_quotas>`, :ref:`watermarks
+<damon_design_damos_watermarks>`, and :ref:`filters
+<damon_design_damos_filters>` that handled on core logic could affect this.
+The core logic will only ask the underlying :ref:`operation set
+<damon_operations_set>` to do apply the action to the region, so whether the
+action is really applied or not is unclear.  That's why it is called "tried".
+
+"A scheme is applied to a region" means the :ref:`operation set
+<damon_operations_set>` has applied the action to at least a part of the
+region.  The :ref:`filters <damon_design_damos_filters>` that handled by the
+operation set, and the types of the :ref:`action <damon_design_damos_action>`
+and the pages of the region can affect this.  For example, if a filter is set
+to exclude anonymous pages and the region has only anonymous pages, or if the
+action is ``pageout`` while all pages of the region are unreclaimable, applying
+the action to the region will fail.
+
+To know how user-space can read the stats via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
+documentation.
 
 Regions Walking
 ~~~~~~~~~~~~~~~
-- 
2.39.5
