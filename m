Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2C23E333;
	Mon,  3 Mar 2025 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040261; cv=none; b=tIqhL5hY/ZWcNd+kQd9ekoO2xwUnEyuD9X85xDhYgy60K7/74MLxYm11N6EDIAryKu7OzeWqt+bsUAsA4inhW2IwMUJ6lqPlkmoC+wPI3PwJaBH+NBCj+4z2w0qL/y/QGiLmoeuNJTjyEbJoxhX0/25GXh3oM8Mj1Y83zqfpmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040261; c=relaxed/simple;
	bh=ki10B3zR5mixA9j/A7CWQx5SObRymhGEPj5DgsDuWCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqBYZcrzvszUsrovCJWOnvPX5V5wEAu3eWwW6O3l8WXsVhjnnkbgiFUXPef4wQQ3Xp+SW7L6JStyaW/PbE7EhXT0v5+Y0tksgT+C2v04LLWd8y6mDC15rYMYoI+zlM1JpszSCdux+7EfCIhMzX6FHSISJScVA2s1PCgDxzbqRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSqjdJHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSqjdJHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD32C4CED6;
	Mon,  3 Mar 2025 22:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040261;
	bh=ki10B3zR5mixA9j/A7CWQx5SObRymhGEPj5DgsDuWCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSqjdJHAWbCdKV26S5QgEbhmE/6LeicMKJ+wZON2b3jtP32CDTJN8OUy8U8OY7syH
	 u64jhcgK91le676PO9VA6Vmk32Jv73Zy0spDofUVWFUwh2KV8KoZboLwh4F6Y6sG/X
	 QwDCblpotBaH8hZrUKCgm2GFZ44sTsxbteMzd0GqOgDDRQ/oGMOA3PQIqpNybb8FBs
	 ByTkVeW2FI03SCLnn4RHpRyQWXT0Gb0iJVGQgzf83PjqR72I2Xenb45FltOLWcHJ72
	 E8/IRa4wDv4/hKWWK4PC9qEBkIo41NxYaGiEmj/Os9LLrGNPdmIMzh8+RXyjPPnf8e
	 jpAtHzLHxn7Rg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] Docs/admin-guide/mm/damon/usage: add intervals_goal directory on the hierarchy
Date: Mon,  3 Mar 2025 14:17:26 -0800
Message-Id: <20250303221726.484227-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document DAMON sysfs interface usage for DAMON sampling and aggregation
intervals auto-tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 25 ++++++++++++++++++++
 Documentation/mm/damon/design.rst            |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index dc37bba96273..de549dd18107 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -64,6 +64,7 @@ comma (",").
     │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations
     │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs>`/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
+    │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
     │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target
@@ -132,6 +133,11 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``off``: Stop running.
 - ``commit``: Read the user inputs in the sysfs files except ``state`` file
   again.
+- ``update_tuned_intervals``: Update the contents of ``sample_us`` and
+  ``aggr_us`` files of the kdamond with the auto-tuning applied ``sampling
+  interval`` and ``aggregation interval`` for the files.  Please refer to
+  :ref:`intervals_goal section <damon_usage_sysfs_monitoring_intervals_goal>`
+  for more details.
 - ``commit_schemes_quota_goals``: Read the DAMON-based operation schemes'
   :ref:`quota goals <sysfs_schemes_quota_goals>`.
 - ``update_schemes_stats``: Update the contents of stats files for each
@@ -213,6 +219,25 @@ writing to and rading from the files.
 For more details about the intervals and monitoring regions range, please refer
 to the Design document (:doc:`/mm/damon/design`).
 
+.. _damon_usage_sysfs_monitoring_intervals_goal:
+
+contexts/<N>/monitoring_attrs/intervals/intervals_goal/
+-------------------------------------------------------
+
+Under the ``intervals`` directory, one directory for automated tuning of
+``sample_us`` and ``aggr_us``, namely ``intervals_goal`` directory also exists.
+Under the directory, four files for the auto-tuning control, namely
+``access_bp``, ``aggrs``, ``min_sample_us`` and ``max_sample_us`` exist.
+Please refer to  the :ref:`design document of the feature
+<damon_design_monitoring_intervals_autotuning>` for the internal of the tuning
+mechanism.  Reading and writing the four files under ``intervals_goal``
+directory shows and updates the tuning parameters that described in the
+:ref:design doc <damon_design_monitoring_intervals_autotuning>` with the same
+names.  The tuning starts with the user-set ``sample_us`` and ``aggr_us``.  The
+tuning-applied current values of the two intervals can be read from the
+``sample_us`` and ``aggr_us`` files after writing ``update_tuned_intervals`` to
+the ``state`` file.
+
 .. _sysfs_targets:
 
 contexts/<N>/targets/
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index cb388d791ff7..26c9ab10daf7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -366,6 +366,10 @@ is recommended.  Note that Parreto principle (80/20 rule) has applied twice.
 That is, assumes 4% (20% of 20%) DAMON-observed access events ratio (source)
 to capture 64% (80% multipled by 80%) real access events (outcomes).
 
+To know how user-space can use this feature via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`intervals_goal <sysfs_scheme>` part of
+the documentation.
+
 
 .. _damon_design_damos:
 
-- 
2.39.5
