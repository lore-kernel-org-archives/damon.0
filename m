Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84762D879E;
	Tue, 28 Apr 2026 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340073; cv=none; b=h+wd2aCZAtAdemedFEAeAYGnBAS1kZ3opQB+aXTwcHEvWTAPTNjhHWQLfr0o54q1QR6MwkNVM3bv+7rWzT/97Y9dAKfSnQEoPA9Jwnq0tVmiAUoRDexWYs/DorN+SYM57QZkQjo2neFX6Lv9gnA22gdqNF+ENNAMn85mfp9zCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340073; c=relaxed/simple;
	bh=oBXW5uIN8lzshHczxlHFHeX8VLmiX/5T2Hz8N+WZ/sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ+sDi85JEwP9QqmvuR2pqSiR8p2f+0fQEdF+Nyc1Aqvb2Geu239ZijSLRURNWZxc4UXfalWgDKfOhmeQLtpK6WxIMYIJscYJxFANrNTIdP4SoSFVd2p/gtvx9iTko0u0Q0WC5T9OzJL4GPv3b9jwAlt8+cXFVPIzFtOEErdQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwyTEHm8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwyTEHm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36923C2BCB7;
	Tue, 28 Apr 2026 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340073;
	bh=oBXW5uIN8lzshHczxlHFHeX8VLmiX/5T2Hz8N+WZ/sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwyTEHm80Or8EoY3Y07sV+u4M/imSwhr2NI0NYYsImWzS9cLsSA/sONsLP/uxH4zd
	 JFLXuIneV4KEm03obAG4R0/ElK0W1CxHEiI4RErdHC5yCC1LKSmS50QqmIJ1Syh+LC
	 AGiBLAjkj/WZfIJhueEAYhHfvJ1VE/HbEF6E8LMOQzWUi/CSB9+b4b5Ocu7BYnzDOA
	 t2bRTPJYgBWhNJdVKuEJqhZkwwddYM+Nn2k3r/mYk+qPUAL27mEAqrBGR8Ll5cicq6
	 bqu8yQQFy2oVO8G5gtuSUOhZMNycXJjWsOBHFF8ct6uIaKun6Dq8ClW3Ve/2yZ91HB
	 R/Nptel5v+z8Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/11] mm/damon/tests/core-kunit: test fail_charge_{num,denom} committing
Date: Mon, 27 Apr 2026 18:33:57 -0700
Message-ID: <20260428013402.115171-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
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
index 0030f682b23b7..1b23a22ac04c4 100644
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
+	KUNIT_EXPECT_EQ(test, dst.fail_charge_num, src.fail_charge_num);
+	KUNIT_EXPECT_EQ(test, dst.fail_charge_denom, src.fail_charge_denom);
 	KUNIT_EXPECT_EQ(test, dst.weight_sz, src.weight_sz);
 	KUNIT_EXPECT_EQ(test, dst.weight_nr_accesses, src.weight_nr_accesses);
 	KUNIT_EXPECT_EQ(test, dst.weight_age, src.weight_age);
-- 
2.47.3
