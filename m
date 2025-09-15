Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004479EA;
	Mon, 15 Sep 2025 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901492; cv=none; b=PDier6NtU9bjOA88mouOJAyt5KFqTm8xviGMiruuvlaHRh2GkoYXQJ2AU1snEAhboD/vmBxEOsk1pfBu8rf8wbJgK8Nj3T0No2h18BqLKeRnPNhKHppLaEIPdbQD9sR6ql6t/aIcZd0xRAuywcJ91LKowUrrHvVU6uSnWMufMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901492; c=relaxed/simple;
	bh=BjDfoABSgABBExqvsCQseg6eKUcYV/UHjDVy9HDbnTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rqk+WrfTqJ0j8qHDh4HFCOuO0Sie/NQscJc1GUOZzem+svaR2jvQOf+IkF4WqdB54Nq5fJrzkOWiTpj2Bm6Q3WLzrZd/HnqdeXsWgiyTqVl/5MJaFLX95ZUHInYgNuuL+yH027WXUSnYrUBtmjf3jU1fDqlYAYS5Tj958nmTGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0AJjbBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0AJjbBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C49C4CEF0;
	Mon, 15 Sep 2025 01:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757901492;
	bh=BjDfoABSgABBExqvsCQseg6eKUcYV/UHjDVy9HDbnTM=;
	h=From:To:Cc:Subject:Date:From;
	b=p0AJjbBGFPG749zf9wQYkZKmgBX19ks09WgebMp/0+Hpb55ugQuzAomtLitCmJ5Yy
	 dTzRVHUoQv3y+CT4Ivr5dw8PWQ03uYMJQLa3ZDbtLg3UQutyzvgsH3WNMMM48TwMxA
	 mGrqqKHI64s8s2OKPM+2FCF/DAmEyMa6FAPlt5b3C7ub6dLLIpIBlcH9ESwtPyi3NG
	 TjVCW17Fp+EiqKDtKJUptMA09kckNx/v4hIQXu+QXE/uEd9ApAih+UqwF3E4HAoYuT
	 QVvgaSFzYrIrwRCMGfY6ilG+tToxHmEnqUjYKh/V9KlASxr9DRtAH91puGizygcwSM
	 K6MLyBvtOWwIg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
Date: Sun, 14 Sep 2025 18:58:01 -0700
Message-Id: <20250915015807.101505-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misc fixes and improvements for DAMON that are not critical and
therefore aims to be merged into Linux 6.18-rc1.

The first patch improves DAMON's age counting for nr_accesses zero
to/from non-zero changes.

The second patch fixes an initial DAMOS apply interval delay issue that
is not realistic but still could happen on an odd setup.

The third patch fixes wrongly written code that doesn't cause any real
problem but could make code review confusing.

The fourth and the fifth patches update DAMON community meetup
description and DAMON user-space tool example command for DAMOS usage,
respectively.

Finally, the sixth patch updates MAINTAINERS section name for DAMON to
just DAMON.

Changes from RFC
(https://lore.kernel.org/20250909034353.7064-1-sj@kernel.org)
- The RFC was only for the first patch
- Rebase and wordsmith the first patch
- Add a few misc fixes and improvements for 6.18 to the series

SeongJae Park (6):
  mm/damon/core: reset age if nr_accesses changes between non-zero and
    zero
  mm/damon/core: set effective quota on first charge window
  mm/damon/lru_sort: use param_ctx correctly
  Docs/mm/damon/maintainer-profile: update community meetup for
    reservation requirements
  Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example
    command
  MAINTAINERS: rename DAMON section

 Documentation/admin-guide/mm/damon/start.rst  |  2 +-
 Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
 MAINTAINERS                                   |  2 +-
 mm/damon/core.c                               |  7 ++++++-
 mm/damon/lru_sort.c                           |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)


base-commit: d245e17d619ea0336d50b0a6c914f5701d1b0e53
-- 
2.39.5
