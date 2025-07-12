Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E35226533;
	Sat, 12 Jul 2025 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353216; cv=none; b=XPwCiO8OIF2GOFlRh0jEiJLoi3dh7NKCGW6d2yKVv1RDEWLSc0uQLouM4UGqEDAFKLwmuMHP1yT6qm7LOTmbbrQ8drG32BHd/Np+melSQaw9ptjePO3RlF1lkwLhakmmTD/oaXntgl+6Y87GN1PHkUDHuS+OE+QytuFXb8ZsWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353216; c=relaxed/simple;
	bh=UtykI35djlz4/u32hylRxjPmwdljWWbpzC+3yqmXBmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7j7XMlKr0vkYkZzRnpJwnIxRtXqD/kBQVWxeyMVNPmkzOYz49oCSg3VL3DzexwgrvgoHXpgAl3TvN1bgw32wfZSi1K8KMGr7ckf2H12jArV321zI6wqNVl6jCzLXtpfGm+OWZMFwDPpI8trehz0kflYFPeRdi7oIG/3zH49tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKXmsoFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKXmsoFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BAEC4CEF5;
	Sat, 12 Jul 2025 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752353215;
	bh=UtykI35djlz4/u32hylRxjPmwdljWWbpzC+3yqmXBmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKXmsoFAs466IPb6TIRODKI2CQxvs86/uZM4eH3FJg/J0ByWSdYPzb8ihymdxa3jM
	 vuYk16p5TqkYWSAI9uFiwXqxhMnQDvA3W/0YcxgbqEW/Vqq80Qf6X/clEg0dRabl44
	 x4H21qFJI4vKA4XSFkxXscuR8AvQtc9bjOfUcTz7F/oqswZymvptTJCMd0vtKFhto/
	 By/O4Kfayr3szeuou5hqcwtHgh8gGRDkvcA9gs1Lta9Zuu+SWWwhWDjDjXvCXooyy1
	 CbRmrxpyTL8ac3o3G5wKy8V7rkZvn4tqJvNMWEZYAUcJoBIbvmSpCJZg+R3RqxGE3W
	 1YJqexl5ebcRg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon/sysfs: implement refresh_ms file under kdamond directory
Date: Sat, 12 Jul 2025 13:46:46 -0700
Message-Id: <20250712204650.155988-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712204650.155988-1-sj@kernel.org>
References: <20250712204650.155988-1-sj@kernel.org>
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
