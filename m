Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB319A
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414540; cv=none; b=BV4ev62ETcnsgTd3vhKZaSRLsD2ztEP9B2h13XkE3uj6yKxHG0bBbq5N+d++Iywhe6aw/ampmeT7IGITt23XofECQEGfj7Hj28VZw20filN7JEjSRUlfOD6MCKltu79qySiJfk+hrpfF0LdwDkyDlidumkCXD4B0QMs41csizlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414540; c=relaxed/simple;
	bh=Z2QBJoMxLfvkUimBFt/t+6UsMVqGgn0hR3C/mq2uO0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYLeyRU0OjjhgSWfwWjJYpMlpb2HBuh3/X+9gy/JTX/ms+l7Oav5AKy+nPYpWEynyFHyDVfFMADlCqYlE6Pu2DgpxUQGFV9tUIKwIrjYTm7ncu+tTfBdMnvOTsABHpe1GV6HBt+Bdp5D2JrhouhUA07SKcL7wYqqnkVxGa1sIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a9-68647702b276
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/4] mm/damon: fix divide by zero in damon_get_intervals_score()
Date: Wed,  2 Jul 2025 09:02:04 +0900
Message-ID: <20250702000205.1921-5-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250702000205.1921-1-honggyu.kim@sk.com>
References: <20250702000205.1921-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXC9ZZnoS5TeUqGwdUGKYs569ewWTz5/5vV
	4t6a/6wWh7++YbJYsPERowOrx6ZVnWwemz5NYvc4MeM3i8eLzTMZPT5vkgtgjeKySUnNySxL
	LdK3S+DKuNqbWbCJs+LOg4nsDYx32LsYOTkkBEwkJk//ytbFyAFmfzvECxJmE1CTuPJyEhNI
	WETASmLajtguRi4OZoE5jBLf3u1iBqkRFgiWWPvsNyOIzSKgKnFt/Rp2kHpeATOJXbOiIaZr
	Sjze/hNsE6eAucTH5tVsILYQUMm8w+/A4rwCghInZz5hAbGZBeQlmrfOZgbZJSEwh01i0upN
	bBCDJCUOrrjBMoGRfxaSnllIehYwMq1iFMrMK8tNzMwx0cuozMus0EvOz93ECAzKZbV/oncw
	froQfIhRgINRiYf3xJXkDCHWxLLiytxDjBIczEoivHyyQCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MYV1lsbwqMj38P21fRXk8Fs6KsBbeel5KsKVh
	Podg/xfe6q1rf87/qnl5i9ABd7Eq3Y5vaeWH77huy+aasf9XxIqX+3n3mme1+c/8kX4k594e
	rSRm07wTDeLd3H6ya7fY3bmvlXhAevX9TemqqQcnhbAfeXDqMt8tZQbXPf0f9p4v8XXLTWNQ
	YinOSDTUYi4qTgQAoII9iEYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsXCNUNLT5epPCXD4PhrIYs569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YLBZsfMTowO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfG1d7Mgk2cFXceTGRvYLzD3sXIwSEhYCLx7RBv
	FyMnB5uAmsSVl5OYQMIiAlYS03bEdjFycTALzGGU+PZuFzNIjbBAsMTaZ78ZQWwWAVWJa+vX
	gI3hFTCT2DUrGiQsIaAp8Xj7T3YQm1PAXOJj82o2EFsIqGTe4XdgcV4BQYmTM5+wgNjMAvIS
	zVtnM09g5JmFJDULSWoBI9MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwKBbVvtn4g7GL5fd
	DzEKcDAq8fAeOJucIcSaWFZcmXuIUYKDWUmEl08WKMSbklhZlVqUH19UmpNafIhRmoNFSZzX
	Kzw1QUggPbEkNTs1tSC1CCbLxMEp1cB490jdxO0rXd4UrclKrvyx6KiQ7ZbTiasStDnflTJv
	q51wvCR0/gwBVYHP/4rkd/S9l9/QcEDhNi+Ts5LnmTbe6SI/gtiZ1JMLH+251btjz5qQbdec
	2Y2an12btP55TU2n+i2LB7z7ZglxXmcydq3suTHjtO9n6ywZ5Zb6RZMWXykyu3h3qjerEktx
	RqKhFnNRcSIAUn7B+TYCAAA=
X-CFilter-Loop: Reflected

The current implementation allows having zero size regions with no
special reasons, but damon_get_intervals_score() gets crashed by divide
by zero when the region size is zero.

  [   29.403950] Oops: divide error: 0000 [#1] SMP NOPTI

This patch fixes the bug, but does not disallow zero size regions to
keep the backward compatibility since disallowing zero size regions
might be a breaking change for some users.

In addition, the same crash can happen when intervals_goal.access_bp is
zero so this should be fixed in stable trees as well.

Fixes: f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Cc: stable@vger.kernel.org
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b217e0120e09..2a6b8d1c2c9e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1449,6 +1449,7 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
 		}
 	}
 	target_access_events = max_access_events * goal_bp / 10000;
+	target_access_events = target_access_events ? : 1;
 	return access_events * 10000 / target_access_events;
 }
 
-- 
2.34.1

