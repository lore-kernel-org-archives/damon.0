Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13189547054
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388170; cv=none; b=OnXTFUV+ol5R5eQ8f9D98Ry9BMr7jZaibWIUnyG4zShusPFb7zcyjTuRFs20WE2RC0v7cEeAvi2JKeS+pt/TbtRumydGwEz2A9AuLqVEwYhXh3/jozXu+tm6SfSzt1JowxrFU/TVzyg5I/FHyY+O6/K+r0ByiuFIwKCr1+6ei7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388170; c=relaxed/simple;
	bh=U4HmHSxVFFuQSU3OfTxOGyFo8y7V326X6U+5KdSx1MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll5rcmRTEqLTC3CezULE8cAgJTVA40rDPXQAZn4iKEhzMbg9ikndLhKzMsmk/5UeiU26Pw3igDCBSAET0TAe3YPmkbDPGfA70fCSYVz1A8/B7POjUX8xux0DueJV2igUx4AeayQn3Fvi4DdZYmRPnuMxt64AYaMG9x0LVhX3jTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=cNdDgE2x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxEQk+Mu; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="cNdDgE2x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxEQk+Mu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 0080B13800F8
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 11:49:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 07 Oct 2026 11:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791388164; x=
	1791391764; bh=rAA0a4If2ZULLyjulfk+2NY5Alwb5J7HFWDXTowfvDc=; b=c
	NdDgE2xjNRaJ9IDnzquHqy7rTkagbJVsxAiKGt0muVnNUWv+Ll7S7chJwKSUfJm+
	6ZTVNJ9JPA79k3erjT8jj049ZJRvChSSyqtRj3itFSC3RTT1lzxjKxYGZpDknYZb
	oRu8ItGpUrkvVI31KNo9C+opsO/hy1q6KnQcGb1Y+hwCb5D5E8/C9ziovNziSk8+
	nYhE2WHawtcMqg5Ck2eSc7SQ+sZj8j0jCv+72BJj14mA8PpwJ+SpuXrBHBVYqTrH
	8769Wbw1UmXFEwIONvQF3hkq5aZg0QOgHnVBlHpeLHrPlb1aVGKazYg9tc/hHrda
	KRujsTVCF2eUVX67jNqyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791388164; x=1791391764; bh=r
	AA0a4If2ZULLyjulfk+2NY5Alwb5J7HFWDXTowfvDc=; b=MxEQk+MuZ8+yi2Tya
	6DUZcS69novp6zjjC/9DP/Q45xJChKeOjv8Z2xEwql0Wv+rgPXeKBSfPXLH0hlk/
	bTF1W3aUUTvs2W7bTvGkmZpi8ieqJlByi/Eccus4mX9XxERyivWU3kbN/7QWvzb4
	BycjMVSVUy7mBtf6zp8QEQ6qoNxGjFyFEutYKUThdk1/aBQ3stBoTHxPR3axgxEj
	PO5hkd2NUrLtL3s2MyYO5w5dXz8VuZpK4M2A0R4yMoRicB++KRd4XUY6LLeyJUaI
	LyaZhZRTZbV6nCo22+6PJDjUbqJAdD+4l1dSu4kmO2/udtN7ZiWjOnxcePTutnEr
	BoJQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791388164; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:oq0DrHFESLTZwxdfR8Z8jNeCD6Au705Bo8giv1f3WzTQfy7
	nfz+Dg2YrbVAj4wXfAVFYuSLMFZuMLMj/mV+yDZfwoJnCg/chVeX8BgF3bvEHloX
	4nfnGT9nrHkpUaukfq5gyvOuXhK/nwDTmMJSa6qye1Gfk2Q/pmZUZkvbNs7iT1I6
	Y9CIa+SCHuI2mC37duyCSZIk+cRPtvzpuCYvBO1aovcx6e43EfR0J6yB30/ofZv9
	q4Jwz1Uta+NCLr54RaCrCGeCXO2kyS1gCnu2JQ4zApeJpUSARCpTdod1/gy4a5Is
	PnXIT2mja5MK65bmwaXbMXPfRVx3sMmd/xOo+4A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:x5XYbiwxrWypdSPtOtM3/+vgHgxhWNxQYC4expaSDRk=:U4HmHSxVFFuQSU3OfTxOGyFo8y7V326X6U+5KdSx1MY=;
X-ME-Sender: <xms:BGrGak3zxvPqph6AN2SDjb3hQwiZPgunUdsTW4wHXMDLbp7xVEjvvQ>
    <xme:BGrGaoY1Nn_Cdnf_CNuJpVGA5uDNMaT17M-WNhwoa0tbRI4y3XTU1aErB0Kzzzgmd
    sqW0Y9z510SmF169WhB5_UHRBjHHf4TDwJdNqRf6zLf932IrJgV4MM>
