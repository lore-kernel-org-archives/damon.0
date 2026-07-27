Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C31E1DE5;
	Mon, 27 Jul 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163114; cv=none; b=draEC/seHdk++pIvP169GiOtJ2gbEW6LzFe1dhouCgjJTM/V6eF5Vu6wUmO3gk8ZXa+57iLx/dcOT50IEZ2VwSHZoHy0ZxejZS4VCdcfqABLv94/U6FrgJtA0fGAxRTc6JduUYSO+o4wo3ZrHFbETPb1yOEkHxDedUXUmr6Urk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163114; c=relaxed/simple;
	bh=xG+NXSGPdkFWjM5tqsUiAYaxaZ7Ly6xhBxtqhPK5KGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzhSvq5AZp3yaFo8SG3sazDXhCWZVipUuqESwhrQ4nk07rlX3c4rR7nGwW6HqrH7UYuvpVv63kZx1J+qW3ULWobvjpfjzxGms0vglEc4NKfRr09N8j07D5Kq4PFdOHeero/2vd8Ou8caPjQQcYF6Yhpy0ZARZeLf591oYtMe3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8PoUkUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8PoUkUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85231F000E9;
	Mon, 27 Jul 2026 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163112;
	bh=Y0UW/VdUs5RvUaReKG9LrDbVoWZA9d+f+N+7xVMLYOM=;
	h=From:To:Cc:Subject:Date;
	b=b8PoUkUPeTy3OF1iG8XNYw19XtUn8y8VKka1G+AlDNaB21LfeXE+JnrBFT+doIS8o
	 bTADGQu5bjxrewHs3Io3be97y2GKf+gLnqqXR2aQAbuxKpFyNhmkLMiOxkFG671QK1
	 DedJLy1GvdgbVqA5u2tHW02T+bVdal+HekLlAjGiwmnCxDXWq2eVwc+hFk60Nyd7hR
	 QvRpiAIy0P/B5K92KF7IHkYxlns2TQNKtLngQ6om2Q2ogtd//gn/yxvVxpxixEfOXQ
	 M7XMKmC2asLvSee0CxW6pWG6iu0Q2Ol4tudn+Q+6gT/4BOmhRhQdulo05CNNveDFMs
	 mhk88K36yrJ2w==
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
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 00/17] mm/damon: introduce data access-as-a-data attribute
Date: Mon, 27 Jul 2026 07:38:09 -0700
Message-ID: <20260727143829.86236-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: extend DAMON's data attributes monitoring system to support page
table accessed bit and PG_idle based access monitoring.

DAMON was initially introduced as a data access monitor.  Users found
data access pattern becomes more useful when it is combined with other
data attributes such as belonging cgroups and backing page types.  For
such cases, DAMON has extended to support such data attributes
monitoring in addition to the original data access monitoring.  The
DAMON probes system was introduced for this purpose.  Users set probes
for filtering data attributes of their interest.  For use cases where
the primary interests are the attributes but the access pattern, probe
weights system has been introduced.  When it is used, DAMON applies its
adaptive regions adjustment based on the monitored data attributes.

However, DAMON stops access monitoring when the probe weights are used.
DAMON cannot optimally help users who have interests in both data
attributes and access patterns.  Data access can also be thought of as
another data attribute, though.  Extend the probe system to support data
access as a data attribute.

Introduce a new probe filter type, pgidle_unset.  It shows if the page
is not set as idle.  Specifically, it shows the page table accessed bit
and the PG_idle flag.  It can inform if the region is ever accessed. But
it cannot say when it is accessed.  To answer the second question,
introduce a new probe feature, prep actions.  Using the features, Users
can specify what preparation actions should be made to each region for
each probe.  DAMON executes the preparation actions for each sampling
interval, like it is doing the preparation for access check in the
access monitoring mode.  To help 'pgidle_unset' probe action use case,
'set_pgidle' preparation action is introduced together.  The action does
exactly what the access monitoring was doing: clearing the page table
accessed bits and setting the PG_idle flags.

Tests
=====

I compared the access pattern monitoring results from the classic way
and the probe based way.  As expected, the probe based way shows the
results similar to that of the classic way.  More detailed test methods
and results are below.

