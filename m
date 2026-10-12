Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF689490BF2
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817291; cv=none; b=hOA6EdUbEjej4SKB/If/l0ZWYt8FCBo6OmSU+QEKZVSBIajXXqqI0a6Nbv7m7Y9wLbO+B03CoD41GFRVYZs5XQ8GZJIRF/V7JjjxODVoWI5idY7dMlMyUBRr9hW90dTmXReCZBoAVOnTEDmyYqCXDB6ZHQym/MYb3H+Derg8aoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817291; c=relaxed/simple;
	bh=EbU1gO6yJ94A+z8nQGttuQSMLXTk5X7Knh3WuN6zpcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS5cm0qVv7TbK3G7agHcH0lL0kBFa7Gvd/VfpRMIuqTUsSlCNs1Ys6XB/KURU6wiPTlnpKTGREJjAxCXu1aSYq7ZRG+9Q1CGqzpA72+NDs38o/uqTxDNniu+oVy8DputliMXwmjkAE9osShE5BuZA5SW1RoYWFDlnYh/FGDKRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=QR82NAl4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rU49rm64; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="QR82NAl4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rU49rm64"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 3E4AC1301223
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 11:01:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 Oct 2026 11:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791817288; x=
	1791820888; bh=A2dc0CGlbxZBoAyOu61oiIE05gV4Aem5ERwND2CKoYw=; b=Q
	R82NAl4hAueURW4BrkP5uX9Q5LWTdk9oJKWEhB05ZzDuCN7F/D2AaAOtccUZrgEG
	HWCDjj+F23YzoUf7msGY0iPOjrYwu0q4dZyOGuK3prTRDPu5v/dZ5Ks23OHRSXKI
	uHFAF5UHMFm/Py092k89qSZdChY2LMq8jybUgIHi6rHXDAUpOLsXXt9d9hUvlKa/
	BC6PUwfyoOsfg6vcshd8Hypssgn2XBEaTfvl8xON3HU92yblOo9zUydc7iNJzG16
	czXPi1Wg87SSnAJ+E+8+Uo9LiUrxhfxJKEJ/bOGj2l/WsdvanMnI3WrGpohGGZZW
	zIrjA6IB47CbL4sT41F4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791817288; x=1791820888; bh=A
	2dc0CGlbxZBoAyOu61oiIE05gV4Aem5ERwND2CKoYw=; b=rU49rm64u2BwUpQVK
	CUgpBrK5YvZBwX3sXHZjH7o7cwRV3uPwKWYxSr8DxAQG+W7C1inIfzbo1KrhDYXU
	GVzNP78vF7R2M+HOs6NgkOHZobTnlt3PeylHu1Ll/Ap5PC8NhVu6Afwg2dE10vru
	qJcx2Y/pqVZEqB/nWW4NhopoGG/50s7B78qGCL6OSwcf8O1oO6pjFDfhs0pCv65X
	P9Uvg8H5iRPfMmBSPE5x7p4cFSkvkcwi77a1uDKxLuUZ9MzH0il/anGQgEHT7PCQ
	E/5umd4b0cuMQ2Uw2KfjWOZ5awpVvaG8N/Z1iQcfcOv4EjaZAcK8zLLXTIOOqLpO
	tLwUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791817288; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:S74UdVLVYymT6WWdxMUZoNKbzFQrl8qVum5t4RZ1uH8eq4O
	Rtp/dH/+vIZUzGDvDQFfnsVugjqO2ud9dtHrNYP+FYD54jOkec6SHAHa5P43fueK
	SrOCDJpEaA/3zaFxhjUsx+mJ0C4E2VMPVyssXmCgzszjT63JYBVtDw/JTtvoJprl
	rLKpo5H70Q27IR/584QeE6S3GM1N9eyp0aKP6hjD9KNYKhffDnoKxTstkaFmXe1l
	Caljv0M4tTU67PiDpB1tPXA8i5DOlQp4+9VBj+64Bl4/Nv2ARRX8A1M7VxjEe8WX
	qRJXfSYVdLB06SCwnI0rbWxiW1S99HeBezhrR6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qrC+U7FgVzXS3foaIrE1i+0g10qzzjJJGgb7e54BLgI=:EbU1gO6yJ94A+z8nQGttuQSMLXTk5X7Knh3WuN6zpcM=;
X-ME-Sender: <xms:SPbMasZQ747EDHkuKnYPh43y8UCv_yNRrhbZujzU3qH3joByo50Xaw>
    <xme:SPbMagu47Oy95erNAiq4yY_sQc8YFcO_2Jcjci-qcDGa4IA5erA2xR-LbvO8DiTGB
    mevCjGZLy73cVWbBx1Id70SftX1RbLObN6Dy5cq9NFoKEaHYutc3whT>
