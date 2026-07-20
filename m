Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE5388873
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516621; cv=none; b=N1hf7lHS9igyb0v/VApdeXwQEqBoG4+No64dy/MoCbWlAD2iM/k8e52PShgRgAKYHBgWsd/8GGVd4/CXCas5c1FNLn4XxGaquERYrBSwORSo6cgZlyoHL5cq2e3BuTwcF12+DMK3QnCn0tl5vgjD5qbteUnU9BbsqEJoDl0/GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516621; c=relaxed/simple;
	bh=Bqh/sq4KPhx3AnFg+RiqqCU8cfWV/1rPo0hZzmm7aOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G20gaXxnhI6BoOJByEFOgzgRYYK28KjZSpvFCNVk7qV+x+hCJgqnjC2WM2CeiR1YxTcybj4clCW3kJP5pic2TV6igIPaLNNPFzc0Ps1U8Gr1vVN/1fVkSWC4OlFiDiIgxp/csd3budGDjlsUZ9pAHpVICoXVl8KlJKGfS2BYsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuWbkxRx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuWbkxRx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caced6038eso45197765ad.0
        for <damon@lists.linux.dev>; Sun, 19 Jul 2026 20:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784516619; x=1785121419; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Enmu8Zl/5+J0ooluJh3kcPVk/sYivrIeh8Ayq7SQkGw=;
        b=WuWbkxRxwr66SbsLnCNoznN+/lUDZizHkRWLY0FH8RMEbviNb2mYQZsEXQcCqFm3zT
         /HEK/q0OMa1xTDLXkr6jdL+OW8unUzjaFgNP7OWsn3ZB+2U1D+TxrGdOPGeOHJB4ic7h
         hgfDkUR2PaPp4T/N2wRP7U1gVOcjbBkcsUOim4QwysSG5Raja4wFqdRG/pGCA8Dvym88
         QF7AbXQEAKYoSAcpW6KLro0T1cftcOlTwdZXgbFC8IDbXG5J6iobSMqstscW7473GUqg
         TOn12f+VqymJYcFkY5tWXzlvJUuDxz+Us28L/xRed41zGydyNridjiurxOwUOcOmo9iI
         AcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784516619; x=1785121419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Enmu8Zl/5+J0ooluJh3kcPVk/sYivrIeh8Ayq7SQkGw=;
        b=ZKs7xLL9mWp2S+ZRojXxZxd4Bto8j4griNa3wyfroGtclXq9RFNQ1clWWsMlHWSLiA
         yj/DR1H0Y5Ugc2qaAMetCJIdmHogAIqWc+IIXIGJMZBmVrL/IYWF3gYvz2gW/W8W8pcR
         OVEHXZDR7vKuQ4QVvnjJSp5hcBi1505CoZigbE86ooz2TEsM8YqY7Dw8abg+7Nj0Yy5M
         QexLgyg/MVNKcYS5oTGMIs1lIYitfl3eu0KpEObfhyES8hE3h3n68qQKmtq/XHrJDoAI
         qpe24tlfdoSyvPwgTvxSTWiKhtH+1xDYlBhUFT3zMnpKNYCXXN1/hw/Aqk2SDbt7jUYz
         TMlQ==
X-Gm-Message-State: AOJu0YxxHOW075qrBaXkLj5sO1vaBdUuF5NoKsm9UuekQZ0s24/bndTW
	yiFpwleMH37a+Ytvlj7clJVicxixETx64QbHtHvtV0AfagJnk8ZfsDFIYUO3OjkN
X-Gm-Gg: AfdE7cn0XEjIs6KmrSUUJ67jhnapT0DGLzppvWqPCtqDgyI7IWTrGTJ/V+Zy4s+T5f4
	7E+uG/3mzzI2NeBeLFgMjAOr97vc0ZZErnAIIO8ZplraX0K1mDhr7JH9jJPOIH0Md3I/WOn6MRm
	wLqJe3AFBMuZP+vk6tug6+TDhIkZCGz1wNTPJbOib2ZFRThePuuTndy87pyi/qFlg0Cfk5I+tZS
	ful3Ezax3y+IZjmCl5mFGwwflJ0w3rTTS2D7I4h+tHzxeoCbdcRSbS8TD43TiZ5x/0OkRaFiVSv
	ejxYaBNPtBhyv4TApapE052zeaTJsbM53z0U7y8PvbQ8xK+VBXeZUNXW0mZhdiD+fnWJEIUrsLD
	PTZBUvJ81MfwjaqTWmbAnPLXq/b5EOFh3zJ3J0BQuKJVz92mvVa5UIpu9hqnfE2c3lJT0Z/YpAR
	KugQhppuStRphz3oM3Fefy5zIHNQM=
