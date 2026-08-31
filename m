Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5D49C4BA;
	Mon, 31 Aug 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188253; cv=none; b=YVSNkccGBZWMcZQHbTY/1Soq/l5ybZp9drMCglxJJmsq3MNKFVmBk0zjeIHuSu2ooDZwchMep7sO2D7puRjxc6B1f9HdZHor6nO0Xy5OZkE52RTBsTMrZeKkLXXG4uwJWYuQ3GuVCz22ixG2QRGVLkPdpvLEHQcbtKs94L80zpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188253; c=relaxed/simple;
	bh=UE0RnzVn480eoP0WC9sVQd7CJ7fMw/fMqjNlKhE30co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jd1SAPPBzTZ20wHv7hbpFo/UKH9qyYtqpOF4zGn1mrfhXf1VMxeNrFJPVcazNY3UXmfXrg5SyGjCfBm5DczBiHcBoJAVTKoxOfB3aNbl65+mbxv5H+FNa/xka4EBqyfnkbRgyo2cVgi1G3MguEGwHy8OLOC6kurkDXVAwDGlNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+zCiSEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+zCiSEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEC91F00A3E;
	Mon, 31 Aug 2026 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188252;
	bh=m77KSml7J9PVuWvfDXU+9FGVhk1wJqugBBvBHQZQDmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+zCiSEGrK3Nhq36uxKo0p9P/kcOA4cpEbSw5T1KZg+DAK8nJN/eTFcWbFp0r5vvs
	 2P/YVxF3C7gxWGtQLNfoDgeZ6uK2Whscwipd1W8j/ie71rBLoY7vpdjl9ANKFYBbPw
	 oTNNIOkfqYWe1l1auFjEgXoKhNfBWdaoqSQJtVQOJnrvXFTPXw4ZqpPQQ+kLHIFC4d
	 2R3RBZHF1ZtLQdsiZfibRVSCGTi+WjRfuN+gUOJUx+pcM0yiSxVzuoXvIjva+B0H0o
	 P7GFCV33v1VXSE9jCh3GmunH/A18fTlnnUIupp2+JUN8SbsWuxLWb7X8TbZo7wiQ5e
	 gfqrnnq930bpQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Cheng-Han Wu <hank20010209@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm/damon/core: remove unused damon_nr_running_ctxs()
Date: Mon, 31 Aug 2026 07:57:22 -0700
Message-ID: <20260831145724.82387-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831145724.82387-1-sj@kernel.org>
References: <20260831145724.82387-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng-Han Wu <hank20010209@gmail.com>

damon_nr_running_ctxs() has had no in-tree users since commit
5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
all of its callers.

Remove the unused declaration and definition.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  1 -
 mm/damon/core.c       | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9835b864a8db9..6842a336291e8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1067,7 +1067,6 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
 void damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
 int damon_commit_ctx(struct damon_ctx *old_ctx, struct damon_ctx *new_ctx);
-int damon_nr_running_ctxs(void);
 bool damon_is_registered_ops(enum damon_ops_id id);
 int damon_register_ops(struct damon_operations *ops);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 043eb38de5fd3..53c3f97e3f126 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1866,20 +1866,6 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	return err;
 }
 
-/**
- * damon_nr_running_ctxs() - Return number of currently running contexts.
- */
-int damon_nr_running_ctxs(void)
-{
-	int nr_ctxs;
-
-	mutex_lock(&damon_lock);
-	nr_ctxs = nr_running_ctxs;
-	mutex_unlock(&damon_lock);
-
-	return nr_ctxs;
-}
-
 /* Returns the size upper limit for each monitoring region */
 static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 {
-- 
2.47.3
