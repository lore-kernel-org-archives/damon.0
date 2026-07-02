Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CAD34F255;
	Thu,  2 Jul 2026 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026367; cv=none; b=UBy3rLEfqPGs3y4d+jx8gvn6MmbHtZPlR8pbzF8Mm1yp3SVKaVHoXDFuYbiBwXCJqcOJ4nklLZk6EjAWBAdDQMZ+2+Uw1NWSq+BN2x4SflsuQR6Xe3AvCzwtnhuqUHVdsavzF3EBvghkGe3/pZdPm17Ehcw1E9Ea92fbK5tGQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026367; c=relaxed/simple;
	bh=ijnPu6P3+YsHNowcf+/ywLbHOdx27TJHLjpV60NY/I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+3SKWascR1hIwzaXymeaZM3upCnGCRm6WJHG/rEimBsaz0kbaL+7FRJG5jQ8mH4KqdoppByWAe5d/XLHlQTQAoh2uDhe3RnrUhEzQHSetXzuZmIfMkEq313XnhnjBYuC3UiQZR7YVn4OU3YT/fkNkdV5R95L5mQckad9TnVwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/vD0Zgf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/vD0Zgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A944B1F000E9;
	Thu,  2 Jul 2026 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026366;
	bh=DqLQ2Ua3Wk29R4FwSGEqfPPas6Fe/mAiDzCtNiVA+UY=;
	h=From:To:Cc:Subject:Date;
	b=F/vD0ZgfzmVCpFkfB+8/7yt05fuMwCflIdkiLhodxA1mlu6wSm6mvbhCimfFkcR6K
	 TcVvisooQAuTdNa4ZAQv4WAcHRasgRS/s6uKf/8FmzkN5q9UeDqLhA1vsCIclhF4hj
	 V0uVv/hEkJ+3sUS6P3wumlJ7zhJZ3VH99aoszpayU/GhdiUsV6KrHHusV0CFgnPDvS
	 P9/ftgKsA/tJ120k6SJ+uqeEqRhZ3r9tQtScRNGdApUDQhW/A6ZAFqv/gOuCk6kn9a
	 Ykv9ioMymjmzy/THrEUDUuSSbY+4xf8iyVIii5G6aH3QITRK2l4TJfDr//ywYMwLVe
	 L6aOzTWylTVwA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 0/8] mm/damon: validate all parameters in the core
Date: Thu,  2 Jul 2026 14:05:42 -0700
Message-ID: <20260702210551.95167-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON has a number of parameters.  Some of the parameters are validated
by DAMON, while some are validated by DAMON API callers.  Each caller
has their own set of parameters that are exposed to users.  Hence each
caller has their own ways to do the validation.  There is no clear lines
for the responsibilities.  It is confusing and easy to make mistakes at
validations.  Actually we found a few bugs in the class.

Define DAMON core as the place to do all the validations and implement
those.  damon_set_regions(), damon_start() and damon_commit_ctx() are
the three main DAMON core API functions for setup of DAMON parameters.
Make the three functions to do safe and holistic parameter checks.  The
first one is already providing the validation, so changes are only for
the last two functions.

This might add unnecessary validations for some use cases.  The overhead
should be negligible as parameters update is expected to only rarely
happen.  It reduces the number of places to check and fix for bugs of
the class from all callers to the single component.  The maintenance
efficiency gain is obvious.

Further cleanup documents and caller code.  Make the lines of validation
duties clearer.  Remove validations that are no more needed owing to the
core validations.

Patches Sequence
================

Patch 1 implements the core holistic parameters validation for
damon_commit_ctx().  Patch 2 extends the validation to damon_start().
Patch 3 removes the duplicated holistic parameters validation in DAMON
sysfs interface, which is now embedded into the core layer.  Patches 4
and 5 remove duplicated min_region_sz validation in DAMON modules.
Patches 6 updates kernel doc to clarify damon_set_regions() is doing the
range validation.  Patches 7 and 8 remove monitoring target range
validations that doesn't necessary thanks to the validation in
damon_set_regions().

Note that the patch for providing the validation from
damon_set_regions() is separately posted as a hotfix [1] but not yet
picked into mm.git as of this writing.

[1] https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260701144815.113325-1-sj@kernel.org
- Fix wrong dst testing of damon_commit_ctx().
- Use fresh test_ctx for each ctx in damon_start().

SJ Park (8):
  mm/damon/core: safely validate src on damon_commit_ctx()
  mm/damon/core: do parameter testing commit on damon_start()
  mm/damon/sysfs: remove duplicated commit input validity check
  mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
  mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
  mm/damon: document region size validation in damon_set_regions()
  mm/damon/core: remove start, end check in
    damon_set_region_system_rams()
  mm/damon/sysfs: remove region size validation

 include/linux/damon.h |  3 +-
 mm/damon/core.c       | 78 ++++++++++++++++++++++++++++++++-----------
 mm/damon/lru_sort.c   |  5 ---
 mm/damon/reclaim.c    |  5 ---
 mm/damon/sysfs.c      | 35 +------------------
 5 files changed, 62 insertions(+), 64 deletions(-)


base-commit: 77d522544edf9183183689ea38f01d6c03098200
-- 
2.47.3
