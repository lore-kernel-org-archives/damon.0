Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968560;
	b=jQ19SVSGOBxuptrh3DjzjhBTDe5YzKRwBu6jcnHvyfxTBFoqOkqTw2ApidBlXeEEEc/x
	 s0+1QJcvhqCtG8mzguVcomkAcd2VpGMwGJONmH1brcEt+BTJdeoQJDGoEbU7PZ2Aqv0uT
	 ssga2iiw2D6B1obPzAq71QrP3bxsaGdbiCAhgJbTIRRZDl7YNOEkCN05aBMQw/BIRNWZh
	 xAe703LKz4ZVn7pdTRe5rNSONQeA3cBw5FWrtAJhGBIKRQl9EljFhDwEmP57EW40bkEeC
	 Ao62au9YQoNHNKPCHKfRMBji+sSpJmm5mIpwt3tHlMWidDITBDa+ZAORiDeEcKlqEpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W6sgrGq/PIPvl2dUtr0MUNu6vsfTRiTVsaaYrgPkigI=;
	b=fEWOxdzx+J2o65+EPSzlFzLzvCtoXrnZeKUwqI0j+hpgU6GMQ9NfwciC9O7g//k7P1Qj
	 4Uy0PXE39Ve+BFbxyJVt8CkP7X59eqUb25MQu7+W4g/dVJQMcM6XYxrznSNeIf8KxECoi
	 t3X496BV9ZHd1EVgGsyBKh+bJJBgMynUMxazZnLx6C4uBkQRqH+ERyziR6MxCxKHMGtNf
	 fJI6bg8xWV0lSJAXnoPuVR5KfemkBqxsz8p68bZpwxgj5+14bkshlWZW0SrxRAJmfeLY4
	 1bKWm8ZNWMDgD4+r39+kpOShdxfgPebiSBSDFtrnY3gYFUpt3KOjYszeZgg85RpBPYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nx1g8nk8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A3606B566;
	Wed, 18 Nov 2026 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nx1g8nk8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6765A1F0093B;
	Wed, 18 Nov 2026 02:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968560;
	bh=W6sgrGq/PIPvl2dUtr0MUNu6vsfTRiTVsaaYrgPkigI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nx1g8nk88w+k5bEx5XcdXAfwU+9OiWqJRGKxYuZmw0O53h5HDZbLdkvsj7gAgWvTA
	 4PeHAObfpdNB0wTN9BCXw131W7TDlYQ+A2kA6gsAMXBf9/rf9umgorg+50rgTTRA81
	 gdjI+9/mQs+LAjSPYmLXClCn/BbHfeZIaR4SV8hvNOpu+vZoaUjcIkHH4/FOW+WcMZ
	 3HnpKMPi5TU/jXej9S1C4m3BNPpz/oRIU+LUUf4fHmgADhdr56kfoRIyb4gpDBPi3E
	 Kou6Tde9TodAlqRDzff8jmYTiwgzwr/C1vigVzF9OBHgsGlm0UxIX+VhgJzMAd7xQf
	 Kw8xcSnK3aCKA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 24/27] selftests/damon/sysfs.sh: add basic tests for admin/reports/
Date: Tue, 17 Nov 2026 18:22:19 -0800
Message-ID: <20261118022225.100659-25-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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
