Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B61C15
	for <damon@lists.linux.dev>; Sat, 16 Sep 2023 02:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0623C433C8;
	Sat, 16 Sep 2023 02:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694830198;
	bh=DNLoykVfcLunzlqLq92ppaTwpNSuqGnLy/p/x4HnboY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOW72m4+tcRyIHubvfGta2PK60I+MtD4+v+Xr+eH0EemTaxQPuTpCGCkUMLnjCAa+
	 o/2hmGpyllSeicIhd3FysLe0WsJ8ETtGUxFa7DFAmLgljTuv8bSbEQX785z8vISz2W
	 ULi87aU+zbisxJZKBJ7bMQ5GwcLGJYKr1vBzMsiUzRCaqaatj7WjHpB7n5/570XMYj
	 QjUNjvbxGcwD9TPVr7FBbPoMwNYPLh3eRe/8kKkE8me85m9jNJL4GfTQoKudWnzImQ
	 vsDZ2/2R8LpB8aAXw+R0ARwhL5AEaBGZAzoS/PYxAr/WWECQg4TsDtiObwoyz/ZEpc
	 mD1gZAGqr5wfQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mm/damon/sysfs-schemes: use nr_accesses_bp as the source of tried_regions/<N>/nr_accesses
Date: Sat, 16 Sep 2023 02:09:38 +0000
Message-Id: <20230916020945.47296-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface exposes access rate of each region via DAMOS tried
regions directory.  For this, the nr_accesses field of the region is
used.  DAMOS was actually using nr_accesses in the past, but it uses
nr_accesses_bp now.  Use the value that it is really using as the
source.

Note that this doesn't expose nr_accesses_bp as is (in basis point), but
after converting it to the natural number by dividing the value by
10,000.  Hence there is no behavioral change from users' perspective.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 527e7d17eb3b..093700f50b18 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -31,7 +31,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 		return NULL;
 	sysfs_region->kobj = (struct kobject){};
 	sysfs_region->ar = region->ar;
-	sysfs_region->nr_accesses = region->nr_accesses;
+	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
 	sysfs_region->age = region->age;
 	INIT_LIST_HEAD(&sysfs_region->list);
 	return sysfs_region;
-- 
2.25.1

