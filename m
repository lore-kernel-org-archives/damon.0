Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3F6FB9
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277887; cv=none; b=Wc+VUk9XeGhX+pTjlIQBY3tLnm3vup3wZsX3y+jVZInG/SSOWggIg8ARO8qdjN5QYgHRyCWrFRSKwWZ/kLKh5LMnohuVZDPym7An+0EsQqZHmxsS3C1XoC4u/3qBQ3Z8lsM2lQFjb/aP0BrJgV3PAkvX+lCV55WyRiQSWu67ZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277887; c=relaxed/simple;
	bh=9AbMyjbM5U3u4bIkQU4Gva1xtuOsbjJRJr7zpzzTSQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0h4hCZ2NLpXqlGyQYYhvcIFi+VsGMY5NJtG/TBKOOqx2Znla2wv0mUpJNUTrUs9ZPWSJ0njUwBMQn80zMfks3/kQOXoc36hW5mdHq6ekEBf+xdJgeY3IiNWYWYIOd8+AjhKLZogaf7x+EQaaUJG6dxTgvINqFlviS4XWxtCqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE9q3SLL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE9q3SLL"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471953ab6d8so10142841cf.1
        for <damon@lists.linux.dev>; Tue, 11 Feb 2025 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739277885; x=1739882685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IF5/UBQxjFLH2+MQA16bJD+AsiCj/abxj48IwWLegK8=;
        b=hE9q3SLLaabvjb7glSgWQvsUMm3Te+wNJlV2Xu43sw3GhzRPay8J3Cx63FHa2o4mad
         u2UYs7AqflnLhQ9kJA29VzdR2DQZG/fiWQSsqiryyXLbSDdWQyqEMGkIVx/fH3ghO6HY
         g5iTHdGrYQU4NWfZwEKXkz3GAvbD+WM4bVRKq2jfqZYk74ZQZHeZPz46lfc5CKoZBEy5
         ZfRDV9JgdsRrS9dR4OZ7v7T6moUEBHc2v80f8j7Mss8L0Tmatr+YfjITowZ1zIu1blZy
         WdD+88r4kOdHMsHwR9HZ47yZnxO13HGxc0mo2pOLMFCN56TuEArEaH3ha5+16LWrLhH+
         flzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277885; x=1739882685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF5/UBQxjFLH2+MQA16bJD+AsiCj/abxj48IwWLegK8=;
        b=u47S9bA1rIY7xjYhyxcUhnIGoDLujAfp10F1Og+DydTWyFa22WX/HOuRbAvLd9XBtm
         vecwVxZ07iWQDioOkPTawmLn2tKnucqAGtuzWJn+LAJYJXHHfiY3fS2J5JJaDqrGV3ov
         XhxHu+suUTfx5LLji9oy3EqIPYynk0SNV01o9X/W1uOT3doxzmXPNISiyWqHG8hpAho0
         5qFHDFLshtSI6atrX9dp1hJuICdYOOZwRrFk62hlSzEYHFu97CfkHbQqQFMCx4JnVYsl
         kdsNESv5oC2sQU3v0D8XV18c5+9XiS112X1esGFnMR/+lNNvq2/f5o7hykecVrfji3hM
         GW8A==
X-Gm-Message-State: AOJu0YyrLfypSf/ovYITUMvnDVOuOZZ1rAnmFtfIux96q5Vo/xpZY3p4
	RHHWqvQRWmtY0yVVtcswwSTFV98odyNgugHbbbnkJklgBPlt8a2h
X-Gm-Gg: ASbGncv8HzNp98wJuM7W3oxkeXlOWRxhb0FxlJhwSPXODMi5piEGdpdQXOo9qdkS+34
	zfQ0EQmLJ5NHc2E8GWwIy7XMz87zB1rKVsOj+mDDMuuBjCjlLerCttbxRcORfh92Row2WOmcxr+
	3Z9AYXBbBcMAwTA9DX7mEZ62JFeJL9a9yl73tS0xFfo5L1CNsBRX3LTrg2B1qDVLIus4zlC9aA+
	VwkXNkVQ8uOL9f6YR4eamNeMgyUqkwHNxitIXUJWh3uzf9G8MlNHuIOVgZVoquOklRlXLZwX0JN
	yL3/RAPLeW3J
X-Google-Smtp-Source: AGHT+IEFVjHT/jHefoaC7k2UGiNiqMd0fmscMxk7+zYqsr0N+uXwEWATevEwg+hzZ8PW0AlVeKTbPw==
X-Received: by 2002:a05:622a:4c17:b0:471:a079:a506 with SMTP id d75a77b69052e-471a079a5bdmr47637541cf.2.1739277884941;
        Tue, 11 Feb 2025 04:44:44 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47180b1ca44sm35729031cf.76.2025.02.11.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:44:44 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 0/4] mm/damon: add support for hugepage_size DAMOS filter
Date: Tue, 11 Feb 2025 12:43:39 +0000
Message-ID: <20250211124437.278873-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1-2 from v4 which are a requirement for this series
were sent separately by SJ and are merged in mm-unstable.

hugepage_size DAMOS filter can be used to gather statistics to
check if memory regions of specific access tempratures are backed
by hugepages of a size in a specific range. This filter can help
to observe and prove the effectivenes of different schemes for
shrinking/collapsing hugepages.

v4 -> v5: (SJ)
- Drop patches 1-2 which were merged.
- change filter name from 'hugepage' -> 'hugepage_size'.
- change struct name from damon_folio_size to damon_size_range.

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

Usama Arif (4):
  mm/damon: introduce DAMOS filter type hugepage_size
  mm/damon/sysfs-schemes: add files for setting damos_filter->sz_range
  Docs/ABI/damon: document DAMOS sysfs files to set the min/max
    folio_size
  Docs/admin-guide/mm/damon/usage: Document hugepage_size filter type

 .../ABI/testing/sysfs-kernel-mm-damon         | 14 +++++
 Documentation/admin-guide/mm/damon/usage.rst  | 17 +++---
 include/linux/damon.h                         | 13 +++++
 mm/damon/core.c                               |  3 +
 mm/damon/paddr.c                              |  6 ++
 mm/damon/sysfs-schemes.c                      | 55 +++++++++++++++++++
 6 files changed, 100 insertions(+), 8 deletions(-)

-- 
2.43.5

