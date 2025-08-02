Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BD20298E
	for <damon@lists.linux.dev>; Sat,  2 Aug 2025 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135583; cv=none; b=Bz7+lLea44TchDqnhwinuFJvk5QviEEU7J8nNGFlVBrm2DuPWT6FSgtTFCa4lQ/G7ySy2NPSQjlqbb4cvALiEQjiawW168K2TmyhE2L6oJde3s1BBivvz+FC8eK0No3ZKr615frdLKdnC9bCMVDpAaEtK8LKpv8zH0weJObDOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135583; c=relaxed/simple;
	bh=71ZL9LBNhhUMIeFnhgEDkAnFQJ1NURNlSVq8LbY+WKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nR8uf09VaxsDrrpw9FX7ZcZvptBduXhdBFO1TWy06TxD38K6Obnl9VOl/nGIypfCOslhuFBzwMH6bBhk01Rdi4xWaQjhnUvXrNsaBK7QhRrMuLUELp4Ejpg09vTE870CxbDjbvNNLYCtA6i1+oX0mT9EYAhvnIf/lEP6nFOpJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdzVncki; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdzVncki"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af94e75445dso67911066b.0
        for <damon@lists.linux.dev>; Sat, 02 Aug 2025 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754135580; x=1754740380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4brAoBW23LGCc+VB07OY1whyNY3DMBmIf8Vmk+ZO+U=;
        b=IdzVnckiLdg5KY93CqVzbM820t97OuZQfN9DVwNgYSiY5Te2vqLtcyQ960I9cwN9GK
         ztDJhUGp10+imXy7CJy7bqhDCPKNdSgHKdndL8w0kFvnCfwql/bLplEEuqq7JH+LQ4C+
         FAkflyHaktWNkQ6+HK0oBJeIlcSLoctXUWMpmwbOgtyeH0Ct7niwh0Mh721EPlwRQA9i
         Rvq8t7D9pcZr1QPfUx6Tyas7HFGEI2Tb/zIOV1jD+pRhvZ6vXxI0QzTXwcd8SsPTxZql
         C5KkO8i3/yoA5pVKV5VnsRwpJv8/lVPrIrWmRbdiJJ5WIvMSWNOCA1TP447VyjVj0d4E
         Vu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754135580; x=1754740380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4brAoBW23LGCc+VB07OY1whyNY3DMBmIf8Vmk+ZO+U=;
        b=a2h+TbkrftRGGZ0n1+k4GJYEDkg3dRrjOSVJEq+zd4Fm3Xv/V83La8d5ZJxRVtiop6
         /0wa/K0isPa8cLk6gR6AVjg/izeDcVOJTt0EH9jzU6IaO2EX7ee9IcJ8cHxFH1tJgmoE
         mWiZlQx2A9wFhE8eo9j3EeZ5gINjWYdY2e/+OFpgEkLSADA8olY8UW+7Thg+qARHEeLc
         4lbJT/mra44Xy7sMmoLl5zV6KRoEGdjeZNh02GDDQLEDx9EVvi+wiJx89xtn5D9loCes
         BdJMTuQAMlOppqR4Y1BAdGOPkO7ttY8c85f4vFwZQwBLzjRIQuOJrB6n6gc/SwI95cOA
         8OcA==
X-Gm-Message-State: AOJu0YyhML7rxKlyDU13j7PtbW25iseKD/yBEohGMSdgR1hljW3XDPyr
	ecKL8WJP+Uj2dww14llccRWBIkmkTTlE6r7M490Key7Jwf4msOLrGq6M
