Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0EA1DED42
	for <damon@lists.linux.dev>; Sun, 22 Jun 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750594220; cv=none; b=gog/lWOxh+R/Jf8wUR2Mrl5hMMdugElqJX2ylwbVncWkzzpj5fc3Vu2JuTmq7Vt6FCCnv/9pyR+sSws4hZLGv5psfZeaOp9ynCuxSCcrgKeKf5M7o5kwojqrNSQRffyX2mv5YYU8MKb9qBrkSv67CDuvc1eY82IwPwa6NesCcYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750594220; c=relaxed/simple;
	bh=FduXMafm8hv6jLzjCbONKOplVWWvzRNBLsdAvsT1uog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCnRPupnY2AAl3sz+megxmtrBJ1W2zGy0ZU0S/wH2OXEChTqoC6ubgl3VbKMAVE6A9zh+5fdDe0apJgAhhD6oU1d0oy5a6Xcxzf3rDV+YUvM1McfoH8n0ear1Fku/PhRKmpNswKvoDgNnNJukjPtzGN+GfvAZdRqAj/B7p09594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-26-6857f29e00bd
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 0/3] mm/damon: Enhance damon and its samples
Date: Sun, 22 Jun 2025 21:09:22 +0900
Message-ID: <20250622120926.1712-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsXC9ZZnke68T+EZBvdW2ljMWb+GzeLJ/9+s
	FvfW/Ge1OPz1DZMDi8emVZ1sHps+TWL3ODHjN4vHi80zGQNYorhsUlJzMstSi/TtErgyvtxa
	w15wia3iTPtH1gbGjaxdjJwcEgImEm3futi7GDnA7BNnJEDCbAJqEldeTmICCYsIWElM2xHb
	xcjFwSzQxCix8VcnG0iNsICNxK1li8BsFgFVifXtq5hBbF4BM4k5hxZDjdeUeLz9JztEXFDi
	5MwnLCA2s4C8RPPW2cwQNR9ZJfr/xEDYkhIHV9xgmcDIOwtJyywkLQsYmVYxCmXmleUmZuaY
	6GVU5mVW6CXn525iBAbVsto/0TsYP10IPsQowMGoxMP74mBYhhBrYllxZe4hRgkOZiUR3kNO
	QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MAmsVt65K
	9xGL3HyV5wXX8nOzDV7cbPL8Xq1hbarPKu/LFcpfYynB7RLO5CyfsP9GevWEBRUax+07fR6d
	tdj31bat4Ft4vvXTer/JH77725U91pq4YFf3tfwts36dCfmRNunE7km7TS+t3Of7xnJJ2K2O
	Ke+UOOZJTIxzFfwefD+v0eTWja69SizFGYmGWsxFxYkARcbRyCYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LhmqGlpzvvU3iGwft/ehZz1q9hs3jy/zer
	xednr5ktDs89yWpxb81/VovDX98wObB5bFrVCSQ+TWL3ODHjN4vHi80zGT2+3fbwWPziA1MA
	WxSXTUpqTmZZapG+XQJXxpdba9gLLrFVnGn/yNrAuJG1i5GDQ0LAROLEGYkuRk4ONgE1iSsv
	JzGBhEUErCSm7YjtYuTiYBZoYpTY+KuTDaRGWMBG4tayRWA2i4CqxPr2VcwgNq+AmcScQ4tZ
	QWwJAU2Jx9t/skPEBSVOznzCAmIzC8hLNG+dzTyBkWsWktQsJKkFjEyrGEUy88pyEzNzTPWK
	szMq8zIr9JLzczcxAsNmWe2fiTsYv1x2P8QowMGoxMP78mBYhhBrYllxZe4hRgkOZiUR3kNO
	QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGvK9GjyJ2
	31Gbea9jeVhb8EHpPaZrnSYHhzaUn3x0+2wB467dnZt0wpuvSHRsKDlyM9pUXH0eu/HB25KT
	P6ndMml7fG7thJzchOCg1R6HOG6ZT7CSPOI18WtjSrtZxHGvqyq9H4KX2RxR+bAuQvDKpLOP
	dim071gud55nh6SjaPzeQOvJN3/nKbEUZyQaajEXFScCABXN/UIXAgAA
X-CFilter-Loop: Reflected

This includes random fixes of damon and its samples to make it safer and
consistent with other damon modules.

It includes the following changes.
- Fix unexpected divide by zero crash not allowing zero size region
- Keep "enabled" parameter in damon samples consistent with others
- Fix bugs for damon samples in case of start failures

Honggyu Kim (3):
  mm/damon: do not allow creating zero size region
  samples/damon: change enable parameters to enabled
  samples/damon: fix bugs for damon sample for start failures

 mm/damon/core.c       |  3 +++
 samples/damon/mtier.c | 22 +++++++++++++---------
 samples/damon/prcl.c  | 22 +++++++++++++---------
 samples/damon/wsse.c  | 22 +++++++++++++---------
 4 files changed, 42 insertions(+), 27 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.34.1

