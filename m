Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5737E2EE;
	Sat, 19 Sep 2026 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780461; cv=none; b=k8/OnrnVlOFPT0Sad+C4DRJ8aq6o18D+XbXfm4DuOfbdsu5uqA3sDzpjIFGVl7hk0g+NSX2tL6bcXn/mrabmiDiBnxwE/f+QvOBjDNB4awGWzZZWbzchKdtwmYvqsFh/ydAQm8uPMn9uU39FlqpEyvK8NOrHc7EqMi0sUgtXlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780461; c=relaxed/simple;
	bh=GDXvN/oUdxtfz8ODbwp2BnCBx7mlLzYNo2acZWvIxyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+Ri5zsF5UnNou/qL81euYyePux7Wpx7geEzwxKB1DKdF/YI/jHMtqTixnX0uN1KpcgT/OouFn1uwcpGXze9b+UAiqotfd2CjXu4PGhfwiBXjl4u3HzTO9/pyDMy4tb7+2Gc1tc//Xlp9idz0Plf1NCdd6hU+GmbZcza8tPhStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/eUpwDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/eUpwDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFED1F0089B;
	Sat, 19 Sep 2026 01:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780449;
	bh=yRWBrRHzXRD4yV6zK3pssB5trIwz9nJ/p0K/bKugcGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/eUpwDe+6EpsVRHBLLOe8RKee8YZX9K9fwa0l2tZlIaeY9bJvCcF4Q76jGjVXuqY
	 uOSiQBCMHU3oyHyzBvgNxmD1OYYvaX4RinwQCDslB4XCmzhJcz/oVhKsGlgpymI8Vc
	 ++ScuqaRzrhYHbILzrAhUax6Q7rOY06/4sokwMgXm3ejct4PADva0R4e8uAmgP787g
	 Vtpqeq8ddSWArCdZzuqnc+qwysC0MrFrmdnzipHMYFdBzdawmODXEWMdh43P4W6jJI
	 yhtcQNScxw7SbUeEvV+d2NEng0a5nfwBl7SOQQPByymTSpkHy3mtVLla6b/4mF1gXW
	 FnTZUVqa26aQg==
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
Subject: [RFC PATCH v2 4/7] mm/damon/tests/core-kunit: test quota_goal->complement commit
Date: Fri, 18 Sep 2026 18:13:53 -0700
Message-ID: <20260919011359.88921-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919011359.88921-1-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
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
