Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BD8F5C
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414535; cv=none; b=HXpSSUU7j/G0RAv+eYh8a3v+1K3E5vNjQPpqHrScpR6lcGfHZ3wNOetTvgtML/ACbn2Uaef3dkWJRSg9EyCmcH/vfmEFLt80/fCD6V11RPtTh2xT30GeAl3cUVBr4yPUE1ITNR/Phvealbu38VlUFiAdPYDaKglmcn0Ys/IswQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414535; c=relaxed/simple;
	bh=0oqF02reaGTtCF3C6hZEKkRUyeG+j0FLn75jiMQ58gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BblXOPwsEwtH9ypvDdmQxX++TMy6xrcq1/Q49+4WxWgXiYQg10q3ZZkjzOUTUwr8C1E7KgKipHyaUOfEEV6B9NKHyUWosIS0eLHRlywjoKyOpg/id+pCyX4U3XrDP0o/2n0ojHMzec3Hd2mfVLmckLYAkZGyuzr0uPR+2gB4fEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-9c-68647700caf5
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v3 0/4] mm/damon: fix divide by zero and its samples
Date: Wed,  2 Jul 2025 09:02:00 +0900
Message-ID: <20250702000205.1921-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsXC9ZZnoS5DeUqGwcenEhZz1q9hs3jy/zer
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9Tsz4zeLxYvNMxgCWKC6blNSczLLUIn27BK6M3qOn
	mAva2Cp+felgaWB8xdLFyMkhIWAicXbhc3YYe9nBO0wgNpuAmsSVl5OAbA4OEQEriWk7YrsY
	uTiYBZoYJTb+6mQDqREWcJF41nmLEaSGRUBVYs0lBZAwr4CZxPGH/xkhRmpKPN7+kx0iLihx
	cuYTsLXMAvISzVtnM0PUvGWVWHpEB8KWlDi44gbLBEbeWUhaZiFpWcDItIpRKDOvLDcxM8dE
	L6MyL7NCLzk/dxMjMKiW1f6J3sH46ULwIUYBDkYlHt4TV5IzhFgTy4orcw8xSnAwK4nw8skC
	hXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTDOnrp7hnNV
	K1+5XLHbBufIS8f+3d5snr3I7+Is/xYmhqf7Xp/c+OjCQqYLBVsWbqpon7jm5Z0/j65/77/Z
	PVd/8tnaO2E69c7VAnHrQ5b9XjXH4UH8BZ6tNxSVJFbnLd1/WvqT6GpuxX3/ZEw+iP7bej1v
	GS8Th6w9S5GaiXbNiZ+qPPvn50Q4KbEUZyQaajEXFScCAG5/2cImAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LhmqGlp8tQnpJhsKhV2GLO+jVsFk/+/2a1
	+PzsNbPF4bknWS3urfnPanH46xsmBzaPTas6gcSnSeweJ2b8ZvF4sXkmo8e32x4ei198YApg
	i+KySUnNySxLLdK3S+DK6D16irmgja3i15cOlgbGVyxdjJwcEgImEssO3mECsdkE1CSuvJwE
	ZHNwiAhYSUzbEdvFyMXBLNDEKLHxVycbSI2wgIvEs85bjCA1LAKqEmsuKYCEeQXMJI4//M8I
	MVJT4vH2n+wQcUGJkzOfgK1iFpCXaN46m3kCI9csJKlZSFILGJlWMYpk5pXlJmbmmOoVZ2dU
	5mVW6CXn525iBIbNsto/E3cwfrnsfohRgINRiYf3wNnkDCHWxLLiytxDjBIczEoivHyyQCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGBRlW9nwcjUl5
	CQqtuzYvED/ZXLZDLO5GhlXWJvH/H486LdrQ+H9Zx97oPrFlGyYKPpj8YY3bkWV2FT3P5aaf
	N8zsure8e3vtnRc6MR+WmnnwXHDjnaH2IO6kp1HLmz6L/DfrZrSeuqH4uVV8bf65fZ91wuYz
	Mr3YmVRxsN5kQb3EPv+NysbJSizFGYmGWsxFxYkA0wOLJhcCAAA=
X-CFilter-Loop: Reflected

This includes damon fixes and its samples to make it safer when damon
sample start fails.

It includes the following changes.
- fix unexpected divide by zero crash for zero size regions
- fix bugs for damon samples in case of start failures

Honggyu Kim (4):
  samples/damon: fix damon sample prcl for start failure
  samples/damon: fix damon sample wsse for start failure
  samples/damon: fix damon sample mtier for start failure
  mm/damon: fix divide by zero in damon_get_intervals_score()

 mm/damon/core.c       | 1 +
 samples/damon/mtier.c | 8 ++++++--
 samples/damon/prcl.c  | 8 ++++++--
 samples/damon/wsse.c  | 8 ++++++--
 4 files changed, 19 insertions(+), 6 deletions(-)


base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
-- 
2.34.1

