Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAE194A73;
	Thu, 19 Dec 2024 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581022; cv=none; b=VpvuMKA2tJS37zFz69hf8EzbC8v/3LapQpfrojfEZwb0rX2DczsXma9Ly9sNwqyjLJ0PEzNaCMQvkIbRZ7z9l/JN7q/bwga9lYvCzDC4HqPidBYcTD9KSy4ffdKoSHUUN8drUaNSmV3oOINg5JvYA4+77vul+ta9gBT7EtxUxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581022; c=relaxed/simple;
	bh=Aw/qCp2OKsDn0Vp0elm6T6OQsuDbvPiF9mR4j+5HNd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPmUx8FVcSW8TXlU6NnSFvkjJRV2Fhm+/qSPIENyagTJuzQ1TbJqGkqBRTqSE0Hbqmww8+eOa4pbBDSxGgP0rgX500X+j+NUY79SliykcVWINB1sYKucROPLqMy5Q7TgLieYtwveRGA2T8xM0Y3M7wJoa+9W+rlU4aLpBzkNGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2tTbxmm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2tTbxmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A633C4CED4;
	Thu, 19 Dec 2024 04:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581022;
	bh=Aw/qCp2OKsDn0Vp0elm6T6OQsuDbvPiF9mR4j+5HNd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2tTbxmmglczCo90VZCkRAMan0dUUYbiwkWiCX2bjsVd1i+/CVEd/djOxN65DViYd
	 HGVVxJfV0ZWEdfO90jfrdX5oVaqE/UB+bTuatA29NoQCBPHwT7S6g9ire81fx8tiwZ
	 61pMKZSdck6PEctLG8ntkCGUhm8PsFsefZyW4wdBaAIMY8x2kkW5VCSiVFjc4lLqVC
	 C30C5/I+w5vNXVJOD2e635SINKRRoA5bKTvzRiGPwA+n7x1sZqXOV34DC7W0N+4LLF
	 y/eurOoKcukW+56yU17d2jDsk9Vr84FufCsYdZaYkZpKiuKj4NL9WovsffvY0w3Cs3
	 kKd0N9evuuuCQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/18] Docs/mm/damon/design: add 'statistics' section
Date: Wed, 18 Dec 2024 20:03:12 -0800
Message-Id: <20241219040327.61902-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
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
 Documentation/mm/damon/design.rst | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a577ae40e71c..8710fa71ad71 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -539,6 +539,43 @@ To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
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
+<damon_design_damos_access_patter>`, :ref:`quotas <damon_design_damos_quotas>`,
+:ref:`watermarks <damon_design_damos_watermarks>`, and :ref:`filters
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

