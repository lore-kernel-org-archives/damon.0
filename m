Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1F3C585F;
	Tue, 12 May 2026 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596625; cv=none; b=J9ijE1NHsqGZ5ZKLbVGB0GQgNn473V99j8/Ag+C3zFEPPKDrsBoI9d6Cr0fY+2Yc8q243DJnBTZBwXjVh8qfQNTsyXWXMKleGBGgvXPHGEkoDmmHbNphtd5dr1fm7kLqRKPxinODgfXKUcTDng6E0CSiUjag+Gu1KXeiV0pL/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596625; c=relaxed/simple;
	bh=EauBIBzKjl6rFCRlEGSo/s6NrgLL9HoVh8TIqUsq9vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7B2HFG3J2/cgks2nwRf2K/vQ59f0iMwk810ss7/HG1CVf4dWeXD7/1vJWlGOr5OyBzZqazglo8aqGdu01C5UEwMAmWm/KoYYUa/LWmYUmiOVETcNX4EB4+OlE3NNHXom15c28F0WlwnJLvwSLsyfpQCKX1byyV6uYXDc8pDmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFJZVSu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFJZVSu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833EAC2BCF5;
	Tue, 12 May 2026 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596624;
	bh=EauBIBzKjl6rFCRlEGSo/s6NrgLL9HoVh8TIqUsq9vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFJZVSu0GDYBqvaQBc63EdHHe5GXKyEp9CdmpKL/PB+nApIyvzw5Akctb1w/Xy8r6
	 7A9I+VMxFFCc0HCWCPzxBkxT+ypJbAyd4C4ZM2OCw2974pDynugyPPuJ4E2xk7kTSG
	 JPBfu/WULl77WKdP98o29HR/uQE+xif1sDGa5YgSC4+LeH3mPsLs/Z6QbNKcjxcDOI
	 zHVpnKzLQiCdkOMkoAJSmasVHliI9sSOhwng+UzFBfctZl0fK9isp6uFl5fZRiiKNd
	 9yxSrrGvUv5g/zH/+oOAcths8s6xjXowv+QZPKAbDdcCb/ngDOkzJyotlfts3w0aJf
	 VgYJAXwCRY6Cg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 19/28] selftests/damon/sysfs.sh: test probes dir
Date: Tue, 12 May 2026 07:36:34 -0700
Message-ID: <20260512143645.113201-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple existence tests for data probes sysfs directories and files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 83e3b7f63d81c..1ac3e2ce8e448 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -291,11 +291,59 @@ test_intervals()
 	ensure_file "$intervals_dir/update_us" "exist" "600"
 }
 
+test_damon_filter()
+{
+	damon_filter_dir=$1
+	ensure_file "$damon_filter_dir/type" "exist" "600"
+	ensure_write_succ "$damon_filter_dir/type" "anon" "valid input"
+	ensure_write_fail "$damon_filter_dir/type" "foo" "invalid input"
+	ensure_file "$damon_filter_dir/matching" "exist" "600"
+	ensure_file "$damon_filter_dir/allow" "exist" "600"
+}
+
+test_damon_filters()
+{
+	filters_dir=$1
+	ensure_dir "$filters_dir" "exist"
+	ensure_file "$filters_dir/nr_filters" "exist" "600"
+	ensure_write_succ  "$filters_dir/nr_filters" "1" "valid input"
+	test_damon_filter "$filters_dir/0"
+
+	ensure_write_succ  "$filters_dir/nr_filters" "2" "valid input"
+	test_damon_filter "$filters_dir/0"
+	test_damon_filter "$filters_dir/1"
+
+	ensure_write_succ "$filters_dir/nr_filters" "0" "valid input"
+	ensure_dir "$filters_dir/0" "not_exist"
+	ensure_dir "$filters_dir/1" "not_exist"
+}
+
+test_probe()
+{
+	probe_dir=$1
+	ensure_dir "$probe_dir" "exist"
+	test_damon_filters "$probe_dir/filters"
+}
+
+test_probes()
+{
+	probes_dir=$1
+	ensure_dir "$probes_dir" "exist"
+	ensure_file "$probes_dir/nr_probes" "exist" "600"
+
+	ensure_write_succ "$probes_dir/nr_probes" "1" "valid input"
+	test_probe "$probes_dir/0"
+
+	ensure_write_succ "$probes_dir/nr_probes" "0" "valid input"
+	ensure_dir "$probes_dir/0" "not_exist"
+}
+
 test_monitoring_attrs()
 {
 	monitoring_attrs_dir=$1
 	ensure_dir "$monitoring_attrs_dir" "exist"
 	test_intervals "$monitoring_attrs_dir/intervals"
+	test_probes "$monitoring_attrs_dir/probes"
 	test_range "$monitoring_attrs_dir/nr_regions"
 }
 
-- 
2.47.3
