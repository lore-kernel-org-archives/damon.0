Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E343D810F;
	Sun, 26 Jul 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087589; cv=none; b=A/qSkTKdTf2Wa79xJg3VcZ8jg+vh1X3n21JK72o3Qfa5aGBGT6tOZIL/IT+mM/xcsI+H1OvYcXYOVFpd6d8q5YcQ5Jdl7PLV8TJg3y7nXhfQb1EzkTK3LpgejqJab28RfsVoYEwm3xpFdi1TtUb9IktW0N2CwXxywi+Qn1pJgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087589; c=relaxed/simple;
	bh=t7XpFLkd2aQrtwGB7HTk+0WmyiyRdKbQh4ojC5sDIh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIte9da7jV0fMDjo+vMUpeICdQkFpc0eC2E4AlGNniPX6PL5E/laV7Axkabbmp53vwk32h91QwwRuHf8YCC3YWpKcMLnXmaD5e9eLfar4VFThDVmRDWfw1D732y50YKGYd0zpilRehRtg5TGwZV2ZjgL2cSWIUNluWEr7ngVu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWzwtaD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWzwtaD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4405B1F00A3A;
	Sun, 26 Jul 2026 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087587;
	bh=FZqsFhVwCQ90V1mw7pN7W1WQWqn45B9+8ZoH6zkUunU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FWzwtaD8K5T3PuAtKXT+W3KgcdnBe+NnyadfyoD71hdZgbFt3Lcuce0G/9reZAqCj
	 VIZIhxDyVNRIkxe2EguG7u08Ur0DoCGiuEigYxcNHUgVlIJPsiBz//9bKs17zxS3ml
	 EJFYpcyPFglNNPf/QLi9LDC5EBNNrepqAMzImdRf9uh9ejFXDSsLak6SxU/XbMbM/e
	 gqC+93TdhmHX4dCWpS/apGKB5ogyKiFIBOZrwzNK1SlS6hExvgjDXiHI/a2ke8TqKt
	 J8k7QbAmmV0lULlwQgQhL0lDd/t0UwzEa3VRy5WhnivUsykw19eINsMcmP5OCDkvIs
	 cklT/Q6pptYow==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 09/17] mm/damon/sysfs: implement preps directory
Date: Sun, 26 Jul 2026 10:39:25 -0700
Message-ID: <20260726173935.94046-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a sysfs directory and a file under the directory that will be
used for setting DAMON probe preps.  Implement only preparatory data
structures and functions.  The code is not really generating the
directories at the moment.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 376c6ecbd4bf3..0e4d7a50545e1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -750,6 +750,74 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.default_groups = damon_sysfs_intervals_groups,
 };
 
+/*
+ * preps directory
+ */
+
+struct damon_sysfs_preps {
+	struct kobject kobj;
+	int nr;
+};
+
+static int damon_sysfs_preps_add_dirs(struct damon_sysfs_preps *preps,
+		int nr_preps)
+{
+	preps->nr = nr_preps;
+	return 0;
+}
+
+static ssize_t nr_preps_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_preps *preps = container_of(kobj,
+			struct damon_sysfs_preps, kobj);
+
+	return sysfs_emit(buf, "%d\n", preps->nr);
+}
+
+static ssize_t nr_preps_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_preps *preps;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	preps = container_of(kobj, struct damon_sysfs_preps, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_preps_add_dirs(preps, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damon_sysfs_preps_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_preps, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_preps_nr_attr =
+		__ATTR_RW_MODE(nr_preps, 0600);
+
+static struct attribute *damon_sysfs_preps_attrs[] = {
+	&damon_sysfs_preps_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_preps);
+
+const struct kobj_type damon_sysfs_preps_ktype = {
+	.release = damon_sysfs_preps_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_preps_groups,
+};
+
 /*
  * filter directory
  */
-- 
2.47.3
