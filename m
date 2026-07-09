Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F1428474;
	Thu,  9 Jul 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605970; cv=none; b=VCulu0sNHDXXx+XjzbsdKP7OWvEmYR9sShYr7gcM8iIuRQLopsoKiCvMTtEvf+PgyuYLVYmsEPFKHRFHNRJhqCqXdd9ekEDt3DqRXxUdw0kgQxPdJiEo88l80cg8w4hVJDgd69tIC44mDCIG+OTtlU2t2jb4xFAHta+CpA5flWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605970; c=relaxed/simple;
	bh=1qK22Wmyg+VPePlHBItbL0HDLucjvkb0yd+RYmjadoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPZRQFa1b13IJBZuelO0E/I4qUg3Qy11fz/BANDvIhmIoydka1VzJvlm4oYdVooEzDXKCzfzoIkYojT9WwMzEF1vlTrks5XfuW5UmoFGGpMXVq24eNdRfkc55srmNOxie8AwEpCzVqLl3WgpBBIEPKuesCSowCJDfmOxRaibFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL5oqmRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL5oqmRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F511F00ACA;
	Thu,  9 Jul 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605969;
	bh=yJOHjYArtxH1+/qkwlfdh08BuCLZ4ONkiqi8cM2xmzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hL5oqmRF8LzkkynQfdce6wbeYQWSDjpL6UswnKc8fc6G9J/HeoLInPWbIJB9ZikM/
	 ZXDvIJDC/ngOO3yqCFJr+ephAwzS2oy3Cga8BGZZErFkDCzrhS5N1N0DgrBfIjSmOG
	 WYf6KInPrH2uRuWCksJBNd/fTIKDyX6jRU2sTtNr0wgjPiSRDEOepGRmm+1eNL+ZB0
	 a12wi/QRvOGNUtAu+SXzH5OFuXkNhSWCFPEROU6xn+lj298NTSKDcVPQ6RpUAov7Vl
	 Nm7TWgaHERszU1Z5+6YX2aOoUa8pnb3Gqhxu5lKqpIJgqrYBcXOZzn6M6xhsWHDo6M
	 M9Oa/JMhiKcsA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 16/19] mm/damon/sysfs: implement probe/weight file
Date: Thu,  9 Jul 2026 07:05:54 -0700
Message-ID: <20260709140600.90950-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
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