First, do the access monitoring using the DAMON user-space tool [1] in
the classic way.  The system is idle.  It shows no access as expected.

    $ sudo ./damo/damo start
    $ sudo ./damo report access
    heatmap: 00000000000000000000000000000000000000000000000029300000000000002222222100019000
    # min/max temperatures: -440,000,000, 0, column size: 99.800 MiB
    intervals: sample 5 ms aggr 100 ms (max access hz 200)
    0   addr 4.000 KiB    size 4.748 GiB   access 0 hz   age 4.400 s
    1   addr 4.748 GiB    size 167.664 MiB access 0 hz   age 0 ns
    2   addr 4.912 GiB    size 1.325 GiB   access 0 hz   age 4.400 s
    3   addr 6.238 GiB    size 744.301 MiB access 0 hz   age 3.200 s
    4   addr 6.964 GiB    size 438.594 MiB access 0 hz   age 4.400 s
    5   addr 7.393 GiB    size 115.883 MiB access 0 hz   age 0 ns
    6   addr 7.506 GiB    size 298.000 MiB access 0 hz   age 4.400 s
    memory bw estimate: 0 B per second
    total size: 7.797 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

Start an artificial memory access generator [2] and show the monitoring
results.  As expected, it captures accesses.

    $ ./masim/masim ./masim/configs/zigzag.cfg
    $ sudo ./damo report access
    heatmap: 68888888888888888888888888888886222222210017788888888888888888888888899999998777
    # min/max temperatures: -850,000,000, 40,000,500, column size: 99.800 MiB
    intervals: sample 5 ms aggr 100 ms (max access hz 200)
    0   addr 4.000 KiB    size 28.137 MiB  access 0 hz   age 4.200 s
    1   addr 28.141 MiB   size 880.000 KiB access 170 hz age 0 ns
    2   addr 29.000 MiB   size 4.000 MiB   access 0 hz   age 3.100 s
    3   addr 33.000 MiB   size 500.000 KiB access 160 hz age 0 ns
    4   addr 33.488 MiB   size 12.000 KiB  access 0 hz   age 1.700 s
    5   addr 33.500 MiB   size 40.000 KiB  access 170 hz age 0 ns
    6   addr 33.539 MiB   size 8.000 KiB   access 0 hz   age 900 ms
    7   addr 33.547 MiB   size 80.000 KiB  access 170 hz age 0 ns
    8   addr 33.625 MiB   size 32.000 KiB  access 0 hz   age 2.300 s
    9   addr 33.656 MiB   size 68.000 KiB  access 170 hz age 0 ns
    [...]
    528 addr 7.437 GiB    size 368.586 MiB access 0 hz   age 900 ms
    memory bw estimate: 28.521 GiB per second
    total size: 7.797 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

After the artificial memory access generator is terminated, restart
DAMON with the probe-based access monitoring.  Note that DAMON
user-space tool [1] gained the support of probe-based access monitoring
as an experimental feature, starting from v3.3.3.  As expected, it shows
no access since the system is idle again.

    $ sudo ./damo/damo start --probe_prep set_pgidle --probe_filter allow pgidle_unset
    $ sudo ./damo report attrs
    heatmap:
    99999999999999999999899866666664000000000000000277777775333333333333333333333332
    # min/max temperatures: -2,250,000,000, -1,690,000,000, column size:
    99.800 MiB
    intervals: sample 5 ms aggr 100 ms (max access hz 200)
    #   addr         size         age           probe_hits
    0   4.000 KiB    2.316 GiB    16.900 s      0
    1   2.316 GiB    790.730 MiB  18.400 s      0
    2   3.088 GiB    794.406 MiB  22.200 s      0
    3   3.864 GiB    796.473 MiB  22.500 s      0
    4   4.642 GiB    786.223 MiB  17.600 s      0
    5   5.410 GiB    2.326 GiB    20.600 s      0
    6   7.736 GiB    62.773 MiB   20.700 s      0
    memory bw estimate: 0 B per second
    total size: 7.797 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

