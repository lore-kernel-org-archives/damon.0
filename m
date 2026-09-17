Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA03BBFB4;
	Thu, 17 Sep 2026 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617949; cv=none; b=RHSb/wCPbmLdMELF6hnRruHqBzWB8wDsN4snVbED9R0P6z9U+cRf9xGMZKD2mvdk9PgVJ+mYTbPqXCTgfxmuYt5bx2QQe7pi5H7EuS997K7GhUinr1gYWO7MwYNT8Yl35sqT79AkP/aIKKqnjRoU5rKhC3fJ4ssaroTU+XrDBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617949; c=relaxed/simple;
	bh=3waL/h3q7DZwEaKW66X8co0xhOUYc545eSn+/YM2mqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTpToZp9GMdSbKE5dmDEa3l4QdeY2cr+Zp8TcxdJ6oOjjzETT/3NYb4xm48IMkykfjczUc5xPfyOf1bkXQZgCarp6+FzJQORWdJ2uAqRgeonGyTyn/UG9ralo9TDBJhGNdSx5xzQGdf1N2oWq8Bz374PZmah94DQw2Yu9bAWSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLy5Z/jH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLy5Z/jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE3B1F00898;
	Thu, 17 Sep 2026 04:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617947;
	bh=PDYFtYaMI0AhnykvPFvkzlsotZmDoTCT5c0S8nqI1O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NLy5Z/jH1+4dW/Yv3fuWWsqcwJbHuH4Bx4sq02CzSo0x9EY1cLKhIflZFhRTlu0/f
	 AY6MfHFCp3fRe5oU1QbtD+4yHCYdzXR7W00DWNScRkznBrhufu+aID6C/Hp/cyRKTu
	 C2vkv+AoIhr1n9Ghwr/tfXfb1mkR0Koi3velQZlIbMt77XNMtsJYF7l8U+fHvtOhLQ
	 /gMfhtJ2GWYbc0CMeuZX0o12UAzebRzYCaZCyGNPDCt8Uc53PEPXOS1uLaPUYwFSou
	 smGV+thHWKYurYjIQXR1DBmtSEC1Ce6M09b5AbNPCSuDguhyvkZxlWcgEZagI+W0uy
	 4yYWJsNOPBJ2Q==
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
Subject: [RFC PATCH v2 07/10] mm/damon/tests/core-kunit: test eligible_mem_bp commitment
Date: Wed, 16 Sep 2026 21:05:33 -0700
Message-ID: <20260917040537.107341-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
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
index 82c542afaa60e..1244cfeae5e70 100644
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
