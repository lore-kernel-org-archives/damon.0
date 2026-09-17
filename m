Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD75908D7;
	Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654943; cv=none; b=txoWP8FciXo6c2h4JnE28PJ9ajZINmAPC6RwFt+QAZ7S/U6c4DECMgYjbo8LINn3ELRlQbvt+EM4dBuhKnSkM+UatqMDUNDeWRw0kt4ta0yYqAWEtHnXmaMG8bgu3aaABX2BqJrErS1epX7n2wb/WbFC2whpsRS/AimCdr5WdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654943; c=relaxed/simple;
	bh=p27VGeOi6mxkr5YznAUf9hm/9dm7aJzUvGSB5HjhgHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFnXXpdD5qsD3i4wSVjDuoxa19NsekDS5ChufYU/rEFM+A0tdEZIbfNI5O1l1OmKMsx0aZnb5LMmnathIYP3G0EvreTUU1Wez0QTVEjMxtrX+w/x7SXqmrIrS1dOVWb/69zkeepfLhXg7UHWYsuaFxZINRNyN3wf4tjy8yj9Nwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il+Y6f5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il+Y6f5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACFF1F0089B;
	Thu, 17 Sep 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654941;
	bh=Wlky4skHwDTF/HcxfK2+0jqoZPXhpLYEW64K0EJjYo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Il+Y6f5QaMfp8RYw8AQOdX8mESp/ZegADh7Db9mBRkj6NKFyLyYsobOEuS1IXwOYy
	 GMytgLOgDE2zZ9+Xrm5+H5lYnaFfGfCw89EqFUITBdWUuOaq5PHEB19XLDKLsFGokS
	 pyMTlIvmXvoIu5vHLWB3RFxetcB2AeyHy8/qmcewoFJFMWVnjGem88aZmATDjFk9Ko
	 ZrGxj5+HdqZreGuuhPPj6TlpcYRqZhAAmZ/agJlBdxpPniF0VxpjhhT9Zzwxz99CSX
	 MVVpKsnp/mISeCRyJS2/83CtFFj21+dNMwRSJyb11pY8PSDmSDWAPN7lOYXHRw6jWZ
	 PEI+2wVpQJhCQ==
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
Subject: [PATCH 07/10] mm/damon/tests/core-kunit: test eligible_mem_bp commitment
Date: Thu, 17 Sep 2026 07:22:05 -0700
Message-ID: <20260917142210.90829-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
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
index 5da84caf4124d..1f19fefdd98c3 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -835,6 +835,9 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
 		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
 		break;
+	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
+		break;
 	default:
 		break;
 	}
@@ -898,6 +901,13 @@ static void damos_test_commit_quota_goal(struct kunit *test)
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
