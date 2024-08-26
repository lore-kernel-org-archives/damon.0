Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D446450;
	Mon, 26 Aug 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646209; cv=none; b=q7AybhwyksWn2qlAu93PYoAr84y8x2Q9IqtjidZi2MylwuR2hFDpLnDUB3FiKCAvychuLC+kqpMYF/Pg8hg6+X0bJGJ2MmNUpqR5ROPFVI6wy+G+UvQTCet4xnRYu6+cKnsaqqpuxNVNniBOWpUQsCZzLmmOW70k9sFgm63UUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646209; c=relaxed/simple;
	bh=AC0J/gaemr58bowZatGs1lVoNaCBAqyQ8IjIhHKBMDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUpXykTpE4qQAhA0X91kGViIu1KV63ZE2LX9Sy9ugPZJhZ58lEp2p3KgUQASbcQaJg9BpKozAa2Uijy8PGOgGoB4s/eobphSOPx5MhU6+kbFdk2VaKQZLxo+fYDKEQrFglKR89qSDJqdPdqxrEHQREMmAeoU7FPoMALuFHHo7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdZIct5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdZIct5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496CBC4AF51;
	Mon, 26 Aug 2024 04:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724646208;
	bh=AC0J/gaemr58bowZatGs1lVoNaCBAqyQ8IjIhHKBMDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdZIct5FgY14f39r9PJTSNx9KWZM02CHokBUpwLEj3RlL9e58paF4dVBckzZYJHV3
	 Rq5eIRwlsMA9JVx7rmU6KVE2QBRe7VRQe0681ySeKXRhDrYtm5mDQf8Nr73WHzKYi7
	 nznJ8ZBcGTrA2bVOlTOZut3J0Vq91mnMV+78qY/Ac31H9HT2jm1gq93wcChHXJbjYX
	 lzbFXb/fiF29oba41xcYRu97hCGizUzeOOnJJyn/YkddZuEW5pUjpNE1lu1wc830io
	 JucMQygfS/WqyYCpygUp0VBAveOS7ul6b9L+sP0KJIEkaoto5R5uMWYdsFWAQ9dVl0
	 EoUnFr0IX7Efg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm/damon/core: intorduce per-context region priorities histogram buffer
Date: Sun, 25 Aug 2024 21:23:20 -0700
Message-Id: <20240826042323.87025-2-sj@kernel.org>
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

Introduce per-context buffer for region priority scores-total size
histogram.  Same to the per-quota one (->histogram of
struct damos_quota), the new buffer is hidden from DAMON API users by
being defined as a private field of DAMON context structure.  It is
dynamically allocated and de-allocated at the beginning and ending of
the execution of the kdamond by kdamond_fn() itself.

[1] commit 0742cadf5e4c ("mm/damon/lru_sort: adjust local variable to dynamic allocation")
[2] https://lore.kernel.org/20240531122320.909060-1-yorha.op@gmail.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index fcccaa9b9d54..6342d8f9b0fd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -661,6 +661,8 @@ struct damon_ctx {
 	unsigned long next_ops_update_sis;
 	/* for waiting until the execution of the kdamond_fn is started */
 	struct completion kdamond_started;
+	/* for scheme quotas prioritization */
+	unsigned long *regions_score_histogram;
 
 /* public: */
 	struct task_struct *kdamond;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 84d9b0fd8ace..be3d05357667 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2019,6 +2019,10 @@ static int kdamond_fn(void *data)
 		ctx->ops.init(ctx);
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
 		goto done;
+	ctx->regions_score_histogram = kmalloc_array(DAMOS_MAX_SCORE + 1,
+			sizeof(*ctx->regions_score_histogram), GFP_KERNEL);
+	if (!ctx->regions_score_histogram)
+		goto done;
 
 	sz_limit = damon_region_sz_limit(ctx);
 
@@ -2096,6 +2100,7 @@ static int kdamond_fn(void *data)
 		ctx->callback.before_terminate(ctx);
 	if (ctx->ops.cleanup)
 		ctx->ops.cleanup(ctx);
+	kfree(ctx->regions_score_histogram);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
-- 
2.39.2

