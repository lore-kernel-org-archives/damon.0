Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90B200B8
	for <damon@lists.linux.dev>; Fri, 20 Oct 2023 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQhrh7+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6732C433C7;
	Fri, 20 Oct 2023 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697822600;
	bh=9DTH2ejZ6gRx9v5Kr+Y3Lfgwo0SmTNuA/A5IR8D58/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=UQhrh7+6S/MSu4IcYRnXuy7EYcConABwkV5hydTwSyGaPGdbM+HMqPvgfmUEdx3Q2
	 2pBWW6qmhoe340ImjiAKa6WW0FD71QgmiHBHceMfRdW4VLA1W3NQyHUjHIXN+eXJP/
	 VlBL0uJMjRaOjf/o5PY5oVU6dzu7hzgNv6yKwCT7zH+CxhfMgHie2tydm/d+/n7S+N
	 CZNwWgm3CF7e66+DDpUriULU2laVgMqusZkUK7RZkGYU/tb698rfmgSsfILGziBHQE
	 brznPtN20sErmnwVXeT5lynnssIpxOJhevA05ao1A4x8QeQG4b4ek2Ioxqg1VwmSzs
	 OZcVn5GEq5lGA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jakub Acs <acsjakub@amazon.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date: Fri, 20 Oct 2023 17:23:12 +0000
Message-Id: <20231020172317.64192-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1
(https://lore.kernel.org/damon/20231019194924.100347-1-sj@kernel.org/)
- Add Reported-by: Jakub Acs <acsjakub@amazon.de>

The maximum nr_accesses of given DAMON context can be calculated by
dividing the aggregation interval by the sampling interval.  Some logics
in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
shouldn't be zero.  Such case is avoided since DAMON avoids setting the
agregation interval as samller than the sampling interval.  However,
since nr_accesses is unsigned int while the intervals are unsigned long,
the maximum nr_accesses could be zero while casting.

Avoid the divide-by-zero by implementing a function that handles the
corner case (first patch), and replaces the vulnerable direct max
nr_accesses calculations (remaining patches).

Note that the patches for the replacements are divided for broken
commits, to make backporting on required tres easier.  Especially, the
last patch is for a patch that not yet merged into the mainline but in
mm tree.

SeongJae Park (5):
  mm/damon: implement a function for max nr_accesses safe calculation
  mm/damon/core: avoid divide-by-zero during monitoring results update
  mm/damon/ops-common: avoid divide-by-zero during region hotness
    calculation
  mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
  mm/damon/core: avoid divide-by-zero from pseudo-moving window length
    calculation

 include/linux/damon.h |  7 +++++++
 mm/damon/core.c       | 12 +++---------
 mm/damon/lru_sort.c   |  4 +---
 mm/damon/ops-common.c |  5 ++---
 4 files changed, 13 insertions(+), 15 deletions(-)


base-commit: e845524c56a529768a8793e96304db09134eafdf
-- 
2.34.1

