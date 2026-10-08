Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99884D5964
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472826; cv=none; b=qgsm72u8xNbJ+ILQ+lTISH9uyOSXm6jAJmIRbOb4lYPR5SBd/mc+HOplFiyJlnOxS2zF0uBGPMgL6Rl5e/R8hK36Wo8vUkog2f6P54kkZ4woSgHIDRKEKg3OgMyc2tQpyhK9I9Fbq/9FO9PM2FU0saKNuW0SJc+E9tkVEGzLwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472826; c=relaxed/simple;
	bh=e7ERreKHiOOv9CSbIXDAbTuNf1BLAP6Jhju1J1ZFDKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsU9Qw/gtgkYbjHiU6lC6u8DMg2mH85D02VawJ85vVZXPx3+8vQVi0m4KFt7Poda0OHa/9FIeGC71SXG6mQE/xrEQNAGqwenl75DZu28kJxOwgg21hzep8JokqnBtPHg02RQ0ww0xXO+Rwc22EALq3oIorCSio+l/o2+dOTDBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=RJ+trGLF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJqmRJjn; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="RJ+trGLF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJqmRJjn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 86BB013804A1
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 11:20:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 11:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791472815; x=
	1791476415; bh=Ta9VTltlWRdF05/D8b/khNytMzX4AxfIKyly2vVwptM=; b=R
	J+trGLFiHc173kC7Y1WekkcSfFYMjB2Kw3FAXstAkHS5IcebYuZpeOyTTmNU6o7G
	qUnM2HSKTL9zUjozl5dG10KYoJwgcwYvNs/BwA/tlTexTr70fJN3fp7O3GtZW0Td
	VmIF+SE6Z4zdKXJNLydYlRbCC+O5mbT9CJmAgFhbzbp3n25i1Abz/AfFJc76NiZg
	KOVKrIHDnAOo8aJLT2v5Z6ME56xYGWPOIuqEkzEbVaoEWfN524j/W/3p2wBmDh+4
	Plj0GsDclBXkbuCv0VplqP9Mc0q56YUKx5HdgEQhHvSiUqZg30IEyeszTMKRb+D8
	U9umTXGu38CPZPqbJYHiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791472815; x=1791476415; bh=T
	a9VTltlWRdF05/D8b/khNytMzX4AxfIKyly2vVwptM=; b=mJqmRJjn+LkKdYB9o
	1JHl/NWqScBzwIygC1qBFlZcM/dQfs6/LLNwGq3STaTr/A14pPlFMgWbmGOul3Z2
	MD2C8C6YaIsV3Vllt9oWi//kDsP06zmf58IRAo2gtrwxv4BYdqgip7Mcsz6puW6f
	v6vraqFJ2YcT4gkHCzItTKucIrZqW+abQCPpZ2gMd8c9VDp7lAvkU+R05K3SLhL+
	j9gAdS3WG/l41gz3iSYZ6CR7RKoqX8e0fAanc4m1QxxGIPEAGyQiIRio0SsgetYO
	iDzzVSzMad/JtjKkYtVJjmArd19Bg3aT3A6UPKCyhk9hrovmspemqnQOLCFEL1tm
	sfMUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791472815; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:bX/fQkdVBnFURmwKBru6DKOEueVqsmTDzDAuDqt1kj5+4T1
	9LmzXVYeAhByLOwwU/Zb0ERpcGGLaJ1JGc2+6s+vaP0mdUKVkV2c753N2r60uX6l
	VjlXmTX2vCFmUb3QlVSXsShEqhyCw26yY9mybjHSJKWagVYtpUrd/YbOHYZHdybf
	N986j7DSFn9l64trSG6SJyWcNnCGa0cxg0oGhG6ZliZVluYt8dDD1rbmBDFgxNJ6
	L0p9/6CE/kl44l0Ff9GPUBzEHwCXmPE7ssZgi7WGfHoV7Zv+0sz17v1ZSpGzKhjX
	TjYPEpjqBfPOsiOX+MCoq+/DpLBJnB6xLUsnJ4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GjaHNlPQHdzpUjaVVm1nmoHkaMenMqF0aN9KzBEuPFg=:e7ERreKHiOOv9CSbIXDAbTuNf1BLAP6Jhju1J1ZFDKM=;
X-ME-Sender: <xms:r7THappW6IywW8HuOcK6XZ_s_y0cLf8D_cBLBocUrXQ88uxtOuVyqQ>
    <xme:r7THasWpYq15Lv5drFyHy5JRYDU7eq4ioTXjCPssCrnQGEDFfA3ZMmpJ6OFEc7j-M
    ZD1YuCB1Wc620EZHhM9nwLKV5oJK9ZPfBGkBg66HftcXaJzfWYtg_Co>
