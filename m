Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE0237713
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304824; cv=none; b=JXsn6l74Hf25oWJo78z4hi+1/Ss7VG+O1IuoyXVZXi+koayRboXwEgw8lHgR2KYhqoHYgblYrOaBDK+vRddWFECdErrgP/wpFsogIqzE7jV1+FbQcEVaTlaBFBOX+F/IjIe7EmY716uq1LwQ4lnxtEbgf+g2yW23pqttNQqoXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304824; c=relaxed/simple;
	bh=jKB+t2TE+SIW8PKSP2UeMVmcAiplJgCRKbwcjETku7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn0FsSfpKkT8Z8G+tRbBCumsMcIm9wI+60/wdDcjIAuPPQORjWfsY0BTV0HyW79wcyGevJASeJ0LhGjxGWgNp52yqZUISkG9QX/5tqWSpUR+c5MgE4HHiHCjdyjQl8qCT1iy/Vp4xYyfbVE6gchWWcVRwot5R2BGZ9eNefpRwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kYxuEtUv; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kYxuEtUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780304803;
	bh=lAHbdeOT8ZX8fshgJDDeCFa1dLV9zKerU9/NHqvyp+U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kYxuEtUvBR1e2XiFQumuPUQdouL/6nCc/PGwWOTCpkUwOu6CA1uV9fJKBHYI4esWi
	 XF5wAZvksOATLNbVxOo3YVDVRBZcoK/eKJyuCCs6zPXXwlRJhPwXX79Wkl1UJXJoK2
	 m3bimuBBgtXpzUicC/YdFojCl0tz1q4w+11d81cw=
X-QQ-mid: zesmtpsz5t1780304798t67d8a19d
X-QQ-Originating-IP: Er3M68l1E0Xar1zCBj8gD6rIxkoUlUhGdvpeAZizzh8=
Received: from PEN1097 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 17:06:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9912389010984352199
EX-QQ-RecipientCnt: 7
From: Cheng Nie <niecheng1@uniontech.com>
To: niecheng1@uniontech.com
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org,
	sj@kernel.org
Subject: [PATCH v4 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon,  1 Jun 2026 17:06:33 +0800
Message-ID: <D2B37130D38E09AC+20260601090634.241864-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <7E6EAB7C1BE04DEA+20260601090119.238457-1-niecheng1@uniontech.com>
References: <7E6EAB7C1BE04DEA+20260601090119.238457-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OaHhCqwLoLqrN65ABrgAEgxEzVdlUgQzzuPiHJEuDMVxZ5YDH32bvBzT
	gUooTyDSkyOY5QNnuK258Ldce9bF3XLQUrEAaPnJjVPHERbG4HqBceqxo42FG1g3igMnTln
	8HecTcXT8C6+pb4TkSl18GUhgKOIt5w77fooeU36eG97f2B2lyvq5giF4sTM/laTb37jSFk
	HL2Y3z8PfeFem6XxDIAMnJ/9Pgj2n9Hnc/Bzfp15dAAo3TeJiWKQq2kxA85nqlY4c+3tghj
	DnHQ03rXe/Gra3t3sg4YpvgI2wONychFdmDTzmMpjmGZDaXDmvieJ+OV4ZiCXu5LspMAZWw
	R13YvlsJx2dq3MPNxVeNp8lqApWE6Ehqlnw1MwwMQzo0p0T6TMkGQeVd65bpJk98G33fO2N
	3m8T6tIV40guDF3pNeF/8YwDmCkCAD9LHr9IIDNx5HKY6G9uucQjirZP5+BqhyxsbIij1bW
	I0Pc4U5bA8tSdt2M+614IXbc/AWm6F8pJJdw16HV35HieFCIxK8URpRoJ99JZ9JCSf9/pYz
	oelSCrdBkF2tZAi45csm6K7jdcSblcQowZGjD30DpptIGlF2tuFEuJHvGQZ5jBr9Sx/xpEd
	odXWexTeqiYbsxxmwGqdQxwTt1yrUWlT66DGELYxEsIhOLMhGZVWiBhJZQtBib5WRm0K6fn
	xMCJ/9FLlkX21SNqs65pLlaEQraiyJXxRmvcnfcB6XveeeEPfIvyXVKZO0LztYUZ3Hm5jIZ
	qz0hrSFkmdKgf9PFSPxuC4ZMPbl6r91HF0VJES7N4oQAy3WBhotLMdtwGbZmX+e3B/ZzYUI
	GRMOwxxhgF3gsFHlK+1E3N2huyx6PzzkkdVpOnSqEvn4re4yMR8nDzAd7HjBvK1Ash4fXk4
	rN0f9SYtMhvAEtOp6hlrxvRMUv4U4yyg5q3/iLiIot68n6DpSQNeA2yCXkEbpWg9HyQdI31
	UV8+RH3fYpZ6j5p0JEUdrIEHwSMhKyWo8W6aG9yMG2foi2lMj0YA403jv4O9VSxgmlHSm2F
	/tYiyy199NmMigA31s7XgzXFQP9yxNacUQWmAhZKEuSR3Pvv2ISBjvHzvjsakuDJ+xnYzcJ
	JQg6eLYm9fAjDC1n36mvHd4pabvs6WKcUGsKLHUAi2crAR8o286KINxWxPutMhbhx/9hPaZ
	7hzWJE5P62+sZNtgF6KwJI5uSGYV5wwaIRu9
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Add a dedicated test at the end of main() that stages memcg_path via
sysfs and verifies its readback.  Configure the memcg filter before
start(), do not call commit(), and ignore start() failures so the test
does not depend on CONFIG_MEMCG or cgroup layout.  Call stop() for
cleanup without checking its return value.

Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
---
 tools/testing/selftests/damon/sysfs.py | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index aa03a1187489..35be32cf49ac 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -250,6 +250,35 @@ def assert_ctxs_committed(kdamonds):
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
+                    schemes=[_damon_sysfs.Damos(
+                        ops_filters=[memcg_filter])],
+                    )])])
+    kdamonds.start()
+
+    shown, rd_err = _damon_sysfs.read_file(
+            os.path.join(memcg_filter.sysfs_dir(), 'memcg_path'))
+    if rd_err is not None:
+        print('memcg_path staging: sysfs read (%s)' % rd_err)
+        kdamonds.stop()
+        exit(1)
+    if shown.rstrip('\n') != memcg_filter.memcg_path:
+        print('memcg_path staging: memcg_path readback '
+              '(shown=%s, expected=%s)' %
+              (shown.rstrip('\n'), memcg_filter.memcg_path))
+        kdamonds.stop()
+        exit(1)
+
+    kdamonds.stop()
+    kdamonds = None
+
 def main():
     global kdamonds
     kdamonds = _damon_sysfs.Kdamonds(
@@ -356,5 +385,7 @@ def main():
     assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
+    test_memcg_filter_memcg_path_staging()
+
 if __name__ == '__main__':
     main()
-- 
2.51.0

