Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905F1D5CD4
	for <damon@lists.linux.dev>; Mon,  3 Feb 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623378; cv=none; b=EzyJawVuXcQXfOOiaoxMjWzXVifnqW+ONyULeNhGCKvardUWSbiMouyIVu0yM5p2W8G4+oKhaXsNobcTGWDrqtO8t+J2CRdjdBWYVxU1nK5T1GZcExRVx5srxceQXwDeLZEsmt0g/vyc9esmbTdFjzgkIJJtgJdjMd22CKiskHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623378; c=relaxed/simple;
	bh=q3msv5Fr9o1PH681GAa2rjVuBo2CPNgUaAIBcTA6MCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2hIqyx52KNDRN/05EwxjhrIDDuHhnC9c93yEp9tFjzEt57cMfHGIMLRNxZSZnmC4g1LLCkIPf3YtnMHuCGxeP+BBOEDUW78WTZoNNxiOo+y7otY8/sW0+7AayWwjXhcJefPL+rBpmyiJt/QMDqd3JY/prqQDKz27v+KmQ1zNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8CnDRI3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8CnDRI3"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7bcf32a6582so441523685a.1
        for <damon@lists.linux.dev>; Mon, 03 Feb 2025 14:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623374; x=1739228174; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMSYI+lCJFhGZA6hMY5/xBsys03sqH3X3JuX0L1RK/o=;
        b=F8CnDRI35Op+jZseBo2f0FP4F6/vO7u2TKUZUOFcCnM4RSioVzx2TR/rp54T5tnOqB
         vfo6Ry42fgH8aEqMTnCZlm+5pkT0qg1cOolBjm7RgDvBXlQHn5qegF7I7Wrm3ej/TJc8
         zAfysr5LkdR8j7KpSda2kcJ44qMO7Fkw0yRal2mXmd+x1Tj35NVChMrZEszSoCQp4ppD
         EJyT4bJ118/JQ8t+C496h4kZyGzGqMq+SJA55ItIklUDcEWhqQ1tmoAVU3+BcSMFNFMI
         mOCOp6wLw2v+xIe/tZbKgw8+W3fYGMBt37EkVGfkY7XlIVswi9rQ+XF9nqQtjt9BRyXm
         T3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623374; x=1739228174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMSYI+lCJFhGZA6hMY5/xBsys03sqH3X3JuX0L1RK/o=;
        b=piMshyXLIqYkSjnAJwWutJy8Q3k84ToVgxMPSDudV+BoS94UUGSpwKrRzPYkqvmb8Z
         nIoyDyDfmGyqshfZPlOdMKTN9ZPNVthP1FuzVpDeBcIS6ken1/sdsRDLOyWfw4mjFUQ9
         wcOmOxVdmZwO3PLsMpEZPnFyEHgNol8exkesUfcuR/wju6cYaPaaBFVmcMmNfSHg6JxT
         k8I17oWb9sG2X18UdpShwTgvHpUMNvXTn5TyIw2xzSwGozI9Y72B4oVz8pkffkkMRMAS
         DfK1KozEg9Xvk35FqWaafPUn5KBE5Fbz8INDwxSxnHkkv9ZmUjH/qqB0JoWMGvpv8jUQ
         0/SQ==
X-Gm-Message-State: AOJu0Yz1E2mDLBUvxLNFXYHy3KpRJSKl1LbPYhcaYNaKktuBqwWh9Fto
	6e68Ql02gVaZ0oku9CbAG523xFkxaN/dvRxC32WPsCs0p+d6ieaw
X-Gm-Gg: ASbGncsZ9mzpGeOrVQ2LM9lqwnk/IHV/kd/OjVKyXFY0bE0xqdHvMBL7++W6qdv1uUH
	Nbu7PVlunMc73Sj1pgZjXnjRNpkCFMIQlKt5rXXNjw7TfZ02gPmfbZ+aLqjXqhizv/k2wnAYqBD
	D6Ig0g9E/sEtIAEBjDV6JGRtMpD7lqdZwcwlazejoBE7geIzvn+XayZi4FA1BVA+ydhcQ3sc+Gp
	6+R5sp8Qq/FZhJoqVv2TfK1MU6LTc0Mj7uKVjUImtz2ePz4Vrdg3EOpkKC3oXSveQQUoVmvl3VP
	Hpjza8VRVN1S
X-Google-Smtp-Source: AGHT+IGjjhFQXztlwnTsudV0QsG8PT/MiBMppZmrjKrzfjvLqVzJ9k+wbPIL2RvU+u0uVLjTSCa2fQ==
X-Received: by 2002:a05:620a:3706:b0:7b6:6e7c:8efc with SMTP id af79cd13be357-7bffcd95828mr3626672085a.44.1738623374063;
        Mon, 03 Feb 2025 14:56:14 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:8::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90cc5asm574031785a.94.2025.02.03.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:12 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 0/6] mm/damon: add support for hugepages
Date: Mon,  3 Feb 2025 22:55:27 +0000
Message-ID: <20250203225604.44742-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This includes adding support for larger folios in damon for paddr,
which means largers folios will have their access checked and will
be considered for different DAMOS actions like pageout, prioritization
and migration.

Patches 3-6 add support for DAMOS hugepage filter type. This is to
gather statistics to check if memory regions of specific access
tempratures are backed by hugepages of a size in a specific
range. This filter can help to observe and prove the effectivenes of
different schemes for shrinking/collapsing hugepages.

I have kept patches 1-2 as part of these series as the later patches
are dependent on them.

The corresponding damo PR is at https://github.com/damonitor/damo/pull/20.

v3 -> v4:
- Add support for large folios of all sizes, and not just
  PMD mapped hugepages (David and SJ).
- only get folio while checking access/ applying DAMOS
  scheme if the head page is also part of that region.

v2 -> v3:
- expose hugepage via sysfs even if the kernel is
  built without hugepage support. DAMON will just
  just return 0. (SJ Park)

v1 -> v2:
- Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
  CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)

Usama Arif (6):
  mm/damon: have damon_get_folio return folio even for tail pages
  mm/damon/paddr: use damon_get_folio_in_region to obtain folio
  mm/damon/sysfs-schemes: add files for setting damos_filter->folio_size
  mm/damon: introduce DAMOS filter type hugepage
  Docs/ABI/damon: document DAMOS sysfs files to set the min/max
    folio_size
  Docs/admin-guide/mm/damon/usage: Document hugepage filter type

 .../ABI/testing/sysfs-kernel-mm-damon         | 12 +++
 Documentation/admin-guide/mm/damon/usage.rst  | 17 +++--
 include/linux/damon.h                         | 13 ++++
 mm/damon/core.c                               |  3 +
 mm/damon/ops-common.c                         |  2 +-
 mm/damon/paddr.c                              | 75 +++++++++++++++----
 mm/damon/sysfs-schemes.c                      | 54 +++++++++++++
 7 files changed, 151 insertions(+), 25 deletions(-)

-- 
2.43.5

