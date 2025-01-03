Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C98187555;
	Fri,  3 Jan 2025 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926251; cv=none; b=c21XOwlnmLBmZpRnFhM2cGTc7XFSkhmROfGnX/Uiukp59lkc2pq/88YDiAeRzId3Y8lW2EKUjfTH/XGH6KRyMXEKRU/GTnyVWmL3JTYtMF5ANziYFwDH6KMMXtTZk0P1Yb1pUJUylR+HYfAL7OMwDBrSLp7XZhV62RSTWkaGSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926251; c=relaxed/simple;
	bh=QxhUTm1Fxoz+hhWeeJHKvT4HGRsA+AbYAkmp06R9U/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q80ZKFpu9pDtMATkch2QFD7cIVPEJtydR2zV43QRonWQd4xgm8POtR6oNPMkHCdQy7dz/CBPEivLywQi9W523b7fE+8EO6LXSduAjQ/ym0buPZXyt/D5Uyz0fZxHG/fz7o5tBkdLdux6Rxw5Oh4+puWWMrq7sKhdGm7QunjP/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eksEPLCh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eksEPLCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0A0C4CECE;
	Fri,  3 Jan 2025 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926251;
	bh=QxhUTm1Fxoz+hhWeeJHKvT4HGRsA+AbYAkmp06R9U/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=eksEPLChZccj7AXoq1tGoFe5i1rGV/j1GqLbUDg/wtPxeuRwMzGe/DSXDOxbvvdKH
	 owXHT6spd/56ufUzai/NQCL57/yD72nGmY7jatSkDXTCzquaYyKhU92uPmTfoV6Cb3
	 alqR0eAH3D2bxKGrHf0axVVGsg4achjBMpLl88/kqAzq7aX8pHCppoCxtIkNjp+QIG
	 pMLvWla7BOoIjWpv9GfYNUcVvAHSm5M7jcrRxMgVqQnVto54PtmPTqvYhUKP7VLwaI
	 UcN/zUObladvocJvpgFss46p0oncSIkmOZRtV8gCc434GHVrixNobuvYbiRR2Rmd8d
	 WS7tgc1RS7X/Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/10] mm/damon: replace most damon_callback usages in sysfs with new core functions
Date: Fri,  3 Jan 2025 09:43:50 -0800
Message-Id: <20250103174400.54890-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON provides damon_callback API that notifies monitoring events and
allows safe access to damon_ctx internal data.  The usage is simple.
Users register and deregister callback functions for different
monitoring events in damon_ctx.  Then the DAMON worker thread (kdamond)
of the damon_ctx calls back the registered functions on the events.

It is designed in such simple way because it was sufficient for usages
of DAMON at the early days.  We also wanted to make it flexible so that
API user code can implement any required additional features on top of
damon_callback on their demands.

As expected, more sophisticated usages have invented.  Online updates of
DAMON parameters and DAMOS auto-tuning inputs, and online retrieval of
DAMOS statistics and tried regions information are such usages.  Because
damon_callback doesn't provide any explicit synchronization mechanism,
the user ABIs for exposing such functionalities are implemented in
asynchronous ways (DAMON_RECLAIM and DAMON_LRU_SORT}), or synchronous
ways (DAMON_SYSFS) with additional synchronization mechanisms that built
inside the ABI implementation, on top of damon_callback.

So damon_callback is working as expected.  However, the additional
mechanisms built inside ABI on top of damon_callback is becoming
somewhat too big and not easy to maintain.  The additional mechanisms
can be smaller and easier to maintain when implemented inside the core
logic layer.

Introduce two new DAMON core API, namely 'damon_call()' and
'damos_walk()'.  The two functions support synchronous access to
- damon_ctx internal data including DAMON parameters and monitoring
  results, and
- DAMOS-specific data such as regions that each DAMOS action is applied,
respectively.

And replace most of damon_callback usages in DAMON sysfs interface with
the new core API functions.  damon_callback usage for online DAMON
parameters tuning is not replaced in this series, since it has specific
callback timing assumptions that require more works.

Patch sequence
==============

First two patches are fixups for simplifying the following changes.
Those remove a unnecessary condition check and a synchronization,
respectively.

Third patch implements one of the new DAMON core APIs, namely
damon_call().  Three patches replacing damon_callback usages in DAMON
sysfs interface using damon_call() follow.

Then, seventh and eighth patches introduces the other new DAMON API,
damos_walk(), and document it on the design doc.  Ninth patch replaces
two damon_callback usages in DAMON sysfs interface using damos_walk().

The tenth patch finally cleans up code that no more being used.

Revision History
================

Changes from RFC
(https://lore.kernel.org/20241213215306.54778-1-sj@kernel.org)
- Call damos_call_cotnrol->walk_fn() after applying action
- Document DAMOS regions walk feature on design doc
- Wordsmith and fix typos in commit messages

SeongJae Park (10):
  mm/damon/sysfs-schemes: remove unnecessary schemes existence check in
    damon_sysfs_schemes_clear_regions()
  mm/damon/sysfs: handle clear_schemes_tried_regions from DAMON sysfs
    context
  mm/damon/core: introduce damon_call()
  mm/damon/sysfs: use damon_call() for update_schemes_stats
  mm/damon/sysfs: use damon_call() for commit_schemes_quota_goals
  mm/damon/sysfs: use damon_call() for update_schemes_effective_quotas
  mm/damon/core: implement damos_walk()
  Docs/mm/damon/design: document DAMOS regions walking
  mm/damon/sysfs: use damos_walk() for
    update_schemes_tried_{bytes,regions}
  mm/damon/sysfs: remove unused code for schemes tried regions update

 Documentation/mm/damon/design.rst |  11 ++
 include/linux/damon.h             |  59 +++++++-
 mm/damon/core.c                   | 218 ++++++++++++++++++++++++++++++
 mm/damon/sysfs-common.h           |  16 +--
 mm/damon/sysfs-schemes.c          | 206 +++-------------------------
 mm/damon/sysfs.c                  | 187 +++++++++++--------------
 6 files changed, 395 insertions(+), 302 deletions(-)

-- 
2.39.5
