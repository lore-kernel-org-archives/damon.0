Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE84207A;
	Sat, 21 Feb 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702595; cv=none; b=qWuICY3LZwGxVdHSYmnBo7VOalvm5kboyFT31kzhF/+lZ3hefY6bFfqLJtsVdYrV4tLm7XUj24DhmZjAfOO3rqLEIMtr66JyPHOGz5aZP00PtggSPvjITwd6V5qzwxcBN5L4dK29VCU5ck2jPT0oeFZCtwmToIDQcvk97TSQD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702595; c=relaxed/simple;
	bh=4/cqu6/9bMRWAkiwVUxwwdtCHQE1xsDQhJqSkDquOyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=up2oijSwmbqe96+GHhjv4hi5UyJVMjeaYM/TFwNy02lO/fhhDStTm46LayKDIydHAokJxq0r6nTXczkm3tSuoCxDL2QffMGP0ICM4blKjTLNzBqfV+UXt4tz/8qtT+FrJBzfY0hOiGokoNP43eYNs+5bekE9ZOPZtBipG9BwRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKdZa4MV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKdZa4MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AB5C4CEF7;
	Sat, 21 Feb 2026 19:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702594;
	bh=4/cqu6/9bMRWAkiwVUxwwdtCHQE1xsDQhJqSkDquOyM=;
	h=From:To:Cc:Subject:Date:From;
	b=dKdZa4MVbzSBmai1pABwghOZq1xaPwH4Vm34+d4LyPVpyPqgr41f7niT1RSxfFx0A
	 BoL3y1DhuuRcB4NnBTCu+1d4XpmDo/+Y9CO1ohjPsR5Bzxb8k7MNtjKGDgu1F0d+Cm
	 wUickhpNF6LciTPOTcz9M/zAnda92MHgkJQNzXHf90RTofgeLATa/iprkxk+kyWJPV
	 uIQg3Pu0aarI11cyesYSCHnx/lht7H6fwLDItsoUKCiyfgDFLnm7CnwRslQQAdTQvV
	 W8uF1whQ+xynG1k8Owbo25RkEW47AdXsnDwYa+nk/zse4a/C54oV8+BJMLti0BNF8+
	 E3r7/z2lr51Bg==
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
Subject: [RFC PATCH 00/10] mm/damon: add optional debugging-purpose sanity checks
Date: Sat, 21 Feb 2026 11:36:17 -0800
Message-ID: <20260221193629.19332-1-sj@kernel.org>
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

[1] https://lore.kernel.org/20251231070029.79682-1-sj@kernel.org

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
  tools/testing/selftests/damon/config: enable DAMON_DEBUG_SANITY

 mm/damon/Kconfig                     |  11 +++
 mm/damon/core.c                      | 139 +++++++++++++++++++++++++++
 mm/damon/tests/.kunitconfig          |   3 +
 tools/testing/selftests/damon/config |   1 +
 4 files changed, 154 insertions(+)


base-commit: e059221c54896e36c8fc320029648e9013b382ea
-- 
2.47.3
