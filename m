Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787363F9F50
	for <damon@lists.linux.dev>; Wed, 15 Jul 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107629; cv=none; b=aGXIxSJoJZxGTRimPSRpnXNae6aCkHic+txkRJyoY5QFE/xOS6Wn55N3LuZp7n8gcYptyuVldZgPNkYp0tdmZvamL7aPtemy0UYLsr0+3/lzNiaL6RTVcn+qEepAnGWYO0suc7UAzYI4asdXbjWtIZuLMs4IqhycxlADWhX/mH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107629; c=relaxed/simple;
	bh=l33jC3EdCqDNqIxyeHfLuxLKm14arJFL/BXEel8tYS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSE4OsBdPzZY4xRUnRkYHRjoUOlvYHHDHoaJDUlyIiJ9nQXlYVX3//3n7du5T+IWeXircwNGVeXNgs2oEav1QKeYAONBeWe9Q1gELIpTGJOBt4oCw/B7bq5UXkBpYbx67aJ0zHwnz1JPGMgk97MnuvET9e9L3I3YkHGF7afRKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 536265b0802f11f1aa26b74ffac11d73-20260715
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0244c0a7-664b-49e0-9c8d-8b15c88ea586,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:0244c0a7-664b-49e0-9c8d-8b15c88ea586,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:202a7087583be5d5c56ce914c9e11c12,BulkI
	D:2607151727009LO51T1T,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|136
	|865|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 536265b0802f11f1aa26b74ffac11d73-20260715
X-User: husong@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 938891429; Wed, 15 Jul 2026 17:26:57 +0800
From: Song Hu <husong@kylinos.cn>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Song Hu <husong@kylinos.cn>
Subject: [PATCH] damon: update outdated comment about DAMOS filter handling
Date: Wed, 15 Jul 2026 17:26:34 +0800
Message-ID: <20260715092634.1450702-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment above enum damos_filter_type states that only the
anon and memcg type filters are handled by damon_operations (and therefore
accounted as 'tried'), and that DAMON_OPS_VADDR and DAMON_OPS_FVADDR do
not support those two filter types.

Neither is accurate anymore.  damos_filter_for_ops() routes every filter
type except ADDR and TARGET to the operations layer, and the VADDR and
FVADDR operations (the latter being a copy of the former) handle all of
those types through damos_folio_filter_match() / damos_va_filter_out().
Update the comment to match the code.

Signed-off-by: Song Hu <husong@kylinos.cn>
---
 include/linux/damon.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f69442a9d431..d1bb3490792a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -392,16 +392,15 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
- * The anon pages type and memcg type filters are handled by underlying
- * &struct damon_operations as a part of scheme action trying, and therefore
- * accounted as 'tried'.  In contrast, other types are handled by core layer
- * before trying of the action and therefore not accounted as 'tried'.
+ * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
+ * are handled by the underlying &struct damon_operations as a part of scheme
+ * action trying, and therefore accounted as 'tried'.  In contrast,
+ * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are handled
+ * by the core layer before trying of the action, and therefore not accounted
+ * as 'tried'.
  *
- * The support of the filters that handled by &struct damon_operations depend
- * on the running &struct damon_operations.
- * &enum DAMON_OPS_PADDR supports both anon pages type and memcg type filters,
- * while &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR don't support any of
- * the two types.
+ * Support for the operations-handled filters depends on the running
+ * &struct damon_operations.
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
-- 
2.43.0

