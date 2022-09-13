Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2D66E7
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B463C43144;
	Tue, 13 Sep 2022 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091104;
	bh=9Ie/eYWIDmaeWIIzjho1hLTkE8OQk0TsC6fyZAjKC84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxRWRVz4xS5qVWe0ZeEo+e/hBelBW8BPMyZafRuBCXoJrRDNz1nALb/Sf/2DOVjJD
	 mNrKJnwvEdDCg6m6D1X6N4wVNEmxcdegxtNWe+GcmTyYdGioHK64En+VztzAuQXsUK
	 SZ07SpZurtmGYM9ySOXA9xshufEBcFNxjJwPNYZLCSFRJb+Quro+hey6JeF60M+7Yp
	 kyeOuG1jQhZwOJM8p/tQZ2KRiw8xpWYW90HispIXRVkON86iKUGTfqylXV2hKeDn9o
	 dijqj+f38tCRUTBqoIOb0vN876wv4buHFms+KzPbT0rAC5gHkA3Id5l0yTer8F3EYo
	 rIZdrvbrhAhTQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/22] mm/damon/modules-common: implement a stats parameters generator macro
Date: Tue, 13 Sep 2022 17:44:42 +0000
Message-Id: <20220913174449.50645-16-sj@kernel.org>
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

DAMON_RECLAIM and DAMON_LRU_SORT have module parameters for DAMOS
statistics that having same names.  This commit implements a macro for
generating such module parameters so that we can reuse later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/modules-common.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 4c2ce84869d5..ed973e0770ae 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -23,3 +23,15 @@
 	module_param_named(wmarks_high, wmarks.high, ulong, 0600);	\
 	module_param_named(wmarks_mid, wmarks.mid, ulong, 0600);	\
 	module_param_named(wmarks_low, wmarks.low, ulong, 0600);
+
+#define DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(stat, try_name,		\
+		succ_name, qt_exceed_name)				\
+	module_param_named(nr_##try_name, stat.nr_tried, ulong, 0400);	\
+	module_param_named(bytes_##try_name, stat.sz_tried, ulong,	\
+			0400);						\
+	module_param_named(nr_##succ_name, stat.nr_applied, ulong,	\
+			0400);						\
+	module_param_named(bytes_##succ_name, stat.sz_applied, ulong,	\
+			0400);						\
+	module_param_named(qt_exceed_name, stat.qt_exceeds, ulong,	\
+			0400);
-- 
2.25.1

