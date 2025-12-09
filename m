Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5E27467E
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765259865; cv=none; b=Eqzv2HkFq5xN8pWqLEkTPdWr4yemLArR8voDKuNYWN3lwfLSvPqzoLiGm5ktPEC4mNwCpdY4x/AowykvkCfZC9DKt+W4tWAMBNA82+kqGwSD8NxmzrMjBU3HHvWEDi64/2+IyT+8SZWeM1cqefJqaBzAfiE3aCa/qHZkq5L+Fj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765259865; c=relaxed/simple;
	bh=eFzCioR7AQSxZ8/LLiZpOsDJAmNsvrPdnAQQVGIfAKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWZ4WxQjscBT2mtVF9dALrUb8KdYhrfsShrTeMMTnNmQWRS1e41z5N3K+HeTP2UJ5ptefISpbL6CnJLHvHWcQr2DI7dJJismA1kXgsxm8omc+QSNqziL20au/y2Tu43rSyj5vgEq7CGfDS8tEJW0DjsEsdkvvn5Qx2UX8GjQCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f00bc2c0d4c311f0a38c85956e01ac42-20251209
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
X-CID-O-INFO: VERSION:1.3.6,REQID:a4ee5210-558a-4a02-850b-aae16ec0cb53,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:a4ee5210-558a-4a02-850b-aae16ec0cb53,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:e41193994fc12412c7bb15a61e65599b,BulkI
	D:251209135728SMWVWXEJ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f00bc2c0d4c311f0a38c85956e01ac42-20251209
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 902813503; Tue, 09 Dec 2025 13:57:25 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/core: delete damon_target when detected invalid
Date: Tue,  9 Dec 2025 13:57:13 +0800
Message-ID: <20251209055713.270737-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, DAMON does not proactively clean up invalid monitoring
targets during its runtime.  When some monitored targets exit, DAMON
still makes the following unnecessary function calls,

  --damon_for_each_target--
  --damon_for_each_region--
      damon_do_apply_schemes
        damos_apply_scheme
          damon_va_apply_scheme
            damos_madvise
              damon_get_mm

and it is only in the damon_get_mm() that it may finally discover that
the monitoring target no longer exists.

To avoid wasting CPU resources, this patch modifies the
kdamond_need_stop() logic to proactively clean up monitoring targets
when they are found to be invalid.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9fc0375890a..eb5612bfd6bf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2462,7 +2462,8 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
  */
 static bool kdamond_need_stop(struct damon_ctx *ctx)
 {
-	struct damon_target *t;
+	struct damon_target *t, *next;
+	bool valid_target_exist = false;
 
 	if (kthread_should_stop())
 		return true;
@@ -2470,11 +2471,16 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	if (!ctx->ops.target_valid)
 		return false;
 
-	damon_for_each_target(t, ctx) {
+	damon_for_each_target_safe(t, next, ctx) {
 		if (ctx->ops.target_valid(t))
-			return false;
+			valid_target_exist = true;
+		else
+			damon_destroy_target(t, ctx);
 	}
 
+	if (valid_target_exist)
+		return false;
+
 	return true;
 }
 
-- 
2.52.0