X-ME-Received: <xmr:SPbMauMNvigLVTcdIFrPuLgEOIJu0PfEV6bJ5PNe4aUL82gLHO7IGJ5sug>
X-ME-Proxy-Cause: dmFkZTEHJG3yMNusjUXrxpkU64Fx3XJNDC8KXa3Gw/5AeW0JDaa1mp8OT2rIdRnn1s3ZXL
    KcViY4/t1K+UURBWIOR1K83d5n8eup4ClfBOQJpaoVzRKQQgeaGXJsPyGihxcLBZfDO6b2
    BYJRRcU7+hnR6abTRjKCKEavzSAZBG0zDeq4y1vSczr3/hcYljInDN8m84yk/dO7aqfKWz
    WVVABbGF5d5ZxP2Icv7e9hpf39nenWSNdMl/Yi5Uq1ZVq6+Q04Ss3otTk1rsCyQnoHIGB8
    aQwzwj3X/6V7y8lLvKf94z+E/RAwqH38Vuo6L6myAe0zvJye0yYRoEUPnYhrnThUxXY4cU
    wg0Jnk4JPZE/9Dg95+FPZH7lBO/qsKgMwoSPp8tHcxtkRj/foNmmmJSJtTcpMNmc3LqwwG
    rgt0JEJrboIsLEpY3FzH6Ef51PaP0BC5e5McbbaFk1nKmfZgoBpCnz81lY1IHvnGGE+Kbv
    dOMZ9NtPuoLOrSyBY17MREPLxADmmW60kC6AhsaPhnYt3mcx/6mngLVx6f4SQcnYHP2z2L
    ZnnUFdkH2yGUciZfZIcXsXTYUgoYw8mCDvcuSOQyQkguE9kSgxicEhaS1uSZ3IcG1TttFW
    tP7MT+1fEMjxSjV6q9mWYV4+YYc075N4XkRXBtXiASd/7sjrMeoKwrB+ql/A
X-ME-Proxy: <xmx:SPbMan762U-ODbTFW7-uvnn7RrNNPhq7lZgP-N6cSYPdYIp3U_3GBg>
    <xmx:SPbMakRSDRV6O8D5C3gu4FSx3OieAidmot8Ljbw2Xwke-92Caf2OCw>
    <xmx:SPbMakAjE7y9dvSfNdMQn1jR4ZWhZtcVmdZdfPbm2DF8iP4arfKdxA>
    <xmx:SPbMakFeFTDPes_oZOVXiP4eIqe6FjN0y6FER-oVdBca0E7vRRcPmA>
    <xmx:SPbMaoRKLhJ7hkcTKRx_nRolTKLAbOw-wPHK4MVwyV_OaT3IZZBoGty_>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 11:01:27 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Mon, 12 Oct 2026 20:30:40 +0530
Message-ID: <20261012150045.169377-2-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012145636.168436-1-suhaas@s-joshi.in>
References: <20261012145636.168436-1-suhaas@s-joshi.in>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_split_region_at(), we copy the entire probe_hits[] and
last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
that the number of probes installed is less than DAMON_MAX_PROBES, in which
case one or more iterations is/are redundant. To remedy this, iterate over
only as many times as the number of installed probes. To do so, accept a
struct damon_ctx pointer in damon_split_region_at(), and update all
invocations of the function to pass the new argument.

Also update damon_test_split_at() and damos_test_filter_out() in
core-kunit.h to supply a context to function paths that call
damon_split_region_at().

Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
---
 mm/damon/core.c             | 42 +++++++++++++++------------
 mm/damon/tests/core-kunit.h | 58 ++++++++++++++++++++++++++++++-------
 2 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bebd2889c2c8..2677fabc9c29 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2051,8 +2051,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 	return sz;
 }
 
-static int damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r);
+static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, unsigned long sz_r);
 
 /*
  * damon_apply_min_nr_regions() - Make effect of min_nr_regions parameter.
@@ -2077,7 +2077,7 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t) {
 			while (damon_sz_region(r) > max_region_sz) {
-				if (damon_split_region_at(t, r, max_region_sz))
+				if (damon_split_region_at(ctx, t, r, max_region_sz))
 					goto out;
 				r = damon_next_region(r);
 			}
@@ -2474,6 +2474,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 /*
  * damos_skip_charged_region() - Check if the given region or starting part of
  * it is already charged for the DAMOS quota.
+ * @ctx: The pointer to the context.
  * @t:	The target of the region.
  * @rp:	The pointer to the region.
  * @s:	The scheme to be applied.
@@ -2496,8 +2497,8 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
  *
  * Return: true if the region should be skipped, false otherwise.
  */
-static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region *r, struct damos *s,
+static bool damos_skip_charged_region(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r, struct damos *s,
 		unsigned long min_region_sz)
 {
 	struct damos_quota *quota = &s->quota;
@@ -2525,7 +2526,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 				}
 				sz_to_skip = min_region_sz;
 			}
-			damon_split_region_at(t, r, sz_to_skip);
+			damon_split_region_at(ctx, t, r, sz_to_skip);
 			skip = true;
 		}
 	}
@@ -2583,12 +2584,12 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		}
 		/* start before the range and overlap */
 		if (r->ar.start < start) {
-			damon_split_region_at(t, r, start - r->ar.start);
+			damon_split_region_at(ctx, t, r, start - r->ar.start);
 			matched = false;
 			break;
 		}
 		/* start inside the range */
-		damon_split_region_at(t, r, end - r->ar.start);
+		damon_split_region_at(ctx, t, r, end - r->ar.start);
 		matched = true;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
