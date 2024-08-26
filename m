Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD377103;
	Mon, 26 Aug 2024 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646210; cv=none; b=Dyt37ZXjnzYUGeLSu5VamZdDegF7akL5A9Po6hlDlQny7KbY9LEdsuXQvJMBs7e9ALy/7LhRkPfSW1DmOl+ArY/0peyPJY/M8+NxRLQX9LLsd+S/3uEKkNLRqd+CgBwk4wfCsWuGD4C+xftyoYByIE0t8q4kV0WjM1QBxUm4tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646210; c=relaxed/simple;
	bh=8KWTe6g417NjxQYOu8DbwjfveiZLDo0pwWEWfK9DvjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PNvrulF+hzWaIYFUNLQfOXCeJr4Mxn0qq7HcKYpgI1fsPxoZslxXBNG/zaXNDXwPqr7lqb1C7vkwNFPUl+IKv5tEOK+wSylT49mWWO52UxuFA8I+csH1om05ekY3RLl3fhVbjMoq7hmP4y6ewWcxUJ5ym3es0KlsDJTLClzk568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPWGxV5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPWGxV5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A9BC4AF67;
	Mon, 26 Aug 2024 04:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724646210;
	bh=8KWTe6g417NjxQYOu8DbwjfveiZLDo0pwWEWfK9DvjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPWGxV5FGARu1NIS/Xn8xAdpW19/evFCGNH3EP2m6L+LSg6KT4VeBp4oB/ThoQ45D
	 iPkF6RN+oEnwI73janQ9Fh7Qk7qFKyntXTo0FUv8/LTRAKWsiQrAKE35iKKLamOuj5
	 45o59P11Egip5YnveSSZXeK+MNesvM3tWvaVbBtmwYZSCoGZEK2ReUJMYtKdChWlRJ
	 zoN4nRQPQtNbNw0jTgRa0xMaYNz+8/NayjNYhNkHxyzt8p3dsYCwxqE5d+zsiA67Cm
	 2x9BkA4ElJZJ30BW8EukK17m/S4jApjRXW7HBTmWn2YEcdmq9VbmWi44jIH/SL0d0a
	 azOewe0o615Mg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Revert "mm/damon/lru_sort: adjust local variable to dynamic allocation"
Date: Sun, 25 Aug 2024 21:23:23 -0700
Message-Id: <20240826042323.87025-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826042323.87025-1-sj@kernel.org>
References: <20240826042323.87025-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 0742cadf5e4c080aa9bab323dfb234c37a86e884.

The commit was introduced to avoid unnecessary usage of stack memory for
per-scheme region priorities histogram buffer.  The fix is nice, but the
point of the fix looks not very clear if the commit message is not read
together.  That's mainly because the buffer is a private field, which
means it is hidden from the DAMON API users.  That's not the fault of
the fix but the underlying data structure.

Now the per-scheme histogram buffer is gone, so the problem that the
commit was fixing is also removed.  The use of kmemdup() has no more
point but just making the code bit difficult to understand.  Revert the
fix.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 0b35bd5fb659..4af8fd4a390b 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -148,17 +148,12 @@ static struct damon_target *target;
 static struct damos *damon_lru_sort_new_scheme(
 		struct damos_access_pattern *pattern, enum damos_action action)
 {
-	struct damos *damos;
-	struct damos_quota *quota = kmemdup(&damon_lru_sort_quota,
-				    sizeof(damon_lru_sort_quota), GFP_KERNEL);
-
-	if (!quota)
-		return NULL;
+	struct damos_quota quota = damon_lru_sort_quota;
 
 	/* Use half of total quota for hot/cold pages sorting */
-	quota->ms = quota->ms / 2;
+	quota.ms = quota.ms / 2;
 
-	damos = damon_new_scheme(
+	return damon_new_scheme(
 			/* find the pattern, and */
 			pattern,
 			/* (de)prioritize on LRU-lists */
@@ -166,12 +161,10 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* for each aggregation interval */
 			0,
 			/* under the quota. */
-			quota,
+			&quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_lru_sort_wmarks,
 			NUMA_NO_NODE);
-	kfree(quota);
-	return damos;
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
-- 
2.39.2

