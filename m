Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3E3D348C;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810962; cv=none; b=tdbNnf6lChVvjKylXusOsWjvRuGyD+kZLXNxNwjURnQpBOy5K6j5D0ca54Gj59b7kwJKqI7rq9EJtxhpSoPqF9Az5nt7QvGuH4CGNYJ0fQVyjeY7+66KRvuZ+z1uyucZRTZcisWjxvnfcyihTRnIUdUoMBXxDaXzzneZM6ZhqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810962; c=relaxed/simple;
	bh=BNmBp855yDuZHxGokx46EelosP2pYBbR2PhSTdYtR0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyR2O4L0g59RY6Ej4TOiKzqi2JpwogWuCG565L5gQ13fpFx9BIf29E4dAW3XBxFSBeI6P5MDhvYQnbYnidv0fuZJ2RpCZ/lVKMjqF33NuGaRS+95/EK+wwRn4TM+9ykLBpErI+TnfgJY1VAeSxDHnv992jByvXMFyynz2QOPaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDEspnsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDEspnsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576B0C2BCAF;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810962;
	bh=BNmBp855yDuZHxGokx46EelosP2pYBbR2PhSTdYtR0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDEspnskaNEi9nA0EiGpws7eiJ4ZKcOygic65UXT0LnFrQTn3lBb6SH6fraYsS3mv
	 0WFYE4+sedwEG7jybwDPXo/ta3KY7kGYO/X5RJEVMlSqsbDh0X81GvkbewH6Ycv4fB
	 ENyIDVPA7gBCOnsI1X4kaA5StvU/XR2i3q7G+V8RCzTPeR5ertDm0HJ0u9fjkQzOF8
	 80jhLQgmROa1oz4tIHOkQjlTA8dxZzosw9XYeOxjyeGZT7h/rBpwhdTx4Go1lEf8Vb
	 f1rVcaQasQLhQ3PGIFBoCwO+lMg23DH7zixHH4JVollqyr2f3mxhfQXG6zXkqZLNTQ
	 ZjercEiL6RlmQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/10] mm/damon/core: add damon_new_region() debug_sanity check
Date: Fri,  6 Mar 2026 07:29:05 -0800
Message-ID: <20260306152914.86303-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_new_region() is supposed to be called with only valid address
range arguments.  Do the check under DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f1a97e85824ac..0c1353164ec81 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -109,6 +109,17 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	return err;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_new_region(unsigned long start, unsigned long end)
+{
+	WARN_ONCE(start >= end, "start %lu >= end %lu\n", start, end);
+}
+#else
+static void damon_verify_new_region(unsigned long start, unsigned long end)
+{
+}
+#endif
+
 /*
  * Construct a damon_region struct
  *
@@ -118,6 +129,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
 
+	damon_verify_new_region(start, end);
 	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
 	if (!region)
 		return NULL;
-- 
2.47.3