X-ME-Received: <xmr:BGrGakL9KNBLqZ9TSRs25Ax8khOPKZFmcsKTqN0FTRG32OwJbw-taLvnPA>
X-ME-Proxy-Cause: dmFkZTEBaUDDO6ngTf2qaoSnvem6liDvuhKl/9yQVpKqZxwy4l1eqKxf+EyLhO58G5o0Gk
    FCVZ5dgt+2a+9WSMNk6P1NC/alZr9x3nei1HF3ulSpjUgDRWm3MOfiENnwy+bbJnNFqBv6
    01JjNYluYE02hPPSGuQvtWjRl4n20jQ98HoA3X45Z/VIWCArdnL60YadLRBc+c9Y0G+ABZ
    CKUZ3Lv3++BdVjZn1l3etwpTvSpv9G6XBVnQOcuLLi0b/OpnpZAFrIIuZDZQXHaaNKuDUo
    8HvPsQHd4nffXMvs7XIOg/J6/2EI+tKqpbMZB4s1+BkZ0nB6uTNWeGWijEEeSu74c8NTIL
    mqhMblWm3HHwz/CI8IgxXCOHsD0X/e1UnhLUebngiWpyQPQP98LawVvjVF+9gK3dDpxokY
    cQRSpT1Cik1hTDVrC9Oj34vK0/jkFoOhFoOM5dN8gXeZhtmn6BBN5SkXjKfOvVG+plTlJx
    wlmIJiyI5CBM+M8sh1qMPbA5TOi6meNRMRHH2kVhiJyuDoKaPxbikKUbAWe7ga33Ch3hvF
    ezdJXZ09hgclHvd4ZiTIehqzpo5iB8dgCcvvW6DSkjw1ycsd+YlJBZ393CI3BjC93JC4gu
    fSZD94awwy/+mvodZU+dvmfIHK10mw/Mzi9gxEFtDAN5715GDBMdKRF/C4XQ
X-ME-Proxy: <xmx:BGrGavE_BblGMJfyq1mPKj4NkftCuFUDOkXMs4XStFCbrfzfeOVZ5Q>
    <xmx:BGrGajs243zjH9EYNpNfDoPOXJJ5y_PwAzmKDL9agcrVBIjrCh9YPA>
    <xmx:BGrGamsdqXYpcVjxZ52ImGLZ2-0oa3E-vrUOYhVxhHqZNVBgJdvUCA>
    <xmx:BGrGapCEV0pbUTOo_JqKBXJhssx9UBH0iKKpg-_TL30lXrH4UxZnHw>
    <xmx:BGrGaj-J3NeKTI4lJqde7w-G5geW2_UUZT8u3N3zFV2bc_xOE-A8COzf>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 11:49:23 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	suhaas@s-joshi.in
Subject: [PATCH 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Wed,  7 Oct 2026 21:18:45 +0530
Message-ID: <20261007154851.45368-2-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007154851.45368-1-suhaas@s-joshi.in>
References: <20261007154851.45368-1-suhaas@s-joshi.in>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While merging 2 regions, we iterate over the entire probe_hits[] array,
whose size is determined by the DAMON_MAX_PROBES macro. It is possible,
however, that we have fewer probes installed than DAMON_MAX_PROBES. In such
cases, we end up making redundant iterations. Therefore, to remedy this,
iterate over the list of installed probes instead of iterating over the
entire array. For doing this, start accepting a struct damon_ctx in
damon_merge_two_regions(), and update calling functions to pass this
argument.

Update the damon_test_merge_two() test to use this new signature for
damon_merge_two_regions() as well.

Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
---
 mm/damon/core.c             | 14 +++++++++-----
 mm/damon/tests/core-kunit.h | 19 +++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 733025b36745..a3af5ee685e1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3499,20 +3499,24 @@ static void damon_verify_merge_two_regions(
 /*
  * Merge two adjacent regions into one region
  */
-static void damon_merge_two_regions(struct damon_target *t,
-		struct damon_region *l, struct damon_region *r)
+static void damon_merge_two_regions(struct damon_ctx *ctx, struct damon_target *t,
+				    struct damon_region *l, struct damon_region *r)
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
@@ -3565,7 +3569,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 			goto set_prev_continue;
 		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
 			goto set_prev_continue;
-		damon_merge_two_regions(t, prev, r);
+		damon_merge_two_regions(ctx, t, prev, r);
 		continue;
 set_prev_continue:
 		prev = r;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index df84d9cc7d20..5ad89c1d9fc2 100644
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
@@ -206,7 +220,7 @@ static void damon_test_merge_two(struct kunit *test)
 	r2->age = 21;
 	damon_add_region(r2, t);
 
-	damon_merge_two_regions(t, r, r2);
+	damon_merge_two_regions(ctx, t, r, r2);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
@@ -220,6 +234,7 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	KUNIT_EXPECT_EQ(test, i, 1);
 
+	damon_destroy_ctx(ctx);
 	damon_free_target(t);
 }
 
-- 
2.55.0

