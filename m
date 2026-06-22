Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565D3B47D6;
	Mon, 22 Jun 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138108; cv=none; b=fz8IHNvrFgFI4x2w3yqsrcDR+FmIJcrIxzay3twkrlBp7ArRFrMiFQvRX4Jw2540iwUFWtJM+/JS772r1FyTFExrH+trHkt54tYhtVlXmKJvCxH0nChaOocPW/lFs+qkkSIdZL+5hGGv5as3R0IS4IBl80NVqoMGvBqr2Q0YcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138108; c=relaxed/simple;
	bh=iIhu9887dhx+SJ0eMusAwK3CPQRNNJXPhXwuKWYjGfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0e6ioP8Bc53K4C2nSxm7XkQa1um/N0d7bvUhP3y5jm8oGpjEfM253ZYHjH89MQ9zLZ4fb1ZM3oGaL4Tz7ikd3LjDamU7umqujPRtVE/5gbT9jxvMoTifwA5VH1zWCFMhlZwSEkxdxxX4Zselv3A5kjpB/bJaY/Ehb0MOLq4fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5upGlO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5upGlO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55CA1F000E9;
	Mon, 22 Jun 2026 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138106;
	bh=ulp3AjMI7B4owCFSWbljnqEOw+fQMJireuqm4uU5XDA=;
	h=From:To:Cc:Subject:Date;
	b=f5upGlO7tDaw2xoj25Q0J6HRHLPKbqkTMUPQDH4FgG/FbyZTeze8a9YMz+D4OqDnB
	 8xf4fWEYEmNX4IiqH4yHZPl4G1Mzru9Eqmnf03K2ePUacbq4Wa7INIoebAI8vYoba+
	 DAeupamDMxxuR/rO3R2O064FMtTTcdy7tCJjfw+p6hRPHYWX+XSkHPmaBiD4OILXUY
	 NAgWjSG1aPqi/Z0NhR0urrhchDa64wjpL2SJbrjrrpTBEK/G44vgaavy9U4LZwu4WI
	 GWwKpPmS4/SPsqZikB4uB7VhnW3ZDP7HjvtPYIrzsEm8sDGDrs9MCiIT3DLdx7ui0I
	 BwdmvhSgoNg8Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v1.3 00/18] mm/damon: optimize out nr_accesses_bp
Date: Mon, 22 Jun 2026 07:21:20 -0700
Message-ID: <20260622142139.30269-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TLDR: Replace damon_region->nr_accesses_bp, which is easy to be wrong,
with a simpler on-demand moving sum function, damon_nr_accesses_mvsum().

Background
==========

DAMON's monitoring output (access pattern snapshot, or more technically
speaking, damon_region->nr_accesses) is completed once per aggregation
interval, which is 100 ms by default.  Users can arbitrarily increase
the interval for demand.  Under the suggested intervals auto-tuning
setup, it can span up to 200 seconds.  If the aggregation interval is
too long, the snapshot users cannot use it in reasonable time.  To
mitigate this, we introduced a new field of damon_region, namely
nr_accesses_bp.  It contains a pseudo moving sum of nr_accesses in bp
units and is updated for each sampling interval.

It turned out keeping it correctly updated every sampling interval is
not that easy.  From online parameter update feature development and
more experimental hacks, we found it is easy to be corrupted.  Once it
is corrupted, DAMON's monitoring outputs become quite insane.  Hence we
added a few validation checks.  It is easy  to be corrupted because it
requires every update per sampling interval to be correct.

Solution
========

There is no real reason to keep it updated every sampling interval.  Due
to the simple pseudo-moving sum mechanism and existing helper field
(last_nr_accesses), we can also calculate the pseudo moving sum on
demand in a much simpler way.

Implement a function for getting the pseudo moving sum on demand, and
replace nr_accessses_bp uses with the new function.  Also remove no more
needed tests for nr_accesses_bp and the per-sampling interval update
functions.  Finally, remove the nr_accesses_bp.  The new function is
quite simple.

Discussion
==========