X-ME-Received: <xmr:r7THakYb2hba3agwsl6SGfbXcYDXjBeopfxrc7JxnQnB-RYAMBzuvoejYw>
X-ME-Proxy-Cause: dmFkZTE7Rb351G0R8SPI91T2ULiEwlsWaSN0SYjxpqHcExmMqEBVpkcJrRJdtJYJv0xU9X
    mb2RVMnxHNqAcNDo0PQgX8Lp9vq2778ObHCahwNLqEH9FxhpVir/PFIr7l2E9Hx6MFqLXZ
    fARGPVZeIUqGpiI3+4b5Mm/xAFVjCcMzfzuwKfi06QinMULzduJn8C2+CQuL1rIP7yqnw4
    6M0HZNMimgzR1Y6dUDEkpxDXLLw4pfZCCtmAls7/jI5s13b3FjAljq4c7HgfsbIf6lJK+Q
    iztD5x0JRhOi0JS/SAvuePtt6oApHrxq0VRFSciMrMdopwAYZSijolYnG2EH+6Foxnf7IL
    pyiMM/vZDikrJMxTNd/DOMWfp+R7EUZOiDsw3DHseoDDm25sWIkcyCtDPjsimSiyglO747
    gt9tz/vy/YmFObIeEoegd9cwbeHJ8skPanrdTWlX3+I8EZf5Hp4HkwZldt+uIv1szF1zAO
    ZAHkwe5PUpeIlPHhYasGMU9hkVYH1UCvt6FOHerscM3Uj55rRAp/+g1vu+SaEWoIwpaWAT
    dyafXRlvg1+Q4PLkNAIViuJ8/4cPFxMJST6ni4jsSQ+LYCUX9hF3YtTv22wlhTJpqPCZvl
    CvtxlLr09d/5bmQ2rGTrf2faDjrywWyH+vY88pEj2GSXJW6iPifDOeZR5OQg
X-ME-Proxy: <xmx:r7THapfgM9pdLtjlCCC0Cjak3uzUmFgaaC2M7yYGSUIdWHkisy_hHA>
    <xmx:r7THau2l7PQSk-d5yGK_olQMGcZOWbw187JOoy-HyrdWXPL4d9hhYQ>
    <xmx:r7THagKPuvAFTYEtiqAsVAq4C6eoYSfOUcL-gLtifWbLgGVHTeLXOQ>
    <xmx:r7THatFtT0HZkRmHpc8x3_5imTDX7O0VgI__wNHNP5NR22Us9TliIg>
    <xmx:r7THav9wo9cNfVkSin9GLWmD2c59Xsi_KN3ya9T_Hivulgf_kuSFeN1k>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 11:20:13 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Thu,  8 Oct 2026 20:49:25 +0530
Message-ID: <20261008151944.113714-2-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008151944.113714-1-suhaas@s-joshi.in>
References: <20261008151944.113714-1-suhaas@s-joshi.in>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 mm/damon/core.c             | 16 +++++++++++-----
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++--
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef8990..fc202f90991b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3524,20 +3524,26 @@ static void damon_verify_merge_two_regions(
 /*
  * Merge two adjacent regions into one region
  */
-static void damon_merge_two_regions(struct damon_target *t,
-		struct damon_region *l, struct damon_region *r)
+static void damon_merge_two_regions(struct damon_ctx *ctx,
+				    struct damon_target *t,
+				    struct damon_region *l,
+				    struct damon_region *r)
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
@@ -3590,7 +3596,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 			goto set_prev_continue;
 		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
 			goto set_prev_continue;
-		damon_merge_two_regions(t, prev, r);
+		damon_merge_two_regions(ctx, t, prev, r);
 		continue;
 set_prev_continue:
 		prev = r;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ef146ca2ae8a..4e380c6c5eb2 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -182,13 +182,27 @@ static void damon_test_merge_two(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r, *r2, *r3;
+	struct damon_probe *p;
+	struct damon_ctx *ctx;
 	int i;
 
+	p = damon_new_probe();
+	if (!p)
+		kunit_skip(test, "probe alloc fail");
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		kunit_skip(test, "context alloc fail");
+	}
+	damon_add_probe(ctx, p);
 	t = damon_new_target();
-	if (!t)
+	if (!t) {
+		damon_destroy_ctx(ctx);
 		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 100);
 	if (!r) {
+		damon_destroy_ctx(ctx);
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
 	}
@@ -198,6 +212,7 @@ static void damon_test_merge_two(struct kunit *test)
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
 	if (!r2) {
+		damon_destroy_ctx(ctx);
 		damon_free_target(t);
 		kunit_skip(test, "second region alloc fail");
 	}
@@ -206,7 +221,7 @@ static void damon_test_merge_two(struct kunit *test)
 	r2->age = 21;
 	damon_add_region(r2, t);
 
-	damon_merge_two_regions(t, r, r2);
+	damon_merge_two_regions(ctx, t, r, r2);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
@@ -220,6 +235,7 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	KUNIT_EXPECT_EQ(test, i, 1);
 
+	damon_destroy_ctx(ctx);
 	damon_free_target(t);
 }
 
-- 
2.55.0

