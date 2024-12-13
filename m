Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468D19048F;
	Fri, 13 Dec 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126795; cv=none; b=QjOUqK360PjuEU3twSvWtBTk9qDL53DAiNEJTMMo1rebb1gY3nsmO3nBTcPPPqSASHhDjEdxWuKdu6bQOg4ibNsE0yc9IcS1Ohsbg8RQmC2qcteiwPckXgb1qFp7LOpRJV56exFXcgc7hR0S5rGtf1LQUqn2znHm15FQvFGrZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126795; c=relaxed/simple;
	bh=mR+4nKd1LKKpydDTMtiPpQrNDhEN5Vr0X8tr0Qj3a5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZueK85W5VgLkjZCgwokzebM5iMvh+OxpATNCZrmit5A71TRpPtjp4TNDrxnZIeu9xNM5eTEPSGWiElrg+dyY7gnUExhk0muXMKnvw1r11NM9rjgFfCSIUqtr5MJwTPCcSqBY1WZpU5ZbrQbnNBZx6Is6EkLX2hSwA3+/yh6SiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khIZbyOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khIZbyOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AF8C4CED0;
	Fri, 13 Dec 2024 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126795;
	bh=mR+4nKd1LKKpydDTMtiPpQrNDhEN5Vr0X8tr0Qj3a5k=;
	h=From:To:Cc:Subject:Date:From;
	b=khIZbyOH3Bc0k+VFFhYWdlNqueBcGJ50g4spcTMPdihaklXLSZbZ9CMNwvJp3HFm7
	 2Rcs2JTl/YucvGvK9p2ZSNKffp8w888i07XlgN39L+cdHKoDOnhoE3YTISsBy0R4J2
	 2eNkj7kl/xH6+EeUiZPxbnnR7mKlj7uedWcg22Rn2bllSThbWBoca1n1A+hYnC/M9F
	 rhRvGJoCUvyZHBI37j9APo3lkK2YkHTpMZ1LaI5XOGE+FgIFPU3RetBlq35jnPhKmL
	 mzK1RFpPC+zsFdFd9ILY9fH5AljxTVYE7tRsfBtSDqe7ZgQwR1VLlklKKMQPTYOL2v
	 wXsyGC3lic8Ag==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/9] mm/damon: replace most damon_callback usages in sysfs with new core functions
Date: Fri, 13 Dec 2024 13:52:57 -0800
Message-Id: <20241213215306.54778-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON provides damon_callback API that notifies monitoring events and
allows safe access to damon_ctx internal data.  Users can set and unset
callback functions for different monitoring events in damon_ctx.  Then
DAMON worker thread (kdamond) calls back the functions on the events as
long as the function is set on the damon_ctx.

It is designed in such simple way because it was sufficient for usages
of DAMON at the early days.  We also wanted to make it flexible so that
API client code can implement any required additional features on top of
damon_callback on their demands.

As expected, more sophisticated usages have invented.  Online updates
of parameters or DAMOS auto-tuning inputs and retrieval of DAMOS
statistics and tried regions are notable such usages.  Because
damon_callback doesn't provide any explict synchronization mechanism,
the user ABIs for exposing such functionalities are implemented in
asynchronous ways (DAMON_RECLAIM and DAMON_LRU_SORT}), or synchronous
ways (DAMON_SYSFS) with additional synchronization mechanisms that built
inside the ABI implementation, on top of damon_callback.

So damon_callback is working as expected.  However, the additional
mechanisms built inside ABI on top of damon_callback beocming somewhat
too big and not easy to maintain.  damon_callback is basically simple
enougy to use in not only correct but also wrong ways.  The additional
mechanisms can be easier to maintain when implemented inside core logic.

Introduce two new DAMON core API, namely 'damon_call()' and
'damos_walk()'.  The two functions support synchronous access to
- damon_ctx internal data including DAMON parameters and monitoring
  results, and
- DAMOS-specific data such as regions that each DAMOS action is applied,
respectively.

And replace most of damon_callback usages from DAMON sysfs with the new
core API functions.  Online DAMON parameters tuning feature is not
replaced in this series, since it has specific callback timing
assumptions that require more works.

Patch sequence
==============

First two patches removes unnecessary synchronization dependency of
clear_schemes_tried_regions command handling.

Third patch implements one of the new DAMON API, damon_call().  Three
patches replacing damon_callback usages in DAMON sysfs interface using
damon_call() follow.

Then, seventh patch introduces the other new DAMON API, damos_walk().
Eighth patch replaces two damon_callback usages in DAMON sysfs interface
using damos_walk().  The ninth patch finally cleans up code that no more
being used.

SeongJae Park (9):
  mm/damon/sysfs-schemes: remove unnecessary schemes existence check in
    damon_sysfs_schemes_clear_regions()
  mm/damon/sysfs: handle clear_schemes_tried_regions from DAMON sysfs
    context
  mm/damon/core: implement damon_call()
  mm/damon/sysfs: use damon_call() for update_schemes_stats
  mm/damon/sysfs: use damon_call() for commit_schemes_quota_goals
  mm/damon/sysfs: use damon_call() for update_schemes_effective_quotas
  mm/damon/core: implement damos_walk()
  mm/damon/sysfs: use damos_walk() for
    update_schemes_tried_{bytes,regions}
  mm/damon/sysfs: remove unused code for schemes tried regions update

 include/linux/damon.h    |  59 ++++++++++-
 mm/damon/core.c          | 220 +++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-common.h  |  16 +--
 mm/damon/sysfs-schemes.c | 206 ++++--------------------------------
 mm/damon/sysfs.c         | 187 +++++++++++++++------------------
 5 files changed, 386 insertions(+), 302 deletions(-)


base-commit: e5c48d400cab89a0539ce822ba805f0ad4209e87
-- 
2.39.5

