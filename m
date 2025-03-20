Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68A1E32B9;
	Thu, 20 Mar 2025 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449186; cv=none; b=nIawjO62qaVZ6BZAe/NdsJZxvLzFv2SI39n0fo65wSagIEfyyJ0NsZaM35SLj1/VvDkPx9hyRo00SIkvltFsxzHbpQtGLYd4KEEkhasKjds71FrdqEKz3n29A4VHjcmPhNEYMT9ImVQimHI3N8fhyTb4lXsNrQpSVJ9TIoGlU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449186; c=relaxed/simple;
	bh=00PQCLtovSAjyu/3Lndfh7V4VIWve/5SxCLnZNKDSzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chYDFKd+TIXuofr5PRJKZfNEb2wS2WhKy8H1N29mHJnXVD5SCVxFHz3j4nXToVyu2BYmRbXcF6T1lpZM+XfFHNKU1d3x24Jb+VUygME9a98RH7qRdVFJ9D1Lr5hHiPwZbVgEwuAHY98LDbb/rhx3dzBK1KmKfW5tbFZ4+qRpCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIw0uP/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIw0uP/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A287C4CEDD;
	Thu, 20 Mar 2025 05:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742449186;
	bh=00PQCLtovSAjyu/3Lndfh7V4VIWve/5SxCLnZNKDSzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIw0uP/fO84iFLnADRPGs235ZTy+7Ert1btRyCCAzUmsM2rr26wGlPrAs5Fq6xwfr
	 pV6RrGnuZtMXEDhldoQaQNo26/o0EY1i/LhBf6seZMXn8hctmfKO6euFwRPrtpwvBv
	 j71/okQQdhFBK2ohC9Fp8lgQwMR45BTp4PljsrzyY5OCRW43MwyTA9a/PSO14RVEs6
	 krR4BM+A0DbqqFdSM3iyagCIWHfhnbWLwIDlCPSWy5k7W6DyLl9b9r/By4IDFrWK49
	 bEczofxfcKczVftWHK4oI4p2t1ptgywoAnFyduYWXPyYBb9nb0Dn2Cec2+np8KMpmt
	 jmZlEKR9feEsg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/sysfs-schemes: implement file for quota goal nid parameter
Date: Wed, 19 Mar 2025 22:39:35 -0700
Message-Id: <20250320053937.57734-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320053937.57734-1-sj@kernel.org>
References: <20250320053937.57734-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only DAMON core kernel API callers can use the DAMOS quota goal metrics
for specific NUMA node's utilization and free ratios.  Implement DAMON
sysfs files to receive the node id for the goals.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0f338ba1db43..8c51906c8268 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -936,6 +936,7 @@ struct damos_sysfs_quota_goal {
 	enum damos_quota_goal_metric metric;
 	unsigned long target_value;
 	unsigned long current_value;
+	int nid;
 };
 
 /* This should match with enum damos_quota_goal_metric */
@@ -1016,6 +1017,28 @@ static ssize_t current_value_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t nid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+
+	/* todo: return error if the goal is not using nid */
+
+	return sysfs_emit(buf, "%d\n", goal->nid);
+}
+
+static ssize_t nid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+	int err = kstrtoint(buf, 0, &goal->nid);
+
+	/* feed callback should check existence of this file and read value */
+	return err ? err : count;
+}
+
 static void damos_sysfs_quota_goal_release(struct kobject *kobj)
 {
 	/* or, notify this release to the feed callback */
@@ -1031,10 +1054,14 @@ static struct kobj_attribute damos_sysfs_quota_goal_target_value_attr =
 static struct kobj_attribute damos_sysfs_quota_goal_current_value_attr =
 		__ATTR_RW_MODE(current_value, 0600);
 
+static struct kobj_attribute damos_sysfs_quota_goal_nid_attr =
+		__ATTR_RW_MODE(nid, 0600);
+
 static struct attribute *damos_sysfs_quota_goal_attrs[] = {
 	&damos_sysfs_quota_goal_target_metric_attr.attr,
 	&damos_sysfs_quota_goal_target_value_attr.attr,
 	&damos_sysfs_quota_goal_current_value_attr.attr,
+	&damos_sysfs_quota_goal_nid_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damos_sysfs_quota_goal);
-- 
2.39.5
