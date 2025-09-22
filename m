Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CB28A73A
	for <damon@lists.linux.dev>; Mon, 22 Sep 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535852; cv=none; b=EyFYz+jpNqGcZESxlBP0IzATmjiEJrwfUHJToLfO+6bdmPoMEptQ4H468s9OdMeB0cH0WRkp7BKQCggB4hF+iumUt336oPiGMRdpWpg2+2MN7yzJjAqEOYqHAUhVnJrv6ZyHNW8zMKY6XhOvVfvHAMaR+T+Nabf+/0bvNgSFWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535852; c=relaxed/simple;
	bh=ViqvSWlBhLuHijAfZkLqZMriuAaig1reaRL4OvCY3S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6kPwEwC+jvM0NjhFGRjWyd57qkBdD5y9GT2kUjwFe9NVUGvYv0bFDQcP4+c8hv3CWYe17pIufX71UxWKCzP/Mh8CFoN4a+VRq2+awEu6tvvLxw8w6qIyJh0Ip1CBGCovjDedIqVxpcif+fncRxePz4vHCxtdmh6Pe6TEiK19qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 65f05902979c11f08b9f7d2eb6caa7cf-20250922
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5c8a2a3f-503f-44a6-af0f-1a5d4aebc910,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:5c8a2a3f-503f-44a6-af0f-1a5d4aebc910,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:31d7d39b95cce73a5dc3d5d670b85d5f,BulkI
	D:250922154409NPG9RFLE,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|81
	|82|102|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 65f05902979c11f08b9f7d2eb6caa7cf-20250922
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1089521498; Mon, 22 Sep 2025 18:10:42 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [RFC PATCH 2/2] mm/damon/sysfs: add priority support for DAMOS targets
Date: Mon, 22 Sep 2025 18:10:22 +0800
Message-ID: <20250922101022.362822-3-lienze@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922101022.362822-1-lienze@kylinos.cn>
References: <20250922101022.362822-1-lienze@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch extends the DAMON sysfs interface to support the configuration
of target priorities, enabling users to assign and adjust the relative
importance of monitored processes at runtime.  A new sysfs file, priority,
is added under each target’s directory (e.g.,
/sys/kernel/mm/damon/admin/kdamonds/0/contexts/<ctx>/targets/<target>/priority).
Users can write an integer value to this file to set the priority level for
the corresponding target.  Reading the file returns the currently assigned
priority.

The interface integrates seamlessly with the existing priority-based
scheduling mechanism introduced in the core DAMON logic.  When a priority
value is set via sysfs, it directly influences the frequency of scheme
applications for the target.

This enhancement provides user-space administrators and adaptive system
controllers with the ability to dynamically adjust monitoring and memory
management priorities based on real-time workload requirements.  The change
maintains full backward compatibility -- targets without a configured
priority use the default behavior, ensuring no disruption to existing
deployments.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d2b0dab50cb..cd08732f3b6d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -212,6 +212,7 @@ struct damon_sysfs_target {
 	struct kobject kobj;
 	struct damon_sysfs_regions *regions;
 	int pid;
+	int priority;
 };
 
 static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
@@ -271,8 +272,33 @@ static void damon_sysfs_target_release(struct kobject *kobj)
 static struct kobj_attribute damon_sysfs_target_pid_attr =
 		__ATTR_RW_MODE(pid_target, 0600);
 
+static ssize_t target_priority_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+
+	return sysfs_emit(buf, "%d\n", target->priority);
+}
+
+static ssize_t target_priority_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+	int err = kstrtoint(buf, 0, &target->priority);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static struct kobj_attribute damon_sysfs_target_priority =
+		__ATTR_RW_MODE(target_priority, 0600);
+
 static struct attribute *damon_sysfs_target_attrs[] = {
 	&damon_sysfs_target_pid_attr.attr,
+	&damon_sysfs_target_priority.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_target);
@@ -1340,6 +1366,8 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			/* caller will destroy targets */
 			return -EINVAL;
 	}
+	t->priority = sys_target->priority;
+
 	return damon_sysfs_set_regions(t, sys_target->regions);
 }
 
-- 
2.51.0

