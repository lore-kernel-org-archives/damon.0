Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52093B9931;
	Tue, 29 Sep 2026 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668890; cv=none; b=u6aynmjRUgX6AqzL+7ureYMNd1tfk22KjVzF5F3/+BMA3EYtWThlmUXcsUnbLH0UOfuJCtfE70+qoQIYXWmJcxfk7IjuNyy+nUmNNpBByAJFxkIy5GWogNHE4gnboc6yHh9OHkfKjeSVeNbZyUN/xbSRRBRAU4+qUF8b41yG6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668890; c=relaxed/simple;
	bh=13UFJC5xgyhM/2CR9RufQFENqMAb4s3595qZ7J4PYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT8RsJvpKHPR5rQJONtXP0LN/TdAG7TAxnrH41hQNICyAqSc67gqvn8SvJ3N/mv9adgj17JgvrhK2hW9bxLfIDnYqTGPOBmNDfA/X4u7I+cEaKosk2dHah1FVnsyVv5gZeMurVcoWqtDjxa8c3bMFV6FuLgs/4J/CF0WliC7NBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC5u6d3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC5u6d3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670281F000FF;
	Tue, 29 Sep 2026 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668888;
	bh=L5cEs7PRdoqMNSy5NOsa42xjR4QTiCW1/my5gdO7tFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YC5u6d3yluoDzHwp4Cpxt5vHFKrGn3wti3vDOFMYsUMQCb4bomj0Pvx4JQeJMJQCL
	 N0lyjbiLVSkur+o1P0OdoCHp2etn9/aC35dhq+T48T41uMztjCohjvsavxJwqqWSTz
	 w98GAVe54rZh84P7gFqjc3dlTMcxL5g4X3it3QfWCMWmUjqVzRb4vWdkcIXExpXXsT
	 jl3gNNsfMxRMhtw0YOKmk+Bypmo6uhhGkLmKlIx89p3hN17JvHkgTsCFyRPTRargD5
	 Qe6ZfKzNbo5J+glpqmAfsRHZTuBMbVW+6dgdAzeJNueIzDYvmqc6uikYKuQnkj0FGL
	 wvtpWGwCljG/A==
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
Subject: [PATCH 4/8] mm/damon/tests/core-kunit: test quota_goal->complement commit
Date: Tue, 29 Sep 2026 01:01:07 -0700
Message-ID: <20260929080113.41708-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929080113.41708-1-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend existing DAMOS quota goal commit unit test to test the complement
flag.  Set the source complement flag and confirm the destination is
updated to the given input.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5a924edb171f..ef146ca2ae8a 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -861,6 +861,7 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
 	damos_commit_quota_goal(dst, src);
 
 	KUNIT_EXPECT_EQ(test, dst->metric, src->metric);
+	KUNIT_EXPECT_EQ(test, dst->complement, src->complement);
 	KUNIT_EXPECT_EQ(test, dst->target_value, src->target_value);
 	if (src->metric == DAMOS_QUOTA_USER_INPUT)
 		KUNIT_EXPECT_EQ(test, dst->current_value, src->current_value);
@@ -904,6 +905,7 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 	damos_test_commit_quota_goal_for(test, &dst,
 			&(struct damos_quota_goal){
 			.metric = DAMOS_QUOTA_USER_INPUT,
+			.complement = true,
 			.target_value = 789,
 			.current_value = 12});
 	damos_test_commit_quota_goal_for(test, &dst,
-- 
2.47.3
