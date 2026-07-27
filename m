Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931338AC87;
	Mon, 27 Jul 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163119; cv=none; b=tNFvD+pUHJAFeSVFN7V5bNEOZOgd/UxiYYRF+13f9l/UhjvDqinBsHlmVnHV9colG3b+qpl4sqSNXvXDqRE5oIz/yukmOejZlllVMK5SV49f4bip8ovqTfSLjV8k1CI++1VFuvajWuFtur5UqQtwNTW4Ht4Bpy9qHjcWFGhzCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163119; c=relaxed/simple;
	bh=I7iSQWo3DIeCl4GG9ImX2V39xbLJgFz5OBrIHCf8Mf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVHOFfx3VRz54m8oiUS9CJPcew4YqTAgGcBF6laT659NOHQJ5lh4bWRfFbv2CkkwyAFqo9kvtllljx7T9NU4Umz5SY57hzekAZtjt9qTTLi3nONXHHbLUxqiET0ie7qktK2ymtOlnyvM86ncdvBSFAwkH6dwnQJMxYSZ025lexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSnV8FmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSnV8FmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246F41F00ADB;
	Mon, 27 Jul 2026 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163117;
	bh=m+OX/QoubOtPs5CYX5dE9pYfjfAmb4FTinvx7UvjP30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KSnV8FmNeHv9kGffCEbQy/POwV1OWhguNWtd5yZlBmmRaHNRVS1W0/qHid4JN7Ys1
	 HLCv9JITbYTk4tBSGLppHW7jqGl+WGLBLkUmyvvs1ZXxm0HhiSqEOo6X+2iImmknUm
	 R+5kYVgDOnQzc5mUK6+29ULBD2R4783bTG8ED2NzCNOvtYHpqc9+ljLuajOfG/TuRH
	 LhhL0TmothsXGKLbC3/Zbg3rIdzgVIjEExYCyUWMIkTyQpaIWKSUaABJZJc7yInc6w
	 giMItXRE424VuMSyPp+6VdOt5hR+ZdDYL+8VRKZ6vKrkk0pierLMU/NjNOFUfSMd33
	 /SYFRWMsCAbpA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 14/17] selftests/damon/sysfs.sh: test probe prep sysfs files
Date: Mon, 27 Jul 2026 07:38:23 -0700
Message-ID: <20260727143829.86236-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
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