@@ -2781,7 +2782,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			if (damon_split_region_at(t, r, sz))
+			if (damon_split_region_at(c, t, r, sz))
 				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
@@ -2828,7 +2829,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
-		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
+		if (damos_skip_charged_region(c, t, r, s, c->min_region_sz))
 			continue;
 
 		if (s->max_nr_snapshots &&
@@ -3665,15 +3666,18 @@ static void damon_verify_split_region_at(struct damon_region *r,
 /*
  * Split a region in two
  *
+ * ctx		pointer to the region's context
  * r		the region to be split
  * sz_r		size of the first sub-region that will be made
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r)
+static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, unsigned long sz_r)
 {
 	struct damon_region *new;
+	struct damon_probe *p;
+	int i;
 
 	damon_verify_split_region_at(r, sz_r);
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
@@ -3685,11 +3689,13 @@ static int damon_split_region_at(struct damon_target *t,
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
 	new->nr_accesses = r->nr_accesses;
-	/* todo: do this for only installed probes */
-	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
-	memcpy(new->last_probe_hits, r->last_probe_hits,
-			sizeof(r->last_probe_hits));
 
+	i = 0;
+	damon_for_each_probe(p, ctx) {
+		new->probe_hits[i] = r->probe_hits[i];
+		new->last_probe_hits[i] = r->last_probe_hits[i];
+		++i;
+	}
 	damon_insert_region(new, r, damon_next_region(r), t);
 	return 0;
 }
@@ -3718,7 +3724,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(t, r, sz_sub);
+			damon_split_region_at(ctx, t, r, sz_sub);
 			sz_region = sz_sub;
 		}
 	}
@@ -3750,7 +3756,7 @@ static void damon_split_some_regions(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(t, r, sz_sub);
+			damon_split_region_at(ctx, t, r, sz_sub);
 		}
 	}
 }
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 385d32901650..61ce085549a6 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -141,6 +141,8 @@ static void damon_test_split_at(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r, *r_new;
+	struct damon_ctx *ctx;
+	struct damon_probe *p;
 
 	t = damon_new_target();
 	if (!t)
@@ -150,13 +152,25 @@ static void damon_test_split_at(struct kunit *test)
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
 	}
+	p = damon_new_probe();
+	if (!p)
+		kunit_skip(test, "probe alloc fail");
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		damon_free_target(t);
+		kunit_skip(test, "context alloc fail");
+	}
+	damon_add_probe(ctx, p);
+	damon_add_target(ctx, t);
+
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
 	r->probe_hits[0] = 7;
 	r->last_probe_hits[0] = 3;
 	r->age = 10;
 	damon_add_region(r, t);
-	damon_split_region_at(t, r, 25);
+	damon_split_region_at(ctx, t, r, 25);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
 	if (damon_nr_regions(t) != 2)
 		goto out;
@@ -175,7 +189,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
 out:
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static void damon_test_merge_two(struct kunit *test)
@@ -1799,6 +1813,8 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	struct damon_ctx *ctx;
+	struct damon_probe *p;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	if (!f)
@@ -1818,28 +1834,42 @@ static void damos_test_filter_out(struct kunit *test)
 	}
 	damon_add_region(r, t);
 
+	p = damon_new_probe();
+	if (!p) {
+		kunit_skip(test, "probe alloc fail");
+		damon_free_target(t);
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
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, f, 1));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = 1;
 	r->ar.end = 2;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(ctx, t, r, f, 1));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = 6;
 	r->ar.end = 8;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(ctx, t, r, f, 1));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = 1;
 	r->ar.end = 4;
-	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, f, 1));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
@@ -1855,7 +1885,7 @@ static void damos_test_filter_out(struct kunit *test)
 	r->ar.start = 2;
 	r->ar.end = 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(ctx, t, r, f, 1));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
@@ -1868,7 +1898,7 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_destroy_region(r2, t);
 
 out:
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 	damos_free_filter(f);
 }
 
@@ -2458,6 +2488,7 @@ static void damos_test_esz_goal_temporal(struct kunit *test)
 static void damon_test_last_region_quota_reset(struct kunit *test)
 {
 	struct damos s = {0};
+	struct damon_ctx *ctx;
 	struct damon_target *t;
 	struct damon_region *r1, *r2;
 	unsigned long min_region_sz = 1;
@@ -2484,7 +2515,14 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	s.quota.charge_target_from = t;
 	s.quota.charge_addr_from = r1->ar.end;
 
-	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		kunit_skip(test, "ctx alloc failed");
+		damon_free_target(t);
+	}
+	damon_add_target(ctx, t);
+
+	skipped = damos_skip_charged_region(ctx, t, r2, &s, min_region_sz);
 
 	/* 'r2' is not processed, it should not skip */
 	KUNIT_EXPECT_EQ(test, skipped, false);
@@ -2493,7 +2531,7 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, s.quota.charge_target_from, NULL);
 	KUNIT_EXPECT_EQ(test, s.quota.charge_addr_from, 0);
 
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static struct kunit_case damon_test_cases[] = {
-- 
2.55.0

