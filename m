Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCA52D2A1
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072710; cv=none; b=e332iQSsak3VT9IepVagxD8gqKXz3EanXaupRuPar1yNEWGmnVUtAeNbNAmUgA9MpP8SEo130zZirt5MoDoSvbMPfpUxiGAru+FYMq4ACV5+apNLP3REg4UEZ9jLD0qUJHg3/KJ/iYvPBn1H0s7fZkfJWC6JhuXnvX3ji7xeoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072710; c=relaxed/simple;
	bh=OCv0J4F0+cKT1MGHRq/Orj+bkEruIA6kgjMbhaQyAzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tve2qeFpNe+hpgJJBBhJjpSRPTONQQZ4e65GX4Zn09jMTd+F2VaIxINS0NrWeNj7EV/FU1o/c3TmNo2ZTpwv33VbJ/RLseZ1N4Bcj4gaKyxo8XgWTl55dCzwriMpvN+sBogtYkE7zTcDlyS/o74UnS+4KteqRbpstztPpXVgbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=iawvqngN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xr6tPNFl; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="iawvqngN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xr6tPNFl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id E26D91380280
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 09:58:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 09:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792072706; x=
	1792076306; bh=3/Q6wychZRDpWguDGY6+VUJKrf/+wIfeSmHd7gFbPr0=; b=i
	awvqngNARpAE/TLK4RtHxMeNE3TZygqK/rDPNeHvb2w+9/B0ZsnG10SGIOCK8KV3
	78hz2SGOf6aSAD+ZagL+V3DbOpKNdXhC+dkb2zDfYN3u9pRYRHPzeOt9T3U5MvHm
	VmFJrCtvFv0VBkOQBDGu6+7Oqg+6NI4yTGSU8GDxS8R7lJtVeVXm4XkcEk4Rfa46
	/H3DpJgFGymOCdqsudGR9/Dhge9r2rAnXGwrFA7MO4pcb66OgXZchCNxXbvqlHSe
	pxt3Ydi42Et74t4rftWk7IFi621XYlv7iC4WMr+32vSQiQ6BhPMaD7Lt51aW3zTo
	ohW+iNDsPNHrkZPK1qRjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792072706; x=1792076306; bh=3
	/Q6wychZRDpWguDGY6+VUJKrf/+wIfeSmHd7gFbPr0=; b=xr6tPNFlrzoYZIQIk
	B3mECbrwebsOLGPcdeZaAZoSuOdGKb+axz3V3yLZuLXLdukoy7JLkeKCkYkxV1xA
	tgkKpfmIqgP4/UQmw71eNHvpqE3H/oKd3h4ua4Fwdu8LCxRTieuAAo/HKyNwYGYv
	vbMM/v+1KESlaSzBU0c3kOmB5a3nbKaSdeM5hiT+HGvEHRuSTZrLiYa5wf+pfujB
	yUZ7qjIHVTMH131ZqZZGYD4qg108g44862CBFPQLJQyYfNPv2vl8uF/1pymlagBB
	tSJBOuZeluHmLBhtRIhmmwnHBVEmGF0ObbxcArQtTgfnvxYz40rzjOv6wACRoX3f
	FZOmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792072706; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:DqXy+Km8q6AflktFjEMeHuuCkbTiAMQfN89YTJZFweVqlI9
	+3zl2sCJ0t0C8GdLdysCtrW6fV6IMSoEq6/ppC+rJfoCe7aL9sfV55RIfjfSF4Yd
	AY/F46yua72D9OFy+8C6EMkeEvoRVDFqpgnpthc0dhqrccc6BrFjq/up8ZvHM8ic
	BvUNuO8IUQDm3q6YjhFiPLJFQlThvaB2WA0LDJt9g36riPSo6afdHWQbzJ+/7paM
	EFfD8mAwhSlOuBPcQiJ7EbEC7nUJj6jR+yhzIa2NjPKvsdJbw7y5lHlEeuxW7zlw
	AJbVzAredFoWc/RtvHc5ObKFKqZOkapOLLHL21Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J1qIQ0oheCSSO4Oo6x7gs3ST57Fjww9Za6MZ8s3CE0w=:OCv0J4F0+cKT1MGHRq/Orj+bkEruIA6kgjMbhaQyAzo=;
X-ME-Sender: <xms:AtzQaiHMIfxUGI_NYffml3NcyLRi2ddZDFRLNuQrRbzD4Cm7GJ-quw>
    <xme:AtzQasr_ImjUphF0IcsbcidZJFLyfkLB2sWvtOoNuertM5OPaWpgKPw_T4yrVekfO
    GQtLNtHvMUOEUdgyKraW8GU45gxHGxvq0ngIrPGSVg8_smK6HW5iJ3J>
