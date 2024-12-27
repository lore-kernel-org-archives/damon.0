Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537E1F9EAB;
	Fri, 27 Dec 2024 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333715; cv=none; b=KLiX+183fSusoKL+zL8hdharrPmQ8yYMHpnZ0QrMbzahlc/iyY9Zy76O73QMNZSpgEVaArOxwc2HxhTjeSvS9fKq/jh/Jwuv/Cnm5W9Oc1Z2nzbqKjeP985FcpzVAKrcfmVnT8Qc3832M0yHubpWT0pdr8JCJmZZ/FpfTdO1KUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333715; c=relaxed/simple;
	bh=ZERQXRIpbhEDVEpD6J6LgTdFsTQpbeeZuCqI48fC6sI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rkl2JHtH2tbwxqlVEbCDxcHqpp+eox6gJQE4VYKeuxVgGXI7b9L4+dEjCxHUZ6IK1UTosai4gYkfESXYGdQ8mY6KcVRteUKbnOzUKT9f5CtydIwBvkRww3wQlm6qQKXrbWQKN9cE5oRxXqku8T5rUkfOd/lsVl7wBnxlNXOBR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrLt89ic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrLt89ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437FBC4CEE2;
	Fri, 27 Dec 2024 21:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333713;
	bh=ZERQXRIpbhEDVEpD6J6LgTdFsTQpbeeZuCqI48fC6sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrLt89icA879gSM39Ub/e7HV147OGR4ZXrFChzBzd0p8ILo78pml8/I8T2/zDwh3h
	 HwqflM4E+tOSgKiITbK/KpcoVrSaMURpRrKuUmmWrQYnL2tJ/UMRl21g8UZTJqEUMW
	 u7/nRtrszEUkMjtWvMdxfLJNF96VeKKSqf7HLnDsmy79/C1QW6aGuOm19deAEEtY8r
	 ZGSEt0Y0nqoSmj8QkS4XXzEUFf7ASUGCU9U0fp/5eSSd2JkMpfblFkMNE3Xa/SOU/C
	 BVMNdxZus9nHeBjJpwZwK/p8HVVhNyPoUtgdRo0wOK6rChQGvh7k78/frABWDndXxx
	 +ZHav/02/UuQA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/10] mm/damon/sysfs-schemes: add a file for setting damos_filter->pass
Date: Fri, 27 Dec 2024 13:08:15 -0800
Message-Id: <20241227210819.63776-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only kernel-space DAMON API users can use inclusive DAMOS filters.  Add
a sysfs file named 'pass' under DAMOS filter directory of DAMON sysfs
interface, to let the user-space users use inclusive DAMOS filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9a883e8aea1c..9e171046ee94 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -313,6 +313,7 @@ struct damon_sysfs_scheme_filter {
 	struct kobject kobj;
 	enum damos_filter_type type;
 	bool matching;
+	bool pass;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
 	int target_idx;
@@ -385,6 +386,30 @@ static ssize_t matching_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t pass_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->pass ? 'Y' : 'N');
+}
+
+static ssize_t pass_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	bool pass;
+	int err = kstrtobool(buf, &pass);
+
+	if (err)
+		return err;
+
+	filter->pass = pass;
+	return count;
+}
+
 static ssize_t memcg_path_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -482,6 +507,9 @@ static struct kobj_attribute damon_sysfs_scheme_filter_type_attr =
 static struct kobj_attribute damon_sysfs_scheme_filter_matching_attr =
 		__ATTR_RW_MODE(matching, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_filter_pass_attr =
+		__ATTR_RW_MODE(pass, 0600);
+
 static struct kobj_attribute damon_sysfs_scheme_filter_memcg_path_attr =
 		__ATTR_RW_MODE(memcg_path, 0600);
 
@@ -497,6 +525,7 @@ static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
 static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_type_attr.attr,
 	&damon_sysfs_scheme_filter_matching_attr.attr,
+	&damon_sysfs_scheme_filter_pass_attr.attr,
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
 	&damon_sysfs_scheme_filter_addr_start_attr.attr,
 	&damon_sysfs_scheme_filter_addr_end_attr.attr,
@@ -1901,7 +1930,8 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			sysfs_filters->filters_arr[i];
 		struct damos_filter *filter =
 			damos_new_filter(sysfs_filter->type,
-					sysfs_filter->matching, false);
+					sysfs_filter->matching,
+					sysfs_filter->pass);
 		int err;
 
 		if (!filter)
-- 
2.39.5
