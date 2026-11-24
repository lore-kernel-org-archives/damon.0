Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534624;
	b=06nVUmCiGROVO6dwu/P/GgeEtJMPuaz0mFaISBOxppZpOImEWqTj361qDWj9zPMz/uEj
	 oO/Smi56LFb6US8WIH4rpZYWxsHgITypXSda5QloC30D18+Fkfv97YSOe6bkWiBC1kXkZ
	 S/iy7PMMmPtN9k8N0GavwpsiT4whMvF49gRPWJKNyA6zV7Lp4bT4up1A1OBTWkfQw8rtD
	 V9p+YHCwrBzl+mSP1/wcq929IylKiRhGcudxUgUANbqzFkf22Mw8l9nhl2fq3R/gdUQI3
	 A5qIK+3km/ygrprbIm7/Wrnl3hej447nTzY5y0Uu21fZmWGaBSXgE/MIrX2ex+uqBBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VFtYD/uH6yXovXFjGtew5hKjn5SsMtqJwYXOh4QWcz4=;
	b=C1YUFd5hEVDPCKcO/Y9kSUONyspMjuq1y3/okzueeMDyMvWUnONSbkC6QcAEYnbnvrxa
	 +EPdJ/Br+FdHQRn4mqCFBdyUeSbuBsH/1xyzrU99nOY/m5hDS8FU+flaAR1Y1ZHulzH/L
	 bx3poY43EJK55Zlz/5fznaX9LgryqIaGf4f8Iv+fnVpfY483s0UGZ5lut3cGc9NhSU6Cw
	 MoklQrs+Zu7iP4YDAQjg90w/ql3X3hiU5EZDUd8+VLmoSBA2JIZVxDgZm3UBVCJIbIQmg
	 6p9c9JVHZ/nS7CnESYKaI8YwFhaduWxtx+9TR4lQuT+eDJ9W+JkKxUkQQAr0OOwEheQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXU3lRrz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CD606A31E;
	Tue, 24 Nov 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXU3lRrz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF01F000CA;
	Tue, 24 Nov 2026 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534623;
	bh=VFtYD/uH6yXovXFjGtew5hKjn5SsMtqJwYXOh4QWcz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXU3lRrzDxiSDS9sWMGfkCgkHJxJL2czX+jTtzCzUU9gtPOLkTF2ZjXsT8YvE4OU6
	 bXgW+pHfPasEqWDfPRlFy0oKiP8h9dlE/Nvv9nilRA/vAthUsHvMZ2T8cpXHB5pwda
	 rDf1YI+4X595k2yLzeTPY9QARkPhPyFNZt7wsmQ56uBVeyNAnEp4isCnGETkOh7cUk
	 s+VbTPa+YAjelZ3+TTde+kGlHTXnI4zoM3xsTjBIwMuGeFq4/X8yNKgLBBENigd2V+
	 Z5cHzcyeNbWp6DqgA0kaOipr3vVaIqCp6vz/cuFUKiNu8FdwXGaVGdRWKAeaHsU0ow
	 3561PY9LvASMA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 24/27] selftests/damon/sysfs.sh: add basic tests for admin/reports/
Date: Tue, 24 Nov 2026 07:36:30 -0800
Message-ID: <20261124153636.91854-25-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
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
