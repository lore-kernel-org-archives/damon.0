Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D326AD5
	for <damon@lists.linux.dev>; Mon, 24 Oct 2022 20:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D5C433D6;
	Mon, 24 Oct 2022 20:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666644565;
	bh=eaYYbVIt8/+YtwkZbXmhWn+ifMSd+sXZYeDANgnL568=;
	h=From:To:Cc:Subject:Date:From;
	b=WIZ16QyG5Q6vwOmUWHJ7DZ3C93eYq1e4vlvqj2xhXEgil6Dse1Q01vZs3+J0urUO0
	 knps5WXaFzvq5VfPiPkJh4e0peL20MAOXXa3m2AEl1KXKAiAcg/8qdI9mVIVW05DFb
	 QgvfEpi7XmS/LClWDIGu1sLJtqCNlimdF/GzwpGibfjnf0Qbkjs9DA35HYpW1PB/GE
	 ZxLXshRS4GUmu3j8ESWINLnfBZFicdUxQg7HkxjYJ/cFLzmqMvmoLrZVcTKnN5wptr
	 Q7DjDGskKYHXg9aWmnsD/7LLYvJpxdvwzNk5SPhnaZ2+MaIjBL5n3uBv+jixPvZlmr
	 1g2OnHsgaNSqw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/11] mm/damon: cleanup and refactoring code
Date: Mon, 24 Oct 2022 20:49:08 +0000
Message-Id: <20221024204919.18524-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset cleans up and refactors a range of DAMON code including
the core, DAMON sysfs interface, and DAMON modules, for better
readability and convenient future feature implementations.

In detail, this patchset splits unnecessarily long and complex functions
in core into smaller functions (patches 1-4).  Then, it cleans up the
DAMON sysfs interface by using more type-safe code (patch 5) and
removing unnecessary function parameters (patch 6).  Further, it
refactor the code by distributing the code into multiple files (patches
7-9).  Last two patches (patches 10 and 11) deduplicates and remove
unnecessary header inclusion in DAMON modules (reclaim and lru_sort).

Note that this initially posted as a part of a feature implementation
RFC patchset[1], but separated into this patchset as the amount of the
change is not small compared to the feature implementation change
itself.

[1] https://lore.kernel.org/damon/20221019001317.104270-1-sj@kernel.org/

SeongJae Park (11):
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
  mm/damon/modules: deduplicate init steps for DAMON context setup
  mm/damon/{reclaim,lru_sort}: remove unnecessarily included headers

 mm/damon/Makefile         |   6 +-
 mm/damon/core.c           | 262 +++++++++++++++++++++++---------------
 mm/damon/lru_sort.c       |  19 +--
 mm/damon/modules-common.c |  42 ++++++
 mm/damon/modules-common.h |   3 +
 mm/damon/reclaim.c        |  19 +--
 mm/damon/sysfs-common.c   | 107 ++++++++++++++++
 mm/damon/sysfs-common.h   |  24 ++++
 mm/damon/sysfs.c          | 172 +++++--------------------
 9 files changed, 374 insertions(+), 280 deletions(-)
 create mode 100644 mm/damon/modules-common.c
 create mode 100644 mm/damon/sysfs-common.c
 create mode 100644 mm/damon/sysfs-common.h

-- 
2.25.1

