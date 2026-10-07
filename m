Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF10547054
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388173; cv=none; b=jxZIjOyQLpiDdYgjQWkXmmvusWQv9HlVSxtnfpgH3WAf+ki/18JPNvzU9aNqZOeUm4qmMjQvyaJdvCllqjrtcYfFKWBFoNlyGmfhwISPbbQCY2v5MpeqvoTtEowc+sarFmusRdxpAn2qAEzU4pILpYEK1kuZ1avHeaShNKDc9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388173; c=relaxed/simple;
	bh=SJ85HzI3nnTUKBjbG9eDMxU8wMh9OyTklgMqk6xA5BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKaYw8jOGvxtYi4frOpW4bpkgaktPUW6qTXOMtsId8mWorsjnIcBcLEOPE81ccD9Fo3+Zq0iBHOjBd6Yc2vH70smCTFHlGoGxztHjnUiwzbOiSQEPP5Mr9ESYrvAZHZMTYbFwb86gmv0G4xgdlQcWGzQ/dpWZ/azysYwjxQQBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=JpmXNUyD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYuZ+sQs; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="JpmXNUyD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYuZ+sQs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 81A4513801CD
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 11:49:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 07 Oct 2026 11:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791388169; x=
	1791391769; bh=NMzj+0i9NThcJ6q8TSEFs4eoC4MBdtZJg2mYQDdAvN4=; b=J
	pmXNUyDSsiJ7zfYJSF18AGNLAXDcZGSTWvdFh4QCGsJqlEhBgQzq96UhPWD0e7TY
	oXCnD4EFGVS+SKN0DInYQytBIS91/AyWWJIWZsmOeIrofGs1tEq2aTCXasvqFEFx
	ACRzIU11zHOHb+Q/7J5TbBSBvdCGH3uP5EAWcxTM0154zgGOF8B5sInp84kYFXTj
	evNPfZQ+CQWXjVTXzNEIETppTNRxav+NhWn3Dqxv2K2+X1LhSLEeuTiiqKjgql6s
	qaZjIwaG/+fPgm2UPqtq+jCOttheQJSFrTpkEwrE3MHvbOhUbNsj/rwyjdvONNjO
	zgbeDTkI3o+kSKsx/wKvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791388169; x=1791391769; bh=N
	Mzj+0i9NThcJ6q8TSEFs4eoC4MBdtZJg2mYQDdAvN4=; b=OYuZ+sQsFEMkdvZLP
	HixoehhJYyLOlut2GRlKP5wQof4f7mC4KjRJr/JE+sSWuBu2uNOgZMBsJHmaHdKw
	0WGb0+cZIc03pSuxbioU7HlBa5uQAaOyWjFdgiU0lCzB9OipFUOzbzngdczfK2Sn
	3Saixd5HOptRMKvPnjE9ylL8CZHMRCc8AvwwFFegF2XZgGtenueOu4iZ/gvPCZAv
	0CTE5IauN3U8Y5Kgk3hmBFd7Pgprj4TbZlOmzaaxGtjbkQGQmCUc/W8LAG4+enhm
	4TQB28jTq4Zhw40K7ubOdpSmdHMLRE7fdEQjEjAgKf5kx/Od5CJJa/qsB8I/UYHT
	/JByQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791388169; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:gM7FAAQYI9ieT+v5Ppc0qYDcQe6BqxpMO/HGjXkyE/w3abY
	CL4lTEia/6z0R8UhdF1niMcLyYNuV0pjj8JAK370JUZwtz1wOkCC+bsDDl3W/Ahc
	pz8gKX7jJbRyJ4zUwHSvBQ5R+kmHaRp8gz4ldJ0SOIptgFBWnwHqlUGFGBXoOvXP
	OdSoF4OZhEvfWOxRhdRgsU6Kw44KTlQvzUlyg714ZhFWiE0y6Scekwc4FpgldUwp
	szKiCDAo8hSUgeoEknE56uLq5xFV4fgj0VShHAH7qBag9UKMeWnFvfyYhRsckJER
	Qtd/U3NXUPvs38CQN+OAiyQ+KeXfcfQzhh5s2Vw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7AQ9A5q7IWuAEQ0ViyW9S4JAu6xYUCd/GdG3tTeUDtg=:SJ85HzI3nnTUKBjbG9eDMxU8wMh9OyTklgMqk6xA5BU=;
