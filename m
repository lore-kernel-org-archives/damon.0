Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604B2FE58C
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291870; cv=none; b=q71oFHzP/+I00upEztTF7Sl9cJCIsPC5/t78kQeI9uaCW1pf2yKHArhrcfXWTpowgFtzXrIBtzqE935ZTBN5xbPM32wQhIB6owYGiQUnS3h8ZrHxoGYUqDtaYl6Au1MyvFaaUZ3zmjTOzcQs88KoITj03v8XGzcYLGbq/JBgIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291870; c=relaxed/simple;
	bh=MW5jGxg83vZLIru3+gkP9EwEq8t390Loe8hLTC/C0YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fX+8KiDu76ZeCn0lh2dRkU9HpD6I3yJUWnkOJ1JxSiRZHf3K9vUvxYpzBu7G6zAuWtUhqdFiL/OuYeLE1bSmCE8uWG8e2BaF7Ss74bcCJ7Hm6O6gFiZOCoci1I0uIto9f0sr4gz4sMkJ29lTvQcLOrIQtYjrcsDuKHylZBaFyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 78812056d50e11f0a38c85956e01ac42-20251209
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_C_CI, GTI_FG_IC
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5aca313a-6b53-4e05-8cc9-d8fd65a0c629,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:5aca313a-6b53-4e05-8cc9-d8fd65a0c629,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:d0969ff4c2f5e0348c8b557d1f52115a,BulkI
	D:2512092243430WAGPXSZ,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:40,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 78812056d50e11f0a38c85956e01ac42-20251209
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1831383406; Tue, 09 Dec 2025 22:50:57 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [RFC PATCH 0/2] mm/damon: Introduce basic auto-tuning framework with priority support
Date: Tue,  9 Dec 2025 22:50:24 +0800
Message-ID: <20251209145026.3263754-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, users need to manually tune multiple parameters (e.g.,
watermarks, quotas) for different workloads when using DAMON.  This
increases the barrier to entry and complicates adoption.  This patchset
aims to lower this barrier by introducing a basic auto-tuning
framework for DAMON, which allows the system to automatically adapt
DAMON's operational parameters based on user-provided hints and system
state.

The core idea is to allow users to assign a simple priority level to
each monitoring target.  Based on these priorities and the current system
conditions (initially focusing on free memory), the framework
dynamically adjusts DAMON's parameters.  The initial implementation
focuses on the automatic management of watermarks.

While the auto-tuning functionality could be implemented in user space
as a separate daemon, integrating it directly into the DAMON kernel
subsystem offers distinct advantages essential for a memory management
automation feature.  First, it delivers superior performance and
real-time responsiveness by executing tuning logic within the monitoring
thread (kdamond) context, eliminating the latency and overhead of
frequent kernel-user space context switches and system calls.  This
ensures parameter adjustments can keep pace with DAMON's monitoring
cycles.  Second, it provides inherent reliability as the tuning logic
becomes an integral part of the DAMON context, immune to failures of any
user-space process (e.g., termination by the OOM killer) and requiring
no additional service management.  Finally, it offers a simplified,
out-of-the-box experience where users enable auto-tuning through a
single configuration without needing to install, maintain, or ensure
version compatibility of an external tool.  This kernel-based approach
aligns with the goal of creating a robust, low-overhead, and truly
self-adaptive memory management subsystem.

You may want to verify this framework using the following testing
procedure:

 # git clone -b v2 https://github.com/lienze/damo.git
 # cd damo
 # ./damo start --target_pid $(pidof <target1>) --priority 50 \
 --target_pid $(pidof <target2>) --priority 30 --damos_action \
 pageout

Enze Li (2):
  mm/damon/auto-tuning: introduce DAMON-based auto-tunning module
  mm/damon/sysfs: introduce priority sysfs interface

 include/linux/damon.h  |   3 +
 mm/damon/Kconfig       |  11 ++
 mm/damon/Makefile      |   1 +
 mm/damon/auto-tuning.c | 244 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/auto-tuning.h |  10 ++
 mm/damon/core.c        |  11 ++
 mm/damon/sysfs.c       |  41 +++++++
 7 files changed, 321 insertions(+)
 create mode 100644 mm/damon/auto-tuning.c
 create mode 100644 mm/damon/auto-tuning.h

-- 
2.52.0

