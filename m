Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE231F8AC5;
	Thu, 17 Jul 2025 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731697; cv=none; b=P1H6AySCUAKz8Yi2p1BzEah1VY0M83sZkJVWfWTfhhvi4lLdXZdLgzT209A04cnEP+fhr+c02m9ml/BCUYRwfNl2UsviaRelinregnZTZ5fYqsdgeUIvZ+yk/mQ0ZS7UoRVkJlXF45mzZkXKc1sULgSX1erY9nTinOL9Oriht9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731697; c=relaxed/simple;
	bh=UtykI35djlz4/u32hylRxjPmwdljWWbpzC+3yqmXBmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tv6ZcGhK9xdv8DJkRtQv/cxb4daYSQ5oD33rSgKfgl2t00yBQiox8+s0VkHImXNKNF8KC0QB4M519WkpegP4ncN/AAXseaAi3CZ8Fmk2KG5tFFu+H4eD007uCmUVp0FigTd4ysz7KOPKkscay+77AZsKTiE1CuGfk843fHenwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No+y/kRh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No+y/kRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77003C4CEED;
	Thu, 17 Jul 2025 05:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752731695;
	bh=UtykI35djlz4/u32hylRxjPmwdljWWbpzC+3yqmXBmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=No+y/kRh+ouxJUHLNZzi6B/wN5RKDkCa/e8cn6fr6+kyErKqAJ8wQbJm9E4bRTJOD
	 5FD6eBqE+UviTyLGBHE8jOJLpB+hOcuUzYycysRtn8WnQSZVGt211OuoNFW+Z68iS3
	 An1o+1t/XknkKZyFm6hZVoRVAKkXSFHSlERA00prjZxE5/Mva4OQz2UkQVeOdtomu6
	 EIgiHO3BaZZvANKWr2PmE+sI9AQyYh3vRfAwV08yWem0VkblYUIKrjJ30VHuM6cEom
	 GZSjUUdAZ1LO4K5CajFQWHjxsfNVBw4MQ+w/Jp709ga2ZufpIdS3hgVweIMLaIJMN0
	 Zp5aemLP2eyrA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/damon/sysfs: implement refresh_ms file under kdamond directory
Date: Wed, 16 Jul 2025 22:54:45 -0700
Message-Id: <20250717055448.56976-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717055448.56976-1-sj@kernel.org>
References: <20250717055448.56976-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new DAMON sysfs file named 'refresh_ms' under each kdamond
directory.  The file will be used as a control knob of automatic refresh
of a few DAMON internal status files.  This commit implements only
minimum file operations, though.  The automatic refresh feature will be
implemented by the following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index cce2c8a296e2..4296dc201f4d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1155,6 +1155,7 @@ struct damon_sysfs_kdamond {
 	struct kobject kobj;
 	struct damon_sysfs_contexts *contexts;
 	struct damon_ctx *damon_ctx;
+	unsigned int refresh_ms;
 };
 
 static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
@@ -1690,6 +1691,30 @@ static ssize_t pid_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", pid);
 }
 
+static ssize_t refresh_ms_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+
+	return sysfs_emit(buf, "%u\n", kdamond->refresh_ms);
+}
+
+static ssize_t refresh_ms_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
+			struct damon_sysfs_kdamond, kobj);
+	unsigned int nr;
+	int err = kstrtouint(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	kdamond->refresh_ms = nr;
+	return count;
+}
+
 static void damon_sysfs_kdamond_release(struct kobject *kobj)
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
@@ -1706,9 +1731,13 @@ static struct kobj_attribute damon_sysfs_kdamond_state_attr =
 static struct kobj_attribute damon_sysfs_kdamond_pid_attr =
 		__ATTR_RO_MODE(pid, 0400);
 
+static struct kobj_attribute damon_sysfs_kdamond_refresh_ms_attr =
+		__ATTR_RW_MODE(refresh_ms, 0600);
+
 static struct attribute *damon_sysfs_kdamond_attrs[] = {
 	&damon_sysfs_kdamond_state_attr.attr,
 	&damon_sysfs_kdamond_pid_attr.attr,
+	&damon_sysfs_kdamond_refresh_ms_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_kdamond);
-- 
2.39.5
