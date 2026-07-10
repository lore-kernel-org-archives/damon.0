Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09933749E5
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783658889; cv=none; b=f9i3pipDMTlR8Ex8Zy2ddBOpGHj3ECPku2hFwIlhGcpMDprJW0vSlIJd19haNJwjVjfa3qOTV34L/0n7dP2aRyC1oEAQZnIAxMVs1k4zc8JvdgeNgNF16OGkuP7wnpOX2STlslPP1GJhYP5NfD1rI2QF1guna/MtzdjbUFBPexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783658889; c=relaxed/simple;
	bh=3UdBQkwUn1pkptl/X3w9sM6Chvgd3Qtzq2HIHXHh4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRQXQmoUCg0BIDNgCrhTC0cV8IOvYB2ZB9QgiMZlz6WQUEdHa054WXxucdHC35uWdx4P2BzFiqwlBhxTzW6V7D9Nv/Ys0/rE9cX0R8CgTtH3BTiMP30l7CGiXOHOgape8l9Ks32bVyynvf8GPQXxd/RmnhyP2EGyvxIX/jq9h+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 888efaa07c1a11f1aa26b74ffac11d73-20260710
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:df2420dc-be79-4755-81c6-07fe9a878936,IP:20,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:df2420dc-be79-4755-81c6-07fe9a878936,IP:20,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:6ab51f0f0179adbd7711d247bca93c74,BulkI
	D:260710124803J08ENMYM,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|136|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 888efaa07c1a11f1aa26b74ffac11d73-20260710
X-User: husong@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2000734830; Fri, 10 Jul 2026 12:48:02 +0800
From: Song Hu <husong@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Song Hu <husong@kylinos.cn>
Subject: [PATCH 4/4] Docs/ABI/damon: document tried_regions probe hits
Date: Fri, 10 Jul 2026 12:47:37 +0800
Message-ID: <20260710044737.561102-5-husong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710044737.561102-1-husong@kylinos.cn>
References: <20260710044737.561102-1-husong@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'tried_regions/<R>/probes/<P>/hits' file, added in commit
5b0de1bc3325 ("mm/damon/sysfs-schemes: implement probe/hits file"),
is described in usage.rst but missing from the canonical ABI document.

Document the 'probes/' directory and the 'probes/<P>/hits' file.

Signed-off-by: Song Hu <husong@kylinos.cn>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 7e8192527191..e8645f987fc3 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -644,3 +644,15 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Reading this file returns the size of the memory in the region
 		that passed DAMON operations layer-handled filters of the
 		scheme in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/probes/
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Directory for DAMON data-attribute monitoring probes of the
+		region.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/probes/<P>/hits
+Date:		May 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Reading this file returns the number of data-attribute
+		monitoring probe-hit positive samples of the region.
-- 
2.43.0

