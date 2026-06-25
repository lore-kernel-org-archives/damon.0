Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5F1DE8AE;
	Thu, 25 Jun 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364100; cv=none; b=SkiBgtq/1BEbGZzbxFznZNHr7lVe1IwqdQ3/HAq+XZ1f0peOgKeoS5EZaIjBFql/AmAcDR3yVLfF3aM85iEjFmamoOFgahOT2q7urdewhw/5D/mTZ1vR1bj9aEsQEV+AiAZo7lRoLA1a9lqLoJmsKuMTON1a0dMuMl2xIsTl3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364100; c=relaxed/simple;
	bh=PL/6ZIZjnOan1gOeFnHjJMR4b9XjaBpSrUTwBJCajJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHtIk+39AYHILoQTeJRoT5F4eIJd43mCWQCsTeqSwO6gNIVfyf8SVJ1i50S64dYcpjcNzbNyQuh3LKXLOgMzUOwwOA0dEY2QrpkHPIwmqBE56eCDXE0aa4Z3sR6THERX4NdmVA5T5CAGTRyvupitWsIjFEijHzBfBZeAj4H8Dsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmFjRnSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmFjRnSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BB01F000E9;
	Thu, 25 Jun 2026 05:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364099;
	bh=e/lP4pJsEcdBFV2cPdsUW/Ogh7Izs8xLb+p1m+SLBac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YmFjRnSe+PXIIKUGaKMql6Wmtw+qOREVgGsXpixF6JzHStIbuxKFBphSso72ZDzFt
	 +Ou5J8Ia3M0puUsvMqpNk+iX5+rjwqfG1jvSbHs31/69I71gi3mUEXUiQmm+TgKiHK
	 3UZFoNGZmnT7THa+iV2oj/68fgv82FNthRHnuzm+W0RzLwQ1YzQTJaXoXi71XdJqg9
	 WvLaZoOJjKdMhk280D2G81NYlDD5Cv+9XkjtCwzW47ls2lyA4I08OAtdwVuA+HzzDH
	 kM1V7kPlcNTgZto0kPgJTHVopZ7YkY/LQoapipdWBYHs5wxPYouiQkZ0sRViS9jbFq
	 rcE2FVdCk8pmg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 05/11] selftests/damon/sysfs.sh: test {core,ops}_filters/ directories
Date: Wed, 24 Jun 2026 22:07:48 -0700
Message-ID: <20260625050756.91115-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625050756.91115-1-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
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
