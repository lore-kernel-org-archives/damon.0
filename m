Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794957790;
	b=WhbEA0CuEK3WT0Xr/7nZ5EpizXz3PMofHteea9VVIElYFTAMrwRrMI9xsu23S9KIy++c
	 SE7LXdkC0YlkS/eG6sOPsVqFgw+WS20qbqdMqWyCMMn/XtTOA6zzlFSereJ+uivmDkVjv
	 AEC0cA35zwZhg4HPr/5JBHSdzRHPPli7ZwHKY0L/bk1qHA93R47t4iMAVQ0/D6jpR5/Vz
	 tEISHHTyGGIkWMcXQXX5rNQL/ntxhlCJVi9YawvhXR9993DvDUveqMBegw2QUEPdaVZtM
	 bBWZUt3KYAI6kdUCk/qD4ivA9vqzf1iAZdJx3vEfmlrnup9CtJSGoo5YmkiL+xego2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957790;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ARUJ4MAAEpvnziFuLB+fXPX9rGdUVA5ywAZlGvBHYD4=;
	b=5MuamI2Sulf5MUCPnThXQ9AKFglMjEsIlYZqxuGKVHL2K4eYJ2Us8+hue3ArWIdESkSC
	 Jx5IUud9bBWepK1Qbci2pOBfpCXemLwTUWvxYPxsb7GVVYGQBiR3QjZSWdeLbD0RBF5uL
	 RBljKQ4+Rpndl7v5E1dPZvr9oASTtmfbrBh6hbess4VPhVXbIGickB1lLHWh37DN6VcPP
	 dRXZq83c6ohlcQZ7dVVPm0Wns8tS+m59/2WCbPmEZWrcf0a+xnSVhiflY1azYGuQkeNiW
	 SPahDCvK472UD5eSoxug+agjk5er2fCeJ3P4zn6Bm8nYhScDyTz91bC0kUuO1SvXkuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPPOKVWI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D2606A88B;
	Tue, 17 Nov 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPPOKVWI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794957790;
	b=mgfANOd34HR/SejL2SBqQbqomzh0xMBMuFuHvznmQ9jv2O2RmdQsXqIZFP0xDpo0QqoR
	 nZeFKrqdiFIy34LwK5T5OyvVpyt1mnrwoY9c4hg488sHPvmcDpqsbBWe3x8XQXuo7zQ5D
	 E/xusn7Y1x22aP5W9QMcEsrhEcSn/yTPN/LmpXzpI/+1Nj4rAz0IEOoLuhnquXQoXP/rU
	 UWkdoF4PSMwz1lmDntFmpZctAC6g4X19+k2uTVjyOcmAS9E8t9llh35tuyJZURi+Ov1tA
	 HCX1WqsUaHtymdE2rF+jIQDz4eBVzlTTbyJRS+zH+ETt/FhJnaUc/e5peDvhZLeX7kw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794957790;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ARUJ4MAAEpvnziFuLB+fXPX9rGdUVA5ywAZlGvBHYD4=;
	b=2OGJyzolixh21Y833I0OUWLVwbKDJSppoLa1viFFfv+rRaxFmYM3OeLIKuSQE/j1drPV
	 4pTzcWCEWVfHIj69oTDBxNrG+vSNbr9aZXbFf18KV3j4G8am8GMITWMZ8bH0JiNpC63na
	 xxewAJcCKU1kB/KFu/YmL1BUVxc/7so5euu31wbgL2VVeY0z+0zHVqhPBWibv/5wAYk06
	 42Is892wIXar659dE/CcLjMcOI3K/64zoRsCMeV4axmry7kPqWAxzCL9xOkxo0OqbYAlM
	 UNvksVB9nSIjqWT5wWtBio3VztoHTIaybhq8angQTGQ12GXYU+hpEwf4E4XVG7HCGig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A6FA1F000C7;
	Tue, 17 Nov 2026 23:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957790;
	bh=ARUJ4MAAEpvnziFuLB+fXPX9rGdUVA5ywAZlGvBHYD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KPPOKVWISH7C+ybLO/dQWDVzh9+5TZakBeAA2ZkaZsHltq98R4gBguNXK3ug65Z9h
	 qf+07hvVPhvC7FITg/MsxHJDpd3Xu0w6QrJF9yaktVwON7j9v1JXBtMIAQJz08dKax
	 cnftnFPzkOlWWFODLWpX03a8fj0BIoJzNdvhmSb9L/RlAH0jxuruPRhNoKuvQKDWfo
	 Ot+6cqF+IdUodYTjrpp0wnXsK0arscfRs22V5s3EMy/P4yRYlBclT+OHYOfYqMbudU
	 BL6FqE6PeP4JoXMEm/Ztg2QWOkunkZLInAOP6lKZbJ9N1YFNVHJW8xreEx7qHwGSp+
	 v5j9bQpbrl1YA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DCA394AB44;
	Tue, 17 Nov 2026 23:23:07 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Tue, 17 Nov 2026 23:22:17 +0000
