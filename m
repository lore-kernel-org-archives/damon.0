Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACA6AD5
	for <damon@lists.linux.dev>; Mon, 24 Oct 2022 20:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B0FC433D7;
	Mon, 24 Oct 2022 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666644571;
	bh=ed3OO6jR2hviy6STfWb58XYnzMUxxyGe+e0xErjg1fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9cIXzhU9U1zWxdfPsC7S7cI+Ulc4SATnZVntGHQSe96wwChjQu3bcUIxth195MMp
	 f4ukgLvBrlxZd/H8PRujs8KanGthShxmvvpLnHDKW1Lq299OzeaVMvog4X/ZgZdPDc
	 gpM3BJ3Hn9RDw+azkUEHJHF155dHbvb5CGHOXw6Wpj2N2B1XvJx/RMFy6ILnUIFUIW
	 PoUMZQoA9/tvPN6u7OKJusB50RP+v/mQIrqZw2hTUaX68Z3CYtid7Ykt9yjoi1Gflh
	 D8BsHRcEsbV8Q8JtuFi3LFky/66KYi+CsQEkI+AyyL6UbExCY19nR679Fw2zEgoFJn
	 9ENAJnc8bWkRg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] mm/damon/{reclaim,lru_sort}: remove unnecessarily included headers
Date: Mon, 24 Oct 2022 20:49:19 +0000
Message-Id: <20221024204919.18524-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204919.18524-1-sj@kernel.org>
References: <20221024204919.18524-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some headers that 'recalim.c' and 'lru_sort.c' are including are
unnecessary now owing to previous cleanups and refactorings.  Remove
those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 --
 mm/damon/reclaim.c  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index a1896c5acfe9..5c60163e556c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -8,9 +8,7 @@
 #define pr_fmt(fmt) "damon-lru-sort: " fmt
 
 #include <linux/damon.h>
-#include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/workqueue.h>
 
 #include "modules-common.h"
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3173f373435c..e14eb30c01f4 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -8,9 +8,7 @@
 #define pr_fmt(fmt) "damon-reclaim: " fmt
 
 #include <linux/damon.h>
-#include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/workqueue.h>
 
 #include "modules-common.h"
-- 
2.25.1

