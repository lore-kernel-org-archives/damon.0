Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169982E3FE;
	Wed,  8 Jul 2026 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478945; cv=none; b=rHF3N/C1Ov97PWI+MMqjBHR+TFm+vwaqMccziRWKW5vgSw121QZTHEL7Rgsb870RzAiKnmg3wk0TB+ZBF/VLY1g9YF4SPDMX6Ehrr2gGISosxBL1qSuo+UyTJrCb09RxJzsAH/Vw4wDgtrtl9dyc1CeXnSIyRk6PqkdmjY51OsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478945; c=relaxed/simple;
	bh=sgL2Aa1Ut1WIqjUhuCKIehLwabS0lIChHnDoYz1sayw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1zlyqjSQSVTjlsdlalXnUrwLlgnIAsvccB4MstSH8wV5Y/2pmHrbh8A9rZ41LHg6JJsdvsPdgGw22bUWbK0O8Vn3YCGSBabTfCkK3kpc0BkVncAm30g7qIdn6odT3baUCDcSm6HKJMp83mGb5fNpqGUNf+XGF1mOO9oI7b1jHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlhsMs58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlhsMs58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89161F000E9;
	Wed,  8 Jul 2026 02:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478943;
	bh=di2Omsb6NMSBZD8DrcCMzDSvay2hwhtM+GShb46YMM4=;
	h=From:To:Cc:Subject:Date;
	b=VlhsMs586PSqacvNLg428TgMSP6y4/CI4k8TvlFlIt64T7yh+w27xIsoGGsHPKbiO
	 GIjIj5bC9YBipEtZJvymGljqPNj9iHgcqdYSg8HI4c2IURQrHhtZS2f/8TcwaqfTGb
	 uh2zt7h+Q5KtbkyPypyRyZ2aT4IX+WUBwaf2l+XfFNBK0mBcB00UIg7mcV1ba4uAfH
	 sTUr2cMNrffJPwW6Ho+My2EaXoU3xmNx8JEN7ecWTee/TQ30eXjcDCaL++ZGhDJ0IZ
	 V4KJd46nV6kaMKoj19tnk9AsiQhXskgxy9rpL8B0UhG3FYzApwfhaEnkoi4Ushrivc
	 Cm5/HMWG36vfg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 0/7] mm/damon: update probe hits for runtime parameter commits
Date: Tue,  7 Jul 2026 19:48:46 -0700
Message-ID: <20260708024855.116614-1-sj@kernel.org>
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


base-commit: 82154b14568e9b7abebe2fc9240eafd031e01b30
-- 
2.47.3
