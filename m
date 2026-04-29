Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935533A702;
	Wed, 29 Apr 2026 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435957; cv=none; b=dqm837Nve+C6QuhVRDrSEJz13ae0fxH45Qg++xZ6Ixljljb5L6xnaQEkt1erFSEjJSVxFmDbEeHlcPPcFd90FEqyNiA0lVBdwYoa5YBhAGPDg41NnRYaGBWOOSK9Ey+fuvmjl3T/ut1nvg+6XnNmku3O7gwcvkzHl4CCV096Ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435957; c=relaxed/simple;
	bh=RCIYZP1Msb2RTI2SpfpPltIJeD6RApU3Y40MYAqfhiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SL+qWfNK4u08kt1PM0xRpwtbkr6f98QBinOt8KYUDGO/0D4uUQiVt9b7EfnrXVEYr7UimzFtc1uJvdQD95mDlPYKIkHzkILesdrwr52DCRCBHTOgXEmMna0hhm//z6aMbjlmyuoxB5cyxEDqk95rmtBwAjYH0DrzayRVQxSfk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4YNR7uD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4YNR7uD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CB0C19425;
	Wed, 29 Apr 2026 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435957;
	bh=RCIYZP1Msb2RTI2SpfpPltIJeD6RApU3Y40MYAqfhiI=;
	h=From:To:Cc:Subject:Date:From;
	b=R4YNR7uDsz9ma88wFhsLog/autlmAYCp9r4i/R/c6j8wSh28uod14qZe7792jWfi8
	 4IP7GzXzZcORJ0kJhktIv98nrGV6asZpmyuJ6WPF68fyMzKTLjMmYC9SRS8MWB7qZf
	 9xJuWjKgmlCR49qXkFFIeC7CsUKsUN9HzoJG4x1EvJrnhRVS9qvd4ekDqBc6yAGi6B
	 0+KzQA3KwSW+dV9nLXG6Ux9Fti4WvBfLVNJHid7+/N5aWmqch92y5rm3gLYVatpN+/
	 gkVzjyITojlmDehfgwYIDLyXD+7XE5ILvmBWGKorDuyWIvJ8SK5AwJHgoHv2bokLzg
	 v8e+74YDPAT8A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] mm/damon/reclaim,lru_sort: monitor all system rams by default
Date: Tue, 28 Apr 2026 21:12:22 -0700
Message-ID: <20260429041232.90257-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM and DAMON_LRU_SORT set the biggest 'System RAM' resource
of the system as the default monitoring target address range.  The main
intention behind the design is to minimize the overhead coming from
monitoring of non-System RAM areas.

This could result in an odd setup when there are multiple discrete
System RAMs of considerable sizes.  For example, there are System RAMs
each having 500 GiB size.  In this case, only the first 500 GiB will be
set as the monitoring region by default.  This is particularly common on
NUMA systems.  Hence the modules allow users to set the monitoring
target address range using the module parameters if the default setup
doesn't work for them.  In other words, the current design trades ease
of setup for lower overhead.

However, because DAMON utilizes the sampling based access check and the
adaptive regions adjustment mechanisms, the overhead from the monitoring
of non-System RAM areas should be negligible in most setups.  Meanwhile,
the setup complexity is causing real headaches for users who need to run
those modules on various types of systems.  That is, the current
tradeoff is not a good deal.

Set the physical address range that can cover all System RAM areas of
the system as the default monitoring regions for DAMON_RECLAIM and
DAMON_LRU_SORT.

Technically speaking, this is changing documented behavior.  However, it
makes no sense to believe there is a real use case that really depends
on the old weird default behavior.  If the old default behavior was
working for them in the reasonable way, this change will only add a
negligible amount of monitoring overhead.  If it didn't work, the users
may already be using manual monitoring regions setup, and they will not
be affected by this change.

Patches Sequence
================

Patch 1 introduces a new core function that will be used for the new
default monitoring target region setup.  Patch 2 and 3 update
DAMON_RECLAIM and DAMON_LRU_SORT to use the new function instead of the
old one, respectively.  Patch 4 removes the old core function that was
replaced by the new one, as there is no more user of it.  Patch 5
updates DAMON_STAT to use the new one instead of its in-house
nearly-duplicate self implementation of the functionality.  Finally
patches 6 and 7 update the DAMON_RECLAIM and DAMON_LRU_SORT user
documentation for the new behaviors, respectively.

Changes from RFC
- rfc: https://lore.kernel.org/20260415012048.76508-1-sj@kernel.org
- Fix typos: s/phiscal/physical/

SeongJae Park (7):
  mm/damon: introduce damon_set_region_system_rams_default()
  mm/damon/reclaim: cover all system rams
  mm/damon/lru_sort: cover all system rams
  mm/damon/core: remove damon_set_region_biggest_system_ram_default()
  mm/damon/stat: use damon_set_region_system_rams_default()
  Docs/admin-guide/mm/damon/reclaim: update for entire memory monitoring
  Docs/admin-guide/mm/damon/lru_sort: update for entire memory
    monitoring

 .../admin-guide/mm/damon/lru_sort.rst         |  6 ++-
 .../admin-guide/mm/damon/reclaim.rst          |  6 ++-
 include/linux/damon.h                         |  2 +-
 mm/damon/core.c                               | 49 +++++++++--------
 mm/damon/lru_sort.c                           |  8 +--
 mm/damon/reclaim.c                            | 14 ++---
 mm/damon/stat.c                               | 53 ++-----------------
 7 files changed, 50 insertions(+), 88 deletions(-)


base-commit: 01b1d4a72970ced030ffe246ba99c961c746527d
-- 
2.47.3
