Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA94430
	for <damon@lists.linux.dev>; Wed, 21 May 2025 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811312; cv=none; b=JsubtZIx+vwcno78bNmqrq9KqOAvKhdohL8ngHPLH2s1yDP/ys7xVGZ6xaFB380Z5vZsKgKZamACTDZ3pi9gQPqchOAE5hrkgxjqMTZc4h0MMIkfQ5SWWrkp/ocIDbGcs8aNFawVhuWb/owIG9002O8hWI+szB5Yl8dhhGg4bIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811312; c=relaxed/simple;
	bh=bPA4/QJUU17AYsy8kGZu+7rWORTpgbVp4JczGr/VauI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eakeLkfxtvsGCQsrM30SBTXnFj05ESPumFmg+DGKV1RO+Mk1pWbjmMfqXs0POWMnsFHok7hM4ERk5HwQCn1a6QL2rdtV5B5YJEDE7olmtenvdTn1vmSv4aIP0J+EZnZt8pKQef66Ik91x8jCsGsDJjkWMVI5lY4Ya2dozC2xJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f7f0834361211f0b29709d653e92f7d-20250521
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8611437b-d10b-471a-962e-b360074be269,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:8611437b-d10b-471a-962e-b360074be269,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:503941006b8da8118754c24f8566eab4,BulkI
	D:2505211505012SFIG77S,BulkQuantity:1,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5f7f0834361211f0b29709d653e92f7d-20250521
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 712346014; Wed, 21 May 2025 15:08:18 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	lienze@kylinos.cn
Subject: [PATCH] mm/damon: make region calculations more precise
Date: Wed, 21 May 2025 15:07:47 +0800
Message-ID: <20250521070747.1458270-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_sz_region() function misses counting one element when
calculating region size, which leads to inaccurate results.  This patch
corrects the size calculation by properly accounting for all elements.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 include/linux/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 47e36e6ea203..70473863f7fe 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -808,7 +808,7 @@ static inline struct damon_region *damon_first_region(struct damon_target *t)
 
 static inline unsigned long damon_sz_region(struct damon_region *r)
 {
-	return r->ar.end - r->ar.start;
+	return r->ar.end - r->ar.start + 1;
 }
 
 

base-commit: 4a95bc121ccdaee04c4d72f84dbfa6b880a514b6
-- 
2.43.0

