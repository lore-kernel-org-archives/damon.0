Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4D3CF207
	for <damon@lists.linux.dev>; Thu, 16 Jul 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193342; cv=none; b=mW1QrXo/ad/yvqw/RXNFjS+4MianaCl387vkEn8pNdyIYm3pve5E1ZcTjhma6XWHmPDHy/iyPUbp83TeU8YlTalSaEcMBtVEeTvpNyKauqI+LYDlRaRwAMZjea4g4E1RCKQ4tTktavkTEI9U75tMqBzJrgdLtqQMpEHhbt9JClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193342; c=relaxed/simple;
	bh=Ny2D+377nl+2OvzrLbRdgkgvRLewBJ97t0WLyRK4KCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAdsFu2h7S9s2AX8gnh7vPkFJj6+LAMZy9tGkZCk2fDY9lbgIgFgRlZ/HPrvXcWvqZY4yTmdc8yG1Oc5TCgzirrniCiXiHfjljFtP8giurIQIOscVSCPE4b5ucQIgL7JerhtFi55gcrSATtfELeIM3wKjxszPbATxpx7G0oiePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e4df958680f611f1aa26b74ffac11d73-20260716
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f89e710d-fe40-4e3f-9388-ce2bb05d1147,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:f89e710d-fe40-4e3f-9388-ce2bb05d1147,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:ee01cacb6305821de2aff38909daa32f,BulkI
	D:260716171532A3UCPN8Q,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e4df958680f611f1aa26b74ffac11d73-20260716
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1130411518; Thu, 16 Jul 2026 17:15:31 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	lienze@kylinos.cn,
	enze.li@gmx.com
Subject: [PATCH] samples/damon/prcl: add module parameter description for target_pid
Date: Thu, 16 Jul 2026 17:14:44 +0800
Message-ID: <20260716091444.284702-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document 'target_pid' via MODULE_PARM_DESC so its meaning is visible
through kernel command line usage and sysfs interface.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 samples/damon/prcl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 842099bd6228..2592fc53e9d7 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -18,6 +18,7 @@
 
 static int target_pid __read_mostly;
 module_param(target_pid, int, 0600);
+MODULE_PARM_DESC(target_pid, "Target PID of monitored process");
 
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp);
-- 
2.54.0

