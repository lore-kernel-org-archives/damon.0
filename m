Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372B385D69;
	Sat, 16 May 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778966081; cv=none; b=JR0G/14NMPsb+w7KBuPbnVwlbHBO8uSJwr9neCXAwU/v0wY9alvNaniK/PXxqfLpBsVEA7Ext71ztru5fcY8sNuZ2DQSFZFGNUA9VmBhHeu05FrVaujb+ey4L6ZBi9LKAQOYaSzRxMXOdLyMO3psEsG3hzOVovw0IvqiTlsjxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778966081; c=relaxed/simple;
	bh=eXb27mgMuft7D/Kna5spkvt2pEa3JGTJj4WtzToGUq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=garI8TcWTHY84FdugXaUyt7nJVpts1/++yz2z2RpZ+pnvdXTVQ7S6Fv1ignR7QJcsQrCovJfRyRdjkCP95DvtmPY1WB6Up6FEA0JYjKwdiSa2sGvLRMlDTL6waCnhuK7rscnIk7wPkd7rYaAfzY15urep3wJJ1OomndVPTzN2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udodKoFy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udodKoFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A661C19425;
	Sat, 16 May 2026 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778966081;
	bh=eXb27mgMuft7D/Kna5spkvt2pEa3JGTJj4WtzToGUq8=;
	h=From:To:Cc:Subject:Date:From;
	b=udodKoFyHuHw4e0+rQfbvCgxWvRXAMA4MMsmXi6USJIVqOK57GtkP7btDpyX7gqOF
	 qUGCCUA0oc8cegm1UYvT70jB1q53LkMvmvljziC78Fe9KXro2TZBkDcICXg90kFLHG
	 0wAz4HROL6k7Icrw4KMmPOZK+AZsHcUxNh6saUH29fCbEoKaMSju4n9OxbjMWNJqA7
	 rxgfKOL8sUqN+j7SpEkM3FZBtv8c53toiG++jNgiZUCGKeeK3HFxTZ+q9Yi1KkfqUS
	 FLgTNGmPFezzVwz/yclBqy6GAseYw/iokdRYXDYzLmhYWrXqXPMjGtGlFX+d0v7NRM
	 qoFYWjLSd4v2g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Sat, 16 May 2026 14:14:35 -0700
Message-ID: <20260516211436.1883-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs maintains the DAMOS tried region directory objects via a
linked list.  When the user requests refresh of the directories, DAMON
sysfs removes all the region directories first, and then generate
updated regions directory on the empty space.  The removal function
(damon_sysfs_scheme_regions_rm_dirs()) only puts the kobj objects.
Deletion of the container region object from the linked list is done
inside the kobj release callback function.

If somehow the callback invocation is delayed, the list will contain
regions list that gonna be freed.  If the updated region directories
creation is started in this situation, the list can be corrupted and
use-after-free can happen.

Because the kobj objects are managed by only DAMON sysfs, the issue
cannot happen in normal situation.  But, such delays can be made on
kernels that built with CONFIG_DEBUG_KOBJECT_RELEASE.  On the kernel,
the issue can indeed be reproduced like below.

    # damo start --damos_action stat
    # cd /sys/kernel/mm/damon/admin/kdamonds/0/
    # for i in {1..10}; do echo update_schemes_tried_regions > state; done
    # dmesg | grep underflow
    [   89.296152] refcount_t: underflow; use-after-free.

Fix the issue by removing the region object from the list when
decrementing the reference count.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org

Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5d966ac864193..52627ce3a1a62 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -88,7 +88,6 @@ static void damon_sysfs_scheme_region_release(struct kobject *kobj)
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	list_del(&region->list);
 	kfree(region);
 }
 
@@ -164,7 +163,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	struct damon_sysfs_scheme_region *r, *next;
 
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
-		/* release function deletes it from the list */
+		list_del(&r->list);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}

base-commit: 950de73f0f8bb17fc322e8f9ec09a5fbb4a72ed8
-- 
2.47.3
