Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278371B3925
	for <damon@lists.linux.dev>; Tue,  2 Dec 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764641673; cv=none; b=LM5rK5mGdy1UmAE3oOMaoY1On0R0wSyxUMq22PM0/JOGAbjBFJRXXUkhv3Pdts6QloLPzfGDOdInSJj5C9MAfzmbK3dCjNvcdScX+fFaPoKLhb2+kC8bgzN5N9OL+E6YQdJnb/DwscQ6nYIXBftRiFQMekovNks8NQ3EYJj8FnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764641673; c=relaxed/simple;
	bh=TbKh/W2zSJictkh4oGA4QsazERrDqDoXSf7ak35ywdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bib9orCQtotylqn98m1FxAoTSXqi78x651asRcOW6L5SrRpZTJzBYIqLox01JxcRZW9PkrM6LriOcfP2cBeKiJuLl/mLlqscEv9cNGyKVDcRmAgTQlDrz66Euc5M59vld9V3Jsw36ibB3zrDxfV0gQdMVmC6Ucr9wDbg/C6GHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9dbce656cf2411f0a38c85956e01ac42-20251202
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a9f3be1f-e302-4a7d-b298-b6189dd2f276,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:a9f3be1f-e302-4a7d-b298-b6189dd2f276,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:1c153c2c6cc70ab6555d3353e4b6db72,BulkI
	D:251202100923MMTR89NJ,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9dbce656cf2411f0a38c85956e01ac42-20251202
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1943159812; Tue, 02 Dec 2025 10:14:22 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/core: support multiple damon_call_control requests
Date: Tue,  2 Dec 2025 10:14:07 +0800
Message-ID: <20251202021407.11818-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation only supports repeated calls to a single
damon_call_control request per context.  This limitation introduces
inefficiencies for scenarios that require registering multiple deferred
operations.

This patch modifies the implementation of kdamond_call() to support
repeated calls to multiple damon_call_control requests.  To demonstrate
the effect of this change, I made minor modifications to
samples/damon/prcl.c by adding a new request alongside the original
damon_call_control request and performed comparative tests.

Before applying the patch, I observed,

[  381.661821] damon_sample_prcl: start
[  381.668199] damon_sample_prcl: repeat_call_v2
[  381.668208] damon_sample_prcl: repeat_call
[  381.668211] damon_sample_prcl: wss: 0
[  381.675194] damon_sample_prcl: repeat_call
[  381.675202] damon_sample_prcl: wss: 0

after applying the patch, I saw,

[   61.750723] damon_sample_prcl: start
[   61.757104] damon_sample_prcl: repeat_call_v2
[   61.757106] damon_sample_prcl: repeat_call
[   61.757107] damon_sample_prcl: wss: 0
[   61.763067] damon_sample_prcl: repeat_call_v2
[   61.763069] damon_sample_prcl: repeat_call
[   61.763070] damon_sample_prcl: wss: 0

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 109b050c795a..66b5bae44f22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2526,13 +2526,19 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 			list_add(&control->list, &repeat_controls);
 		}
 	}
-	control = list_first_entry_or_null(&repeat_controls,
-			struct damon_call_control, list);
-	if (!control || cancel)
-		return;
-	mutex_lock(&ctx->call_controls_lock);
-	list_add_tail(&control->list, &ctx->call_controls);
-	mutex_unlock(&ctx->call_controls_lock);
+	while (true) {
+		control = list_first_entry_or_null(&repeat_controls,
+				struct damon_call_control, list);
+		if (!control)
+			break;
+		/* Unlink from the repeate_controls list. */
+		list_del(&control->list);
+		if (cancel)
+			continue;
+		mutex_lock(&ctx->call_controls_lock);
+		list_add(&control->list, &ctx->call_controls);
+		mutex_unlock(&ctx->call_controls_lock);
+	}
 }
 
 /* Returns negative error code if it's not activated but should return */

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.52.0

