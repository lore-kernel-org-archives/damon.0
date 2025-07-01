Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BAB202995
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357984; cv=none; b=ZXgGlRkjDr7qnplNi+d0IJJybIQE9lV8FehMT8Srd8dmGtf2WqkiRhhBbfZb28WtI1xlARj22OJjMyMwG1+khKg0CejVlOakRxst3gunWAtcQJx5Q270A/ADkxuhOdLVNVG1ZJfC0Xvr4j2HB7NwuyvHVGy3qqqorHUUc6nIgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357984; c=relaxed/simple;
	bh=CB5vp1JKIlTQiDO5g48eAGXYnl8EODYSvxG3DV9+UD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEUMd6KN6zhTg2NPc2XLnk88o3ZktbEx3UwQT7ULu8a7NQSNDwynS9CoRYBWZj7klYhizrLtRgUFJsoOk3jJG6rqrw8a6y2OfC+RmcKOcGpGjMtrK1mieGOLKqtbW0rwbNdBt+NKcJX7WgOhJMSCJa0d6HLk4Bjx5ZuaV4Y+c/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-c7-68639a138d1f
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v2 0/4] mm/damon: fix divide by zero and its samples
Date: Tue,  1 Jul 2025 17:19:22 +0900
Message-ID: <20250701081927.1873-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsXC9ZZnoa7wrOQMg4m3RSzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZs+48
	YiroYqt4d6+FuYHxHUsXIyeHhICJxKaLC5lh7Fuv1zCC2GwCahJXXk5i6mLk4BARsJKYtiO2
	i5GLg1mgiVFi469ONpAaYQEXiWdtF9lBbBYBVYm355eAzeQVMJOYubWBHWKmpsTj7T/ZIeKC
	EidnPgGrYRaQl2jeOpsZZKiEwEdWiXMPdrJBNEhKHFxxg2UCI+8sJD2zkPQsYGRaxSiUmVeW
	m5iZY6KXUZmXWaGXnJ+7iREYWMtq/0TvYPx0IfgQowAHoxIP74yTSRlCrIllxZW5hxglOJiV
	RHj5ZJMzhHhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTA6
	LLo67crEsLOJE/nWd0wO2Kmod2q3qu2qIoMYTdsTV1Ztfz/vgc3yS41Zk+ImTrjjaJrz4+n2
	exf7+mavtGJ8XeOpxXlIL3qatmKuwvdj3B5hRmeFJNRelzi80ZujFMPTva3vT/XnQ/1l4pY8
	aU5Z1qt4r3847pNz5V7WFB/zo5Y/Km2UsiqVWIozEg21mIuKEwGm61RQKAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplluLIzCtJLcpLzFFi42LhmqGlpys8KznDYO4LXos569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YHNg8Nq3qBBKfJrF7nJjxm8XjxeaZjB7fbnt4LH7xgSmA
	LYrLJiU1J7MstUjfLoErY9adR0wFXWwV7+61MDcwvmPpYuTkkBAwkbj1eg0jiM0moCZx5eUk
	pi5GDg4RASuJaTtiuxi5OJgFmhglNv7qZAOpERZwkXjWdpEdxGYRUJV4e34J2BxeATOJmVsb
	2CFmako83v6THSIuKHFy5hOwGmYBeYnmrbOZJzByzUKSmoUktYCRaRWjSGZeWW5iZo6pXnF2
	RmVeZoVecn7uJkZg4Cyr/TNxB+OXy+6HGAU4GJV4eA3ykjKEWBPLiitzDzFKcDArifDyySZn
	CPGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTAqb9+gWFyX
	e2DdyqQNb/rtL338UVFgevha5UkfzzaOGp1vlzhX9egusQhu1ylh2vPMrHTPNg6j71qahv73
	VFbWLV4iast51WN77sa9/xQWpDPrqj6XCH/udjrt5dt3uedMCppFP6mGTcyfEq+/6I5+qou4
	7EbTujzzZtPnktxWAUtn+sq941JiKc5INNRiLipOBACF0oJuGAIAAA==
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

 mm/damon/core.c       | 5 ++++-
 samples/damon/mtier.c | 8 ++++++--
 samples/damon/prcl.c  | 8 ++++++--
 samples/damon/wsse.c  | 8 ++++++--
 4 files changed, 22 insertions(+), 7 deletions(-)


base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
-- 
2.34.1

