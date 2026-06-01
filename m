Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D12F691D
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299970; cv=none; b=O0HgQb+JpCt0GTbcxFyqjf6dj1hEVe1hd8G0O72gq/BKSiDyu2zRDy3WuqnugBU2fA7Nx02dQ+SvAuVaZ3en6tLL8LDbSOv6qykugI6WltEa+D7tCkbp7ERwlBjJTwvc3M7QoEcr5eoiwK/65VHAWx92vZHhRy76nY2/6Z+03D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299970; c=relaxed/simple;
	bh=Ui10wFMz45J23P1UzESKZoov93+QxhRiviRiKuErgFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwBlimrCeXHhvpbI2uLMVVsTjBZZCkC1x9uDzZUVq1rthMZ7OSB6WHAOag12BKSWvj2HunJV0ZCzt+K0RkPiNKg6g6tcpgLBwWi2xZTflrQbGv95w4zezdWtEsoWQzDGQKRSP0Xv7tm2wevgQ4oa97mi4FL5hWAOhBA7l0ou7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Phy+ESHY; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Phy+ESHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780299954;
	bh=iKyEwkDOqalQswQ1rmvg6AgbJ6uvYlJ03lXFXs4SB1M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Phy+ESHYTnTiP5xB0SyzTmSkCe8vVFWugME9ZnndAI1ARiNN2sN35+AIYryudEbxK
	 9dBCa145Q818TokHFm1Om/Vd3d7MOK1BJRNjPPHmjRH/xkgwLoEMUbAkg86KuU+f+W
	 YbqHJlMEq8KvZzeKBDMKmlQrr9RyPuuDxZO1OJE4=
X-QQ-mid: zesmtpsz6t1780299943t5ed19dd0
X-QQ-Originating-IP: ExqSHFqpbSAZiOqWYUgRQlClVGT7Rdp2BnFYmqkl5ww=
Received: from PEN1097 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 15:45:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14208097749711545290
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
Subject: [PATCH v3 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon,  1 Jun 2026 15:45:33 +0800
Message-ID: <87B39E0F19A29319+20260601074533.205616-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601073635.200015-1-niecheng1@uniontech.com>
References: <20260601073635.200015-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NqpYruwlneiLd4+90csc0Uz7O5BhcCk49C2h/IwNVRqp34joGqK9uw8p
	+VBxHP9kIJ+o5AjlN707vFeljzZv65zCWyOeHP67+kQRYEr4xmoPySRYOhWIPZpRDA2ZjHp
	wv1I3u7gIkkrBYQK8JjpJ7ulu3gM6tOYCUgzLT1VqfX4YRdforMYhxIF5/d2/7liPsSfqMW
	/edYJz06UvRgmGaxptY6yiZFEG+EYGixWVR5JsDC+XhZ4vu2dszDtCNew45hrJE8v+e8d40
	5nripfeBA891NMJ/SJX7G1RLffiEPRctBRVaca3WX+34eM7I66Nixp8Qozm+fYKR6On1B/A
	inlpDpEwQVU2IGhQuHlyGbFoagZtkiU/jX/V+0mbBU8U83tTRdylMx/V5MKBIYOagne3Mtj
	GdrK47CK5taO14T4i+qHZFokDHIsK6nxZd4xqP4+E0yJ9PZIMZVGV0qUJFDlTR3eJHyosQF
	7G33bbz4WcHWPpZykBUkaoN5QKfAdRVfRC0xI8u9w1lZqN4iaORYTXCk0WeqRbXjDHkhqZW
	7A0/BMZ+h02H32XV9e7J1c4eQKwKpzuzysvI6TYTHy5mjG5hNBKWLISpuEV/vSFuXoSPEOT
	DJmJyYOcsT0pIhJSjzR5HZ7T4DzSIP7trmi478d+JGuDawZUdFGBZ757BioHHLJV3PKlc/o
	W8uuj5fBrjCuADh8BFeb+XW6oArSfxhp6k6Vm0aDGbycw3uOMOpGWyygJ91ONSKH30bmTpu
	XXHQAkyZVfNmJa0BhjlrGBR9lLGv7hz2xEEJUkAz+4bM9ThX+qytj/7fW+c5gyc7alhHbMi
	GHaUoKNlu2y3SnnCyeX0NH/51sulHne+txsb2zMV8mMvKNtyG0Zqvx+E8W3kCzcaW1gdMlh
	XohVA+ZUBY9h8vzPvc6ghsqso5lSCNLOStXo0IJwsZVEVPM1d7jhfgql4g3p7H24eOgaHW/
	vKThboxVmSTADB/XIxgB96zZBbVlWAztvk2z4lhDy8waXtTAlH5fDxzWwPJaE9kYtn5jqup
	EQjxMCCiA5hwKtNZxr4rJ1oyInJXSsfNRy2XUK4czu1j3P4gNe439RaIYMRmTwnCFQTbe4I
	kYKqeUDAN5Uiulia0o7d+n6F+0+f+o5vtVfUXrDfFabXBzDtYEZg2k=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Add a dedicated test at the end of main() that writes memcg_path to
sysfs and checks the readback path.  Configure the memcg filter before
start(), verify staging readback without commit(), and ignore start()
failures so the test does not depend on CONFIG_MEMCG or cgroup layout.

Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
---
 tools/testing/selftests/damon/sysfs.py | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index aa03a1187489..7a17ab88361b 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -250,6 +250,38 @@ def assert_ctxs_committed(kdamonds):
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
+    err = kdamonds.stop()
+    if err is not None:
+        print('memcg_path staging: kdamond stop (%s)' % err)
+        exit(1)
+    kdamonds = None
+
 def main():
     global kdamonds
     kdamonds = _damon_sysfs.Kdamonds(
@@ -356,5 +388,7 @@ def main():
     assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
+    test_memcg_filter_memcg_path_staging()
+
 if __name__ == '__main__':
     main()
-- 
2.51.0

