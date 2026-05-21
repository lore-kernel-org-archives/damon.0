Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E877299959;
	Thu, 21 May 2026 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335641; cv=none; b=eLLbhUkHBXBudCXvOs5mYMY38vRO5kmhSIAz8bPQSDGu29Sr9GgbHbM7PE4PhaZofZLDDRVwyLZxbeQPh2xl5Hy5pr5wSL7WIRYi8lX9Npv8zAGLTWaIWP4QFiTfJf78Q9BbmzzLIJWx12FtWKMURLVQzIFzfXYW5vgjhWnXGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335641; c=relaxed/simple;
	bh=2Mrzvwpj79byPkxBHVx5WQsyswPHQ8padRKvoa208+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rARsOnxtcquVn6/aV0hhVz0q5lkPPn+CDThEII2ZNl2FHLiAMWjuP4LmOs1E+cXYklgGGrhyPPJ2i5X3/L3OfidxgeJviBfJ2crA+aJRnfJYeiqB37uQxPmeUCkU50/Jl+PYup7+I5g8JatQ/wm4NrmIpoXNt71XhTZbUj6Ykdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFAapP3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFAapP3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565901F000E9;
	Thu, 21 May 2026 03:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335639;
	bh=TJFCxCKfH+m1BDgsjzbYuCTSOiloEwDvbWbleyxza+U=;
	h=From:To:Cc:Subject:Date;
	b=CFAapP3fUeJAbxRvEvaaOmN682WJ2DCPSQoiSxwaQYkDxpDry/DYJbPUoN6MuTfbE
	 c8boByrg6YxziGv9D/2xwZn3rErvayYnUFlg9Xu9Yp9xFIqPOx8YPcxbAHZgfIItDc
	 1LhU6G/KbvarCMT65JtCWz/bOHTxDk/gz16E7iSEyUJvZsCBTEDDJU7oPVRM7MDjD5
	 +Fm5+VqVpWeKjYphzq01LqzuM8n8wO54GFUfLFkpAODu9onAUBUHo7pLKfm83aLOrK
	 Mi0hHRPN/AVdSsPn5N0tC1ZSdmJqdZCZJOmJ/xSaxRKjopw3VKuvfUCJLXWdIC15RW
	 dHOesJBYlp/EA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 00/14] mm/damon: minor improvements for code readability and tests
Date: Wed, 20 May 2026 20:53:34 -0700
Message-ID: <20260521035349.87565-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement minor improvements on code readability and tests for DAMON.

First seven patches are for DAMON code readability and resulting
maintenance.  Patches 1 and 2 make damon_set_regions() safer and easier
to read.  Patches 3 and 4 remove fragmented DAMON API use cases. Patches
5-7 hides unused core functions that are unnecessarily exposed to API
callers.

The following seven patches are for DAMON tests improvement.  Patches 8
and 9 adds and removes DAMON_DEBUG_SANITY verifications to ensure
reasonable test coverage without too high overhead.  Patch 10 adds a new
kunit test for damon_set_regions().  Patch 11 makes sysfs.py selftest
more gracefully finishes under test failures.  Patches 12-13 adds simple
sysfs.sh test cases for the monitoring intervals goal directory, the
addr_unit file and the pause file.

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260520062858.167011-1-sj@kernel.org
- Handle damon_set_regions() failure in vaddr unit test.
- Free ranges array in vaddr unit test.
- Fix wrong region address verification.
- Fix typos in selftest: s/exit/exist/

SeongJae Park (14):
  mm/damon/core: safely handle no region case in damon_set_regions()
  mm/damon/core: do not use region out of a loop in damon_set_regions()
  samples/damon/mtier: replace damon_add_region() with
    damon_set_regions()
  mm/damon/tests/vaddr-kunit: replace damon_add_region() with
    damon_set_regions()
  mm/damon/core: hide damon_add_region()
  mm/damon/core: hide damon_insert_region()
  mm/damon/core: hide damon_destroy_region()
  mm/damon/core: add kdamond_call() debug_sanity check
  mm/damon/core: remove damon_verify_nr_regions()
  mm/damon/tests/core-kunit: add damon_set_regions() test cases
  selftests/damon/sysfs.py: stop kdamonds before failing
  selftests/damon/sysfs.sh: test monitoring intervals goal dir
  selftests/damon/sysfs.sh: test addr_unit file existence
  selftests/damon/sysfs.sh: test pause file existence

 include/linux/damon.h                  |  13 ---
 mm/damon/core.c                        |  92 ++++++++++++----
 mm/damon/tests/core-kunit.h            | 142 +++++++++++++++++++++----
 mm/damon/tests/vaddr-kunit.h           |  24 +++--
 samples/damon/mtier.c                  |  10 +-
 tools/testing/selftests/damon/sysfs.py |   4 +
 tools/testing/selftests/damon/sysfs.sh |  14 +++
 7 files changed, 230 insertions(+), 69 deletions(-)


base-commit: ae90ad6788e582af07da1b2ce81277d5a65f4f89
-- 
2.47.3
