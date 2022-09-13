Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826266E7
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92E0C43142;
	Tue, 13 Sep 2022 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091101;
	bh=kK1sxLOXEkaoDNnV++Rope2Ec8RZDVijxu5erLk09sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdVSywTxsq0Xeh3ZASYyycbEgiYJiKaQ5ta5McLxvRu2AiXwWQowXtIqqKC41LuQw
	 hNgbHrDkc2xHScq2yRGwn6raCF4mMNpeuEtyZd4GNyM1cuxyYgOG5mgrURSS4LNa8D
	 IK+Ip4ztkqRC7f8WiHYYRDMxavuASn6po6rLCFsQuPVfL7U/D40W7VsMfLMcCT6rjp
	 Pie2gHvvQwJBFQq4xoJaJ6J5hEuuMj7Nn3eTT1yiN1/HuRhLEdLX5ZLyQPMDwAXDcO
	 PHWGYlKXvIW2ZUztbr9nMwaqDBkUGZuq57AAB7uZrwRhk/K5KawdsTv8P/lpsXOSZm
	 Sez7g0v2A+9Mg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 09/22] mm/damon: implement a monitoring attributes module parameters generator macro
Date: Tue, 13 Sep 2022 17:44:36 +0000
Message-Id: <20220913174449.50645-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM and DAMON_LRU_SORT have module parameters for monitoring
attributes that having same names.  This commot implements a macro for
generating such module parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 mm/damon/modules-common.h

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
new file mode 100644
index 000000000000..0abd0636bc64
--- /dev/null
+++ b/mm/damon/modules-common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common Primitives for DAMON Modules
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/moduleparam.h>
+
+#define DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(attrs)			\
+	module_param_named(sample_interval, attrs.sample_interval,	\
+			ulong, 0600);					\
+	module_param_named(aggr_interval, attrs.aggr_interval, ulong,	\
+			0600);						\
+	module_param_named(min_nr_regions, attrs.min_nr_regions, ulong,	\
+			0600);						\
+	module_param_named(max_nr_regions, attrs.max_nr_regions, ulong,	\
+			0600);
-- 
2.25.1

