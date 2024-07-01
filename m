Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4C171E6A;
	Mon,  1 Jul 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862036; cv=none; b=SJ8zzOvOg5CdZnLp1/4xa3zT3ynkZh4eUyMN1u2QT2CfH03MVHHryyuGweacQZkV19gm2ZHoCLHhSjwCl1T8CC7BWW4Hq388YhWSueTAREl24gogYUcBruoU1FVKjQzVgML+E8DGdDc3giPuiFMCjXDe9pw549hbJPAS9B3bYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862036; c=relaxed/simple;
	bh=ZnT7QNZiiuEpgT4tYIiBE2EHtfYlH/fKceMtToSKPPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLvaJEw7e5qP7CfHLyXg9Sn46zv7cphxkD7VH/l84LpGzH2npCXCScao/BfP+dl5QlJiJZQ5xUuQdt1RsqlmixBsBs7rLXgRGgAWpwsd91l+Sly8BokSv2SZGGKr1TdeSeHfWz7pYeJGE81zPn03yjfZhPmpWNs3TR4s9aeUHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSsroV1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSsroV1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A9C32781;
	Mon,  1 Jul 2024 19:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862036;
	bh=ZnT7QNZiiuEpgT4tYIiBE2EHtfYlH/fKceMtToSKPPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSsroV1UZFnezFKy/slb8Tj9vjjvce9bJP1JFpky/QnyvTug16ElPmCjL3vuaEElJ
	 KBiRty1iMUl4AxQEwHmBZvyUoIv63L6CIVHl7ROUWYQeriAs71CzH08x+HURlSu2iD
	 CtY7nQ6GBZGqEfD4ACjHSbSCvTkmdDdMYCObfGAn3y9qF35ky7tK3Wl8KmrEu5ThBF
	 pr+3V3cFw8Nh3WcaWsD+bVvVK5rtsjxqZnWLQrr2LSRfARIc1dCZN9WeM5ufvS9VWa
	 5A7IFxxUNyTKPZkgFxBBk7V4tsanJHQwfcegLxhG0KN3GSNvUrDl3xjmwZtc99Tbg8
	 4MzdcmVCUVEbQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] Docs/mm/damon/design: add links to sections of DAMON sysfs interface usage doc
Date: Mon,  1 Jul 2024 12:27:04 -0700
Message-Id: <20240701192706.51415-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Readers of the design document would wonder how they can configure and
use specific DAMON features.  Add links to sections of DAMON sysfs
interface usage document that provides the answers for easier browsing.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 39e686c6862d..89f5330e003f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -16,6 +16,9 @@ called DAMON ``context``.  DAMON executes each context with a kernel thread
 called ``kdamond``.  Multiple kdamonds could run in parallel, for different
 types of monitoring.
 
+To know how user-space can do the configurations and start/stop DAMON, refer to
+:ref:`DAMON sysfs interface <sysfs_interface>` documentation.
+
 
 Overall Architecture
 ====================
@@ -71,6 +74,10 @@ describe how those work.
  - fvaddr: Monitor fixed virtual address ranges
  - paddr: Monitor the physical address space of the system
 
+To know how user-space can do the configuration via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`operations <sysfs_context>` file part of the
+documentation.
+
 
  .. _damon_design_vaddr_target_regions_construction:
 
@@ -143,6 +150,10 @@ monitoring attributes, ``sampling interval``, ``aggregation interval``,
 ``update interval``, ``minimum number of regions``, and ``maximum number of
 regions``.
 
+To know how user-space can set the attributes via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`monitoring_attrs <sysfs_monitoring_attrs>`
+part of the documentation.
+
 
 Access Frequency Monitoring
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -246,6 +257,11 @@ and applies it to monitoring operations-related data structures such as the
 abstracted monitoring target memory area only for each of a user-specified time
 interval (``update interval``).
 
+User-space can get the monitoring results via DAMON sysfs interface and/or
+tracepoints.  For more details, please refer to the documentations for
+:ref:`DAMOS tried regions <sysfs_schemes_tried_regions>` and :ref:`tracepoint`,
+respectively.
+
 
 .. _damon_design_damos:
 
@@ -286,6 +302,10 @@ the access pattern of interest, and applies the user-desired operation actions
 to the regions, for every user-specified time interval called
 ``apply_interval``.
 
+To know how user-space can set ``apply_interval`` via :ref:`DAMON sysfs
+interface <sysfs_interface>`, refer to :ref:`apply_interval_us <sysfs_scheme>`
+part of the documentation.
+
 
 .. _damon_design_damos_action:
 
@@ -334,6 +354,10 @@ Applying the actions except ``stat`` to a region is considered as changing the
 region's characteristics.  Hence, DAMOS resets the age of regions when any such
 actions are applied to those.
 
+To know how user-space can set the action via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`action <sysfs_scheme>` part of the
+documentation.
+
 
 .. _damon_design_damos_access_pattern:
 
@@ -347,6 +371,10 @@ interest by setting minimum and maximum values of the three properties.  If a
 region's three properties are in the ranges, DAMOS classifies it as one of the
 regions that the scheme is having an interest in.
 
+To know how user-space can set the access pattern via :ref:`DAMON sysfs
+interface <sysfs_interface>`, refer to :ref:`access_pattern
+<sysfs_access_pattern>` part of the documentation.
+
 
 .. _damon_design_damos_quotas:
 
@@ -366,6 +394,10 @@ feature called quotas.  It lets users specify an upper limit of time that DAMOS
 can use for applying the action, and/or a maximum bytes of memory regions that
 the action can be applied within a user-specified time duration.
 
+To know how user-space can set the basic quotas via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`quotas <sysfs_quotas>` part of the
+documentation.
+
 
 .. _damon_design_damos_quotas_prioritization:
 
@@ -393,6 +425,10 @@ information to the underlying mechanism.  Nevertheless, how and even whether
 the weight will be respected are up to the underlying prioritization mechanism
 implementation.
 
+To know how user-space can set the prioritization weights via :ref:`DAMON sysfs
+interface <sysfs_interface>`, refer to :ref:`weights <sysfs_quotas>` part of
+the documentation.
+
 
 .. _damon_design_damos_quotas_auto_tuning:
 
@@ -422,6 +458,10 @@ Currently, two ``target_metric`` are provided.
   DAMOS does the measurement on its own, so only ``target_value`` need to be
   set by users at the initial time.  In other words, DAMOS does self-feedback.
 
+To know how user-space can set the tuning goal metric, the target value, and/or
+the current value via :ref:`DAMON sysfs interface <sysfs_interface>`, refer to
+:ref:`quota goals <sysfs_schemes_quota_goals>` part of the documentation.
+
 
 .. _damon_design_damos_watermarks:
 
@@ -444,6 +484,10 @@ is activated.  If all schemes are deactivated by the watermarks, the monitoring
 is also deactivated.  In this case, the DAMON worker thread only periodically
 checks the watermarks and therefore incurs nearly zero overhead.
 
+To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`watermarks <sysfs_watermarks>` part of the
+documentation.
+
 
 .. _damon_design_damos_filters:
 
@@ -490,6 +534,10 @@ Below types of filters are currently supported.
     - Applied to pages that belonging to a given DAMON monitoring target.
     - Handled by the core logic.
 
+To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
+<sysfs_interface>`, refer to :ref:`filters <sysfs_filters>` part of the
+documentation.
+
 
 Application Programming Interface
 ---------------------------------
-- 
2.39.2

