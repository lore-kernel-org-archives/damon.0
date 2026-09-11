Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3C46EC88;
	Fri, 11 Sep 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134919; cv=none; b=E9hsH7+SWwuocUaeikTpouXE4Y4Y94yeyUKxkAQR3dTa8CRJsM3nHsLdt8m1WwqXMBtmITDhNpLcOqm44332Z4C29ESOTnfTOyQMFiwOSWNVz3gC+AgUA6EiS58vo6xV4+ilItxVMYnl9Jz2IycIXpcOjxIHaW4PuSQpq8NcBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134919; c=relaxed/simple;
	bh=DdQOnaXxaWFG9T7wWMn8suPaTsILhVsokzAC4s7h0WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxwF1v9ZO6vACC7a65H6o4Fy1x1NCIRAxRmkVbwydpFoEtVV9pWnEb+hW4Cz7TMr/6duaQ1KE5Fog4Y2WyGtPdL93M1lv/o/OI8FJisV+HibR+5cKg49DD2dDKUAOwhv7jUAnZ2xLZjhee0puQdimCzDt7LCCqksBUGabdMkxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvpeu/2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvpeu/2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B30D1F000FF;
	Fri, 11 Sep 2026 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134918;
	bh=fAZQzRBgRrm9eHxZI3qPgkDGXnuB9LQ39hNTY8psKnY=;
	h=From:To:Cc:Subject:Date;
	b=dvpeu/2FsiD05c79j971JPnbwVDxf8XY8OczJKP073Eq0Lji1J+UwE8vW4d2SAO4J
	 0Heof6xseU9mQCddUtSoXr/4TTIuWh7ILBesy7KXMXBPU9HotRBaOrhjQChGBgNM0d
	 9+B0nODxzVktTgvp6apKSmIpKPb240aGXOZRUo9ifmJjXIjPHDG50W8azE63Cl440D
	 //qOmPTeKRQ+gRQWpvRSCkuI1g2CpwhwquNx9WbHbnLuPmi9IsGTup313OpJXLD+uE
	 gv/ZGz+H923/sYIc/g0edoO9eiqSLFmGIFcUNBgaA++UNFpsaCV32R2kqs8gY/y7u+
	 tVdprEUu+88lg==
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
Subject: [PATCH v2 0/7] mm/damon: introduce probe_hits_wsum DAMOS core filter
Date: Fri, 11 Sep 2026 06:55:02 -0700
Message-ID: <20260911135510.96914-1-sj@kernel.org>
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

Changes from RFC v2.2
- RFC v2.2: https://lore.kernel.org/20260911011330.93678-1-sj@kernel.org
- Drop RFC tag again.
- Rebase to latest mm-new.
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


base-commit: e81bad1a9d225410ad05860d729169baadb2543a
-- 
2.47.3