X-Gm-Gg: ASbGnctCz0ZpiyKzFLsrOexH6iZUj0EZ+wOnr4EYAz6fgbESXrblo9fqCw5ly6rdogS
	U9lGa19HYDNZVArXrL5BoYA4bbX5Ac03FYZtvS3trZJSNJh1Gn9QdddfepCb32MNTdXnTC2+P15
	aTCBfrZsf1XUfg1KCqqGkFQCCjHLTMO+66QJO9idYSdOm/PLu08LY26QFu6qSRJZjnuaJzl5cJ0
	izw7agwtQIj5OWirji03WAS6kpXM4tmSj65IMfrw0LXFO+aEt7nzD1j5zfR03Ee/Jhcu6fnX1vX
	foAE6OObiL7VK+qFx2T/Qo57501IAeSjSx6IR37dVTi3Uqj+6ZOxqyiA43D8iNSwW5b8dvgezMo
	XUKG4lRUNQRncW6p0LFaN7emod/b6p0dabsDWWw2aV9+P1fEIAIDBBvWjV7BpaSgrVfYwQ+M=
X-Google-Smtp-Source: AGHT+IHEgBsjwBarO7mciGajTi+ctVhNkkYuFAQHrt27NjJPcufQ7mQqgDlCHZbivMVkWnO16U7EBg==
X-Received: by 2002:a17:907:3d90:b0:ae0:c6fa:ef45 with SMTP id a640c23a62f3a-af9401a5325mr328832866b.41.1754135579295;
        Sat, 02 Aug 2025 04:52:59 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0753f9sm425028166b.20.2025.08.02.04.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 04:52:58 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v4 0/2] mm/damon/vaddr: support stat-purpose DAMOS filters
Date: Sat,  2 Aug 2025 11:52:44 +0000
Message-ID: <cover.1754135312.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMOS_STAT handling of the DAMON operations sets for virtual
address spaces for ops-level DAMOS filters.

Functionality Test
==================
I wrote a small test program which allocates 10GB of DRAM, use 
madvise(MADV_HUGEPAGE) to convert the base pages to 2MB huge pages
Then my program does the following things in order:
1. Write sequentially to the whole 10GB region
2. Read the first 5GB region sequentially for 10 times
3. Sleep 5s
4. Read the second 5GB region sequentially for 10 times

With a proper damon setting, we are expected to see df-passed to be 10GB
and hot region move around with the read

$ # Start DAMON
$ sudo ./damo/damo start "./my_test/test" --monitoring_intervals 100ms\
1s 2s

