Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2E7B
	for <damon@lists.linux.dev>; Wed, 26 Oct 2022 22:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF248C433D7;
	Wed, 26 Oct 2022 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666825189;
	bh=A1xog9/JoTImuQjfC8/0jRefs+jLn853oqIp5j+8x/c=;
	h=From:To:Cc:Subject:Date:From;
	b=QuZyRMU3886vYVE9gsZJ/b9p/OupKMJkvflDE3O8Tpf3rT5z/+aX0QHbWjjP63vHI
	 LZZkgA1vu7Blc2LCxWr051ayX6l1dQzGNlUL11HVCOqYob35Z4MQdCHEbmTsLu/OyB
	 oEFhko1EMhCPAhvgco50a17N4c2GLd3zLbQX5aUF3Tw9tdHQIThpqd1lEOfqWs6BrF
	 fFmwJYzqRWJSM/T/Sygfc8AFO+/lFSWw6Yd5HXvNxx3XnO1gghW1eOgrY2tyxGsHP2
	 vHdKZ9Xa2YTSV6GkqtaUY+96KMC++26CXgZM1YYvQddsPVWBm4PNdV/jcfkCzbT+oC
	 STlJEMnhT2gNA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 00/12] mm/damon: cleanup and refactoring code
Date: Wed, 26 Oct 2022 22:59:31 +0000
Message-Id: <20221026225943.100429-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1
(https://lore.kernel.org/damon/20221024204919.18524-1-sj@kernel.org/):
- Add 10th patch, which splits schemes sysfs directory implementation

This patchset cleans up and refactors a range of DAMON code including
the core, DAMON sysfs interface, and DAMON modules, for better
readability and convenient future feature implementations.

In detail, this patchset splits unnecessarily long and complex functions
in core into smaller functions (patches 1-4).  Then, it cleans up the
DAMON sysfs interface by using more type-safe code (patch 5) and
removing unnecessary function parameters (patch 6).  Further, it
refactor the code by distributing the code into multiple files (patches
7-10).  Last two patches (patches 11 and 12) deduplicates and remove
unnecessary header inclusion in DAMON modules (reclaim and lru_sort).

Note that this initially posted as a part of a feature implementation
RFC patchset[1], but separated into this patchset as the amount of the
change is not small compared to the feature implementation change
itself.

[1] https://lore.kernel.org/damon/20221019001317.104270-1-sj@kernel.org/

SeongJae Park (12):
  mm/damon/core: split out DAMOS-charged region skip logic into a new
    function
  mm/damon/core: split damos application logic into a new function
  mm/damon/core: split out scheme stat update logic into a new function
  mm/damon/core: split out scheme quota adjustment logic into a new
    function
  mm/damon/sysfs: use damon_addr_range for regions' start and end values
  mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
  mm/damon/sysfs: move sysfs_lock to common module
  mm/damon/sysfs: move unsigned long range directory to common module
  mm/damon/sysfs: split out kdamond-independent schemes stats update
    logic into a new function
  mm/damon/sysfs: split out schemes directory implementation to separate
    file
  mm/damon/modules: deduplicate init steps for DAMON context setup
  mm/damon/{reclaim,lru_sort}: remove unnecessarily included headers

 mm/damon/Makefile         |    6 +-
 mm/damon/core.c           |  262 +++++----
 mm/damon/lru_sort.c       |   19 +-
 mm/damon/modules-common.c |   42 ++
 mm/damon/modules-common.h |    3 +
 mm/damon/reclaim.c        |   19 +-
 mm/damon/sysfs-common.c   |  107 ++++
 mm/damon/sysfs-common.h   |   46 ++
 mm/damon/sysfs-schemes.c  | 1022 ++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c          | 1152 +------------------------------------
 10 files changed, 1399 insertions(+), 1279 deletions(-)
 create mode 100644 mm/damon/modules-common.c
 create mode 100644 mm/damon/sysfs-common.c
 create mode 100644 mm/damon/sysfs-common.h
 create mode 100644 mm/damon/sysfs-schemes.c

-- 
2.25.1

