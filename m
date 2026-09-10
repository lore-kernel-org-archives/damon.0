Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7C352002;
	Thu, 10 Sep 2026 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013009; cv=none; b=dG2PBRHvfSis3F5kTYel3MGfayzys06YdjshNUHmxSybinOv/pZqWym9X4XgVqb6DI+weLbMpkEUSSv6ZZZvowFyCqvq2Zg6sTonrt9lefBv/e0mvuTthRd/Qs1gvWST+bAbzPABh345+P2k7cIu14KUEpfh9rbD3bPfr5Nz4eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013009; c=relaxed/simple;
	bh=riQlFwGg7FSwaxs/4CPgQQyf29UFdjb2SeqHhONQmno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtjQzW9CcXPUNYspT0sT2q06Q/f+d+gfHx6xpvhVQTqd2SqUbjO+HSL4EqnCMgUxa1W+KCSHXaDWD3/Sfq6k04aY6TGkF7n9V1o4Q87dqkjF/4lHgNJD8i4JhaeA+0f5Rk9mDB/FZDfJxnIcDJkyxHQD9rQGEDiUdzEK19DvoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1QIO72J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1QIO72J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040261F000FF;
	Thu, 10 Sep 2026 04:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013007;
	bh=Fn16+s8pwcYwe1UkQ7UDOCdjo2v9pEURHMCmkbI/wZ8=;
	h=From:To:Cc:Subject:Date;
	b=M1QIO72JqahmYJFMMNlIMQFzyCFsdczpPacaK7qHuYZX4FGpU/oSyhQKjHP8Kxotx
	 hSPFeoxoZzdjbNdvp/UuyhRNCnLunbScnvmVbvlIUqErb4WsnrJ2vDpDZ/6EhiTIt6
	 r7Uk7sJ9lATr+kSB3vFANmxkRC8QamEwm6JnkUcBig26Cpvtag5k2zIf4S5E/GoFwV
	 a6nU/u0Lt6k379cF3yK7qYEZ7jdZ8TPezo+PVB6CrTnSXY5vOWMTPRAfE9eZnds+0p
	 PYJAMuxQ2sg3DKtmMi83PmfFoO24OCYgrj5OEI+1qcu+SIwBDTioJWI+MHDsMpvWmF
	 hbr+M5UkyE75w==
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
Subject: [RFC PATCH v2.1 0/7] mm/damon: introduce probe_hits_wsum DAMOS core filter
Date: Wed,  9 Sep 2026 21:03:11 -0700
Message-ID: <20260910040319.147037-1-sj@kernel.org>
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
 include/linux/damon.h                        | 10 ++++++-
 mm/damon/core.c                              | 20 +++++++++++--
 mm/damon/paddr.c                             |  2 +-
 mm/damon/sysfs-schemes.c                     | 30 ++++++++++++++------
 mm/damon/vaddr.c                             |  2 +-
 7 files changed, 57 insertions(+), 14 deletions(-)


base-commit: 569e5184af6e299ec0e1f44cde89c2c2bb309a9e
-- 
2.47.3
