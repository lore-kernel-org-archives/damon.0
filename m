Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969F401494
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548913; cv=none; b=U0ThM3huwFGYLagtnrkQveN/FLdfIKhziiS0l4GXaAnPH7QRxcmzXvxON52z2lVAgpIcVyxS4iRVW+iOtD/BCupPpGfSSKJixrmiyeJNiTenn7qGfNmEfQWrRCMeRG2qVwQYlBJ5uB1cZj45rdfs/1SBn28Zmyejbn+a7/qmqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548913; c=relaxed/simple;
	bh=dkAR92jis8STtC64GAqFUhy2cPmVcY6pES7V+MghZSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cz6AjlOIic51vXS1CcJAcJ24TDwq6a1Ek+nScw6CbADVJdf6vwUxp8bb/ruj8ErTrycb7D4w/W4DYMjtg9QQoE3NyYDUsNeMG/Iw8QHr+yWAwAHteSjIgCqdCMY6ggAFEExZ+kfRZHh7cbnbcYx9YJSEcIlgSgarVqP53XMRwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=GDnvskj1; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="GDnvskj1"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=o7VcgX5vIHVzpuEW1mQLqgVH3WPDkCDx6B6ye8bU6SE=;
	b=GDnvskj1Y3CRxQwlfdqkMCVN7KbsUN9TRUXS6qtHZJL3c3/OfKyFY4YHsbTGCPrwi4pcPyBWo
	iMYDoqAfLmtTarkKKHMkjTgqop2hDVexyj09QbH0Z6FW5sxkdO+/X+WQktbMhS4lkrnB3EovgmD
	Amwn80nGqOFofRoaMRIruWs=
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h3fHj6t8bzHnH5k;
	Mon, 20 Jul 2026 20:01:21 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 21FA640570;
	Mon, 20 Jul 2026 20:01:44 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 15:01:43 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] Docs/mm/damon/design: Document hugepage_mem_bp target metric
Date: Mon, 20 Jul 2026 12:01:40 +0000
Message-ID: <20260720120140.881468-4-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
References: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Document hugepage_mem_bp metric exposed by sysfs.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aed6cb1cf483..a8c163475ef2 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -713,6 +713,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
   bp (1/10,000).
 - ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
   of a node in bp (1/10,000).
+- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
+  (1/10,000).
 
 ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
 ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
-- 
2.43.0

