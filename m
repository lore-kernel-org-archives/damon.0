Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B447F2D3;
	Wed,  2 Sep 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357819; cv=none; b=O4ot00ZTdMw2gCN/Ww9pXAAG9psODusDUrhQdE9bPaslLHjzqhNLERGQqNTRhJ+63y3b/S29kon4Qe+DSjUhBKRpjA+jhwORm1DfNc//o2H/kICsw32r91FPTZqTQ5KmGrPeRsUVDTqeJa7dJR+ne+25cx6LakIiWklKs2CD2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357819; c=relaxed/simple;
	bh=yuRjMV6HPxxGg3F8T//08K7nMtyRS0b4BVjN4ba2aTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2HQbjZnhW6K+bCGHSp+JESxIKajJ7gSMnyUDJQ/31eT3I4Mnd/dL892eTIxHJ1yxmP56pWTtXqT+DlniaK30WVQ2vRh9hRiLUcNPY1PndmRoagQgWgn9gLL0tA6wKBooa172kKD1NKpfl8gZ9VxNJOr1VUULXBEsWE5pFfGT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlBh8+Wj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlBh8+Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F8C1F00A3D;
	Wed,  2 Sep 2026 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357818;
	bh=kRgNHsjFIHJ5E6PMMKzx1XWhx+ToWlevPqGLUpHC1XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlBh8+WjuF2tUrcxK9t8i6OKujglfGERH1zT9Ygc6ORXDetBsjv9UkXIFPqat4qQ/
	 XxncyUXVP54V9k1BE3y8dWajPTkMQFkwKuk0ZuKXnC2dI9HngItnFELEAuGjITSNDl
	 MQ/nOi7ad3OeZoVC6LjxAp3qr17gxsqPNEPcudfcbphgNtcisXwHuWLbuun77C0usV
	 pUWFJavZyMgYMZRK7/wFPzocZGYf6PR/6ryvRh9lvs2ab+TDN0FGpXL9BFcxICOmWn
	 f3SpQgIuEPObRLv1sQhlxhrxZ/lwGw4P00nBuBC/e5tlMazAXyQWveSIgGeRpk3lp9
	 H049qrbpP/sPQ==
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
Subject: [PATCH 1/6] mm/damon/tests/core-kunit: test damon_commit_filter()
Date: Wed,  2 Sep 2026 07:03:07 -0700
Message-ID: <20260902140313.85983-2-sj@kernel.org>
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

Add kunit test to ensure damon_commit_filter() updates destination
filter as expected for valid inputs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index d0bed01a5b7fe..c2ddef3c76d35 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1364,6 +1364,45 @@ static void damon_test_commit_target_regions(struct kunit *test)
 			(unsigned long[][2]) {{3, 8}, {8, 10}}, 2);
 }
 
+static void damon_test_commit_filter_for(struct kunit *test,
+		struct damon_filter *dst, struct damon_filter *src)
+{
+	damon_commit_filter(dst, src);
+	KUNIT_EXPECT_EQ(test, dst->type, src->type);
+	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
+	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
+	switch (src->type) {
+	case DAMON_FILTER_TYPE_MEMCG:
+		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
+		break;
+	default:
+		break;
+	}
+}
+
+static void damon_test_commit_filter(struct kunit *test)
+{
+	struct damon_filter dst = {
+		.type = DAMON_FILTER_TYPE_ANON,
+		.matching = false,
+		.allow = false,
+	};
+
+	damon_test_commit_filter_for(test, &dst,
+			&(struct damon_filter){
+			.type = DAMON_FILTER_TYPE_ANON,
+			.matching = true,
+			.allow = true,
+			});
+	damon_test_commit_filter_for(test, &dst,
+			&(struct damon_filter){
+			.type = DAMON_FILTER_TYPE_MEMCG,
+			.matching = false,
+			.allow = false,
+			.memcg_id = 123,
+			});
+}
+
 static void damon_test_commit_ctx(struct kunit *test)
 {
 	struct damon_ctx *src, *dst;
@@ -1771,6 +1810,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_pageout),
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
+	KUNIT_CASE(damon_test_commit_filter),
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_filter_out),
-- 
2.47.3
