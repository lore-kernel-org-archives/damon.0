Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B82BEC5F;
	Fri, 26 Jun 2026 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433028; cv=none; b=SflAzvcsP8ooXNFfQW69gbQl833oJKdm0y6OPOq3aV8SsM9M7ta9i9qKX5bIju+tKPdaP38/e9JpsUBgUyH2lm7CJc6h0r8MbcDwFE1DoTWu0D4gHDEBcC66RGDFwPBjjtl/iZyqQE9JQFf8N3Isg3BsPnRpYrrGZ13H64vNdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433028; c=relaxed/simple;
	bh=PL/6ZIZjnOan1gOeFnHjJMR4b9XjaBpSrUTwBJCajJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgE5blRnf05HfpBfSZeP5ms8KY5zHhp/RqSRZ51EK9814pT7rHo0AhpzdEMhj49xmsD+PzHiBCQoRvxD4B0IVXkRbUJC5ron3toxshOnU29SaPe4qiKJlsDUT1kODzOUsxcQjYuAvmJUwefFDsR9p2l5V5t7O7i5YZ9vpdvPFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCV7A5Cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCV7A5Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632731F00A3D;
	Fri, 26 Jun 2026 00:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433026;
	bh=e/lP4pJsEcdBFV2cPdsUW/Ogh7Izs8xLb+p1m+SLBac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCV7A5CspRBkoI1irBocJ7mdNgvlBhwrJ9DWsY4fn1m3Ndd5+id81IRAgwiFDeIlX
	 Pys5kbIEecLTxSZi84s99izDCql4AQQqQinQx02EKFOynAHy2qzlThG7Comct0ZibI
	 /tQjM1tLBBKm51qR77wZcsO6IhcSLxpk087UMJDrl3diSAm39CLZw8RkVRuOdYOT/L
	 HG8OJm/LsRY+7N1K8dAbcBFt2oMfhmb8XFw7Ndta3ueWbdU2nKKuc/1pszXZ8xemEI
	 kao8u0WyYD0JV+bVJIKfTKNkl5aRx4/WU7TIzqi/AabM+QQZjmX87lhUhGdmOspr8G
	 cdmH/xW7L5rPQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 05/11] selftests/damon/sysfs.sh: test {core,ops}_filters/ directories
Date: Thu, 25 Jun 2026 17:16:36 -0700
Message-ID: <20260626001644.85825-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626001644.85825-1-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface essential file operations test (sysf.sh) is not
testing DAMOS {core,ops}_filters directories.  Add the tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 28 ++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 0f2ef462a6b6a..07a33995be852 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -103,10 +103,28 @@ test_filter()
 {
 	filter_dir=$1
 	ensure_file "$filter_dir/type" "exist" "600"
-	ensure_write_succ "$filter_dir/type" "anon" "valid input"
-	ensure_write_succ "$filter_dir/type" "memcg" "valid input"
-	ensure_write_succ "$filter_dir/type" "addr" "valid input"
-	ensure_write_succ "$filter_dir/type" "target" "valid input"
+
+	local dir_name=$(basename "$(dirname "$filter_dir")")
+	if  [ "$dir_name" = "filters" ] || [ "$dir_name" = "ops_filters" ]
+	then
+		ensure_write_succ "$filter_dir/type" "anon" "valid input"
+		ensure_write_succ "$filter_dir/type" "memcg" "valid input"
+	fi
+	if  [ "$dir_name" = "filters" ] || [ "$dir_name" = "core_filters" ]
+	then
+		ensure_write_succ "$filter_dir/type" "addr" "valid input"
+		ensure_write_succ "$filter_dir/type" "target" "valid input"
+	fi
+	if [ "$dir_name" = "core_filters" ]
+	then
+		ensure_write_fail "$filter_dir/type" "anon" "ops type"
+		ensure_write_fail "$filter_dir/type" "memcg" "ops type"
+	fi
+	if [ "$dir_name"  = "ops_filters" ]
+	then
+		ensure_write_fail "$filter_dir/type" "addr" "core type"
+		ensure_write_fail "$filter_dir/type" "target" "core type"
+	fi
 	ensure_write_fail "$filter_dir/type" "foo" "invalid input"
 	ensure_file "$filter_dir/matching" "exist" "600"
 	ensure_file "$filter_dir/memcg_path" "exist" "600"
@@ -208,6 +226,8 @@ test_scheme()
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
 	test_filters "$scheme_dir/filters"
+	test_filters "$scheme_dir/core_filters"
+	test_filters "$scheme_dir/ops_filters"
 	test_stats "$scheme_dir/stats"
 	test_tried_regions "$scheme_dir/tried_regions"
 }
-- 
2.47.3
