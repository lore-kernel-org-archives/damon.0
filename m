Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BC31A041;
	Mon,  8 Dec 2025 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175409; cv=none; b=pSoS8r8t1aql6bkZ6UR+ueuOL5q8mXnQJDWwVBTioo9sU5oZzlI2HEx3TjdkKlNEwGSJuHtX2xtK4TrbJ7A8UtsLA3PYh4cWOX4orXHarVmWdbZtg8RNuDlsh1LOkBhcRb94nzZDmAA/KyVzaxIGjNVm2bMyMd04LjND4rs0F7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175409; c=relaxed/simple;
	bh=BIoh7tGOQxVtDXmZY7UkJm8cloeuUXw++f1jh950BB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIfRbH4kZdSPuSG9yW0T1QNVFZH20ZNy81OvBZFrJssrLIgcaNmJXHCwrWGJT495uqR+lfGdByckTOz/ON61PjeGy1Cex0YEGS0kqR4hZCdpuUDErU+yIn/VOcIdPVzgFI97L/8uQgY3MJ882uIbFnjUHYMoD8j92/aPgWGf41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLiFBe5i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLiFBe5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849C5C113D0;
	Mon,  8 Dec 2025 06:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175408;
	bh=BIoh7tGOQxVtDXmZY7UkJm8cloeuUXw++f1jh950BB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLiFBe5iASWmPouudCyfwWsSiKUlu5UqEFg7KIkZQ/15AoC6ic71KPhH1QVqAemjA
	 As92e7k+awmI3oMmflwuPiaCwOgOXfB750LFYek0Em9a1uC/cVSpPE3OW2RSaXxIns
	 UMOV1bRFEhAyqm5pSNNbLO7on0TsM7STy06hTRilHUjQsWRaUyAMAeuyJBCC9Yk6Wq
	 yqMU0lkBOT3CYS9cP38/onZptUSA9GxM8y/5OywZnlUl2U3y99wX5KeliufVc801xl
	 WRbO8jkdXllfuVYJAgwRLrwFlQ3JeEKU1Pdc7BqduYfgJQ9sG8/Yg5KJUUTwxPHGeS
	 7m/a/Ud+zItLw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
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
Subject: [RFC PATCH v3 12/37] Docs/admin-guide/mm/damon/usage: document sample primitives dir
Date: Sun,  7 Dec 2025 22:29:16 -0800
Message-ID: <20251208062943.68824-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the selective access sampling primitives
activation, which is essential for using page fault events as the access
check sampling primitive.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 7da4c002cb39..897a89950351 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -65,6 +65,7 @@ comma (",").
     │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs>`/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
+    │ │ │ │ │ │ sample/primitives/page_table,page_faults
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
     │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
@@ -215,9 +216,9 @@ contexts/<N>/monitoring_attrs/
 ------------------------------
 
 Files for specifying attributes of the monitoring including required quality
-and efficiency of the monitoring are in ``monitoring_attrs`` directory.
-Specifically, two directories, ``intervals`` and ``nr_regions`` exist in this
-directory.
+and efficiency of the monitoring, and types of accesses to monitor are in
+``monitoring_attrs`` directory.  Specifically, three directories, ``intervals``
+, ``nr_regions`` and ``sample`` exist in this directory.
 
 Under ``intervals`` directory, three files for DAMON's sampling interval
 (``sample_us``), aggregation interval (``aggr_us``), and update interval
@@ -232,6 +233,18 @@ writing to and rading from the files.
 For more details about the intervals and monitoring regions range, please refer
 to the Design document (:doc:`/mm/damon/design`).
 
+Under ``sample`` directory, a directory, ``primitives`` exists.
+
+contexts/<N>/monitoring_attrs/sample/primitives/
+------------------------------------------------
+
+This directory is for the access sampling primitives :ref:`selection
+<damon_design_sampling_primitives_selection>`.  Under ``primitives`` directory,
+two files, ``page_table`` and ``page_faults`` exist.  By writing ``Y`` or ``N``
+to these files, users can select whether to use the :ref:`page table accessed
+bit <damon_design_pte_accessed_bit_access_check>` and :ref:`page fault events
+<damon_design_page_fault_access_check>`, respectively.
+
 .. _damon_usage_sysfs_monitoring_intervals_goal:
 
 contexts/<N>/monitoring_attrs/intervals/intervals_goal/
-- 
2.47.3