X-ME-Sender: <xms:CWrGav5_hxK97RNu0wEmCXqVNZvadydOOrr1T__GXlP8vsp0_KOVug>
    <xme:CWrGauMixcZRSaCM7J3v1uCgPLsuf9AZlNscO2kUZ1X5yCjonvEYWzD79K9dz1b0B
    Dile7UdaF6af3evaJ7FbYbWFm2OgAVOzyiI8B7rxbdCRX81IlcvzOIZ>
X-ME-Received: <xmr:CWrGatubASkOwrKCV7Xfjp9fuvO4-JoWMZ3lw-R9cTR2otCjCD4Emk8GXA>
X-ME-Proxy-Cause: dmFkZTEBaUDDO6ngTf2qaoSnvem6liDvuhKl/9yQVpKqZxwy4l1eqKxf+EyLhO58G5o0Gk
    FCVZ5dgt+2a+9WSMNk6P1NC/alZr9x3nei1HF3ulSpjUgDRWm3MOfiENnwy+bbJnNFqBv6
    01JjNYluYE02hPPSGuQvtWjRl4n20jQ98HoA3X45Z/VIWCArdnL60YadLRBc+c9Y0G+ABZ
    CKUZ3Lv3++BdVjZn1l3etwpTvSpv9G6XBVnQOcuLLi0b/OpnpZAFrIIuZDZQXHaaNKuDUo
    8HvPsQHd4nffXMvs7XIOg/J6/2EI+tKqpbMZB4s1+BkZ0nB6uTNWeGWijEEeSu74c8NTQJ
    vsEkXXlJdTlvMzVDgeOAXKkuNn2KNTLOMcqRe9Th1pl5qe5XU5fYkcJ3CBo/NqO8s66dB4
    bVOPVqPEin8sahcf4meKLM+ECBsqHvfnA05IgMmeo58ltlR4+DWifCAMjHhK77ViOYHn+z
    S8gVZJoQRlgeDs5O2tG6U4AQHWyZSpE/qBxnYBuU4m625TkjN56HZBHzevAClgn35/35Xd
    RSmsEvhk+iytFzrUn5DUUUnujyUL3mhzdinr8JjnJiikdQ/uRIkMXNs9GuIKVFQly1UAKU
    0icnpZPp1t7l55kZltznc2HKVlsTVVWZigF0pt2ZU4a4Dark6bNdAJvI57LA
X-ME-Proxy: <xmx:CWrGahY9yg7hO9h_-IYyWsQm3PlRaPLDlWdWw8KXY-x6gqv5J868mg>
    <xmx:CWrGavw8TnGNSi0HUwsm3kjUEVoNZ7Hc5m29K77FT5i2RhEil9z2jg>
    <xmx:CWrGaphjOEgaDI8Sd3Zo5GX2VRCKJYCWTMhXAXvqI72gGQ_JCpLp0A>
    <xmx:CWrGarnT4PTJWRQpHbR65c6S2Q-NhnEGGvbhIO5F2O7ypGcpckA24w>
    <xmx:CWrGahKiom2Ru4Yd_ao7GxHuBKaCW5pz-J_Q0qH3ZX_uGxXXr45J39Nw>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 11:49:28 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	suhaas@s-joshi.in
Subject: [PATCH 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Wed,  7 Oct 2026 21:18:46 +0530
Message-ID: <20261007154851.45368-3-suhaas@s-joshi.in>
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
 mm/damon/core.c             | 42 +++++++++++++++++---------------
 mm/damon/tests/core-kunit.h | 48 ++++++++++++++++++++++++++++++-------
 2 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a3af5ee685e1..025df4d19e20 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2049,8 +2049,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 	return sz;
 }
 
-static int damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r);
+static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
+				 struct damon_region *r, unsigned long sz_r);
 
 /*
  * damon_apply_min_nr_regions() - Make effect of min_nr_regions parameter.
@@ -2075,7 +2075,7 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t) {
 			while (damon_sz_region(r) > max_region_sz) {
-				if (damon_split_region_at(t, r, max_region_sz))
+				if (damon_split_region_at(ctx, t, r, max_region_sz))
 					goto out;
 				r = damon_next_region(r);
 			}
@@ -2494,9 +2494,9 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
  *
  * Return: true if the region should be skipped, false otherwise.
  */
