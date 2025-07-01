Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B0264FA6
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357988; cv=none; b=Z9pyTwKhpzSVoy9LDGNZZ+6hXYWzxpKI+rnlp5kU0aU1OUVFd2bWHTLOLaNwPhnsp0AlkaXPsJlnO/aG0kMmEmdpE7YQGCcQdfQgBVA2Km/UZTzyn6L9of2WfqFYFCwKQxJzSfABkdBBjDEk1YpYMpoQGACZX42vm71FpVLrBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357988; c=relaxed/simple;
	bh=4ZdbJafntvQ12z29G21pvaE7wkTqSdFE40uN78M0HR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb2EEPlOJ3vBOFct2ewKJu0NC93pZoAqkTi5toiCoAQIRSb3FEnpdJYp/BYJrYsvIuftGEH5VmVDTaGuHzDkgnjG7optOZRkDTWHTDHe9BEStfq1/QsMlMtlDwl3rGXX8Xip+0FBor+YeFejUH4URV2YSf/8bZOYrjE5IwZHmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-d0-68639a152db7
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: [PATCH v2 4/4] mm/damon: fix divide by zero in damon_get_intervals_score()
Date: Tue,  1 Jul 2025 17:19:26 +0900
Message-ID: <20250701081927.1873-5-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250701081927.1873-1-honggyu.kim@sk.com>
References: <20250701081927.1873-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsXC9ZZnoa7orOQMg74VPBZz1q9hs3jy/zer
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9Tsz4zeLxYvNMxgCWKC6blNSczLLUIn27BK6M3Ufv
	sxXc5Kz48fk9awPjP/YuRg4OCQETiWmNUV2MnGDm/i27GUFsNgE1iSsvJzGBlIgIWElM2xEL
	EmYWWMEoMW9FHEhYWCBY4le3M0iYRUBVYsP3DSwgNq+AmcSKVw8YISZqSjze/hNsEaeAucSq
	O+wgYSGgknkPbkCVC0qcnPmEBWK6vETz1tnMXYxcQK09bBLTl7xhg5gjKXFwxQ2WCYz8s5D0
	zELSs4CRaRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYAAuq/0TvYPx04XgQ4wCHIxKPLwzTiZl
	CLEmlhVX5h5ilOBgVhLh5ZNNzhDiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7
	NbUgtQgmy8TBKdXAGOco8DPynO6ygO0xUiGpGjKVd35/O8mflbfTrdPjU7yp2PPns5wYdonE
	PTW/LP1rpS6nVmXJl9VcKtf7jI7mmd2a2jXvXXD3t3W8RTceMUkuUDhkMv/Umg2WYpm3+w+3
	vy14bS4c+vHfmtWVqi9m3l142rbq4ZLiF3/3/reeuGMGwz7+95qzTZRYijMSDbWYi4oTAcyq
	AwA8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsXCNUNLT1d0VnKGwbxkiznr17BZPPn/m9Xi
	87PXzBaH555ktbi35j+rxeGvb5gsfm9bwebA7rFpVSebx6ZPk9g9Tsz4zeLxYvNMRo9vtz08
	Fr/4wBTAFsVlk5Kak1mWWqRvl8CVsfvofbaCm5wVPz6/Z21g/MfexcjJISFgIrF/y25GEJtN
	QE3iystJTF2MHBwiAlYS03bEgoSZBVYwSsxbEQcSFhYIlvjV7QwSZhFQldjwfQMLiM0rYCax
	4tUDRoiJmhKPt/9kBynnFDCXWHUHbJEQUMm8BzegygUlTs58wgIxXV6ieets5gmMPLOQpGYh
	SS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGGrLav9M3MH45bL7IUYBDkYlHl6DvKQM
	IdbEsuLK3EOMEhzMSiK8fLLJGUK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNT
	UwtSi2CyTBycUg2MG0rD53+10Yic2pTEIeyv+vOKIV/SWUM9uRNqNz65X7y+40eTbLqE1N97
	qiq3BPUL+bzuzFvH+KdcJevzh7rNb6eW7i3/s3VrQkbMpa2T4/8GWjb/aouSZ7cITHqprJyY
	oCJTl+HC+aBz+6sLbXF3PJgm7bkd279lzoZdMp0X4n73m/ZNnLZXiaU4I9FQi7moOBEAwSm6
	+zECAAA=
X-CFilter-Loop: Reflected

The current implementation allows having zero size regions with no
special reasons, but damon_get_intervals_score() gets crashed by divide
by zero when the region size is zero.

  [   29.403950] Oops: divide error: 0000 [#1] SMP NOPTI

This patch fixes the bug, but does not disallow zero size regions to
keep the backward compatibility since disallowing zero size regions
might be a breaking change for some users.

Fixes: f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>
---
 mm/damon/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b217e0120e09..e274a4d958d6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1448,7 +1448,10 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
 			access_events += sz_region * r->nr_accesses;
 		}
 	}
-	target_access_events = max_access_events * goal_bp / 10000;
+	if (likely(max_access_events) > 0)
+		target_access_events = max_access_events * goal_bp / 10000;
+	else
+		target_access_events = 1;
 	return access_events * 10000 / target_access_events;
 }
 
-- 
2.34.1

