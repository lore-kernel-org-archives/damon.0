Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7648593F;
	Thu, 10 Sep 2026 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050162; cv=none; b=feuQYye8Jw8Go+fVr9jdR6lgkgZy3QL/6yQaUpMu7fq1kAVSynJJePnSG06z92GKYMJlHAgd9YtZWilf4pU7sYPB4LU+augzaEbYyz0UYhDw1+MTOojVD82I6iAbM+IuQ5SVSl5Ih0OjzEPLgcJykZasaJGvoWufNQJIU5Inrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050162; c=relaxed/simple;
	bh=v3gsoa86da1l1Vfh8dFgETogi+G/os/79V9Csd7WjHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/AJVqOt3u1HHTJcZnFpFWPlNqfL34zqdBQdGbAbaUVLlHmKATo+iDkCHaCvDDjKx5K1oBboY0/qLfu5tD+H5k2ka0yoxtT1QhcRQoAFSDtYXcMbDfmYDpd4M61XoQJh7mnSfbFyiLbY3Po+5CEyc5swO/S/Fg8vzEA9ZQGhKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxvePAEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxvePAEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EEB1F000FF;
	Thu, 10 Sep 2026 14:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050161;
	bh=wPCZ7WqgRzvETLWg2a26RvqiL8k5Df3lkcW+Fvmq+Qg=;
	h=From:To:Cc:Subject:Date;
	b=YxvePAEXrWXF6Rw1TL5OTHVTq1O5/0FetqS4vTfRh2HWWw82DPGEbBrpTdVfF7T4/
	 gf0eDrKaLbNDoJF2XCFghUWRwQl18qgKoiRTXft/jaIC2o3I+RCu101I0OcPOpHWYU
	 IW+Mc/l5NwiLiEC2clQg34xX/l1Ocy00wRcnO7riJYd/ssawrA7/BmcLNblMxQvYym
	 oo//zYHGcdx6UBqQn/EC3to2ZVN5TNvSu+e2yLZQVyVtZf+MDCQugpaOVkxPW8JSx8
	 2LRQ6LSDrEpyOQZSifbtnxgY42zGPk9IQlDO6/hA7S1c6/fkow/B0l2xXqpbJ+Ytri
	 g717Ko26Fv0rQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] mm/damon: introduce pgidle_set probe filter type
Date: Thu, 10 Sep 2026 07:22:27 -0700
Message-ID: <20260910142234.171562-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can do effective access monitoring with DAMON, using set_pgidle
probe prep operation and pgidle_unset allowing probe filter.  In the
setup, high probe_hits means the region was accessed frequently.  Zero
probe_hits means the region was not accessed.  The filter, however,
matches only the memory that can show the idleness.  Regions of zero
probe_hits may contain memory that was just unable to show the idleness.
On virtual address space based monitoring, for example, non-present
pages are reported as cold.  It is truly cold, but if the purpose is to
make some operations like reclaiming or compressing the data, this is
not really useful.  Introduce a new probe filter type, pgidle_set, that
confirms the page is marked as idle.  Using it instead of pgidle_unset,
users can find cold pages that can effectively be processed.

Patch 1 introduces the pgidle_set probe filter type to DAMON kernel API.
Patches 2 and 3 add support for it on physical and virtual address space
operation sets, respectively.  Patch 4 adds support for it on the DAMON
sysfs interface.  Finally, patch 5 updates the documentation for the new
filter type.

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260910040911.148273-1-sj@kernel.org
- Drop RFC tag.
Changes from RFC
- RFC: https://lore.kernel.org/20260906175009.93471-1-sj@kernel.org
- Rebase to latest mm-new.

SJ Park (5):
  mm/damon/api: introduce DAMON_FILTER_TYPE_PGIDLE_SET
  mm/damon/paddr: support DAMON_FILTER_TYPE_PGIDLE_SET
  mm/damon/vaddr: support DAMON_FILTER_TYPE_PGIDLE_SET
  mm/damon/sysfs: support DAMON_FILTER_TYPE_PGIDLE_SET
  Docs/mm/damon/design: update for pgidle_set probe filter

 Documentation/mm/damon/design.rst | 3 ++-
 include/linux/damon.h             | 2 ++
 mm/damon/paddr.c                  | 6 ++++++
 mm/damon/sysfs.c                  | 4 ++++
 mm/damon/vaddr.c                  | 7 +++++++
 5 files changed, 21 insertions(+), 1 deletion(-)


base-commit: db0399c7f55d733a66e5661c4300276629123b0b
-- 
2.47.3
