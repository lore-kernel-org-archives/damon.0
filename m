Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753423E866B;
	Sun, 27 Sep 2026 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510754; cv=none; b=tQFmgFS2iPZEzGSVMkGzCxM/iUJeIz30iddIn7OKpeGJKxkR1J+qzXjDihd8bs+SK/Gt9C4CotWW+QjbKXQLcnZo7M1STU1BOSJA6mORPoZy+BhzkI4E2+0vwe2GZ1ClF+8oWVNI4nmBUFI1PJa2c5/wPw++mmwfEn0pG0HACQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510754; c=relaxed/simple;
	bh=c5dpY8t8NR19qmsFL9+HNNFFopcTwhkAr61MOmon9sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIsb7eF/5epDBEiEm2UAIDJ1LjPEhGyiOHZpbknk+eVL6TlS1PeyOLIM00fl2HS+WTHHCaDtq52teLpOgzO1nKICZHrVSrcNhOsB/jzkJ3ch/duXoM132ycaDhAxc5rGBl1hlbx+EA+LrtdnrvBDloZzxbvdFp5Yu3Qprqy6zxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVfVx3q3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVfVx3q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CCA1F000FF;
	Sun, 27 Sep 2026 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790510753;
	bh=2LAOr2VrxDMxvqQVVQdJq9DDAXVVY7pPMrYfBvs5+RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVfVx3q3qHk+eJC7JbErH4YF5G90ayd/Xe4ajV0iC9bi8YpaoVAoy8LN0wbwIWqsL
	 PBKNLRSU5dlh/U/+WN6Cl9j4a53mtI4issK0ovHIBWpBt3/t5zst+WzitkykbKGsCm
	 c3u2DZwtiQmSSefgM9wUYitHEBoz9OWCCGyKhuqCNdjfm846PaqhJtMct0UfZsKQ7B
	 jVBLVHci3mA5bTHW1Ty0f9tURi3pFywzjMEYwUdqG2a0nD5ne2HxMI+OZjKqzDDvU9
	 H1gTW/15pweBAjLhcDcBgzqofgOXDkhJMkAFNkIRBkVmawQneoX/ewd2QozwrlwOrV
	 1gbR/69o8iDzA==
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
Subject: [RFC PATCH v4 4/7] mm/damon/tests/core-kunit: test quota_goal->complement commit
Date: Sun, 27 Sep 2026 05:05:28 -0700
Message-ID: <20260927120533.50484-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927120533.50484-1-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
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
index 20bba7421a40..6a13d9bd377c 100644
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
