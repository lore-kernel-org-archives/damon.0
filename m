Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8C84D13;
	Mon, 26 May 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293782; cv=none; b=ZQ5X0TsyPtbxWAmO+Bm8G79LYHmMs57imS1NMp0Un9wMbVrzs2sKvCIL+JpY3O1nY4HNj/lH2LSMMitOgeY1aMxPZK4BCkzdjlmyN3JKuFkAltjunbPBM+r23IU3R8blGvMCyKwSa7x2ZDp2ZROO1Iu7eDHMhPzIHCiQJrkdCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293782; c=relaxed/simple;
	bh=Oi6m9zluj9+upljpAJCCZuQWC64rKRxq5v43Dw2FA6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eE2SgbQfG9UuUpnr5PI5ebR9RIEodwe9XfQBiJSTqW+hsUrHmlWmBoSwjwFRtr0mKJScmdy8YgHt/4n/88FSLAQm0qfNWr7AiTylU/fAds7gELWdFu+TNNbWilCPu1SRezm5wdU5h1RqxhNzDeON6pG/1oXRERJRmvBFBZh3Q3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STloriLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STloriLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D41C4CEE7;
	Mon, 26 May 2025 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748293781;
	bh=Oi6m9zluj9+upljpAJCCZuQWC64rKRxq5v43Dw2FA6s=;
	h=From:To:Cc:Subject:Date:From;
	b=STloriLVBeMKppjjdQPNQViDlg9IzHsHKwKh2FvRoKdtK3pMZR64tmTyNr8jTPRra
	 mwCXo2djmbcXwFh3Diw76oAiHdM8luheSHGssJBt4mCXSZuhnVM978uW7xhnHz8tvx
	 k/8+GT71v+R+mvZ80fxhf2sTgDemhQGb9pBOiKNUGaZKkqp0ycQm9dbzsuDruAdqtK
	 Wsm9DyEsoyc9H1trgTSrpi+1mxp8Ntrbk0DtVWQHBQK2PIOBTRwKOqSvXPVyTeAmZw
	 i82rZkmZ51I8D60XTxj45vPJd3t98e+ybS2V42uR4CVw2thERJGSO8sA080/rx/wBe
	 M/rKecMlArLyA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon: introduce DAMON_STAT for simple and practical access monitoring
Date: Mon, 26 May 2025 14:09:32 -0700
Message-Id: <20250526210936.2744-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON-based access monitoring is not simple due to required DAMON
control and results visualizations.  Introduce a static kernel module
for making it simple.  The module can be enabled without manual setup
and provides access pattern metrics that easy to fetch and understand
the practical access pattern information, namely estimated memory
bandwidth and memory idle time percentiles.

Background and Problems
=======================

DAMON can be used for monitoring data access patterns of the system and
workloads.  Specifically, users can start DAMON to monitor access events
on specific address space with fine controls including address ranges to
monitor and time intervals between samplings and aggregations.  The
resulting access information snapshot contains access frequency
(nr_accesses) and how long the frequency was kept (age) for each byte.

The monitoring usage is not simple and practical enough for production
usage.  Users should first start DAMON with a number of parameters, and
wait until DAMON's monitoring results capture a reasonable amount of the
time data (age).  In production, such manual start and wait is
impractical to capture useful information from a high number of machines
in a timely manner.

The monitoring result is also too detailed to be used on production
environments.  The raw results are hard to be aggregated and/or compared
for production environments having a large scale of time, space and
machines fleet.

Users have to implement and use their own automation of DAMON control
and results processing.  It is repetitive and challenging since there is
no good reference or guideline for such automation.

Solution: DAMON_STAT
====================

Implement such automation in kernel space as a static kernel module,
namely DAMON_STAT.  It can be enabled at build, boot, or run time via
its build configuration or module parameter.  It monitors the entire
physical address space with monitoring intervals that auto-tuned for a
reasonable amount of access observations and minimum overhead.  It
converts the raw monitoring results into simpler metrics that can easily
be aggregated and compared, namely estimated memory bandwidth and idle
time percentiles.  Refer to the commit messages of the second and the
third patches of this patch series for more details about the metrics.

Discussions
===========

The module aims to be useful on production environments constructed with
a large number of machines that run a long time.  The auto-tuned
monitoring intervals ensure a reasonable quality of the outputs.  The
auto-tuning also ensures its overhead be reasonable and low enough to be
enabled always on the production.  The simplified monitoring results
metrics can be useful for showing both coldness (idle time percentiles)
and hotness (memory bandwidth) of the system's access pattern.  We
expect the information can be useful for assessing system memory
utilization and inspiring optimizations or investigations on both kernel
and user space memory management logics for large scale fleets.

We hence expect the module is good enough to be just used in most
environments.  For special cases that require a custom access monitoring
automation, users will still benefit by using DAMON_STAT as a reference
or a guideline for their specialized automation.

Revision History
================

Changes from RFC
(https://lore.kernel.org/20250519164415.43935-1-sj@kernel.org)
- Add an admin-guide documentation
- Wordsmith commit messages
- Rebase to latest mm-new

SeongJae Park (4):
  mm/damon: introduce DAMON_STAT module
  mm/damon/stat: calculate and expose estimated memory bandwidth
  mm/damon/stat: calculate and expose idle time percentiles
  Docs/admin-guide/mm/damon: add DAMON_STAT usage document

 Documentation/admin-guide/mm/damon/index.rst |   1 +
 Documentation/admin-guide/mm/damon/stat.rst  |  69 ++++++
 mm/damon/Kconfig                             |  16 ++
 mm/damon/Makefile                            |   1 +
 mm/damon/stat.c                              | 245 +++++++++++++++++++
 5 files changed, 332 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/stat.rst
 create mode 100644 mm/damon/stat.c


base-commit: 90887f57d7a67917136e7c70d26fb3f2fcdc6f53
-- 
2.39.5
