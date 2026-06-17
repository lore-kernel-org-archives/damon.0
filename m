Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226D23B8D7B
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679500; cv=none; b=RpPD/5WoQuUDNRRYJD65mF4bujHu47D8bnsRaSiMRK8TSdbrfayYEGCEHdgps3GXm0QSQlge+luLBEGrkfFmfk1xGXSLHYCBCeEbm9HHEWQsxyxOZ4b/6qoQV3G55MCX359FCuAZaD9YCylJq+D89WJMV4ZylVumjYzgaJw31js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679500; c=relaxed/simple;
	bh=IbRiJ/Gma2PBHsGo8yJlTx8HHE8NMr2ZWSwWgU+ci/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JojaLNbR4LccJnQApb/6HlasKKJDUurdfYSUNDFCZ/wTrpVCMPa8dyMg+pIWknB49r7FQJocDxsh7KDyLc1WpK+QuI8ug7Ad0b6BMqxVqdGTq5W463kMgI2b/cYF3wOah4tNsa+0VE+Rh8L9Y6SLhaJ0bpg5DggDcybSnmX7r7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggF6s2tqvzHnGg3;
	Wed, 17 Jun 2026 14:57:57 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 412E740577;
	Wed, 17 Jun 2026 14:58:15 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 09:58:14 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] samples/damon: Fix typo in Kconfig help text
Date: Wed, 17 Jun 2026 06:57:16 +0000
Message-ID: <20260617065716.750179-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
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

Fix a typo in samples/damon/Kconfig help text. Change
"Thps" to "This".

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 samples/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index cbf96fd8a8bf..182a59722879 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -31,7 +31,7 @@ config SAMPLE_DAMON_MTIER
 	bool "DAMON sample module for memory tiering"
 	depends on DAMON && DAMON_PADDR
 	help
-	  Thps builds DAMON sample module for memory tierign.
+	  This builds DAMON sample module for memory tierign.
 
 	  The module assumes the system is constructed with two NUMA nodes,
 	  which seems as local and remote nodes to all CPUs.  For example,
-- 
2.43.0

