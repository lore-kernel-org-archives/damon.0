Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A947D932
	for <damon@lists.linux.dev>; Fri, 14 Aug 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719288; cv=none; b=dYBRjJJe0Zw9AEYZVj+c9BScIIwg1lbZMUEZLXzqmRmt60jhjweQtaUrvg05HpnMPJ7DHK8eXuYRqJUq3nuvd58XgSVgD9fvSnMSy0U7kN1NZBi/VLgB8UmguG4IoOYJ27mlS4OhFlvdpOc+WUusiFyjKvH2jw+8Emapt1o6ZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719288; c=relaxed/simple;
	bh=4W3+BCFF4CNPqHrdkzDCE6XGlQnQVhoBC3aQWIeW2l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmG4K0+rvIQSTsM+jsy75FhJtfxD81USY/1Cp4z4RPCWwqirY+NK1VmeCT6BK/RjRlJc3y5mGawccbjlIwKniRcoCYN0PW9RRgq6BNeWT0ZmnMobhHWH06hO+FOqUb1kN9MhaVMp4VAKeJBiVv48fdvbGNHshW1nQiACbef9/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0ede099897f011f19a56ed5b684f684d-20260814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d1a1be2e-dc37-4716-8c96-0f12715df988,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:d1a1be2e-dc37-4716-8c96-0f12715df988,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:85d6637386c9f1a391c82b250b9c79f5,BulkI
	D:260814225207IKVV92P0,BulkQuantity:1,SF:17|19|38|66|78|102|127|865|898,TC
	:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ede099897f011f19a56ed5b684f684d-20260814
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.210.10)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2099589790; Fri, 14 Aug 2026 22:54:32 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/stat: avoid iterating targets in damon_stat_sort_regions()
Date: Fri, 14 Aug 2026 22:54:09 +0800
Message-ID: <20260814145409.553724-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon/stat module creates only one target in damon_stat_build_ctx(), and
the comment in damon_stat_sort_regions() already says so.  But the code
still iterates adaptive_targets with damon_for_each_target(), which is
needlessly verbose and adds an extra indentation level.

Just use list_first_entry() to grab the single target, with a
list_empty() check to be safe.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/stat.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b05b68f73e10..c8b1e909bbac 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -91,16 +91,15 @@ static int damon_stat_sort_regions(struct damon_ctx *c,
 	unsigned int nr_regions = 0;
 	unsigned long total_sz = 0;
 
-	damon_for_each_target(t, c) {
-		/* there is only one target */
-		region_pointers = kmalloc_objs(*region_pointers,
-					       damon_nr_regions(t));
-		if (!region_pointers)
-			return -ENOMEM;
-		damon_for_each_region(r, t) {
-			region_pointers[nr_regions++] = r;
-			total_sz += r->ar.end - r->ar.start;
-		}
+	if (list_empty(&c->adaptive_targets))
+		return -EINVAL;
+	t = list_first_entry(&c->adaptive_targets, struct damon_target, list);
+	region_pointers = kmalloc_objs(*region_pointers, damon_nr_regions(t));
+	if (!region_pointers)
+		return -ENOMEM;
+	damon_for_each_region(r, t) {
+		region_pointers[nr_regions++] = r;
+		total_sz += r->ar.end - r->ar.start;
 	}
 	sort(region_pointers, nr_regions, sizeof(*region_pointers),
 			damon_stat_cmp_regions, NULL);

base-commit: 6c2cdf00fe5205942b5f29e16905603a1717b931
-- 
2.43.0

