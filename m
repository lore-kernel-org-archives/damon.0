Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522712EAFF
	for <damon@lists.linux.dev>; Thu, 19 Oct 2023 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/fE20KR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C9FC433CA;
	Thu, 19 Oct 2023 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744972;
	bh=JxnxpQi8Ul6nOhB30Sf8ttPU+Mbj0MwnPDqKZ/PALpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/fE20KRyvJSGgRHegK3R+DBDTlM3NC4FaQxFC4fEJqSqwQHdqJucdhbh4cngKoMc
	 4Rii7MDRtomRT4L7TDzKSxzplwSoImsmMyfa3pLNK93O+F5ZWCTyb7IQdswuPcgchl
	 965fTzfU8pgybiLDqIrTq1WN72VSV27JSHJAoaMnrSmnzGcIde1GR1YtAwuXZXGr1W
	 eg5GU5zj3caGORuA48hBOJgeswWu4AroqifVxo5HnxmR0uD99zC0Uig6ysPuqW9ijc
	 ypsclOhxptVMU8Q7x6XKah1QWLn8ZPJiX2DEFntORfQiabj4NwIhRpZUTb/thUZHzA
	 ufQlp0F+OjBaQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/5] mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
Date: Thu, 19 Oct 2023 19:49:23 +0000
Message-Id: <20231019194924.100347-5-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calculating the hotness threshold for lru_prio scheme of
DAMON_LRU_SORT, the module divides some values by the maximum
nr_accesses.  However, due to the type of the related variables, simple
division-based calculation of the divisor can return zero.  As a result,
divide-by-zero is possible.  Fix it by using damon_max_nr_accesses(),
which handles the case.

Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3ecdcc029443..f2e5f9431892 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -195,9 +195,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
-	/* aggr_interval / sample_interval is the maximum nr_accesses */
-	hot_thres = damon_lru_sort_mon_attrs.aggr_interval /
-		damon_lru_sort_mon_attrs.sample_interval *
+	hot_thres = damon_max_nr_accesses(&damon_lru_sort_mon_attrs) *
 		hot_thres_access_freq / 1000;
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
-- 
2.34.1

