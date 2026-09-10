Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FC306B3D;
	Thu, 10 Sep 2026 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013365; cv=none; b=rWFrQq6h5uvvOUuO+YBYx3VvWbM2ZMESead5DXhKU2TTDhNQaTQBFBYGtUiZ/5dBxqX1w2HkC1H5BNGtinCi1zbg7wUa1n5Q/1tv/hcgJhNOXuSSMoRGXLoZSqrO5e/89tAUw9gwEWSJ/l8sKN+5/+e9s7vKopqLPiM/rQc3fO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013365; c=relaxed/simple;
	bh=MGkyaNmfpEYy9E4ERHSmsC52O0X4Y+zkw3SSRFRVobU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5yIB2nT2AEX3Uj5jbymrO9GCLMBdEqu7xhqZfWEcTS5IRvSFsbHg9Zvy81fIMaNrhOApVouQ5XnX+M/HMCIXmZDHa96yR0WWSorePCfn8W9Vb8oeX/EAxk3m+Ayraui7wa8Hfo644iTRsYlkQNdQUr6cFWUbprToppdM52pweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOhVxn91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOhVxn91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFB41F000FF;
	Thu, 10 Sep 2026 04:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013364;
	bh=IpnCkI3XmaUQenTKAoPeiZEhLOladtx3MVkC2IC7tvs=;
	h=From:To:Cc:Subject:Date;
	b=UOhVxn91pcikH2N175OfGaY4gHnHk3mjXONatrvrYHQ0mIblzptYismN2cf2RzCYZ
	 vK8P/8sQ+6malbd/Jp5hrctjLEMYk3oXOQvlYdyuEpBNfak8LxmCe3Zosg0rqf756u
	 JjY4J0rTVWK9el8xOgUYuqYuXLisdRf8YVp/WkGwl0Wvl/nDdhXyxUzVKS/gTclE7c
	 yEIiJyaPIhvFhk4H6ZiQSpB5VzTj3lOUa0Xnrl3iG7EobV0ImnKerEWmEsCZg3FMnz
	 dyXtEOCny8xVWEBB9SEzwKwzDi3zmZtVgKG1D0u3OC2UVIJFbKr8HYlL5YhnSdVHUF
	 yh9SfR8Qy9OkA==
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
Subject: [RFC PATCH v1.1 0/5] mm/damon: introduce pgidle_set probe filter type
Date: Wed,  9 Sep 2026 21:09:02 -0700
Message-ID: <20260910040911.148273-1-sj@kernel.org>
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


base-commit: 0dd30563c006765cf3937091901dafb02957ab45
-- 
2.47.3
