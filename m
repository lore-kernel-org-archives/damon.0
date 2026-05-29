Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F4348C5E
	for <damon@lists.linux.dev>; Fri, 29 May 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046533; cv=none; b=MduAv1r/nVJVSA61UW1Z9VcxbGbPKHlImSbJ6hAhrFYsr5rDsm5VjCoB41lta0B0F3duFy3y1F9T2LiZ/1NIOGVUu8gcdIkvlR9rhtBBjw23yRs13Nxc1Td2pATPIAHz7CAGV4mkGYE0IuZctDB1Z5qSuZNBV241M/sNIcU9U6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046533; c=relaxed/simple;
	bh=CSKQ1mUJep3xo5dtlv6+IPIZTxEkOQs4c5ARJks54ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuMLlI0j5CeFiLo9Gwc7I9GJKM/2qZSzcF1IJhwbQZ/I5OGNIX+yln1YV+eQ8pW0nKyp79Qc1UZB8Ml2rwhz8jKZ2xE2LmF+HHeIWsCs1PyKrZYdo8TUOpCC3iy8qwxdOZtjXTiQq1w6Q+rioTOx8thGZYcEDlWIypPPSXath8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZLt3VEXe; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZLt3VEXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780046507;
	bh=HylwJTKDEjdoNKKWZ6Eg8/02B5viIR23i6MNlY5fspM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZLt3VEXe9hzaPs8160QBczBg7KZjf8Ju/zdWS4Mf0LsT8wUAVZiPSJ9MkFhLUdcbA
	 szQKyto/d+wtOM96/9K1E8fT1XvokuZHQNnFGRUl62EkH414gR/7/J8jnD8jc7FY8Z
	 xAdLZdEw3SSvXSe7jLceOtX0oOcMocUr5w7xuMuA=
X-QQ-mid: esmtpsz17t1780046496t9cd9bc45
X-QQ-Originating-IP: 5UBRpNotQxnNW9HKXjVMAySgKETLGGMgdHkYNKWLoeQ=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 17:21:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8261288960962780039
EX-QQ-RecipientCnt: 8
From: Cheng Nie <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH v2 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Fri, 29 May 2026 17:21:31 +0800
Message-ID: <FF9A1552C03B7C88+20260529092131.1703337-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <4CDA28DC581FDCF8+20260529090845.1696845-1-niecheng1@uniontech.com>
References: <4CDA28DC581FDCF8+20260529090845.1696845-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M3Y38+foqXFqd39Vo05m7qqe1YkKOZngwhy+l2ffA7pcW6jfMqGpJjzB
	3KmYSq3A63PwrFSX+bWRH7E4IlAKxox0ib9LBwEdqzvyODozryMhPpk5MNjPfHeUuDZ6rHi
	KTB9h3s556hS+7ywgvL3Q+SUi2Z7TgzKtTHF3HZNfzhsVfjCzCskxvwkV/OQWFOsPcV/ybO
	d7NHAf8Ue2LGas9wxBKrf3iWfHbPorjwYF8gnGcgQRCBMIyGe3ap3G0sDlfsXDsZW0uI9Z8
	C/xObQMV07FjhlS7BqWNG9bHYNPuCMGkWWM2yy45SXlfuaSgwoAXjFNkWPZfRvHhBIuLKXw
	R1NC0mpRp0ur4cvmHK2gqoWCFrhcWz/G6cBAXiPevB+ICiaT/c2QNsvMuQ1ryEoN5n7Y8Ll
	QlkghK694W0gnQgG+Fz5iwE1am3Ny8C9rc/4/nyMter/gTEClCi4NHtOJUa9ppyH0Jdnh+t
	l9VaACBXcEUZ8nAWfwmS3yQeJAiZsCVlc6bV6YusJNo/1igYs4XXUAi3nwR433/1+i28AwF
	AVnMtxME1o4RyFIW7hMZI2fOJdl9o7U9xdZCQkVNUcwjVElCcEm1hBz411hVqJd33flinXL
	TimRNiFfH2fqZndp8zSkMsZ9jIV5d3z5mDuWx03dGm52WRUafQVEi/E6TubQbDHUMBDPzxc
	IBAaVYHQmZckLghhRKt+en2+yo1FrCSRFnXVrs8S+21B9BObKQ9BqDKCsXkgeGPtswVNN5G
	cXzJspMyVZ8xIpNGBgJuDWrOsPWJFV/KNvOuWd6AWRjKM3hdSyS64frQMf52DL2kKjQMzV7
	C3s4ehOn2C8ANakVyZ2qIthsibmMvePA7otnh4B0ITsdEizhWBb1eK7ifzDCcByW0oF88ga
	/Ohytup8Bv0eKcKJYPe/9wD98ktSguhgteUKUQ2Bc5myTP08PosLb3oyzIvLG7nbP1Hxfnc
	AqBFdqmbwONJwdBz0e/Sl0Eyzma9YyoLMTo2VUKlmDG5yx3ljS1ZY0tKT8PH9DwQfnE0F2G
	ITQTeZlAxfojIwPLaxq03D3J2551DlMj4PGrU3+wuMxVH//YaysUqEb60xn4oc9DSgMMLZQ
	g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Add a dedicated test at the end of main() that writes memcg_path to
