Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC907414DCD;
	Tue,  7 Jul 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432245; cv=none; b=bQj+79uNADPxQoI0F5gLaklPrUko0xTJy0Ew+W/iqpStG+cqacWxVFRnOvnDAgs0Q3VLV1D1tfWM4p4OKKUkWZnzVF3/4N252sV267U+v9rK9SOa0A51dEnSyY9U6nV37FU60UKWoAm0Qe97uQGQAbMA7ta6AWKrtepPHvDQOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432245; c=relaxed/simple;
	bh=lQxZ0z3G7KDPKkDuIrrKONEH6L3/pJ05B2wxBKb8GAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azfUw2GcFDDVDJIEstfAn/BXM6x8wo40Oy4rHT1FDYHC/wArQl5LvOzrs4A8BTXSV8Aw4OcdlxpgqgbroHrEdXmJqdfv+tzKQF3p8TUneyUnF6dTDfOy/bPiWFEdL8J0yJN5/grcoTlIm+oqMxJxhYYIV5HkGal14IBIj/XSte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2jxb3uA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2jxb3uA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1FB1F00A3A;
	Tue,  7 Jul 2026 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432241;
	bh=nr7LiDJycW7rOXIUJ0Nv9/D3v/lvB0yYNIb1OxPaUcw=;
	h=From:To:Cc:Subject:Date;
	b=L2jxb3uAGdDvzvWsmN5zCrK1xnY0X6efwdUSRFvER7tfHfXesBy7pwDqu/Xi4xSRs
	 WdQ0R3V8e532UpspMPX0zLEnU3xXmppIB+tTn/G3/NDkQ5OV97E8GBc4SLaLA+Rk17
	 3l8EVZDPrhfwPl02R0dhSMuFcrnCjTTJIQPKyZud57BO9SLrP+m+KFE8MwREwuj5sw
	 qWIG265hwlFPaNkLVXHvWyN44Og+5bqjL/bo/WynFvJa3ciFzLa+HVOymtojG9sWDT
	 hMCumww3KCzwdSqeYbgVZxIZiCcJmmEbZ1ttQJ7G/lDRCYKWDjZtKZp5KhO5uzt5Qj
	 tkgGlIs9W9IRA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 0/7] mm/damon: update probe hits for runtime parameter commits
Date: Tue,  7 Jul 2026 06:50:29 -0700
Message-ID: <20260707135038.90068-1-sj@kernel.org>
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

Patch 1 removes obsolete comments and test code on a function that this
series will touch.  Patches 2-5 rename functions that are being used for
nr_accesses update, to be able to be used for probe_hits without
confusion.  Patch 6 does the probe_hits update.  Patch 7 update
damon_probe_hits_mvsum() to cover a corner case from the update for
better accuracy.

Changelog
=========

Changes from RFC
- RFC: https://lore.kernel.org/20260707043828.97900-1-sj@kernel.org
- Remove obsolete comment and code on the test.

SJ Park (7):
  mm/damon/core: remove obsolete comment for nr_to_bp() divide-by-zero
  mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
  mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
  mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
  mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
  mm/damon/core: update probe hits for new parameter commit
  mm/damon/core: handle unreset probe_hits in probe_hits_mvsum()

 include/linux/damon.h       | 10 +++---
 mm/damon/core.c             | 64 ++++++++++++++++++++++++-------------
 mm/damon/lru_sort.c         |  2 +-
 mm/damon/ops-common.c       |  2 +-
 mm/damon/tests/core-kunit.h | 31 ++++++++----------
 5 files changed, 62 insertions(+), 47 deletions(-)


base-commit: 86f45ad9d6667f344421729eec5a9367e37bfc5b
-- 
2.47.3
