Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAD29B764;
	Sun, 19 Apr 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615012; cv=none; b=UDkXL1TAtslXRx5PtQVwgvz36xGT1SLjsAmC19VdZbkTihx2E9tM8aZhoxIssW8Qrk3Dva5cKQ3wZ3UY/Xyk8U7KIlTxo4thgXz5C118N+lnBBkLZ74gjLKi+IqPpPeATDJVqFhECLrApzGtqyKkWcijf8zRdiZs8Sp9aYvehdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615012; c=relaxed/simple;
	bh=ICP4ejP14X/+oD3w9wU26G/JpfDfG6uEmFxcpnMElSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgaYD68WFJW0unbakH5sDHZH2yJU8y2jAum34i7khoD30ejaQJNLGsqsfbP7wA9uXm2Q045uAhxHcWW93TXz83T+m2lMxoqqGZ6aRw9ScmU1NaP1+mxFE+hFKVsQ1WR4xfvKGJO6OcMIY/O6DEuJYYJuklO4v7tvNkTfbpX0Vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcSfOb3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcSfOb3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45554C2BCAF;
	Sun, 19 Apr 2026 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776615011;
	bh=ICP4ejP14X/+oD3w9wU26G/JpfDfG6uEmFxcpnMElSw=;
	h=From:To:Cc:Subject:Date:From;
	b=RcSfOb3cljkpqeIwkHFSmEkODaVwl7Ey6An63tiBa4ncCL5Kcv0z2WQZzreEzxaW/
	 NBn3ybcy6q5HtCdC77f6fg9Y9RxvotACAgS1GnsekMOW4eM4JpsN3H8iS9LyHbTBcW
	 w2kqqrOfVQhwJkf5TMB6QWv/gVVMT1H20+cSyZPw1Gys1dBAkqaKtVV5vtvN0uTKao
	 Mf6NB371qUvXYB3nKfgyex7tJHZgQdS2UimQAFkIZfwOZ9E0fxEaXotPq0GmuHXZF3
	 dwbU+vpb/0PYKfHYtnwd3PkmteR4W5YfPX8DsH4xcvkwlGyo2bESJFzEugk3OO+XRs
	 034ZmFWcoQHNw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] mm/damon/modules: detect and use fresh status
Date: Sun, 19 Apr 2026 09:09:59 -0700
Message-ID: <20260419161003.79176-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON modules including DAMON_RECLAIM, DAMON_LRU_SORT and DAMON_STAT
commonly expose the kdamond running status via their parameters.  Under
certain scenarios including wrong user inputs and memory allocation
failures, those parameter values can be stale.  It can confuse users.
For DAMON_RECLAIM and DAMON_LRU_SORT, it even makes the kdamond unable
to be restarted before the system reboot.

The problem comes from the fact that there are multiple events for the
status changes and it is difficult to follow up all the scenarios.  Fix
the issue by detecting and using the status on demand, instead of using
a cached status that is difficult to be updated.

Patches 1-3 fix the bugs in DAMON_RECLAIM, DAMON_LRU_SORT and DAMON_STAT
in the order.

Changes from RFC v2.1
- rfc v2.1: https://lore.kernel.org/20260418222758.39795-1-sj@kernel.org
- Rebase to latest mm-new.
Changes from RFC v2
- rfc v2: https://lore.kernel.org/20260418014439.6353-1-sj@kernel.org
- Set kdamond_pid set callbacks.
- Support multiple enabled parameters setup on boot commandline.
- Acknowledge the third patch was discovered by Sashiko.
Changes from v2
- v2: https://lore.kernel.org/20260413185249.5921-1-aethernet65535@gmail.com
- Add RFC tag back, for sashiko review.
- Detect and use fresh status instead of trying to catch up all scenarios.
- Change Liew from the responsible author to a credit-deserved co-developer.
- Move authorship responsibility to SJ.
- Add DAMON_STAT fix.
  - RFC of the fix was posted separately
    (https://lore.kernel.org/20260416143857.76146-1-sj@kernel.org), and
    only commit message wordsmithing is added in this version.
Changes from RFC
- rfc: https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com
- Remove RFC tag.
- Remove 'damon_thread_status' structure and damon_update_thread_status()
  (SJ pointed out this was too much extension of core API for a problem
  that can be fixed more simply).
- Add a fallback in damon_{lru_sort, reclaim}_turn() 'N' path. If
  damon_stop() fails but kdamond is not running, forcefully reset the
  parameters.
- Reset 'enabled' and 'kdamond_pid' when damon_commit_ctx() fails in
  damon_{lru_sort, reclaim}_apply_parameters() (kdamond will terminate
  eventually in this case).

SeongJae Park (3):
  mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
  mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
  mm/damon/stat: detect and use fresh enabled value

 mm/damon/lru_sort.c | 85 +++++++++++++++++++++++++++++----------------
 mm/damon/reclaim.c  | 85 +++++++++++++++++++++++++++++----------------
 mm/damon/stat.c     | 30 ++++++++++------
 3 files changed, 130 insertions(+), 70 deletions(-)


base-commit: a51b50e60d2dae1f66329f147bde8723e6b1031e
-- 
2.47.3
