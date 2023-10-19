Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900539866
	for <damon@lists.linux.dev>; Thu, 19 Oct 2023 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuUPzS+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79ACC433C7;
	Thu, 19 Oct 2023 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744970;
	bh=hrrza+crBd0RjMFZAgh+3yDyKNEWLMDaW4dbIT2n9jQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CuUPzS+NiENfFW4IGkmjF1bIWMGzjCQS3iWVUOePE5rhfXDWxQte786cYVifxeVzx
	 GrusnsW84WOyMJCPzhi3dOzPjSZbDevDjkyXI7MCiqo08/rKT0phGUitlODzcDpPvA
	 DvtSZBqIgt3a6OilHFjCisaHGwHT4q7him0DbNN7eSOLHYaW+xrQcm5RQ/gr255Wr4
	 +idbbXK+i9HClhI5L3MD8qLFUwodlAdLn3hQC7Xp6A4mslYvrIeQv7J/RAgd1cYbh/
	 +KhbQCiGeuMhqyTDT0vc5ilNhJwDrMG5lYAE3kylIerEvyFdvggU2shT/VU/IZ5SKA
	 a7DlWTT1r0r6Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date: Thu, 19 Oct 2023 19:49:19 +0000
Message-Id: <20231019194924.100347-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

