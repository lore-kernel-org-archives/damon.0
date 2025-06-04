Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667F20D4FF;
	Wed,  4 Jun 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061896; cv=none; b=ETRteuEw6vm0wHQMyY+nnOrWcXHi2MGf9vJlr8KvdUHgx9TOkGxVp98zuyr8X2B+1ngyfKkQGvYpYUHop/+Sjx4Nxa1rrlpgcgirOVJ7xF4u64Mo3BbeMmUCwHolEy9MiAsPZh4vnWpgI8QD4OevYHAmr14dVQnQd75N9fimV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061896; c=relaxed/simple;
	bh=gYQU/YXDeNgT1BMcNObhy08nWBlr86fWpjeWwTbkqzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cALEFrwds1d8PcciztBmcbUwd3aRlys0Wy5z0Bzsl5GPztyGfS28lW0yvBntPZ/Vh6AZlCgwElGUcTxflfwarTwaYpFPs5XZsvgavnmloc1RDGtdBROnq2KOEq/kIyyCQcFzgHNMeTUpoqoBE/OLS+2JQRGNIWQlorKd5cmslZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWwqW/Ib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWwqW/Ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19FFC4CEF1;
	Wed,  4 Jun 2025 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749061896;
	bh=gYQU/YXDeNgT1BMcNObhy08nWBlr86fWpjeWwTbkqzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWwqW/IbIQSxR7WAexf6dNLzEPriLBPWkOrtKaDXrSodU/jR6bqYHU8zlYqx4RdVY
	 dlRMCGJnEOhReOrQ7fqcOIuPn0BznEU1upLOicsUjU4B/bQU8UaKuRRdgjq4rFimqx
	 NAEHPX8pAFkBm/spKRN4zNHuftXB3JRW8jKBdLKGHpoWfiIQX+ZhC1t8itmmpiYnU8
	 lYc12eVK5Qy7f6pdagHUg/Xot4AROneCKD6oDTm06er/UonsxejPtaBPAPdHCGPSEG
	 dw3PFAyapZv1gCPaXkGskrYeyWM/dYbG/fF/0ObhuNde3Fj9Q13VUmBLoUilTYl4qV
	 GWHjYUg6e5zKw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 4/4] Docs/admin-guide/mm/damon: add DAMON_STAT usage document
Date: Wed,  4 Jun 2025 11:31:27 -0700
Message-Id: <20250604183127.13968-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604183127.13968-1-sj@kernel.org>
References: <20250604183127.13968-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document DAMON_STAT usage and add a link to it on DAMON admin-guide
page.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/index.rst |  1 +
 Documentation/admin-guide/mm/damon/stat.rst  | 69 ++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/stat.rst

diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index bc7e976120e0..3ce3164480c7 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -14,3 +14,4 @@ access monitoring and access-aware system operations.
    usage
    reclaim
    lru_sort
+   stat
diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
new file mode 100644
index 000000000000..4c517c2c219a
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+Data Access Monitoring Results Stat
+===================================
+
+Data Access Monitoring Results Stat (DAMON_STAT) is a static kernel module that
+is aimed to be used for simple access pattern monitoring.  It monitors accesses
+on the system's entire physical memory using DAMON, and provides simplified
+access monitoring results statistics, namely idle time percentiles and
+estimated memory bandwidth.
+
+Monitoring Accuracy and Overhead
+================================
+
+DAMON_STAT uses monitoring intervals :ref:`auto-tuning
+<damon_design_monitoring_intervals_autotuning>` to make its accuracy high and
+overhead minimum.  It auto-tunes the intervals aiming 4 % of observable access
+events to be captured in each snapshot, while limiting the resulting sampling
+events to be 5 milliseconds in minimum and 10 seconds in maximum.  On a few
+production server systems, it resulted in consuming only 0.x % single CPU time,
+while capturing reasonable quality of access patterns.
+
+Interface: Module Parameters
+============================
+
+To use this feature, you should first ensure your system is running on a kernel
+that is built with ``CONFIG_DAMON_STAT=y``.  The feature can be enabled by
+default at build time, by setting ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` true.
+
+To let sysadmins enable or disable it at boot and/or runtime, and read the
+monitoring results, DAMON_STAT provides module parameters.  Following
+sections are descriptions of the parameters.
+
+enabled
+-------
+
+Enable or disable DAMON_STAT.
+
+You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
+Setting it as ``N`` disables DAMON_STAT.  The default value is set by
+``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` build config option.
+
+estimated_memory_bandwidth
+--------------------------
+
+Estimated memory bandwidth consumption (bytes per second) of the system.
+
+DAMON_STAT reads observed access events on the current DAMON results snapshot
+and converts it to memory bandwidth consumption estimation in bytes per second.
+The resulting metric is exposed to user via this read-only parameter.  Because
+DAMON uses sampling, this is only an estimation of the access intensity rather
+than accurate memory bandwidth.
+
+memory_idle_ms_percentiles
+--------------------------
+
+Per-byte idle time (milliseconds) percentiles of the system.
+
+DAMON_STAT calculates how long each byte of the memory was not accessed until
+now (idle time), based on the current DAMON results snapshot.  If DAMON found a
+region of access frequency (nr_accesses) larger than zero, every byte of the
+region gets zero idle time.  If a region has zero access frequency
+(nr_accesses), how long the region was keeping the zero access frequency (age)
+becomes the idle time of every byte of the region.  Then, DAMON_STAT exposes
+the percentiles of the idle time values via this read-only parameter.  Reading
+the parameter returns 101 idle time values in milliseconds, separated by comma.
+Each value represents 0-th, 1st, 2nd, 3rd, ..., 99th and 100th percentile idle
+times.
-- 
2.39.5
