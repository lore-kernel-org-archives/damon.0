Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856222;
	b=wgECmcIQSShPSHHst3H3KIzZ+8sOfxDMpuBY5CviXBOMv8C6s7E6IkJlSBoJ1cERSrxm
	 z5WoxPIAZFKjRe409xoRNM08NETmsFX5OsPAT5p2VmUkD3kNgVDiPzs7j92gDuMC85hg4
	 K7sfQaO734+eqTC566nxlKL1F9PIgVdfNVxKegrKcXT4O9BaLbGdFG3LKX8EuFt2dWrbj
	 tTbWYVpt59+/wA8Mx4zEy+ufgH7YeNE3MJYDDlUwm5BhJ+itUPY+v3qsnme4H4DWbEqW/
	 zhbDIle7oKNN1Krf0ZQrMIm7dRMilzAdLaq1hX2Z5nWcQhaMDmS/TkPU12BGZXD74oQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Va0EwVY7Jk2HkM+Pck50ew1/raTtCTxdQw7XogRQQbc=;
	b=UERCArBHJFlsYvTfwXv0AriAqMxOqs/NZkxHLkrKKTr535Rd8FWNRXd6EVdhiCfM715j
	 WEcFz499bAXere0VFZIcWONQN+qm13YU1SGk14MghWrqjDXz6UQoOxHtrB2itQ+mdJTbW
	 sON9U12bmyw0ACvoIC1qNdT6CMS/LoyW6l8JF7IvzxeUxPXAp9eg8JjolWMcfaTRfIOd8
	 +rlE/sbOVovA4wSgpCGwqQbK1Ayj35PJljMdaYQMfV6BXmV4nvBiEkBPBsOKxsnM6Bufu
	 C1O2ORDPY+bxNEmCGZNrDanrRxY9ZzadW0JladHieZ5e/bPowQJEfN88izZ0hwaUa7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEqi4qKr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E635606A33F;
	Mon, 16 Nov 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEqi4qKr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794856222;
	b=R70SqA6towqWskxr/hI/d3cXyXY6tYoFZEbUHvBtctQwDSe3aeTrlCv/HrHKHaZ5ldj6
	 gTRz1EA53DMujbD8IJYtB1bQs+iSTGfxSqPZJH25sFOpLb7iHvzuEDKc+aYTcDMdStt0n
	 ny/hurG+rmVNAiijhaqVn6JUkxrkbBicoGp6m/Gp+EATbI6Q8o/yE7j6W4rVOYqYE4hCc
	 fZ803ztZDecN+kUailsr6wTG26Ho6GhaqEMc8Pqf+zZ2AaAmH2wVKRdAYokRDLCDAa+9N
	 wr4Lph/YoZSFjXo8Hk2zI/0mRwvJwZs6N8rpAPrF8KOkndJF11FrUazyCnYmYA1GLLQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794856222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Va0EwVY7Jk2HkM+Pck50ew1/raTtCTxdQw7XogRQQbc=;
	b=SLSWDH3o6JTfbcrNpQEO9h7q5yjPcFzXKppUXge6zoDgd6fczdfwUSQbLc1+4k/adTnh
	 OnisjPg6MxDMaQgBdVNEGzvonO+Ud4PBCJC4mE35Dc4o4ByuuiYFDBDm94jZqfKbDc4Jt
	 BWLfs5/ldQDVvqTyli78YRZPrQCAcHh14KlAj0JhohdcFZw2leZ9TIwV0J6JIeZt6PlHC
	 UhfIdU1tiCl5FJZ1yCam06q7oPKSgDt2UHBmQCD2JCm6dAA3LKABk9wGQeekR8jAtbvkl
	 2wREwBtG1zxaXUXhhw5sVaRv/femdtD/L9URE0GO8CCj1bakH8uepeilMwUyY5TblUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 03BDB1F000C8;
	Mon, 16 Nov 2026 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856222;
	bh=Va0EwVY7Jk2HkM+Pck50ew1/raTtCTxdQw7XogRQQbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EEqi4qKr9nCqtr+8Zmcasng84XJwpUYbmiqwErOq4K+R+xFSEfk0TO8CkipbcJweJ
	 cqGy0F7jD02rb/cK8BXnviEudnwEOH1MOFK0RQQBgS8CYU8xKgbbhyG7rlmf8kDNZF
	 oknAVbHaplbTuNZZQo+GPUhb2lisT4+0zC5tqkuq2P2N8MKpF/iWHDatUhq8BclgAq
	 OEh6WBZn0UJ+2eV/6IxvH15Cr19tFBC75WKMWFuTXbSKl6AoGqxgvX/VG9hMdRuJ9u
	 IJ73v5eL2vjHLgMWMz+2D71on1xdVmf5xTyuN+PeqS135hZVqv+bfvvRvBCVQRD4mE
	 Wj7MLzPMn1Hdw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7EEC94A59D;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Mon, 16 Nov 2026 19:10:06 +0000
Subject: [PATCH 3/6] mm/damon/tests/core-kunit: test
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
Message-Id: <20261116-damon-sz-ops-b4-v1-3-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
In-Reply-To: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794856219; l=4165;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=UFGCYkPDB1A1PqGUSxc/9uQS5JCp5qLJGKRVY3lIpTw=;
 b=z6AHg3v78OFP9tox8IrSuvIggfioYOad3FwiX6QaKwoVYoRaeS58Vefw6kCy1ZTkr0ygHXLya
 Qwt4+0k/Mt/AVt3nYT8cxpMOUoo7FWdvUYMln+Q1tf3eNhWDlmK+7rS
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
 mm/damon/tests/core-kunit.h | 92 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a5ca4bfe2f0d..ec83598fff0e 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2541,6 +2541,97 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
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
@@ -2585,6 +2676,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_rand),
 	KUNIT_CASE(damos_test_esz_goal_temporal),
 	KUNIT_CASE(damon_test_last_region_quota_reset),
+	KUNIT_CASE(damos_test_sz_ops_filter_passed_last),
 	{},
 };
 

-- 
2.54.0-uber3


