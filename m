Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291462DC34F
	for <damon@lists.linux.dev>; Wed, 30 Jul 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896003; cv=none; b=dFNHck0WUo6Ay8+fIz6icus+LwDCZbD1Ua0qYairpfeTOPWXjktMq0V3qtdCgEI3a9pJ+IfT2K9CK8uEuxHrT4giVeZHc84+AMRq9NG6gNjTWAI0xqsQkeyoo1FPWQI4jhqEu63X5c4GuxrnnN7TuAPwkB8W4wzJWMXbOeoKdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896003; c=relaxed/simple;
	bh=AcAhv9q5vTu1g4k0gz+3jIhEurYESvb07bGDGjZaNeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bW0coas6iar6PjAiYLyBJ+UpQYYHiDmQ5nB+UY4Nw0XzOm41gDLInVXTegv7aqWSBx0L1SJG42PoKPKrjZ2LFtZxcnFDDZFxOOxJBD14J37r8seZO+/OVMKXrT2OrUrymUbGThDmm/EOp/fWrWtM4nTjeXa8ZLgTcTaGEMHqdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX2i/iue; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX2i/iue"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b794a013bcso59806f8f.2
        for <damon@lists.linux.dev>; Wed, 30 Jul 2025 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753895999; x=1754500799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LSHcQ0idAwPKDvX8EE25U8/JSS0uYFnXe2HDNHqMNY=;
        b=SX2i/iueOOjwroqoddivMYI5KH/Ru+Ca6sCquJ1hf9dTWGMvmsjutleY96zpuxVxYB
         IeffvN3JemjzhfUkq0S1Oc2nB58woToM/6yYU6H/6fRmjCl4Jg76UhAZ2gMLBPK7o1qw
         DdJdfnf37vbBg4KRM2vd9K0cRDUwVUaTwuJbkR4OAuzCY0ZFmKnwrnVgwGQnIZd6bfUx
         1JPa4zUgDuPrf9bQ0Xms+wIhPRyVPJs7q4gxdZ8Mw+DK7/zMwhqlmYwgMDJwU7upQ4Mt
         snmw+K5LKGzDhVjFPsazLucljtLkEB2tf82KU5Z88fzKmF8Aq+ZQneAP+bvJckgDpGqq
         11/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895999; x=1754500799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LSHcQ0idAwPKDvX8EE25U8/JSS0uYFnXe2HDNHqMNY=;
        b=H2jzLXr0Mgtc6Q8lIROPyASygrbjtC4myiPRXSTfbO/7xEbYQu+ypgZNlLg5EUHu3A
         tXDGUJwOvDbb0MuaHhmIgjnWc5B+KkRsjlIOz39LafZd5R82nXR6FtbsL64rUYDofu0n
         K4fFWfAj8D3/ctYE4XbVn4WzElmOLct6ii1bV8sFCw29lhn2h6443ELqixPLMr0MFoKC
         35tVWuuto+IVI5a723r3RFyX0/HZBI7VY4nCd3IDhOL5deut4+HSh2eju9f5L05tNncn
         1TJ8RII2hSoR1WxcDAvBCc2TzA/fstBzAFbaxEgb+/5Y2J8w7GlpHBNVMqK9olOOzzpi
         J5XA==
X-Gm-Message-State: AOJu0YwhlB4NzLbPDpu2aBDVg4lADAfu2SU08J4x/p6TKvDnXIaIdwXo
	tUQTgyS2WszQm5qUgLeZMHzTYtitAXbvfE5ChaO8Dlma7Ukha1V01fNThRVZq6fsYJDq6Q==
X-Gm-Gg: ASbGncun9jP33MMDBickACTq87wgK2nQGPaoQ3mMLGHhzI2tBvgwv4VTZDvwcMs+lRQ
	bnBuvn7GnZpIE+wx3b900nFEhrSqDs+F6D0vVAmO475yyG9p6rjjqGZqhGvOPX/lLlO/qIjIiwv
	sdFlt0kwuzvz21uZ1F93YpUpK5Ns+xJis+YqyDeGObXldiFaOyO0yLC5fN+93g8RXs4fi9os/yc
	42A3DLa4Rp8fQ1sU9KkB0h3orsM+TtlbVJ3w3qnGNqCzSmDupyRa5Rx8NglEw3GWSZB21r0y6mI
	MQ6UQ0Tf1bryNXVPHnkarRwxSbuygwHJWlskQBX25nLMTutKGwb+T549rySlYdr79dqYHN7IIbf
	YQzZdVD/45xMMGAk=
X-Google-Smtp-Source: AGHT+IHHpOLorxoYWXm9QIh1oiahYntiaztlH+OhrVoWzA0q4E4cWgVlDniRm+8G6MBU9hzMPBToCQ==
X-Received: by 2002:a05:6000:3107:b0:3b7:8af8:b922 with SMTP id ffacd0b85a97d-3b794ffd8d8mr3068673f8f.34.1753895999181;
        Wed, 30 Jul 2025 10:19:59 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589aefaa44sm26603385e9.20.2025.07.30.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:19:58 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/damon: Add damos_stat support for vaddr
Date: Wed, 30 Jul 2025 10:19:54 -0700
Message-ID: <cover.1753895066.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously damos_stat only supoort paddr. This patch set adds support 
for damos_stat for vaddr. Also all different types of filters are 
supported. 

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

$ # Start damon record
$sudo ./damo/damo start "./my_test/test" --monitoring_intervals 100ms\
1s 2s

$ # damon report
$sudo ./damo/damo report access --snapshot_damos_filter allow \
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


$ # damon report again
$sudo ./damo/damo report access --snapshot_damos_filter allow \
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
Changes from v1 [1]:
- Follow David's advise to combine *pmd_entry() and *pte_entry() into
  one. Also remove manually setting walk->action
- Use vma_normal_page and vma_normal_page_pmd instead of damon_get_folio
  to remove redundant folio_get and folio_put
- Follow SJ's advise to only move damon_pa_scheme_has_filter to
  ops-common
- Change the command used in cover-letter for more natural illustration

[1] https://lore.kernel.org/all/cover.1753794408.git.pyyjason@gmail.com/

Yueyang Pan (2):
  mm/damon: Move has filter to ops-common
  mm/damon: Add damos_stat support for vaddr

 mm/damon/ops-common.c |   9 ++++
 mm/damon/ops-common.h |   2 +
 mm/damon/paddr.c      |  11 +----
 mm/damon/vaddr.c      | 105 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 11 deletions(-)

-- 
2.47.3

