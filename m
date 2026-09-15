Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA573B584F;
	Tue, 15 Sep 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482848; cv=none; b=ZVVfVpTh+ttMyXAY3v99YWopVDSrTs5kPGvedEh/2ia/fLYWLobehRZIu57UjLVwDiU0EpEd/AFWV1Vo8lZmO2CNw/+9t8vwWI50wnUFPAeSIKSZFSobRxEOl3ESGHfBSzWAPHny3Q05WkvkJgh4XdBPnaqiN32OXFDwdlUaQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482848; c=relaxed/simple;
	bh=AnVBFaSdSnHF7XpWgLHbAyXThCr3yHJW8vTnAvkAyXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxHhbUvuRIWTj1Ce4GSvzQ7Ma+87MCQ853cIjRasT1IWNIgTQmduVD5RBTy8+RtK6hasgCBYnLuIR3RB2oZady4teIMw0dsm7n98WCqdY3sVQg1G0dRdjlXNdRvccJnjToB1bY9pPUyx0YVNX8DvNEspJDq8ORGO4SVeE+xNNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbqnj4Km; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbqnj4Km"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989081F00893;
	Tue, 15 Sep 2026 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482847;
	bh=SKLqSPCuAsRd41lrGHWS/9aSfp+Jllqic8PVAZKPWiU=;
	h=From:To:Cc:Subject:Date;
	b=gbqnj4KmIO0ejFd0frDulKvYZeTYh0oyxvqG3RqvA/u/KYwjz8JKbwYjX5wRGifX4
	 DLYY1/Hv6Yy1lWnph8z7x7o3L08/blL2ulbZapVp0jyj6t2PAujD7E2jUG8ShEs8Iw
	 T+8fx0YTObe6owuOHLSrxIk4F63kselKybh1XVuaY6aUcsZQ6cKOtfPBcicYX01AGH
	 yboeYGUdgAUtfyLMX9OceMmwrJ+eZ+K7Rs/GBp47oUS31B+kD5RdoW3hdwwt0FBatb
	 JMg5MdmzLoYvs8pi3bHLXsmz4T8Z3tFykz6Q4oSx56kZM2G5D4USyjJIjmo/x4bV0f
	 5lWX/LllPIyig==
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
Subject: [PATCH 0/8] mm/damon: introduce hugepage_size probe filter
Date: Tue, 15 Sep 2026 07:33:49 -0700
Message-ID: <20260915143359.91472-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing whether a given memory is backed by a hugepage of specific size
is useful for efficient utilization of hugepages.  For easy monitoring
of the information, introduce a new data attribute probe filter type,
hugepage_size.  It works similar to the DAMOS filter of the same name.
It works for memory that is backed by a hugepage of a given size range.

Patch 1 introduces the new probe filter type to DAMON API and extends
related data structures.  Patch 2 updates probe filter commit logic to
handle the size range.  Patch 3 Updates the filtering logic to support
the new type.  Patch 4 adds new DAMON sysfs files for the size range.
Patch 5 updates DAMON sysfs interface to fully support the new filter
type.  Patches 6-8 updates design, usage and ABI documents for the new
feature.

Test
====

Set THP always and start a test workload using masim [1].

    $ echo always | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
    $ ./masim.py run --config_file ./configs/stairs-500mb.cfg --repeat 10

Using the DAMON user-space tool, damo [2], start DAMON with two probes.
The primary probe monitors access.  The secondary probe monitors 2 MiB
sized hugepages.  The region adjustment weight is given to only the
primary probe.  That is, this setup is for showing access temperature
and additionally how many 2 MiB hugepages are being used for the region
of the access temperature.

    $ sudo ./damo start $(pidof masim) \
            --probe \
                --probe_prep set_pgidle --probe_filter allow pgidle_unset \
                --probe_weight 1 \
            --probe \
                --probe_filter allow hugepage_size 2M 2M

