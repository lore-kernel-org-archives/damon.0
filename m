Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B06E30649C;
	Tue,  1 Sep 2026 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237272; cv=none; b=UzcW/HYuN+U0DLkG6rmaoAmtNOlADrCa/99dSx7OvPtHU0kQ3z1GgDS1bXl7XROL6cqkasMHj3HCV0LicS4aWG2WeVyt5IBV1hSpKhxoI0pRmlomERd0ACkU4jL/8L+BuLVDo2xR49JA+6zrW7/72NGE3HjE5fnISe9QVoWNFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237272; c=relaxed/simple;
	bh=I7iSQWo3DIeCl4GG9ImX2V39xbLJgFz5OBrIHCf8Mf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KL7Zh5u9SuevELtTEgxzQqiPmLpkaQxkAk2sbBqXd3Cw+tWQ724rpCsJO8phK/RPmcDq6T4DRKVx/6g3ihcVpe37125svKqNWyPsXWmR8CClMAClRJf276vpTjeQwGcJRBj0TUREKj5aEqjK1b633Ua3/xMbKmKEMy/4dgVkaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLCE2Ixd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLCE2Ixd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA701F000E9;
	Tue,  1 Sep 2026 04:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237270;
	bh=m+OX/QoubOtPs5CYX5dE9pYfjfAmb4FTinvx7UvjP30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fLCE2Ixdi6gF8dbq+fA6A0ezfDrlAohge5ca00te/Onhm3sslbns7GdQg0TbY55av
	 6g/Sg/aQ9rZgJhwTlOG0kCbibygq8/VuaycDskgeVhb3bKr3bhbJi5pD9OPD3h8v2J
	 8WzC5IroH2uWwiwNcVQUj9aV2c37FrLJqh2Gii25Gc4oyggSFj5sxOFm7BcMXPjN6N
	 P+apq0UF/ojAbu9lpaleI7SCVUBkvda5hSQcM+59xHCh9u0pbDTn8OfVheyk4es96W
	 dYGH4fSUE2kS5ZA2gQQLt6R6DA6Zq8jTNjIEYk9gAK/hHBa3n1MBoHYenavl53jUtm
	 zhphVB9A9l8Zw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/17] selftests/damon/sysfs.sh: test probe prep sysfs files
Date: Mon, 31 Aug 2026 21:34:10 -0700
Message-ID: <20260901043417.2165-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic file operations test for newly introduced DAMON probe prep
sysfs directories and files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index f7fb94b84e716..ddebde6edabe4 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -361,6 +361,32 @@ test_intervals()
 	test_intervals_goal "$intervals_dir/intervals_goal"
 }
 
+test_damon_prep()
+{
+	damon_prep_dir=$1
+	ensure_file "$damon_prep_dir/prep_action" "exist" "600"
+	ensure_write_succ "$damon_prep_dir/prep_action" "set_pgidle" \
+		"valid input"
+	ensure_write_fail "$damon_prep_dir/prep_action" "foo" "invalid input"
+}
+
+test_damon_preps()
+{
+	preps_dir=$1
+	ensure_dir "$preps_dir" "exist"
+	ensure_file "$preps_dir/nr_preps" "exist" "600"
+	ensure_write_succ "$preps_dir/nr_preps" "1" "valid input"
+	test_damon_prep "$preps_dir/0"
+
+	ensure_write_succ  "$preps_dir/nr_preps" "2" "valid input"
+	test_damon_prep "$preps_dir/0"
+	test_damon_prep "$preps_dir/1"
+
+	ensure_write_succ "$preps_dir/nr_preps" "0" "valid input"
+	ensure_dir "$preps_dir/0" "not_exist"
+	ensure_dir "$preps_dir/1" "not_exist"
+}
+
 test_damon_filter()
 {
 	damon_filter_dir=$1
@@ -392,6 +418,7 @@ test_probe()
 {
 	probe_dir=$1
 	ensure_dir "$probe_dir" "exist"
+	test_damon_preps "$probe_dir/preps"
 	test_damon_filters "$probe_dir/filters"
 }
 
-- 
2.47.3