sysfs and checks the readback path.  Validate the readback rather than
a derived memcg_id so the test stays focused on DAMON sysfs behavior
and avoids depending on the local userspace cgroup mount layout.

Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
---
 tools/testing/selftests/damon/sysfs.py | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index aa03a1187489..0f20bc9c46b7 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -250,6 +250,43 @@ def assert_ctxs_committed(kdamonds):
             if ctx in ctxs_paused_for_dump:
                 ctx.pause = False
 
+def test_memcg_filter_memcg_path_staging():
+    global kdamonds
+    memcg_filter = _damon_sysfs.DamosFilter(
+            type_='memcg', matching=True, allow=True, memcg_path='/')
+    kdamonds = _damon_sysfs.Kdamonds(
+            [_damon_sysfs.Kdamond(
+                contexts=[_damon_sysfs.DamonCtx(
+                    targets=[_damon_sysfs.DamonTarget(pid=-1)],
+                    schemes=[_damon_sysfs.Damos()],
+                    )])])
+    err = kdamonds.start()
+    if err is not None:
+        fail('memcg_path staging: kdamond start', {'error': err})
+
+    context = _damon_sysfs.DamonCtx(
+            targets=[_damon_sysfs.DamonTarget(pid=-1)],
+            schemes=[_damon_sysfs.Damos(ops_filters=[memcg_filter])])
+    context.idx = 0
+    context.kdamond = kdamonds.kdamonds[0]
+    kdamonds.kdamonds[0].contexts = [context]
+
+    err = kdamonds.kdamonds[0].commit()
+    if err is not None:
+        fail('memcg_path staging: kdamond commit', {'error': err})
+
+    shown, rd_err = _damon_sysfs.read_file(
+            os.path.join(memcg_filter.sysfs_dir(), 'memcg_path'))
+    if rd_err is not None:
+        fail('memcg_path staging: sysfs read', {'error': rd_err})
+    assert_true(shown.rstrip('\n') == memcg_filter.memcg_path,
+                'memcg_path readback', {'shown': shown})
+
+    err = kdamonds.stop()
+    if err is not None:
+        fail('memcg_path staging: kdamond stop', {'error': err})
+    kdamonds = None
+
 def main():
     global kdamonds
     kdamonds = _damon_sysfs.Kdamonds(
@@ -356,5 +393,7 @@ def main():
     assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
+    test_memcg_filter_memcg_path_staging()
+
 if __name__ == '__main__':
     main()
-- 
2.51.0

