Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE93EBF22;
	Sat, 21 Feb 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697032; cv=none; b=DaUORgtsGyJdsPcG6eKZMfBpcGTNIOt5oUONoVhtICMXfiZ4MPfPsrNIhFLMyxsyF0nVQdzNi9Di4ZPDxDbbAh67bfVIyxaSP3LfpR3H4A0CcthVUx1pJrTcFVYPYVIYhQhH43z8eJWJ2jYMUYG60/n0LQIIVnh7SNx6GtcNbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697032; c=relaxed/simple;
	bh=3nAKOmdR4WaTdsGiJ79MmmJcYTDbSE8Pmqh31ykwIqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UA/PbyXSN5U6hQHUb/bOrphbvf6m+kLKqhZBYv8hvMfg29AoCfSZTmAVXmC5KwKG0YVvxEASqZe40ELaZBVcRJZEMsMXNBZs+M/YHdYaxj6U2q95U2ykNh5pwoNshtMXHXrjo/IvnLQHgW4XFvGS7K7AgMQGJK3nBq++coL4kV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGsr1+A2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGsr1+A2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354D1C4CEF7;
	Sat, 21 Feb 2026 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771697031;
	bh=3nAKOmdR4WaTdsGiJ79MmmJcYTDbSE8Pmqh31ykwIqc=;
	h=From:To:Cc:Subject:Date:From;
	b=pGsr1+A2KVrG7oeQlbTQObGcxOALqByMYG1qdanVHwYfRVlbz+XNQXlji+DKwlZoU
	 WGFY2Qwt5S8TullKEXw7c+rt3mtxGK3NYIAtHsn2KuPMpZ/XMGx6sO4rtlsMN2vZky
	 SWMYGVtR1PpDNTWqFrlZrO55Nufr6kSqsAhMb3hYgRPY1qjc/e95xBefIObA5uwsYS
	 oMEOWddRCiBK6p13e0BoaCs3meee6K1aYR6DOtrldcUNSYbavhwNqoEWAND5xQQ31c
	 pioZBj0xr7snUdxdePm9nPI/9Akjnbyo5qX144XGQdukGQXrerqrTJkg4mPqhcyquD
	 0H9SrFg2rs1sw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/3] mm/damon: strictly respect min_nr_regions
Date: Sat, 21 Feb 2026 10:03:37 -0800
Message-ID: <20260221180341.10313-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core respects min_nr_regions only at merge operation.  DAMON API
callers are therefore responsible to respect or ignore that.  Only vaddr
ops is respecting that, but only for initial start time.  DAMON sysfs
interface allows users to setup the initial regions that DAMON core also
respects.  But, again, it works for only the initial time.  Users
setting the regions for min_nr_regions can be difficult and inefficient,
when the min_nr_regions value is high.  There was actually a report [1]
from a user.  The use case was page granular access monitoring with a
large aggregation interval.

Make the following three changes for resolving the issue.  First (patch
1), make DAMON core split regions at the beginning and every aggregation
interval, to respect the min_nr_regions.  Second (patch 2), drop the
vaddr's split operations and related code that are no more needed.
Third (patch 3), add a kunit test for the newly introduced function.

Changes from RFC v1
(https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org)
- Split regions every aggregation interval

[1] https://lore.kernel.org/CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com

SeongJae Park (3):
  mm/damon/core: split regions for min_nr_regions
  mm/damon/vaddr: do not split regions for min_nr_regions
  mm/damon/test/core-kunit: add damon_apply_min_nr_regions() test

 mm/damon/core.c              | 45 ++++++++++++++++++---
 mm/damon/tests/core-kunit.h  | 52 ++++++++++++++++++++++++
 mm/damon/tests/vaddr-kunit.h | 76 ------------------------------------
 mm/damon/vaddr.c             | 70 +--------------------------------
 4 files changed, 93 insertions(+), 150 deletions(-)


base-commit: de85cadcf3a95954743146e39ffacc58d2355184
-- 
2.47.3
