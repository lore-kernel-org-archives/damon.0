Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49163F210B
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015672; cv=none; b=kY2dqoIstAlOxPCRAchPnrRkEN+pTUgoMW1OadCd3vHHIFb3wBlZ2QB+rqr/ZvMXeR3a8tBHHy3BucC4xvAP0mJTTnvF0DQW3jx+v1qoF6w9zhveP7rdMHo+i5P5AC8UPXbGG0R4REJcpSNWN/zkRYy6A15eQnH3b+n1ZvSJScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015672; c=relaxed/simple;
	bh=0LvpM0JA4UJWzqg59mn5+rR7RxqKvuHmVG8Weatyaac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mq7r9bTd9rmEvL02UANLxHPx69YuYB/fH/q6Nb+3FRxK7pGt8zbGgkoExWACg2HVpgeYAlKi5sGGw1IJCqRJdqCmGJWk5xOoflBqluNgTAXUS30gPODzV/YtDAWNpw97dX1TS7W0tf0Z8V5U8WHt4CWxrZdTVXeNmkq7YEwV5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 386c8df27f5911f1aa26b74ffac11d73-20260714
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:05dbf085-a693-45e8-a0b6-84f55bc50ee6,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:05dbf085-a693-45e8-a0b6-84f55bc50ee6,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:40f5943f7a49aee119523de9c1afc868,BulkI
	D:260714155423MQ7OG88W,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 386c8df27f5911f1aa26b74ffac11d73-20260714
X-User: wangxuewen@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <wangxuewen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1772328423; Tue, 14 Jul 2026 15:54:20 +0800
From: Xuewen Wang <wangxuewen@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xuewen Wang <wangxuewen@kylinos.cn>
Subject: [PATCH v1] mm/damon: remove trailing semicolons after function definitions
Date: Tue, 14 Jul 2026 15:53:58 +0800
Message-Id: <20260714075358.1592393-1-wangxuewen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three function definitions terminate with '};' instead of '}',
which is unnecessary and inconsistent with kernel coding style:

- damon_pa_initcall() in paddr.c
- damon_va_initcall() in vaddr.c
- damos_get_some_mem_psi_total() in core.c

No functional change intended.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
---
 mm/damon/core.c  | 2 +-
 mm/damon/paddr.c | 2 +-
 mm/damon/vaddr.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e4b9affc5b0..4197957009aa 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2579,7 +2579,7 @@ static u64 damos_get_some_mem_psi_total(void)
 static inline u64 damos_get_some_mem_psi_total(void)
 {
 	return 0;
-};
+}
 
 #endif	/* CONFIG_PSI */
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d0598f5f2688..17353b14af77 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -453,6 +453,6 @@ static int __init damon_pa_initcall(void)
 	};
 
 	return damon_register_ops(&ops);
-};
+}
 
 subsys_initcall(damon_pa_initcall);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d27147603564..13f4e05f871b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -983,7 +983,7 @@ static int __init damon_va_initcall(void)
 	if (err)
 		return err;
 	return damon_register_ops(&ops_fvaddr);
-};
+}
 
 subsys_initcall(damon_va_initcall);
 
-- 
2.25.1

