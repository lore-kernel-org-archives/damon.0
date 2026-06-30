Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362B4192EC;
	Tue, 30 Jun 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829064; cv=none; b=lOkBjIEQJBuWyDp3iUQpBq7LcQqMeH9HKMO1eW+4uCmBLJJG3Qvy/KbZwtKIkGaSXNRljpqYPMkOGKNRZfVMmARKHXRQ1heKmJZw1VxFf9tPj2ELDpGrvP9mg080mTiUslzFt+fNQA7K0RMSZdpGHcDtVtdKOrXY7Y8mFGW5EEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829064; c=relaxed/simple;
	bh=7Ebl+K8z3mHBIBxdBDuTcxZxMlpkiUh0qz0tLw796II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWyQQkr4LI84KJAtukJ1VckZZyb5o4cmNi3PNTryDSMs94qgVwmqfB9VtfUpJFZ45tNb25Hnjky1qNTPmFYs/z2Z5Ghp6mYxAtAHzLWLlUkvpC24OeAkU95SUETsYZ7igbYpaO0ylP9wO8r367ICe0aBiCFFLvqUxCgn6DauVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyl6xEDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyl6xEDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AF51F00A3A;
	Tue, 30 Jun 2026 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829063;
	bh=0nmlNQ5aYOF5tQr1EQbZrbSTFwUpJ5xLRATEsQ8uEpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyl6xEDQo8YATDg6v02JGOcISed2NZCmwgojeIx6cpWSVk+dnPNDrPSUXXRyHeAX5
	 +ARuhdKwEoAi9pfgVkZKTmEsbwXitOAESA314jU34PuSumpgPlaS3qxXsv6LgqOODH
	 55IUtOqf6UVqu85nwRKEpRS9WYLLqFG1ipDLYOo+bbhab6ZVcC+SkpyFURcOuvO+Qg
	 E73JR1DH4hOeQ+/Gnpyv20cvyKA+W6QO/V1CT+lTInEWH8/zo8UjCo0bk62yriDXY5
	 GLlPYOMa9L/Aw9Rg2yAAaKDGG2SZtF/lIbSmZonjHZgVZMKWBmBXV2F9/Oo4324lmP
	 OaOBZ0hkXDHrg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/11] selftests/damon/sysfs.sh: test {core,ops}_filters/ directories
Date: Tue, 30 Jun 2026 07:17:19 -0700
Message-ID: <20260630141726.92246-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface essential file operations test (sysf.sh) is not
testing DAMOS {core,ops}_filters directories.  Add the tests.

Signed-off-by: SJ Park <sj@kernel.org>
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
