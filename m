Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8030C621;
	Tue, 10 Mar 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104741; cv=none; b=pJXr12uZA2cE5zrsUZTjhEHc5Sy05fF+tbVcBSwfh2fKijdWkr6hcPgSEPp4d5LcIJd0yYu0lWUbc+ijFhzDw5iy3YLKO0S3YJqMaU7fCgMEPwgclAqOcD29txY2amc/tp0k0nvZi+mRaaKHscyFMlyRlmbGYB3nautrlhhRhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104741; c=relaxed/simple;
	bh=RnZI/MXRpMMVI21PH3lD5eWdT2CRwxGrwP2sFfAnvFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr2Y9RQ4S573FcO4bZoQnKP75E92ClECuRlKBImYfO17OLBeQlNf8bB8BNg2JCFZ0r61ViR/PQHa97+aFboBk14VpZ9cWGYvuQvYwV3cqSQ+Depbu8E77hgBLP1+i3i3b9c5UVygBZWI7Kw7j1eCHKgBGI6TGN33q9DXN9HUvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlaywHj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlaywHj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DA2C2BCAF;
	Tue, 10 Mar 2026 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104740;
	bh=RnZI/MXRpMMVI21PH3lD5eWdT2CRwxGrwP2sFfAnvFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlaywHj+K9Zz2qhj7I/fWERoGNXH/0LTgb4PdowthXyd5FwlOhmslyFIZVF6MfnW4
	 lu6sAjCygck1yJ50owxWPe+2ogZEGybivoRQTi6jwkZUegDx2Om42qstvvTRxM1xnk
	 w/p/ek4mLghJswoGvuTMoekqXnrVUougnaKYcrJOMUojXiqCK4TKOwYi3CB3GkhJcX
	 OtfWIviJ5z0K5CTEaqw1J4sGw8ECJsbAQPg6W1wS3uKfb0+HpPI//zFwSgE3LhNbn4
	 KvkR2hPivPaKl7ELQZRIXpC19bxZUrkQ9eFqm/hfxdIQCeMORQkeelINdGfu6uE0Gv
	 0nfdGv4YoRJ5w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/11] mm/damon/tests/core-kunit: test goal_tuner commit
Date: Mon,  9 Mar 2026 18:05:24 -0700
Message-ID: <20260310010529.91162-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310010529.91162-1-sj@kernel.org>
References: <20260310010529.91162-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend damos_commit_quota() kunit test for the newly added goal_tuner
parameter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index e86d4f4fe261a..9e5904c2beeb2 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -693,6 +693,7 @@ static void damos_test_commit_quota(struct kunit *test)
 		.reset_interval = 1,
 		.ms = 2,
 		.sz = 3,
+		.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_CONSIST,
 		.weight_sz = 4,
 		.weight_nr_accesses = 5,
 		.weight_age = 6,
@@ -701,6 +702,7 @@ static void damos_test_commit_quota(struct kunit *test)
 		.reset_interval = 7,
 		.ms = 8,
 		.sz = 9,
+		.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
 		.weight_sz = 10,
 		.weight_nr_accesses = 11,
 		.weight_age = 12,
@@ -714,6 +716,7 @@ static void damos_test_commit_quota(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dst.reset_interval, src.reset_interval);
 	KUNIT_EXPECT_EQ(test, dst.ms, src.ms);
 	KUNIT_EXPECT_EQ(test, dst.sz, src.sz);
+	KUNIT_EXPECT_EQ(test, dst.goal_tuner, src.goal_tuner);
 	KUNIT_EXPECT_EQ(test, dst.weight_sz, src.weight_sz);
 	KUNIT_EXPECT_EQ(test, dst.weight_nr_accesses, src.weight_nr_accesses);
 	KUNIT_EXPECT_EQ(test, dst.weight_age, src.weight_age);
-- 
2.47.3
