Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9B49F127;
	Wed,  2 Sep 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357820; cv=none; b=XHVCR56oI1crrORhWt+vwSWYNjyyLqOMloJ6u4eSL8u0hqHUKG+h0uurRTRIpoa1cWrhchzRClEbj8kDuWlEigwcfD++y8WmswY6uXWh9KVZpCb5O1w1aMS3QW43f0hwfTeWHHL3IJu+k4YormnKV6vDbVPhW7x2L15cnn4HUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357820; c=relaxed/simple;
	bh=mhg5spd/dAFzjI717T5/J5tKnG9ErLfa6LKK+y41F6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWHFYiStmFqFgW2bJtiGY2tMEYJJII+TZdnSKaht0M6rXpt0X1tekgAck3ybF4bGdMea9Hdt1IUO9OvLs3Dq6jE+99VJDIUvujmpGKzPguR66Sq3UpGDc0flyGgQOWOn1r4zeUNHL8tXZSunv4XKCPteu+EYxUi1gWmTvhYHvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8GMKvau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8GMKvau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0D01F00A3A;
	Wed,  2 Sep 2026 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357818;
	bh=w+y2YGAE9dCS66KlFXJ1CfqA9PNhGVCbFRiU+z6GWB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8GMKvaur5A0pGiCYcRq25dH9g8ieYXqvdJV7+FJTx227q0RwkObIse7UVbq8E52B
	 wsGio2tAGIeJImnBWe930VkihgttsxasQNoolrwco2tMmdTjC946GflB60YrJOBCJE
	 6PujGNQOkx18GuRX46w9/DdLvFPHwh/AOBM9S1fqD2bJfbICQwJwS58HQ9+Vm4skFW
	 GS+tgCIKssbWirh9QIi/61bIyMrMqCH19z/v7kZTLxTEVEuUjETXoe7HmqtC4JfrEZ
	 a3047oU+oe3oOmxG702GvYLytWS6KCzGCXD2jhOJmpSjWm/j+iXBXDAyXsrZLvlaxZ
	 c9e5sWL6PEXIw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] mm/damon/tests/core-kunit: add damon_commit_probes() test
Date: Wed,  2 Sep 2026 07:03:08 -0700
Message-ID: <20260902140313.85983-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902140313.85983-1-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kunit test to ensure damon_commit_probes() updates destination DAMON
context with source probes as expected.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c2ddef3c76d35..c01e6a75cadc1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1403,6 +1403,89 @@ static void damon_test_commit_filter(struct kunit *test)
 			});
 }
 
+static struct damon_ctx *damon_test_help_setup_probes(unsigned int weights[],
+		int nr_weights)
+{
+	struct damon_ctx *ctx;
+	struct damon_probe *probe;
+	int i;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return NULL;
+	for (i = 0; i < nr_weights; i++) {
+		probe = damon_new_probe();
+		if (!probe) {
+			damon_destroy_ctx(ctx);
+			return NULL;
+		}
+		probe->weight = weights[i];
+		damon_add_probe(ctx, probe);
+	}
+	return ctx;
+}
+
+static void damon_test_commit_probes_for(struct kunit *test,
+		unsigned int dst_weights[], int nr_dst_probes,
+		unsigned int src_weights[], int nr_src_probes)
+{
+	struct damon_ctx *dst, *src;
+	int err;
+	struct damon_probe *dst_probe, *src_probe;
+
+	dst = damon_test_help_setup_probes(dst_weights, nr_dst_probes);
+	if (!dst)
+		kunit_skip(test, "dst alloc fail");
+	src = damon_test_help_setup_probes(src_weights, nr_src_probes);
+	if (!src) {
+		damon_destroy_ctx(dst);
+		kunit_skip(test, "src alloc fail");
+	}
+
+	err = damon_commit_probes(dst, src);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	if (err)
+		goto out;
+	nr_dst_probes = 0;
+	damon_for_each_probe(dst_probe, dst)
+		nr_dst_probes++;
+	nr_src_probes = 0;
+	damon_for_each_probe(src_probe, src)
+		nr_src_probes++;
+	KUNIT_EXPECT_EQ(test, nr_dst_probes, nr_src_probes);
+	if (nr_dst_probes != nr_src_probes)
+		goto out;
+	nr_dst_probes = 0;
+	damon_for_each_probe(dst_probe, dst) {
+		src_probe = damon_nth_probe(nr_dst_probes, src);
+		KUNIT_EXPECT_EQ(test, src_probe->weight, dst_probe->weight);
+		nr_dst_probes++;
+	}
+out:
+	damon_destroy_ctx(dst);
+	damon_destroy_ctx(src);
+}
+
+static void damon_test_commit_probes(struct kunit *test)
+{
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){}, 0, (unsigned int[]){}, 0);
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){}, 0, (unsigned int[]){1}, 1);
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){}, 0, (unsigned int[]){1, 2}, 2);
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){1}, 1, (unsigned int[]){2}, 1);
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){1}, 1, (unsigned int[]){2, 3}, 2);
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){2, 3}, 2, (unsigned int[]){1}, 1);
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){2, 3}, 2, (unsigned int[]){}, 0);
+	damon_test_commit_probes_for(test,
+			(unsigned int[]){2}, 1, (unsigned int[]){}, 0);
+}
+
 static void damon_test_commit_ctx(struct kunit *test)
 {
 	struct damon_ctx *src, *dst;
@@ -1811,6 +1894,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
 	KUNIT_CASE(damon_test_commit_filter),
+	KUNIT_CASE(damon_test_commit_probes),
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_filter_out),
-- 
2.47.3
