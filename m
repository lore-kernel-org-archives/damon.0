Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90D3AF662;
	Fri, 18 Sep 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741718; cv=none; b=XoO2hLwHu/70LRjb3AylqRpWC1//MR5x2GP02F5rbvcpXRWx5IQpzWDMX+JMS0VGpRzop1gfVMRDfBVGVyy78KGkYbh4/GuDHPNIWnuXbL6Z9FnqT3IXpf3hoxt2zQMb+XfCkNnVxVF19RWmDKJdSDMFbbc3PgPVts5xX/0EnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741718; c=relaxed/simple;
	bh=GDXvN/oUdxtfz8ODbwp2BnCBx7mlLzYNo2acZWvIxyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN/ul0uF5Om84CL+t5ppziG0aOgWq0TMWGXvBcm5prib56vKp6Zw/8PCbRPcfptMxIII9O2qNpEu3wHbQq6B++J23dgLIQnUROSLrp78sSgUaW6O7PvAcz6d+zWOP29J2qoTyOxINZcYqBWIZLwcNJ8x1MjxLo4/nCzS2HwVZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3UKdxmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3UKdxmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28071F0089A;
	Fri, 18 Sep 2026 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741717;
	bh=yRWBrRHzXRD4yV6zK3pssB5trIwz9nJ/p0K/bKugcGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3UKdxmkO5xWdreA65UuGBv1dqMomRvgd54gkrZ8RGNPAlQjZAq+HKNGLEcYZQdbE
	 7FlyQwK7gtWLhJdK+doRYKhEDNLUliIW6k7PyptSPoUO0cuxoq+Fme7pGTKaxWfBSL
	 gHas31tt1h9X4+SvaTrHq9RL8a35T82XKwc0oj6+Tep7ja5PVwwdhwXFIadaRuQ7tt
	 knun83sYAYvGf4A+FOw8JMPrtT6Pz+/iN+j5GrXLKzVQoTjnFEa6vXE5FS5Zl2RwN1
	 zf03kLTVzXa6oPA87qFQqd2OEkjZ61EV+erS0KYZKfnzaFcYg04rXISNChyqAb2eWf
	 Nl19yQJQ3PYHA==
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
Subject: [RFC PATCH 4/7] mm/damon/tests/core-kunit: test quota_goal->complement commit
Date: Fri, 18 Sep 2026 07:28:23 -0700
Message-ID: <20260918142827.85303-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142827.85303-1-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
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
index e8290a2c6f343..a2504e96954f7 100644
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
