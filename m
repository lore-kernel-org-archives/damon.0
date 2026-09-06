Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA43C5DD4;
	Sun,  6 Sep 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728723; cv=none; b=H2+0MBYNZ9P2BxDOR+cKj1GCsyCA/qf1bhkjSMU/puWM0KRBk37/uz1cEMVeYUJ0rkFbXi1fMJJEnG5LewG8wqGNBhPT7sBrHxI0lMK6OXzyqsWNbHjlBknhs9ZxjYSWqIwRVVAcoNy2kFH9k0ddLaD8/sOuJk/b/rJ8/DrKD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728723; c=relaxed/simple;
	bh=66xVvf9AYDaubgalGRElpfl7AJBa4gDemippERfSJ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpCYidduJtEcRfc2l91Fm0wZusUu5YUv5N4HRdThxQyntT9dSr7cumZfODjhyfzf45MEBP78LTYkw5J4beRxZ5txDkdOA+7+tTytdGiYDaAPoyEZfptlHjDH0v+70fgczk0J/vupWH6yu/AClp1EJhRk6gfKi7fA7XNz7UAmZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0wOCysI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0wOCysI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C721F00A3A;
	Sun,  6 Sep 2026 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728721;
	bh=tJB81UTgzrSfPhYv5eHHbGNV659HaY2JEk6GKYFHi0k=;
	h=From:To:Cc:Subject:Date;
	b=S0wOCysIgW+9naXrgkj4wzl/6wFSrTfkTZ9KQIHBnR6bB/Yj/Bws8uCf+uVyjSJgg
	 p3YRGIgEiCMn4CQBMTaeOYZeHbPD/XdTeamAWbW1qsBEO8ncCsA1Ku7y4Yai40TBj6
	 wiBIvgVvy+LUmXsxVHzUE4JxEqxRppss3YSVu4DMvgVgzgy1aPGqrc7q0xFxIqvfMW
	 EmJ1ufzWrIieg99vs9+qAuQzo85z5QqxO9uwwBzFP43g7zmCl6MBfFONtJeGFphDqL
	 GzxLKAmTozx+KY4dydyz3OQYuVQEfqtada9sXjJvLsi5uWO9JsCDcTmcLGjSQ/SSmD
	 arkVrjqfWrNVQ==
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
Subject: [RFC PATCH 0/6] mm/damon: introduce probe_hits_wsum DAMOS core filter
Date: Sun,  6 Sep 2026 14:05:06 -0700
Message-ID: <20260906210513.106895-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON can do flexible data attributes monitoring.  The classical data
access monitoring can also be done using the attributes monitoring.  The
access event is just one of the data attributes that DAMON supports.
Users do monitoring to make some actions based on it.  DAMOS is a
feature for automating that.  However, DAMOS cannot utilize the data
attributes monitoring results.  It is still Data "Access"
Monitoring-based Operation Schemes.  It requires users to set the target
"access" pattern.

DAMOS core filter is effectively the same as the target access pattern.
It is just a more generalized and flexible way of describing the
operation action target region.  Introduce a new DAMOS core filter type,
probe_hits_wsum.  It specifies the filter target based on a range of the
probe hits weighted sum.  Using this, users can apply DAMOS actions to
regions of specific data attributes pattern.

Note that the classic target access pattern still works.  Hence the
target nr_accesses range should still be properly configured.  The new
filter would be used in only data attributes-only mode.  In the mode,
classic access monitoring is just turned off, and therefore nr_accesses
of regions are always zero.  Users could simply set the target
nr_accesses range to include the zero nr_Accesses regions.

Patches Sequence
================

Patch 1 updates the DAMON kernel API for the new filter type.  Patch 2
implements the filter type in the core layer.  Patch 3 refactor DAMON
sysfs interface internal data structure for efficient reuse of data
structure for the probe hits weighted sum range user inputs.  Patch 4
updates DAMON sysfs interface to support the new filter type.  Patches 5
and 6 update design and usage documents for the new filter type,
respectively.

SJ Park (6):
  mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
  mm/damon/core: support probe_hits_wsum damos core filter
  mm/damon/sysfs-schemes: rename sysfs_filter->sz_range to
    range_{min,max}
  mm/damon/sysfs-schemes: setup range_{min,max} for probe_hits_wsum
    filter
  Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
  Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS
    filter

 Documentation/admin-guide/mm/damon/usage.rst |  4 +++
 Documentation/mm/damon/design.rst            |  3 ++
 include/linux/damon.h                        |  8 ++++++
 mm/damon/core.c                              | 12 +++++++-
 mm/damon/sysfs-schemes.c                     | 30 ++++++++++++++------
 5 files changed, 48 insertions(+), 9 deletions(-)


base-commit: 787c63ba44ce65021966f55673e27d778c8d9c68
-- 
2.47.3
