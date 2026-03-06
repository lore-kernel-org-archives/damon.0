Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37C3CB2FD;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810962; cv=none; b=X1XkuFA1+PWtICVyGJAk0qo5LKT55hmII/o4iJbRdK4tMrYmp1hwaLaPPQCxnoREDwwrCl+onHJIOB/E0AcYBxT1CiW2FampsaluYAyyWkZVYJ56xsYZFJxC1aNsRtjjNuLevuFWFZwLwOmUn4MSpPltkAeKWiIC4j+j2EDfhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810962; c=relaxed/simple;
	bh=E14iF6Uxk2Oavef0L2q6s8ESqXWplXDEpDkb4fZORcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkNdljZ0lfd9exsVoJXduRR1ddaYtYOMOqXbB7ScKHunle62QCRubNYg9/ZtZB6TWcGvvaaOr5TZGsYY1rpr+yht6/RYmFP5gkywNZvUDS6S8VZHxXRP12e24kFFeBYbHgAryJY3i1R8rs7kX4EWMFV8GR3OsOVUhuf9ANaBw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgi/yg6Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgi/yg6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4954C4CEF7;
	Fri,  6 Mar 2026 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810962;
	bh=E14iF6Uxk2Oavef0L2q6s8ESqXWplXDEpDkb4fZORcU=;
	h=From:To:Cc:Subject:Date:From;
	b=Qgi/yg6YyYTyLiY4iliYNCvbDyAsX7fmBjIJZtx3q6lXMGKGskn3AusoHZEoAo7Xq
	 WVm6qfAtTEYZVoRsGKb3glk4HeyjbZeW7bf02n2Ffszbi6+LTEZ6Nu9cwn3YWgTxIj
	 qFnNxsocQ+IamtHf0XxvtietST9EMuZZgelM3gEz+Wu1Ndh3xeLRa3WuhAaSBuGMBS
	 aNtfTvEbkLyma6YdoX9qaxaWhMh4Iu23gu+P1VGJ4Dd9r9YeMJ8kmCVpLG1bVxYief
	 BpioUcuHSy29+erlfpl5jSLLv56UPXQ12/NaPCBq3/Rb6wIjrPQeM/f/NvjUMC3hfw
	 CCNXnK7ZiZuPQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/10] mm/damon: add optional debugging-purpose sanity checks
Date: Fri,  6 Mar 2026 07:29:03 -0800
Message-ID: <20260306152914.86303-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON code has a few assumptions that can be critical if violated.
Validating the assumptions in code can be useful at finding such
critical bugs.  I was actually adding some such additional sanity checks
in my personal tree, and those were useful at finding bugs that I made
during the development of new patches.  We also found [1] sometimes the
assumptions are misunderstood.  The validation can work as good
documentation for such cases.

Add some of such debugging purpose sanity checks.  Because those
additional checks can impose more overhead, make those only optional via
new config, CONFIG_DAMON_DEBUG_SANITY, that is recommended for only
development and test setups.  And as recommended, enable it for DAMON
kunit tests and selftests.

Note that the verification only WARN_ON() for each of the insanity.  The
developer or tester may better to set panic_on_oops together, like
damon-tests/corr did [2].

[1] https://lore.kernel.org/20251231070029.79682-1-sj@kernel.org
[2] https://github.com/damonitor/damon-tests/commit/a80fbee55e272f151b4e5809ee85898aea33e6ff

Changes from RFC v2
(https://lore.kernel.org/20260301174327.76849-1-sj@kernel.org)
- Rebase to latest mm-new

Changes from RFC v1
(https://lore.kernel.org/20260221193629.19332-1-sj@kernel.org)
- Fix WARN_ON() failure on kunit UML build
- Fix Wformat-zero-length issue
  (https://lore.kernel.org/oe-kbuild-all/202602221352.odZW8x1R-lkp@intel.com/)
- Rebase to latest mm-new
- Make warning message less verbose
- Use WARN_ONCE() condition
- Do the verification asap
- Minor cleanups

SeongJae Park (10):
  mm/damon: add CONFIG_DAMON_DEBUG_SANITY
  mm/damon/core: add damon_new_region() debug_sanity check
  mm/damon/core: add damon_del_region() debug_sanity check
  mm/damon/core: add damon_nr_regions() debug_sanity check
  mm/damon/core: add damon_merge_two_regions() debug_sanity check
  mm/damon/core: add damon_merge_regions_of() debug_sanity check
  mm/damon/core: add damon_split_region_at() debug_sanity check
  mm/damon/core: add damon_reset_aggregated() debug_sanity check
  mm/damon/tests/.kunitconifg: enable DAMON_DEBUG_SANITY
  selftests/damon/config: enable DAMON_DEBUG_SANITY

 mm/damon/Kconfig                     |  11 +++
 mm/damon/core.c                      | 109 +++++++++++++++++++++++++++
 mm/damon/tests/.kunitconfig          |   3 +
 tools/testing/selftests/damon/config |   1 +
 4 files changed, 124 insertions(+)


base-commit: b2de0f05a00142f219d8f6e96b22c8f19fe0446f
-- 
2.47.3