Subject: [PATCH v2 3/6] mm/damon/tests/core-kunit: test
 sz_ops_filter_passed_last
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-damon-sz-ops-b4-v2-3-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
In-Reply-To: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794957787; l=4205;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=h2bZi8GyX472sluoP+mJ0igMgXjinQcbkxTFNqsCnXE=;
 b=ZS34BMhhNNrcONv8s6qnYwqh4wj0bpUA4Em2mETWCFRNJ9ey1QcEsZRaNUI6Xf1MD07QoprXJ
 hdZUjXRi/lUDfzAinICPHfg3X+BebVvswtcnycZHNUYnIZwF37EYvLh
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 7bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Add a kunit test for the sz_ops_filter_passed_last DAMOS
stat.  The test runs kdamond_apply_schemes() for multiple apply intervals
with a stub apply_scheme() operation that reports a given ops
filter-passed size, and checks that the stat is set to the value of the
last apply interval rather than the accumulated value, and that it is
kept unchanged until the next apply interval is completed.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 mm/damon/tests/core-kunit.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a5ca4bfe2f0d..d256e6b7de73 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2541,6 +2541,98 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+/* bytes that damos_test_apply_scheme_passed_stub() reports per region */
+static unsigned long damos_test_sz_passed;
+
+static unsigned long damos_test_apply_scheme_passed_stub(struct damon_ctx *c,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *s, unsigned long *sz_filter_passed)
+{
+	*sz_filter_passed = damos_test_sz_passed;
+	return 0;
+}
+
+/* run one apply interval and return the last apply interval's passed bytes */
+static unsigned long damos_test_apply_interval(struct damon_ctx *c,
+		struct damos *s)
+{
+	c->passed_sample_intervals = s->next_apply_sis;
+	kdamond_apply_schemes(c);
+	return s->stat.sz_ops_filter_passed_last;
+}
+
+static void damos_test_sz_ops_filter_passed_last(struct kunit *test)
+{
+	struct damos_access_pattern pattern = {
+		.min_sz_region = 0,
+		.max_sz_region = ULONG_MAX,
+		.min_nr_accesses = 0,
+		.max_nr_accesses = UINT_MAX,
+		.min_age_region = 0,
+		.max_age_region = UINT_MAX,
+	};
+	struct damos_watermarks wmarks = {};
+	struct damos_quota quota = {};
+	struct damon_ctx *c;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damos *s;
+
+	c = damon_new_ctx();
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+	c->ops.apply_scheme = damos_test_apply_scheme_passed_stub;
+
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damos_set_filters_default_reject(s);
+	damon_add_scheme(c, s);
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
+	damon_add_target(c, t);
+
+	r = damon_new_region(0, DAMON_MIN_REGION_SZ);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	KUNIT_EXPECT_EQ(test, s->stat.sz_ops_filter_passed_last, 0);
+
+	/* each value is for the last apply interval only, not cumulative */
+	damos_test_sz_passed = 1000;
+	KUNIT_EXPECT_EQ(test, damos_test_apply_interval(c, s), 1000);
+	KUNIT_EXPECT_EQ(test, damos_test_apply_interval(c, s), 1000);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_ops_filter_passed, 2000);
+
+	damos_test_sz_passed = 300;
+	KUNIT_EXPECT_EQ(test, damos_test_apply_interval(c, s), 300);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_ops_filter_passed, 2300);
+
+	damos_test_sz_passed = 0;
+	KUNIT_EXPECT_EQ(test, damos_test_apply_interval(c, s), 0);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_ops_filter_passed, 2300);
+
+	/* not yet the time to apply, so the last value should be kept */
+	damos_test_sz_passed = 500;
+	damos_test_apply_interval(c, s);
+	c->passed_sample_intervals = s->next_apply_sis - 1;
+	kdamond_apply_schemes(c);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_ops_filter_passed_last,
+			500);
+
+	damon_destroy_ctx(c);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -2585,6 +2677,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_rand),
 	KUNIT_CASE(damos_test_esz_goal_temporal),
 	KUNIT_CASE(damon_test_last_region_quota_reset),
+	KUNIT_CASE(damos_test_sz_ops_filter_passed_last),
 	{},
 };
 

-- 
2.54.0-uber3


