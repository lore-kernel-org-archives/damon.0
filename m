Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BF2D8764;
	Mon,  8 Dec 2025 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175423; cv=none; b=rcw8QUuK+2NJCtvGQHDlj4UMHOJIGyg1P4N8SFxOXKj5l2YqUBS0W/efrfbdBkc4x8posL0XZHWzI0i3VLVz8tPjtn00nU0A6tl+dWteOr0hLyHVhlqx6ACLVk3+DyvTLfkCLaMNlUs6Rw8XernJ62inWA3R3QBv3ofSLHS1vkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175423; c=relaxed/simple;
	bh=WawtKcdhhI5OD3ibegWa6UMwH2uHq8mmOHPfQB4SyPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3UwEKhUXTeaQLCa8UbeCtdhg5+SW3imYHl1Xm4FY/2lle5yYQ2BrfRw2NA6/yxrjT7CRAJrSYdcVnZp8IexiILRq4lKgvvP8C/SEMFobzaXNW3yHYd1v6yHolH7JA3PT67fVDIZJlZMVDHfbtufh3HHEOyQCh7QMQmW9AHJlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aurXw1mb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aurXw1mb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D9BC19422;
	Mon,  8 Dec 2025 06:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175421;
	bh=WawtKcdhhI5OD3ibegWa6UMwH2uHq8mmOHPfQB4SyPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aurXw1mb7+DNtDpJv9c+X16hkpu7iLBKNTqx3ERbpveUEL1bLXLkCTPqiCj4TmA61
	 sdDkXckh9cBhOeKgjKPG5C4RW0kPzYzcIXKCJa8nnP5u5nOCXNSTx2QctBlb/swGvs
	 /iBJ3qv2lXDDAh0vhogHIF4P3J5MvZlunpW88MFJAL6sZvdwvXN6tWNDAd2axqY46/
	 pFTzuRlkJPWy/c4Gp0QVSh/o00y7K78T05ZGpPs0yzpxZR/iB0gKVvh6/7yQ3EdtoF
	 hdtWm4tjFlzkvelHHAY/sNDo0yA7mqnL6/KVEoqaAsA+3M+hUOKHlY7uJlI97L6nFA
	 Stny1jirD/d9g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 22/37] mm/damon/sysfs: implement cpumask file under sample filter dir
Date: Sun,  7 Dec 2025 22:29:26 -0800
Message-ID: <20251208062943.68824-23-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAON sample filter directory has files for only common properties.
Add a file to further specify the CPUs to filter in or out.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 74594e6e461c..d6b0b6513fd1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -758,6 +758,7 @@ struct damon_sysfs_sample_filter {
 	enum damon_sample_filter_type type;
 	bool matching;
 	bool allow;
+	cpumask_t cpumask;
 };
 
 static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
@@ -765,6 +766,19 @@ static struct damon_sysfs_sample_filter *damon_sysfs_sample_filter_alloc(void)
 	return kzalloc(sizeof(struct damon_sysfs_sample_filter), GFP_KERNEL);
 }
 
+struct damon_sysfs_sample_filter_type_name {
+	enum damon_sample_filter_type type;
+	char *name;
+};
+
+static const struct damon_sysfs_sample_filter_type_name
+damon_sysfs_sample_filter_type_names[] = {
+	{
+		.type = DAMON_FILTER_TYPE_CPUMASK,
+		.name = "cpumask",
+	},
+};
+
 static ssize_t type_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -851,6 +865,29 @@ static ssize_t allow_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t cpumask_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&filter->cpumask));
+}
+
+static ssize_t cpumask_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_sample_filter *filter = container_of(kobj,
+			struct damon_sysfs_sample_filter, kobj);
+	cpumask_t cpumask;
+	int err = cpulist_parse(buf, &cpumask);
+
+	if (err)
+		return err;
+	filter->cpumask = cpumask;
+	return count;
+}
+
 static void damon_sysfs_sample_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_sample_filter *filter = container_of(kobj,
@@ -868,10 +905,14 @@ static struct kobj_attribute damon_sysfs_sample_filter_matching_attr =
 static struct kobj_attribute damon_sysfs_sample_filter_allow_attr =
 		__ATTR_RW_MODE(allow, 0600);
 
+static struct kobj_attribute damon_sysfs_sample_filter_cpumask_attr =
+		__ATTR_RW_MODE(cpumask, 0600);
+
 static struct attribute *damon_sysfs_sample_filter_attrs[] = {
 	&damon_sysfs_sample_filter_type_attr.attr,
 	&damon_sysfs_sample_filter_matching_attr.attr,
 	&damon_sysfs_sample_filter_allow_attr.attr,
+	&damon_sysfs_sample_filter_cpumask_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_sample_filter);
-- 
2.47.3
