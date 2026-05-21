Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D33EDE7E;
	Thu, 21 May 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374079; cv=none; b=PQPNYDZLQP5SF+4uhcxKyueunERSqvCc5/1g4L6UDsBDRAQx4DcdtMP5cqZ1k/X+IBCn3y3/pFPxVefn3KMbbRpffg3D5PBjRzEmuRiFUhUNi55yCWNAxYgXxDh0VLDznGaCWRA33XE0o2YT0YpPMZK3yoaKeQbcm8wNLGY4Nro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374079; c=relaxed/simple;
	bh=8tM1Ip+kL/INzmucmor8I4MTEb43F8KCuLBYXYE96QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=If20yjuPZMWR5zxkONX2ANkKt1CD+HYeRzEi3s1cpdzbWszFsclqEBw+ZH7UPeeVQ1ZJGyaqahcIcfSEITQdmIlJzaIxzKGnZvq0WdPzXlNetESo+7DsnOW/vjIgQdccXq3bS0LeZ/XWd6lqH7N6SOkf5Z1EjLyzKwUhT8d7SFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWEiFSk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWEiFSk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349ED1F000E9;
	Thu, 21 May 2026 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374077;
	bh=oDpHqdp2/FfG8W6otjqNlnOFXaYu8wH7zUOP/guV6po=;
	h=From:To:Cc:Subject:Date;
	b=jWEiFSk53GduYLLCUcNwNsnavil23yX3zXvfJ2cxVG+reQXF35lvztNJ6uNseFk16
	 MvWA7k/XHMtEkdJloi/jQyycdC0GfEdaZPOd86TcUFcsxpZVc6gjUIjZI1FQVZALdS
	 ezDdvqO151RFHncBqVl+pljPYy0D5oc6WhLhwSIUSLRVwIe1+n5OgonZ4z42zkOgpe
	 heUNBdL9AKfTE8OG8a4dAPIQCHLDHLtkk2iADsiLAzVF3beAt2l/EIaYOuZbPyu6LV
	 58x1F6+2i7xYNeetZtVI7XcNyZWpekxX5YHCIE/xxtYkv2+DgJ3Cvk+3BHQh3NQmLr
	 oVII3c3q1GNwg==
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
Subject: [RFC PATCH v1.2 00/14] mm/damon: minor improvements for code readability and tests
Date: Thu, 21 May 2026 07:34:10 -0700
Message-ID: <20260521143428.83157-1-sj@kernel.org>
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

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260521035349.87565-1-sj@kernel.org
- Free DAMON target in vaddr unit test fail-out path.
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
 mm/damon/tests/vaddr-kunit.h           |  27 +++--
 samples/damon/mtier.c                  |  10 +-
 tools/testing/selftests/damon/sysfs.py |   4 +
 tools/testing/selftests/damon/sysfs.sh |  14 +++
 7 files changed, 233 insertions(+), 69 deletions(-)


base-commit: ac6b83c7bf3671e8ff0d541cf03e6eaeed00a79e
-- 
2.47.3
