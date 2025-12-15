Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5133B6FF
	for <damon@lists.linux.dev>; Mon, 15 Dec 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808520; cv=none; b=gU8LFGtZ//gq6/zxEf3nmxP01P29L/JBf9HQnrDgo5CmKBUrXjGsUHmXy9/pvEmKQhdrR83mMV3CWn1Y65hlxhD1p0CA9jzbWp+mWPPVjYVqGkxup3al/cc33QDeD8w16zpWanZgyJqgbc9fsIBAIkKJOCNuome8cqdgDC1MQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808520; c=relaxed/simple;
	bh=7CtgNzciMeN/j01y/n5Gaf06poZYvQB7EKFA/KTPCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jq1+sF1IfgaJIhBoEtZjBB+O9h9yWiR0gE5qkgmDij+D/eHIw/l8/lRBaaro/r2FEdoJH/3JnZRIy2t531zts+h6W0nztJvkfNsqOxSTkXHJz9/rWxtdeMwtTJw1z1aJe19IiR0ibgLTSd5I0pvHicu7QOzqLOXR9HdBqhi87Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 64f5d272d9c111f0a38c85956e01ac42-20251215
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
X-CID-O-INFO: VERSION:1.3.6,REQID:f43e1b67-0c3b-4f04-88b6-56baf8ccb14e,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:f43e1b67-0c3b-4f04-88b6-56baf8ccb14e,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:dd1bf524195dcf197d833e47ec69bb52,BulkI
	D:2512152221510JK8K5F8,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 64f5d272d9c111f0a38c85956e01ac42-20251215
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1342721327; Mon, 15 Dec 2025 22:21:49 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
Date: Mon, 15 Dec 2025 22:20:55 +0800
Message-ID: <20251215142057.588500-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes DAMON's advanced memory management accessible to a
broader range of users through two complementary enhancements.  First,
it exports the necessary DAMON core symbols to enable building loadable
kernel modules.  Building on this foundation, it then introduces the
'prdm' module, which extends the concept from the DAMON sample code
(prcl.c) into a production-ready, user-friendly tool.

The key strength of this module is its out-of-the-box simplicity: by
simply specifying the PIDs of target processes and enabling the module,
users can concurrently monitor memory access patterns across multiple
processes and trigger proactive reclamation automatically.  This
significantly lowers the barrier to using DAMON, allowing system
administrators and regular users without deep kernel expertise to easily
apply sophisticated memory optimization.

The goal is to help alleviate system-wide memory pressure and improve
performance for various workloads, advancing DAMON from a
developer-centric tool towards a practical solution for a wider
audience.

To test this 'prdm' module, you can follow these steps,

  # modprobe prdm
  # cd /sys/module/prdm/parameters
  # echo <target1_pid> > damon_prdm.target_pid
  # echo <target2_pid> > damon_prdm.target_pid
  # echo <target3_pid> > damon_prdm.target_pid
  # cat damon_prdm.target_pid
  Tasks: <target1_pid> <target2_pid> <target3_pid>(exited)
  # echo Y > damon_prdm.enabled

To stop the monitoring,

  # echo N > damon_prdm.enabled
  # rmmod prdm

Enze Li (2):
  mm/damon/core: export necessary symbols
  mm/damon/modules: introduce prdm module for DAMON

 mm/damon/Kconfig          |   2 +
 mm/damon/Makefile         |   1 +
 mm/damon/core.c           |  10 ++
 mm/damon/modules/Kconfig  |  18 +++
 mm/damon/modules/Makefile |   3 +
 mm/damon/modules/prdm.c   | 251 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 285 insertions(+)
 create mode 100644 mm/damon/modules/Kconfig
 create mode 100644 mm/damon/modules/Makefile
 create mode 100644 mm/damon/modules/prdm.c


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.52.0

