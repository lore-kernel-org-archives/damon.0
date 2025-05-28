Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602A27B516
	for <damon@lists.linux.dev>; Wed, 28 May 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430661; cv=none; b=q5IEtHFxeJicXEZ6uO8TECM+xVtbA8VEDsm1Sh/y7aZWC8tErhNWflXlSH3g5kjMNtB55zKD1To4omKy8NvOFn3IE4+qSdtoiaOJp9zvb/R8Aaiu/zkLMWnHl/j4WVW1q35nGKfE+UxMGFUPbB83B6ACidIPowiEG6SjnANcUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430661; c=relaxed/simple;
	bh=1jmecZ5L1+UsOfR9gOZIhTOLkSHDG9ViAD45jRoCSYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssFqj9YP0y9RnSOzNYc/REDPQv2cATZBxSs4W+h88NNuU3CETd3ZOMJmGNSSVlVJioPx0QDfqVLQWpKBRIl3uOnenJyRt0v7NJIOK3ihxbVcF5u9OkLCcvWGAkGLENzLcOqHCos3cBzMJmDg0IJpIk1aq2iPrHbWfeeCcsglCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202505281910480880;
        Wed, 28 May 2025 19:10:48 +0800
Received: from vbox.home.langchao.com (10.94.6.79) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 28 May 2025 19:10:46 +0800
From: wangchuanguo <wangchuanguo@inspur.com>
To: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>, <sj@kernel.org>
CC: <david@redhat.com>, <mhocko@kernel.org>, <zhengqi.arch@bytedance.com>,
	<shakeel.butt@linux.dev>, <lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>, wangchuanguo
	<wangchuanguo@inspur.com>
Subject: [PATCH 1/2] mm: migrate: restore the nmask after successfully allocating on the  target node
Date: Wed, 28 May 2025 19:10:37 +0800
Message-ID: <20250528111038.18378-2-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250528111038.18378-1-wangchuanguo@inspur.com>
References: <20250528111038.18378-1-wangchuanguo@inspur.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20255281910481d35228f5462e32d9f5e25fcd7adb2ed
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

If memory is successfully allocated on the target node and the
function directly returns without value restore for nmask,
non-first migration operations in migrate_pages() by again label
may ignore the nmask settings, thereby allowing new memory
allocations for migration on any node.

Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f8dfd2864bbf..e13f17244279 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1035,11 +1035,11 @@ struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
 	mtc->nmask = NULL;
 	mtc->gfp_mask |= __GFP_THISNODE;
 	dst = alloc_migration_target(src, (unsigned long)mtc);
+	mtc->nmask = allowed_mask;
 	if (dst)
 		return dst;
 
 	mtc->gfp_mask &= ~__GFP_THISNODE;
-	mtc->nmask = allowed_mask;
 
 	return alloc_migration_target(src, (unsigned long)mtc);
 }
-- 
2.39.3

