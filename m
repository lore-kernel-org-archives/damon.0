Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A147ACC9;
	Mon, 14 Sep 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395819; cv=none; b=eEM6JXSg3tJGcPxlkxaCWIe8ttiKdsdNodEaS/rDpPAd845U3Yh2YQF3YB9hyU8hkOH94kvBXVdrSOKj+osfHH5vSaVQg7EREhTCrk9kPA+eTzVZ0SdBMVMXYzajxPaFgm68Yp8NyPRpr6HgR6KMW/VMXeLZJi6iOqnqd5/EPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395819; c=relaxed/simple;
	bh=dL2tCf9R2yFYdQyhb1vg7KlOpunIGTvyq2ICqewh28E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejZqbohv6QWfKU/DfUwABTeKxu8wntZiu4gZqij8mSITGglMxcv3u0tbNVxnZjqJU9CDln9egA1I8Tyut7vsLdFilnxIBkKBsc5UTdJWQtZhaZhoOwPvVTW9gX0vpyX1n852sFASDUvv6rrn/edXGXO/6usPWhv6lWGafsyrnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHui+Ibu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHui+Ibu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C731F0089D;
	Mon, 14 Sep 2026 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395817;
	bh=MBpdI9GABjSpbOSBeiuA8iViUPE/b+K1BLYoiHpgDDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHui+Ibu6V4Lmbd00FMAKZfVJb5+IqZz8jTq/0v8I2B8+lo0FsxJlHmOMWSR0fMh5
	 JL2VXI5yolS7lMgfsDUfqWTgMynzKD3HyBjZgbvoQzMmJ3RlGf3eMtuFH/bmK2gMSk
	 YXToqSlnJMVRQmhYY9we8UpQMKHjy4V0hPjl1v0zyTEs6Qw/Haq7HPkh1kwds5bSOQ
	 jXArOAnECpOT850NqXI5lJoRHacAzEBSTVD1CUp1gLYdFXjPjM6cJiDZo+bYNaAQ6H
	 JGoi/mXF67cUwkrxdxos5vKiNjXPU/vRI39tUQCT3TyV8T+aF7HFba4PCsASHiy/K8
	 X14pGOEx9Ufcg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()
Date: Mon, 14 Sep 2026 07:23:23 -0700
Message-ID: <20260914142327.92510-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914142327.92510-1-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_add_scheeme_filters() has long if-else chains for DAMOS
filter types.  Convert the code to use switch-case, which would be
cleaner and more efficient.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a4ec5d54cfbd1..bfb6f0bc3f213 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2822,7 +2822,8 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 
 		if (!filter)
 			return -ENOMEM;
-		if (filter->type == DAMOS_FILTER_TYPE_MEMCG) {
+		switch (filter->type) {
+		case DAMOS_FILTER_TYPE_MEMCG:
 			err = damon_sysfs_memcg_path_to_id(
 					sysfs_filter->memcg_path,
 					&filter->memcg_id);
@@ -2830,16 +2831,23 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 				damos_destroy_filter(filter);
 				return err;
 			}
-		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
+			break;
+		case DAMOS_FILTER_TYPE_ADDR:
 			filter->addr_range = sysfs_filter->addr_range;
-		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
+			break;
+		case DAMOS_FILTER_TYPE_TARGET:
 			filter->target_idx = sysfs_filter->target_idx;
-		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
+			break;
+		case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
+			break;
+		case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
+			break;
+		default:
+			break;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
