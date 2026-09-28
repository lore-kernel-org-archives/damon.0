Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA3492E53;
	Mon, 28 Sep 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588040; cv=none; b=rcYC10OFswOMbvG8qzYDIkZWYKZQ+afGdMOJuZoXgwOYo7MazutoJrk8KL1TY2VZQabNyixWvJXy2KLaLqParU2tON1PiXfmUTOfpQsxJGoCyRUvO/+0T2M6EwqyYV4lRRcQULQ72eylthCFJNVO1ZA5FotGZ6dBMUyDOn9/Xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588040; c=relaxed/simple;
	bh=7+B3Aoz7wXM7fMdP0vsFzx5YK/hE4EEVfI+9bZvFrL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc96DdIFxGt3+3ffTV/QIZMxXISQ4E2LFDGA0mGW6NUEC3undAauPwVg3H7z6e7GYszA9M21dP9+lawJJokHPHEQnc/EXIE+u5gE0aNAhfKw5Xlpj3oQAql5B+txCMX05S6iITxTeXdulx0LUGW0iX1hKF0g+kHJEedHuz1Vvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBYTnntk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBYTnntk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C291F00893;
	Mon, 28 Sep 2026 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588039;
	bh=bvxZAPrh873tByEC/VSENyOCS06X7bQblLdWzpYhHiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBYTnntkncMsChVyMJu37KR6cC45yYnLGJ16rQWkS0H11rc7ApcXxyQeC1g05Vm4h
	 2O8AOpqSLg3yXcuThqKfymMbpru2pSBdnlfZZhOh/LciGiFE/urZErF2O6Xiba3Ob4
	 hOrF5btSePr+E2Us3ViLVWgUCYR1bFxessGdeAIbQsxsWEC0Ow/SIxNU3bZPUJ627M
	 mgIiCflTx8vx8jPKM4WFBjfSX9N7EAlR5WXYywdonfWJj7Z/aDb96nwf+bbohPLI6K
	 spm2IHi1ncYXUEi6DmeR88Sxrp5ZWgyLhiSgOMUwLU/DEHDq6rytfaZqySrlaXGpuK
	 N3eVpkMPvZR9Q==
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
Subject: [RFC PATCH v5 4/8] mm/damon/tests/core-kunit: test quota_goal->complement commit
Date: Mon, 28 Sep 2026 02:33:36 -0700
Message-ID: <20260928093342.16584-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928093342.16584-1-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
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
index 945037fe4be9..251b300eaa50 100644
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
