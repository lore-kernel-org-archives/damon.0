Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393E3D9050;
	Sun, 26 Jul 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087590; cv=none; b=ez1pIeO94cwbuEbj2ZOFa2lGy84P0CbKDDzNty2ehfKo2v2tOS2+3qDKxNyrJE8r7KBIZV+tHWZJVs3H4o7HA+WtfCI9CjT57fBu/SRN0R2XCZKC4LlUYiN3n8DpB35JNGPrIyzkAHPuYUMgjpXYYTDbQIeA2zPs4NLRvsT8kvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087590; c=relaxed/simple;
	bh=I7iSQWo3DIeCl4GG9ImX2V39xbLJgFz5OBrIHCf8Mf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnqOFdYkhmhoDmDeBHi3nKw96JSD/C+YYRU5f0vKbB8/le4KLg7eXPeCmXA5P24II1yBXiOUCHy+lt/qIvWN2JKSW2O5cpLj3AeddnizQNL8FAlv96EG5QciCB8zLPiSwooS10zyzoHzLJxyox/6f+ve8luxZws6e+MP5BUIgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g34Ox6rY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g34Ox6rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8851F00A3E;
	Sun, 26 Jul 2026 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087589;
	bh=m+OX/QoubOtPs5CYX5dE9pYfjfAmb4FTinvx7UvjP30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g34Ox6rYaTdtXgIillaKFACK89FYjuaLjH4TKJlXhLKprR0mcQKQOzClX2DvkNQeN
	 qgn24jNKvu5w0pE2iDwv4G6oxMIahAf/oSmMlTu3eIGH+3FuLpE1GjUWEQaB8yG5bD
	 ll0+YDwQj/L1wHGfBXcJNPy39n0mp7M68RlU3d3/duWML0f7gFmWzB4g9AftNjTJNe
	 kS60v1/cyXIuqIsmmIUPY+0WFY4oQ3VP+TTxYmKuH7qAvpUy36zeqe53/ki5qGLPAr
	 4bcKtc88AUuUgyN+78SEM3S5Eh5xqhhbdfLgnuNF/XSr7QDBOHRxlpig1WsPFiAMuj
	 wC5DXd5YOEOeA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 14/17] selftests/damon/sysfs.sh: test probe prep sysfs files
Date: Sun, 26 Jul 2026 10:39:30 -0700
Message-ID: <20260726173935.94046-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
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
