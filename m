Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E0151990
	for <damon@lists.linux.dev>; Tue, 18 Mar 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322632; cv=none; b=rkOWjj5KypWw6r5qcsVHahN/fvea1RZIqTYgUdTmjTvJuyyoiE66tCP/1e/cB9pcTlxx6GIgOVQXxtklw9/kkE/QcnDACRaibmWJull17n5Ok8GVfMaNFT6upUeyJO8fzY8gWa0IL6UuZssYE0qkssa/4jm5rNGZozSfH0Fxzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322632; c=relaxed/simple;
	bh=i5OfEoSljC+HbbhTACIKKpTdq1guqyC/ApD6p8ex79s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMT695iO37rDfvc1SYcu6S/h+yqNC6kSJ+1FDafD3O1qaHasoOsM9g3oEL2ifCml6H1fS5XGHeB4QznvdTYuYr487vyFZqvttV55dJEIkDTvsUe4AhZIjPPKEJtJQPl1uF1uRRZWEnxuogdgkIqlfscYHqKZ7V4flyNAOGDKZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWHsApk0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWHsApk0"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f7031ea11cso64717347b3.2
        for <damon@lists.linux.dev>; Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322630; x=1742927430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNwhYyHLUku5wWb6XEn1vDwJORz/NTg7eokwpgJAoks=;
        b=kWHsApk0UOyKq+deHAw8wJpGCITXjzg+1Zf2OXfN9EfmNr9cjh1wHrHmfBuE/67X3q
         Ck8sPCyJ8BGyY3knE1XoArAct/HHooVUtYQSPxLRnvBfNI3IBjC3YEY5ZWDx1tEKzcd2
         Jp/ZmTrAQzOsztwh81sy58swlVmum9KEcE05AXeXD7hRwBp/RrRF6zi3i+dnH1LOGI4O
         iJtWYuCeeCw19tTfn6OF39r0WnS5xtfuaGtmRaHCaU6xI69lIGCVV/Al7cP5kfSVq9rv
         9PhMDJML5OSvMja3RhbCJoNzZl2pBmnjNUPfdFloMmK6w1ediC6xh6bySg949wnlC/Bs
         Bz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322630; x=1742927430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNwhYyHLUku5wWb6XEn1vDwJORz/NTg7eokwpgJAoks=;
        b=JXHrnJ6NO2q8+FVP4c1WmNpQyo14sCSO+mz+8R6faycHTwTm+kL0bqh63hyW+YUm1/
         geCtzh8QqH4VmaYGAAlHLUKotol4xZFplieZZ/G/0Nn/3D3CqJHtBaID6LTV1V1F85ma
         FeOGJ7TUeU4pVKGN2qG9QHVEgK15e4h+yLUjAlSLQXGCTDlazZV4Cvd6nJ7Ww5KwbxiR
         DV3YBcavdFAKJd7wRIdaAduWbhO8dQA+lsnLK9uGFr963k+GVxpSjfnhN3Pd7mgceYAB
         dCnReuW1isyR0JckW1nAfKZFEdNjcyE7MvqmKFOzuyjEcg+3a5mvWp2KOSbSvb+sTfwM
         7/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW7FsFNVsXGwLNvOE+2iHY0idB6fLGxdnP9pJn3tTL0XTFAa+on0lgLpI/zzj8bDtqYucTrIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YygeNgtXS/jkVdfIfCIRS7DjcJMj9sxmgCY6aT3hTWNDtwa3W3t
	kfMWSQK4pnQiSddqJWelTb7gsUaV7v5wzsdTWhO+JSD2zaH+Al4u
X-Gm-Gg: ASbGnctw1sdGxeF+/wLzvMqKl7QZZRMvnc7vAK3fo56PFaH5cRdxD/IqvCHMuahAvYJ
	vYXmUHv59od+qKn3mpI8kCdvIue9PD7pvib6S/SU5VJJnGzEmNPisQCRpxsPCfZNgI1W3Nz8/Rl
	Y/dLGUNW5cGuAbOEE/f205ueXSG79NNpU2Mpgu2ZLeq0o1au8nkgiFBcriONqtWKr0iCA39q9ez
	2asH3DBivu0AQSQHeksvBykEwllPNh2TkJN0HaSvTyvseP3lrKNqeOrqAiQr3EGpE3Vi8aIVCK+
	YLYYdXgoAllwY+eysJgvMx5zffA7CdZuzPyV
X-Google-Smtp-Source: AGHT+IE4IZmkYAr1CYhWXfFj7jyE8tpcUyeBW1sCfCwj6z7X4tNm2KMPObQ5RHcAkj4MPiAxgpoWHA==
X-Received: by 2002:a05:690c:9985:b0:6ff:1fac:c4fc with SMTP id 00721157ae682-6ff460f42ccmr234534797b3.37.1742322630047;
        Tue, 18 Mar 2025 11:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm27095807b3.111.2025.03.18.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:30:29 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH 0/2] mm/damon: introduce DAMOS filter type for active pages
Date: Tue, 18 Mar 2025 11:30:27 -0700
Message-ID: <20250318183029.2062917-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory reclaim algorithm categorizes pages into active and inactive
lists, separately for file and anon pages. The system's performance
relies heavily on the (relative and absolute) accuracy of this
categorization.

This patch series add a new DAMOS filter for pages' activeness, giving
us visibility into the access frequency of the pages on each list. This
insight can help us diagnose issues with the active-inactive balancing
dynamics, and make decisions to optimize reclaim efficiency and memory
utilization.

For instance, we might decide to enable DAMON_LRU_SORT, if we find that
there are pages on the active list that are infrequently accessed, or
less frequently accessed than pages on the inactive list.

Nhat Pham (2):
  mm/damon: implement a new DAMOS filter type for active pages
  Docs/mm/damon/design: document active DAMOS filter type

 Documentation/mm/damon/design.rst | 2 ++
 include/linux/damon.h             | 2 ++
 mm/damon/paddr.c                  | 3 +++
 mm/damon/sysfs-schemes.c          | 1 +
 4 files changed, 8 insertions(+)


base-commit: 40caf747267c18b6206e26a37d6ea6b695236c11
-- 
2.47.1
