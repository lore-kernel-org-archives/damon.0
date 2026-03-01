Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA132C0F6F;
	Sun,  1 Mar 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387011; cv=none; b=Lz2YEJcoT/Mhmi0FC5EXO9OP3jEalCEUqM5J8OcuT6OpsBpXxC3P0w8IUVcSqZQxWRGqvXPQZKKoALt/rHFwFXq+FRmuGIQC65VoOEztTBRfFwtzBTfOcDsUKRooW2d33BH69RYw6KxtytwyJ/dSewIR0O7guhDmIMmR6P9SnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387011; c=relaxed/simple;
	bh=+CwkXbOh/Fg6OBVe8JUapRvY8ZYQMp73JI7BMgt63xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4J3kKF64AmKyGqHqf7qp1aINbdN7d9ipJH2pA9hwBmRIqDauVKQQAegYygnT3lF7epITVzo+tqjRGBIL9yqQsRyyWG0RcgPo34pYHYXxdWCg5OPvt6qbku71fjzu3qU7IR+avxHFjA9B3NJkg0j6UhpHNnA+d7DgJgHgjTTJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMQeBh/5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMQeBh/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F4AC116C6;
	Sun,  1 Mar 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387011;
	bh=+CwkXbOh/Fg6OBVe8JUapRvY8ZYQMp73JI7BMgt63xE=;
	h=From:To:Cc:Subject:Date:From;
	b=HMQeBh/5DjKrwDG2HtHsTqzr3oTuh45Xn+J8cyc9lI0TmzjP/N1s9r/nywlh347yi
	 h4lgUeq8iGAUN8KILGk3q8JeiFVMJvw3CoLHKwLh3M67Ozwhites3cKQRJhuqbciyR
	 oz8VJ+LY0XSpTl+9LoxSPCjOS6Hk6a+/aaGiNqk4d760PDAI0fBOnm2ta4hcYLCW8S
	 sK6Wmcsv5kXDzGefzFlR+tl5H61dsAna9Cv76OjegaRMdTCJnSGTcqK6Pc8QYApWSJ
	 vsBGFlnwDmGFpy02IyztVzOK47cx5aTJgA34hARbxROOvjMzf61urrTP2WCHvhwOV/
	 5pAlC4YTWud2A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 00/10] mm/damon: add optional debugging-purpose sanity checks
Date: Sun,  1 Mar 2026 09:43:15 -0800
Message-ID: <20260301174327.76849-1-sj@kernel.org>
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


base-commit: b511f483f5fc7e85ad60679181503f16937feb6e
-- 
2.47.3
