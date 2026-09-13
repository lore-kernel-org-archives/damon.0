Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E0389106;
	Sun, 13 Sep 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319838; cv=none; b=oJMTUrsF43S/LxGuiwe8ywkFvr0yViiLd0W6OwoiOKZYkSKvggPCgu5Da+tufzrV2X85/9VVgKWBYhP2Hg8voxphCeHfuKaU4wxWfoHZYPj1sLYsLhHEluGYlBcfsFcdE/fZxTM+893WJher8cwFV8E2bfhhGFojT+dJHoCtOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319838; c=relaxed/simple;
	bh=S3b6wCMSIhA5OZ0fTX5hY3QoKyzxhQ3s8RJHucABZXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFVCr9aYKviM6cWwsBHMdpp/LbZW545zW4zqDSiJzoSfRpBC122Xu7WcUE9nGRxMfUrtj++C7/BdZ3K8HregiLPJfmF/3QIdWPSu89NrrVGyaFCAJ4xDrgYN31MaU0QKO77eWfXl9PhijqM8Pu6Hc6A/PoT72xFkE2qliQsSKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4W7py6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4W7py6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98D71F00899;
	Sun, 13 Sep 2026 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319837;
	bh=nqfaQq4DYDAwDcS6eX/vnZ8ZZiveWwkFxlbgk1mGGIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H4W7py6aOI53Y/ZvNSunZRHFe0l0i6pGkVwow4aMEflbBTjd5mP73d/jl4iuSE70w
	 /wMFvEg+0UIYFIoEVo3WqwWNj/gFLtEaiCpbb3iCkP144bNl+M74+2wCvC01cCK+hV
	 8fnB74LyzDzBwjdXY70NVF2vwiQZy0ru2VnbjyQIKq+y3tDkBc2HertUhRQBF7vz5a
	 juJklc1eGsYaq31xW8meHEK1YRl0Wo9eUadCuSSylpj3dz6eZAlIsCF90TCJ1sUAUd
	 Z6w/90du8neSMJ4i5vBWBP1W0V6eZrUZdmcDO+dDrf2GqhFrQTWKwuol3yI8zdQIcL
	 3rM52daiIfvxA==
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
Subject: [RFC PATCH v2 7/8] mm/damon/core-kunit: extend damos_commit_filter_for() for wrong input
Date: Sun, 13 Sep 2026 10:17:04 -0700
Message-ID: <20260913171706.103052-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171706.103052-1-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_filter_for() supposes damos_commit_filter() to always
succeed with given inputs.  damos_commit_filter() could return an error
for invalid inputs.  Existing callers always pass only valid inputs, but
they may pass invalid inputs in future, for test purposes.  Extend the
function to be able to be used for wrong inputs-caused error testing.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a47a5cdf285c8..c9941f3bfb42b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1127,9 +1127,15 @@ static void damos_test_commit_dests(struct kunit *test)
 }
 
 static void damos_test_commit_filter_for(struct kunit *test,
-		struct damos_filter *dst, struct damos_filter *src)
+		struct damos_filter *dst, struct damos_filter *src,
+		bool expect_fail)
 {
-	damos_commit_filter(dst, src);
+	int err;
+
+	err = damos_commit_filter(dst, src);
+	KUNIT_EXPECT_EQ(test, err != 0, expect_fail);
+	if (expect_fail)
+		return;
 	KUNIT_EXPECT_EQ(test, dst->type, src->type);
 	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
 	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
@@ -1168,47 +1174,47 @@ static void damos_test_commit_filter(struct kunit *test)
 			.type = DAMOS_FILTER_TYPE_ANON,
 			.matching = true,
 			.allow = true,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_MEMCG,
 			.matching = false,
 			.allow = false,
 			.memcg_id = 123,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_YOUNG,
 			.matching = true,
 			.allow = true,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
 			.matching = false,
 			.allow = false,
 			.sz_range = {.min = 234, .max = 345},
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_UNMAPPED,
 			.matching = true,
 			.allow = true,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_ADDR,
 			.matching = false,
 			.allow = false,
 			.addr_range = {.start = 456, .end = 567},
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_TARGET,
 			.matching = true,
 			.allow = true,
 			.target_idx = 6,
-			});
+			}, false);
 }
 
 static void damos_test_help_initailize_scheme(struct damos *scheme)
-- 
2.47.3
