Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F316AD8
	for <damon@lists.linux.dev>; Mon, 24 Oct 2022 20:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5A2C433D6;
	Mon, 24 Oct 2022 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666644568;
	bh=ujSci3Jr9yWO8XdHXzr/zi1RpAlYDD3yaad0xsGDwtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0PNJwF7F8B6wDCT8U5OvUuUzVBgp8YQ/xYp56NtYF3J+apq8tV363lbDS/dAVE9x
	 fmE1KhGzme+66U40xnPxhCiGER08YnmCVpFOOoXzMNwJdsHg9XkhE0h2IglBKku8Qk
	 0R3GZqSNZtFaMKpOjz9jv3aamgzvzty7b1BBMqBiUTBM5Z3QCKDU2LJ1lVnuJfzih4
	 YiMPbVNMnUXZTngRymS02lmsG8cD41erv/DtQA2mKokmw5y+4FXwKDV4hBH/tUKLJY
	 2YNKfkUPrm/R4hseLEskL/AinkQdMCyRdNeV3Gza0l5JxjrTscQ6MhU4BaaSFDNiXW
	 zkY/9xpZ6LDRg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
Date: Mon, 24 Oct 2022 20:49:14 +0000
Message-Id: <20221024204919.18524-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204919.18524-1-sj@kernel.org>
References: <20221024204919.18524-1-sj@kernel.org>
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

