Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4C51D53C;
	Mon,  7 Sep 2026 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801148; cv=none; b=jtpFK5ya8FLOqbngwwIfEZ/5HQ1HModo2cTheLjoq9JcKd32fQYxiogHOOAoyROZEG5PW0HODd+yrGCTNKHM2zVYS2XWfYOOz8AB6ZVM14QE7UtGpSd0pdHbJ/gfQER9SXVpYx3skSu4TNNZw5vMR1ltZR//0+lUw5wVT0uPQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801148; c=relaxed/simple;
	bh=CXgZSpIQXX9GUpSFbygQz96dQyeP8fiQOTkP/Q1JHSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ch7+J6e9/Rg2Ca21bVXS+bwNfVHkXi8+MpUH6Zj4dqivx17TJV8ZDNnRo3Jf1JC0VjyDJpFsV/mpKYYmWeCMN6p6KizyoQKEMJLlWrDUbIV1LDT3MhhQNXQPS+sDn/jU/ubEg54xreqKZNYqWOwMT827iihWYrnYP9e9jxUux8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np/evmUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np/evmUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099081F00A3A;
	Mon,  7 Sep 2026 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801145;
	bh=Y4p31XPgokx2qGPPsP878fh0V85lBvlTq2ciEbDGO3U=;
	h=From:To:Cc:Subject:Date;
	b=np/evmUeNjelzFmw9xTdA+JsbGs2ltTV2QDwKxwAcVeIdX6kt3gku2vENsL3wRZRk
	 eVZB4+X8aRVXmz7mM/V0LTwoH+hqtzMzpW3ElsYo57KVgxbasBMregeE6v7eSCG3jx
	 aYyN014d7bUA9dBcRPw39EfEIBlPJtomNq+he3HqOAKLRmptzRzj0VgteoTyFq0dnh
	 Uw2DNz3W4uYLrkOmjbRJtdkkc8/zmzG/O3pCVMU952hdHp3i9sKLnllmyF3ss8fcPb
	 4700rT65guzgVUEa6HlwV6MxJKGDAcBHWcm/Y87JulXMeB6vY0AgnvfG7GuaUSSmqE
	 AM5vIJc9hyCiQ==
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
Subject: [RFC PATCH v2 0/7] mm/damon: introduce probe_hits_wsum DAMOS core filter
Date: Mon,  7 Sep 2026 10:12:09 -0700
Message-ID: <20260907171218.101430-1-sj@kernel.org>
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
extends damon_probe_hits_wsum() to do the calculation based on moving
sum.  Patch 3 implements the filter type in the core layer.  Patch 4
refactors DAMON sysfs interface internal data structure for efficient
reuse of data structure for the probe hits weighted sum range user
inputs.  Patch 5 updates DAMON sysfs interface to support the new filter
type.  Patches 6 and 7 update design and usage documents for the new
filter type, respectively.

Changelog
=========

Changes from RFC
- RFC: https://lore.kernel.org/20260906210513.106895-1-sj@kernel.org
- Fix kernel-doc typo.
- Use moving sum based weighted sum.
- Fix wrong range saving field names in sysfs.

SJ Park (7):
  mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
  mm/damon/core: extend probe_hits_wsum() for moving sum based
    calculation
  mm/damon/core: support probe_hits_wsum damos core filter
  mm/damon/sysfs-schemes: rename sysfs_filter->sz_range to
    range_{min,max}
  mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
  Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
  Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS
    filter

 Documentation/admin-guide/mm/damon/usage.rst |  4 +++
 Documentation/mm/damon/design.rst            |  3 ++
 include/linux/damon.h                        | 10 ++++++-
 mm/damon/core.c                              | 20 +++++++++++--
 mm/damon/paddr.c                             |  2 +-
 mm/damon/sysfs-schemes.c                     | 30 ++++++++++++++------
 mm/damon/vaddr.c                             |  2 +-
 7 files changed, 57 insertions(+), 14 deletions(-)


base-commit: 48856ec5bf2f614ff3ef647bbf7cc605faf8c977
-- 
2.47.3
