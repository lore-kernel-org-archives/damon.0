Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F84125CC;
	Thu, 30 Nov 2023 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF2NM7qE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14DAC433C9;
	Thu, 30 Nov 2023 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701311823;
	bh=tm53i8GhYDRGpRCnZgtLIn7P8jIf3OMjFqv6O/swkJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mF2NM7qEDR2eJeiTCxOHD0A+5NunTLYKc63iE0l9/ywqjnaj6xo8D0yGnT6Gmvw/A
	 xD91IpuQUYOBVVCxDiJe4H16CJesJnVJ21lgmggfbUD5S3QxJiJkLZszoLmYDHMXxz
	 PEj1zqFucaACRUuOXA3oPuDzdJy8kYEUBSv5OE8pBMbxrZHe2uJjsTidqJEOFmS8eR
	 0AGIKl4PgJVr/z5eQ3zv6EABddpoQCRpnRrDVKwL/lnsjlaZ0+Ma9teMxzaf/ccZz7
	 fo0/hMTsCfM4rXGNO0cNf6rXSkHmTF7AkE30ORjDwm4TF23bo0hVD688vrMHNQ/Vku
	 s9Kd4TI4Fn6xQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] selftests/damon: test quota goals directory
Date: Thu, 30 Nov 2023 02:36:49 +0000
Message-Id: <20231130023652.50284-7-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DAMON selftests for testing creation/existence of quota goals
directories and files, and simple valid input writes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 56f0230a8b92..e9a976d296e2 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -150,6 +150,32 @@ test_weights()
 	ensure_file "$weights_dir/age_permil" "exist" "600"
 }
 
+test_goal()
+{
+	goal_dir=$1
+	ensure_dir "$goal_dir" "exist"
+	ensure_file "$goal_dir/target_value" "exist" "600"
+	ensure_file "$goal_dir/current_value" "exist" "600"
+}
+
+test_goals()
+{
+	goals_dir=$1
+	ensure_dir "$goals_dir" "exist"
+	ensure_file "$goals_dir/nr_goals" "exist" "600"
+
+	ensure_write_succ  "$goals_dir/nr_goals" "1" "valid input"
+	test_goal "$goals_dir/0"
+
+	ensure_write_succ  "$goals_dir/nr_goals" "2" "valid input"
+	test_goal "$goals_dir/0"
+	test_goal "$goals_dir/1"
+
+	ensure_write_succ  "$goals_dir/nr_goals" "0" "valid input"
+	ensure_dir "$goals_dir/0" "not_exist"
+	ensure_dir "$goals_dir/1" "not_exist"
+}
+
 test_quotas()
 {
 	quotas_dir=$1
@@ -158,6 +184,7 @@ test_quotas()
 	ensure_file "$quotas_dir/bytes" "exist" 600
 	ensure_file "$quotas_dir/reset_interval_ms" "exist" 600
 	test_weights "$quotas_dir/weights"
+	test_goals "$quotas_dir/goals"
 }
 
 test_access_pattern()
-- 
2.34.1

