Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617538F646;
	Sat,  4 Apr 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320794; cv=none; b=jOzmUqEhqunVK0oLxzkZKqtlcbm54W2vZZTvMUF+vBLUQeLXUq6MIrbtnY8+Tubpj7W8iECpBdm0v49ktEhyQbcsRVeLsWQe+VEdDC71N3IAWvVBBGjKePhDjLmEcjiOd5elb5h+IhpIU1cUeAJ79x2fPSBP2/PZrluxgpOcZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320794; c=relaxed/simple;
	bh=F/M9rB5L2tN6LoRT9CXC/JolkzvZc5e3+oNuxF0asr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMpOsBbVQXki3rWeIIa4EJZOBCqjuTj3jTx68e8eNjI1KsIkCgw6mMugphb/bqA4OW2v4fdWsVbKqZiKKLCb2B2qynDiBAt0bLkxmPybgy9wlb4O6xhsTVHU7AMqm64aj8Sn4Oe6CaDSxH4c18bnscuQAD4kCkRH0pM4cm80NjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsHm6Ox+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsHm6Ox+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CACC19424;
	Sat,  4 Apr 2026 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320794;
	bh=F/M9rB5L2tN6LoRT9CXC/JolkzvZc5e3+oNuxF0asr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsHm6Ox+bssIRAHtF44fTbr23jm1N8ZBo820dEmyWtDkK+0cMUyNqApalavJxXgpo
	 lFsQbP6XbDIEWIDqcDn5LVDjrjKjyJLXpEjrygVX//9m/a3JLjIBcxa7y+1LfItrxx
	 kbzF0vOWxEAGkTbEfAja98uNiEnB2mNkDaatyKjAlEsOcJ+xA9u0sKX+nJekGDtsRT
	 jzhU1CfVOocGiGoEKVer1lv9g0uW+miZFHSguzacY3thwviBsZ0S9a7VrWjfdY9qlM
	 BIFZuPh+MSMwqbvSLpcUswM5wTpEFXhmL00N5vsHn4eYn5kK5KlReu9JKkdUQ8h2VB
	 M2Y2mISVIUdIA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/9] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
Date: Sat,  4 Apr 2026 09:39:32 -0700
Message-ID: <20260404163943.89278-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: <20260404163943.89278-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the user-space ABI for the DAMOS action failed region
quota-charge ratio setup.  For this, add two new sysfs files under the
DAMON sysfs interface for DAMOS quotas.  Names of the files are
fail_charge_num and fail_charge_denom, and work for reading and setting
the numerator and denominator of the failed regions charge ratio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5186966dafb35..d5bfba79f105f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1489,6 +1489,8 @@ struct damon_sysfs_quotas {
 	unsigned long reset_interval_ms;
 	unsigned long effective_sz;	/* Effective size quota in bytes */
 	enum damos_quota_goal_tuner goal_tuner;
+	unsigned int fail_charge_num;
+	unsigned int fail_charge_denom;
 };
 
 static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
@@ -1663,6 +1665,48 @@ static ssize_t goal_tuner_store(struct kobject *kobj,
 	return -EINVAL;
 }
 
+static ssize_t fail_charge_num_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%u\n", quotas->fail_charge_num);
+}
+
+static ssize_t fail_charge_num_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtouint(buf, 0, &quotas->fail_charge_num);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t fail_charge_denom_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%u\n", quotas->fail_charge_denom);
+}
+
+static ssize_t fail_charge_denom_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtouint(buf, 0, &quotas->fail_charge_denom);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
 static void damon_sysfs_quotas_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_quotas, kobj));
@@ -1683,12 +1727,20 @@ static struct kobj_attribute damon_sysfs_quotas_effective_bytes_attr =
 static struct kobj_attribute damon_sysfs_quotas_goal_tuner_attr =
 		__ATTR_RW_MODE(goal_tuner, 0600);
 
+static struct kobj_attribute damon_sysfs_quotas_fail_charge_num_attr =
+		__ATTR_RW_MODE(fail_charge_num, 0600);
+
+static struct kobj_attribute damon_sysfs_quotas_fail_charge_denom_attr =
+		__ATTR_RW_MODE(fail_charge_denom, 0600);
+
 static struct attribute *damon_sysfs_quotas_attrs[] = {
 	&damon_sysfs_quotas_ms_attr.attr,
 	&damon_sysfs_quotas_sz_attr.attr,
 	&damon_sysfs_quotas_reset_interval_ms_attr.attr,
 	&damon_sysfs_quotas_effective_bytes_attr.attr,
 	&damon_sysfs_quotas_goal_tuner_attr.attr,
+	&damon_sysfs_quotas_fail_charge_num_attr.attr,
+	&damon_sysfs_quotas_fail_charge_denom_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_quotas);
@@ -2776,6 +2828,8 @@ static struct damos *damon_sysfs_mk_scheme(
 		.weight_nr_accesses = sysfs_weights->nr_accesses,
 		.weight_age = sysfs_weights->age,
 		.goal_tuner = sysfs_quotas->goal_tuner,
+		.fail_charge_num = sysfs_quotas->fail_charge_num,
+		.fail_charge_denom = sysfs_quotas->fail_charge_denom,
 	};
 	struct damos_watermarks wmarks = {
 		.metric = sysfs_wmarks->metric,
-- 
2.47.3
