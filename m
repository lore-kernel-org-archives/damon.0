Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22929994B
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783658887; cv=none; b=BoHglz9Z4YeyOXT2z7zi/VvyVJP27tOJ6UbH/ttmxJLRCMpcvtU1KfoJfuNSEmq3XwofpVw2bcyuyLzyI4SxCYe6v6K26YRYsWTHtQVUx+A0/sBo+lp/XWhbIHkjYMB5ZyCrEihv4ae+KjHaY8CB7Ioj8PDfDitG4YSexYtWxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783658887; c=relaxed/simple;
	bh=4M1suvIB5h9ry3pDLqesbSkIMg8qb5JZCnrnT9UknJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6DmFxFpuBnMbGUUEhpU1EiwH6Esrw9/lgpKuLkk1tdy9hjYKjqLz3fzg64LigpiNBVf66qMuMbVIMaxKUfN6XKNGWZ+uCtZxFJ++vce5yz0yYzTBOhO33CW40ShIQ6d9w4HeafgOFXp2JkgiAqxqnZTj0xGM0B7uXUx6frzTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 878d25e67c1a11f1aa26b74ffac11d73-20260710
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
X-CID-O-INFO: VERSION:1.3.12,REQID:498a809a-93a4-4bb2-8e59-01ad85f3bfc0,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.12,REQID:498a809a-93a4-4bb2-8e59-01ad85f3bfc0,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:4fba04f2ce21b72797cd9e9a741924e0,BulkI
	D:260710124803IHUJF5Y2,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|136|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 878d25e67c1a11f1aa26b74ffac11d73-20260710
X-User: husong@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1826423182; Fri, 10 Jul 2026 12:48:01 +0800
From: Song Hu <husong@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Song Hu <husong@kylinos.cn>
Subject: [PATCH 3/4] Docs/ABI/damon: document update_tuned_intervals state command
Date: Fri, 10 Jul 2026 12:47:36 +0800
Message-ID: <20260710044737.561102-4-husong@kylinos.cn>
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

The 'update_tuned_intervals' command of the 'state' file, added in
commit 1077605396b4 ("mm/damon/sysfs: implement a command to update
auto-tuned monitoring intervals"), is described in usage.rst but
missing from the canonical ABI document.  Add it.

Signed-off-by: Song Hu <husong@kylinos.cn>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 03aecc07a5bd..7e8192527191 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -36,7 +36,10 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		kdamond.  Writing 'clear_schemes_tried_regions' to the file
 		removes contents of the 'tried_regions' directory.  Writing
 		'update_schemes_effective_quotas' to the file updates
-		'.../quotas/effective_bytes' files of this kdamond.
+		'.../quotas/effective_bytes' files of this kdamond.  Writing
+		'update_tuned_intervals' to the file updates 'sample_us' and
+		'aggr_us' files under 'monitoring_attrs/intervals' with the
+		auto-tuned sampling and aggregation intervals.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
-- 
2.43.0

