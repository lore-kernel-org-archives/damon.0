Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B4397329;
	Fri, 19 Jun 2026 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897678; cv=none; b=MeCZWUc2bf1Rs4kQT/LbPxVnHGNuVJ5D26aesXfQBphdBrK84PI3dhaBDNLoXMqtt3f3lpf6wuA0p/CIkZM1ep2KiGd7KaiSNiBqL13duEtJMY/Q7Obv7dX3XLaFdrzxPo1g/j/kyQMlIqxoqOKKxzFDdhsaoxyB8U83ikmQUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897678; c=relaxed/simple;
	bh=aIGhUJ4IoRlUb8jMftp99Tj2NImb49Pmhd/fzeAvk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTE/T2yvQVMGrQbeQ4tWKZvwWfAqg/xS8nlyATzUJ3maV1SupRWHpsNNRfnp/nPLlT03lZltMGvw4ZDgdbmbNyI3C7FCqckgWdO7sZKq/xEsMcBKIz70CHEgXrPqbadMblbxdXVu4iMJgOL4ObifkiDqZslw6jkBooJo4W/PhCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgQozR+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgQozR+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E60A1F00A3A;
	Fri, 19 Jun 2026 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897674;
	bh=HUk5Cck1sJbUUjMgjgxqdG3j5G1J/Fn/sddbtTw+llU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QgQozR+Evjxx196nYAkpmjcXIrwW+sdgpUxyCTAjW8wWiUIxD6/xkdbLciJckZvuq
	 VSgpPpKcMQibZqrAxL4gxG+23aw4+gas8EyJHsGfLK0G8588li0ummvEHKzgbe2bRd
	 ZAqk0iTZch+Ab+Mv7P+FbcOKb+M1V7XHie6vxs5xngV1cLH3xekB211UI02FFoC089
	 PNno4ZJqLjMQX4bU7LPIMmPthlrh4BNDS3zIJ8GCLf1J9OBqxjtzf/bR76SfkPNm44
	 bEwLr9oMdClEc5DWiyaxoq8y4GrbjO/sG43p61qLt9zzKEKJxO95sUercut2mEzzOG
	 NwC2TmaZxkgmg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/13] mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
Date: Fri, 19 Jun 2026 12:33:50 -0700
Message-ID: <20260619193415.73833-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_mvsum() returns a value same to nr_accesses_bp.  Also
the function is more simple and therefore more tolerant to errors.
Execution of the function would be more expensive than the simple read
of the field, but because the function is quite simple, the overhead
should be negligible.  Use it in the DAMON sysfs interface for
scheme-tried regions, instead of the nr_accesses_bp.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9d8fab32b80f7..30a007bcf82f4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -159,7 +159,7 @@ struct damon_sysfs_scheme_region {
 };
 
 static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
-		struct damon_region *region)
+		struct damon_region *region, struct damon_ctx *ctx)
 {
 	struct damon_sysfs_scheme_region *sysfs_region = kmalloc_obj(*sysfs_region);
 
@@ -167,7 +167,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 		return NULL;
 	sysfs_region->kobj = (struct kobject){};
 	sysfs_region->ar = region->ar;
-	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
+	sysfs_region->nr_accesses = damon_nr_accesses_mvsum(region, ctx);
 	sysfs_region->age = region->age;
 	sysfs_region->probes = NULL;
 	INIT_LIST_HEAD(&sysfs_region->list);
@@ -3124,7 +3124,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (total_bytes_only)
 		return;
 
-	region = damon_sysfs_scheme_region_alloc(r);
+	region = damon_sysfs_scheme_region_alloc(r, ctx);
 	if (!region)
 		return;
 	region->sz_filter_passed = sz_filter_passed;
-- 
2.47.3
