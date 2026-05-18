Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6936EA9F;
	Mon, 18 May 2026 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147690; cv=none; b=D96w2WI8EQZgYNftrfNQM0cG8Ja93FNFKGaoZ6UKfL1UnuGr1bHnUxOT2nsO70U+kmxCAr8wJ/kM7h/J4vsPMXuMzTaWC5ZIatQ+EYA1dkWiKYuVP1rtPHSWEQqA9vZjMQ7ozJfG2u+2DNya8rE5d7uX+6b8TqJOqGghvABe8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147690; c=relaxed/simple;
	bh=EauBIBzKjl6rFCRlEGSo/s6NrgLL9HoVh8TIqUsq9vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKo903l8Zaw9fUZlzaB/DiY7vffpY3YcB+BbXq7WjfHJSaiHxA+zS2BauglYE9RN5Mo+R4oE4jXEZ/opvrFgNjCXuGAci4iyFMYlbam9E9QkqZNt0p3ezlSlMdmdp1Zo7juuN23SPcyzVZZNMuLGs7KrUiT8DVkHpDpLNSj07oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAqdjbTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAqdjbTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329DEC2BCB8;
	Mon, 18 May 2026 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147690;
	bh=EauBIBzKjl6rFCRlEGSo/s6NrgLL9HoVh8TIqUsq9vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAqdjbTtt4J592f5rknZPYg4bEy3S6qGxaMY2eqzUkrPLo7adPWZoZWmoR8Pj1lLX
	 dombct2THm3bxFohjssz3OVixZpijTWCsHo0Dop1h6i1PZhUaA1TzQZ0ff5iRjIrhX
	 jfLBNj/j42cmRh9tpjYPhzcC22bMIGsvou0C3AVJHeTDnRxJt/TSLaHJ+FqA5+PsBb
	 s9oThTX8KBpju+wPm9Wah7BX/AbXifDKKPwmLocz+RbtIiSt7y6oC8wmHdP8Yy27Wn
	 eGXde//yUTUzrXqnj02/C4I4OFtdSwIrX4qP/o6Sg+5rtr2sbSKwU60sD09zYXgdUJ
	 PcOz4kGZCmYJA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 19/28] selftests/damon/sysfs.sh: test probes dir
Date: Mon, 18 May 2026 16:41:07 -0700
Message-ID: <20260518234119.97569-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
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
