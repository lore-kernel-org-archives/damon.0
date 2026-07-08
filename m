Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFD1B87C9;
	Wed,  8 Jul 2026 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474379; cv=none; b=V1xA57G8/wzEnEhueCazgFeMIGoKOT+geOdnQBvgdOOUI+JC1yXN/AxpEpDR48mslGHRR6otg2L1mRNRkdc/g7TztOKoYFMHTt5MbfrIMGf+yKDW7qXigLmEaXw8sze2OdpEJrWVPOLthzc54P371b374KVo8gCd4cYST4tJ4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474379; c=relaxed/simple;
	bh=uWC2/XRT2s/j4pVkSnVy9yRl/wp4gWB4cZ5KhK7GQ3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHoijagnkc2Cy4q67rfPpG212+D49zr7Bh9MKDf36KwTWV/V/t84pMv8zcdvfQyBOjQA2KJa9i9j26yexL2+UV9kJel8vXV4ldpL0Ao+x0B5WbjJ4Yc48LWhnsYqn8azFA8cJrDl4uqjQcp4KCfNyZcIPwSVegj8//KgAGARGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEvBl7SB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEvBl7SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1EB1F000E9;
	Wed,  8 Jul 2026 01:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474377;
	bh=I8QrNb/C+cvH7yIXprKVZCOZdxfCmRYXj28pAZUqsXg=;
	h=From:To:Cc:Subject:Date;
	b=HEvBl7SBTjtN3xOHmo6QnCYsDOCSq0tUXKDtcYO+ampOiSjh2eZ9dmSbIVM8E8fcq
	 SLxs2t9uY1KTqpW/c8QT+D6YCmicgfJ/DAH4Wua1W/dRM6Kyrl9WR82hm4mNvkXin5
	 lKR+uz5tKc0535K4zVpZ53pC2VlRT+G7+IpSx7D5Jg3DPhhIUV0U0EzLvJt0VHUIb/
	 YdTa3jJ5pqvmcV+j7suaHWzwRCtoEXy/4wWTLGCWMIjfWHTa2j6pt0ZyG415KrhVr6
	 Eo7jZJyCRo//W+msBiuyD90ibtMFQMMv0OQz5EWeNsPZ3TYxl2cYaEW2mTECiRtbwB
	 Pzv9VOTn80cfw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 0/7] mm/damon: update probe hits for runtime parameter commits
Date: Tue,  7 Jul 2026 18:32:43 -0700
Message-ID: <20260708013252.95888-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON users can update DAMON parameters such as sampling and aggregation
intervals at runtime.  For such changes, monitoring results that depend
on the intervals should be properly updated for better accuracy.  For
example, the access frequency counter (nr_accesses) is updated.  The
data attribute monitoring counter (probe_hits) is not being updated,
though.  Do the updates for new parameters.

Patches Sequence
================

Patch 1 removes obsolete comments and test code for a function that this
series will touch.  Patches 2-5 rename functions that are being used for
nr_accesses update, to be able to be used for probe_hits without
confusion.  Patch 6 does the probe_hits update.  Patch 7 update
damon_probe_hits_mvsum() to cover a corner case from the update for
better accuracy.

Changelog
=========

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260707135038.90068-1-sj@kernel.org
- Remove obsolete divide-by-zero test with comments as a separate patch.
- Remove obsolete comment removal part in a rename commit message.
- Rename name-changed function parameters.
Changes from RFC
- RFC: https://lore.kernel.org/20260707043828.97900-1-sj@kernel.org
- Remove obsolete comment and code on the test.

SJ Park (7):
  mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero
  mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
  mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
  mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
  mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
  mm/damon/core: update probe hits for new parameter commit
  mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()

 include/linux/damon.h       | 10 +++---
 mm/damon/core.c             | 65 +++++++++++++++++++++++--------------
 mm/damon/lru_sort.c         |  2 +-
 mm/damon/ops-common.c       |  2 +-
 mm/damon/tests/core-kunit.h | 38 +++++++++++-----------
 5 files changed, 68 insertions(+), 49 deletions(-)


base-commit: 29da8f7d1b66215addd212b9b7191a203e322b8c
-- 
2.47.3
