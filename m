Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BB1E32C3;
	Mon, 19 May 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673060; cv=none; b=tEQQqFjO417ZrxcIsV1/neHeMkGLCdPIcnSyupv4rgo94/BWph8anhamgBu9O8ZLrQA/M8l4c+L7wm2A/8HipAusAPCboKZXQGWqfmz8B7/xcnrDLW3/o3PKOHaQLDVZFMPGcxG4fpvD9sEmAmuXAPs9Yd/MPqoI4PKcT5IBQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673060; c=relaxed/simple;
	bh=tNwc3KlCa+UsKLQNf/TF+YhpZdTxy9+n5nN6fjl4mIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNqK4HvaCh0yqoHyFuHbC9ZO/q6pPVp0xgzlW/3iylN2etzj7AF9kbLUgBpX4U/mnVk7ZW0l5rkYhwA7m7nCxTMz5ikwiOca4qII/xc4Prq7wE3eT+w+1gR+1/wzSQClj1c+V5gRgWMu2BuayttpprfZgsY04q/9qMNXgcEJLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu/PZ/R7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu/PZ/R7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA7AC4CEE4;
	Mon, 19 May 2025 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747673059;
	bh=tNwc3KlCa+UsKLQNf/TF+YhpZdTxy9+n5nN6fjl4mIs=;
	h=From:To:Cc:Subject:Date:From;
	b=tu/PZ/R7xjoRbosdEr05GmX51LuS5dRnQIBbAZGIX21QL8XPHXCUIAr7RPvHIIehu
	 QWkAwHxCRdTCYNrmZtFte8S1zhfJTt4BDmMliyhWX7wQ/RGIao89Mbobx1dmk6wPV8
	 Jcjj/l50sygfZyS40m3V3NGtRbOi1A9VnyhBGYRGeDkBzgvoOkot4I4rkpAf/4t4YH
	 4JKw9SJ6s5ZX2ZWL3HRJDu5b6qJbWou7YEepiIsJPTLz6EKZODlafgIHjNAAtJuRSx
	 OQ7zWgrD8xofPA6uiFF3YAr1D9fAHjVntHhcXO8pLucpMpikG8XeJX3ivAs5fCjNwv
	 yeLIY1AuwFOgA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/3] mm/damon: introduce DAMON_STAT for access monitoring that just works
Date: Mon, 19 May 2025 09:44:12 -0700
Message-Id: <20250519164415.43935-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON-based access monitoring requires manual DAMON control and results
parsing.  Introduce a static kernel module for making it simple and
intuitive.  The module can be enabled without manual setup and provides
simple but practical access pattern metrics, namely memory idle time
percentiles and estimatd memory bandwidth.

Background and Problems
=======================

DAMON can be used for monitoring data access pattern of the system and
workloads.  For that, users can start DAMON to monitor access events on
specific address space with fine controls including address ranges to do
monitor and time intervals between samplings and aggregations.  The
resulting access information snapshot contains access frequency
(nr_accesses) and how long the frequency was maintained (age) for each
byte.

The monitoring usage is not simple and practical enough for production
usage.  Users should first start DAMON with a number of parameters, and
wait until DAMON's monitoring results capture reasonable amount of the
time data (age).  In production, such manual start and wait is
impractical to capture useful information from a high number of machines
in a timely manner.

The monitoring result is also too detailed to be used on production
environments.  The raw results are hard to be aggregated and/or compared
for production environments having large scale of time, space and
machines fleet.

Users have to implement and use their own automation of DAMON control
and results processing.  It is repetitive and challenging since there is
no good reference or guideline for such automation.

Solution: DAMON_STAT
====================

Implement a such automation in kernel space as a static kernel module,
namely DAMON_STAT.  It can be enabled at build, boot, or run time via
its build configuration or module parameter.  It monitors entire
physical address space with monitoring intervals that auto-tuned for
reasonable amount of access observations and minimum overhead.  It
converts the raw monitoring results into simpler metrics that can easily
aggregated and compared, namely idle time percentiles and memory
bandwidth.

Discussions
===========

The module aims to be useful on production environments constructed with
large number of machines that runs ling time.  The auto-tuned monitoring
intervals ensures a reasonable quality of the outputs.  The auto-tuning
also ensures its overhead be reasonable and low enough to be enabled
always on the production.  The simplified monitoring results metrics can
be useful for showing both coldness (idle time percentiles) and hotness
(memory bandwidth) of the system's access pattern.  We expect the
information can be useful for assessing system memory utilization and
inspiring optimizations or investigations on both kernel and user space
memory management logics for large scale fleets.

We hence expect the module is good enough to be just used in most
environments.  For special cases that require a custom access monitoring
automation, users will still get benefit by using DAMON_STAT as a
reference or a guideline for their automation.

SeongJae Park (3):
  mm/damon: introduce DAMON_STAT module
  mm/damon/stat: calculate and expose estimated memory bandwidth
  mm/damon/stat: calculate and expose idle time percentiles

 mm/damon/Kconfig  |  16 +++
 mm/damon/Makefile |   1 +
 mm/damon/stat.c   | 245 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 mm/damon/stat.c


base-commit: 251509f2949105d3d0e3cdcd3921670a6aee3a0e
-- 
2.39.5
