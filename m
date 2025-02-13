Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147D19CCFA;
	Thu, 13 Feb 2025 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411102; cv=none; b=c/ZYHrVQoJVuLOxZHIMQFh6XJN3pVK1n/k9AtNXSW4NIRtq+Ewrqp3GR7ixCfPSl72VR4TWNtvtWg6X5PNeBjOd/rdhOO4pyQsjEIt8boPU6yQcUFwhdCwfmV0oC6dXVK5tB+nZBa6A3Oh9N53y/5MYG/7FSeavCeaHicRAsS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411102; c=relaxed/simple;
	bh=QR2M3ggNynpLgjaV5MuEdSsLXcYuPIdLc3HO6YmtxuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwC1uiMN3eA7gLDHmZC058ugHX84vjL1owgivcjVlD2Co/euJ8wdsvRcv30finVp5q52FKHe2ACfCZ/HJI3xpaIMamSA6ppoMigo4qFijPm5otftFYkaBGd2/cvzziykZimjEUcYz38nTVnRUx/+7Ov8LYJFH2qdlLp0OZwnEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSX6aGIZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSX6aGIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95533C4CEE2;
	Thu, 13 Feb 2025 01:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411101;
	bh=QR2M3ggNynpLgjaV5MuEdSsLXcYuPIdLc3HO6YmtxuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSX6aGIZUvu8Ow3QiHi49WpJMlcbTPa3MmrNc3TMLwyrXGyAMkh+D08gbtBhrm5Ka
	 0FMbInTxW20qQKBtCs0qQ0HwHpXpDwt1M1VVj64fATFn13PR2u5Q3km+3EdSR2Wtgk
	 D54xFRjVT5lBCDv3bu/wLFBl5hxvp48h8TYyVc/e1r7o5/gdGK480VsLuMq0QAdVdu
	 EWYzQ9pl2FxlK3ErLMGQvJRSE24Vgr/oB70eF4/X+PzZtZz3D30HK8DrhmMCLhNbmw
	 SESO8O1kjGGKQCKodHns7yOiLNSzCrnXF2IpRTySqpqw1xzps064C3NUcGzmBGNfnp
	 A1jNF2i79DYXw==
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
Subject: [RFC PATCH 8/8] Docs/admin-guide/mm/damon/usage: add intervals_goal directory on the hierarchy
Date: Wed, 12 Feb 2025 17:44:38 -0800
Message-Id: <20250213014438.145611-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
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
index 51af66c208c5..8970efce32f0 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -64,6 +64,7 @@ comma (",").
     │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations
     │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs>`/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
+    │ │ │ │ │ │ │ intervals_goal/samples_bp,aggrs,min_sample_us,max_sample_us
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
+``samples_bp``, ``aggrs``, ``min_sample_us`` and ``max_sample_us`` exist.
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
index c8e906ac3965..940409abc23f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -354,6 +354,10 @@ The tuning is turned off by default, and need to be set explicitly by the user.
 As a rule of thumbs and the Parreto principle, 20% access samples ratio target
 is recommended.
 
+To know how user-space can use this feature via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`intervals_goal <sysfs_scheme>` part of
+the documentation.
+
 
 .. _damon_design_damos:
 
-- 
2.39.5
