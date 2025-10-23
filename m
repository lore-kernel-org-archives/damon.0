Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063881E3DDB;
	Thu, 23 Oct 2025 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182742; cv=none; b=M+jg15AT17ywvl9F1DoD8PMF5Xhz3njLoJlgpUt+xL3iFEmSqKl1IKBPwbtt7dqnF1Sj3H77NQsdJkuv8D4fsOCWB0Gy6rP9nl2AuqSMYEEMN7FkVc+THwEkFBs3TNzZ8O//QXHPduJa+Mrh3/QrNh6y7Bei3Js6UO+Xs2qFpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182742; c=relaxed/simple;
	bh=oyDZN9oCVEaeb/3UXPzhIKvg1TDMd2tTbJ81AbOf+E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUqOQVE7pngNVtgIGBvz9/HNwuSOFN1a1o1lV+uSsfaaZh06GicSZFUukwqHxMFUkWbdsyGmhtTYnBPIRzzI0TGt8ukVHN4VVUOx8NV4pr84pS1ukSxqijW/OTC27Pao+eeuPKOkbrne/4waZ41+CGD0NOaIEZvJT92XBENEZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiqf8kaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiqf8kaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDABC4CEFF;
	Thu, 23 Oct 2025 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182741;
	bh=oyDZN9oCVEaeb/3UXPzhIKvg1TDMd2tTbJ81AbOf+E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiqf8kaMA6/9WJy1wPmi1bMps3cEPFsKyAgqTYZtSH9LZaIsFeuSE+PsB7I/2yRzM
	 Ofhu7Edk3uQjgYLqGHd/BpkpGL5fRqXQLb5EwOiLp95Tk+W6wV7UD+F3bEfiazBpRi
	 /aN1+5J6pFnC4cQ6mAQG0COQacc+raCK0J6MtaXacibc/RPZUf3XlDitDADNzvNPUL
	 I8W0HIkAdboT4LIxSd9GbHbr9LzfP280XIzy5dCUDAWAb78TU5k7wMianWWtAVSUXt
	 pB3qyNyvR5OtOu0Xy3JUPXK9Tv2cxVUW79Bi6O+v41+bAM8+jfljm0OhJP3Les/Rx7
	 zfSk7fUZ/69CA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/9] mm/damon/sysfs: implement obsolete_target file
Date: Wed, 22 Oct 2025 18:25:27 -0700
Message-ID: <20251023012535.69625-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no good way to remove DAMON targets in the middle of the
existing targets list.  It restricts efficient and flexible DAMON use
cases.  Improve the usability by implementing a new DAMON sysfs
interface file, namely obsolete_target, under each target directory.  It
is connected to the obsolete field of parameters commit-source targets,
so allows removing arbitrary targets in the middle of existing targets
list.

Note that the sysfs files are not automatically updated.  For example,
let's suppose there are three targets in the running context, and a user
removes the third target using this feature.  If the user writes
'commit' to the kdamond 'state' file again, DAMON sysfs interface will
again try to remove the third target.  But because there is no matching
target in the running context, the commit will fail.  It is the user's
responsibility to understand resulting DAMON internal targets list
change, and construct sysfs files (using nr_targets and other sysfs
files) to correctly represent it.

Also note that this is arguably an improvement rather than a fix of
broken things.

Reported-by: Bijan Tabatabai <bijan311@gmail.com>
Closes: https://github.com/damonitor/damo/issues/36
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
---
 mm/damon/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0fe6ea68d311..43ee9ce4dd84 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -212,6 +212,7 @@ struct damon_sysfs_target {
 	struct kobject kobj;
 	struct damon_sysfs_regions *regions;
 	int pid;
+	bool obsolete;
 };
 
 static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
@@ -263,6 +264,29 @@ static ssize_t pid_target_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t obsolete_target_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+
+	return sysfs_emit(buf, "%c\n", target->obsolete ? 'Y' : 'N');
+}
+
+static ssize_t obsolete_target_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+	bool obsolete;
+	int err = kstrtobool(buf, &obsolete);
+
+	if (err)
+		return err;
+	target->obsolete = obsolete;
+	return count;
+}
+
 static void damon_sysfs_target_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_target, kobj));
@@ -271,8 +295,12 @@ static void damon_sysfs_target_release(struct kobject *kobj)
 static struct kobj_attribute damon_sysfs_target_pid_attr =
 		__ATTR_RW_MODE(pid_target, 0600);
 
+static struct kobj_attribute damon_sysfs_target_obsolete_attr =
+		__ATTR_RW_MODE(obsolete_target, 0600);
+
 static struct attribute *damon_sysfs_target_attrs[] = {
 	&damon_sysfs_target_pid_attr.attr,
+	&damon_sysfs_target_obsolete_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_target);
@@ -1377,6 +1405,7 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			/* caller will destroy targets */
 			return -EINVAL;
 	}
+	t->obsolete = sys_target->obsolete;
 	return damon_sysfs_set_regions(t, sys_target->regions, ctx->min_sz_region);
 }
 
-- 
2.47.3
