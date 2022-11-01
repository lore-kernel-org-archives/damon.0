Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6267B
	for <damon@lists.linux.dev>; Tue,  1 Nov 2022 21:15:25 +0000 (UTC)
Received: from pop-os.home ([86.243.100.34])
	by smtp.orange.fr with ESMTPA
	id pyanoKD2rsfCIpybToWfKU; Tue, 01 Nov 2022 22:15:24 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:24 +0100
X-ME-IP: 86.243.100.34
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 20/30] mm/damon: Use kstrtobool() instead of strtobool()
Date: Tue,  1 Nov 2022 22:14:08 +0100
Message-Id: <ed2b46489a513988688decb53850339cc228940c.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a serie that axes all usages of strtobool().
Each patch can be applied independently from the other ones.

The last patch of the serie removes the definition of strtobool().

You may not be in copy of the cover letter. So, if needed, it is available
at [1].

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 mm/damon/lru_sort.c | 3 ++-
 mm/damon/reclaim.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 2a532e3983df..7b8fce2f67a8 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "damon-lru-sort: " fmt
 
 #include <linux/damon.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 
 #include "modules-common.h"
@@ -241,7 +242,7 @@ static int damon_lru_sort_enabled_store(const char *val,
 	bool enable;
 	int err;
 
-	err = strtobool(val, &enable);
+	err = kstrtobool(val, &enable);
 	if (err)
 		return err;
 
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e57604bec06d..e82631f39481 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "damon-reclaim: " fmt
 
 #include <linux/damon.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 
 #include "modules-common.h"
@@ -187,7 +188,7 @@ static int damon_reclaim_enabled_store(const char *val,
 	bool enable;
 	int err;
 
-	err = strtobool(val, &enable);
+	err = kstrtobool(val, &enable);
 	if (err)
 		return err;
 
-- 
2.34.1

