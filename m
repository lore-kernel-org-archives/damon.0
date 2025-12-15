Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65041346E72
	for <damon@lists.linux.dev>; Mon, 15 Dec 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808522; cv=none; b=Rl0cmMeaQ/rpQ98rMH3tmbnisM/4EwlcPZE04LcxH0HPW+1MmvtcPfXkB67TG9nM+p5BRaq+/nu3mHiw1RqguHs7WUYuucWsEovVG/rlUxgDtZrra92e7zlEGvSYuoi7IMx6MKlck6/KIZi6E1SiiZHaCb6DlP7ZNCi2dFGRsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808522; c=relaxed/simple;
	bh=X06HkMeFnHhefSMq3DKbFXnHboiHbYAmjVtPeR5Hy+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+jm104dKMQoV6YWTITWDfwK9BJUY/skwpmQgDRxkTKjOOFU81OLrvtjiqMw4o1p5nvDRcrWK+Nj4qd2zKmL/cECAELPQLYgIrNwu6TUOnouuZDlHk6cjloefbry4F1vA8iu9OwqYY60DMU3tH8SQcn/qbbrk8Efeo3S+YuQNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 67006cbcd9c111f0a38c85956e01ac42-20251215
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a159553b-53a4-4e5b-bd6e-11bb762e76f6,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:a159553b-53a4-4e5b-bd6e-11bb762e76f6,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:3f795d0f366ff774f0650dac6b0e463c,BulkI
	D:251215222154C0FZ39VJ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 67006cbcd9c111f0a38c85956e01ac42-20251215
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1269189267; Mon, 15 Dec 2025 22:21:52 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH 1/2] mm/damon/core: export necessary symbols
Date: Mon, 15 Dec 2025 22:20:56 +0800
Message-ID: <20251215142057.588500-2-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215142057.588500-1-lienze@kylinos.cn>
References: <20251215142057.588500-1-lienze@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exports necessary DAMON core symbols to allow building
loadable kernel modules that leverage DAMON's monitoring capabilities
for advanced memory management techniques, such as proactive
reclamation.

The exported functions include those for context creation/destruction,
target and scheme management, and monitoring control.  This enables
external modules to create dedicated DAMON contexts and targets,
operation schemes, and control the monitoring lifecycle without
requiring direct modifications to the core DAMON subsystem.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9fc0375890a..b3f6b36a034d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -108,6 +108,7 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(damon_select_ops);
 
 /*
  * Construct a damon_region struct
@@ -409,6 +410,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 
 	return scheme;
 }
+EXPORT_SYMBOL_GPL(damon_new_scheme);
 
 static void damos_set_next_apply_sis(struct damos *s, struct damon_ctx *ctx)
 {
@@ -478,11 +480,13 @@ struct damon_target *damon_new_target(void)
 
 	return t;
 }
+EXPORT_SYMBOL_GPL(damon_new_target);
 
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 {
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
+EXPORT_SYMBOL_GPL(damon_add_target);
 
 bool damon_targets_empty(struct damon_ctx *ctx)
 {
@@ -553,6 +557,7 @@ struct damon_ctx *damon_new_ctx(void)
 
 	return ctx;
 }
+EXPORT_SYMBOL_GPL(damon_new_ctx);
 
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
@@ -573,6 +578,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 
 	kfree(ctx);
 }
+EXPORT_SYMBOL_GPL(damon_destroy_ctx);
 
 static bool damon_attrs_equals(const struct damon_attrs *attrs1,
 		const struct damon_attrs *attrs2)
@@ -763,6 +769,7 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 	for (i = 0; i < nr_schemes; i++)
 		damon_add_scheme(ctx, schemes[i]);
 }
+EXPORT_SYMBOL_GPL(damon_set_schemes);
 
 static struct damos_quota_goal *damos_nth_quota_goal(
 		int n, struct damos_quota *q)
@@ -1371,6 +1378,7 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(damon_start);
 
 /*
  * __damon_stop() - Stops monitoring of a given context.
@@ -1414,6 +1422,7 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	}
 	return err;
 }
+EXPORT_SYMBOL_GPL(damon_stop);
 
 /**
  * damon_is_running() - Returns if a given DAMON context is running.
@@ -2924,6 +2933,7 @@ bool damon_initialized(void)
 {
 	return damon_region_cache != NULL;
 }
+EXPORT_SYMBOL_GPL(damon_initialized);
 
 static int __init damon_init(void)
 {
-- 
2.43.0

