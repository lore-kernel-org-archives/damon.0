Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FEF470433;
	Wed, 23 Sep 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158521; cv=none; b=EenWVsjOOxl5V0zpoLW10NXKbdVpAK1EQlJA2D9GSKaGck2XdB1pA27SWRR4Qdjr5erknwRfXoSAyQsh2MPIwwL1pQ8L6haH3ahzDGhN+QQptpup+qVHdlpc5/CsX0Zrf5jDrKT7QOUTkSyqXytt67zRJYnWrZukcUdXBXgFhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158521; c=relaxed/simple;
	bh=2NG2VfGFk0r9dWmBXWLbaQ/ZCUEaA/xPBsh57g7HauI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqtI5PJ/C+9viUnNz/OgUbI6QWd1wS4Sd0Uk++sbSltw9GCaPOd2Ff7BZnspLfuhqkylYxVFJEmgKNxO3bvN/ScbvDGxan9WWjYNFs9CX/5epidRmDRP8XcUYMDmXSOvhpRR14t2cEdQkMnbQZvslrvD1SImLmwDqcQ6aOz+dKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnImGiUN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnImGiUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA431F0089A;
	Wed, 23 Sep 2026 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158511;
	bh=k7YELTFQNH7j9BvemS3D+5shFIScXDKY2I62M6OGUww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnImGiUN2/myjs8Neflq48mmgdjZYYc4VUBwwh2d5bAoxr1jP23mCfwMS147zHAm8
	 9RfCTWuUfbGB0E20WzRr1BQs3W2SnLuaQ6+Hm8athKeteLLdgCwOZjNxh7aHwlWR+C
	 OV+DejIdfvd2tlhLIKviB67wyTwKopviC3Flv1Keae97Q6obY0leVmd5hdIjQG6jRV
	 7ZB/VYTs+yCx9uIS6AUZ9VY9xuNEQm1xje2pWk9Hk+ODKIgMuhn7cRrCJBewR0Urxa
	 tN1jILP0idlevObPsRWYCsQ9EM9kDCxBu/1WUfvRG97iCyUssBhigUWNZ0QeWqpNjZ
	 ntTWsFGili3HQ==
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
Subject: [RFC PATCH v3 4/7] mm/damon/tests/core-kunit: test quota_goal->complement commit
Date: Wed, 23 Sep 2026 03:14:49 -0700
Message-ID: <20260923101454.5748-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923101454.5748-1-sj@kernel.org>
References: <20260923101454.5748-1-sj@kernel.org>
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
index 72dfb9c595a4..ce15e693bc0e 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -819,6 +819,7 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
 	damos_commit_quota_goal(dst, src);
 
 	KUNIT_EXPECT_EQ(test, dst->metric, src->metric);
+	KUNIT_EXPECT_EQ(test, dst->complement, src->complement);
 	KUNIT_EXPECT_EQ(test, dst->target_value, src->target_value);
 	if (src->metric == DAMOS_QUOTA_USER_INPUT)
 		KUNIT_EXPECT_EQ(test, dst->current_value, src->current_value);
@@ -862,6 +863,7 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 	damos_test_commit_quota_goal_for(test, &dst,
 			&(struct damos_quota_goal){
 			.metric = DAMOS_QUOTA_USER_INPUT,
+			.complement = true,
 			.target_value = 789,
 			.current_value = 12});
 	damos_test_commit_quota_goal_for(test, &dst,
-- 
2.47.3
