Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7A1A76BB;
	Fri, 11 Sep 2026 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089226; cv=none; b=a7PPZsLJ1PcY1R9YHHkaLAOjrkD+i+B2LNsvSHcoXwgSXwRtj7sfSOrSPNOy7j39m9t27/RPXhGYC1MzZetQwd6WXwIPp+XXK+i0tesi2F8njZ+2CF7vUra3fUzQK6E0WxsUbsvtxcTMF7+np+8PN1qyLS1myOgD0kxmleaWSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089226; c=relaxed/simple;
	bh=2OizEc6gGKFmPKIxF7d6IMbH/x32/umYvg687eojMdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrnDDlVwos5Y4lupsyxC1TVZwTGOx4rHkJOFg+zcGdOreVeBYzMJfjjMTBBRiWBbNaRrl8cOyyIET1+pWMvOCm5a9K5mJJuNL5DxkTUe9Ubj9nPXH7AwLAMylhw8fAhWSJ+Wz9bxFzKeGBSpn5V8WiT11UvdSXzVVgkCFD9bcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i81ukWa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i81ukWa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5AE1F000FF;
	Fri, 11 Sep 2026 01:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089218;
	bh=GpC4gk3m7cdW8BgHK5/ON6FM2LXn4NcAQ6pZC9bl+OA=;
	h=From:To:Cc:Subject:Date;
	b=i81ukWa9Q8JIQisy8BbIlRUyfGpX8D/Ju1bddEZSQ5Q69K5NkvMY8hw/Rpfe888Ut
	 LXV/H+SvyWR5vCLtUjEW0BgT889s0GxDMZ/Rd0H0tK3T4JaDs0HeTnC0oUXRnOXMy+
	 xoq9eYpPf8TFaUQ0TDhT9HUS+TgI5YyCFSCZ9vBm3PIzRNKBUksZ8RNELqGR257FRm
	 GNbrUFj8ZnOrHnpgK+3E1rDDsCWnEGolNsynUi1G/2/WnHcPyfn4whYL0DnMidsY07
	 hKLax3gjw39Qcfv5Ttopa50mPawvYixzfSmQLTMwg6OFc675qTPyFkEEEUJzlRtcng
	 +8h29SO/AW4pA==
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
Subject: [RFC PATCH v2.2 0/7] mm/damon: introduce probe_hits_wsum DAMOS core filter
Date: Thu, 10 Sep 2026 18:13:21 -0700
Message-ID: <20260911011330.93678-1-sj@kernel.org>
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

Changes from v1
- v1: https://lore.kernel.org/20260910141849.170896-1-sj@kernel.org
- Validate {min,max}_range sysfs input on local variables.
- Add RFC tag again.
Changes from RFC v2.1
- RFC v2.1: https://lore.kernel.org/20260910040319.147037-1-sj@kernel.org
- Update kernel-doc to clarify probe_hits_wsum is a damos core filter.
- Drop RFC tag.
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260907171218.101430-1-sj@kernel.org
- Rebase to latest mm-new.
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
 include/linux/damon.h                        | 22 ++++++++++-----
 mm/damon/core.c                              | 20 ++++++++++++--
 mm/damon/paddr.c                             |  2 +-
 mm/damon/sysfs-schemes.c                     | 29 ++++++++++++++------
 mm/damon/vaddr.c                             |  2 +-
 7 files changed, 62 insertions(+), 20 deletions(-)


base-commit: d07c4abd83baebbe6dcc351c519292cddce024f4
-- 
2.47.3
