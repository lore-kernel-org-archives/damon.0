Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B331D5ADC;
	Sun, 20 Apr 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178041; cv=none; b=aBrwRVcIsHY95uxPZ9UR39mH9Vnj4Rta/IKcU/VYg5ShurcgNI19Ojn0QsTO7EGht0dTzt6NTVughc8nM9B1F2rrP8j57TvMCQLpNMQuWxeEWeT4WSX7POpztwxhXkxbElFL/3G88LKZqogBhs7f/kdq5uHlWJP2L2B3seuULFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178041; c=relaxed/simple;
	bh=O2QyPpvrJel3yg5xTV6SbG3aWvJ/8ntEB2kQvqlcRMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+tpN41jdswfKxAJYcYM9y9lC4VlEL4tzQWANEbVWG8dPA4qD2zSAhLd7fudsqzLmlcHzDe6bfcwKeOQjRt1TZ1IT8e9tItdwpPTW5Q8+WaB5CnMbYZNql8Hos01O7vQryV0SIUIMeRQfncUBpkqehNy1NxQedWiezAndIU/pB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+66FnMg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+66FnMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC032C4CEE9;
	Sun, 20 Apr 2025 19:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178041;
	bh=O2QyPpvrJel3yg5xTV6SbG3aWvJ/8ntEB2kQvqlcRMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+66FnMgcD+CJtwBxR5WWy1A5UzEWfX0UVpz9MTQlFUQtBjjb0kE0LMjLqhXjDAwY
	 xCk831yNZdJ44WsB3Tor6plm2LGP2tQc4X4QOX4DLNGsm7zpMOxT7aw7YC41MD8Kk+
	 aoe4pE7NV+bfUUBsNb/mY8jt9KGUR9Am923cYTBe4ksldXmntuCPlNu3xJSOo2teZB
	 FpI0W5IG1dkcILs0AdPkuoYHs4xfecxIekA5k16TbejzF8K2G0puvqrp6+/AEDQ65P
	 OtoEF8hXDk1qbsP0hSf9L2V/AgEPLNRmvbOM0h0qxhjoZY84WfJrhPtA3CDnrR5wAV
	 tcMuU96DYhH2w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] Docs/mm/damon/design: document node_mem_{used,free}_bp
Date: Sun, 20 Apr 2025 12:40:27 -0700
Message-Id: <20250420194030.75838-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: <20250420194030.75838-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description of DAMOS quota goal metrics for NUMA node utilization on
the DAMON deesign document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index f12d33749329..728bf5754343 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -550,10 +550,10 @@ aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
 is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
 is over achieving the goal, it decreases the quota.
 
-The goal can be specified with three parameters, namely ``target_metric``,
-``target_value``, and ``current_value``.  The auto-tuning mechanism tries to
-make ``current_value`` of ``target_metric`` be same to ``target_value``.
-Currently, two ``target_metric`` are provided.
+The goal can be specified with four parameters, namely ``target_metric``,
+``target_value``, ``current_value`` and ``nid``.  The auto-tuning mechanism
+tries to make ``current_value`` of ``target_metric`` be same to
+``target_value``.
 
 - ``user_input``: User-provided value.  Users could use any metric that they
   has interest in for the value.  Use space main workload's latency or
@@ -565,6 +565,11 @@ Currently, two ``target_metric`` are provided.
   in microseconds that measured from last quota reset to next quota reset.
   DAMOS does the measurement on its own, so only ``target_value`` need to be
   set by users at the initial time.  In other words, DAMOS does self-feedback.
+- ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
+- ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
+
+``nid`` is optionally required for only ``node_mem_used_bp`` and
+``node_mem_free_bp`` to point the specific NUMA node.
 
 To know how user-space can set the tuning goal metric, the target value, and/or
 the current value via :ref:`DAMON sysfs interface <sysfs_interface>`, refer to
-- 
2.39.5
