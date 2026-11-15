Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774550;
	b=ErxrCozpP7aqLNqHAJfBoou8PCrqPp06I2+ATdDz5JnQrSPUfmQIFmiE1mxo5ZU+v8mX
	 BBood7EQvo2XQdGf8BgiHvDIhUUl7QXkO5VtNW6yZ1sHrsT6IJY0v/B4sugvBQGh+e0cH
	 J50t6tP5y8IdIahVnfnRzRLefmI0BEj968PIFEWbuo2WcLhMiwhRZKOQzX7U4t9t2D1UM
	 mDocfJkJ+68T/07Q9IJ43oqrsfA4N5e75epwNnOsA5G7fgzPOcxBq6aqpLLPopBE0yDY3
	 Q/AsWdaftwQPcc5Tjq+bzuDwjLjFpwuogdNYbeuD20rMdWcmy4dYkvbiZgvD7vy3GHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W6sgrGq/PIPvl2dUtr0MUNu6vsfTRiTVsaaYrgPkigI=;
	b=dTqoiHkPmfPH3NkPRjWd74+XPxFWJTq5Nli2crEPxcZTkwPydqWoUqE8DlTboLK4YwNU
	 3e9PCWJrmPlxU5rqjtk6eYMfC8jDWXEqDeaGglyK+lpoQCKYHB6E7TsgWAYM++XUBMiMo
	 PGc+HwVMzNIKAfAcRpouI2RC5Xpjxj8q6GZLdjo13lbTJAo+e/YOp/Vl92jOgAX8cAXOj
	 y5SrR7it646C49RFMxZS5jK3jneN1JqgmbapbrR2Iv+6GKnPl+dUGbwNgXeHW3e2uAjzP
	 P8KDzTm5Tk5wRVrNc/lAm4rxO4Ida7eVRZ8EMm9Q48Q7OzNYyXfqLMPaiRjY2zFMQBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzuLiX25;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93274606B1DC;
	Sun, 15 Nov 2026 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzuLiX25
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A851F000C8;
	Sun, 15 Nov 2026 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774550;
	bh=W6sgrGq/PIPvl2dUtr0MUNu6vsfTRiTVsaaYrgPkigI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lzuLiX25gw2GZjl9a/4QVtmg7J42CRZmnbhDZJul7b+jxLRzFDkvM1tct6l21Ny47
	 VprzVyjkd6DoKUoAGGKwe5LNMywgrO71Iz4eILsHyO2a415ux3XqYiEZ10bdeerlKH
	 3fI7ZlcPKahyuDSD9IJLXR+8tOJZ7Lyay1Sk///sr5Cksa89ps8G3RJRDDQRTaxH/Z
	 80JxaQUdQgHdaoRfpF5RW1GruSaiSbUu7R5a8sNDC6d5wlJ30LEpVbDceEEHtQmVAi
	 DJUFHQRXXoIUhi54P2+0UtsymNoSU8ysbNIXOVFMG3HaC4SKI6JtygZXhgudijaWiG
	 lT6YfcOVsogtg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 24/27] selftests/damon/sysfs.sh: add basic tests for admin/reports/
Date: Sun, 15 Nov 2026 12:28:42 -0800
Message-ID: <20261115202849.99134-25-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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
