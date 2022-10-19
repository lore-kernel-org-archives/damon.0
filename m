Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676C1851
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 00:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03394C43143;
	Wed, 19 Oct 2022 00:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666138407;
	bh=ujSci3Jr9yWO8XdHXzr/zi1RpAlYDD3yaad0xsGDwtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqdDiFtCwIgZRauAibxFTY0xxMT21TP4sJWBZxuoXVCoBeOE/nUzDBSSKb/XDoolr
	 H3hSh8l2G2xHPvF3K1Wcf/Yi8+zX88kHSAj0bc242eWmBspKXRxucRxMtRSqYKPaBY
	 N7ahcK87QvjxtfusnABfcZ9nQcZ26u5nJwi/zxHvzTVOEwG/ojX+OKcnQvvrBwJcIy
	 ONFBk8PmkaL3RjDbJCO5g051DKHayZL1Dvf4OMRKr7MITxJqMFNs+NBnLq39y3EXRE
	 ZAeuYmtbGwiRmVaFB1xLiL9jy1IALkSv5U4bZxSHeqVVV22jSTGHSc0ToUcdMWPjFa
	 n6IBUKynEQUGA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/18] mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
Date: Wed, 19 Oct 2022 00:13:07 +0000
Message-Id: <20221019001317.104270-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019001317.104270-1-sj@kernel.org>
References: <20221019001317.104270-1-sj@kernel.org>
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

