Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E82F6929
	for <damon@lists.linux.dev>; Wed, 10 Dec 2025 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765344352; cv=none; b=pL1b0XkZSNO5lPDcNaKtV/OvYndYfkTpsJfVieBX6EmDMgDcGtUqr9HtdhRen82vH28N6InQL8OUw4t2AphvUrvsgL6T97ov/c1dpN703sWquhEs+Kd48ZqkO06svqEshjmIMLKQZSvWnR8GmqCkaXRF7WSCh6xQuLam7185GAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765344352; c=relaxed/simple;
	bh=KkqDYI5UU/ExorDooDwMuGyYgXXWuleZLPOsNBjwmME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7CK9/yj6DDn+UmyVXNPmrhS9+/fsp7+gDtOETZFwP+rflmvMyFkF4qmQC5SxuF+zjzPJI+Dj1Q+5/PIGTGLc3DcPjb9+Fwopk79evPUrT6T97tZ/RKJxDdp2fNrWoPmGeCWBEo2bZsFthR3uggn5UTs/Q8EuIuyHuL9QwmtIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a67431ead58811f0a38c85956e01ac42-20251210
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3003985e-5f7c-4672-98c6-31e9e248a8cc,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:3003985e-5f7c-4672-98c6-31e9e248a8cc,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:310602fbf03de4f7880188d6a71b941c,BulkI
	D:251210132533GWS883M0,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a67431ead58811f0a38c85956e01ac42-20251210
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1115932276; Wed, 10 Dec 2025 13:25:33 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/core: fix wasteful CPU calls by skipping non-existent targets
Date: Wed, 10 Dec 2025 13:25:08 +0800
Message-ID: <20251210052508.264433-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, DAMON does not proactively clean up invalid monitoring
targets during its runtime.  When some monitored processes exit, DAMON
continues to make the following unnecessary function calls,

  --damon_for_each_target--
  --damon_for_each_region--
      damon_do_apply_schemes
        damos_apply_scheme
          damon_va_apply_scheme
            damos_madvise
              damon_get_mm

it is only in the damon_get_mm() function that it may finally discover
the target no longer exists, which wastes CPU resources. A simple idea
is to check for the existence of monitoring targets within the
kdamond_need_stop() function and promptly clean up non-existent targets.

However, SJ pointed out that this approach is problematic because the
online commit logic incorrectly uses list indices to update the
monitoring state.  This can lead to data loss if the target list is
changed concurrently.  Meanwhile, SJ suggests checking for target
existence at the damon_for_each_target level, and if a target does not
exist, simply skip it and proceed to the next one.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9fc0375890a..e43bdf0b41a8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2266,6 +2266,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 
 	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
+		if (c->ops.target_valid && c->ops.target_valid(t) == false)
+			continue;
+
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
 	}

base-commit: c9b47175e9131118e6f221cc8fb81397d62e7c91
-- 
2.52.0

