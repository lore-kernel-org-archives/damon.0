Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E73374A02;
	Thu, 30 Jul 2026 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386399; cv=none; b=Jba49Hd05E7Ccnsj61GfXg3JRXW8NQApuVKEwad+FZFbTjgPeR+kgaXZMUm4NFWtbK3cCWo5NAwdwr67qjKHod9bPZIpUrzaJZb9gpgK581E8QBgrLC3QEK4lvP+ecOQtMPVQ/bLdgmGbGl0AjAQMNT1W5Q0hANeY87RmkV1A4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386399; c=relaxed/simple;
	bh=cQ0vr2tOQJsXQ3PhVLbpZy60xjDpKRbWIqym6vb3ODE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgNHojf6+3ZRsUjgn/Eep6nDDzx+Z+auxIfvVI9pJgfJWnnHsbMyRjsQeCsXaWP8V2QwgSMBca00N0N8eG9zSHDjeYVJPZRBda1wmYnXLwkWyxsAmQ+gSWeOlL+JAzkcv4uP3ZySD3gosRj1/2djKZnW93fquE3KUk1CAoZxZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR5EwBmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR5EwBmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280931F00A3E;
	Thu, 30 Jul 2026 04:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386396;
	bh=liaC4gsoXyQOSeWbJsXi7paYTFzhMPeKXE7Q3rNWdA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RR5EwBmInBmc6wr6EdqCKxSapCPXsS9LvMd1PJuZcOZp+D6SB+pJQ9WVNnrBQOIxQ
	 j7ltUi5IPVTA6F5wMfIE8MxBdoCp92tGku5J1a2ztyR9dwMeSKv9UXH+PAyquRwpUg
	 nSML7ZM9CHpmx/01mVpcBKJF6sDq1gogwPtX1sdNcoKFr8epCiA6afiTcogvXQGYh+
	 nUXc2YkzeIgaT9/EFDrm9B9P/PEhFKCwpZmevXXX7kU9SoWs2OXBAvEMxmrDcBnMHF
	 rUTHgcaY97UfMbtsqPUgXL6Jas9vAG55HiMbxCYBYFgZYsqyoTVy60tEQTdjGA+HdE
	 f6EO03eQeJaCw==
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
Subject: [RFC PATCH v1.1 2/6] mm/damon/tests/core-kunit: add damon_commit_probes() test
Date: Wed, 29 Jul 2026 21:39:39 -0700
Message-ID: <20260730043944.146030-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730043944.146030-1-sj@kernel.org>
References: <20260730043944.146030-1-sj@kernel.org>
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
index 9cd2be03aeb9b..2ef0609b8d0e5 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1393,6 +1393,89 @@ static void damon_test_commit_filter(struct kunit *test)
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
@@ -1745,6 +1828,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
 	KUNIT_CASE(damon_test_commit_filter),
+	KUNIT_CASE(damon_test_commit_probes),
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3
