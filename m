Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53293374E40;
	Wed, 20 May 2026 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258553; cv=none; b=HgEizrUomJCCJ/oau9e3TcUhz94/wBp+6Pm/A/Ky20T/zUoq72ywuq3Wiqeiw3n4u7vYCwmW6tJ6McbJO5kJPQ5zXbTXMTh//zFt4N2aEkyVwOOZ9PrVgRUTPJ9PF6VH8RXsD486NB4uqFpTN/BzGbiOLKjvrZlRaGFWEmnfZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258553; c=relaxed/simple;
	bh=4Z9nDEpElV7CLHeQzITxn/6P2S9ErV3Ie4yqUQCoJI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a79qa4WqFd+7TraKiI1YsQzYIhJDGOhxRukA5r7j8b1FMHJgbpo3OwvyGjgWyBt0PKELQkEN4Ooery8u1IPbfJ8Fasdg0A7ezWilvSUjPE6p9dqc0rsigJHW0m/+gJA5t79ksbCnlbB+5zzEhmkp7sXEDJIdQ/gfhsc8sSmkn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIx5CwT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIx5CwT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEAC1F00896;
	Wed, 20 May 2026 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258552;
	bh=9HFBKYb5cdZ3muhhdyyxDCFvE0VgsBfb1xW7NVeIcwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIx5CwT5nbcZRLOm8k2VDrxQfa8PQpvbQfcOhB7cOOIIXPOpGHttLzr5ixoqI/jgF
	 X9ylB9chrO5IPmhcmMm4VHYaZFKlGKXc1//9zibxwUFmEMz3v/q8hmQ3bzjaNfOlc9
	 G66FwJDGBQj3vIyzeVAvFBETr/IDuwyngnLFtY5hX2T4SE7vhNk8QusReC3bXyjNi1
	 SNdSTxzQNCO5dDEQ/CAuQSLqdWQerxVsPvkatiNE7mAa9snjVJ4LLJYx63fZe3M6OO
	 sLF11WqiKT03aXObWm+ComvFI+QFNsbWeIDQUQ9qERfnKkjFAr7Do1X/K4mYX5btgq
	 Q1i24obrBR58w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 12/14] selftests/damon/sysfs.sh: test monitoring intervals goal dir
Date: Tue, 19 May 2026 23:28:44 -0700
Message-ID: <20260520062858.167011-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
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