$ # Show DAMON-generated access pattern snapshot
$ sudo ./damo/damo report access --snapshot_damos_filter allow \
hugepage_size 2MiB 2MiB
    heatmap:
    # min/max temperatures: -600,000,000, 100,001,000, column size: 137.352 MiB
    intervals: sample 100 ms aggr 1 s (max access hz 10)
    # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
    df-pass:
    # min/max temperatures: -400,000,000, 100,001,000, column size: 128.031 MiB
    0   addr 85.373 TiB   size 745.555 MiB access 0 hz   age 6 s           df-passed 0 B
    1   addr 127.608 TiB  size 877.664 MiB access 3.000 hz age 0 ns          df-passed 878.000 MiB
    2   addr 127.609 TiB  size 219.418 MiB access 2.000 hz age 0 ns          df-passed 220.000 MiB
    3   addr 127.609 TiB  size 316.613 MiB access 1.000 hz age 1 s           df-passed 316.000 MiB
    4   addr 127.609 TiB  size 474.922 MiB access 1.000 hz age 1 s           df-passed 476.000 MiB
    5   addr 127.610 TiB  size 407.188 MiB access 1.000 hz age 0 ns          df-passed 406.000 MiB
    6   addr 127.610 TiB  size 610.781 MiB access 1.000 hz age 0 ns          df-passed 612.000 MiB
    7   addr 127.611 TiB  size 697.309 MiB access 0 hz   age 0 ns          df-passed 696.000 MiB
    8   addr 127.611 TiB  size 77.480 MiB  access 1.000 hz age 0 ns          df-passed 78.000 MiB
    9   addr 127.611 TiB  size 573.102 MiB access 1.000 hz age 0 ns          df-passed 574.000 MiB
    10  addr 127.612 TiB  size 245.617 MiB access 2.000 hz age 0 ns          df-passed 246.000 MiB
    11  addr 127.612 TiB  size 295.102 MiB access 1.000 hz age 1 s           df-passed 294.000 MiB
    12  addr 127.612 TiB  size 295.105 MiB access 1.000 hz age 1 s           df-passed 296.000 MiB
    13  addr 127.613 TiB  size 67.172 MiB  access 1.000 hz age 1 s           df-passed 66.000 MiB
    14  addr 127.613 TiB  size 604.570 MiB access 0 hz   age 1 s           df-passed 606.000 MiB
    15  addr 127.613 TiB  size 389.578 MiB access 0 hz   age 4 s           df-passed 388.000 MiB
    16  addr 127.614 TiB  size 259.719 MiB access 0 hz   age 4 s           df-passed 260.000 MiB
    17  addr 127.614 TiB  size 817.941 MiB access 0 hz   age 4 s           df-passed 818.000 MiB
    18  addr 127.615 TiB  size 204.488 MiB access 0 hz   age 4 s           df-passed 204.000 MiB
    19  addr 127.615 TiB  size 730.902 MiB access 0 hz   age 4 s           df-passed 732.000 MiB
    20  addr 127.616 TiB  size 182.727 MiB access 0 hz   age 4 s           df-passed 182.000 MiB
    21  addr 127.616 TiB  size 926.824 MiB access 0 hz   age 2 s           df-passed 928.000 MiB
    22  addr 127.617 TiB  size 102.984 MiB access 0 hz   age 2 s           df-passed 102.000 MiB
    23  addr 127.617 TiB  size 86.527 MiB  access 0 hz   age 2 s           df-passed 86.000 MiB
    24  addr 127.617 TiB  size 778.777 MiB access 0 hz   age 2 s           df-passed 776.000 MiB
    25  addr 127.999 TiB  size 132.000 KiB access 0 hz   age 6 s           df-passed 0 B
    memory bw estimate: 6.524 GiB per second  df-passed: 6.527 GiB per second
    total size: 10.731 GiB  df-passed 10.000 GiB
    record DAMON intervals: sample 100 ms, aggr 1 s


