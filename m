Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B387374A1A
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833189; cv=none; b=Ja6CLrms0EjCGt7yi97OvdPN90E//POTz0cToB7JRVbPbHRGz4X6fN6zzDJh34mxwLHDajYLfr7mH2etg2VoqlqyIkeOaaLGdpnkRMtSW2Jwvf3vFKL0eWUCaSYknwwrHLOCrXI1Nff3SPDq1NbdsGjgISiTNaB8gjqqxxCaUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833189; c=relaxed/simple;
	bh=vLD9bYArNeLIJTNZq3xpXaXlUnLiHy46ylzcRTr7HeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qigAAZKfImgDuYKq86PAQTkgs3kAMpWcHE4LnOqxgk0zpwz7hPyntXSCs0uFWV3eCj7wFO4hedrK3NS6krsxspQ765LJy9M7F652/1wVjeW95TOAYUQhh+VOO33QKe5UNumDfau7TnxFfmz4Bx4WuufIOXaaPLpGPs5zSgpT3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahbZT3Fm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahbZT3Fm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39b1eb7bde5so9040271fa.2
        for <damon@lists.linux.dev>; Tue, 30 Jun 2026 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833186; x=1783437986; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9OMsgmFwx4twtX8wuXkotNjpYBSB2q91Hio3qUcaSo=;
        b=ahbZT3FmePus8MKZV0pgC0/KFjTRTDMp8OGkTiDv1cuoypfrCOTJb5Ql1Sn1PV/gab
         LkYpOQmHmV623vlZ53BVYBhh5wGwfUh5BhR0GlbQDS6kg3Jcmu/KnVEck/WB5eMymZmR
         QiN+nqqpMInGuArpn1U8cq1UgpM2OcblHcMcaOl6nOHuNr2urrgpjIenJE2s1D71YnBq
         /UoMJHUafmoJdmLHFToJFmImLTxGN5Iw0OiN64x+z6ZcFuUvYxscCZ7Zd7xTSwUVEtAX
         tCXvR3a1Q75Tq7Pb9/vg+RkmYST8yeQkLf+bFlHMVTv179K0gE/6DOHkvGfvrCXZLOFQ
         r52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833186; x=1783437986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9OMsgmFwx4twtX8wuXkotNjpYBSB2q91Hio3qUcaSo=;
        b=NXnWzbgjgGh771TzD76Dn00E5oQH2JgvbebySVYuMPfGK2flogbzsZWDO0WDb7MCBf
         gWlD7cjVNhvxBvbah70pmRvnfGvrF7aR+N2eCtm5m6c/wBW5afaGPBO7kXpQL4LXI/lr
         /DO8VeHf5P73sWVtvySNV8zJ4ilO/pxJvnBskNAKmn6ESJxdDQnIHXe99/E2b7v8gvks
         7eorMSBjKKPLl5spXPY36pMABoQwezMFPqS01XZ2f8rCsTHpHgTLaqXGIJujM2m+eikV
         4Gn+yXz4DglLkLbCw9VIdji+9LzTCLJ5OYaysjgitM7SqYoDOi0qDYt+zEyhStv/yqxr
         +24Q==
X-Forwarded-Encrypted: i=1; AHgh+RqUIZ4suYBp2/iGaiUGOo47sDIbg/OqrYVHP99AouUrna8py2TmrqOLVSyYe4CMY9fO1it4bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWeHAKzP7X553+HMhwbGAIptMPbT6WFjh5zVrNbUSM38yyGNgO
	u8FJ1sAIJ8YS+TX7ghQt/pAdFWesO2PIuT2auVevUgbD0hyDYSK969uZ
X-Gm-Gg: AfdE7ck+l0EVHHTUV8pbTsKB1XWtBMjgxNZmybOjVjLQHhgRZFevPdx3S+ERPBps5ld
	nEj8zYZrG8OaknlJgY+0ohQLBreju4NOiaJXv2ExfPy1PBHvpGu8M3JiY3t5JrrNF1R+7QM1VpD
	BRwTsk/PKqmR83UF87f5oyUOCwmhDpmy6N+x8SVy5KHmgcAl0YN/vC8GVgELTFt79XB9hVwHLkP
	VFA+Job9ma/OqaAqFopzSg9+m4BseNoMhF7DsWB6w94gEVdSoegBg0bEVfb6D4miwW1F66g10wz
	0+49Cjoa9KTwjJaMdnDxRSV6Ajv89XoReMZHdUbI4uXz71wtsvMlrveVaTQ4I4cb2MzT/Ij94eq
	RsDcLzoS4PA7zNuVhXC6VXrKUn+nS44w84EG3MgKPGjES54dJWKMuiOFv7Qf++EAViEEiijCJqL
	+6cCVae/vk0smIXDWwV1eJufqN0xaSqibyeyHVEoP4+Tv6kgjg8T9HBoGG1ZHXnBZplPOFdkj+b
	ubXFKs=
X-Received: by 2002:a05:6512:618:10b0:5ae:a9d1:2854 with SMTP id 2adb3069b0e04-5aec10c76acmr294395e87.44.1782833185330;
        Tue, 30 Jun 2026 08:26:25 -0700 (PDT)
Received: from debian.localdomain (95-25-158-125.broadband.corbina.ru. [95.25.158.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aebe333664sm667745e87.6.2026.06.30.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:26:24 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH] mm/damon/vaddr: check address space stability before VMA traversal
Date: Tue, 30 Jun 2026 18:25:58 +0300
Message-ID: <20260630152558.24063-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __damon_va_three_regions(), the VMA tree is traversed without
checking if the address space is stable. If the OOM reaper runs
concurrently, it may mark the mm as MMF_UNSTABLE and leave empty
markers in the maple tree.
Add a check_stable_address_space(mm) call before iterating over
the VMAs to avoid potential NULL pointer dereferences.

Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 mm/damon/vaddr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 345b89b5d..e756ac147 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
+#include <linux/oom.h>
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
@@ -84,6 +85,9 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	 * If this is too slow, it can be optimised to examine the maple
 	 * tree gaps.
 	 */
+	if (!check_stable_address_space(mm))
+		return -EINVAL;
+
 	for_each_vma(vmi, vma) {
 		unsigned long gap;
 
-- 
2.47.3

