Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCFC383C8E
	for <damon@lists.linux.dev>; Mon, 20 Apr 2026 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689653; cv=none; b=PFsPrA5gH38RYPxIvpKJHkVCxydOeb0G2KTECwLnpnQq9UrpFbtYpGx/zConDDpE9RYT7K61i5UAzRhTBMgwagJC3vtIAt9/1mL8sxcK6Qhb0P7hrFprv1E0+qpVUjtiYhTO7qtgfbycnx78I/LRKo+JnIeiJtVoTO9jfBoOI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689653; c=relaxed/simple;
	bh=52YnQbH20Fn7ucrG3Y3QUGJpLEU04PFKTpj+ckFomaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omf2YrwZh2bYO1r9n1bd/zcn4NQ/aQFUN/y1ZhPS/m11DugYiCAs0jmI3t2AYkMgTtLXIpmLeeMYYzETdLtRV0U2RoPYu0543V59OBRl6IXPVakkUCYWDvjc8x2wik0gVSbD3n3NoGwK0F6bclKfIHp8eBOzT8Win4Bc7TMIzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scIF3jYo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scIF3jYo"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d95017a68so1909616a91.3
        for <damon@lists.linux.dev>; Mon, 20 Apr 2026 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776689651; x=1777294451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21qwcfMPBqAFoGsY5GMYgj3M1yvirBqTjEWNooxl2kM=;
        b=scIF3jYovK03/XqLhGj6m2uD6Gt2ZxLCpSgTejCre7rVrzn0xX92WjwEbJzERVbUDr
         wV+UowFrkP3xK34LhBS03NvKF5LBnks4EHn2jtPEhQe61R/5hp4ZqZuvXVfEDURI+G5B
         o7TrXmyDH7FeJpl2YyozUp0yn2UuJTsH+4woDyUYrgBvtFrIHX2hfA8nyS/88db1j8CV
         KmL8rmTIQSUoXs/kpcQ2UVBp9dmcfHbgZ0h9geX3MIna9LiuC5qEdkrvGUqEUWYAnn5k
         tKhAK0KmPCMKzGtZbyxdAgyckGon9T4aG7Uog0X96akJ6zUein1jTUhor8mG3q39fhx3
         rEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689651; x=1777294451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=21qwcfMPBqAFoGsY5GMYgj3M1yvirBqTjEWNooxl2kM=;
        b=bqm9nrb0nPdlqSulzrfNfeJZsetgVQXtg4PA8IU2y12rkLWl8dE8U+JRDlrDcW7eSK
         4P2dODE9H2yQeyXrpGuuizPBnptmWEndEB37a7Dsd+KGRkqLEdOm5gDBCchVck3VIm/r
         nNqfu4f7qjp1Q7G0pHmLRj+jr2bzoD49jcHNDp1oSfb+S5+Gk+LlGqbgV7FY6QqG4ydw
         Ix6W1fYJ6jaKy27gcIDU/WuHE+2o645RU0i5bpH11snHzoIdW1FNvEti2cSq40RpRt82
         Gek8i7Td22IviHzazwvECmFzY4fthCcrUtk2oOYuFyp0x6bMRs1GwtCtV1avwoSuERMX
         BL9g==
X-Forwarded-Encrypted: i=1; AFNElJ/f+T64eY6VnjJxSfJGPzGsHBa4pNG5cB116vTQ+M5ke8GIpg3bJg8LvKphXBRv58jmQie5Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQRUhE+Lto9KfynEXc0vdNYi3rzWFh+xZILSx/JeNR54dOdiKE
	jBpKccJlRMazRH0D/qshjpnobYdkNWHn1/vBsmhUnO2qZkZEAT3Fr4/p
X-Gm-Gg: AeBDiesR3IapJGCr6oR5496pWcw7eyi8KmZx6N8GBDCZMti9jif7V5L9vlHxmOw+MNo
	q9o0KJVDwDoh7b+kqfKBl603Zz+CTdhLvJ0pXUmey6C4Xo3Ua1hZOv1Tv9kJbqi7C4TPgzvlf+2
	swFc1T5EFm0BxWMhSH7rovBfoX/F8HkwHkn1zbhOjG7edQUs0TIr/0p0scYsz+Sc8HoJP5YvYAL
	fV7YMmxgzaVw78qAcxvjLSk3FFlQyoUkA5RwOm07hE4LnJm1qv99Ff+nd5a5jK+Oe9w4Omx9gvi
	8AtXL+8aFTry0s7QGqVkXxKs5WkNkWRskV6BTB9tnnu6GLZPqaFJXkcyjCWyAqax+y+B1iEY1Fg
	uXxZkdrdvOLsIWXvW/GU8opMVbZVy3aAGW27zNv1jcnA8osrRm+QTbjjMmBOrAwSpOadfyEuDTG
	DjEbXodJVOSr/77QFcWGDhZuvleCLR81UyJAMA1ZJ+lYnSUVpL0OV2cQ==
X-Received: by 2002:a17:902:e746:b0:2b0:60b2:4f8 with SMTP id d9443c01a7336-2b5f9f01725mr164450995ad.15.1776689650901;
        Mon, 20 Apr 2026 05:54:10 -0700 (PDT)
