Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0333F360
	for <damon@lists.linux.dev>; Mon, 16 Mar 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686370; cv=none; b=uFfgcBFCwnBkiMEr2KVpZ7Ct/BR0u5Igj7LD67HMEcD9sEiQ4/CoqLTpL+0rglBii5hhYiV4GZT12qH6BTH0uD/UrdGqWL+zcdZuA/zjToeej4OyCF4nELA7Hwm8KhvqJ6PXHre5F+dWgJVE3XDaIdioyT+YGxHV6AMVOGhb6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686370; c=relaxed/simple;
	bh=Auw6mQopLS5NUXCZhG8aYr1bNmql+WJrerr0XdyluXg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Le+PdVF8kkXBRhi5K2lGeIXnZpGeiijDD8dpDH75gIq1R5CDo36a0SVdAUOmi6x2nHw62vWN441Z7pKaZKWexx+VrwoABtJmoP9HF2Cl/wa8TFPNFU3GykwLE8Wr7tf4fwb55NeABKVfRNKpJV2oAoX1bn7nWu/ihXn2EiUYoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZP4p6stTzHnGfH;
	Tue, 17 Mar 2026 02:39:06 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 042C140584;
	Tue, 17 Mar 2026 02:39:25 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 21:39:24 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <ljs@kernel.org>,
	<Liam.Howlett@oracle.com>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Mon, 16 Mar 2026 18:38:05 +0000
Message-ID: <20260316183805.2090297-1-gutierrez.asier@huawei-partners.com>
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

This patch set introces a new action: DAMOS_COLLAPSE.

For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
working, since it relies on hugepage_madvise to add a new slot. This
slot should be picked up by khugepaged and eventually collapse (or
not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
enabled, khugepaged will not be working, and therefore no collapse
will happen.

DAMOS_COLLAPSE eventually calls madvise_collapse, which will collapse
the address range synchronously.

This new action may be required to support autotuning with hugepage as
a goal.

[1] https://lore.kernel.org/lkml/20260314165156.86647-1-sj@kernel.org/

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++++
 include/linux/damon.h             | 1 +
 mm/damon/sysfs-schemes.c          | 4 ++++
 mm/damon/vaddr.c                  | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 29fff20b3c2a..3b1461f42987 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -463,6 +463,10 @@ that supports each action are as below.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``collapse``: Call ``madvise()`` for the region with ``MADV_COLLAPSE``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set. When
+   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
+   fail.
  - ``lru_prio``: Prioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3a441fbca170..6720dc70c487 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -140,6 +140,7 @@ enum damos_action {
 	DAMOS_PAGEOUT,
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+	DAMOS_COLLAPSE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5186966dafb3..aa08a8f885fb 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2041,6 +2041,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
 		.action = DAMOS_NOHUGEPAGE,
 		.name = "nohugepage",
 	},
+	{
+		.action = DAMOS_COLLAPSE,
+		.name = "collapse",
+	},
 	{
 		.action = DAMOS_LRU_PRIO,
 		.name = "lru_prio",
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b069dbc7e3d2..dd5f2d7027ac 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -903,6 +903,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
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