Start the artificial memory access generator [2] again and show the
monitoring results.  As expected, it captures accesses similar to the
classic monitoring mode.

    $ ./masim/masim ./masim/configs/zigzag.cfg
    $ sudo ./damo report attrs
    heatmap:
    88888888888888899999999888888888400000003888888888888888888888888888888888888888
    # min/max temperatures: -2,100,000,000, 500, column size: 99.800 MiB
    intervals: sample 5 ms aggr 100 ms (max access hz 200)
    #   addr         size         age           probe_hits
    0   4.000 KiB    23.414 MiB   3.500 s       0
    1   23.418 MiB   35.121 MiB   3.500 s       1
    2   58.539 MiB   264.000 KiB  1.600 s       19
    3   58.797 MiB   16.000 KiB   0 ns          0
    4   58.812 MiB   92.000 KiB   1.400 s       20
    5   58.902 MiB   996.000 KiB  600 ms        0
    6   59.875 MiB   32.000 KiB   1.600 s       20
    7   59.906 MiB   24.000 KiB   6.900 s       0
    8   59.930 MiB   72.000 KiB   1.600 s       20
    9   60.000 MiB   160.000 KiB  0 ns          0
    [...]
    316 6.641 GiB    754.949 MiB  1.300 s       0
    317 7.378 GiB    428.676 MiB  1.500 s       0
    memory bw estimate: 11.633 GiB per second
    total size: 7.797 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

Patches Sequence
================

First four patches (patches 1-4) introduce the new probe filter type for
knowing if a region is accessed.  Patch 1 defines the new type in the
core.  Patch 2 implements the execution of the new filter in the
physical address space DAMON operation set.  Patch 3 implements a user
interface on DAMON sysfs interface.  Patch 4 updates the documentation
for the new filter type.

Following 13 patches (patches 5-17) introduce the probe preparation
actions feature.  Patch 5 defines the data structure for specifying the
preparation actions.  Patch 6 completes setup of the API parameter for
the prep.  Patch 7 extends the DAMON operation set callback list to
connect the parameter with the underlying operation set.  Patch 8
implements the execution of the prep in the physical address space DAMON
operation set.

Following five patches (patches 9-13) extends DAMON sysfs interface for
the new prep feature.  Patch 14 adds simple selftest for basic file
operations of the new sysfs files.  Final three patches (patches 15-17)
respectively update design, usage and ABI documents for the new feature
and its interface.

[1] https://github.com/damonitor/damo
[2] https://github.com/sjp38/masim

Changelog
=========

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260726173935.94046-1-sj@kernel.org
- Rename prep iterator macro param names to make more sense.
- Document set_samples param of prep_probes().
- Set do_prep after kdamond_wait_activation().
- Use const keyword for sysfs prep action-name structure fields.
- Fix typos in documents.
- Restructure sysfs interface patches for no build warning.
- Rebase to the latest mm-new.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260725210225.129944-1-sj@kernel.org
- Fix wrong sample_addr setup condition.
- Fix build warnings from sysfs part.
- Fix typos.
- Rebase to latest mm-new.
- Add the tests section to the cover letter.

SJ Park (17):
  mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
  mm/damon/paddr: support PGIDLE_UNSET probe filter type
  mm/damon/sysfs: support pgidle_unset probe filter type
  Docs/mm/damon/design: document pgidle_unset probe filter type
  mm/damon/core: introduce damon_prep struct
  mm/damon/core: commit preps
  mm/damon/core: introduce damon_operations->prep_probes()
  mm/damon/paddr: support damon_prep
  mm/damon/sysfs: implement preps directory
  mm/damon/sysfs: implement preps/nr_preps file
  mm/damon/sysfs: create directories for nr_preps writes
  mm/damon/sysfs: implement prep_action file
  mm/damon/sysfs: pass preps to DAMON core
  selftests/damon/sysfs.sh: test probe prep sysfs files
  Docs/mm/damon/design: document probe preps
  Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
  Docs/ABI/damon: document probe prep sysfs files

 .../ABI/testing/sysfs-kernel-mm-damon         |  13 +
 Documentation/admin-guide/mm/damon/usage.rst  |  18 +-
 Documentation/mm/damon/design.rst             |  15 +-
 include/linux/damon.h                         |  43 ++-
 mm/damon/core.c                               | 105 ++++++-
 mm/damon/paddr.c                              |  41 +++
 mm/damon/sysfs.c                              | 280 +++++++++++++++++-
 tools/testing/selftests/damon/sysfs.sh        |  27 ++
 8 files changed, 528 insertions(+), 14 deletions(-)


base-commit: cf94444749762a681c6b1daafb89bd386c591b32
-- 
2.47.3
