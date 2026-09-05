Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C92F8E9E;
	Sat,  5 Sep 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640005; cv=none; b=jxrhWrUQZ19YBfEkEGGgNBr65FSCOi2vJuGH0DLuy2RxBYBKGYeD8VvNsHeyqwaD3qujuVF+Vnm6Kh4ymd+CR9YbErujrK3Lou85j1h8HJPRX5ekv5WbvhtiACbLi0cNprJOkeqXmzhZklHjY963L3Z7SdCJEAIRAa7ET+5+gwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640005; c=relaxed/simple;
	bh=siS781YOL86d2A1OduE3YacXgWvCtixOx+Z3G3HlIik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBG2l8T7Wk0ttBQ1+AbMlKdiZzTgZktYva1ecF/x64ncJFuL/cvRr1s540NTkUj/dSC40FiyLstyJgGGcYtmczzyczlsjc2Ighssu0eg6NXIdC2milWa1LgN4/1KGRuIYnkLw03rbanl5QakMRIOTeETTcCo5Y55Fzuqi0Rqpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI9f8YtR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI9f8YtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACB31F00A3A;
	Sat,  5 Sep 2026 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640003;
	bh=M3fBlIwPeb0MLRMMvDOp8XO46lHImBBRdMKs8udzsHQ=;
	h=From:To:Cc:Subject:Date;
	b=cI9f8YtRJ+edLFJlYPyXxAzXRe8E6sxjDX+IW3YEp6gzU+FkO2TCYOxaY0tKab9xg
	 AzpLZOrtpkGQFuEWklX59RZgAvTPv5ASwtwNPR6bbSD7hAyiY+WAMdQrYX3CKSeNWY
	 Fl59i58l4G5p34IRrpvClc92blo8kMO5diA3fhI9tNcJsOePfVGDcF7zWLsqT671LD
	 Qblp6NslfepNv31/aNO8rcqqJDtnpg7qQNvK7bfa/ir0yMfCe/hVcc8o34wD/1ziDb
	 lL9HOS9ETJNmkg1yY2QqKYX/yBBIF+22icv8IAOuvnnd330Bn29qQXgwZ/wGl73zBc
	 n7dloPmQHgGhg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/5] mm/damon/vaddr: support {prep,apply}_probes
Date: Sat,  5 Sep 2026 13:26:22 -0700
Message-ID: <20260905202634.88102-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON supports data attributes monitoring.  However, only the physical
address space operation set (paddr) is supporting it.  Add the support
to the virtual address space operation set (vaddr).

Patch 1 adds prep_probes support to vaddr.  Patch 2 moves probe filter
handling code in paddr.c that can be reused by vaddr to ops-common.c.
Patch 3 adds minimum apply_probes support to vaddr.  Patch 4 extends the
support for hugetlb.  Patch 5 extends the support for pgidle_unset
filter.

Test
====

I confirmed it can capture ~48 mb working set of masim in vaddr mode,
like below.

First, start masim [1] to access ~48 mb memory at a time, in the
background.

    $ ./masim/masim.py run \
            --config_file ./masim/configs/stairs-50mb.cfg \
            --repeat 10 --quiet &

Note that the config says the working set is 50mb.  It is 50 million
bytes, so ~48 MiB.

Start traditional access monitoring of masim's virtual address space
using damo [2].

    $ sudo ./damo/damo start $(pidof masim)

Confirm it can capture the ~48 MiB working set as the 4-th region on the
snapshot.

    $ sudo ./damo/damo report access
    heatmap:
    11111111334[...]3000000000000000000000000000000000000000489999997777777743333333555556[...]8
    # min/max temperatures: -1,150,000,000, 80,009,499, column size: 6.963
    MiB
    intervals: sample 5 ms aggr 100 ms (max access hz 200)
    0   addr 85.355 TiB   size 55.703 MiB  access 0 hz   age 9.500 s
    1   addr 85.355 TiB   size 18.984 MiB  access 0 hz   age 6.700 s
    2   addr 127.183 TiB  size 278.516 MiB access 0 hz   age 11.500 s
    3   addr 127.183 TiB  size 7.570 MiB   access 0 hz   age 900 ms
    4   addr 127.183 TiB  size 48.133 MiB  access 190 hz age 800 ms
    5   addr 127.183 TiB  size 54.977 MiB  access 0 hz   age 1.700 s
    6   addr 127.183 TiB  size 55.113 MiB  access 0 hz   age 6.700 s
    7   addr 127.183 TiB  size 37.902 MiB  access 0 hz   age 3.900 s
    8   addr 127.990 TiB  size 120.000 KiB access 0 hz   age 11.400 s
    9   addr 127.990 TiB  size 8.000 KiB   access 70 hz  age 0 ns
    10  addr 127.990 TiB  size 4.000 KiB   access 0 hz   age 11.200 s
    memory bw estimate: 8.931 GiB per second
    total size: 557.027 MiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

Stop access monitoring and start probe-only mode access monitoring.

    $ sudo ./damo/damo stop
    $ sudo ./damo/damo start $(pidof masim) --probe_prep set_pgidle \
            --probe_filter allow pgidle_unset --probe_weight 1

Confirm it can also capture the ~48 MiB working set as the 11-th region
on the snapshot.

    $ sudo ./damo/damo report attrs
    heatmap:
    00000000113[...]40000000000000000000000000000000000000000000000001111114999999533333336[...]6
    # min/max temperatures: -840,000,000, 330,002,000, column size: 6.961
    MiB
    probe prep: set_pgidle, filter: allow pgidle_unset (weight: 1)
    intervals: sample 5 ms aggr 100 ms (max probe hits 20)
    #   size         address       age           probe_hits
    0   8.000 KiB    127.990 TiB   8.700 s       0
    1   120.000 KiB  127.990 TiB   8.600 s       0
    2   55.543 MiB   127.183 TiB   8.400 s       0
    3   110.008 MiB  127.183 TiB   8.300 s       0
    4   55.352 MiB   127.183 TiB   8.100 s       0
    5   55.605 MiB   127.183 TiB   8 s           0
    6   55.691 MiB   85.355 TiB    7.900 s       0
    7   54.430 MiB   127.183 TiB   7.900 s       0
    8   50.391 MiB   127.183 TiB   6.900 s       0
    9   18.879 MiB   85.355 TiB    6 s           0
    10  52.844 MiB   127.183 TiB   3.500 s       0
    11  48.039 MiB   127.183 TiB   3.300 s       20
    12  4.000 KiB    127.990 TiB   8.500 s       20
    memory bw estimate: 0 B per second
    total size: 556.910 MiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

[1] https://github.com/sjp38/masim
[2] https://github.com/damonitor/damo

SJ Park (5):
  mm/damon/vaddr: support prep_probes
  mm/damon/paddr: move probe filter handling to ops-common
  mm/damon/vaddr: support apply_probe
  mm/damon/vaddr: extend apply_probes() for hugetlb
  mm/damon/vaddr: support pgidle_unset probe filter type

 mm/damon/ops-common.c |  32 ++++++
 mm/damon/ops-common.h |   2 +
 mm/damon/paddr.c      |  23 +----
 mm/damon/vaddr.c      | 232 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 267 insertions(+), 22 deletions(-)


base-commit: 59446eebc45959fe2d899aeeb301c8df6a1eaf04
-- 
2.47.3
