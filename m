Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF92F5A08
	for <damon@lists.linux.dev>; Mon, 22 Sep 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535852; cv=none; b=AIHLiFR4VODbuZ6miw7oVh+MIdlS0jsbPc0/QoAIBljNHaJfxcVsBV+Swm3fBB/Ha5NlUS/Y8+9QZi2O7A5w19yZmfqLRSNebzewq5tv0lcnmgHmDqZ5HIggpRicO0rLD/1Kf+aLnVceTJZsptaWyBGoL+grM5SaV818XeeMmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535852; c=relaxed/simple;
	bh=pH3DkQVzjLZzULPpCPLJ3cdOjunSw1hPgTtuOolD7R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sl+iobfZ5QaH4hw3eU+UxZ3D79V6VrroVvrNxeb4fBJvFe1EjIXQwlTx1ew9fHFIsNnIQ3naZEoHcrU6nn4v7KDgL717IXLktsU3OygpPM+5P8tax2W0hokItOMFPpx6W2aOXLgH1Bnk9C/at2XqV8adUihVT3AXhbCszQOqVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 659cc440979c11f08b9f7d2eb6caa7cf-20250922
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_C_CI, GTI_FG_IC, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:677bb565-a6a0-4c99-974e-f0d2634e367f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:677bb565-a6a0-4c99-974e-f0d2634e367f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:9fdadd777354701e6854cac0a256054f,BulkI
	D:2509221544039BEHWNZ3,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|10
	2|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:40,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 659cc440979c11f08b9f7d2eb6caa7cf-20250922
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1216891740; Mon, 22 Sep 2025 18:10:42 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [RFC PATCH 0/2] DAMON: add priority-based scheme application control
Date: Mon, 22 Sep 2025 18:10:20 +0800
Message-ID: <20250922101022.362822-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset introduces a priority mechanism for DAMON's scheme
application, allowing users to specify the relative importance of
monitored processes.  The changes ensure that higher-priority targets
receive more frequent memory management operations while maintaining
fairness across all monitored processes.

The first patch modifies kdamond_apply_schemes to implement
priority-based scheduling, where targets are processed in proportion to
their assigned priority values.  For example, a target with priority 50
will be serviced 50 times for every 30 times a target with priority 30
is processed.

The second patch adds a sysfs interface (priority under each target's
directory) to dynamically configure these priorities at runtime. This
enables fine-grained control over DAMON's behavior, making it more
adaptable to performance-sensitive workloads.

Together, these changes provide better flexibility for users who need
differentiated memory management policies across different processes
while maintaining backward compatibility with existing setups.

You may want to verify this feature using the following testing
procedure:

 # git clone -b v2 https://github.com/lienze/damo.git
 # cd damo
 # ./damo start --target_pid $(pidof <target1>) --priority 50 \
 --target_pid $(pidof <target2>) --priority 30 --damos_action \
 pageout --damos_age 5s 5s

Enze Li (2):
  mm/damon/core: introduce priority concept for DAMON
  mm/damon/sysfs: add priority support for DAMOS targets

 include/linux/damon.h |  2 +
 mm/damon/core.c       | 91 ++++++++++++++++++++++++++++++++++++++++++-
 mm/damon/sysfs.c      | 28 +++++++++++++
 3 files changed, 119 insertions(+), 2 deletions(-)

-- 
2.51.0

