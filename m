Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700475;
	b=tprllfw5frzJf6zzxhdBbKFsZ8/9g+Hl3O331XAgL6SkRA91aGXF4E+V16U5eJ9ZScpw
	 oUOniBldQe2J29c3ZFUUOxgV0seLq6xKF5V6ZKB4gL3RZshoTbRS93zbG0aavym16YiHb
	 lj+zU6qY2nFXJMAwePv1O8qZ8JatT+LsVEqefn0x8g4czar4LSaIgniSbqAjnkb8J3+5q
	 oJKKv3qOFQAMPLjJNKrRNT8AgyVWUQmVnmo5Gbt2RuDdbXgssT6ZYYQaLMAd2uvQpUpVK
	 RQWbdwKzWcAWgdsGE21MrV3dzY7psq4OnM2obcGPrKpxchySymx4ijnCnNz0urcr71Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700475;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SJsmFd97LTwyZ96d6CJJUwteWk3GiFywwWpryyUntpQ=;
	b=MX72zXQFmFRjWIf6IxWI+R2dg99PgNZ5RMPUN2mBCnnN+7M+YRoBsMf4N8YZMvyDRt8M
	 GKZiiTW1In9dT2zzzLzIeYVWjhAG2KO081QEK+36wxp8yj9gG3ThdP50eoxurxdUEVzwg
	 rRjLwLZj/YCGBigiCV5EAfTk8+DoLdy+QV4Wl12CAnxJmVg7CrJ3y6BO+uNpl2B8/sbkg
	 yZdH6CBeOPsxsvaZYizBvusKCFKDGhNXD1i9CWSXRjRRppwGJgu8qvDtS5mRy9d/Ua/M/
	 TPGC2jF7QI5d8vXMwMWqd+8vzF6GlTIyyAX+cXqcJn2cFuGib+PlMJ57xM37L4NMGxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33B606A812
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 10:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED33B606A812
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 654a2600d76e11f19a56ed5b684f684d-20261103
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:65cdc808-a4a7-49c3-92dd-10e53b2f0b2b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:65cdc808-a4a7-49c3-92dd-10e53b2f0b2b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:a56069770302e11e76778d73c0ce566d,BulkI
	D:261103180741YRSD4B2I,BulkQuantity:0,SF:17|19|66|78|102|127|153|850|865|8
	98,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 654a2600d76e11f19a56ed5b684f684d-20261103
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 812115188; Tue, 03 Nov 2026 18:07:37 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lienze@kylinos.cn,
	enze.li@gmx.com
Subject: [PATCH] mm/damon/core: use list_{next,prev}_entry() in damon_{next,prev}_region()
Date: Tue,  3 Nov 2026 18:07:14 +0800
Message-ID: <20261103100714.70742-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_next_region() and damon_prev_region() manually do container_of()
type casting to fetch the next and previous region from the linked
list.  Use the dedicated list.h helpers, list_next_entry() and
list_prev_entry(), as damon_first_region() and damon_last_region() do.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 include/linux/damon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 380f9cf6ddd8..2ba43257e043 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -988,12 +988,12 @@ static inline unsigned long damon_rand(struct damon_ctx *ctx,
 
 static inline struct damon_region *damon_next_region(struct damon_region *r)
 {
-	return container_of(r->list.next, struct damon_region, list);
+	return list_next_entry(r, list);
 }
 
 static inline struct damon_region *damon_prev_region(struct damon_region *r)
 {
-	return container_of(r->list.prev, struct damon_region, list);
+	return list_prev_entry(r, list);
 }
 
 static inline struct damon_region *damon_last_region(struct damon_target *t)

base-commit: 74d73ffcffe03804f97e9fb82301dadf75671282
-- 
2.56.0

