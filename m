Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BB218845
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194156; cv=none; b=JEgxFXZIDOrEYKkMwAQRsuzIuF5jyIX0lhndO7LJIwKPIKpqZK+pdOq17xLqbareZBuCn3uYiLsENFzFDIc6b7RjQd3OAfrJEZ/elm/oA53K/Tgvpk0HpDf/23e4EY6L4Ierk8cVywUwd2OkUJGNuychX/rpYCUJF1kChP+5iKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194156; c=relaxed/simple;
	bh=vUzzg013NbFky0++XVPXvaSX2VpABICnfRaLzUqX7U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rrj+t+n/f+ZAODDCj88UQ0t3QTX+qbCTKw4tbQDR5TQamv8PceUF3Mvs5XEssiZ2kMDokAUkbcajV4qJoHXEsWb+Zj6V0HO5N7u4NtJ0klHuZVehimpefDQE3t7XOiu1/6ql4sUpZC9UTn3nFRPgb1RaPZaw5d9CflkF3zK3e3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuWUY6OI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuWUY6OI"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce49785a0so701354b3a.2
        for <damon@lists.linux.dev>; Thu, 02 Apr 2026 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775194155; x=1775798955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwVEBTN2pqE65yckg0LJLlK41X4ju08angcIWHyFOv0=;
        b=NuWUY6OIcujH9UQXc7pBy0UCrfSbR+QIC9Ug2XoPEe3DAVy/c4EN8zvyuBNz7VjMSR
         UpdGsgMur+hGG3HJxeiiGqZTYP6b7QlWrr45d/MpMeCxvvDHp/xQckKicstYK/b8iS+9
         RwHxr8fJBMruSEAM8goSE4ZOlRPrhtm+W77n9eI0xndr8MLX2BtkvU0gp3ur6uZ/KUyn
         u4t5SOhZQ/RNDaR3OlGLGxjQqjGPwrTBneZBJ/50G9l83RdWFuRsExLc2HGlGXUYNon8
         NYi09F20yCLyjjjCb/H3nxC6+8U0MKUt44mBnMnoUAZgktobBVmTyz76KJ519LSuP6Qi
         v5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775194155; x=1775798955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwVEBTN2pqE65yckg0LJLlK41X4ju08angcIWHyFOv0=;
        b=B67CffugsoMVVVpn4jsPeNhQ7odgtYQnmq6HiRehy5/4ydwj/Xrz8QsQtjDjR5BWrX
         9rZHKBpKBsoZ4ksYwE7e+/3D0lUWyaWgHD47KSRKij/ZigR/pxDwXJWZiWkLXhdOjhEV
         wZ2ngpHQIFwJmelgtqXtxJh+d44uO/MwF+CqlRn4gAs/ysqxmhWdvpZ962g8jtt1k/Ll
         0wYCajxmN1wVOB7P0Ry9K6Y0WNbJOzSSs8CBGteRDifmLnqygu9MmSN0N/MGIJYkLFwH
         8SlU3dMOQSjGniTrtB9TM9BEPH3qOihnc3AT2Oefw87DHF5A5zQtLiTP/t9pNi3GDrr9
         KJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwBZMdOQRf4nLlXglx5Wh3HeMg9DiBYlBQ7ytnvqo2ToNDpYlem+EjpS+oWPGplHRs3vayiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt2elBJnlntD4kOyPO3LHyVVOBMWdZEH4pi3n6t2JD32WQHA/u
	PudPLBEQmTcH7x4YWhajSk9ulGFkxdkHijN/o5VAQfUGHkU6S3GCtipB
X-Gm-Gg: AeBDievDxvWEMZgWAgLjYvZxQj6wRXYZ3GVMKEPLSqW/8vVCtxJqru4vgUw+bWD+qOz
	TuSJKgUNApaIPA6P39Hx3TYMQ1mx4YoJyhU7SPBKnN344e0tHoDbXG3WCHZN7Gk2n05VPbrIFvz
	pDjkZYHZmArik/Bx4kGk/827X4T9kDwOirdiqtWaH2pSuuXMl2ChITLAddhhZqRX31Nr50Mnbet
	LTdqLrQ9XmUhatNfgsOWgMOXAfSXAH6E+96O1Xk/DE9b3XTnkQB6ZUpz6BQtCcrc4IFnaMPyOja
	XUPskaztwrnAAlHl3X130FHiYQ8cHTPZzoOiwgT0LF+Jx+IhY/swL32c3qv1ZFDs+8Bg2LmEI8x
	pW2J1UP+eErJOk9XN+HbhO/nFxM6zFpyRQF+5ue6PMPP8vEVuHeO0/CBx/ZKmwb6cjR+lvLDAj/
	Lndep1xS3Q8yQ1A1tTt0JK83InTE8=
X-Received: by 2002:a05:6a00:4c16:b0:82a:78c0:6b75 with SMTP id d2e1a72fcca58-82d0dbabb59mr1887722b3a.44.1775194154839;
        Thu, 02 Apr 2026 22:29:14 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11cd2ce2sm782120b3a.6.2026.04.02.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:29:14 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v3 0/2] mm/damon: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 13:23:48 +0800
Message-ID: <20260403052837.58063-1-aethernet65535@gmail.com>
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
When a user provides an invalid min_region_sz (not a power-of-2) via the
DAMON sysfs interface, damon_commit_ctx() fails the validation, which
causes the kdamond to terminate unexpectedly.

Reproduction steps:
1. Enable DAMON_LRU_SORT or DAMON_RECLAIM.
2. Set an invalid 'min_region_sz' by setting 'addr_unit' such that
   'DAMON_MIN_REGION_SZ / addr_unit' is not a power-of-2 (e.g.,
   addr_unit=3).
3. Commit the parameters via 'commit_inputs'.
4. kdamond terminates due to the validation failure.

Solution
========
Add power-of-2 validation in damon_lru_sort_apply_parameters() and
damon_reclaim_apply_parameters(), return -EINVAL immediately.

Patch 1 fixes the issue for DAMON_LRU_SORT.
Patch 2 fixes the issue for DAMON_RECLAIM.

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

