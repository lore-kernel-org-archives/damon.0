Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD523A9DAD;
	Sat,  4 Apr 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320796; cv=none; b=ITzmfdpF9CiZu3rs+6PkgrljjOzCq0ivTx7lJ3mUTaTeplHv6keAYMoUm+dcaoXsf44ImwS9Yy7OeoZp8zwl8YVan+KZ2lAJ6C85YKo4QB5XYx6afwuhHXyuiAZ4nBTM06BoCv4cz1nFqZVI0BD3FkqIpLjKInQeGQJgwcSmPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320796; c=relaxed/simple;
	bh=b4CXGO6BtXvCfJCLfnWiBdtEE+beFehwNMWLSu4Nq0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVu0xL9w8Q1lJdDl9GLBjSWRtvX2IlqQek//hJ9yUzVUWR6RXDHt/Rf7QlzZBfPh4imCRR0rgfUiYPjmp2uFIqKDP0YwvLxldzO115BXVrhoJGVX1AgjFLN/A4G9NQvPkrIyGEeIU6EOW/BSOrVnSsxlu7h5ODt/R34dDLxAwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qao+zlqE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qao+zlqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5847EC19421;
	Sat,  4 Apr 2026 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320796;
	bh=b4CXGO6BtXvCfJCLfnWiBdtEE+beFehwNMWLSu4Nq0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qao+zlqEWV9F2q0IEVtzTXnMp+hsLYhkJsfLY7Lw6VwDwLfxub4N9+Hbr6CtWkv5C
	 KsMrIjvKAQr5aa2X04R6FmYuB5mE5sJTZkTTAwdIKLM86b4utjrMVYp4K/CEmbSP68
	 PvZcybMJKQrSb8c9yaQLc6yoQGniZ5y9smTvwgESB++vise5+u344cnSBJ6BaAA/1F
	 H40fCHq5P2lkP182YUVsrVsCTU9pNCaqG1TjDZzednK4skOxBNTPYCcPZheIOB7ziG
	 0+V536TSC37LkHY8zlN7Gi6gGFBH2xxECO7Xg99seqrGGmKiH0S4htDgh5qUUCz0na
	 CZZrtBH74Sx4g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/9] mm/damon/tests/core-kunit: test fail_charge_{num,denom} committing
Date: Sat,  4 Apr 2026 09:39:36 -0700
Message-ID: <20260404163943.89278-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: <20260404163943.89278-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend damos_test_commit_quotas() kunit test to ensure
damos_commit_quota() handles fail_charge_{num,denom} parameters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0030f682b23b7..16f68315ba119 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -694,6 +694,8 @@ static void damos_test_commit_quota(struct kunit *test)
 		.ms = 2,
 		.sz = 3,
 		.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_CONSIST,
+		.fail_charge_num = 2,
+		.fail_charge_denom = 3,
 		.weight_sz = 4,
 		.weight_nr_accesses = 5,
 		.weight_age = 6,
@@ -703,6 +705,8 @@ static void damos_test_commit_quota(struct kunit *test)
 		.ms = 8,
 		.sz = 9,
 		.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
+		.fail_charge_num = 1,
+		.fail_charge_denom = 1024,
 		.weight_sz = 10,
 		.weight_nr_accesses = 11,
 		.weight_age = 12,
@@ -717,6 +721,8 @@ static void damos_test_commit_quota(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dst.ms, src.ms);
 	KUNIT_EXPECT_EQ(test, dst.sz, src.sz);
 	KUNIT_EXPECT_EQ(test, dst.goal_tuner, src.goal_tuner);
+	KUNIT_EXPECT_EQ(test, dst.fail_charge_num, 1);
+	KUNIT_EXPECT_EQ(test, dst.fail_charge_denom, 1024);
 	KUNIT_EXPECT_EQ(test, dst.weight_sz, src.weight_sz);
 	KUNIT_EXPECT_EQ(test, dst.weight_nr_accesses, src.weight_nr_accesses);
 	KUNIT_EXPECT_EQ(test, dst.weight_age, src.weight_age);
-- 
2.47.3
