Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7E377ABA;
	Sat, 12 Sep 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243706; cv=none; b=MYZLTR9z+dTIE7g3sGDoq3inZIIOFUh0ng8uykSKbFvS0lqmIgBviUPxYOhbtGaHj1p0lxUq/GarkCJ0jRFbUl7/dAugfv3RzA1tjkpu6KvMfGbx/CZxswz74u9J+p6TSdW7xWNEIGr+v0ZK0+t3fLgV75+k7wuh3YDkCJ2VJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243706; c=relaxed/simple;
	bh=tj57dOkpo5p8mqK620ygw5xHdLzVPd/Z+Uk+Xtaw24o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLGNj4Xc4xicDvy0ORN/74U9rCvhSSSNQ4rjdN0tdvtfDPjp6U+87fmKjBYj3vU5++/H8iReiY+7PVOjHIqeqfeuEKwBYSEPiiuMICD8WWwh0FeLjnCyybtqY+dFYYY9dtoDj46AnfbMcvDcj85saLMkGtdniVSQTYDXkZx5+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr2Ct0gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr2Ct0gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41F11F00898;
	Sat, 12 Sep 2026 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243705;
	bh=lL1r3CUzqH0YyqVpSIiKQgN1c4eEo+XPmJg0bTQTEPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fr2Ct0gjx4ey0HMKZepWjvvdEdapyTx2PkS66AnwV5UQk0uNr5wG1pgfCcUH3xCFR
	 qoVkZgJUj29+fIgDyZ0H61stEZv38yIKh/TXvgJGKs2ENWdJa7RYznv++695Hyddnc
	 1vue1U9ySEs44c8LZMnPE6p9wVc2MMGQVxtRBCEmW0mxROCJbTpYDxHZhmhwSJKD/J
	 9Oxc80N/4g4oybr2HskM5CEY+6wGN82O8fbsgsOKgpyPsG6eqgsCIGn+SAjwVGdruJ
	 fxkJ7oXlpSI0uDMWyzK/curlpqr9F4gBJRhdV68+h+mJuk0+dlWwTyzhve3jLIUIBm
	 0T0eV6xqNavDA==
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
Subject: [RFC PATCH 8/9] mm/damon/tests/core-kunit: test eligible_mem_bp commitment
Date: Sat, 12 Sep 2026 13:08:09 -0700
Message-ID: <20260912200814.145612-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a DAMOS quota goal commit bug [1] that doesn't update the nid
field for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric goal.  Add a kunit
test case for confirming nid commitment.

[1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5e8ead5ef8728..c2da4a3fbcafb 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -836,6 +836,9 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
 		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
 		break;
+	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
+		break;
 	default:
 		break;
 	}
@@ -900,6 +903,13 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 			.current_value = 345,
 			.last_psi_total = 567,
 			});
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal){
+			.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
+			.target_value = 12,
+			.current_value = 345,
+			.nid = 6,
+			});
 }
 
 static void damos_test_commit_quota_goals_for(struct kunit *test,
-- 
2.47.3
