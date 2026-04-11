Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764663B9DA2;
	Sat, 11 Apr 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926168; cv=none; b=YswI/mMMpmrGcJcVEyyvXiebuotL8pXSuqtwqWJ1Ye0entLJkA4XJs7+7vZKEzh3q/lLMRtIOCbty+RR73OIfu53MLmBbJokOe9KQzTeG0q3vUolEveSFVfJDohTG87lYOYLv78cAI+s8ZuD8GY1yGGEdmJb615XRuRFjeTzBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926168; c=relaxed/simple;
	bh=sGB3rlU6Wo00dN98XUbINMBktp7aAzb0KnYDPk0v+Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWCoNYd2RQdADMahFhqOjjS+t84mDpIffeCJyiIhIMqoRo/+3Rbiid0cPnDql3KXdD9ZzgMX1xA1CdE6KueV+kiTkLNphTarCq3mgyhIwVSLMzqrRiZ6VvXoQSrmYWl4LmBgFMrTnTfRLa6ccbe8tdX78eaSzcCPs0a4YrdILZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao04Vg1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao04Vg1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D379CC2BC87;
	Sat, 11 Apr 2026 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775926168;
	bh=sGB3rlU6Wo00dN98XUbINMBktp7aAzb0KnYDPk0v+Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ao04Vg1pC2h7ahiOQjT5272QwRmCO58ckfIBxt4p7h35inI0qqSWlB/FHLkp6VLWJ
	 HqqbbOCVpzEKB8VyRFCoEm2DLqVcD8jgSsfit3YEpuQBJKHtTQuXDIwlvCSYlvBIq3
	 V76NJZqFhdUQ+fWlO7UaXdHthlZrZldiOkFCDiQqqPygTE8d9i/OUz4rHAgG9VJlOA
	 BoGKU9Uo0cKFi+cZaNBmc8hfLqdMhgGVZOHAsuRg3oQRZDFCd3Kojn8eLWPRuvu+IO
	 qFw0Qog0Hee1XV/buZB9ov2k0KbGRvWVTSwnlE3sFyhBnjbloxwXX9yglwjaT4P32c
	 fDI1dvk1SBo7g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.1 04/11] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
Date: Sat, 11 Apr 2026 09:48:57 -0700
Message-ID: <20260411164908.77189-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-1-sj@kernel.org>
References: <20260411164908.77189-1-sj@kernel.org>
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
index aa08a8f885fb0..edec3566bcd11 100644
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
@@ -2780,6 +2832,8 @@ static struct damos *damon_sysfs_mk_scheme(
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
