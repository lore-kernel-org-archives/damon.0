Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDE3955ED;
	Mon, 18 May 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147692; cv=none; b=jZ4Wbbt91W9JF+5OCoFPYl/UmUQz2ewMP+Vp1qk0X7Iy2fN9Se6nX/QBu9TmJRjIt5hGNQHBEaw9PlZ/IixD/OLZdlsrkGYdf/E9DoIlX+DJoNCXXdubNQByvIcGO51r+SAijLiEGsGXMP5bNGgErUa5nIN7pOkFt0p8fjcQdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147692; c=relaxed/simple;
	bh=7jjwSTj0oWvjONIEU6hizSouOGWRpTuxqy3LQsj9UQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWSN4v+nLEDau07cA5eI679oEMTSBCxUjpogXA7HyJFS5+gYiQuTQtg0N7SaLDCgRjlSnymFG8SAKcluzilHXKANOB2JrVeXK3iloonwdYWEb/CKDpQnYaLN6TmOfSwZtYNvfjMftV8SY/h5i20tPCq72rFmTR8GXr6wEJPQ2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYki/Wx0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYki/Wx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF72C2BCB8;
	Mon, 18 May 2026 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147691;
	bh=7jjwSTj0oWvjONIEU6hizSouOGWRpTuxqy3LQsj9UQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYki/Wx0XXVJgKBiW6cFEviE1oaaTeAmamUswBb7Nj79oB4pX/QV4+bmAo8ErWIMF
	 LQ7PR0kapL/4lP90Bkcu1srMFcPDP3GRpljYT+oafXfi4rBfXr145kGW9teb+RrNr7
	 5Qoh3qXYWOkWclcotzKkKarSeLE03ubHKXWFY1KyFXMXeKv21/ikR+IbsPrUaldnAG
	 xsJxq/j62exPyjowPIXpvW33jm1KcLzqa1abnFFFhFEySpHtNNv3FaOMI1wIqG3oVt
	 tmjjcDu9e+jj7WT4v6D7YLWL+eLzTtY9cKgagm4xTUHXw4eheLCI/Xk1wEPlL06Rvv
	 RqWIOSgzqgMzA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 21/28] Docs/admin-guide/mm/damon/usage: document data attributes monitoring
Date: Mon, 18 May 2026 16:41:09 -0700
Message-ID: <20260518234119.97569-22-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added data attributes
monitoring feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 44 ++++++++++++++++++--
 Documentation/mm/damon/design.rst            |  2 +
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index c74dfa0ff3bfb..abd38385b3c23 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -72,6 +72,11 @@ comma (",").
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ nr_regions/min,max
+    │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
+    │ │ │ │ │ │ │ 0/filters/nr_filters
+    │ │ │ │ │ │ │ │ 0/type,matching,allow
+    │ │ │ │ │ │ │ │ ...
+    │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
     │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
     │ │ │ │ │ │ │ :ref:`regions <sysfs_regions>`/nr_regions
@@ -98,6 +103,9 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
+    │ │ │ │ │ │ │ │ │ probes
+    │ │ │ │ │ │ │ │ │ │ 0/hits
+    │ │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
@@ -227,8 +235,8 @@ contexts/<N>/monitoring_attrs/
 
 Files for specifying attributes of the monitoring including required quality
 and efficiency of the monitoring are in ``monitoring_attrs`` directory.
-Specifically, two directories, ``intervals`` and ``nr_regions`` exist in this
-directory.
+Specifically, three directories, ``intervals``, ``nr_regions`` and ``probes``
+exist in this directory.
 
 Under ``intervals`` directory, three files for DAMON's sampling interval
 (``sample_us``), aggregation interval (``aggr_us``), and update interval
@@ -262,6 +270,27 @@ tuning-applied current values of the two intervals can be read from the
 ``sample_us`` and ``aggr_us`` files after writing ``update_tuned_intervals`` to
 the ``state`` file.
 
+.. _damon_usage_sysfs_probes:
+
+contexts/<N>/monitoring_attrs/probes/
+-------------------------------------
+
+A directory for registering :ref:`data attributes monitoring
+<damon_design_data_attrs_monitoring>` probes.
+
+In the beginning, this directory has only one file, ``nr_probes``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each monitoring probe.
+
+In each probe directory, one directory, ``filters`` exists.  The directory
+contains files for installing filters for the probe, that is used to determine
+the data attribute for the probe.
+
+In the beginning, ``filters`` directory has only one file, ``nr_filters``.
+Writing a number (``N``) to the file creates the number of child directories
+named ``0`` to ``N-1``.  Each directory represents each filter and works in a
+way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
+
 .. _sysfs_targets:
 
 contexts/<N>/targets/
@@ -615,10 +644,19 @@ tried_regions/<N>/
 ------------------
 
 In each region directory, you will find five files (``start``, ``end``,
-``nr_accesses``, ``age``, and ``sz_filter_passed``).  Reading the files will
+``nr_accesses``, ``age`` and ``sz_filter_passed``).  Reading the files will
 show the properties of the region that corresponding DAMON-based operation
 scheme ``action`` has tried to be applied.
 
+tried_regions/<N>/probes/
+-------------------------
+
+In each region directory, one directory (``probes``) also exists.  In the
+directory, subdirectories named ``0`` to ``N-1`` exists.  ``N`` is the number
+of installed probes.  In each number-named directory, a file (``hits``) exist.
+Reading the file shows the number of data attributes monitoring probe-hit
+positive samples of the region.
+
 Example
 ~~~~~~~
 
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 7fcb726263c1a..937960d2b6d73 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -276,6 +276,8 @@ interval``, DAMON checks if the region's size and access frequency
 (``nr_accesses``) has significantly changed.  If so, the counter is reset to
 zero.  Otherwise, the counter is increased.
 
+.. _damon_design_data_attrs_monitoring:
+
 Data Attributes Monitoring
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