-static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region *r, struct damos *s,
-		unsigned long min_region_sz)
+static bool damos_skip_charged_region(struct damon_ctx *ctx, struct damon_target *t,
+				      struct damon_region *r, struct damos *s,
+				      unsigned long min_region_sz)
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
@@ -2523,7 +2523,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 				}
 				sz_to_skip = min_region_sz;
 			}
-			damon_split_region_at(t, r, sz_to_skip);
+			damon_split_region_at(ctx, t, r, sz_to_skip);
 			skip = true;
 		}
 	}
@@ -2581,12 +2581,12 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
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
@@ -2779,7 +2779,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			if (damon_split_region_at(t, r, sz))
+			if (damon_split_region_at(c, t, r, sz))
 				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
@@ -2826,7 +2826,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
-		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
+		if (damos_skip_charged_region(c, t, r, s, c->min_region_sz))
 			continue;
 
 		if (s->max_nr_snapshots &&
@@ -3643,10 +3643,12 @@ static void damon_verify_split_region_at(struct damon_region *r,
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r)
+static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
+				 struct damon_region *r, unsigned long sz_r)
 {
 	struct damon_region *new;
+	struct damon_probe *p;
+	int i;
 
 	damon_verify_split_region_at(r, sz_r);
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
@@ -3658,11 +3660,13 @@ static int damon_split_region_at(struct damon_target *t,
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
@@ -3691,7 +3695,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(t, r, sz_sub);
+			damon_split_region_at(ctx, t, r, sz_sub);
 			sz_region = sz_sub;
 		}
 	}
@@ -3723,7 +3727,7 @@ static void damon_split_some_regions(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(t, r, sz_sub);
+			damon_split_region_at(ctx, t, r, sz_sub);
 		}
 	}
 }
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5ad89c1d9fc2..e02604c7e0bc 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -141,12 +141,26 @@ static void damon_test_split_at(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r, *r_new;
+	struct damon_ctx *ctx;
+	struct damon_probe *p;
 
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
@@ -156,7 +170,7 @@ static void damon_test_split_at(struct kunit *test)
 	r->last_probe_hits[0] = 3;
 	r->age = 10;
 	damon_add_region(r, t);
-	damon_split_region_at(t, r, 25);
+	damon_split_region_at(ctx, t, r, 25);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
 	if (damon_nr_regions(t) != 2)
 		goto out;
@@ -176,6 +190,7 @@ static void damon_test_split_at(struct kunit *test)
 
 out:
 	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static void damon_test_merge_two(struct kunit *test)
@@ -1648,19 +1663,35 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	struct damon_ctx *ctx;
+	struct damon_probe *p;
+
+	p = damon_new_probe();
+	if (!p)
+		kunit_skip(test, "probe alloc fail");
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		kunit_skip(test, "context alloc fail");
+	}
+	damon_add_probe(ctx, p);
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
-	if (!f)
+	if (!f) {
+		damon_destroy_ctx(ctx);
 		kunit_skip(test, "filter alloc fail");
+	}
 	f->addr_range = (struct damon_addr_range){.start = 2, .end = 6};
 
 	t = damon_new_target();
 	if (!t) {
+		damon_destroy_ctx(ctx);
 		damos_destroy_filter(f);
 		kunit_skip(test, "target alloc fail");
 	}
 	r = damon_new_region(3, 5);
 	if (!r) {
+		damon_destroy_ctx(ctx);
 		damos_destroy_filter(f);
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
@@ -1668,27 +1699,27 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
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
@@ -1704,7 +1735,7 @@ static void damos_test_filter_out(struct kunit *test)
 	r->ar.start = 2;
 	r->ar.end = 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(ctx, t, r, f, 1));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
@@ -1717,6 +1748,7 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_destroy_region(r2, t);
 
 out:
+	damon_destroy_ctx(ctx);
 	damon_free_target(t);
 	damos_free_filter(f);
 }
-- 
2.55.0

