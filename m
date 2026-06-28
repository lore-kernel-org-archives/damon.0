Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD392F0C62;
	Sun, 28 Jun 2026 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782685983; cv=none; b=EHK5mDi5XDcsLvpp5PwSNYp0epeSPX8k1/rMsofI1tb1hA5uSg0vX98s473Xq+JZRLO/XZ74mjeojk8fLzEGbmmRk1ZZU0FIHEJQtcWU7vbG+NuIOHrNTuIM0Q1k+Di0bzECWYLRWk52U3KNue3+r/A63Y9WSI2pTJ6QOkZkk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782685983; c=relaxed/simple;
	bh=kePI7AO1I+uYy/YzOi8o0Zp68v+CEnNWfjrHKALqw/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IbfKhZQn2uijIB2cY8inv1VdoB6JNhirLu88rb59H0vlC3x/+80ZVFbbrVv2u+wQBkgi9byBstZ1kjRXpX3qwJxb4B4ULhHxFGWP7bJ/SUSQFE6S6zXUjzG+TaJ51xgxUqRlcLdJjg15y1ndlclBFj64QT1L7i/bCzAa4OGyakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA37E1F000E9;
	Sun, 28 Jun 2026 22:33:01 +0000 (UTC)
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: DAMON patches reposting plan
Date: Sun, 28 Jun 2026 15:32:50 -0700
Message-ID: <20260628223251.99886-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


For the lst couple of weeks, I was queueing a few patches in my tree
(damon/next) that reviewed by me.  Those were intentionally not merged into
mm-new, for gathering our efforts on stabilizing changes in mm-new for 7.2-rc1.
Because 7.2-rc1 is released, I am planning to repost the queued patches.  Let
me share the rough plan.

Hotfix
======

There are 3 such (blocked for 7.2-rc1) hotfix series (19 patches in total) in
the queue.  I just posted those all.  The list of the series and links to the
mails are below:

- samples/damon: handle damon_{start,stop}() failures (6 patches)
  - https://lore.kernel.org/20260628215447.96166-1-sj@kernel.org
- mm/damon/sysfs: kobject_del() directories that users can create/remove
  (11 patches)
  - https://lore.kernel.org/20260628220121.97360-1-sj@kernel.org
- mm/damon: add kernel-doc comments for probes and rnd_state of damon_ctx
  (2 patches)
  - https://lore.kernel.org/20260628220808.98931-1-sj@kernel.org

Non-Hotfix
==========

There are 4 such (blocked for 7.2-rc1) series (9 patces in total) and 7 such
individual patches in the queue.  The list of patches is below.

- selftests/damon: misc fixes for test bugs (3 patches)
- selftests/damon: fix memcg_path staging handling (2 patches)
- selftests/damon: test kdamond refresh_ms (2 patches)
- non-series
  - mm/damon/core: use kvmalloc for target regions array
  - samples/damon/mtier: fail early if address range parameters are invalid
  - Docs/{admin-guide,mm}/damon: fix DAMON documentation details
  - mm/damon/core: reduce kernel stack usage
  - mm/damon/tests/core-kunit: add KUnit test for walk_control_obsolete behavior
  - mm/damon/stat: use secs_to_jiffies() instead of msecs_to_jiffies()
  - samples/damon: Fix typos in Kconfig help text
- mm/damon/core: detect internal variation above max_nr_regions/2 (2 patches)

I will post those starting from tomorrow.  The 7 individual patches will be
posted as one series.  Whether to post all at once or one by one would depend
on how quickly the hotfixes are merged, and how many new findings on the
reposted patches the reviewers and Sashiko will make.

If the plan needs some changes, please feel free to let me know.


Thanks,
SJ
