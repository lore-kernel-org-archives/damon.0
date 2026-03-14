Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6B70818
	for <damon@lists.linux.dev>; Sat, 14 Mar 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481182; cv=none; b=DI9MVU/U7joSacxSP3TtQ/fCj/KDiiL5Fhw3WJy9y6nugp3sioA4ISN6Y/Rp4WF+FVDsZCDePQAkjo9MYfIZ0DDJCkS/MIcCkjKBh1inwPJwgWgAqX3KFS8vsYyakFsHBUK4ZwR4yd5uHEsxsNtaMIGJiHhd1C+SA09wzYojIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481182; c=relaxed/simple;
	bh=Up7hD+JyVHRK+jkqaDkcGkfzqvkM0V0Yb7aXOhPageA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dTlF8ZD/eK/1jglgf3eUM4cBLbznLfzz4sCk0LvvBDKcCPJqVJLT6qwnBWhHJHUfjpiCPJwgBcp6ntQzZ9fcz/zrcDhfXQVl/yyV8kIkSH7xRTs3dXsIdkvGGVl6sEThh80qWeAF96+pmqYrKYxp4qvY6CNrJTZCIvrLUY9XGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fXxB74vcVzJ46ZK;
	Sat, 14 Mar 2026 17:38:39 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BCE940086;
	Sat, 14 Mar 2026 17:39:30 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 14 Mar 2026 12:39:29 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1] mm/damon: guard THP-specific DAMOS actions with CONFIG_TRANSPARENT_HUGEPAGE
Date: Sat, 14 Mar 2026 09:38:12 +0000
Message-ID: <20260314093813.1359737-1-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
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

MADV_HUGEPAGE and MADV_NOHUGEPAGE are guarded and they are not
available when compiling the kernel without TRANSPARENT_HUGEPAGE
option. Therefore, DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE shouldn't be
available to the user either.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 Documentation/mm/damon/design.rst | 6 ++++--
 include/linux/damon.h             | 2 ++
 mm/damon/sysfs-schemes.c          | 2 ++
 mm/damon/vaddr.c                  | 2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 29fff20b3c2a..207219ee10d4 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -460,9 +460,11 @@ that supports each action are as below.
  - ``pageout``: Reclaim the region.
    Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
+   Supported by ``vaddr`` and ``fvaddr`` operations set when
+   TRANSPARENT_HUGEPAGE is enabled.
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
+   Supported by ``vaddr`` and ``fvaddr`` operations set when
+   TRANSPARENT_HUGEPAGE is enabled.
  - ``lru_prio``: Prioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3a441fbca170..b3fcbe84b5d7 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -138,8 +138,10 @@ enum damos_action {
 	DAMOS_WILLNEED,
 	DAMOS_COLD,
 	DAMOS_PAGEOUT,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+#endif
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5186966dafb3..05e57c7ca2b6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2033,6 +2033,7 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 		.action = DAMOS_PAGEOUT,
 		.name = "pageout",
 	},
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	{
 		.action = DAMOS_HUGEPAGE,
 		.name = "hugepage",
@@ -2041,6 +2042,7 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 		.action = DAMOS_NOHUGEPAGE,
 		.name = "nohugepage",
 	},
+#endif
 	{
 		.action = DAMOS_LRU_PRIO,
 		.name = "lru_prio",
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b069dbc7e3d2..19c488660027 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -897,12 +897,14 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_PAGEOUT:
 		madv_action = MADV_PAGEOUT;
 		break;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	case DAMOS_HUGEPAGE:
 		madv_action = MADV_HUGEPAGE;
 		break;
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+#endif
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
-- 
2.43.0