Received: from localhost.tail66efb9.ts.net ([240e:3b5:d06f:a890::1000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab2112csm98517395ad.62.2026.04.20.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:54:10 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: linux-mm@kvack.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path
Date: Mon, 20 Apr 2026 20:54:05 +0800
Message-Id: <20260420125405.362137-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420085332.178473-1-qjx1298677004@gmail.com>
References: <20260420085332.178473-1-qjx1298677004@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memcg_path_store() and path_store() free and replace their respective
string pointers without holding damon_sysfs_lock. This creates a race
with the kdamond thread, which reads these pointers in
damon_sysfs_add_scheme_filters() and damos_sysfs_add_quota_score()
via damon_call() during a "commit" operation.

The race window is as follows:
  Thread A (commit):  holds damon_sysfs_lock, triggers damon_call()
  kdamond thread:     reads sysfs_filter->memcg_path in
                      damon_sysfs_memcg_path_to_id()
  Thread B (sysfs):   calls memcg_path_store() WITHOUT lock,
                      kfree(filter->memcg_path), replaces pointer

Since Thread B does not hold damon_sysfs_lock, the kdamond thread can
observe a freed pointer, resulting in a use-after-free when
damon_sysfs_memcg_path_eq() dereferences it for string comparison.

Similarly, memcg_path_show() and path_show() read the string pointers
without holding the lock, so a concurrent store can free the string
just before sysfs_emit() dereferences it, causing a use-after-free.

KASAN reports the following on v7.0.0-rc5 with CONFIG_KASAN=y:

  ==================================================================
  BUG: KASAN: double-free in memcg_path_store+0x6e/0xc0

  Free of addr ffff888100a086c0 by task exp/149

  CPU: 1 UID: 0 PID: 149 Comm: exp Not tainted 7.0.0-rc5-gd38efd7c139a #18 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x55/0x70
   print_report+0xcb/0x5d0
   kasan_report_invalid_free+0x94/0xc0
   check_slab_allocation+0xde/0x110
   kfree+0x114/0x3b0
   memcg_path_store+0x6e/0xc0
   kernfs_fop_write_iter+0x2fc/0x490
   vfs_write+0x8e1/0xcc0
   ksys_write+0xee/0x1c0
   do_syscall_64+0xfc/0x580
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 147 on cpu 0 at 12.364295s:
   kasan_save_stack+0x24/0x50
   kasan_save_track+0x17/0x60
   __kasan_kmalloc+0x7f/0x90
   __kmalloc_noprof+0x191/0x490
   memcg_path_store+0x32/0xc0
   kernfs_fop_write_iter+0x2fc/0x490
   vfs_write+0x8e1/0xcc0
   ksys_write+0xee/0x1c0

  Freed by task 150 on cpu 0 at 13.373810s:
   kasan_save_stack+0x24/0x50
   kasan_save_track+0x17/0x60
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kfree+0x137/0x3b0
   memcg_path_store+0x6e/0xc0
   kernfs_fop_write_iter+0x2fc/0x490
   vfs_write+0x8e1/0xcc0
   ksys_write+0xee/0x1c0

  The buggy address belongs to the object at ffff888100a086c0
   which belongs to the cache kmalloc-8 of size 8
  ==================================================================

Fix this by holding damon_sysfs_lock while swapping the path pointer
in both memcg_path_store() and path_store(), and while reading the
path pointer in memcg_path_show() and path_show(). The actual kfree()
is moved outside the lock since the old pointer is no longer reachable
once replaced.

Fixes: 490a43d07f16 ("mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write")
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>

---
Changes in v2:
- Also protect memcg_path_show() and path_show() with damon_sysfs_lock,
  since sysfs show and store callbacks can run concurrently and a
  lockless read in show can race with the kfree in store. (Sashiko AI)

 mm/damon/sysfs-schemes.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5186966da..1a890e2a4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -533,9 +533,14 @@ static ssize_t memcg_path_show(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n",
+	mutex_lock(&damon_sysfs_lock);
+	len = sysfs_emit(buf, "%s\n",
 			filter->memcg_path ? filter->memcg_path : "");
+	mutex_unlock(&damon_sysfs_lock);
+
+	return len;
 }
 
 static ssize_t memcg_path_store(struct kobject *kobj,
@@ -543,15 +548,20 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
-				   GFP_KERNEL);
+	char *path, *old;
 
+	path = kmalloc_array(size_add(count, 1), sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
-	kfree(filter->memcg_path);
+
+	mutex_lock(&damon_sysfs_lock);
+	old = filter->memcg_path;
 	filter->memcg_path = path;
+	mutex_unlock(&damon_sysfs_lock);
+
+	kfree(old);
 	return count;
 }
 
@@ -1187,8 +1197,13 @@ static ssize_t path_show(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	mutex_lock(&damon_sysfs_lock);
+	len = sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	mutex_unlock(&damon_sysfs_lock);
+
+	return len;
 }
 
 static ssize_t path_store(struct kobject *kobj,
@@ -1196,15 +1211,20 @@ static ssize_t path_store(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
-	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
-				   GFP_KERNEL);
+	char *path, *old;
 
+	path = kmalloc_array(size_add(count, 1), sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
-	kfree(goal->path);
+
+	mutex_lock(&damon_sysfs_lock);
+	old = goal->path;
 	goal->path = path;
+	mutex_unlock(&damon_sysfs_lock);
+
+	kfree(old);
 	return count;
 }
 
-- 
2.34.1

