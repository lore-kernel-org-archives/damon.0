Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282B381AF
	for <damon@lists.linux.dev>; Thu, 14 Aug 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176103; cv=none; b=O5HvwSQRWup4Ov7djSaODLEKiSfza7XDiaFyWYk471qH/odnteqcA7kHAMAoreyHp2BYVBY+RCbIddg7flikKoIHNHk8jmsSNHTmtfJ9Fj8rKTvwzT+7NNuwDKYe0EDa+sjNHthMOeQA4WkgLfZAYsSEGK5cWACt+QNx79wFYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176103; c=relaxed/simple;
	bh=tW0peknyxCTQf+rnMyUaBKSMaCNZTTQAtxaa4A/+KD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQdj5h+fYINbr1b291RNXcFwXGKSMDsW2vm+YYJSTFQAGrgdomZKwztUvP7lRIeCN4Houh8lFP7NAT0i14tG+iLWVBJdYOq9fyu6SUMjiXoTLFw0D19EANpXVPVGu4HUPlwz68gcVNiCVDGl8LVjKzria3TVUksDZcdC65v50Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dc868c10790d11f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	OB_FP, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202508142052+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bb09e0e0-7eae-448c-b7e9-d8971de9dfa2,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:bb09e0e0-7eae-448c-b7e9-d8971de9dfa2,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:bc6ab4738009c0c691e99aff076c3681,BulkI
	D:250814205233GDSRJBYN,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: dc868c10790d11f0b29709d653e92f7d-20250814
X-User: lienze@kylinos.cn
Received: from kylin.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1942505116; Thu, 14 Aug 2025 20:54:48 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] selftests/damon/access_memory_even: remove unused header file
Date: Thu, 14 Aug 2025 20:54:16 +0800
Message-ID: <20250814125417.659937-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the time.h header file is not actually needed in this code, we can
safely remove its inclusion.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 tools/testing/selftests/damon/access_memory_even.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
index a9f4e9aaf3a9..93f3a71bcfd4 100644
--- a/tools/testing/selftests/damon/access_memory_even.c
+++ b/tools/testing/selftests/damon/access_memory_even.c
@@ -9,7 +9,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <time.h>
 
 int main(int argc, char *argv[])
 {

base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
-- 
2.43.0

