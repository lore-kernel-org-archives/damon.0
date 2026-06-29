Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5273EFD15;
	Mon, 29 Jun 2026 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744947; cv=none; b=XP3YcWZuPvMEM0CVtFCcn3JyiRLgKz19m/wzw7hY3Bri78MaXtx0qgXW6EZa66p8VsNyR2ab119c4fVpYn8XusDMV+8ZlLrnsSs5zbqbJPIzTp75lcamBfiHcXNPa3VePmBbMG0+Ln3Qx8B4D83RqA6rFEU7Ee8XCIDW2EonVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744947; c=relaxed/simple;
	bh=BoOkEFv0wOGt8d6xyNkc7MIt3IuM0ct5L9N/XMBWZps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ypa8djcs118b6u2BgdRRdiYhrc8xVNDxdzke25zQhaa7+xm1NK3Mf3wgptihm2Bp8OrjofKZK3hD7+QFwyoIW1I0uj4Xv/7gyw0aqVZJAAKeNwqgqFddcS+n1/h4GK/Lg3q1wdOH9naZhlUEVxCqrLTe7AstvdNlPetwMPNYRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6POtsQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6POtsQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFE91F00A3D;
	Mon, 29 Jun 2026 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744945;
	bh=glg/l+97lI6caoDUvXnrGH8mHyRTc6ftKl7nh2+8cz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6POtsQ7JwmFriLSUrGusEFtYk7bOEnNTG5xsCHvROuypRxbdJzTOv1JY3znWxYIL
	 Lsa+7xKyixqJnDniTwmiovWuuCzQYr2zooe5OLSRu2/I/j16UemiOs4/Rr8d3xFZkp
	 CwoJyfx+45upeJBPkYdN2+j4yrIrq4/uWq6WNkoBe1Y64oHEKeaC6dp+nO5hzLX8Pn
	 9nayPZef9Pa5G9WERePzsQ9x00WSkgICjp0bNoTplPbp1SP9uB2fnKNEsSw9LvbVVJ
	 dY1jP0GGKonOw9Qz9xAMZ7vHBzH9Jee/PT6Hsz218cwJkPz5lP6FFBI1buzoYkCnDp
	 B9c8EvOAix4NA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Doehyun Baek <doehyunbaek@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] Docs/{admin-guide,mm}/damon: fix DAMON documentation details
Date: Mon, 29 Jun 2026 07:55:34 -0700
Message-ID: <20260629145538.134832-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145538.134832-1-sj@kernel.org>
References: <20260629145538.134832-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doehyun Baek <doehyunbaek@gmail.com>

Fix minor DAMON documentation issues.  Correct the sysfs scheme file name
apply_interval_us, the DAMON_STAT module count, a malformed reference, a
misplaced label indentation, and a few typos.

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v5
- v5: https://lore.kernel.org/20260610053951.553739-1-doehyunbaek@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 Documentation/admin-guide/mm/damon/usage.rst |  8 ++++----
 Documentation/mm/damon/design.rst            | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 011296f1e7c21..b2649ea011f93 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -246,7 +246,7 @@ writing to and reading from the files.
 Under ``nr_regions`` directory, two files for the lower-bound and upper-bound
 of DAMON's monitoring regions (``min`` and ``max``, respectively), which
 controls the monitoring overhead, exist.  You can set and get the values by
-writing to and rading from the files.
+writing to and reading from the files.
 
 For more details about the intervals and monitoring regions range, please refer
 to the Design document (:doc:`/mm/damon/design`).
@@ -264,7 +264,7 @@ Please refer to  the :ref:`design document of the feature
 <damon_design_monitoring_intervals_autotuning>` for the internal of the tuning
 mechanism.  Reading and writing the four files under ``intervals_goal``
 directory shows and updates the tuning parameters that described in the
-:ref:design doc <damon_design_monitoring_intervals_autotuning>` with the same
+:ref:`design doc <damon_design_monitoring_intervals_autotuning>` with the same
 names.  The tuning starts with the user-set ``sample_us`` and ``aggr_us``.  The
 tuning-applied current values of the two intervals can be read from the
 ``sample_us`` and ``aggr_us`` files after writing ``update_tuned_intervals`` to
@@ -377,7 +377,7 @@ schemes/<N>/
 In each scheme directory, nine directories (``access_pattern``, ``quotas``,
 ``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
 ``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
-and ``apply_interval``) exist.
+and ``apply_interval_us``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -743,7 +743,7 @@ counter).  Finally the tenth field (``X``) shows the ``age`` of the region
 (refer to :ref:`design <damon_design_age_tracking>` for more details of the
 counter).
 
-If the event was ``damon:damos_beofre_apply``, the ``perf script`` output would
+If the event was ``damon:damos_before_apply``, the ``perf script`` output would
 be somewhat like below::
 
     kdamond.0 47293 [000] 80801.060214: damon:damos_before_apply: ctx_idx=0 scheme_idx=0 target_idx=0 nr_regions=11 121932607488-135128711168: 0 136
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2da7ca0d3d17a..c16a3bb288d07 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -86,7 +86,7 @@ To know how user-space can do the configuration via :ref:`DAMON sysfs interface
 documentation.
 
 
- .. _damon_design_vaddr_target_regions_construction:
+.. _damon_design_vaddr_target_regions_construction:
 
 VMA-based Target Address Range Construction
 -------------------------------------------
@@ -930,11 +930,11 @@ control parameters for the usage would also need to be optimized for the
 purpose.
 
 To support such cases, yet more DAMON API user kernel modules that provide more
-simple and optimized user space interfaces are available.  Currently, two
-modules for proactive reclamation and LRU lists manipulation are provided.  For
-more detail, please read the usage documents for those
-(:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim` and
-:doc:`/admin-guide/mm/damon/lru_sort`).
+simple and optimized user space interfaces are available.  Currently, three
+modules for access monitoring statistics, proactive reclamation, and LRU lists
+manipulation are provided.  For more detail, please read the usage documents for
+those (:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim`
+and :doc:`/admin-guide/mm/damon/lru_sort`).
 
 .. _damon_design_special_purpose_modules_exclusivity:
 
-- 
2.47.3
