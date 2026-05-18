Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99922275B1A;
	Mon, 18 May 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117963; cv=none; b=BDNX+2nOqlGyI+QiOsgkKsg0WL1+60i7RYFgQPvvrS46YDJ5KG/r3sdsKTasZoM51pO64XcSafmGnbVlNVIhh2FdahDA5tv2TZ8bUCgpOkgq17KauioU8wyCsYQrZEPzCkDAvwhMsRQ6lVyDggrzwhfaT473rMNwuqK/lwfR1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117963; c=relaxed/simple;
	bh=cwdjynvPa/H+eNZ07FnU5IjYqj8QXiHrUvyf6S8ZfXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvgpEo+l/2leVFROW3bM43BbPe6GnqQ0HbCYzuBVUB7JLqe2tFyqfzQr0yc3OeV7vLcHe0/CqwTiYFxvCPzbirMoY51yUzGKgfNvapZaY30YiSHCUcbIp8HZP64s99y9+qePshQeUZKeC0pEPccpCj1aBhP9DDUUpNW2a6xnRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2vrtLzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2vrtLzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FD0C2BCB7;
	Mon, 18 May 2026 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779117963;
	bh=cwdjynvPa/H+eNZ07FnU5IjYqj8QXiHrUvyf6S8ZfXI=;
	h=From:To:Cc:Subject:Date:From;
	b=l2vrtLzkQKTZLSS+Q7GJsPDheHmirfH6zjVp0KuGNVGgwip7T0QS9ISK4lCLw/bJN
	 4eGoHgF2y7o/XkcEa3GPR68F4g8dzCEfkTxUTpdnSZG0bw5Jvbe+HjDUCJNCHIU248
	 eX59WGC66e08i3G86+ms04Jp7zI0Q/bsTViFXMSBEcn4XFON6bKoO7gQNayHWGBRgs
	 OJi2BDRh4DxtLWhtP6+RsDJk/niTXzYa/vqn4AhtozcsJ0iE+k+N6E0niI2MskHzXp
	 adleg7gnnE/ANdHVmJCstv1IiME4m+u+evm+WHEEFUDkRz0XsjURrXYGedW0uUM6sM
	 UQO/5Tce9aNqg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Mon, 18 May 2026 08:25:58 -0700
Message-ID: <20260518152559.93038-1-sj@kernel.org>
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

Also update damos_sysfs_populate_region_dir() to add the region object
to the list only after the kobject_init_and_add() is success, so that
fail of kobject_init_and_add() is not leaving the deallocated object on
the list.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org

Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC v2.2
- RFC v2.2: https://lore.kernel.org/20260518014520.88424-1-sj@kernel.org
- Drop RFC tag.
- Rebase to mm-new.
Changes from RFC v2.1
- RFC v2.1: https://lore.kernel.org/20260517175915.3352-1-sj@kernel.org
- Set sz_filter_passed before kobject_init_add().
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260517172624.888-1-sj@kernel.org
- Rebase to mm-stable (7.1-rc3) for Sashiko review.
Changes from RFC
- RFC: https://lore.kernel.org/20260516211436.1883-1-sj@kernel.org
- Add region to the list after kobject_init_and_add() success.

 mm/damon/sysfs-schemes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5d966ac864193..0d3021db0b99b 100644
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
@@ -2993,14 +2992,15 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (!region)
 		return;
 	region->sz_filter_passed = sz_filter_passed;
-	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
 				sysfs_regions->nr_regions)) {
 		kobject_put(&region->kobj);
+		return;
 	}
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
 }
 
 int damon_sysfs_schemes_clear_regions(

base-commit: 011caa6d782382337b598a92aefe3c5db5ed8c0e
-- 
2.47.3
