Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35034175A5
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018034; cv=none; b=sm/FE7MerL06Qg7fpufl9k0W9RjPSXnDRXXeCd3mZxX/6Yqa2NTGs5xvtQZL/+dVO8m6gRt7f94oUKLba2lLz9MQfCG5OSWPammP0qdIJyaMyaJeRI/sXxfQMhSpTNDFYLh+hrWfgkxCrJFDpCugo82CXfIk/jlofkPx868H09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018034; c=relaxed/simple;
	bh=xXlTjxsjzpWoKY1/3S9+MsmoSzPZRCZxPsG/1f6Vnf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvuPFeWon/e5CbDe0rfhjXKTyFJ1AZsBambNBxEQSY2z7rrdmglRR3hUzU4mxP6WWCBDKNAStjBaQqVC4cqlVKv2J5hg3ht5gzWT/AaRGVq29cbrgPOXWTl+mDpiSUnHFMcYxy34iRyaQ7u6vArkJxUWYiZ5l9FdjLkxjn3yJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J73M/ALU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J73M/ALU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82989744ee0so2965719b3a.2
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018032; x=1773622832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Npg7zsgmfHY86YOcXFkvoWsvRPot99dvgJ+7QRwG2Gs=;
        b=J73M/ALU8CWfBtCEVTzhuXsAKsWb8MQME+mJVm3Hbdf1KI1/31Mvnt50FdlzQ2iDeg
         JzxFRGU2dW59/ACXWaWPOP10xnNmW3rebk6n673JHo3lRfUhbRhG9eJPvkNjWxz0EIzu
         bcSzOwWeuAy4lCF6Hps4Nu3YdXONjD0c1USfKvt3W2tKzn/wsVCEnZ6fB7gc0x6Bi1TW
         vq2j14TolAe03nVHRz1W3ANI+oGf3BmY6IhSKigfOhZxMbRvSbSPye2lidqbwkHG24xS
         4AnNTlRGbopepVNzoW3nOEFWzzQ+scJuXh8aAeNeorUJfOmWfoCpXy3b0YjNDLbiTFtp
         Ymow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018032; x=1773622832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npg7zsgmfHY86YOcXFkvoWsvRPot99dvgJ+7QRwG2Gs=;
        b=iS+PD5qUg/WSnGpJylup86MNNc/3PykxKV+S6C5EHutt3JdltNqcqTxUDo3P6IFf3d
         hHr88UgWDqFk4F0Zxdh+yVV4+8f6l7OHpfj2MnKciYzumBFGoz6n/Idlab2TnqYTSV3D
         5hX4cRhKIEPehvnGQIQqH3Ua9i0tsWLpwcCjI7xNjL4qlHsjhz7vdQ1k89ke9cUNsTOk
         iGsN/9AGnU7wU0rNrs/Kf6OEcNFgB5aSZulHCKL+7Wrdz/eF305uSz93LRE8DzW2t+jM
         ic0ce4VVyyzH9SdvwVtBuq47Sv8tUca+UD3byg2ia+ZiIzcwfuFg+9JfTk1jMhV/PdfN
         xaqw==
X-Gm-Message-State: AOJu0YxLYWWctMmy+D5usPq80FVSBnQi+sCq1bYGEn18dI6D/mhdxgVv
	ImgJ37CPRRDxgFcNQX6KdK4CTW2mOHjAdeiqurWPS/Y7VFmgtT28YG6meGj9ig==
X-Gm-Gg: ATEYQzygYTU7yGkDn4LHqfRzAd1TigEuaH66/bWHfzhWarN86WUQfc4VdbBXH7Z3kwy
	KmbckWqvS+Hi+0S4RKc6+z5duO4lgaNTYI6DRxj38nyhbQPZ9hs9RQRVLSrntEozE9ugl/5alPi
	WaCjJbSzzi8FQRs+NC8UVBTflkV/cC5Jq/P5jsbso+mp5rO9L1QKI/dw48ZWtcGSWMaqEpBd5V9
	f2NdS/F/nqErqtcuHT3ra1VLuCb2ujv3QVKRB2YUAs1a6vkQsDCdn0OtpsMTZdRhS/hwjd4tX8e
	AejnTyouh91vpHf8oCttDoM7ScQ6B8KwVscBal/G/Rb3NwuAurZnsccs3WPNJsK4YPV01bOSQl4
	NrAfopu2jX4RzxR896QuVc/fKNwXptP3aodmQxEpjtcKWbP6JuaRyP3cWvaHaFCykdwM/Ihkw6L
	Oozpv4sI4i/H8gD0HcEfMETSUOynU5t9YtKo7Myg==
X-Received: by 2002:a05:6a00:a21e:b0:7f1:4:66b with SMTP id d2e1a72fcca58-829a2f5a6d8mr8061973b3a.44.1773018032173;
        Sun, 08 Mar 2026 18:00:32 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:31 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 0/6] mm/damon: introduce perf event based access check
Date: Mon,  9 Mar 2026 10:00:03 +0900
Message-ID: <20260309010009.11639-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON currently only provides PTE accessed-bit based access check, this
patch series adds a new perf event based access check.

Since perf event-based access checks do not require modifying the PTE
accessed-bit for pages representing each damon region, it reduces the
overhead of monitoring at a fixed granularity of the page size.
Furthermore, this patch series also includes a feature that allows you
to set a minimum region size for each target, enabling you to monitor
at any fixed size greater than the page size for each target.

Using these features also requires modifications to damo, but these are
not included in this patch series and are currently under development in
the following branch:

* https://github.com/mita/damo/tree/damo-perf-for-v3.1.8

Any feedback or advice on the patch set would be greatly appreciated.

* v2
- reintroduce damon_operations->cleanup()
- introduce struct damon_access_report
- use struct damon_access_report instead of introducing struct
  damon_perf_record
- remove maximum region size setting

* v1
- https://lore.kernel.org/damon/20260123021014.26915-1-akinobu.mita@gmail.com/T/

* TODO
- Currently, it is possible to unintentionally specify a perf_event
  that cannot obtain either PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR
- Check if it works in a virtual environment using vPMU

Akinobu Mita (6):
  mm/damon: reintroduce damon_operations->cleanup()
  mm/damon/core: introduce struct damon_access_report
  mm/damon/core: add common code for perf event based access check
  mm/damon/vaddr: support perf event based access check
  mm/damon/paddr: support perf event based access check
  mm/damon: allow user to set min size of region

 .../ABI/testing/sysfs-kernel-mm-damon         |  10 +
 include/linux/damon.h                         |  63 ++
 mm/damon/core.c                               |  77 ++-
 mm/damon/ops-common.h                         |  39 ++
 mm/damon/paddr.c                              | 105 ++-
 mm/damon/sysfs-common.c                       |  11 +
 mm/damon/sysfs-common.h                       |   1 +
 mm/damon/sysfs.c                              | 399 ++++++++++-
 mm/damon/tests/sysfs-kunit.h                  |   2 +
 mm/damon/tests/vaddr-kunit.h                  |   5 +-
 mm/damon/vaddr.c                              | 654 +++++++++++++++++-
 11 files changed, 1332 insertions(+), 34 deletions(-)

-- 
2.43.0

