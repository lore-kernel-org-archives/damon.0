Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BB197A7D
	for <damon@lists.linux.dev>; Thu, 28 May 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955890; cv=none; b=J9mZu92uHWsp1nLjeuqQ2X1FstL2P5ho5Ofh4ImMr4mizKYo2v/W+v3twQnlDHsVCjRsRfJggngOURfVohmwygYNrRk/FylijChFNf6zVimtEBhS3PWlm1MdHbweySrmzcdPCF86O9C7DKU1/40PQrRsJUHrj+uavS458bUIMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955890; c=relaxed/simple;
	bh=EOUTRAQwJbonB/dXnMs4Z7WGxMLzqQf+/o5B9/UPcR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiuNR/bBuVFH8S67JK/JojV6ON0pedv4fy01OMVFFvflPLkiclO8rjVqc5lrtQ6wk2dVhyIm+qlmrthayGmXVCWqX3vZ16Jp2JLUp3BFDSEdSvMnmsYezU25YCw8vceRYaK3hcV4RM3pb6a6noZcfLvWYo3YW6a/pcXD/FIkkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jtCpSd8y; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jtCpSd8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779955865;
	bh=OtizzlCEw0/53zw8NLPj1j97omDIHUW4gZwvkbZ+ZR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jtCpSd8yUgtgkbrH0WGkEe6oirzTbSwJ+bBxQBRJJRbApOVBJa7XX9xS6Vqqoq6Qk
	 UVptZBVP5nHCpkef8cF3IqeLGL3mSGiob5hET6EZUhO7MVlngX3j9MXxWuHXz+fYHm
	 k9Q05D7/iE5ljTaCtJkmpga9hmJI4m94CLnHDm0I=
X-QQ-mid: esmtpsz17t1779955854t571d6731
X-QQ-Originating-IP: w+8TIl4HFrhrX5MF7IR7jCKdH1MZYRedCQ+TRDM3QPg=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 May 2026 16:10:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4212579660610101544
EX-QQ-RecipientCnt: 8
From: niecheng <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH 2/2] selftests/damon: validate memcg filter sysfs readback
Date: Thu, 28 May 2026 16:10:39 +0800
Message-ID: <406BD1BA0F6AE326+20260528081039.1192194-3-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528081039.1192194-1-niecheng1@uniontech.com>
References: <20260528081039.1192194-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NlwPN3mHkzpj3UwhfU1CKWFXrqw1yA5fsK21L0/+1bkHnvM2JJsAa7da
	EFRAMPDq/Yj4tIVVqjhE6ioWY8hthQp50Gx81VCmhkkw0h7q8LbwbtBg/uc+EtIHh2Xwjsm
	nIhalH5WZswNzPZtYfyfh7dG5IHaC5Amc9A3fjcWDBJFeu7FH/pOyq+FoimS7OH0jraLJ8+
	iGLHF6zqMyxQllPRSm+WiwGMgG3tdpfuC4LlJd6hCp51ILSYZLhvsuOFLAKP9s/ICr2XTJn
	ULGHxQzVF//uLjaORVV0bIHE6Qw66EjkwvETzvQgWhSqF9feVe5HaLL5vLlSO+ElQLrln9D
	30Z01Pmz90vnvJmywZaIK0XJlPh/stMzVAZ39gR4t/4yrw7ATgC9v4Pekl1JFypv8utkx1A
	I5CUjN7R+gI4bF/kOn+gUs/LU4orvacNg5XkwwnuBwNiI0Qv6snw9Xnyz4xszIoQoFXSobZ
	90Zd1fgv/KCJPv2aMGjlro0vlYty+g/u0hWlvSb1GnbvMt+64nd1AxQvnr61rbqBrQVkGlP
	9oscdbJvtWO5bJbLm1QI3kEB1YYLnHziVtPIZb91Mns1bO/+5oBeQZaHc7U3gBVe+KjqepN
	slNcwV6jftnup7OPXvwiHAEKwrwvirz/lYwNo+yPdALYqpYXu2MJP4qqPxDJMMBDGsmCXxS
	/FQLMMg5WYfTJN2qbFUV8ANEKUGyArVCR0+MMb0t/yPR5pC1UU4u2eGCcE9AzlHcA8MVBIN
	75sHkYjJvCqS+KsUOiaro7Jm5MPOptjEG5tG288qN/R/xCdlhfWJskQFuj9P7OW1WwYPKjc
	Zouc3IzDQpapraYpfZP8Uku/+AVGKZ0MVD379Qms+okL8CJ6AvhvqjH7TcTyzLpCRqmZHXR
	srAIU6SzeXukTPtGMlQinv/sKg9xOWiBBTwCWRWO86zM3iX+ONIcZmYP/oYqAW8ke6rpY7P
	c6TDP4iZrdTVTcBJyo8S+vhmda9XVq6uz+TKcTZ5Fob6rtEhx9eKXiQ0sUw78EkUqP+Wzcq
	2y07OEIx9cHujaDcJd+r/27uBMrOG+YCaWF84AJcpVu3oq+POPB1YJDVhnBF/6sY2j4Dsnj
	MCOXhkcpuIBe7exHx5LkRhib4AkZp11WM1FTDo/uxUQ0t0lIFdTHx7ajJujb88FItmn6KPi
	YJ/vWh0f88V5Ygo=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Add memcg filter validation to the DAMON sysfs selftest by checking the
memcg_path sysfs readback.

Validate the readback path rather than a derived memcg_id so that the
test stays focused on DAMON sysfs behavior and avoids depending on the
local userspace cgroup mount layout.

Also compare the readback path while stripping only the trailing
newline.

Signed-off-by: niecheng <niecheng1@uniontech.com>
---
 tools/testing/selftests/damon/sysfs.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3aa5c91548a5..b595da24f698 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -33,6 +33,7 @@ def assert_true(condition, expectation, status):
     if condition is not True:
         fail(expectation, status)
 
+
 def assert_watermarks_committed(watermarks, dump):
     wmark_metric_val = {
             'none': 0,
@@ -90,8 +91,14 @@ def assert_filter_committed(filter_, dump):
     assert_true(filter_.type_ == dump['type'], 'type', dump)
     assert_true(filter_.matching == dump['matching'], 'matching', dump)
     assert_true(filter_.allow == dump['allow'], 'allow', dump)
-    # TODO: check memcg_path and memcg_id if type is memcg
-    if filter_.type_ == 'addr':
+    if filter_.type_ == 'memcg':
+        shown, rd_err = _damon_sysfs.read_file(
+                os.path.join(filter_.sysfs_dir(), 'memcg_path'))
+        if rd_err is not None:
+            fail('memcg_path sysfs read', {'error': rd_err})
+        assert_true(shown.rstrip('\n') == ('%s' % filter_.memcg_path),
+                    'memcg_path_sysfs', dump)
+    elif filter_.type_ == 'addr':
         assert_true([filter_.addr_start, filter_.addr_end] ==
                     dump['addr_range'], 'addr_range', dump)
     elif filter_.type_ == 'target':
@@ -258,6 +265,8 @@ def main():
                 ops_filters=[
                     _damon_sysfs.DamosFilter(type_='anon', matching=True,
                                              allow=True),
+                    _damon_sysfs.DamosFilter(type_='memcg', matching=True,
+                                             allow=True, memcg_path='/'),
                     ],
                 )])
     context.idx = 0
-- 
2.51.0

