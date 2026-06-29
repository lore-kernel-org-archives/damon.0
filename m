Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79B4218B2;
	Mon, 29 Jun 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745003; cv=none; b=ZGXeSV9B1DfVNKiL23cwdS0MoF420P14GysxhkkPgVebaxTmp2x1MIgMJiG+03rQaI0uADJq5y9KPjFf6xByo5DUXw6y7SOXyMsxVaW68ujO7odc7AJe8wx72NprJrPBsgwcFdoQjS+67xjf0XhsHE5yXga5OGhJA0Q69qYtvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745003; c=relaxed/simple;
	bh=J1SN97frnM0cvePHU+aIOz6O82hGuKWE7VcRFGEPkSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foeCxflDp7QUKcIa97M33Mhj6Q7waI+dmIl2o5SGKdkvvh3Q38n8U2Gb8BTiJbhMZjILge8O4QjkoEB+PD898cfGV8c7HKMiISKxP/yWVNw8cKq0ZlEeYsUwW2VzCpcgdCUcs8iYFzsDLRjLa7gCGU92H86yAvpCQXkPE/j1Qqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU/k2Zti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU/k2Zti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666941F00A3F;
	Mon, 29 Jun 2026 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744998;
	bh=UzWU4Me4IIb1YZ7xC+da7RUfQPj8e+Q+gI/W5LlD530=;
	h=From:To:Cc:Subject:Date;
	b=eU/k2ZtiggJzLKB6N/h3ekSHuXEFvvxTuHsNUCvt3BMkKk34KwIqJyXFjA2cxdjFM
	 08yP2tYQM7ByK4lzFUmUQzVEUpSoqHh+Mttcr5hxyk1899yibNC7OHdq9oHJ/7aXcS
	 065uWXUqfgwULYoaXHSPuMF08GEV83YlaR9uF3SvrHb2zKv8U27CiYiTpFtY7vsLum
	 8yo6sJAj92rzTYuTjWlCjDSzQS/BDsjhKLe0GXz5yFqOsoMYLhYLizQZXFzw0+0a3i
	 dNRaHs+ZyR+D7PwOzmqIhD8TFly4EL49TkqW0vQSJOx3/0l4IOea16f9fyDJC6nNzb
	 EAkspDiPbx5Rw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shu Anzai <shu17az@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/2] mm/damon/core: detect internal variation above max_nr_regions/2
Date: Mon, 29 Jun 2026 07:56:27 -0700
Message-ID: <20260629145630.134891-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_split_regions() bails out early when nr_regions is already
above max_nr_regions / 2.  A large region that picks up new internal
variation after that point never gets split, so we lose visibility
into its hot/cold structure.

We hit this with damon-paddr on hugepage workloads and damon-vaddr
on processes that mmap a large anonymous range.

Example with max_nr_regions == 1500.  A target ends up with 799
small hot/cold regions plus one big region (an earlier merge
collapsed a uniformly-accessed range into a single piece):

H:hot
C:cold

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|

    nr_regions = 800  >  max_nr_regions / 2 = 750

Now a cold subarea shows up inside r800:

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|

The small regions can't merge with each other (their access counts
differ), so budget never frees up.  r800 can't be split because
nr_regions > max_nr_regions / 2 returns early.  The cold subarea
stays invisible.

Patch 1 keeps refining on this path: when nr_regions is above
max_nr_regions / 2 but still under the maximum, it splits a fraction
of the regions instead of returning.  The fraction shrinks as the
remaining budget shrinks, so the count approaches max_nr_regions
smoothly.  A useless split is undone by the next merge cycle.

Patch 2 adds a KUnit test for the case where nr_regions is already
above max_nr_regions / 2.

Thanks to SJ for the suggestion to drive the split fraction
from the remaining budget rather than an age-based filter.

Changes from v2
- v2: https://lore.kernel.org/20260626085851.70754-1-jiayuan.chen@linux.dev
- Collect R-b: from SJ.
- Rebase to latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/damon/20260521045236.115749-1-jiayuan.chen@linux.dev/
- Some feedback from SJ.

Jiayuan Chen (2):
  mm/damon/core: split a fraction of regions when nr_regions exceeds
    max/2
  mm/damon/tests/core-kunit: test split above max_nr_regions/2

 mm/damon/core.c             | 49 +++++++++++++++++++++++++---
 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 5 deletions(-)


base-commit: 86100fb7e27ebb5da22fc8a2810eebcf8cc897e8
-- 
2.47.3
