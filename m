Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC33C13E6;
	Sun,  6 Sep 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717018; cv=none; b=ul8M5MTQSN/bwa/wbrnsXSyGNmj8EPe+qMEY7dLwh1edhICf+hJ4YVE91zL1Yfr2qg2ndrQOLICU2GJ/fqa3wTaPfhe7JA/W8gSH7Bu+K5i60PBa8DhQ+UEWSrLDzGBE1+paPKfxOzg53Szh+7EwKIP+zBWJTRat2OdzjIiZywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717018; c=relaxed/simple;
	bh=/86R1obF9tqLV8XHK+26DkCa9o1IcWJNrxsAImiOt0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kN0nneVjVzmLBYG6QJXC6xVgyArMI7YQGWq6pQIwMmOgoRaT0PNjvuYAdYexlppSRtWolcfDQtDIdZefTCFFNG+4jqTgaD4AtMw9NPje0OwPzB9Bedinffb6XOhR+5BnZCf1/f/fJzpOON2ulEMP1txmiifF9G5n1gdbVQnVvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miPmOp5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miPmOp5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7071F00A3A;
	Sun,  6 Sep 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717017;
	bh=TXvzQ+SLIaLkAFo34lav/ZXHObksvDjOVwRTnAa8CaU=;
	h=From:To:Cc:Subject:Date;
	b=miPmOp5mukXNbthtuiyU8nWqkKZHQX4z3lS5ReLyaZZ0JycHmDG4VNzFWUiekePfV
	 sM1pc/63uVcr0x8s2UWq6vkD7Rvqk7dMhykTEGNMUmRW3/h06//kyuvgxx5kwpK3JE
	 NFr6Q3pTPKIv2C0HIyZaj4yGIZwgKkbSPRaHlq9I1RzuTMmpBHRBhv3nyqV1UXngUq
	 5sqtZgPpwI4sg9LLu7NgFLJJ4zR5Abe6nNO6pdc3sxLIejoFGHrZlU+tONfEUc8rkm
	 sVJacsdLqq6vcrQqkCY6Kc/UZSji4Bh82pwWcf5ScwwW87MnaYChVGQbNOSTt5aQnT
	 J1I3eW8UlKMKQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH 0/5] mm/damon: introduce pgidle_set probe filter type
Date: Sun,  6 Sep 2026 10:50:02 -0700
Message-ID: <20260906175009.93471-1-sj@kernel.org>
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


base-commit: 1c9ae14f592158ed68845f7552f582545cb95c9a
-- 
2.47.3
