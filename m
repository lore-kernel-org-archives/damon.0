Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FB392C54;
	Tue, 13 Jan 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318052; cv=none; b=susgRxgW00og74hjVkYmUHA4QDMua9Yu/eGNSG38YaphEUTgLX5LRna/HKJ+M+36Jsjy/5LkqPS4Hgu7eF6+lpLf/0scy7C1DpzyJPg933IuPGEeGdedFtg5cE6FHHtapRO043k04kp7Rt4xDRmYl0T3QYQEqC0x8vL4CkVjN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318052; c=relaxed/simple;
	bh=u9BpClkZFdNL3P8/T2nVybp/XhQM1COhsP+bLP+TFE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txziZMoNfLBU2KMOEeVMtUsxnsbqamQTT1FHVSEJ62L4PUqWcyqKJdta820MCcXEGHMxJGlLxH054ZZhB+nwuuS9mI7nzG54p10kSpM2qDPYZ5nL9hYm0z/2Pd1w9kNPo/82EZqmBIPq0ryZvYSlfWpnhKfU4zOe2i9oFWiA0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQwLD6Yq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQwLD6Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3778C2BC87;
	Tue, 13 Jan 2026 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318051;
	bh=u9BpClkZFdNL3P8/T2nVybp/XhQM1COhsP+bLP+TFE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQwLD6YquT6NgnNQ84Kx8u7TWgMhbpMmt3X9fEodCwRYUsC9TaiBlzVw/KmPmmtNw
	 1uII382sK4yne5J+fP75WQWpKjrs847Il9tU6TVwhj3ZkqWDU6trZ9l3kTyh6RFVZq
	 vbbSqe4dEk1gvxU4hzdxMa+eAzna3Z1H6u97Y4GII2PQoTkUBtfPxzGq485BQxg5v6
	 Ega6oOwSY7lWyVFPh42UnaMj5FH8ZKnGua+4N/yiHbsxP8nVfQoHX5COyAAUeQOpr7
	 +F6Wa14h2HHNqnQ6QnbYITbui3f1pqJa3v/SGtfPe8MpJL6zoDbGhlWgv9IwAqNkFZ
	 SGvlIBXdiA08Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/11] mm/damon/lru_sort: consider age for quota prioritization
Date: Tue, 13 Jan 2026 07:27:10 -0800
Message-ID: <20260113152717.70459-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT is doing under-quota access pattern based regions
prioritization using only access frequency.  Age of regions is another
useful information for distinguishing hot and cold regions.  Use it for
prioritization, too.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 9388b091deb7..a74c4ec170a9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -71,7 +71,7 @@ static struct damos_quota damon_lru_sort_quota = {
 	/* Within the quota, mark hotter regions accessed first. */
 	.weight_sz = 0,
 	.weight_nr_accesses = 1,
-	.weight_age = 0,
+	.weight_age = 1,
 };
 DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(damon_lru_sort_quota);
 
-- 
2.47.3
