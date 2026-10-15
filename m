Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1D305057
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072700; cv=none; b=lvdFgjIHcY9hypHxsPzwUSu8kiDHDBb5vP23IcRCKLEVryAK1F4FG0uPIeFs2dCv7qmK9vTcwfnhdM5p6hembgc6WH7zHCwIeLnT47D3kf1J2m/NcMxjXogXMEtslGtzsoDPdNzeqQitvSd73LY0DPYa18r2++wpxsZM3fleV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072700; c=relaxed/simple;
	bh=XCLZISSAltF//O6t+IpR0eamKchFx2zNh3GL/j8aZwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp3XcTeDIIx5v6HxdiinKL6pulW5dKlYIeeDaDfJStkmm1wXwru60UTPMJY/TI5ZaoxbhXUMV7NqDBb3FHU5y7XlCDEYihp9YDGTM3u3gVJACJI9lh32lkkVzpe04ZZKPQFyxk7NGplwbY3hnX5JF4dsFWzNx3MGprHrT8JIkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=K6F5aK+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZyFd6SQk; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="K6F5aK+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZyFd6SQk"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 138991380280
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 09:58:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 09:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792072697; x=
	1792076297; bh=CnO8Z6h9zpO/QTub1B+RFdiy6XB7flbUP5VcPsb88+8=; b=K
	6F5aK+NfLqoqTsZdXarXaIgI2UEHWLUAVRLtF7QjmhL46+nVHdW88jDdLyNjpf94
	YSo+9nhAzmOkjiGFr0DrKcmmLinWaHtftM1N5XjEWzzQ56bTG6dk20+wCAz/MK8a
	FqjUQCSHcJLVbl12sNL7JUnw2caMjLl5pOb3QEWRodanu5LXy+Yqm8p5k5UVMcqH
	aPh8rDxgJ0CqHl69L/ZVs0F015ImkRkG/dcB/Ulm9jOaXOaVVM0KjdcHnXPjK1mz
	J73phcvEEMVAlt3CuAfwbXzCccXZPHpHc6CsWnyQJnsCeS9SRCqUId2WBcjFyc/k
	AnzwIWyR9xp10WZL2IuUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792072697; x=1792076297; bh=C
	nO8Z6h9zpO/QTub1B+RFdiy6XB7flbUP5VcPsb88+8=; b=ZyFd6SQkm2PWBGE8L
	Mh+hzm4BthoRgot8Gg19Buf9wtsKQ4TXySByy+1sLRWgASsD8aZhD8cAHx6uPwtc
	4M/uDFbfWzpVcS8PHNfHrIq1CI4oGN2Cs3Q96L+3aJR5+AuIWe+IeGKQkasM4KAo
	Z6pzZo5P2lEcj61TdOe1vXcQ0XGMIMCJvgypj9Jn06Zv5h0DZUqoptDyzDwaiw2V
	2kVkup1Jy89QcTdbzbtrgYcEiCBDwtZ+JYLyjau2NLz+UXWxqwMNTyXdAJKz7Mxw
	zoxhfx4sXGyAI4nlA9arzlJwXgkOgHDdzYyNnSX4zQKmPAITHxINBuocNQNp6BSF
	/sfdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792072697; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:HguwjxyhJtqLJTZh1NkjH/UvojwqC4WohazPUeXgjJuCNxg
	wXRtkhE35F9A+EL/gPWJcXnwhOvLgNeJnFx+fmqI4hupz+qnklUsjwwa4YN7DFFk
	g6SsudZod51ZeGeIPpiROBLrvHZd9skjPHuWA8d6/HW4jHf6gyHh4N1jVYJiPTHL
	CYWgkRUP056LaWvP4bGBzFgDPPOWqqx1V4IrOGlX4SNo4o5o3fGrh3H14W8uNdlJ
	qohpeGXuFYn7ZV9zcQYoxiy13lX4oHkREi64BvUqmJ/eo/oa1lDSPeRTuNgYkLSA
	bQR6QZBTzd1jcuLY1W0+AjGA4Bth4QX3JuVDNYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ki8EbvuJseo+uOuHf5DKuwHpBlH2h/odU2Bm6ibMO4s=:XCLZISSAltF//O6t+IpR0eamKchFx2zNh3GL/j8aZwA=;
