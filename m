Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82DC86348;
	Sat, 12 Jul 2025 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349821; cv=none; b=nX1yeMjuPfoSV2z+GrfFvy3REyHngeTxkIpo6lhphHspwNoQXaM+lVKdM24dbJSunC/YE4cwVQH5mWd4AR3BF+0ng3HZtLXgV38oAjp4dBqmz3aNfJvR/LAfumedOIaACBEmBggpsdVqDceFmb1BpxYwnK5QEX7OH7NB1+Cbs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349821; c=relaxed/simple;
	bh=iMXyEafbKbZx5VH4yI00DVv/yYVsMaNu/+JwZ+hQPjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CvJR4peN9q3PiRkls4P3jAWXoKBhPns64Jn9oVMZ7Dhf8h6a93gnPS41B5pV48jCMc/6rYJZ/ZLoS+gQXXdNPeEKmyrvFlDhjg4RXrcCI1kmk2jVicm4+jPebAo2fBBdKonSS3sWVHgA+0iTsixj6IFvkro61WnttC2KrQ2buhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXF+bFBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXF+bFBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2104DC4CEEF;
	Sat, 12 Jul 2025 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349820;
	bh=iMXyEafbKbZx5VH4yI00DVv/yYVsMaNu/+JwZ+hQPjI=;
	h=From:To:Cc:Subject:Date:From;
	b=AXF+bFBMDO53rD9LUEJT9cz4+J8lvGOcHXqXShZ/C9YuLQmuh51nLTppgJQN2UKxL
	 3pg88rCuqRup+v2i8Y8Fdr8pVmCL2/Sd0Nk/qfURyMmalERi8BFpJlM8HPnv38hZ1E
	 qyThFAiZ0KO548cJy53a+VPlaJ0VsZwMs3cKfWKtPyfsVzwN7mJEWlQmFwxoiQQVS4
	 Svzz3bIRN/vNlo+fx6voEhYELRcX04D1WxJ1xhnL+Y3eO1Ce8yUVfLCbxixhN8h1R1
	 0KPDtycLqsiq62XpwIfBekWYu7md4KhWqyHJeJWIE/SM34zGQrVWMi2u+KhqrtA6rU
	 RwcIr/ECEu2YQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/14] mm/damon: remove damon_callback
Date: Sat, 12 Jul 2025 12:50:02 -0700
Message-Id: <20250712195016.151108-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_callback was the only way for communicating with DAMON for
contexts running on its worker thread.  The interface is flexible
and simple.  But as DAMON evolves with more features, damon_callback
has become somewhat too old.  With runtime parameters update, for example,
its lack of synchronization support was found to be inconvenient.
Arguably it is also not easy to use correctly since the callers should
understand when each callback is called, and implication of the return
values from the callbacks.

To replace it, damon_call() and damos_walk() are introduced.  And those
replaced a few damon_callback use cases.  Some use cases of
damon_callback such as parallel or repetitive DAMON internal data
reading and additional cleanups cannot simply be replaced by
damon_call() and damos_walk(), though.

To allow those replaceable, extend damon_call() for parallel and/or
repeated callbacks and modify the core/ops layers for additional
resources cleanup.  With the updates, replace the remaining
damon_callback usages and finally say goodbye to damon_callback.

Changes from RFC
(https://lore.kernel.org/20250706200018.42704-1-sj@kernel.org)
- Fix wrong return from loop that prevents repeat mode damon_call().
- Remove unnecessary put_pid() from DAMON sample modules.
- Rebase to latest mm-new

SeongJae Park (14):
  mm/damon: accept parallel damon_call() requests
  mm/damon/core: introduce repeat mode damon_call()
  mm/damon/stat: use damon_call() repeat mode instead of damon_callback
  mm/damon/reclaim: use damon_call() repeat mode instead of
    damon_callback
  mm/damon/lru_sort: use damon_call() repeat mode instead of
    damon_callback
  samples/damon/prcl: use damon_call() repeat mode instead of
    damon_callback
  samples/damon/wsse: use damon_call() repeat mode instead of
    damon_callback
  mm/damon/core: do not call ops.cleanup() when destroying targets
  mm/damon/core: add cleanup_target() ops callback
  mm/damon/vaddr: put pid in cleanup_target()
  mm/damon/sysfs: remove damon_sysfs_destroy_targets()
  mm/damon/core: destroy targets when kdamond_fn() finish
  mm/damon/sysfs: remove damon_sysfs_before_terminate()
  mm/damon/core: remove damon_callback

 include/linux/damon.h        |  44 ++++---------
 mm/damon/core.c              | 116 ++++++++++++++++++-----------------
 mm/damon/lru_sort.c          |  70 ++++++++++-----------
 mm/damon/reclaim.c           |  62 +++++++++----------
 mm/damon/stat.c              |  17 ++++-
 mm/damon/sysfs.c             |  41 +------------
 mm/damon/tests/core-kunit.h  |   4 +-
 mm/damon/tests/vaddr-kunit.h |   2 +-
 mm/damon/vaddr.c             |   6 ++
 samples/damon/prcl.c         |  20 ++++--
 samples/damon/wsse.c         |  18 ++++--
 11 files changed, 189 insertions(+), 211 deletions(-)


base-commit: 2c92772b92095b79ca713f215b192b555e41f72e
-- 
2.39.5
