Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1653BE653
	for <damon@lists.linux.dev>; Tue, 10 Mar 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159938; cv=none; b=RGvtTMQ76x+Z0XH/uRwoxmx+QpN50Bs9G+rCRhrvFNW6zD2S/V7NRGTrr+cy+G0mU1uayFIMEggFWtvKHCJ8DYatBk7lDUeYYYgscy+AtHLCRwSbX73mghRWpzKBOVD56tHAxg+1HZBcUuF/Y3HLHC4/k3HzOWefTlAt9bWG99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159938; c=relaxed/simple;
	bh=VI2PM21MrOU5iz4b76NvZggsYEB0wlt6xKlix1OQhQc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y40TulpRIShBhb1ONTMvnHkIuiigtaOfifrk3CHVIUqPQGrUPnykvOMYLkhOdNVwan6krM5TRww5rayL5FmGImG6dN9K2iN53/6XGNOUGkvTOIAWYKZKShRjrzRusjbx9re3EdXjerjCMi9bx+xuGrxFLmPuoQYrZPRWronOzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fVfNd2Dg6zJ469b;
	Wed, 11 Mar 2026 00:24:49 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 23EAB40086;
	Wed, 11 Mar 2026 00:25:34 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 19:25:33 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 2/4] mm/damon: Support for synchrounous huge pages collapse
Date: Tue, 10 Mar 2026 16:24:18 +0000
Message-ID: <20260310162420.4180562-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310162420.4180562-1-gutierrez.asier@huawei-partners.com>
References: <20260310162420.4180562-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
---
 include/linux/damon.h | 1 +
 mm/damon/vaddr.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a4fea23da857..a9cf17b9e8fa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -142,6 +142,7 @@ enum damos_action {
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
 	DAMOS_MIGRATE_COLD,
+	DAMOS_COLLAPSE,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 729b7ffd3565..36791a9a1094 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -969,6 +969,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_COLLAPSE:
+		madv_action = MADV_COLLAPSE;
+		break;
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
-- 
2.43.0

