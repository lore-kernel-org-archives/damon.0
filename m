Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115CC3C2799;
	Wed, 24 Jun 2026 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310835; cv=none; b=PXXcFM1vgicYmhEwXBDBumh6eQBonau/y0IAu8ML08LnbgXZ7FwI7CHbHwzXf9LeXylH9je8+cQv4dbHpIt6CjE1ON3GRm3XiLPUD4qjpEG2Yp7FhuOII7BYbrC+XWdeLWgFtMw1XIKlhTOpQOSMmmxO8vFqq0RcP9kQHJPtJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310835; c=relaxed/simple;
	bh=2dvVV2DEjR7b4dTwhhNX+5jgB5jR3ZqQ6CDPQQ6FMcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+f+D4917wJpDMVHoCZJeYSwwk8zCk/8ovQc0fMQaIx6+na6YulW8QmH+HumrwCPdZAeM1hwUNhJiRR4Qt429akfQ+XPG86BqVP45XtUzoKfNU9lJRKvoHQRh2l2HDOgaoFHnswOLOjDwvQW8x6r8IIYmwTgng6X7ZftC8H5pls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it/Fw2P9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it/Fw2P9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275181F00A3A;
	Wed, 24 Jun 2026 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310833;
	bh=fkNy+Z070qLX1ZPRlqmLyq6fS4C8mG4AOsGTvswsvyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=it/Fw2P9teN1xXmEMC0JAVSjsosSVhCjbS6xr5owDv1zQrqZK/zq2x0YW6rSOJaSq
	 NNpgacRhprqqsz2JlLVwUCFCnBXqW7BBO32uQFDVsDfL16qoH1peCUJfLLpYU//BZL
	 Ub9zcOu/jQAlX1th1e1ZO9vyom9NlJEx62XI/CpIQ4HpL00kUiqlR7eXXAOUg0VF90
	 XVN9VKtEIqychBNLbtL0wEHXnDe/C7I+60aYxlEicUeqzfN5GHnV0W/IYSLaPmeb0U
	 Ok+E139ZtA+CuEN+ZNO90+eBdovrjkIfaQSCdccTZyzdEcW/kZ8X9FWLhPsbR++YIk
	 QyhIEfIAPcIKg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/11] selftests/damon/sysfs.sh: test all files in quota goal dir
Date: Wed, 24 Jun 2026 07:20:03 -0700
Message-ID: <20260624142008.87180-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface for DAMOS quota has quite extended since its
initial introduction.  The test case for that in DAMON sysfs interface
essential file operations test (sysfs.sh) has not accordingly extended,
though.  Extend the test case to test all existing files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index cbfababa0bf31..ad3aab240b360 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -199,6 +199,20 @@ test_goal()
 	ensure_dir "$goal_dir" "exist"
 	ensure_file "$goal_dir/target_value" "exist" "600"
 	ensure_file "$goal_dir/current_value" "exist" "600"
+	ensure_file "$goal_dir/target_metric" "exist" "600"
+	local fpath="$goal_dir/target_metric"
+	ensure_write_succ "$fpath" "user_input" "valid input"
+	ensure_write_succ "$fpath" "some_mem_psi_us" "valid input"
+	ensure_write_succ "$fpath" "node_mem_used_bp" "valid input"
+	ensure_write_succ "$fpath" "node_mem_free_bp" "valid input"
+	ensure_write_succ "$fpath" "node_memcg_used_bp" "valid input"
+	ensure_write_succ "$fpath" "node_memcg_free_bp" "valid input"
+	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
+	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
+	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
+	ensure_write_fail "$fpath" "foo" "invalid input"
+	ensure_file "$goal_dir/nid" "exist" "600"
+	ensure_file "$goal_dir/path" "exist" "600"
 }
 
 test_goals()
-- 
2.47.3
