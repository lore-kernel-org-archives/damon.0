Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC84386C22;
	Sun, 13 Sep 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319838; cv=none; b=ocjGpZG432JnyY/ZELZ1P4/YcNKT2M017ztx6WU4BVw7ol6ux5qpcTewlTFJAyMryKtDRZ7yZzF7nEMOjCRWPkzc+K0JIpwZGirlR0aJirhUxmGmHcPX1lp9dPcpfpbnMLjc9/tCj/WsfC/4syjhybjJm3aG3M31IHMG0j8rKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319838; c=relaxed/simple;
	bh=dL2tCf9R2yFYdQyhb1vg7KlOpunIGTvyq2ICqewh28E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXqX0kHtMmcsx8ctk1M1+Y+wtuPJju1K+W20HwynwqFUxCqcs9YgNtS3ICRZu8H09MrOlD2octUCZI0oojsHa/FjB7YX1+YpKK5ftkc8EDIM+uttfyZxYPYE2rLESmBmZYH3/AzWk1AytLsbANyGBPoxPUwz3QhLtU17cTzuANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3theO8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3theO8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DE61F00893;
	Sun, 13 Sep 2026 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319836;
	bh=MBpdI9GABjSpbOSBeiuA8iViUPE/b+K1BLYoiHpgDDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i3theO8w1YobTHF6s/PdgEDvl2RO1oiaxzM5QTabU5Q5f4hgM09YO48RE+xK2BhS/
	 2PuETBuVcH7ddsdPJ1zFedK/5ncsVlKrMQiXz/YjPXq+9/OhhyEePrnBb6U7O1G6r2
	 /evjeSjdmRNl6b7X6sQrbgFIJubDAmmsb9H4YoE7p5O1VtOHLURdIP/G6TY3LLyhU3
	 IVeWc3L1J3huFBK7uzwLqnSPOt6arTQqBW53DKUxnjmgiH1BWhxYMhKMowA9UZ5SsL
	 hJG+jWq5t3qz2S0bWlbnDlrUntTv44zOf2oskBEz8Qn8dAtyqJR7XAVcY3kKa7lM5P
	 GMUHq6z+wFD9w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 6/8] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()
Date: Sun, 13 Sep 2026 10:17:03 -0700
Message-ID: <20260913171706.103052-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171706.103052-1-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
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