Depending on the use case, multiple nr_accesses readers could be
executed in the same kdamond_fn() main loop iteration, which is executed
once per sampling interval.  Such readers include DAMON region exporting
tracepoints (damon_[region_]aggregated and damos_before_apply), DAMOS,
and DAMON sysfs interface logic for update_schemes_tried_regions
command.  In this case, the new function will be called multiple times
and this could be overhead compared to the old logic, which simply reads
the field without any additional work.  Nonetheless, the new function is
quite simple.  And the new approach does nothing while there is no need
to read.  The old approach had to execute its update function for each
region for every sampling interval.  Hence the new approach is believed
to be even more lightweight in common case, and the overhead is anyway
negligible.

One more advantage of this change is that one field from the
damon_region struct is removed.  On setups that uses a high number of
DAMON regions, this could be a potential memory space benefit.

Patches Sequence
================

Patch 1 introduces the new function for getting the pseudo moving sum of
nr_accesses on demands.  Patch 2 implements a unit test for the new
function's internal logic.  Patch 3 and 4 update monitoring logic and
the new function to ready for safe use on the existing logic.  Patches
5-7 replace uses of nr_accesses_bp in DAMOS, tracepoints and DAMON sysfs
interface with the new function, respectively.  Patches 8-10 removes
nr_accesses_bp validation functions in DAMON core, one by one.  Patches
11 and 12 further remove tests and test helper for nr_accesses_bp,
respectively.  Patches 13 removes the setups and updates or
nr_accesses_bp field.  Patches 14-16 cleans up function parameters that
are no more being used due to the previous patch.  Patch 17 removes the
function that was used for updating nr_accesses_bp field with its unit
test, which is the single remaining caller of the function.  Finally,
patch 18 removes damon_region->nr_accesses_bp field.

Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260621155715.87932-1-sj@kernel.org
- Explicitly ignore nr_accesses from mvsum at the beginning of
  aggregation.
- Fix a typo in a commit message.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260620172244.90953-1-sj@kernel.org
- Handle next_aggregation_sis < passed_sample_intervals in
  nr_accesses_mvsum().
- Always rescale ->last_nr_accesss for parameter changes.
- Remove unused attrs params from damon_update_region_access_rate() and
  its callers.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260619193415.73833-1-sj@kernel.org
- Avoid divide-by-zero from zero aggregation interval.
- Call damon_nr_accesses_mvsum() for damos tracing only when it is enabled.
- Remove obsolete mentions of nr_accesses_bp in comments.

SeongJae Park (18):
  mm/damon: introduce damon_nr_accesses_mvsum()
  mm/damon/tests/core-kunit: test damon_mvsum()
  mm/damon/core: always update ->last_nr_accesses for intervals change
  mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()
  mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
  mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
  mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
  mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
  mm/damon/core: remove damon_verify_reset_aggregated()
  mm/damon/core: remove damon_verify_merge_regions_of()
  mm/damon/tests/core-kunit: remove nr_accesses_bp setup and tests
  selftests/damon/drgn_dump_damon_status: do not dump nr_accesses_bp
  mm/damon/core: remove nr_accesses_bp setups and updates
  mm/damon/core: remove attrs param from
    damon_update_region_access_rate()
  mm/damonn/paddr: remove attrs param from __damon_pa_check_access()
  mm/damon/vaddr: remove attrs param from __damon_va_check_access()
  mm/damon/core: remove damon_moving_sum() and its unit test
  mm/damon: remove damon_region->nr_accesses_bp

 include/linux/damon.h                         |  15 +-
 include/trace/events/damon.h                  |   8 +-
 mm/damon/core.c                               | 201 +++++++-----------
 mm/damon/paddr.c                              |   9 +-
 mm/damon/sysfs-schemes.c                      |   6 +-
 mm/damon/tests/core-kunit.h                   |  37 ++--
 mm/damon/vaddr.c                              |  12 +-
 .../selftests/damon/drgn_dump_damon_status.py |   1 -
 8 files changed, 119 insertions(+), 170 deletions(-)


base-commit: e08d3bec1dc38cc991fc819afd698bf7bd07bd6d
-- 
2.47.3
