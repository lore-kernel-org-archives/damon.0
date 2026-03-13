Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773973264DB
	for <damon@lists.linux.dev>; Fri, 13 Mar 2026 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400629; cv=none; b=NTctD2wknltgCN+hKLnjxmGbM/ubGtlzUUpKN1ufY9EBR5quvyrGxmpJlN0vm/1a8QtRO+nws5qvsLj0TnFyhgmWXYd/cqeM0tKRJ4+F0H6+eGowQXY0XpKuEWqWpOlgUSz59rJ+u1DizMbC2/rkBmE9fJVbVZMqdEBgLRukgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400629; c=relaxed/simple;
	bh=YwJhd3tvM/kG2WSw5Tl14x2MkPtTxbxeveEpca0O60k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHjeI4Ke1z1GblMgriAqYAY+/ZeyXkpjF/5y2vQQbFk8J0zNXq+xzTM6AIAA9CR9Nrr/easslJ+ve6a54nD3pqjLipiKWvrNvxQsmYX9mhJP4HKKfmPaNslqYh+JNMeb1LhoyGw1qfAZC021DHMRUOVsf8PQLIXUb5yPnLExFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+dwybWX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+dwybWX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829759ca646so1227159b3a.2
        for <damon@lists.linux.dev>; Fri, 13 Mar 2026 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773400628; x=1774005428; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6f9y1Azogy+eVSZvA21A37bR2iFuIMAMTEPkCYBI8c=;
        b=X+dwybWX6zCIs6G7hTIEYapw3PqzceRkMjuqxWKnVr3YweMeQvzDD2auauSQCSd1jX
         JuXRRs6uMXyKCJrjW2jZJ+fm8jF6fCRjph8rnaVKpOLKLbP3/TnYm7z0sB9/9aveLTyi
         AwBYUpCwLlxOenRbgbPvVrF4KeBEW9arNsIIuRzuOgk0HWUqA417PaExvLhJRY3abtl5
         t1cVWuOUKEO3GxTIxlBJBdhM1hFisiuYvI18wlxwJGPgXZEUOWUIAQEQwFgBxsszwTKN
         N+RYGdyUWYIeRHiqdBCKiDpsf19A/iRRuRuEVSFouB2XZ6zOUjXuhJEh4BGZcWuIlNeW
         uW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773400628; x=1774005428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6f9y1Azogy+eVSZvA21A37bR2iFuIMAMTEPkCYBI8c=;
        b=hs8eHP+L+3iIne7MepYsqH+wqcPWHrx5KPSZk2URsowE1dzrxgqIceRgwpi18EGhj5
         qI/mqz9Nt1Km1NTt38aTZ61ys1JGPrDowAVTa2SHO2toUt3ZiMpqsITlUyikatvA3pV7
         hK00ilkX1nngyOdwP1lUOdbMl+uyEnFqWskduozks5+l4BTBjQCFcMVtX2uQKwX9BvZ/
         IxJ4o+Fi1xXZYYqQIQQPgYnTO1MvUpANNOs3xpDZc7C+zEHN3pfw/v6yBtSg1Gcc1lIR
         lpy2OOSKY/TTf/ISFbhQD0flIz/qjdUIqnWLjPFTwu19jPn5BdpX3E78wmBGkBAymYdp
         NwxA==
X-Gm-Message-State: AOJu0YxCMy43IJ0W1NcFtTjd3hUwjfWRPA27aSKw4TYwVZZZYXMUHvoJ
	EKAHWLDA1f2hnpXVINRgaDlcswLzethWkT1qf4cflzOnmq/tAAM8SatpfBZW8kJrMb8=
X-Gm-Gg: ATEYQzwB6kaPPdemq0no/FucK6U+awNzhB4r03gwBRONjBrTMLcK0Dhyb/+prXOgCzv
	jH2imi2cXtr4WH3aY2idKs0MF4HELyYxUUymfQdTmfQDpQPXf/UMvILhZ1hxDBKlTA5IXMENHXJ
	CSs697BS6yMhnlDP6fchiI9qRrnQwiguTRtyM/dfEPhfKFI+Z0uNPPKzrHOZM/V99W7kYIEJvK5
	NkU1ygL3AAE5x++rdjr2hgy+eQzritzTl+uPWJWskAEFhUwIC1YlLkNL1vkMy2DcTUYSOcEMraf
	AFMVlDSMLNcEuhrwIZ49sVQNPoRvfUs2DB4f8PEkJiflhCpuV9puMgt19acShIiD8SV/ruhceAh
	cazvYy3TBDvSs2OIYguibHmseWKMJ4Dauk9oEguCbjhkmFowKkD/t7AqD1nsO+SvVnygAEDOmBU
	I30eDSrFHMFkRflRC18USQFyl8sRRV+cdAAJWmmbDMrc/pPVTSr6YV
X-Received: by 2002:a05:6a20:1602:b0:398:b748:b566 with SMTP id adf61e73a8af0-398ecb34f28mr2274111637.32.1773400627841;
        Fri, 13 Mar 2026 04:17:07 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:89f2:c7ce:9a60:1bde:300a:8fcf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966d9sm1678930a12.11.2026.03.13.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:17:07 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [Question] mm/damon: conflict between DAMON_STAT and DAMON_LRU_SORT?
Date: Fri, 13 Mar 2026 19:17:02 +0800
Message-ID: <20260313111702.38667-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR
=====
When CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, enabling damon_lru_sort via sysfs
"enabled" parameter returns -EBUSY. Is this expected behavior? If yes, should
this limitation be documented?

Reproduction
============
Environment:
- Kernel: 7.0.0-rc3+ (x86_64)
- VM: Virtme-ng (4G RAM, 2 CPUs)
- Config: CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, CONFIG_DAMON_LRU_SORT=y

Steps:
1. cd /sys/module/damon_lru_sort/parameters
2. (optional) tune parameters: hot_thres_access_freq, cold_min_age, etc.
3. echo Y > enabled

Result:
  bash: echo: write error: Device or resource busy

Workaround:
  Disable CONFIG_DAMON_STAT_ENABLED_DEFAULT, or disable damon_stat at runtime
  before enabling damon_lru_sort.

Questions
=========
1. Is this resource conflict between damon_stat and damon_lru_sort expected?
2. If yes, should this limitation be documented in:
   - Documentation/admin-guide/mm/damon/lru_sort.rst
   - Documentation/admin-guide/mm/damon/stat.rst

Additional Context
==================
- On major distros (Arch/Fedora), CONFIG_DAMON_STAT_ENABLED_DEFAULT is typically
  unset (disabled), so this issue may not affect most users.
- However, for kernel developers or custom builds enabling both modules, clearer
  documentation or error handling would improve debuggability.

Best regards,
Liew Rui Yan
