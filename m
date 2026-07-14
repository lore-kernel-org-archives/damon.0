Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E32444716
	for <damon@lists.linux.dev>; Tue, 14 Jul 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041372; cv=none; b=OYegDKCJ1Jb6cjf45+ghRQcr7QSMFfcnQljfPGqMlFg42k0v/LHhyfH6iLlAawGQ5X3Ak6HrQB4e0Wig+Otbx780a5K4Qev+LuALC4LZc/56wZYJtZCC9/NaTtF0gx5FUmtsw/IvB0sU434/erMIFTNtS1YJn2EVU5y6pH7tZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041372; c=relaxed/simple;
	bh=OnEai+eSSA793Nb36+z3mHxPnfn8zmSDTfU02iNNmhs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5eVfcyiet9Uy2d60hKbaHTt/vw5rjZyHdqiFmMN6cMjcXJJwmY22s7SpOY0SW9yrateuHOgf7TUnHF5eIkZlcG5QMPtiTfsPqQfBFXuVyWM9idgbWNfves6TBUt1tyOKESzxzTecs1Qkix3G4RPKtrS22wVFWylTKvoV2gga1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=qPFJWhnh; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="qPFJWhnh"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IT/yVAiDabUqiE4USPZqQnbFTAYiEWdtK+BgXtb/JJ0=;
	b=qPFJWhnhyCVI3xBc8dOhh1yOmaVoHfxNx4zX6UxJlqAqLHXI3S6qXQWbaNnx2fwSovqHzzykP
	BtsRjfeiDMCqW4QQF30+RAjh8kFULQnsvz+/IeDokWhUj6cJnpipsXCfu4VhnKKmDafh06ZXDXh
	223hBGHDuMpRVxVi0yP6KgM=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h02bW5K4BzJ46b4;
	Tue, 14 Jul 2026 23:02:31 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 85AC340584;
	Tue, 14 Jul 2026 23:02:40 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 18:02:40 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<zuoze1@huawei.com>, <damon@lists.linux.dev>, <sj@kernel.org>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v2 3/3] Docs/mm/damon/design: Document hugepage_mem_bp target metric
Date: Tue, 14 Jul 2026 15:01:16 +0000
Message-ID: <20260714150116.382521-4-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714150116.382521-1-gutierrez.asier@huawei-partners.com>
References: <20260714150116.382521-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Document huge_mem_bp metric exposed by sysfs.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2da7ca0d3d17..34d940a13a85 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -686,6 +686,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
   (1/10,000).
 - ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size ratio in
   bp (1/10,000).
+- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
+  (1/10,000).
 
 ``nid`` is optionally required for only ``node_mem_used_bp``,
 ``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
-- 
2.43.0

