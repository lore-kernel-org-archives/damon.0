Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD401B142D
	for <damon@lists.linux.dev>; Mon, 16 Mar 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670186; cv=none; b=WLzUUgqZAl6wuIwtW8SwKnURlGxj4g+3ciaiRt8IvwYh3Pl/FKOzAFUtRTACLn87Q9CIP0hvzzWE7svfc6FBqg/uRo9/d5aTGmkwszVRD8r8J9eQAWAfscAGm6e5DkdZhGibrVC8trN81AZuEB0O2eRwJ4YNkRhlv0Dj+/r7mW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670186; c=relaxed/simple;
	bh=IZjs1SzxSGaIK25pDbcIvjHTN7EfwTxLqrolT0tr6Tk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R0TTcQYrUf4jpwh3BB2W5FpdrBuoirk/z5oacqCuzNCf40345lzryj13Mv2zLGVx+U/6oca7CvLlMT6Qp9S516glNmb3fmbLRrtQEHSnCXQkqZ7z0a6frl9J8N2g+H5pbrXogKqiKoyGcbE2JOALwLUNhHxxjI7pBD9evj/TEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZH4t4vNVzJ46DS;
	Mon, 16 Mar 2026 22:08:46 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 3722540584;
	Mon, 16 Mar 2026 22:09:41 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 17:09:40 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <ljs@kernel.org>,
	<Liam.Howlett@oracle.com>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] Docs/mm/damon: Document DAMON actions when TRANSPARENT_HUGEPAGE is off
Date: Mon, 16 Mar 2026 14:08:21 +0000
Message-ID: <20260316140822.2033181-1-gutierrez.asier@huawei-partners.com>
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

MADV_HUGEPAGE and MADV_NOHUGEPAGE are guarded and they
are not available when compiling the kernel without TRANSPARENT_HUGEPAGE
option. The DAMON behaviour is to silently fail[1] in when DAMOS_HUGEPAGE or
DAMOS_NOHUGEPAGE are used, but TRANSPARENT_HUGEPAGE is disabled. Update the
DAMON documentation to reflect this behaviour.

[1]: https://lore.kernel.org/damon/66131775-180b-4b9f-b7ce-61a3e077b6e6@huawei-partners.com/T/#m278d3c9bbedcceaf2efa51e3dc7b40a40654e51c

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 Documentation/mm/damon/design.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 29fff20b3c2a..478eab4a186a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -460,9 +460,13 @@ that supports each action are as below.
  - ``pageout``: Reclaim the region.
    Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
+   Supported by ``vaddr`` and ``fvaddr`` operations set. When
+   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
+   fail.
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
+   Supported by ``vaddr`` and ``fvaddr`` operations set. When
+   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
+   fail.
  - ``lru_prio``: Prioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.
-- 
2.43.0

