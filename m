Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C5191
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796186; cv=none; b=H/uZ743+qDfwqZNN29XEyYewseRm+aUEA9rJqMQb9zutx3LHKWrCuZrPneZKyWl98T2O/kUrOAGtU8nlXmT4Bc5/gkTE1Iw+uz2c+zRhVgzNh6mzOkIJRFSOkbNN5a7eFmK42T8AgBOmgk6S1uEOKVW1ITM6Nv/CNvvF9bbc5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796186; c=relaxed/simple;
	bh=MAgrbp7q9nQBnrKFs4ecXjBNKULUukoPmyPguYDaibU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHEj2KzjnkKr/ffS3jPItF+F7dFgrmdi02qaJfIXfNFgDGs3KoaiF3Sc+hCDEObziVf/0zu0MxQmsBtZgAsAKK722c8TVtqzziIOMSxnxAGKXLVZVdD5c4HWPTUqO4UkaNd7QXeOv0bvFbbzEG6+fsdYQZhZZ+eHx1o8zfArMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxbKa3V5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxbKa3V5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82748257f5fso904143b3a.1
        for <damon@lists.linux.dev>; Thu, 09 Apr 2026 21:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775796184; x=1776400984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFMB1FxXIFFJF8R3xMlXqM+VGggoB7XxMGsR8vdRK1I=;
        b=JxbKa3V5eOY/UALtBqf349XUgVh6O8iTUmibbsCFCO+hiPxSM62AIH7lbkeX22roFr
         FMUmR1wacZ/3B5IR10+6G8b+FWuMBuD6nN7MyQYg87EYWsPrY1kt2HJkc6aGHu4gXHT1
         aAaD2ZryPW0HfoY2yRCEFw32spZtHwDJmDHukJtJDJ2C8Wg31npip8rS2w/phoxQMGp2
         20Q5Xi8rJTkndyRhpDX+dnjUyDWh1aqh6pCaPSp3cE/blNbt+kgi4Dz4tBb0PEKE2yxh
         gM2giz5SsTYWrzIzppXDSUWPjYgsgQGXzSwNoFYX9hs2oiP0SWJ6sAVkoxiScA1JorPk
         XP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775796184; x=1776400984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFMB1FxXIFFJF8R3xMlXqM+VGggoB7XxMGsR8vdRK1I=;
        b=XUVbwNyPuZZ7u3vnMgwZs6kAH1QJKZlAhBcZJLPGTMDfmyviSbxz42WxaV3Oz3OnDy
         VK+cCB6qrq/aIADKRAMbAS3ilBnbaT3YvlwPIllwzkAgIqwgECImiKubm0z2ojjoen2U
         ZquL4vfFqJVacsIGSRjgkdCy+U1Y/H9evz5wPIPEjV8qvAooil+xoltynBmjkh9fDkSp
         X7styJD7nQQPia9cMLKSJ6Xc7qdHv4G8jO2fwuCOukJP6Xlal2hjkUaAx/2evWfdzeeJ
         rWhalDaCHZaV/J7IJboDZHKH7UTJul8/Gxu5K3L8J2RDpAMYUTvI85nc7WQtLwDV5n4j
         pRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD5NExifd2KeHYoz49WMXQRvWiwpaC3keyrs8di5FQ66fv8wm/vrtCnDYco7u9Zu5bGOPeRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUfv2HCBmX1ZH31tMLGzxrkGOcllbRTp0LsBM3UBP+gkaROL4l
	dDH+faeyPWA7rqfLySi6HwwplFR7iYmstGffk+wL9lPaToI58pzHndw7
X-Gm-Gg: AeBDieu877E+gJM+Cd6eUHVGIFzrI3aXQoRKEVpyfYCXEkU3o8vl2hxo7qE6MFeRFTc
	FeLNtGEmCwrOZWGH8qTNynGvwq4hHSrbMSrx9oG7yfcAoNIJAAl2jEEfMtaDAAdmaey3QXvWfux
	R62c6kHPl+8phARrrsr4wHJIRsysv5jhrwppq38xwuCSoFpTMW/nit5cFzOtwATH1zgfSFoPjRv
	88+wrxqktipypcxYibS5tUHeCnNS9f9X3/kJdeons/ksExfFW0yiZDY/a4yl69n9ncOuU32nRuy
	K88YwzLUU4iSqiePvppVyQwxlE9ZM7yJU/E6cWjViUBzWDt70zx+bZc2jo7gYQPVE6J5B6id+IT
	EcH1A9cISjJL7dCQquhiJBJr+chgKNltvtyo5ShiQ6yMW5LGJqXRuRapftVpBmdFJKuKnmXnJQb
	rbjAYBC+c09gsqNxbGVlaOl58+LYU=
X-Received: by 2002:a05:6a00:2e08:b0:82c:c390:ad77 with SMTP id d2e1a72fcca58-82dd8a1dbb5mr5459830b3a.7.1775796183969;
        Thu, 09 Apr 2026 21:43:03 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30e7besm1200109b3a.5.2026.04.09.21.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:43:03 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v4 0/2] mm/damon: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 12:42:57 +0800
Message-ID: <20260410044259.95877-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
When a user sets an invalid 'addr_unit' (e.g., 3) via
DAMON_LRU_SORT/DAMON_RECLAIM, 'min_region_sz' becomes a non-power-of-2
value. This value eventually reaches damon_commit_ctx(), which does:

    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

Although -EINVAL is returned, 'maybe_corrupted' is already set. The
running kdamond observers this flag and terminates unexpectedly.

"Unexpected termination" here means the kdamond exits without any user
request (e.g., not by writing 'N' to 'enabled').

User Impact
===========
Once kdamond terminates this way, it cannot be restarted via sysfs
because:

1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
   be unloaded and reloaded at runtime.
2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
   Writing 'Y' does nothing, as 'enabled' is already Y.

Solution
========
Add an early validation in damon_lru_sort_apply_parameters()
/damon_reclaim_apply_parameters() to check 'min_region_sz' before any
state change occurs. If it is non-power-of-2, return -EINVAL immediately,
preventing 'maybe_corrupted' from being set.

Patch 1 fixes the issue for DAMON_LRU_SORT.
Patch 2 fixes the issue for DAMON_RECLAIM.

Changes from v3
(https://lore.kernel.org/20260403052837.58063-1-aethernet65535@gmail.com)
- Improve commit message: clarify "unexpected termination".
- Add detailed User Impact with reason why kdamond cannot be restarted.
Changes from v2
(https://lore.kernel.org/20260402053756.26606-1-aethernet65535@gmail.com)
- Split the patch into two per-module patches.
- Add Fixes: and Cc: stable tags.
- Elaborate user impact and reproduction steps.
Changes from v1
(https://lore.kernel.org/20260331073231.30060-1-aethernet65535@gmail.com)
- Fix memory leak issue.
Changes from first attempt
(https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com)
- Renamed the subject.
- Validate min_region_sz rather than addr_unit.

Liew Rui Yan (2):
  mm/damon/lru_sort: validate min_region_size to be power of 2
  mm/damon/reclaim: validate min_region_size to be power of 2

 mm/damon/lru_sort.c | 5 +++++
 mm/damon/reclaim.c  | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.53.0

