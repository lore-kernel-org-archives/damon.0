Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043327E
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 00:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0B0C433C1;
	Wed, 19 Oct 2022 00:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666138402;
	bh=dpOBk5cVjdXzz1IhM8jwMTCjeK/vMf8lWOrAu4uF1nI=;
	h=From:To:Cc:Subject:Date:From;
	b=AMx1r4qTE/UyPgLZgfR5w8EvSMa0cCZcRacr+T37GLPlvpDnrsV5EV9anW1tduwEz
	 E6qFwNNegxjwQfGq52tzTQEUHmCJmMXqBgslB+xe2jyWfYYx3alV7HZOhemXyeDxxe
	 mWa9vG4ErR4W5SQunrbc/Dv3iz7DUuoqAbErw+08cKG3Bzmt/Ni3FRsH47s4pNBxnH
	 pvthyGj5RJV4PpHP3r3fSx/0rOZKHXYNUmdIfGoJRg+haHcBvQNzpLj9Esi4wQXLer
	 zT1o6Sp/8DsxgnftipgRl55GRnS6LFt2QkVAvSmDPGrszWcGiuz5e9TlxgEExCzrVf
	 DGpbnHIXrQ4ug==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/18] efficiently expose damos action tried regions information
Date: Wed, 19 Oct 2022 00:12:59 +0000
Message-Id: <20221019001317.104270-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON users can retrieve the monitoring results via 'after_aggregation'
callbacks if the user is using the kernel API, or 'damon_aggregated'
tracepoint if the user is in the user space.  Those are useful if full
monitoring results are necessary.  However, if the user has interest in
only some regions having specific access pattern, the interfaces could
be inefficient.  For example, some DAMOS users might want to know
exactly what regions were identified as fulfilling the access pattern of
the scheme, for a debugging or a tuning.

This patchset implements DAMON kernel API callbacks and sysfs directory
for efficient exposure of the information.  The new callback will be
called for each region before specific DAMOS action is gonna tried to be
applied.  The sysfs directory will be called 'tried_regions' and placed
under each scheme sysfs directory.  User can write a special keyworkd,
'update_schemes_regions' to the 'state' file of a kdamond sysfs
directory.  Then, DAMON sysfs interface will fill the directory with the
information of regions that corresponding scheme action was tried to be
applied for one aggregation interval.

Patches Sequence
----------------

First five patches (1-5) clean up and refactor code that following patch
will touch, and the following one (patch 6) implements the DAMON
callback for DAMON kernel API users.

Following six patches (7-12) clean up and refactor the sysfs interface
before the new sysfs directory introduction.  Following two patches (13
and 14) implement the sysfs directories, and successing two patches (15
and 16) implement the special keyword for 'state' to fill and clean up
the directories.

Finally, two more patches (17 and 18) for the documentation of the usage
and ABI follow.

Assembled Tree
--------------

This patchset is based on the latest mm-unstable tree[1].  Assembled
tree is also available at the damon/next tree[2].

[1] https://git.kernel.org/akpm/mm/h/mm-unstable
[2] https://git.kernel.org/sj/h/damon/next

SeongJae Park (18):
  mm/damon/modules: deduplicate init steps for DAMON context setup
  mm/damon/core: split out DAMOS-charged region skip logic into a new
    function
  mm/damon/core: split damos application logic into a new function
  mm/damon/core: split out scheme stat update logic into a new function
  mm/damon/core: split out scheme quota adjustment logic into a new
    function
  mm/damon/core: add a DAMON callback for scheme target regions check
  mm/damon/sysfs: Use damon_addr_range for regions' start and end values
  mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
  mm/damon/sysfs: move sysfs_lock to common module
  mm/damon/sysfs: move unsigned long range directory to common module
  mm/damon/sysfs: split out kdamond-independent schemes stats update
    logic into a new function
  mm/damon/sysfs: move schemes directory implementation to separate
    module
  mm/damon/sysfs-schemes: implement schemes/tried_regions directory
  mm/damon/sysfs-schemes: implement scheme region directory
  mm/damon/sysfs: implement DAMOS-tried regions update command
  mm/damon/sysfs-schemes: implement DAMOS tried regions clear command
  Docs/admin-guide/mm/damon/usage: document schemes/<s>/tried_regions
    directory
  Docs/ABI/damon: document 'schemes/<s>/tried_regions' directory

 .../ABI/testing/sysfs-kernel-mm-damon         |   32 +
 Documentation/admin-guide/mm/damon/usage.rst  |   44 +-
 include/linux/damon.h                         |    5 +
 mm/damon/Makefile                             |    6 +-
 mm/damon/core.c                               |  259 ++--
 mm/damon/lru_sort.c                           |   17 +-
 mm/damon/modules-common.c                     |   42 +
 mm/damon/modules-common.h                     |    3 +
 mm/damon/reclaim.c                            |   17 +-
 mm/damon/sysfs-common.c                       |  107 ++
 mm/damon/sysfs-common.h                       |   56 +
 mm/damon/sysfs-schemes.c                      | 1281 +++++++++++++++++
 mm/damon/sysfs.c                              | 1224 ++--------------
 13 files changed, 1813 insertions(+), 1280 deletions(-)
 create mode 100644 mm/damon/modules-common.c
 create mode 100644 mm/damon/sysfs-common.c
 create mode 100644 mm/damon/sysfs-common.h
 create mode 100644 mm/damon/sysfs-schemes.c

-- 
2.25.1

