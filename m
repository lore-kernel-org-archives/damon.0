Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904033C10B0;
	Wed, 24 Jun 2026 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310830; cv=none; b=QY6NvXyM+T2f0a8O5NXpTK+QGtvujlCB3LB15kPPnJa0ZSD9IoRpIkFmoEdOOknAn4oXONWTIy33U2guBkQB2kvRLTkXmQ5YGX0ghFmGKPLQYqf4dbUSvT2LSRmxEhqBUQ6fZoOMX1HLn/K/EL++XBiIXQ1F1DyipeS9vGV7PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310830; c=relaxed/simple;
	bh=Od8BlXfCfS9IdhES0lKHejeIdB9sphmyRd9EUMNhxdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2px45GSdULsuqmPa+vM8zgu3mroL7fjgi05OrPK9vd5JWvJPzqlb4fQDboblZX9yzSHm3Um3aZU94cW049QZyQU+FCsry7J6mrJ4EpZNzD9Re3ZJxFjMCvtIGs4r6Bqad3g2PIe9h8w6wGGNX3vsy/P7ST1aLY2hTkBeTmElNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWwXA4zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWwXA4zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32881F00A3D;
	Wed, 24 Jun 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310829;
	bh=qjAnF1KQcOIfPmAqh531HVJRlkTMMbScffo5lddr31c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWwXA4zLFzKojAlnqJafqe+F/TszR0YMwBv9FiNi6fXiwtLizgrg60MB86NfYFO2Q
	 aO1b6Qe6MWRiX5nWkN7t+I6h7ycWDNbNLI+WoLCQdEb8uYiyjMEmKGfuuvxW16Ullw
	 hn0gsICdv8d8j6toAVRNVtgP3nVeWmkHCsLcNBhLKDylVET8kdrwsycoPtJbZKz011
	 /54gR/SdBC39qjE5Zr4gO8RqxT+hcudnaVYt95LaxTXs+oeUGRxbidMPE4KjCx3FAv
	 i7D9WX9H/7KEDAIrNRUx+MzS3X4zVUcZpu8YLVRtLN7apI81s/QjCqyf+yGU/DMJvk
	 Ua9VC95Yho2zg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/11] selftests/damon/sysfs.sh: test {core,ops}_filters/ directories
Date: Wed, 24 Jun 2026 07:20:01 -0700
Message-ID: <20260624142008.87180-6-sj@kernel.org>
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

DAMON sysfs interface essential file operations test (sysf.sh) is not
testing DAMOS {core,ops}_filters directories.  Add the tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 28 ++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index d528dfea44c3b..78eea0d13c271 100755
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
