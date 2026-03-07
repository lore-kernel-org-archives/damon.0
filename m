Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3231A807;
	Sat,  7 Mar 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912963; cv=none; b=tUoAkICSeKS6Dp94h6emQ1azvkyr1JRCU+zEQovBRrzaoW2rS0LVBpNGi4vfpcnRNK+e7OILP6PLAHCvYcW4b64iHUpkEC1pr4TsFU5iPOVqbtPNFNU56YEawykgR/2h3X6dvkWk8KZjVCJ6x9fkJAb5y3Vcx6CBO7JimbUIf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912963; c=relaxed/simple;
	bh=9pXTMLXjPeeFkiBWY7aejojzZtQ8QdVsGRxu/ihcY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7aj4OT8xuzRM/ExYhpkso7JcmR+pgwjuWGUCihW0PNS6yIIDTzBmTPL6yosr5m3xC9GQBqiThG/UyMjcL38w8+AcAaijQ8ZDJAW3XqOehBEsiEGgPZv2jwXsKcNK6nZnpQRNv0wPiOWULNKSPC19THtTgScDlRnesmYJTjFApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJLaaKcq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJLaaKcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB6FC19422;
	Sat,  7 Mar 2026 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772912962;
	bh=9pXTMLXjPeeFkiBWY7aejojzZtQ8QdVsGRxu/ihcY/A=;
	h=From:To:Cc:Subject:Date:From;
	b=mJLaaKcqz3I+ylDK18HnDKnTzi8E8VRfiEqPevc//dx16NYIyrYSuLrpEknUCR97q
	 /l1qu964FXZyddPds7Hio28N7Hrz2xf74z8hA6sQt9kpiQMuwz0cKPbpkZwgqf0r1k
	 88Emmeal2z2CL+rosZ0+pn2kDbiee8xvmw9FBZWmTrv/1dASoTYz5MSmIpgpursKSN
	 sX+/OZ67VXMh26RerPVQ6tlsCzRbAVr4BLAtMTAWNSZTGOyCC+owue+7VlCtTS2SIU
	 G1SCP1FTBTwkCp2/7wjEGquAFT1aYRBZTt0I5z12TE3/BLj1vAGkqO0SFRMnzXnd4R
	 543Ua6chf5stA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon/core: make passed_sample_intervals comparisons overflow-safe
Date: Sat,  7 Mar 2026 11:49:11 -0800
Message-ID: <20260307194915.203169-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON accounts time using its own jiffies-like time counter, namely
damon_ctx->passed_sample_intervals.  The counter is incremented on each
iteration of kdamond_fn() main loop, which sleeps at least one sample
interval.  Hence the name is like that.

DAMON has time-periodic operations including monitoring results
aggregation and DAMOS action application.  DAMON sets the next time to
do each of such operations in the passed_sample_intervals unit.  And it
does the operation when the counter becomes the same to or larger than
the pre-set values, and update the next time for the operation.  Note
that the operation is done not only when the values exactly match but
also when the time is passed, because the values can be updated for
online-committed DAMON parameters.

The counter is 'unsigned long' type, and the comparison is done using
normal comparison operators.  It is not safe from overflows.  This can
cause rare and limited but odd situations.

Let's suppose there is an operation that should be executed every 20
sampling intervals, and the passed_sample_intervals value for next
execution of the operation is ULONG_MAX - 3.  Once the
passed_sample_intervals reaches ULONG_MAX - 3, the operation will be
executed, and the next time value for doing the operation becomes 17
(ULONG_MAX - 3 + 20), since overflow happens.  In the next iteration of
the kdamond_fn() main loop, passed_sample_intervals is larger than the
next operation time value, so the operation will be executed again.  It
will continue executing the operation for each iteration, until the
passed_sample_intervals also overflows.

Note that this will not be common and problematic in the real world.
The sampling interval, which takes for each passed_sample_intervals
increment, is 5 ms by default.  And it is usually [auto-]tuned for
hundreds of milliseconds.  That means it takes about 248 days or 4,971
days to have the overflow on 32 bit machines when the sampling interval
is 5 ms and 100 ms, respectively (1<<32 * sampling_interval_in_seconds /
3600 / 24).  On 64 bit machines, the numbers become 2924712086.77536 and
58494241735.5072 years.  So the real user impact is negligible.  But
still this is better to be fixed as long as the fix is simple and
efficient.

Fix this by simply replacing the overflow-unsafe native comparison
operators with the existing overflow-safe time comparison helpers.

The first patch only cleans up the next DAMOS action application time
setup for consistency and reduced code.  The second and the third
patches update DAMOS action application time setup and rest,
respectively.

SeongJae Park (3):
  mm/damon/core: remove damos_set_next_apply_sis() duplicates
  mm/damon/core: use time_before() for next_apply_sis
  mm/damon/core: use time_after_eq() in kdamond_fn()

 mm/damon/core.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)


base-commit: 4ef41fd88e37fcdc1751edd9bc57403dba2742a3
-- 
2.47.3