$ # Show DAMON-generated access pattern snapshot again
$ sudo ./damo/damo report access --snapshot_damos_filter allow \
hugepage_size 2MiB 2MiB
    heatmap:
    # min/max temperatures: -1,100,000,000, 2,000, column size: 137.352 MiB
    intervals: sample 100 ms aggr 1 s (max access hz 10)
    # damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
    df-pass:
    # min/max temperatures: -900,000,000, 2,000, column size: 128.031 MiB
    0   addr 85.373 TiB   size 745.555 MiB access 0 hz   age 11 s          df-passed 0 B
    1   addr 127.608 TiB  size 579.715 MiB access 2.000 hz age 0 ns          df-passed 580.000 MiB
    2   addr 127.608 TiB  size 144.930 MiB access 2.000 hz age 0 ns          df-passed 146.000 MiB
    3   addr 127.608 TiB  size 452.453 MiB access 2.000 hz age 0 ns          df-passed 452.000 MiB
    4   addr 127.609 TiB  size 113.117 MiB access 1.000 hz age 0 ns          df-passed 114.000 MiB
    5   addr 127.609 TiB  size 182.367 MiB access 2.000 hz age 0 ns          df-passed 182.000 MiB
    6   addr 127.609 TiB  size 182.371 MiB access 2.000 hz age 0 ns          df-passed 182.000 MiB
    7   addr 127.609 TiB  size 350.488 MiB access 1.000 hz age 0 ns          df-passed 350.000 MiB
    8   addr 127.610 TiB  size 525.738 MiB access 1.000 hz age 0 ns          df-passed 526.000 MiB
    9   addr 127.610 TiB  size 401.352 MiB access 1.000 hz age 0 ns          df-passed 402.000 MiB
    10  addr 127.611 TiB  size 100.340 MiB access 1.000 hz age 0 ns          df-passed 100.000 MiB
    11  addr 127.611 TiB  size 19.523 MiB  access 0 hz   age 0 ns          df-passed 20.000 MiB
    12  addr 127.611 TiB  size 175.727 MiB access 0 hz   age 0 ns          df-passed 176.000 MiB
    13  addr 127.611 TiB  size 106.629 MiB access 0 hz   age 0 ns          df-passed 106.000 MiB
    14  addr 127.611 TiB  size 959.676 MiB access 0 hz   age 0 ns          df-passed 960.000 MiB
    15  addr 127.612 TiB  size 424.469 MiB access 1.000 hz age 0 ns          df-passed 424.000 MiB
    16  addr 127.612 TiB  size 424.469 MiB access 1.000 hz age 0 ns          df-passed 424.000 MiB
    17  addr 127.613 TiB  size 201.648 MiB access 0 hz   age 6 s           df-passed 202.000 MiB
    18  addr 127.613 TiB  size 806.609 MiB access 0 hz   age 6 s           df-passed 806.000 MiB
    19  addr 127.614 TiB  size 862.125 MiB access 0 hz   age 9 s           df-passed 862.000 MiB
    20  addr 127.614 TiB  size 215.535 MiB access 0 hz   age 9 s           df-passed 216.000 MiB
    21  addr 127.615 TiB  size 104.500 MiB access 0 hz   age 9 s           df-passed 104.000 MiB
    22  addr 127.615 TiB  size 940.523 MiB access 0 hz   age 9 s           df-passed 942.000 MiB
    23  addr 127.616 TiB  size 640.281 MiB access 0 hz   age 7 s           df-passed 640.000 MiB
    24  addr 127.616 TiB  size 426.855 MiB access 0 hz   age 7 s           df-passed 426.000 MiB
    25  addr 127.617 TiB  size 90.105 MiB  access 0 hz   age 7 s           df-passed 90.000 MiB
    26  addr 127.617 TiB  size 810.965 MiB access 0 hz   age 7 s           df-passed 808.000 MiB
    27  addr 127.999 TiB  size 132.000 KiB access 0 hz   age 11 s          df-passed 0 B
    memory bw estimate: 5.297 GiB per second  df-passed: 5.297 GiB per second
    total size: 10.731 GiB  df-passed 10.000 GiB
    record DAMON intervals: sample 100 ms, aggr 1 s

As you can see the total df-passed region is 10GiB and the hot region
moves as the seq read keeps going

Revision History
================
Changes from v3 [3]:
- Fix some naming issues and improper text in cover letter raise by SJ.

Changes from v2 [2]:
- Fix some naming and format issues raised by SJ.

Changes from v1 [1]:
- Follow David's advise to combine *pmd_entry() and *pte_entry() into
  one. Also remove manually setting walk->action
- Use vma_normal_page and vma_normal_page_pmd instead of damon_get_folio
  to remove redundant folio_get and folio_put
- Follow SJ's advise to only move damon_pa_scheme_has_filter to
  ops-common
- Change the command used in cover-letter for more natural illustration

[1] https://lore.kernel.org/all/cover.1753794408.git.pyyjason@gmail.com/
[2] https://lore.kernel.org/all/cover.1753895066.git.pyyjason@gmail.com/
[3] https://lore.kernel.org/all/cover.1754088635.git.pyyjason@gmail.com/

Yueyang Pan (2):
  mm/damon/paddr: move filters existence check function to ops-common
  mm/damon/vaddr: support stat-purpose DAMOS filters

 mm/damon/ops-common.c |   9 ++++
 mm/damon/ops-common.h |   2 +
 mm/damon/paddr.c      |  11 +----
 mm/damon/vaddr.c      | 103 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.43.0

