Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852A466B57;
	Fri, 22 May 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464436; cv=none; b=bmcEbXwqfsLORNfgbFnlZqQgxEljllY/Dtu7CVBNS21NeWYWM4xYZuBTEHxlED2FK8z8wy3076E1tW7LpDFSRQsd4A4yr5PlzixAr4yeOwjWigrhrUIPicWKMJTB1py2nK/BvtPWlPBSHwXf5ypk5njKsW+eNPIhxfomL7+kTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464436; c=relaxed/simple;
	bh=Tas0ugQ9cfktkX/E41HfpnDQF3Mj9Llr6hzO6JTSGUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxJvrehCvubOfjdZMm16bH+wyqhZfaAzx+ypooLkVg2xirUDl/eUKNBScJHIgCGst0AAnm5gD6jf4/IoMk93qjvr2oeUZOxJ43XKRUU4PdPxjTcqOL/sVskH7dbvtI5YujOz/+Y64y/huetdXqPUV6UUnaxMg8VJUIpHFmlhl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZqdJ6Ux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZqdJ6Ux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F381F000E9;
	Fri, 22 May 2026 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464434;
	bh=6QxSA9c/yrZYSL5gcr9C6ZCwNghk39MyMElVsQof6yo=;
	h=From:To:Cc:Subject:Date;
	b=oZqdJ6Ux7DMZtTKLSyYOFOWpVxWyMDem1e4BmHzwpHyTb1QPRDOpvyGaICKMor6WJ
	 j37lowD0I8eVvc3BkXsUheghqZAi/nnhfwJpBQMWVA1dgmeOAZ3ldf8qmWvp7IIG1Z
	 AsbDXo8++EVRePIocEDtphlsCkk6Uyn31wUiKZDVcwpfl6PLrWf0YaFmH08rXgVWZP
	 BeYpe5eP7eVdN47jMO/EmI0QSCnHmM4pUwX928kypmAAs4Sc/P+7lp1rJo6pnsKVb+
	 mX1MnQP+yRwB1ithYO7VdK+N5DgENB1pflGWwDBm/ahzK8fW0EfrzxgyMZvKLpXt5m
	 bbIWtRH3qGtNA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/14] mm/damon: minor improvements for code readability and tests
Date: Fri, 22 May 2026 08:40:11 -0700
Message-ID: <20260522154026.80546-1-sj@kernel.org>
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

Chagens from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260521143428.83157-1-sj@kernel.org
- Drop RFC.
- Rebase to latest mm-new.
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


base-commit: 712074729b7852a468166a84b131ca9f12680629
-- 
2.47.3
