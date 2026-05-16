Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BF33E368;
	Sat, 16 May 2026 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956653; cv=none; b=UpzMsH1NrBGlw8e03LVZ4uo66iSQb4l+q2uQwebyzSl1WSnqMxHR9X7TyTsH/sx9YftTgbKaE3jVN3449+JO7SXgzMWc3xUvELVkjSMhrSJLgsEzwqwA+i2phaXUM9oidxxrg5dSIv9k64kCzr5zmwFYcfI2Bd4n4RQLWoS/c3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956653; c=relaxed/simple;
	bh=jMwAnu4yT3RRMK4ipWWfT8kscfFZqP8KMamyoxvugWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkEf2v53uVe05Qmio5cjBfdwm31FFTlSerzsqrj8OfnWHU8SNvNEe/Hm8CT2V/tajuiMZ01hQoPAV5+H6/ba1EzvQprhF/S2H8w41VDiySHfvVIgSO0+xnyEKqcMQd1uRPNUd4Ymeq2NYecTILzut+Gea74ZPjhznQ5MDyCKLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3NGrnmz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3NGrnmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC85C2BCF7;
	Sat, 16 May 2026 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956652;
	bh=jMwAnu4yT3RRMK4ipWWfT8kscfFZqP8KMamyoxvugWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3NGrnmzTBKZP3uPO5ftowoJ2YeL8zy04LqawTayW5hWW5YxiDbdxqND/k8dkap/N
	 y2ZVvxmupRBs74Bb7n4VpHOS5MPEtb0J/xW/ZaxW6oxsgifreh47SOcNaMM0V0HjYj
	 HjJMtZC7XoQ4URHYuTOwsTJWT7SOAJfF/oJHojwj2x56rh6YDoXHUhMaJsOPJA8yDP
	 6U9H7CSbFcrdVPKjchnvXuGw3dcZjUkRAwmdgsxTVZQoGPLc9TfM6uD/3tyAoN91Fj
	 862jeQ3szKe9LTTK8o2/V6zaLoZNiSIIwJxo1HTpJJlwqNAP6wVEPBsozmn7X+v4eY
	 Nq4NOrxL4bpkg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH v3 21/28] Docs/admin-guide/mm/damon/usage: document data attributes monitoring
Date: Sat, 16 May 2026 11:37:02 -0700
Message-ID: <20260516183712.81393-22-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
index 534e1199cf091..7b6074a1666f3 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -71,6 +71,11 @@ comma (",").
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
@@ -95,6 +100,9 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
+    │ │ │ │ │ │ │ │ │ probes
+    │ │ │ │ │ │ │ │ │ │ 0/hits
+    │ │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
@@ -221,8 +229,8 @@ contexts/<N>/monitoring_attrs/
 
 Files for specifying attributes of the monitoring including required quality
 and efficiency of the monitoring are in ``monitoring_attrs`` directory.
-Specifically, two directories, ``intervals`` and ``nr_regions`` exist in this
-directory.
+Specifically, three directories, ``intervals``, ``nr_regions`` and ``probes``
+exist in this directory.
 
 Under ``intervals`` directory, three files for DAMON's sampling interval
 (``sample_us``), aggregation interval (``aggr_us``), and update interval
@@ -256,6 +264,27 @@ tuning-applied current values of the two intervals can be read from the
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
@@ -601,10 +630,19 @@ tried_regions/<N>/
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
index aa08c899a3e5b..85d668e929194 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -269,6 +269,8 @@ interval``, DAMON checks if the region's size and access frequency
 (``nr_accesses``) has significantly changed.  If so, the counter is reset to
 zero.  Otherwise, the counter is increased.
 
+.. _damon_design_data_attrs_monitoring:
+
 Data Attributes Monitoring
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
