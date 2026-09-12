Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99643812F7;
	Sat, 12 Sep 2026 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240699; cv=none; b=F7Po0XPngPSh3+por/tA5W/btw06s7Hld3nVim0v2BQa90lvTq9IiXbhpP6rQm0PmMuppHRKOpy0D2YD0B07vZTAw4akDhBnvgV2cfBkOil63cgjgiFL3YwhHrVaZH+xkEoT6k5e/pUFoS5SU7KGUxDz1BFQ4M+Vu0W5OPf9izU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240699; c=relaxed/simple;
	bh=dL2tCf9R2yFYdQyhb1vg7KlOpunIGTvyq2ICqewh28E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0MwNxHLse//rMZe98KcUNwzxReNfBQV1Kj2woA+AY2AEzeFfB7YH3EKJUNFDcB4abXPd35s3X2qnKG1lKVQ37V/J63airg240+1ctEj7ZNA/zwWNOTbwQbVBakOW337mQLnIkAe/SD7MFbaKK2t53piTFkruq+z2kE07nPeIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/hHv/R2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/hHv/R2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2E01F0089E;
	Sat, 12 Sep 2026 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240697;
	bh=MBpdI9GABjSpbOSBeiuA8iViUPE/b+K1BLYoiHpgDDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/hHv/R2tnulEDhwwUYhXoSm0PLal63tqu6VxubfKNipw+ZB6kOqdo2/OZcxjf4h1
	 ZqDf8SWbF+r9N9cGHCgDmyoAaOGQZzPBM9jkFEH0R1raZ8pwe2dWDbA3m5lhDpXBj3
	 mwDnpLLyvSS72+3c0DCN79RClX5TCD7DzfeEThjgqJE8n7ivYXs1oXC92CD5n26pu6
	 XV2WUAA/VfaoMEb5RTpslKMaxUB9aU5jKpxhB/jZQjnRfg6SfTn7yUVhzJj9fhv40l
	 t2FJDAeqsPVeKwt2/6wiZSAaNLj8+OwqIGYxpGJ+14RisXyWKxHZScJbXTanAMweM2
	 uvM3B6v0cggxg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/8] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()
Date: Sat, 12 Sep 2026 12:18:04 -0700
Message-ID: <20260912191807.138502-7-sj@kernel.org>
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
