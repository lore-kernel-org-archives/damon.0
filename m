Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110B9443;
	Sun,  6 Jul 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832025; cv=none; b=FMEsojV6t8DPMr5c6ZnxIFQgDkdPZ49G6RkvRYw7hQZgPMamBjldGr55ThWaRGmA04at6M1b1w7ZlBEL1KYUYj/BYvYKjNCJw6XmUsfcqWyzrR4aAtKA9CHs0JzN5ksLaKku9OpchrIrP2bloXVlbwQprzsAn5KE6xv8vNNN65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832025; c=relaxed/simple;
	bh=D76AwiLfuundtcXthXhrN0gK/Q44fZ5ROfLZOcnikpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozDAmFyy/I/w6g6+J1WyhHtiFDl9Q2lop+Jo55Bo2sprBUcDwmw9f5OqQobIqUd2foxURcmlVWUEWiRwDFPyLgUqQZ7pHz8piHQHdAdz7ZnyaW9++QZj+MQd7TN3V5aMu/fKLXuAz84VbcgT/HYsNkfhXU+fe9BJiGyuN7RDvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3fkJAcW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3fkJAcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3AFC4CEED;
	Sun,  6 Jul 2025 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832025;
	bh=D76AwiLfuundtcXthXhrN0gK/Q44fZ5ROfLZOcnikpk=;
	h=From:To:Cc:Subject:Date:From;
	b=B3fkJAcWkAVsVT/cO8S7VKV4oz9u9CNBPr6l9Ocmq1NKcIc2+LUhceep2Qz1pQvK7
	 8+KwxuDOuKHXlZEm4nFsaP0gphshiBSGZ7FiRCcYgAUoyXxhN9dBv3F5mxbdo3AMzj
	 shNEDWdKbb1D3jZ9jfe7Xvp/w53Cahgwvd4m/+UIzdHMhIgBRbIKk22gddKpzucxj4
	 /0fbsLvsAOZ67+FC2q1rL8IHh6EvMy0nkfYs6uWILSGIJ/nCBecUABgW618f/sz2Go
	 TWEDAiWZ8dycT2oDUolZN5ASww6NIzEiqIlCFPeKnxdk7yGI81ewqnYQNkzK7TiTbl
	 AFumKBZCrTc7Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/14] mm/damon: remove damon_callback
Date: Sun,  6 Jul 2025 13:00:04 -0700
Message-Id: <20250706200018.42704-1-sj@kernel.org>
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
damon_callback usages and finally remove damon_callback.

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
 samples/damon/prcl.c         |  18 ++++--
 samples/damon/wsse.c         |  16 ++++-
 11 files changed, 189 insertions(+), 207 deletions(-)


base-commit: d7932983411c60940e9b834ac554c33e0ca6f2ef
-- 
2.39.5