Show the monitoring results.

    $ sudo ./damo report attrs
    heatmap: 000000000003[...]666666666666666666666666666666666666666666666668888888888888988888888[...]8
    # min/max temperatures: -2,770,000,000, 68,474,934, column size: 69.784 MiB
    probes
    - prep: set_pgidle, filter: allow pgidle_unset (weight: 1)
    - allow hugepage_size [2.000 MiB, 2.000 MiB] (weight: 0)
    intervals: sample 5 ms aggr 100 ms (max probe hits 20)
    #   size         address       age           probe_hits
    0   250.805 MiB  86.185 TiB    27.700 s      0 0
    1   556.285 MiB  86.184 TiB    27.400 s      0 0
    2   1.629 GiB    127.488 TiB   8.500 s       0 4
    3   535.770 MiB  127.490 TiB   8.400 s       0 7
    4   1.066 GiB    127.490 TiB   8.200 s       0 6
    5   501.332 MiB  127.492 TiB   600 ms        0 12
    [...]
    50  146.133 MiB  127.492 TiB   200 ms        2 20
    51  16.000 KiB   127.492 TiB   200 ms        11 20
    52  144.000 KiB  127.492 TiB   200 ms        17 20
    53  48.000 KiB   127.492 TiB   200 ms        18 20
    54  1.930 MiB    127.492 TiB   200 ms        19 20
    [...]
    101 1.996 MiB    127.492 TiB   2.100 s       1 20
    102 1.992 MiB    127.492 TiB   2.100 s       20 20
    103 1.984 MiB    127.492 TiB   2.200 s       1 20
    104 2.000 MiB    127.492 TiB   2.300 s       20 20
    105 2.000 MiB    127.492 TiB   2.600 s       20 20
    memory bw estimate: 0 B per second
    total size: 5.452 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

The first probe_hits count and the age show the access temperature of
each region.  The region is sorted by access temperature, which is a
weighted sum of the first probe_hits count and the age.  That is,
regions at the beginning of the list are colder than those at the end of
the list.  The second probe_hits count shows the ratio of 2 MiB
hugepages in the region.

For example, region 5, which has 501.332 MiB size, has not accessed for
the last 600 milliseconds and uses 2 MiB THP for ~60% (12/20) of the
region.

Region 105, which is 2 MiB size, has been accessed at least 20 times per
100 milliseconds for the last 2.6 seconds) and fully backed by 2 MiB
hugepage.

[1] https://github.com/sjp38/masim
[2] https://github.com/damonitor/damo

Changes from RFC v3
- RFC v3: https://lore.kernel.org/20260915020929.102953-1-sj@kernel.org
- Drop RFC tag.
- Rebase to lastes mm-new.
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260914144448.93732-1-sj@kernel.org
- Free new filter for invalid filter commit case.
Changes from RFC
- RFC: https://lore.kernel.org/20260913171133.102366-1-sj@kernel.org
- Commit size range for newly added hugepage_size filter.
- Rebase to latest mm-new.

SJ Park (8):
  mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE
  mm/damon/core: commit hugepage_size type damon filter
  mm/damon/ops-common: support hugepage_size damon filter matching
  mm/damon/sysfs: add min,max files under probe filter directory
  mm/damon/sysfs: support hugepage_size probe filter
  Docs/mm/damon/design: update for hugepage_size probe filter
  Docs/admin-guide/mm/damon/usage: update for hugepage_size
  Docs/ABI/damon: update for hugepage_size probe filter

 .../ABI/testing/sysfs-kernel-mm-damon         | 14 +++++
 Documentation/admin-guide/mm/damon/usage.rst  |  4 +-
 Documentation/mm/damon/design.rst             |  2 +
 include/linux/damon.h                         |  8 +++
 mm/damon/core.c                               | 28 ++++++++--
 mm/damon/ops-common.c                         | 10 ++++
 mm/damon/sysfs.c                              | 55 +++++++++++++++++++
 7 files changed, 115 insertions(+), 6 deletions(-)


base-commit: c93300483b699bbc752f1000a1309e8fcf2c9fb2
-- 
2.47.3
