Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75523C8C5;
	Mon,  3 Mar 2025 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040259; cv=none; b=qh1pMiXpaReONrSPb03eAwq8G6Pg6K+s+an1yVuK1eHvnbmVM4Hgbs/gVztXDgnFNVCY8f8S1rKk/2XR5p0pK81QNumwavTYJV9rI9/dIoNPvkafgBjZZn5uUftQWOffcbLZXmtjAO2acgochVzTfDi3+x9bFOqqdWfsU83qU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040259; c=relaxed/simple;
	bh=LMPGQQlkmlc7oVmDROz8XiqF7P/8GVFp76QyeCU2ENk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HauJ3tstWFpdt9VwBuY2c5iwPBdsv9yjNpDu/UHwXhwlLCSig9eYSzqqCWKgk56N7u4sfvQVFLg+ds0SbkFezE4NJMlGSP8iDrCI5h5uumnMX8FmSgefGzrGk0r5sc++OW8tSIW/eI8qM/aPDD0/QP/XexmdBROflXPlwpe06Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew3153Bk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew3153Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9184C4CEE9;
	Mon,  3 Mar 2025 22:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040258;
	bh=LMPGQQlkmlc7oVmDROz8XiqF7P/8GVFp76QyeCU2ENk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ew3153Bkz/qxViCicAwx/SFps15sAAj5PmKnsoDtHn315GlNdykMREPudSZZ6nR31
	 jJN/cH18UFfaV2Va1eipv8RD9qWjVteCcoNWZG5M/1X3WuTiSi6KEr8DBcQd65Qbhf
	 XntXeBf/VKlAeHyWEGdP+DpTwTRoIhxBdGvQ03vo5P9YR9ic/6WcQVU8Da6jhTKEJU
	 kbd1YWhn4+pkfgJdzDeDcbIG5Gbxs1cZ4mvIbgNThflnMbnrpEFXLoFk4PrlPXhV2A
	 dAmYkbVWCrA2mpP/jVmQ0WLjWfYWbTkJzVZQwAUtlH8OyDHtwxEwhmO0TK8aelxnQL
	 DH1jB4tIGO+nA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] Docs/mm/damon/design: document for intervals auto-tuning
Date: Mon,  3 Mar 2025 14:17:24 -0800
Message-Id: <20250303221726.484227-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the design of DAMON sampling and aggregation intervals
auto-tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5af991551a86..cb388d791ff7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -313,6 +313,10 @@ sufficient for the given purpose, it shouldn't be unnecessarily further
 lowered.  It is recommended to be set proportional to ``aggregation interval``.
 By default, the ratio is set as ``1/20``, and it is still recommended.
 
+Based on the manual tuning guide, DAMON provides more intuitive knob-based
+intervals auto tuning mechanism.  Please refer to :ref:`the design document of
+the feature <damon_design_monitoring_intervals_autotuning>` for detail.
+
 Refer to below documents for an example tuning based on the above guide.
 
 .. toctree::
@@ -321,6 +325,48 @@ Refer to below documents for an example tuning based on the above guide.
    monitoring_intervals_tuning_example
 
 
+.. _damon_design_monitoring_intervals_autotuning:
+
+Monitoring Intervals Auto-tuning
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+DAMON provides automatic tuning of the ``sampling interval`` and ``aggregation
+interval`` based on the :ref:`the tuning guide idea
+<damon_design_monitoring_params_tuning_guide>`.  The tuning mechanism allows
+users to set the aimed amount of access events to observe via DAMON within
+given time interval.  The target can be specified by the user as a ratio of
+DAMON-observed access events to the theoretical maximum amount of the events
+(``access_bp``) that measured within a given number of aggregations
+(``aggrs``).
+
+The DAMON-observed access events are calculated in byte granularity based on
+DAMON :ref:`region assumption <damon_design_region_based_sample>`.  For
+example, if a region of size ``X`` bytes of ``Y`` ``nr_accesses`` is found, it
+means ``X * Y`` access events are observed by DAMON.  Theoretical maximum
+access events for the region is calculated in same way, but replacing ``Y``
+with theoretical maximum ``nr_accesses``, which can be calculated as
+``aggregation interval / sampling interval``.
+
+The mechanism calculates the ratio of access events for ``aggrs`` aggregations,
+and increases or decrease the ``sampleing interval`` and ``aggregation
+interval`` in same ratio, if the observed access ratio is lower or higher than
+the target, respectively.  The ratio of the intervals change is decided in
+proportion to the distance between current samples ratio and the target ratio.
+
+The user can further set the minimum and maximum ``sampling interval`` that can
+be set by the tuning mechanism using two parameters (``min_sample_us`` and
+``max_sample_us``).  Because the tuning mechanism changes ``sampling interval``
+and ``aggregation interval`` in same ratio always, the minimum and maximum
+``aggregation interval`` after each of the tuning changes can automatically set
+together.
+
+The tuning is turned off by default, and need to be set explicitly by the user.
+As a rule of thumbs and the Parreto principle, 4% access samples ratio target
+is recommended.  Note that Parreto principle (80/20 rule) has applied twice.
+That is, assumes 4% (20% of 20%) DAMON-observed access events ratio (source)
+to capture 64% (80% multipled by 80%) real access events (outcomes).
+
+
 .. _damon_design_damos:
 
 Operation Schemes
-- 
2.39.5
