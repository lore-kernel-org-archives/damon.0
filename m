Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF05374721;
	Wed, 20 May 2026 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258549; cv=none; b=X48MvvEb6+4a91sBVPwuJ9mxfRcK6Thj3vs7U5mryjh4iV2BoprmQ8S5IZrAYASNGw5tNZJi487apCxAklkp4rHtp2jdfgPToO+E097EZuhNpJCJBTyocsQF5xIN0icEQSg+/MbYx98yFoIoL38RHQsf7vYbB5Ul6AsapnWG088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258549; c=relaxed/simple;
	bh=JNNbHwAZ6vDQlhc2jv9usc/LJITunKX1FSu9NxdEMAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fver3y3qdhTAgAvhxiScsfienjIkydJSHNKCwtXS+4PMRUBkR46CgruQxDYv4hy0PEV+4CcrWnwvzwsAqlLBeGIzJOZrn/usnoazDChDJ+vz9gRR2ucFS0+lBOHKVKFvQi2SrNCP7CjbG3eiREEkAjBbeIWHrB73PjsrK/P2aA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhJVi031; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhJVi031"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641AC1F00893;
	Wed, 20 May 2026 06:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258547;
	bh=2QZBI9lHfw0z2vkHVTq3F8i3GFIsR6yWGGTq/bbu72I=;
	h=From:To:Cc:Subject:Date;
	b=lhJVi0312kKyHMbcsBQ3eowTBceyHjvB+t5JIUXfALT+jp/1VLlXseB3qYIKKL7Gb
	 JxGzGZLDevosJUtPvyATXLqnHzJ8AZ7cq4S0/zNU9a0TWzf57BKxYmsFzkqmPHvPee
	 t16WKXvRhiWZb05CZp5tGASHnCLPZB4V8k/1wGqjz9FykOTYHdVucXb8wUVbvn1KLp
	 C4LPucgd9kqAvMDnKN76tEFB3gGH9oZwGRAaHtwfppExDQQIOyDcPDYRF8er68qEh0
	 y4teKxnCD8wiEBhRB2PN2EgX8kWz5wPFlfPrbh/LLG0eppK9gLWXmDcfGFQj6J9rQO
	 KSQaBkUtZHNdw==
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
Subject: [RFC PATCH 00/14] mm/damon: minor improvements for code readability and tests
Date: Tue, 19 May 2026 23:28:32 -0700
Message-ID: <20260520062858.167011-1-sj@kernel.org>
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
 mm/damon/tests/vaddr-kunit.h           |  16 +--
 samples/damon/mtier.c                  |  10 +-
 tools/testing/selftests/damon/sysfs.py |   4 +
 tools/testing/selftests/damon/sysfs.sh |  14 +++
 7 files changed, 223 insertions(+), 68 deletions(-)


base-commit: 8b8727a18b7f247aed7e0476b92d07fc59c04cb8
-- 
2.47.3
