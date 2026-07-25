Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD9376A08;
	Sat, 25 Jul 2026 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013359; cv=none; b=L01370FxvFOVXtFdJDExEkoaiLO10+CwF9xhvED594Xt9rEru7sXWSvr+q2jh6gU59D5y97QHbAazc0OQeOE1ldKh5xps7WJUzjFfrh3k/Y3dcn9pxfa3Pa7SNO7QYQok/zbPtgA3uEDlPAbsqKan9rtKz3pRVEhNwGlqU8Zicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013359; c=relaxed/simple;
	bh=J130lxfY4TVWgelPaOr/vEcmN/f4m5KVmzdtov9SUSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/ftfdTWKt+F/w1g5eSH/ApPTih7kNMen7zQp1tzdqsnfXmnOx7dfK7A+xaN1RiH2eW/MiYAfbgptsq6rr2wV+Sc7aOpJXW+fkJ1T36YMa4qc8gyjYEewkXWMS+DYd/Eqot+BzpYtemtRA5DEM9XdqWx4rTsRc8tlv6ptHTIcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMrXA5xj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMrXA5xj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE391F00A3E;
	Sat, 25 Jul 2026 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013357;
	bh=yIpwaE1F4B7icWh20zYavmSeZ7bnIpg0bIGzZcATxDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMrXA5xjIrtPAhMEUTygO8ENTmBP9+IcdtREH0BFtsDYP/NlCF9343zmp9dagdHr3
	 KXs6Pk/7uMf7OaUSueb1ZuwzlYEwxisCpTghF//Sdko+jaFX3OQksE3hW18luXK/rf
	 jkvG5mkCyyo636Bg7qXJoQvB1oeEFWmCmo6R7xuQtOqTAJKfEXK7VAfX9i7hEy4k4V
	 QodqOaQIjf4lxFLd88LhD7tpx4zJC0L71f1Ly3XUUhsXFJ5E3Fq1AKXDGOCTVT9xNt
	 HHubGLyqzS57s8dpuBBgvUwwSevzTWsmv5DATojYLCev9tNyvTI4WtEGmOwtH0ObgY
	 dcelrHvVgPu9g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/17] mm/damon/sysfs: implement preps directory
Date: Sat, 25 Jul 2026 14:02:13 -0700
Message-ID: <20260725210225.129944-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
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
index 376c6ecbd4bf3..7b971bfd1169f 100644
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
+static const struct kobj_type damon_sysfs_preps_ktype = {
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