X-ME-Received: <xmr:AtzQajY0ZClSuwhhsJjS2NCxhYQnDd1OdL0MB9lV4aFJWUHpYEB-XMy9bA>
X-ME-Proxy-Cause: dmFkZTGmFAKykKSAVqFKtPUpA7z4HQxXGeWq8/WsVMtzile6xT4qlc2iJUMvU5uto9J+tl
    6xiHAOs1vo9mJEQbj1wOR5tng2NlvDB6a5Z09lC8JabfXEHTsrLDRNS8fsGwBbVTP+reZe
    OPwjXNfp4gnxt9qvz6/K/kr69tIFsz1HP6WSz8b9cBQ+1gKTJaE7P9pHmuAiAUKfuzJtVh
    0WZBQIH5ePTnc6MO1Zq7Pn6fWiuTviDKYiSaak1txos9SONMiUdZzxGnVOrmnxkHNtSoO2
    Fu9ajJhlc/cETsT+/iB2rFW91QAMj4/zaA/p3GMz4isfOE2rvE5e4ENNuPhiQt/3u/qnlR
    Az/eWamD4w7ZWn3s3oi1ZC1CvEq3+Pr08RHUB3PC2Buzgyd5F2QaN2Z1PENyluqqqARYjs
    eYBoh4TDwak9q9r6p+v/4tocQFhLQ6IyEF3/6RAyMH8YwLBwSOHcTXToVmm9X3qP7aMiAH
    j8xRyrZtqQBdwlwr2igbvaPie95KNsNc3Om/hbrqOpfifKkLBsN/c7pfYR4yyVRWLfYRBj
    PTLsItgD7CdO4NC7V3CMjfZ0/DLL/s/Mb3IxG6iKqJ1/nmMsnwsdwYCN1UR8Q84dHIjGQ4
    edIlgJce22Wh9J6st+yroGrUWZsXgdD656Bs7xV2dJHJrEkiiy7hQQfifZQw
X-ME-Proxy: <xmx:AtzQatXdiiu6WNVqMybFRZy1Kyt7bbM-pwjcxZ9FbgF69RWKkZeSOw>
    <xmx:AtzQak9I0pFmxS6ijUWRpPGmXyTQtdzUVxHUs7hVmq_JJUf12XDr6Q>
    <xmx:AtzQau_HIS3cvVs867xVTt5U5wMfhPFuP_8hJxEZkvKX5HgnhwG8Ng>
    <xmx:AtzQasS2mg4QcHnSvj_17JCnbuRE6pP9E3Cqs4kwxqi4qA-ps4gpwQ>
    <xmx:AtzQaoNC-FL-TmUGxuaO6wrESJr9EwD6iqs51ppVpbCeU_dl6_6FH_Sy>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 09:58:25 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Thu, 15 Oct 2026 19:27:54 +0530
Message-ID: <20261015135801.19326-2-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015135533.18761-1-suhaas@s-joshi.in>
References: <20261015135533.18761-1-suhaas@s-joshi.in>
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
 mm/damon/core.c             | 42 +++++++++++++-----------
 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 28 deletions(-)

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
index 849cf61cb828..0a442f1e6a42 100644
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
@@ -150,13 +152,29 @@ static void damon_test_split_at(struct kunit *test)
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
 	}
+	p = damon_new_probe();
+	if (!p) {
+		damon_free_region(r);
+		damon_free_target(t);
+		kunit_skip(test, "probe alloc fail");
+	}
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		damon_free_region(r);
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
@@ -175,7 +193,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
 out:
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static void damon_test_merge_two(struct kunit *test)
@@ -1799,6 +1817,8 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	struct damon_ctx *ctx;
+	struct damon_probe *p;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	if (!f)
@@ -1818,28 +1838,44 @@ static void damos_test_filter_out(struct kunit *test)
 	}
 	damon_add_region(r, t);
 
+	p = damon_new_probe();
+	if (!p) {
+		damon_free_target(t);
+		damos_destroy_filter(f);
+		kunit_skip(test, "probe alloc fail");
+	}
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		damon_free_target(t);
+		damos_destroy_filter(f);
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
@@ -1855,7 +1891,7 @@ static void damos_test_filter_out(struct kunit *test)
 	r->ar.start = 2;
 	r->ar.end = 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(ctx, t, r, f, 1));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
@@ -1868,7 +1904,7 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_destroy_region(r2, t);
 
 out:
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 	damos_free_filter(f);
 }
 
@@ -2458,6 +2494,7 @@ static void damos_test_esz_goal_temporal(struct kunit *test)
 static void damon_test_last_region_quota_reset(struct kunit *test)
 {
 	struct damos s = {0};
+	struct damon_ctx *ctx;
 	struct damon_target *t;
 	struct damon_region *r1, *r2;
 	unsigned long min_region_sz = 1;
@@ -2484,7 +2521,14 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	s.quota.charge_target_from = t;
 	s.quota.charge_addr_from = r1->ar.end;
 
-	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_free_target(t);
+		kunit_skip(test, "ctx alloc failed");
+	}
+	damon_add_target(ctx, t);
+
+	skipped = damos_skip_charged_region(ctx, t, r2, &s, min_region_sz);
 
 	/* 'r2' is not processed, it should not skip */
 	KUNIT_EXPECT_EQ(test, skipped, false);
@@ -2493,7 +2537,7 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, s.quota.charge_target_from, NULL);
 	KUNIT_EXPECT_EQ(test, s.quota.charge_addr_from, 0);
 
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static struct kunit_case damon_test_cases[] = {
-- 
2.55.0

