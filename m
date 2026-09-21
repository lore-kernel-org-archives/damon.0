Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881104B3364;
	Mon, 21 Sep 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003753; cv=none; b=r81Q9DwN3E8e1iin7ED4Ps5GfSoBP+eUrR44hH2nrQgGwC59tHjFqPAO4vlOVlv7aRuiuSpn0M4dyYXnKd5nerMtdBKy3zrGs8XAOSPkxj7QbpwiRX5HZgK6AoE4BPPtkjmeVTjz5ft9xd5iSrN2hDbwcA6nAt7IYEuqxM/CpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003753; c=relaxed/simple;
	bh=KVcK1Y1ih5u1kIcLe/uH3njGYuZ9fXYh/XiLrz4d1/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5JslJVSqSB6g2n4A+XYZR0Oj0l3Xh/tN95gEtLsCBoybJcd2XamQPJMO2rrEBK1FXRMwnNj6t+ibBPkBY1l7cE4++see/YtkBnHwah2E+oqScG5Ctj0nMfBMSK8zOkQqkz9bBKgzPM0xJ0RZKislBMBvHOZUgzH04KbhLrgaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ5oC3YT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ5oC3YT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE501F000FF;
	Mon, 21 Sep 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003752;
	bh=v2TT2RzKq0ySasMECuIA77pplW9JQNZIwLSdAY2y1e4=;
	h=From:To:Cc:Subject:Date;
	b=iJ5oC3YT2dCKI0AwnslGMi+n4gVJufBi1ZPcJxeK/Q5reOxklap/Edzae+xY9CkJx
	 EekHs+4Iops46s7MuiHT2GCd5FyhyXyn/cp6FM7IEc30WVSSZ5VtRtc1RcqLfCfPRn
	 Eh5hfwPTKbE4vtdqNUIBvl0k/0tEQQzxYzgcuG4HyCR92j0iNCuuxwNbFodY8YFXPm
	 p72zzcItP45FCvQcZ1sNhW1c62aMfJImyZJaVne2f/EzFWcx2ygGtyP7L/YBSLLf6b
	 nXiOX7VG5tG20E/3neCVwZX6jAHV3i69/ByzOwQnXWThoS7oaJpJa2xvu3EbxHWFas
	 5MfDPTp0M0ISQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Xuewen Wang <wangxuewen@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon: improvements in efficiency, error handling, documents
Date: Mon, 21 Sep 2026 08:15:42 -0700
Message-ID: <20260921151547.78472-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four various improvements.  Patch 1 from Liew Rui Yan skips unnecessary
quota setup work when relevant.  Patch 2 from Xuewen Wang propagates
ignored damon_call() error to sysfs users.  Patch 3 from Adrian Huang
(Lenovo) fixes typos in comments.  Patch 4 from Karthikeyan KS clarifies
zero sample interval acceptance on kernel-doc comment.

---
Note: this is a batched reposting of DAMON patches that were
individually posted and reviewed by the DAMON maintainer.

Adrian Huang (Lenovo) (1):
  mm/damon: fix typos in comments

Karthikeyan KS (1):
  mm/damon: document that a zero sample_interval is accepted

Liew Rui Yan (1):
  mm/damon/core: skip quota score setup when the quota is full

Xuewen Wang (1):
  mm/damon/sysfs: propagate damon_call() error in turn_damon_on

 include/linux/damon.h | 3 ++-
 mm/damon/core.c       | 8 +++++---
 mm/damon/lru_sort.c   | 2 +-
 mm/damon/sysfs.c      | 3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)


base-commit: 05b2dd9725f76b0024d387ed2226d1ab531620ce
-- 
2.47.3
