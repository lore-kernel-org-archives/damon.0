Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CE3DA5B9;
	Thu,  9 Apr 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744521; cv=none; b=FFdxwE2YND6O5lbZ6+4QxI7F4mj/Onr/f2lViieJqNem4VEa2SIZ5Xq8b9BUlM2KoEH0nOK1y6lNMIy+oaXFPxN3bx+HPeRRX3CzitwUzACLMfm/YH04c6MX8EHyAkwEsuA/vxy5p5RfiMZaedr2lsior6kuo36AcADiGDOY5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744521; c=relaxed/simple;
	bh=oBXW5uIN8lzshHczxlHFHeX8VLmiX/5T2Hz8N+WZ/sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji/KfwEZquDawYZ5Ct91VLOxjTkbWOr6g78SsVQEQK/TTPXPsx/zObySXd0sZ6AUfMzuvZr1pQjt5E4Z2Hxl1GS1toJEWvt0nFlbSiYcOGj5VqY2bdUUoTnQsnxfFE/Zd7hzD/aZ9myvRilhl/qsMg7ybEC0T0yPpr7J/KJxqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG0EerkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG0EerkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C89C19424;
	Thu,  9 Apr 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744521;
	bh=oBXW5uIN8lzshHczxlHFHeX8VLmiX/5T2Hz8N+WZ/sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mG0EerkIiWXO/JhNf6dSmW4UlSyrnzmIhzLE/KjFgogaQCYgaejI1UOz9d3lXPg9z
	 tPmdXPVkcI9YxidqvcLpYDgqXOWnVQWRw6GxCK0srLLKQgJU0hp8DB43Oydn9WaJrx
	 jlNGLVY90llnVQ/aJBDspIqKBYx85OJVjzlVwq/3EEhjAdu2eECuo04ClE1+SPmhSK
	 lKncYJGBbgg9UWHoJMPLurMfgKO/JeYKj+bthU+vvB9Un5b3dxZgOaATP0i3/NLsLQ
	 cM2B1JSpn3xlS7YjBdcwf0gVS8psuTBCC42Igh6wveEXEIlI6g/JP1/Kv86+ySHafv
	 wOlWQxvl7pqvA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 08/11] mm/damon/tests/core-kunit: test fail_charge_{num,denom} committing
Date: Thu,  9 Apr 2026 07:21:43 -0700
Message-ID: <20260409142148.60652-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409142148.60652-1-sj@kernel.org>
References: <20260409142148.60652-1-sj@kernel.org>
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
