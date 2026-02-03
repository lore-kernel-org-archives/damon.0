Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [221.12.31.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FC314B79
	for <damon@lists.linux.dev>; Tue,  3 Feb 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=221.12.31.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116106; cv=none; b=BQjUx37fvKVol8EuQgju9sclNYJbj2EDRC91X7NzR6qTa7UumITVMM0yogcrnNsIqp0BysvAeHLiSROx+tquaCzayqRZ6yBrLeN5kVIyEd6kAgyGnL8eg4uMnj1fP5sDkT0ePrt010FrxKJaQ0dRch1l74s+j3lnQCVlntUpHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116106; c=relaxed/simple;
	bh=fRwPjReG3GV3U9+veyyU8sYQkEsMVpWr7PMct2HsJvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ePgvknYcjXnvFOvKg0lVtRLdWAWGEQ7p0jP+dRim04p21aLlR3ll96vpo/Kt7l29Gb4NwitlsLMdq4lI15sitcoTHpbKYya0WTJsMixhPqy1DHyF/mDII2mP3JqJ/5Fbs/1KMWkKeofs2Dr2xiCaUZzyj258LBfRpy46VdkBiD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=221.12.31.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 6139sq5D069674
	for <damon@lists.linux.dev>; Tue, 3 Feb 2026 17:54:52 +0800 (+08)
	(envelope-from qin.yuA@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 6139s72e067249;
	Tue, 3 Feb 2026 17:54:07 +0800 (+08)
	(envelope-from qin.yuA@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id 4B12D2011873;
	Tue,  3 Feb 2026 18:03:53 +0800 (CST)
Received: from localhost.localdomain (10.142.164.51) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 3 Feb 2026 17:54:07 +0800
From: qinyu <qin.yuA@h3c.com>
To: <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, qinyu <qin.yuA@h3c.com>
Subject: [PATCH] mm/damon: remove redudnant mmu notifier call in pmdp mkold
Date: Tue, 3 Feb 2026 17:54:00 +0800
Message-ID: <20260203095400.2465255-1-qin.yuA@h3c.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 6139sq5D069674

Currently, mmu_notifier_clear_young() is called immediately after
pmdp_clear_young_notify(), which already calls mmu_notifier_clear_young()
internally. This results in a redundant notifier call.

Replace pmdp_clear_young_notify() with the non-notify variant to avoid the
duplicate call and make the pmdp path consistent with the corresponding
ptep_mkold() code.

Signed-off-by: qinyu <qin.yuA@h3c.com>
---
 mm/damon/ops-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index a218d9922..8c6d61342 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -90,7 +90,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 		return;
 
 	if (likely(pmd_present(pmdval)))
-		young |= pmdp_clear_young_notify(vma, addr, pmd);
+		young |= pmdp_test_and_clear_young(vma, addr, pmd);
 	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE);
 	if (young)
 		folio_set_young(folio);
-- 
2.33.0

