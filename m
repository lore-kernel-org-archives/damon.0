Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C530F940
	for <damon@lists.linux.dev>; Tue, 14 Oct 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431385; cv=none; b=hRGFZY/uRBaOvNRK1jW0ZfE6l2Tp27EUNziQ4xN8Scl9M+jrk6tZqkjAb3qcAi+Qws6ofMy6tSu7/qAboYWjrQbvtGzMiGL2Xd7y+R2WUEiCyMVOVrcAZgKOX2KN1V0h4kVWjgPoPYHldX7oJT28WODl9Sn0fBDQBSRuUtmiHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431385; c=relaxed/simple;
	bh=TjcV/vwstQ7TryFhIqQEmlRKq8qYDWvBWM0h7AZZ/tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3ojy7TkbWWZ/Y1s69SIBFQPAUPjRoTzepvE/JNlCHQDPHgE/+l9mkFTKlWkBAZDxLPmPs1I+AyLo1ylFG75UVdbo4/BeYp1fYeCfQKZZvlW2bfsk1CldHC7JcY+gsbU72KyqUZUA2QtKXlBWM5oCGi1rwcCI+HlfuKZOJKCE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c283b6e8a8d911f0a38c85956e01ac42-20251014
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:598fe906-9c18-4ad6-8aa2-4af1c8eaaea6,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-INFO: VERSION:1.3.6,REQID:598fe906-9c18-4ad6-8aa2-4af1c8eaaea6,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:45d320bac237e45ad2aa7e2e56a0f0d9,BulkI
	D:2510141640177430877O,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|10
	2|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c283b6e8a8d911f0a38c85956e01ac42-20251014
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2001799193; Tue, 14 Oct 2025 16:42:47 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] mm/damon/core: fix potential memory leak by cleaning ops_filter in damon_destroy_scheme
Date: Tue, 14 Oct 2025 16:42:25 +0800
Message-ID: <20251014084225.313313-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, damon_destroy_scheme() only cleans up the filter list but
leaves ops_filter untouched, which could lead to memory leaks when
a scheme is destroyed.

This patch ensures both filter and ops_filter are properly freed in
damon_destroy_scheme(), preventing potential memory leaks.

Fixes: ab82e57981d0 ("mm/damon/core: introduce damos->ops_filters")
Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 93848b4c6944..3e2c743e0864 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -452,6 +452,9 @@ void damon_destroy_scheme(struct damos *s)
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 
+	damos_for_each_ops_filter_safe(f, next, s)
+		damos_destroy_filter(f);
+
 	kfree(s->migrate_dests.node_id_arr);
 	kfree(s->migrate_dests.weight_arr);
 	damon_del_scheme(s);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0

