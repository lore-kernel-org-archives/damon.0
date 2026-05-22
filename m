Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24973481222;
	Fri, 22 May 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464440; cv=none; b=eLoxO6PmxGyE+iZbguHNMXpTvDBJUJcESO8DdFE23p26kwEOjC/7Fy58UaMVJVqu1CleSJ3BJoxEdPwKpa4gh05JB/Fr9Zd9gbTkFChaWCtMaE7oRw5wBUTsXqKMzQpO43PZrypCV4J7xbMPn4lC/WPjBwmobVHo3jhOX0HDZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464440; c=relaxed/simple;
	bh=4Z9nDEpElV7CLHeQzITxn/6P2S9ErV3Ie4yqUQCoJI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwn67S6RhS58ixRGruqsNtUOGCN8MoDZG6ncgT7KjcROCcWLqDzatYNGVKgSgp8r1oyOQLJ6/qNvcj1eXQG9VA/Nso4Nhf2G/z4ody/qhpTCxyUu7ZuIp4RKQUH3lzki5VIdJJLcSNh/mUz2dK3p8tRESQTLPrXfP3Ur9c8WShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkjD3l1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkjD3l1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C1F1F0155E;
	Fri, 22 May 2026 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464439;
	bh=9HFBKYb5cdZ3muhhdyyxDCFvE0VgsBfb1xW7NVeIcwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jkjD3l1CLAsGu8RBoARCpI5T334wRV3SRDm+apej1M6lh4NPpaUqLS7qgBxWPOfrG
	 iKlvJObdsx78z1KAdGCrCHztZ7C+OO7GXq90WN0Fg0TWbXumtw6+ni+ZjmLvGUiywy
	 n6mnM6AKrsa0Utoei959vTjort50kxjFfe670VgxQ879Z9UQDfjy6pHQiTlZOA2IiY
	 yRQmUTA6Ci//9qLhx05MEp5HrdF1/60/cZLNJI8sgECplUjrx5lcyhHsVl5LZJH5WU
	 +joPP1XPdAiwO52OcdH/XxL4hiKwh4j5BThaCRONA2zcGOt0O8l+nn5FBKFke7OXh5
	 X6Ffe828hAxmA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/14] selftests/damon/sysfs.sh: test monitoring intervals goal dir
Date: Fri, 22 May 2026 08:40:23 -0700
Message-ID: <20260522154026.80546-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.sh DAMON selftest is not testing monitoring intervals goal
directory.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 1ac3e2ce8e448..b3418214ed358 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -282,6 +282,17 @@ test_targets()
 	ensure_dir "$targets_dir/1" "not_exist"
 }
 
+
+test_intervals_goal()
+{
+	goal_dir=$1
+	ensure_dir "$goal_dir" "exist"
+	ensure_file "$goal_dir/access_bp" "exist" "600"
+	ensure_file "$goal_dir/aggrs" "exist" "600"
+	ensure_file "$goal_dir/min_sample_us" "exist" "600"
+	ensure_file "$goal_dir/max_sample_us" "exist" "600"
+}
+
 test_intervals()
 {
 	intervals_dir=$1
@@ -289,6 +300,7 @@ test_intervals()
 	ensure_file "$intervals_dir/aggr_us" "exist" "600"
 	ensure_file "$intervals_dir/sample_us" "exist" "600"
 	ensure_file "$intervals_dir/update_us" "exist" "600"
+	test_intervals_goal "$intervals_dir/intervals_goal"
 }
 
 test_damon_filter()
-- 
2.47.3
