Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BC3624A5;
	Sun, 13 Sep 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319503; cv=none; b=nByfaY4DqQ7BLjYXiUyIltb/ZUhE0EGsYF93mD8pEU33VzqqaDRUdRWc3nTDH6wakDnAZtFDv3BYuQCef1WYqk/rocltueoRB/Dc/7OAUG2zKA227SnUgTFagUy7Q6w92bSaEGWBtbISQDUnhh+youn+zh1IAHNwbysG2V/Amw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319503; c=relaxed/simple;
	bh=+sIdpXfxlsc4yuIGGMUlFltyY0YTPsT2xoJif27dxFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfJhFe0mAYW8oe6JwugdZpHp/aJf3hckKuRg2KTb78OPO3XdAyj4KwGmH8okejeHpkRVUbZjt5MHzjvUoiluQUio5bLXqTzJQOHVtW/dyzlAcH1ZqIRHw6sA1nRtdQyfZvN/NaUUGSg1s+OsuQ6oky70YT8WtizOznQTXjdHB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqZAw3Sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqZAw3Sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943271F000FF;
	Sun, 13 Sep 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319502;
	bh=2ZHtfSZyRuUi4qVh2TQmjcCNtITXl+b4Bizxwjd/UP8=;
	h=From:To:Cc:Subject:Date;
	b=jqZAw3Svg9VeStTqsuM2WGZ+gm8UQ5KiloAG7a6ktDPvG+XICMq1upxg7wh3hAfBJ
	 CXwKLNfw3naYioZJon5rKR+hh5FyF84I/D0hUpfWnB77tR496PigKftzDqpq79B5E6
	 jv2VSCIWSQ1b5DHYE6bepvZKyt39g4Z+MCHDl6WMdQNb1HcW6OLciWpOih4E7xHpmn
	 QmUqDPfh6KvDAywF4LsNCGY6GQhO1b1YKWJPVTiCUmOcor7zRvmpSoh/UMTiqXJuyw
	 MYSnz1ogFepuEuwiZAWChIMSzzFKdNehxDA8wdDLTPQNHmGxRST1RKk2WIduca091T
	 NytkNKwAGv8AQ==
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
Subject: [RFC PATCH 0/8] mm/damon: introduce hugepage_size probe filter
Date: Sun, 13 Sep 2026 10:11:22 -0700
Message-ID: <20260913171133.102366-1-sj@kernel.org>
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
            --probe_prep set_pgidle --probe_filter allow pgidle_unset \
            --probe_filter allow hugepage_size 2M 2M --probe_weight 1 0 \
            --nr_probe_preps 1 0 --nr_probe_filters 1 1 --nr_probes 2

Show the monitoring results.

    $ sudo ./damo report attrs
    heatmap: 000004[...]666666668988888888888844444430000000000000000000000000000000000000000000014[...]8
    # min/max temperatures: -470,000,000, 10,000,500, column size: 64.119 MiB
    probes
    - prep: set_pgidle, filter: allow pgidle_unset (weight: 1)
    - allow hugepage_size [2.000 MiB, 2.000 MiB] (weight: 0)
    intervals: sample 5 ms aggr 100 ms (max probe hits 20)
    #   size         address       age           probe_hits
    0   354.039 MiB  85.833 TiB    4.700 s       0 0
    1   1.843 GiB    127.724 TiB   4.700 s       0 6
    2   936.781 MiB  127.726 TiB   4.600 s       0 16
    [...]
    25  44.000 KiB   127.723 TiB   0 ns          15 20
    26  11.492 MiB   127.723 TiB   0 ns          16 20
    27  2.160 MiB    127.723 TiB   0 ns          19 20
    [...]
    47  376.000 KiB  127.723 TiB   300 ms        1 20
    48  48.000 KiB   127.723 TiB   400 ms        2 20
    49  812.000 KiB  127.723 TiB   500 ms        9 20
    memory bw estimate: 0 B per second
    total size: 5.009 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

The first probe_hits count and the age show the access temperature of
each region.  The second probe_hits count shows the ratio of 2 MiB
hugepages in the region.

For example, region 2, which has 936 MiB size, is quite cold (not
accessed for 4.6 seconds) but uses 2 MiB THP for ~80% (16/20) of the
region.  Maybe not a very efficient use of THP.

On the other hand, region 49, which is 812 KiB size, is somewhat hot
(accessed about 9 times per 100 ms for the last 500 ms) and fully backed
by 2 MiB hugepage.  Maybe this is a good use of THP.

[1] https://github.com/sjp38/masim
[2] https://github.com/damonitor/damo

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
 mm/damon/core.c                               | 20 +++++--
 mm/damon/ops-common.c                         | 10 ++++
 mm/damon/sysfs.c                              | 55 +++++++++++++++++++
 7 files changed, 107 insertions(+), 6 deletions(-)


base-commit: 91c120b49e83b867e29684fd229c3e1f07190071
-- 
2.47.3
