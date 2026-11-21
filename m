Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294823;
	b=sUJw8YcnsNAbXahG8NVGNi9P+APr4FyqN6fAvnAd5z2t9gLQujbiJpB7CsgEVK0lmpYe
	 KMGph8+4SpRdxoge7xTXokD0239K1EdnuDaZmlWBehK4n7TihHN394fs1mSo4VcEnEGwE
	 y9ovpBEuzHLTJfjOG7L7p2GnobVdaSMhDVli9V957mdCQpKxlg4Wo5mQBXoBpeE1PcLB7
	 yBxJYP+XSLRoYWZks4dD46wbxT0npcEtM/0Byrz6GghTRGROUoIsfL/iXD3br+q29Yz7y
	 i330daQ1OkfgtbxzwF5L7vm1D23WHx+vOYYu7ACNcRZCGcYpsyBkfElaGEV3So21zAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZoY4hnFbJ5g7c+Vl7aZxcV0uXn6NxmdIonYYm4S4XhY=;
	b=QZQB8cBcE08TgSOYTJJ8gFmCqNzDIhJpt26kY8I48K5GS/4ardDGpLvAVZTo168uIA+v
	 yKNyzM+WfklCeKJ2SL6jr9p7vW31ByTzsw1W1nkmdiL2sZC2hx7n6LPoH+nwHtValzZPR
	 xTrV7vKYA2LIEuDExxjcL2S0KaRt766mJHNoGnAE/WAAY3Giyisb9gxkJAKnccxWyG91e
	 q+pYiZ8hpSK22zASlxJ0UZ/Ovr8WWCC5WfpxuUGqMuB2X+UWuqXzOdlIRYWazJFkZvL/N
	 GBOuHv0vap8Ip4qxMUefB1oTWH9F/X85Pc0JYmLaWDWD+hsFcek6ikc7cBo+Kr+lSfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+oq892n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BB606A332
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+oq892n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2FF1F000CA;
	Sat, 21 Nov 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294823;
	bh=ZoY4hnFbJ5g7c+Vl7aZxcV0uXn6NxmdIonYYm4S4XhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+oq892ntVWyJ1YEx08mPaE1T7ozX6X9bt8h3AkLHAJZU03txkrSykNiibVGqpnsi
	 57qRTXoffWcB4LbH3pNbjR6GL5rbP023l7GXOMieGc7ku7xE7fne9df8ML5a2rTPP6
	 qdXmrAXbATdudDNxVmkgv5UOa08fZTJS2uPXEPI+dIXgaImLVnL56oLK/5xdyjxb4k
	 weh4L5Oa3/ozcOfCXYpWqvz2ImBcGpo9KaRKLiQyOqwmZ1TLZ35CNfca+vI7MympJj
	 L7n20JcnENZR2nCI6AUOXPfwwpAA5OzK305gwXUJX88SiyXLO1REQntnvXYu9kv+Tt
	 13ETmp4NmP1Rg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 06/27] mm/damon/sysfs: add producers/nr_producers file
Date: Sat, 21 Nov 2026 12:59:50 -0800
Message-ID: <20261121210013.130397-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new sysfs file, nr_producers, under the producers/
directory.  The file will be used for generating directories for each
report producer, in a manner that is similar to the nr_kdamonds file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 75701ed662222..d3a7cb170975a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2983,6 +2983,7 @@ static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 
 struct damon_sysfs_producers {
 	struct kobject kobj;
+	int nr;
 };
 
 static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
@@ -2990,12 +2991,62 @@ static struct damon_sysfs_producers *damon_sysfs_producers_alloc(void)
 	return kzalloc_obj(struct damon_sysfs_producers);
 }
 
+static void damon_sysfs_producers_rm_dirs(
+		struct damon_sysfs_producers *producers)
+{
+	producers->nr = 0;
+}
+
+static int damon_sysfs_producers_add_dirs(
+		struct damon_sysfs_producers *producers, int nr_producers)
+{
+	damon_sysfs_producers_rm_dirs(producers);
+	producers->nr = nr_producers;
+	return 0;
+}
+
+static ssize_t nr_producers_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_producers *producers = container_of(kobj,
+			struct damon_sysfs_producers, kobj);
+
+	return sysfs_emit(buf, "%d\n", producers->nr);
+}
+
+static ssize_t nr_producers_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_producers *producers;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	producers = container_of(kobj, struct damon_sysfs_producers, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_producers_add_dirs(producers, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
 static void damon_sysfs_producers_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_producers, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_producers_nr_attr =
+__ATTR_RW_MODE(nr_producers, 0600);
+
 static struct attribute *damon_sysfs_producers_attrs[] = {
+	&damon_sysfs_producers_nr_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_producers);
-- 
2.47.3
