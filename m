Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A237FF75;
	Sun,  6 Sep 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720267; cv=none; b=fEruRSJ7zcUmnLv/WFniWiQAfnG5Ubn0R7YHTvQNoh9JCMQ+mZz6WXHERzP3+H+9ig+h6vFl9x92+XfZk744MEkQuY5cemIy0QvKEQD7BB8oR6/G7SLmv42uIuNey4FDIyyBLRRNPobYHyDlURUD/QEIBVuAVENxcKLocc/gvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720267; c=relaxed/simple;
	bh=j9s6UpVAXTgqlbWTZeNvqJg7avpjX/GYf3DVu5D+roE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yf1DiMCKyjExDPE6Xn0gh9GjcvY4rWvMMvaREJRC2IMKnSHa53BEnbeq6hsmLofiFxDt8KlQsW+gygQ+Wm0F0aDR9zwQF6CMzlXyxGXesEqv2QVRQlZSea0gzw8iMH73yfLNpCupgzOaOTRDP9piLFZ6i6RlvAseoeYICILwHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1zLryBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1zLryBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729B51F00A3A;
	Sun,  6 Sep 2026 18:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720264;
	bh=CVcnKGbYuQsroSfeo45+tXGpgp7HLrTB2fSqLj66N7w=;
	h=From:To:Cc:Subject:Date;
	b=O1zLryBc/iUX3iyFm4CLXnbyNTgqhfb4KtU5wDg0DzrK/Xm/xD9+MNeycr1x6I3/P
	 8biSDVOAOqdguqwaIFL7+7BvzRpQ7cca6uDEnzQqY9PF6cMKhaIwcWtTojKNgJ05r+
	 VeimpMln9miN2pKoGpZnJfE22Hg6P56fVqFLKfPhP0w6GTQVWZ4GXRNRGZqYwRQta/
	 wkPbTSuUi4KxSgnyCuDwyUWdsY47e/iaXVeMIDnr5nu6fXsB2njwJpet34EZbEhDP6
	 0n26HRNJV16+h64j1b0s5EFWUYUoJBoif6nFiMt5nUM0aWgVkZKotrmcepvRyZQouN
	 iICsSsewoWh8g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] mm/damon/vaddr: support {prep,apply}_probes
Date: Sun,  6 Sep 2026 11:44:10 -0700
Message-ID: <20260906184417.96621-1-sj@kernel.org>
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

Changes from RFC
- RFC: https://lore.kernel.org/20260905202634.88102-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.

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


base-commit: 87f579da3b3b652d1bf5ca71ccfd7e267807e8ac
-- 
2.47.3
