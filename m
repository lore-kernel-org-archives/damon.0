Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93EE35E1A4;
	Fri, 19 Jun 2026 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897669; cv=none; b=Q5AGeKyJ1FdNNISlYUchXNVEDhuU/AkNvDK7U+5QCyIPkUrit2g0UvXdatpgsrB8MFlMHbAdJWT5hBzliR28OAHVCrem5/e9r54+3rR3lPLJyXQfmYFSWS062xvXKq4mWNB47S1ePzoL9ojHi+XFb8ihqPkZxijTFiLSYqEkPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897669; c=relaxed/simple;
	bh=di2CptIpoMQgZKS+XImDl3kLGyexInty4ph6W0cWoZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfI5HpfyRnSRJMjECF8neDnDZZRALhaHVywy6yPaDua6w5ZwtrCOpy/TguKMKmujmxrpoumotpQpMwVYWmM+Gl1b76A0hCxZLUMbtG71h3CgzB+nzslJgfaTzG0aw8aq15UgzyPDmPvKvr2A6NeTKyvysiFXs8YM7q7U+XksS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru/rrkCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru/rrkCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449A01F000E9;
	Fri, 19 Jun 2026 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897668;
	bh=nhBjiNpTVYOHJKwKBkORiEIV5livVqDkEf2uu8Hai5o=;
	h=From:To:Cc:Subject:Date;
	b=Ru/rrkCfT5gq968L1/RCUMS9wO2LVANCEZixdfQ7yXhZaZU1n1nywg7CKO6y66bgj
	 /pBTDjUjf31Cbn8d4q2dE1X1+disbJnizIxpX3ogV0eFCUvI6pY8YDvoHTk6PPJsS3
	 h7xk8iKNUJA+50C7sB3eIpP/Zp8wFMTl7Mipxyo1OOFuoY8SJRiUg3ykeJwjWjCH2Q
	 s121vLA3FXZtHSn2/S7/rdjyfmbQDkU7eeBOUdpY4AqcOhBuWTqwBUxO2dIaCI3O2B
	 fpFQ6rsWhu8z00e22Z6UssSUs/1aIMITG4V14xU3QXqXw00BA3y2xEqrdiuDIcVZ2l
	 Ir9hHJC4swZsg==
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
Subject: [RFC PATCH 00/13] mm/damon: optimize out nr_accesses_bp
Date: Fri, 19 Jun 2026 12:33:45 -0700
Message-ID: <20260619193415.73833-1-sj@kernel.org>
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
function's internal logic.  Patches 3-5 replace uses of nr_accesses_bp
in DAMOS, tracepoints and DAMON sysfs interface with the new function,
respectively.  Patches 6-8 removes nr_accesses_bp validation functions
in DAMON core, one by one.  Patches 9 and 10 further remove tests and
test helper for nr_accesses_bp, respectively. Patches 11 removes the
setups and updates or nr_accesses_bp field.  Patch 12 removes the
function that was used for updating nr_accesses_bp field with its unit
test, which is the single remaining caller of the function.  Finally,
patch 13 removes damon_region->nr_accesses_bp field.

SeongJae Park (13):
  mm/damon: introduce damon_nr_accesses_mvsum()
  mm/damon/tests/core-kunit: test damon_mvsum()
  mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
  mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing
  mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
  mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
  mm/damon/core: remove damon_verify_reset_aggregated()
  mm/damon/core: remove damon_verify_merge_regions_of()
  mm/damon/tests/core-kunit: remove nr_accesses_bp setup and tests
  selftests/damon/drgn_dump_damon_status: do not dump nr_accesses_bp
  mm/damon/core: remove nr_accesses_bp setups and updates
  mm/damon/core: remove damon_moving_sum() and its unit test
  mm/damon: remove damon_region->nr_accesses_bp

 include/linux/damon.h                         |  12 +-
 include/trace/events/damon.h                  |   8 +-
 mm/damon/core.c                               | 171 +++++++-----------
 mm/damon/sysfs-schemes.c                      |   6 +-
 mm/damon/tests/core-kunit.h                   |  37 ++--
 .../selftests/damon/drgn_dump_damon_status.py |   1 -
 6 files changed, 91 insertions(+), 144 deletions(-)


base-commit: 6c6dd09066e98c4afcf61f404d5b2b87f35e3321
-- 
2.47.3
