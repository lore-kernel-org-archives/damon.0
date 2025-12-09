Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B132FE57C
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291870; cv=none; b=T14RT2jDZEzDqqAIfmQoCjI5CXj52nqPRuLvoUfghxywgADIRAXkxsArxR0dmdguhIubvioYT1BzrfKL+7ISB1N6i1xV9uE9R2YS70Hye4uPc21gJa1skXmTg2H+aNettxn5k/f9AN7oTmu3khJauH6fYiLHg2S74Pt4tm9W/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291870; c=relaxed/simple;
	bh=E6JYr+ho54Jf6GUB73TWIuSAOwv8X8D51cuYFuTV01A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEGHF1XuvVOOTtIszKL1gga0GQQMRs6xy3QnXajdUk1g2Sd7vahMWolY01vljAW6S9Mwqtdc6FJ97XjcDtf77a3JPvY+taOTNAZQRM4F3oKcYmY689gr+1tS6NtNyZdjnugG7f0XiHruoR6Uonq+YDbonAiLy+9pFCwsUS69omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 78ea16bad50e11f0a38c85956e01ac42-20251209
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3c077365-ec3e-4004-be08-8f9088a058de,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:3c077365-ec3e-4004-be08-8f9088a058de,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:4998a732b51ff6292f3d92f16951c3af,BulkI
	D:251209224349XEKF8H49,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:4
	1,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 78ea16bad50e11f0a38c85956e01ac42-20251209
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1716179415; Tue, 09 Dec 2025 22:50:58 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [RFC PATCH 2/2] mm/damon/sysfs: introduce priority sysfs interface
Date: Tue,  9 Dec 2025 22:50:26 +0800
Message-ID: <20251209145026.3263754-3-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209145026.3263754-1-lienze@kylinos.cn>
References: <20251209145026.3263754-1-lienze@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends the DAMON sysfs interface to support the
configuration of target priorities, enabling users to assign and adjust
the relative importance of monitored processes at runtime.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e2bd2d7becdd..224d9e89d967 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -213,6 +213,9 @@ struct damon_sysfs_target {
 	struct damon_sysfs_regions *regions;
 	int pid;
 	bool obsolete;
+#ifdef CONFIG_DAMON_AUTO_TUNING
+	int priority;
+#endif
 };
 
 static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
@@ -298,9 +301,44 @@ static struct kobj_attribute damon_sysfs_target_pid_attr =
 static struct kobj_attribute damon_sysfs_target_obsolete_attr =
 		__ATTR_RW_MODE(obsolete_target, 0600);
 
+#ifdef CONFIG_DAMON_AUTO_TUNING
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
+	int err, value;
+	struct damon_sysfs_target *target = container_of(kobj,
+			struct damon_sysfs_target, kobj);
+	err = kstrtoint(buf, 0, &value);
+	if (err)
+		return -EINVAL;
+
+	if (value > 0 && value <= 100)
+		target->priority = value;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static struct kobj_attribute damon_sysfs_target_priority =
+		__ATTR_RW_MODE(target_priority, 0600);
+#endif
+
 static struct attribute *damon_sysfs_target_attrs[] = {
 	&damon_sysfs_target_pid_attr.attr,
 	&damon_sysfs_target_obsolete_attr.attr,
+#ifdef CONFIG_DAMON_AUTO_TUNING
+	&damon_sysfs_target_priority.attr,
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_target);
@@ -1406,6 +1444,9 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			return -EINVAL;
 	}
 	t->obsolete = sys_target->obsolete;
+#ifdef CONFIG_DAMON_AUTO_TUNING
+	t->priority = sys_target->priority;
+#endif
 	return damon_sysfs_set_regions(t, sys_target->regions, ctx->min_sz_region);
 }
 
-- 
2.43.0

