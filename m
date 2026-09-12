Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112C3803F1;
	Sat, 12 Sep 2026 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240698; cv=none; b=QXG6ChF2XuHbO1enkBaiyrp4k6UVX0CYaCcoUHuHKt/SCou9/LkiBYACZFs0YgGta6K+JGqMDw/ZuDWMFA8ZxQpiwaCimcvmzBPOJK1BnM5PdXWlNbebBvOFx6JRHv7aoS6N3ymrbBEFsVT8Ml++gNv/C8dX6xrAHcpsbwQCtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240698; c=relaxed/simple;
	bh=tpVaEb4AYEZ73fAxIIPOmUa+AX18NBp3TqT+frNo5vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIs8go8BTuz6WNtme6pexOlkUe95DyVlfvxIaJxM9R/6DX6vu4rcuOGcuVVnYPP/GcrXugK8rowB0NGJ0Vbe4sr3wMkhzxd2mX7VKakji+YK8by01Vg+bobjrDm7hsHE8kGzLinIqBcMi0Ybx5dLjWMRaxz9GVjl/j3ny9Cpo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrI54Zs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrI54Zs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D961F0089C;
	Sat, 12 Sep 2026 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240697;
	bh=SymGB/Aunbf5NpktH/MrAmxXwvCzvOB6NopidPvvPWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hrI54Zs0ZHlyuNs81eKuRAMlM85IMUjCFlUF75HLy3CHQEDjXuDocyb4YDK9bd7RP
	 XXV8088K0UCW72zqDqixZ018ccn0C3TVca1VwYtAar8GVcp/9Wk+WqOd5uJovhKCBC
	 B8juJYsoPO5PZY/B2LP+S97g5c2Rx3gD1bxwMqg76MBNOwGZxmAvRTL4t7v3HXznre
	 SdTY3I3TGhLB0revSdscRgpafcNMBFbKIE+/JByjWA6pYnP/nBC7RndrwtxO8usccU
	 cvPAfDkYbxIW9LGScNDVhchTHJHoHhaYcqkZUpHqb5jDJM2U85ZxMJ4AlnMLbRZdyT
	 2xD2GqsAT++7g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/8] mm/damon/sysfs-schemes: drop centralized filter range arg validations
Date: Sat, 12 Sep 2026 12:18:03 -0700
Message-ID: <20260912191807.138502-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912191807.138502-1-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is validating wrong range arguments for DAMOS
filters.  Now the core layer is doing the same validation.  Drop the
duplicated validation in DAMON sysfs interface.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8c8ab82c8facc..a4ec5d54cfbd1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
 			filter->addr_range = sysfs_filter->addr_range;
-			if (filter->addr_range.end <
-					filter->addr_range.start) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
