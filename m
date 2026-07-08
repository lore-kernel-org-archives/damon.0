Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489839B4BF;
	Wed,  8 Jul 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518852; cv=none; b=HALwmuz3GOIHXL5ZbXw5+Y3T20mNuG0Sa/7boafnlm0v1R3SK61x4mnUBG8TdlB2FJLjIxCsq9rf/uJGSdaJo8PJyXFHIry1SNNOWlpWuea4llKLWgfsd0R+N6Sxy3lvqcUl3p0Y8eODSOJG4gMFht+clQwNRVF88QpmKQWqtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518852; c=relaxed/simple;
	bh=lQKtRYYYjAXpZ317IT2Gc7xYXd+dhXvpxBnyGnY4a5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0zAXbhEtKNuwz/LWQwfeC1EcIw8vV8bqOYYUYogTjob8XTCQDTRTb7go/sbIL34kViZrOb6Gvzq19KXjcCXnCJUbmw/ZZZpZh4NCchfnId+9JYLepYsocdjae45FfmiaBFkAKq05HbTKpwoEtTkUXHofAES4ML2ljyh+VqO2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C48wGeCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C48wGeCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9511F000E9;
	Wed,  8 Jul 2026 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518844;
	bh=N6Tlg2IQM8d13Ck3KqSkeF7axKX2g7LhiH2fFY9f8WU=;
	h=From:To:Cc:Subject:Date;
	b=C48wGeCLLHcpuS6xlOQG8PQmgxpDZHTopJ7fnpskUpFsK56TXm8zxZZuCfjlGRX5o
	 KukCWuEpO/aQUFgoLtD3YEaicj9ljr+bmHrg87ZaC0J5gqiIW+xGM6CQQBwwNCtXa1
	 QKIYlJC0EbIFFl840TJJOa0MY2jEh+uXxRIc1A9/bqcQYv2ZWPIWbDml1kQX4gtu9l
	 7ozEzelFj93HbJyJV0Ja28fod+VfPTE5gb46vA7HUpnbrNzv9u6mFqmdv0ZzuoNDlf
	 2WRKoJBDBRB8HrZiTNN4oQ8cbryrmL6Ci53nS1jsB5051d2oFUZRXZROTrfbDedb81
	 6bI9Nw/OArrFw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] mm/damon: update probe hits for runtime parameter commits
Date: Wed,  8 Jul 2026 06:53:50 -0700
Message-ID: <20260708135359.122587-1-sj@kernel.org>
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

Changes from RFC v1.3
- RFC v1.3: https://lore.kernel.org/20260708024855.116614-1-sj@kernel.org
- Drop RFC tag.
Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260708013252.95888-1-sj@kernel.org
- Fix rebase failure-caused kunit break in patch 1.
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
 mm/damon/tests/core-kunit.h | 36 ++++++--------------
 5 files changed, 59 insertions(+), 56 deletions(-)


base-commit: aa8ba979c42a7bf2d344a0f3b192c4dc61000096
-- 
2.47.3
