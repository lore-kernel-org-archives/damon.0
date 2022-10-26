Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EF7B
	for <damon@lists.linux.dev>; Wed, 26 Oct 2022 22:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E743C433D6;
	Wed, 26 Oct 2022 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666825192;
	bh=8GL00RPKqf41iTTBqJzSvs8lE7BF3n/Dkon2+BFR2Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MePX4QP7b/+bsXbvuYDWVKEzt8T7ttgcmo+ROEtbeepA6gq+RAYM+Hsv0n5MZf6HR
	 fOoJ7LQbDBQ7v3IRo7/ROwd6lLUpT6cU9hRCtPe42QeE9yahzPn39o6qYY4HZAXszM
	 WMjWy38qDWJp5lPr52IEJMiGkOi2vR3U/8zKGDomoHsUxjGV1Xms72lV21B8XHV2FX
	 sCZZY9ZwHNRf3X1FJ+/hjUjSHcvpyLLbkxY6mRBWxWaVNLgPZ83mX+cCZkJCdMKZeA
	 2LIeGNczowR3Brpwwht3QTd/GBnbqwBhiftq+gGAm2xeLrCnxfnX73vg/VLhWky2Nb
	 jHhgtItkwIP6g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 06/12] mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
Date: Wed, 26 Oct 2022 22:59:37 +0000
Message-Id: <20221026225943.100429-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'damon_sysfs_region_alloc()' is always called with zero-filled 'struct
damon_addr_range', because the start and end addresses should set by
users.  Remove unnecessary parameters of the function and simplify the
body by using 'kzalloc()'.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/sysfs.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b9183063bfea..e8bd7367d15b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1065,17 +1065,9 @@ struct damon_sysfs_region {
 	struct damon_addr_range ar;
 };
 
-static struct damon_sysfs_region *damon_sysfs_region_alloc(
-		struct damon_addr_range ar)
+static struct damon_sysfs_region *damon_sysfs_region_alloc(void)
 {
-	struct damon_sysfs_region *region = kmalloc(sizeof(*region),
-			GFP_KERNEL);
-
-	if (!region)
-		return NULL;
-	region->kobj = (struct kobject){};
-	region->ar = ar;
-	return region;
+	return kzalloc(sizeof(struct damon_sysfs_region), GFP_KERNEL);
 }
 
 static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1184,7 +1176,7 @@ static int damon_sysfs_regions_add_dirs(struct damon_sysfs_regions *regions,
 	regions->regions_arr = regions_arr;
 
 	for (i = 0; i < nr_regions; i++) {
-		region = damon_sysfs_region_alloc((struct damon_addr_range){});
+		region = damon_sysfs_region_alloc();
 		if (!region) {
 			damon_sysfs_regions_rm_dirs(regions);
 			return -ENOMEM;
-- 
2.25.1