X-Received: by 2002:a17:902:b107:b0:2cc:86d6:24cc with SMTP id d9443c01a7336-2cf3484449fmr82277405ad.4.1784516618806;
        Sun, 19 Jul 2026 20:03:38 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344d80e6sm47783065ad.29.2026.07.19.20.03.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 20:03:38 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
Date: Mon, 20 Jul 2026 11:03:24 +0800
Message-ID: <20260720030327.80153-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_SPLIT splits large folios in a target region down to a
configured target order, using the existing split_folio_to_order().
No new core-mm code or exported symbols are introduced.

Based on mm-unstable at 61cccb8363fc ("mm/swap, PM: hibernate:
atomically replace hibernation pin").

Different addresses within a PMD-mapped folio resolve to the same
PMD Accessed bit.  Accesses to a small part of the folio can
therefore coarsen DAMON's observed hot set relative to the actual
working set.

DAMOS already provides promotion actions (HUGEPAGE, COLLAPSE) but
has no corresponding demotion action.  DAMOS_SPLIT fills this gap.
It is a mechanism, not a policy -- it does not decide which folios
to split.  Selection is left to DAMON's existing access patterns,
filters, and future probe/PMU signals.

target_order selects the split target: 0 for order-0 base pages,
or a supported smaller mTHP order.  Both anonymous and file-backed
folios are supported.  The locking follows split_huge_pages_in_pid()
in mm/huge_memory.c.

Tests
=====

damos_split.py (VM + Kunpeng 920):
  anon THP -> order-0 split: PASS

sangfor_exp.py (Kunpeng 920, tmpfs, 4096 MiB):

  - Created a 4 GiB PMD-mapped tmpfs workload.
  - Applied DAMOS_SPLIT with target_order=0.
  - ShmemPmdMapped dropped from 4194304 KiB to 0 in every round.
  - Repeated for five rounds without functional failures.

The functional selftest (damos_split.py) is included in this series.
Additional experiment scripts and raw results are available on
request.  Performance characterization using masim [1] and KMB [2]
is in progress.

[1] https://github.com/sjp38/masim
[2] https://gitee.com/OpenCloudOS/kernel-multi-bench

Open questions
==============

- Selection policy: this series keeps folio selection outside the
  action and relies on DAMOS access patterns, filters, and quotas.
  Is this the appropriate layering for future probe-based signals?

- Hysteresis: khugepaged may re-collapse a just-split folio.
  Should cooldown live in DAMON policy or khugepaged?

- File-backed folios: adjust target_order upward to filesystem
  minimum, or keep current "fail and skip"?

Beyond the action API itself, feedback on real workloads that need
proactive large-folio demotion is particularly welcome.  Follow-up
work will evaluate candidate selection signals, including DAMON
probes and hardware-assisted sampling, as well as target-order
selection and split/collapse hysteresis.  Those policies are
intentionally kept outside this series.

Changes since v2 [3]
====================

- Split-only series (collapse deferred).
- Dropped SPE feedback (mechanism/policy separation).
- DAMOS_MTHP_SPLIT -> DAMOS_SPLIT.
- order field in existing union (no struct size increase).
- Added functional selftest (damos_split.py).
- checkpatch: 0 errors, 0 warnings.

[3] https://lore.kernel.org/20260701123000.00000-1-lianux.mm@gmail.com/

Lian Wang (Processmission) (3):
  mm/damon: introduce DAMOS_SPLIT action
  mm/damon/vaddr: implement DAMOS_SPLIT handler
  selftests/damon: add functional test for DAMOS_SPLIT

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
 Documentation/mm/damon/design.rst             |  5 +
 include/linux/damon.h                         | 15 ++-
 mm/damon/core.c                               |  2 +
 mm/damon/sysfs-schemes.c                      | 48 +++++++
 mm/damon/vaddr.c                              | 90 +++++++++++++
 tools/testing/selftests/damon/Makefile        |  1 +
 tools/testing/selftests/damon/_damon_sysfs.py |  9 +-
 tools/testing/selftests/damon/damos_split.py  | 99 +++++++++++++++
 tools/testing/selftests/damon/sysfs.py        | 11 +-
 10 files changed, 279 insertions(+), 8 deletions(-)
