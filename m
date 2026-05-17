Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AB3CBE70;
	Sun, 17 May 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040758; cv=none; b=X9N/N1K+nv9tnq9nYZS0ZhQ4whPT0+4E0vC2isfVKeG99ozBX5jfdBSK+llOG4ZntBPYn6e+Dsv0uW3Ps5doqYyHtcHSP2gZToclnBnmjjWJwuh8/yZ7Z2ipS95UA2e3EfgHTa3Zjq4O9g0OvSHqjxHvL/zZhz6c/l+O1k4QEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040758; c=relaxed/simple;
	bh=9oeAOM3C3JyLTWhy1VBvlaGvxy8pkJWaNVHEz9VMkTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOISB+uuzVTLNYZzHZVHa4TmUkgtjvS6SUTOOaxt4LYPVbZjPPHQD208aTO4CixYHtFLwGAyKBZuiPexeDhP12Z9JFfwuATi+oV0L0FVpCJk6znE+U2sB2F/gws8O2M4w7EEn5CZu5uJ7oQQfvLcyhbxw8GPM/VFNp/Ff82fiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVFvnMWT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVFvnMWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004BC2BCC6;
	Sun, 17 May 2026 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779040758;
	bh=9oeAOM3C3JyLTWhy1VBvlaGvxy8pkJWaNVHEz9VMkTM=;
	h=From:To:Cc:Subject:Date:From;
	b=iVFvnMWTyqqjm79NBQpe7V4oI06vsZGTDzY7tpd9W7zIPiaryq9eo59WDqrHXIYZe
	 fOsQLG1lXTSIRX0IjraqXSbRAfnAZfF8xDJ5A2xaUFGakSTwysu9RUzmkwW+6oGd7M
	 ByIiZXCVC20FsfKH0YWVg8zeMst/q/aPqahPxvSpO+eBINm4fyA52cfrnrTjJygumH
	 E800lzDMC3dsnouqtEFmCVVlLuZefkiZNHIdIRoB3/TperCfQUxLBIVhUdTUqQc0gB
	 TXYPY7mhgXindqbA5v1FyDSB0o+u03KNUcT+ZS104wTiaRCq6xft0PUBWGc81BtQCq
	 ajvu0jOT4DWWA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Sun, 17 May 2026 10:59:13 -0700
Message-ID: <20260517175915.3352-1-sj@kernel.org>
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
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260517172624.888-1-sj@kernel.org
- Rebase to mm-stable (7.1-rc3) for Sashiko review.
Changes from RFC
- RFC: https://lore.kernel.org/20260516211436.1883-1-sj@kernel.org
- Add region to the list after kobject_init_and_add() success.

 mm/damon/sysfs-schemes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 245d63808411a..a2ebc752d9332 100644
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
@@ -2926,15 +2925,16 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	region = damon_sysfs_scheme_region_alloc(r);
 	if (!region)
 		return;
-	region->sz_filter_passed = sz_filter_passed;
-	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
 				sysfs_regions->nr_regions++)) {
 		kobject_put(&region->kobj);
+		return;
 	}
+	region->sz_filter_passed = sz_filter_passed;
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
 }
 
 int damon_sysfs_schemes_clear_regions(

base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.47.3
