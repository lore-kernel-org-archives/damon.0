Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09372D8385;
	Fri, 26 Jun 2026 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433030; cv=none; b=AKun+YvcCE6Dp+m4Wg4t0lcVDo8+0n/l21sQcL20ZiarZz18U7phT+caxpuih2AzixERqnDoty2FXuDBS8yJd2dMnZQ462Iivly/kw3zjEEi4g2LodIT0CL8hO+vnLdu+cKH4g5ae7QFH5oz13b2nTNH1KFi054ivffveSSRKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433030; c=relaxed/simple;
	bh=N7WvedTBMklmHo1vp6OOAC/i/G3ERHhKPwYJJ5rfwgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtzRtEpk2VL8+015pX/0CPgGkmLyP8V9V0SPXseHCT9VbVu7rGnof32e4GjEKP6VVEQkDI+xbNrgHis2P0PiDR97lP55jJlpoyVXbirZsW1AokYOWIYAKGOp+6eVHDGZv4BWEQm7B83pPR3Sp12tRVNvImqASwpZKL3PEKI/3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqBzHIjB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqBzHIjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC4A1F000E9;
	Fri, 26 Jun 2026 00:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433029;
	bh=/qRUF8cwtcmB/nbdsXtxrh3TaDK04SACL0YdAxUm/I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lqBzHIjBTACgUQRKvnjym4tU9icnx+QDF2K6jMeH7lDOrvCFNMfDKaSOK9JKIVg1N
	 Bf8CfJ6OUp3r6ZzhFUZdX9lA3clmvogOzrw2/PRqZpwDqIIGUfSWdDCsMQjdfiFvfo
	 5GGk1jmhQQ8wLLBeV/oHT6h6K3odVR8aumEalB0gMnCsCfH4YdhURgWt8qEXixxZ2o
	 kXEx71WLNgK0TJL7RLf+kXaTaoD31IyGh3DA6J6pwL+mFXPgr3ly2XB9AufqarATP2
	 lWjyk3egT6VedV9TH2somhXwX+KxozUiiqQJCW+v7QtFk2rf8jF/5cXCZ17capZCKU
	 ldR0hujJlAI4A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 06/11] selftests/damon/sysfs.sh: test dests dir
Date: Thu, 25 Jun 2026 17:16:37 -0700
Message-ID: <20260626001644.85825-7-sj@kernel.org>
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

DAMON selftest interface essential file operations test (sysfs.sh) is
not testing DAMOS dests/ directory.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 07a33995be852..b88bf7b98d7f7 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -99,6 +99,29 @@ test_stats()
 	done
 }
 
+test_dest()
+{
+	dest_dir=$1
+	ensure_file "$dest_dir/id" "exist" "600"
+	ensure_file "$dest_dir/weight" "exist" "600"
+}
+
+test_dests()
+{
+	dests_dir=$1
+	ensure_file "$dests_dir/nr_dests" "exist" "600"
+	ensure_write_succ "$dests_dir/nr_dests" "1" "valid input"
+	test_dest "$dests_dir/0"
+
+	ensure_write_succ "$dests_dir/nr_dests" "2" "valid input"
+	test_dest "$dests_dir/0"
+	test_dest "$dests_dir/1"
+
+	ensure_write_succ "$dests_dir/nr_dests" "0" "valid input"
+	ensure_dir "$dests_dir/0" "not_exist"
+	ensure_dir "$dests_dir/1" "not_exist"
+}
+
 test_filter()
 {
 	filter_dir=$1
@@ -225,6 +248,7 @@ test_scheme()
 	ensure_file "$scheme_dir/apply_interval_us" "exist" "600"
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
+	test_dests "$scheme_dir/dests"
 	test_filters "$scheme_dir/filters"
 	test_filters "$scheme_dir/core_filters"
 	test_filters "$scheme_dir/ops_filters"
-- 
2.47.3
