Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294829;
	b=W21CUaVrTtTS6Lrin5aFEvE/mOb0kpjRJJKwHWUowmU0a0SXYrfDVhpFRgGP2kCjB/YD
	 WSUj8gqt6XcbvbtxCg2Uu4TxPn7AiR/sVqJxCT/C4zLGzdHWFkaYFZ5pWi+V3SroqT0U1
	 V0M851swfcpFXC3+MUPw8Vew+vgY8RWb6I2HhX1dQk3FSk38EN4ztlL9MDC3kbWoqtQKa
	 cO7GclBFnHO0ZNbiRadEMfm/n3Uykz/BMd6frzMAVd95s6M3XyOYn+v+/iQ5yWOHKK3GN
	 ZenhQYLoIw/f+ri9PmBO63mgtoZZeYMU7xhv2hnj9gqLQ3/wXl3IyWO+CV1Fct1YgMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W6sgrGq/PIPvl2dUtr0MUNu6vsfTRiTVsaaYrgPkigI=;
	b=aKsbQmcKxL83FFojvwZk04hLmTciSWMsredVYRnFlb3qE7dHNFIcdtGAEqRV9NYaWnno
	 /M7yiEbkKJVwqcwbbPF6/LHGjSDjNUuO3idtJI6HR+uz8cM2XVL6mUe4upF99sdBWXfYp
	 7m+qPqZaBC5OlYCGbKVjcgRUqre+dtYwb2cjl+q2Ig76QbvQYEQmbB5VpilNurdQCQOiy
	 XKwX/MOPnMfWK14RKxvFM2m38gdIbQFl7k1RJK9KZXHHLOmfXONAsWyDSeGInzSZI3yXi
	 N35G0GB8xZCCjwN8ZaL5LBcHaH2bCQOWbJDloK2RJAz6nit+nlJ7azy0Fd67dwmJfmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVYAiXcd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5491606A334;
	Sat, 21 Nov 2026 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVYAiXcd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3491C1F000CA;
	Sat, 21 Nov 2026 21:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294829;
	bh=W6sgrGq/PIPvl2dUtr0MUNu6vsfTRiTVsaaYrgPkigI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hVYAiXcdRBByp1AyymUjbq0o0B20zi+R9yO+B9MX0vn27z3uGVSxnz2vwXyrEs0Ed
	 rGCanXbvjfhQ660I7Tp6cm6JWM0VcTmi8Q2YJhYzOzJpm6Hy2RQjPH2/HMB8P1YblP
	 SaDuxOxYmVIxRMXJGB6shWjJNoXys+d7+ZJL4zn3IzgVjv+WObcTD1Cya/qF0OzXwi
	 9FVyUjvZ/AFw3JauRVfXF6mUeNmpN4wC9L7cCq+rw4b3skTJQaEXtRAbSD55Uvl181
	 ltC6SguimzDwWe3z/wfVaBdyB05kdKMdVR2o6JKSh0igfnAXQ2fz36Neu6NSr0Dsc9
	 s8Rd+vVMfi6+g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 24/27] selftests/damon/sysfs.sh: add basic tests for admin/reports/
Date: Sat, 21 Nov 2026 13:00:08 -0800
Message-ID: <20261121210013.130397-25-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update sysfs.sh DAMON selftest to cover basic file operations for the
sysfs files under the admin/reports/ directory.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 1cc7ab2d7e22f..577953ee4e631 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -510,6 +510,57 @@ test_kdamonds()
 	ensure_dir "$kdamonds_dir/1" "not_exist"
 }
 
+test_producer()
+{
+	producer_dir=$1
+	ensure_file "$producer_dir/report_type" "exist" "600"
+	ensure_write_succ "$producer_dir/report_type" "user_report" \
+		"valid input"
+	ensure_write_fail "$producer_dir/report_type" "foo" "invlid input"
+
+	ensure_file "$producer_dir/producer_state" "exist" "600"
+	ensure_write_succ "$producer_dir/producer_state" "on" "valid input"
+	ensure_write_succ "$producer_dir/producer_state" "submit" "valid input"
+	ensure_write_succ "$producer_dir/producer_state" "off" "valid input"
+	ensure_write_fail "$producer_dir/producer_state" "foo" "invalid input"
+
+	ensure_file "$producer_dir/addr_start" "exist" "600"
+	ensure_write_succ "$producer_dir/addr_start" 123 "valid input"
+	ensure_write_fail "$producer_dir/addr_start" foo "uinvalid input"
+	ensure_write_fail "$producer_dir/addr_start" "1.23" "uinvalid input"
+
+	ensure_file "$producer_dir/addr_end" "exist" "600"
+	ensure_write_succ "$producer_dir/addr_end" 123 "valid input"
+	ensure_write_fail "$producer_dir/addr_end" foo "uinvalid input"
+	ensure_write_fail "$producer_dir/addr_end" "1.23" "uinvalid input"
+}
+
+test_producers()
+{
+	producers_dir=$1
+	ensure_dir "$producers_dir" "exist"
+
+	ensure_file "$producers_dir/nr_producers" "exist" "600"
+
+	ensure_write_succ "$producers_dir/nr_producers" "1" "valid input"
+	test_producer "$producers_dir/0"
+
+	ensure_write_succ "$producers_dir/nr_producers" "2" "valid input"
+	test_producer "$producers_dir/0"
+	test_producer "$producers_dir/1"
+
+	ensure_write_succ "$producers_dir/nr_producers" "0" "valid input"
+	ensure_dir "$producers_dir/0" "not_exist"
+	ensure_dir "$producers_dir/1" "not_exist"
+}
+
+test_reports()
+{
+	reports_dir=$1
+	ensure_dir "$reports_dir" "exist"
+	test_producers "$reports_dir/producers"
+}
+
 test_damon_sysfs()
 {
 	damon_sysfs=$1
@@ -520,6 +571,7 @@ test_damon_sysfs()
 	fi
 
 	test_kdamonds "$damon_sysfs/kdamonds"
+	test_reports "$damon_sysfs/reports"
 }
 
 check_dependencies
-- 
2.47.3
