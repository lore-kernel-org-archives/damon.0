Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0841A0BF1;
	Sat, 17 Jan 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672385; cv=none; b=dwvUgxDBaPJgjgJv0XZyLDJQz/HxzHbGfCUzC9FQRfbgrZLjXtT9QogVyWQXnhi0fkAKzBxXIHx+XM+N3KAcHy/peegwgO4kElbKAd+Fejqta/70gen1MuOqOs1OtlHgsTpATXGdMMedL06g3XksQ7THeGrdHY2bI9SPQ6ezIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672385; c=relaxed/simple;
	bh=BrhbCrEirTOhCYFjA97mSPQaKUy3EH5FD2Gu/gQI3T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=McfdLt06NqN/4RkdN7LMplvoUkOn+6VTA5CXlmDyyYggcXsXT3IRBBGRo0eG9JMDI1FXAjB53sftaIlLXa94XEJjjQO77s91qiUSUYSDv0Lik6oFfVdTZVm+vFSRn7f5ft6862cwkbY8g7vJXMcnBkMIjpWK+PoLQodHqHSgbRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgIAAu1w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgIAAu1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EB5C4CEF7;
	Sat, 17 Jan 2026 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768672384;
	bh=BrhbCrEirTOhCYFjA97mSPQaKUy3EH5FD2Gu/gQI3T8=;
	h=From:To:Cc:Subject:Date:From;
	b=MgIAAu1w4/CWCZJiuLLu5kFcobQQr2kktaP5aJUyrLFsARW4KF8/g4i8gcsk3uKhs
	 k6WnlweJvSFt+ha6mHfoQGQODYc3RcD417fU43BA4ZexjId0zXOjaMPdG47jQaVtrd
	 EWHBiGxUyDwmK0x1tNJEtdrcMNpP7lizmH2IzdMyrJsgh0tKPh0g7y30QUjAxqVIgJ
	 1TvEKiCT4Ql/HfUqEDWyLUcBoMNl/7TcXnt/nYhUpnJW0MUDtzJnFwfp6kJxDMobOz
	 QgNfqsXExC0kvwgmtW/ku93cGdA5zi5598Q+mpUomS/xR22gSoPRWCvNJ1byoELGy8
	 Qebwzn6y9/K1Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: cleanup kdamond, damon_call(), damos filter and DAMON_MIN_REGION
Date: Sat, 17 Jan 2026 09:52:47 -0800
Message-ID: <20260117175256.82826-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do miscellaneous code cleanups for improving readability.  First three
patches cleanup kdamond termination process, by removing unused
operation set cleanup callback (patch 1) and moving damon_ctx specific
resource cleanups on kdamond termination to synchronization-easy place
(patches 2 and 3).  Next two patches touch damon_call() infrastructure,
by refactoring kdamond_call() function to do less and simpler locking
operations (patch 4), and documenting when dealloc_on_free does work
(patch 5).  Final three patches rename things for clear uses of those.
Those rename damos_filter_out() to be more explicit about the fact that
it is only for core-handled filters (patch 6), DAMON_MIN_REGION macro to
be more explicit it is not about number of regions but size of each
region (patch 7), and damon_ctx->min_sz_region to be different from
damos_access_patern->min_sz_region (patch 8), so that those are not
confusing and easy to grep.

SeongJae Park (8):
  mm/damon: remove damon_operations->cleanup()
  mm/damon/core: cleanup targets and regions at once on kdamond
    termination
  mm/damon/core: cancel damos_walk() before damon_ctx->kdamond reset
  mm/damon/core: process damon_call_control requests on a local list
  mm/damon: document damon_call_control->dealloc_on_cancel repeat
    behavior
  mm/damon/core: rename damos_filter_out() to damos_core_filter_out()
  mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
  mm/damon: rename min_sz_region of damon_ctx to min_region_sz

 include/linux/damon.h        |  15 ++--
 mm/damon/core.c              | 143 +++++++++++++++--------------------
 mm/damon/lru_sort.c          |   4 +-
 mm/damon/paddr.c             |   1 -
 mm/damon/reclaim.c           |   4 +-
 mm/damon/stat.c              |   2 +-
 mm/damon/sysfs.c             |  11 +--
 mm/damon/tests/vaddr-kunit.h |   2 +-
 mm/damon/vaddr.c             |  25 +++---
 9 files changed, 89 insertions(+), 118 deletions(-)


base-commit: 886ef5515d08f05191b61a347fc18f371627bdd4
-- 
2.47.3
