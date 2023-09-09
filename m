Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DF15B4
	for <damon@lists.linux.dev>; Sat,  9 Sep 2023 03:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EC0C433C8;
	Sat,  9 Sep 2023 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694230644;
	bh=LIdwZZs4OlFQUm7n2Pdv3lOWj7cVGyn8OJFVzIV68m4=;
	h=From:To:Cc:Subject:Date:From;
	b=M217PYuf/bogc6R0vAiF1bc6bzDfX7fBWV8BUUZIgvFS2WdG2nAz13yIdyZBxH6Zn
	 sDHTIBYWe2sFLGXzw9XTHq07+SW+W1Pp4kZGB57RnI/f5fFhFdfj0LH4w/sjm02n0f
	 qxPax/8dCCDs29wze4VUlS9dzaQJ50F5Pt3rvMNkmEtRI2TCzMy/ICtYaly3e/qt29
	 d8v2mXzHReXp+F5NF5xqipvczSsxweLePWAnEbPj/sRUfHu981VgU1gxYxWyIPQNSk
	 4GbDnApHjrnqvCLEvZnd45Y3J7FCAWAoJ0f2WbU4EXOMBqfj9cImDNSXQE6piOBdIk
	 DarmMoUr0tDzQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/8] mm/damon: provide pseudo-moving sum based access rate
Date: Sat,  9 Sep 2023 03:37:03 +0000
Message-Id: <20230909033711.55794-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON checks the access to each region for every sampling interval, increase
the counter of the region, namely nr_accesses if the access was made, and reset
the counter for every aggregation interval.  The counter is exposed to users to
be used as a metric showing the access rate (frequency) of each region.  In
other words, DAMON provides access rate of each region in every aggregation
interval.  The aggregation avoids temporal access pattern changes make things
confusing.  However, this also makes many DAMON-based operations to need to be
aligned to the aggregation interval.  This can restrict the flexibility and
speed of DAMON applications, especially when the aggregation interval is huge.

To provide the monitoring results in finer-grained timing with handling of
temporal access pattern change, this patchset implements a pseudo-moving sum
based access rate metric.  It is pseudo-moving sum because strict moving sum
implementation would need to keep every last time window values, and that could
incur high overhead.  Especially in case of the nr_accesses, since the sampling
interval and aggregation interval can arbitrarily set and the past values
should be maintained for every region, it could be risky.  The pseudo-moving
sum assumes there were no temporal access pattern change in last discrete time
window to remove the needs for keeping the list of the last time window values.
As a result, it beocmes not strict moving sum implementation, but provides a
reasonable accuracy.

Also, it keeps a property of the moving sum.  That is, the moving sum becomes
same to discrete-window based sum at the time that aligns to the time window.
Hence, using the pseudo moving sum based nr_accesses makes no change to users
who collect the value for every aggregation interval.

SeongJae Park (8):
  mm/damon/core: define and use a dedicated function for region access
    rate update
  mm/damon/vaddr: call damon_update_region_access_rate() always
  mm/damon/core: implement a pseudo-moving sum function
  mm/damon/core-test: add a unit test for damon_moving_sum()
  mm/damon/core: introduce nr_accesses_bp
  mm/damon/core: use pseudo-moving sum for nr_accesses_bp
  mm/damon/core: skip updating nr_accesses_bp for each aggregation
    interval
  mm/damon/core: mark damon_moving_sum() as a static function

 include/linux/damon.h | 16 +++++++++-
 mm/damon/core-test.h  | 21 ++++++++++++
 mm/damon/core.c       | 74 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/paddr.c      | 11 +++----
 mm/damon/vaddr.c      | 22 +++++++------
 5 files changed, 128 insertions(+), 16 deletions(-)


base-commit: 85bb49ddd3983b85ab98ad50a69ca1c7380fc63a
-- 
2.25.1

