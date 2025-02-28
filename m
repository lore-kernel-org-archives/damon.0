Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1761DE3A3;
	Fri, 28 Feb 2025 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780223; cv=none; b=SfmyC/bSIZvyGF7v1UoA7i40ymZ0NY92GesBp2KlUBoSnHv+1P/nJJN7pHD5TMrf6Dub1h1ja91VBHfaTQdIL454KzDzrcroyf7OtpqAmrnEUZKUYQuJnmVTzH2QaUO42aTAhMxwMLY9SCY+5htgJeh65OQjVjgDplr8w0fLzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780223; c=relaxed/simple;
	bh=/MYVJ3rlbtoAJvOWV+07+WHhI+Q9ZMyJiRshemc3Pdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag8JLQ0wQEu2GNZnEWhGP0gr7jbSz6fXJCbyjKfLA1cqYTLyXriRaC98tvEtqP30ag+pYYQ+fe8fsm2XukOLNqNOQvYfxSwoGjbsKzA9GcnVUZvU10gbPOXE51y/eoRBv7eptL4p+euXPOHLkwoDy8xp3tHV/NL9eCLFtcYu2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq2iiPk2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq2iiPk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8453CC4CED6;
	Fri, 28 Feb 2025 22:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780223;
	bh=/MYVJ3rlbtoAJvOWV+07+WHhI+Q9ZMyJiRshemc3Pdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nq2iiPk2X5wTDN1rEOhOJnEv7NUqTZJOvlOPuG4MMW8vwgYUrCmBJZr0xIR1yo67p
	 d62wq7xVOamZeT/26kiOHlRTUgVUh+AKnoUpbQvikp9/ocZxHLXyjbkLd3hq84CNsr
	 itckDfPhKA/XUHOR/oCEIecXteOvOtfPEAVZ+dJlAW9cT0J9Otlla234ZkzQuJFEyR
	 ICpB0TrNmaOreR88REGBcrAGzRMAo5KqlM4PuuNKBWE2GJES9v5cdNsU8Op9pvsHTT
	 xy80Iro2FNyawVskSDN6LLFepAILtO1ZerHnL5MBoetcI+LH4E19VwtbKEPXLQDT/s
	 FgfKKuVTQLcTQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 8/8] Docs/admin-guide/mm/damon/usage: add intervals_goal directory on the hierarchy
Date: Fri, 28 Feb 2025 14:03:28 -0800
Message-Id: <20250228220328.49438-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: <20250228220328.49438-1-sj@kernel.org>
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
index 4b25c25d4f4f..8f01ad8792e7 100644
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
index 0cc9f6441354..0cf678d98b1b 100644
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