X-ME-Sender: <xms:-NvQarjtjYk26pu96rBeAf5Y6Kd5uT1BJVbRf_AN9v3404waI8ErKQ>
    <xme:-NvQahX3jq4LoFsdwXUkeXNb1nF0jpauLsqaBCO4-jkt1rm9J5x-DHcoKWN27CYY4
    Vx1pC-D7o5ntSOlXTw-n9ggcRy1eaymZAGFC-5tExez5Xr2GgTy_w>
X-ME-Received: <xmr:-NvQaiXhrSiDSpxmszIUkHI0fVPEkKM2_GP6-b6PmGHU2JRLZeXMRiNL9g>
X-ME-Proxy-Cause: dmFkZTEjMW0FdWGU8vE5FR9XXFJ5ToXQmBEsNYZLPQzkZOcxhgH5+QmoDYPjPP5vf1P5tk
    kOcza6G+URvZkSkJwB3YDQH7dUAAd0ZqfyynQ+1E1OsJDPUdK8Dt+uHyXhep3EiaQSJOlD
    o+1BM+m08TR/PRN9ZQlF7oiURKLnSX7EXyfWtjN2YHEnbBobd7MH10qZ7W2ZuArD3zNNlE
    nmHUnz0iCIoupLsV+aLjo6/JKRnPJMQK2CE8YB/7Dr/g1XtEoeayJBQ2G7RbKsER8qQbOH
    f/Q+uoMEYrxVTutGmIUoXlCCcH7fCEsxm+CChuG+68dwGDfFwaO7ltAIXC5KOOvtwtTTL6
    O37Cb5VY/wojXloYrzxPvucWr/OG7C1Gf8KizWJOplNZbi58ppZmMyg6SwJx0n80UPt9SA
    95qeubFsW8a88vOIWJ91d5waLkDzM63YhJYxAYZhOVJgs3bFIO10B1Cj/dD6rquhNCZlT1
    asipMEhPo7aKazxpKRzYVcawkEw+PSkzChOmDFxDaSwPzzCbmnFWN3XJxt0J/hPf1NbrMi
    W3+bY6MGuxPDj7XGS8Y87nX64TZRTeelfT64/w2uCF2Tdopj7oaYOKxzN+xPc6WwPwAomX
    EMpNhsXrtl42nClgOLgTt0Iy2qzOTpRmWdR9nthyCm+wPyUBRty/5iPfAaTg
X-ME-Proxy: <xmx:-NvQapg5nL0Cl44MsMhVceea3-Maqn-ANcP289BE8pPm-lxO3nvoXg>
    <xmx:-NvQalaMaw0jZYgsSvyjA7SZ9a_kKoHyagc7OYuR6-tBfwMj_jRMHA>
    <xmx:-NvQauoI9khiOpQ7V10oFrcD_eoDfVfKgFTDJIRzQtJYdzfiuDwiyg>
    <xmx:-NvQaqPjvyuts3pYmP5Dy-UtvTjx2AMaQVNcbzMTTQ_h-FUFJkn1DA>
    <xmx:-NvQag6HeMn7JSEAbTCnHSit0Lu7HjWeT6w_1WCqY5wn7IWW3XxCUwEV>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 09:58:15 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Thu, 15 Oct 2026 19:27:53 +0530
Message-ID: <20261015135801.19326-1-suhaas@s-joshi.in>
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
 mm/damon/core.c             | 15 ++++++++++-----
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef8990..bebd2889c2c8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3524,20 +3524,25 @@ static void damon_verify_merge_two_regions(
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
@@ -3590,7 +3595,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 			goto set_prev_continue;
 		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
 			goto set_prev_continue;
-		damon_merge_two_regions(t, prev, r);
+		damon_merge_two_regions(ctx, t, prev, r);
 		continue;
 set_prev_continue:
 		prev = r;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3fbb4e4e36fa..849cf61cb828 100644
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
2.55.0

