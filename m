Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEA47ECF8;
	Wed, 29 Jul 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336465; cv=none; b=a2/DbeWmarNF6xWwfAMeynP5cmW6OHhdFyDdtv5wLy0sTEWLmrteT3pgRqNL7abSQg44ERvI71vJUoxKNIoKif0DGkmULeiqvpYZwZfR2RQW6eK0gUhohnKLKc9WsXvLd3NqCdzsvfT/jgcpI8R6E+LUm76p4qvFB878AhDaCOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336465; c=relaxed/simple;
	bh=KSDBHK+3zcJDp2gVlCanQV1rzy+ZpyDI1LK0Tf5n8Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq83pKo/My8y65whfWwtwIh8GS9CC/yh0V0R3j/+vhMPJJU6Qm0AT16+b8OtgFQJZRdsOzzzx0ZxjGzhG0xsMwc8dFtoyZqe829+5bwsocbUfE7XNN4QU7PZtdNANyIyalePAIwTrhZ0aNPZhX91GoYp8/IE8b5PE+uFlm3SJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcr4TtLE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcr4TtLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE531F000E9;
	Wed, 29 Jul 2026 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336463;
	bh=PMEdbVHoJrZwuzmNn8i5Bad/INZcQ1/1hylklN9wYVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mcr4TtLEwYI08+sEBA7Qj3ucQ/+RqsPgHruJ9i70JRLeUkhdzwRrlVfl4g+zu5SaQ
	 XY6qtQsbSvBXJUsy2KE3ezjV7jK/9Z3qtPVxaqVmX+pSbb9Sse3l3BwuPAxcuHOGZB
	 o2j7RF0TTeGnBEHBk3jm/jA1sqthS+PPxDf4BHoiGavgwVcIZ/aDJrIGtJmRxsZnLN
	 NUdJgRCt8nFB2Bk/yplzP7TjG8oO5bOvQaFc4IqaBcZu5o6kCUFB7BgkzLrHp8HNar
	 3VgRKsnrdqPpA/LJy7I0TGMX227cEkXpdq9LdynEUHpL95TE+wENo3K4xTSOgdy9v9
	 4G5HxGwFm2pMQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/6] mm/damon/tests/core-kunit: add damon_commit_probes() test
Date: Wed, 29 Jul 2026 07:47:33 -0700
Message-ID: <20260729144738.90895-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729144738.90895-1-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
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
 mm/damon/tests/core-kunit.h | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ff864402e9c75..d1e8c612fea03 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1393,6 +1393,86 @@ static void damon_test_commit_filter(struct kunit *test)
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
+		return;
+	nr_dst_probes = 0;
+	damon_for_each_probe(dst_probe, dst)
+		nr_dst_probes++;
+	nr_src_probes = 0;
+	damon_for_each_probe(src_probe, src)
+		nr_src_probes++;
+	KUNIT_EXPECT_EQ(test, nr_dst_probes, nr_src_probes);
+	nr_dst_probes = 0;
+	damon_for_each_probe(dst_probe, dst) {
+		src_probe = damon_nth_probe(nr_dst_probes, src);
+		KUNIT_EXPECT_EQ(test, src_probe->weight, dst_probe->weight);
+		nr_dst_probes++;
+	}
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
@@ -1745,6 +1825,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
 	KUNIT_CASE(damon_test_commit_filter),
+	KUNIT_CASE(damon_test_commit_probes),
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3
