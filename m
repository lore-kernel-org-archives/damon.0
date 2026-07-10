Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD127FB3A;
	Fri, 10 Jul 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691227; cv=none; b=ooX75vc2YuWr7Rk33MJukR8U50scCWBuFE+vsI2c7r/sY5xkEHvx5SAZlZaH5ff/Z/He+ikmUoXG8DL5ZQHwhX+rLJ8aeHn4+Jj/66eKsg5+7noIWI/BmIqsho+QH6dOIIBRzes/vnM3kxbg/laSX91XQyhFAoUwnDDOuiRJDM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691227; c=relaxed/simple;
	bh=1qK22Wmyg+VPePlHBItbL0HDLucjvkb0yd+RYmjadoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdhti/wh2Tkc3puqGQPNqW6uCE7CwynoOcra9/lka0zdRCAfvAxZDROKAWOymKhpldiLbPMvFETYPnVOyhdRj/zQLmRW7sKV3IJAY8pV4i+HwaTh2vSKNk3qrIRvidSIkbeciprT4aV+Z2KV/1WKWnY57N1B5IrOXNNrrO+1Emw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJk5Scv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJk5Scv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4BB1F00A3A;
	Fri, 10 Jul 2026 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691225;
	bh=yJOHjYArtxH1+/qkwlfdh08BuCLZ4ONkiqi8cM2xmzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJk5Scv9CzNpnPdfFDYVeiMuJG6fb1OTCsPDbcrJrCLAVbnOKNEhP8f7WlAsmguc3
	 vtXxF0X1kzcPVOOLVsCcfBY8skt6XdfaN9iVNlcaNzulG4EmUU+z3I4eguPILVCDM+
	 6XJNAn7l2GgFqYlZ44YIHUjYmkoLyCiR3Q8qAywyFxOIa6UoeW8ESkWExeaf3mLRz4
	 c0NPQAFyCZYAiYj0lXSXdkzkoEp/6/2qEmNR4VoZrRTqJHoVHLatp9CQ9Go6Fvkpyx
	 WaRo1RksJrwB2IEL9eicdFbmVggg/PM9OUc8/tYGJZX0g0ahJknd1fgigsOZwu7LIr
	 QRwcv52EWdXWQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 16/19] mm/damon/sysfs: implement probe/weight file
Date: Fri, 10 Jul 2026 06:46:45 -0700
Message-ID: <20260710134651.18084-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new sysfs file, 'weight', under probe directory.  Users will
be able to set the probe weight and enable the attributes only
monitoring using it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d7e36c9e509d..b5fe036f78015 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1065,6 +1065,7 @@ static const struct kobj_type damon_sysfs_filters_ktype = {
 
 struct damon_sysfs_probe {
 	struct kobject kobj;
+	unsigned int weight;
 	struct damon_sysfs_filters *filters;
 };
 
@@ -1100,12 +1101,35 @@ static void damon_sysfs_probe_rm_dirs(struct damon_sysfs_probe *probe)
 	}
 }
 
+static ssize_t weight_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_probe *probe = container_of(kobj,
+			struct damon_sysfs_probe, kobj);
+
+	return sysfs_emit(buf, "%u\n", probe->weight);
+}
+
+static ssize_t weight_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_probe *probe = container_of(kobj,
+			struct damon_sysfs_probe, kobj);
+	int err = kstrtouint(buf, 0, &probe->weight);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_probe_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_probe, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_probe_weight_attr =
+		__ATTR_RW_MODE(weight, 0600);
+
 static struct attribute *damon_sysfs_probe_attrs[] = {
+	&damon_sysfs_probe_weight_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_probe);
@@ -1965,6 +1989,7 @@ static int damon_sysfs_set_probes(struct damon_ctx *ctx,
 			return -ENOMEM;
 		damon_add_probe(ctx, p);
 		sys_probe = sys_probes->probes_arr[i];
+		p->weight = sys_probe->weight;
 		err = damon_sysfs_set_probe(p, sys_probe);
 		if (err)
 			return err;
-- 
2.47.3
