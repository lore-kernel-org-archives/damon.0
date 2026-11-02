Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633881;
	b=I4EOjGVrykKmefc+VoXaVjX40IKS9mSNx/0AcDJ13ocIHXIER0fmX7p9ELGZBcttx8y9
	 B1AruJl0FPmCsGWethJZAyp/3fp6WVa2acVCVqguE+HAZNYYSIE+vD76WJZihocLGuiZd
	 aajJZfqy83LtKT9SHqyl/w84ruH/9cMUqc430tuDkYgx+aGDTZ7kMIoFX1u7WPtxOccQ0
	 UVgBwISyP8VNHOqvxt1gWyOyylWLB+IkYsQCyOaNx/pEhF4HerHNbZkBPqXbNd+S6pR1/
	 TMWZLlxErjtFMz+oz2mXdjrT6UbSGdWkye2NYvJ15cuQBLGygkjYHBv1nDxHQEfqw3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z+MgUCfG+V3Anb7erI6rfwRs5z2tWPjnS6eSgen+Zus=;
	b=ueLxnQVFNuej829EhpetqssjX/xbsL5dV03jUWyYIbAyTwi5Y2MGQ4kfBdeTS3L4yeis
	 CKSb8RhtwRWd2fmfTTXywtvSFW8vhxnxoFfF20QF+EVKU7FmYjgULYkVp/c0BL5CC/lt/
	 Dc0y4cIpCeConnuVLDUS3YOI1O6vWWqDcTfV/Gsv7tQWnjD711/dEWH0tmewCA9dkos7/
	 T+M95Lwbqv+GkScBTVx3ql12LDHwSiMn8l2wvmqLbQdpHcRtrTA0THf7YTkioOkqHNX7n
	 ZHk8lO1knK2X49TNsFi8e+JQMWahImr+18ZwdEs1IFvqMxHAW+BnnzAvG/Ne4V7DGtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1H9ljGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C1606BA7F;
	Mon,  2 Nov 2026 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1H9ljGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2483A1F00A1A;
	Mon,  2 Nov 2026 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633881;
	bh=z+MgUCfG+V3Anb7erI6rfwRs5z2tWPjnS6eSgen+Zus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F1H9ljGUVASadIr5+7Ym9zRdT/V/czLIDX4/2uWxB9FZtwDQZ67p8KfWpgs2fc1uA
	 4un8fUuEUxQPP5KYjV/e4cqrGf9Ppv6EitIT/zLprpTAQb64ZDulF+Q9EUfQ9WIzZL
	 aA6vhbj85DBX1DdquyrEEOp8H2M9lmYHa6kpcP7u2igeE6YjWBuzuGzqi4x6v6CQmf
	 H/6VTppz5j7PRUutHzYdBOHpLgZidYmnAaj2gV3O5pTxEDLLESmZA/UurAaG5oXAdv
	 JQQ5ia8DOe3mZeFi9UbE3GESeNv3dcIC12jZ7MppLPfNj4tLcS1N0/i/JwxiT9UASz
	 AXgkcf5xQxzrA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suhaas Joshi <suhaas@s-joshi.in>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 1/2] mm/damon/core: use only installed probe in damon_merge_two_regions()
Date: Mon,  2 Nov 2026 07:37:51 -0800
Message-ID: <20261102153753.97769-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102153753.97769-1-sj@kernel.org>
References: <20261102153753.97769-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suhaas Joshi <suhaas@s-joshi.in>

While merging 2 regions, we iterate over the entire probe_hits[] array,
whose size is determined by the DAMON_MAX_PROBES macro. However, it is
possible that we have fewer probes installed than DAMON_MAX_PROBES. In such
cases, we end up making redundant iterations. Therefore, to remedy this,
iterate over the list of installed probes instead of iterating over the
entire array. For doing this, start accepting a struct damon_ctx in
damon_merge_two_regions(), and update calling functions to pass this
argument.

Update the damon_test_merge_two() test to use this new signature for
damon_merge_two_regions() as well.

Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 15 ++++++++++-----
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9d54899004026..36d60f3e1de62 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3549,20 +3549,25 @@ static void damon_verify_merge_two_regions(
 /*
  * Merge two adjacent regions into one region
  */
-static void damon_merge_two_regions(struct damon_target *t,
-		struct damon_region *l, struct damon_region *r)
+static void damon_merge_two_regions(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *l,
+		struct damon_region *r)
 {
 	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
 	int i;
+	struct damon_probe *p;
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
-	/* todo: do this for only installed probes */
-	for (i = 0; i < DAMON_MAX_PROBES; i++)
+
+	i = 0;
+	damon_for_each_probe(p, ctx) {
 		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
 				* sz_r) / (sz_l + sz_r);
+		++i;
+	}
 	damon_verify_merge_two_regions(l, r);
 	damon_destroy_region(r, t);
 }
@@ -3615,7 +3620,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 			goto set_prev_continue;
 		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
 			goto set_prev_continue;
-		damon_merge_two_regions(t, prev, r);
+		damon_merge_two_regions(ctx, t, prev, r);
 		continue;
 set_prev_continue:
 		prev = r;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 43e2f950f8ff4..ca10d450f7e23 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -182,6 +182,8 @@ static void damon_test_merge_two(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r, *r2, *r3;
+	struct damon_probe *p;
+	struct damon_ctx *ctx;
 	int i;
 
 	t = damon_new_target();
@@ -206,7 +208,21 @@ static void damon_test_merge_two(struct kunit *test)
 	r2->age = 21;
 	damon_add_region(r2, t);
 
-	damon_merge_two_regions(t, r, r2);
+	p = damon_new_probe();
+	if (!p) {
+		damon_free_target(t);
+		kunit_skip(test, "probe alloc fail");
+	}
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		damon_free_target(t);
+		kunit_skip(test, "context alloc fail");
+	}
+	damon_add_probe(ctx, p);
+	damon_add_target(ctx, t);
+
+	damon_merge_two_regions(ctx, t, r, r2);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
@@ -220,7 +236,7 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	KUNIT_EXPECT_EQ(test, i, 1);
 
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
-- 
2.47.3
