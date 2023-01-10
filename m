Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E171A94B
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB108C433D2;
	Tue, 10 Jan 2023 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377445;
	bh=EpuEVUL614S47vXoslv07ySnDH61IdNVsBrU1EkLty8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCl8S7YiAsYSjVYQ6JjpL33E5Zdyh0Drih0OrdQyMBev/agRdKUdaHNWOrGbsRJsk
	 CUm9xv0Q1qyvDy/JbGUNQAH4T2SCwyC0lwrr3By+XE5/gPxPZUEJTGvN8p9MNiYoUH
	 fJNRL+cOlBex8DtmAvlIcioI4YLkXREUsKisYvBQRXNjsHzh6JIaPkyi0DG+RCkTkY
	 BEggkVrMC5MbN75tGE5AjEaBQqvdq+bYZEszEMZhwLR2sFFK/im+NdyEMMbLFCwESC
	 lsHWX7EzszK4qUGrr0DNzX1R9gXbytMa+c88X9+QFYpxaCrUt9mwFUlVLDKC/1LoiL
	 p5PeAAxRCMc9g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm/damon/core: update kernel-doc comments for DAMOS action supports of each DAMON operations set
Date: Tue, 10 Jan 2023 19:03:53 +0000
Message-Id: <20230110190400.119388-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supports of each DAMOS action are up to DAMON operations set
implementation in use, but not well mentioned on the kernel-doc
comments.  Add the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7907918ad2e0..3fa96d7c9fe4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -91,6 +91,12 @@ struct damon_target {
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
+ *
+ * The support of each action is up to running &struct damon_operations.
+ * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
+ * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
+ * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
+ * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
  */
 enum damos_action {
 	DAMOS_WILLNEED,
-- 
2.25.1

