Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03353B05A9;
	Thu, 13 Aug 2026 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599882; cv=none; b=rZjBE1uGl5zKKxnlbqHahdoq+NexNvWRE0aJ5g4khhDv5W037kt4lSAMCmhYbCv0KRcvApybb71jvI+TqhkXwnPcs0bLYBdxsSglPuyAEpD0HK82AkbewpZMotwDVTmrMJ5Aub1uDtpiRmN0rZnB/h4S2Mlg2+yGnNqUwBCiVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599882; c=relaxed/simple;
	bh=reO1Q2y44O7VfZkzhKzC30K0Jdi6MHP+ELt8OjdLzeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftLOWCiwA9lemtKQ+t6TdR48cB2QhS17xUpBN2Sl+wkLk+ODnXtucHplbJ6mLGMHsbRPRrKbQi6Nt7ewtRj/6w2HHVlocJZizA7oH62/RaIs6COg7TfNDGcszevTPbkpNHJaOX8Z3t6mMYCrN3+V29yWUE0EDR/q9mIR2tE78b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbqrgx6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbqrgx6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4CA1F000E9;
	Thu, 13 Aug 2026 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599881;
	bh=GWrqvTQp5gX0iQ380NMQ1BcygYRwK8eMayqbx8OVISw=;
	h=From:To:Cc:Subject:Date;
	b=dbqrgx6ZkdUXnevKHGzSwRe9qhb6DGHB46sDKOee/I9+8JI0DwJmlzqyLUtJgfmTY
	 3lGr3tDPSfzbGQDlicPe2TtMzmSniCoBBsetipySKsdPdiRN2qIv+IX9G4pz8nQbjz
	 HuHUT0Bok71wNIJhlUGqVESGz4Zz+TzHkO34GfN8vYEaoF7zJfrboJ9hYjuQDryN9a
	 DGTOubeaAQXCQYa0JmiNYF+Qle+S9AQEpyCyz1HPewwijXthOPewNwEhVTLRsW4m9w
	 Oa0UZ8dVJDu6Bxaqa78BSC00tG21ci2uqBiWKnwDE9ebXlsPph0qR8vcOQRURGAYZA
	 /gdVG8YK3bAcQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/3] mm/damon: move zero damos quota target_value handling to the core layer
Date: Wed, 12 Aug 2026 22:44:27 -0700
Message-ID: <20260813054432.101197-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having zero DAMOS quota target value can cause division by zero.  DAMON
API callers are checking the target value parameters to avoid that.  It
is easy to make mistakes in some of the multiple API callers.  Move that
to the core layer.

Patch 1 adds the corner case handling into the core layer DAMON
parameters validation logic.  Patches 2 and 3 remove no more needed
DAMON API callers side handling of the corner case in DAMON_LRU_SORT and
DMON_SAMPLIE_MTIER, respectively.

SJ Park (3):
  mm/damon/core: error damos_commit_quota_goal() for zero target_value
  Revert "mm/damon/lru_sort: error out for >10000 active_mem_bp"
  Revert "samples/damon/mtier: error out for zero quota goal target
    values"

 mm/damon/core.c       | 22 ++++++++++++++++------
 mm/damon/lru_sort.c   |  2 --
 samples/damon/mtier.c |  3 ---
 3 files changed, 16 insertions(+), 11 deletions(-)


base-commit: bb9dee2c45b87e872d6b1d5f812ebafaa952b7c5
-- 
2.47.3
