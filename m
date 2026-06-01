Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B2386C16
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300202; cv=none; b=QposuV/cOVz5JN4N/1lqkl4m98yrkkT2qDMC5GPiV/KuLXPDWPhyY7zasxiFkFVZpjriHb7M+s3TiVdmXcQ+AFymxrACGc3umd0rqq2lslUxOcthS2Gh4hkUi1nlMEx4yJbNAfO4NxmXuag8ZStAR1FFaNCXXSz43RCv5vDKSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300202; c=relaxed/simple;
	bh=Ui10wFMz45J23P1UzESKZoov93+QxhRiviRiKuErgFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWjbl0fJV3qtBQ1yGOpNzB9yxLAm0or7gma+3klk8faZMIKINRiXuIr6As9NY6jSlJtMZhCgOZtwYuzAfmyQdAQjKUF3Zf/0FgQVY455lEYBIcXSYYe+eAWqle00khW6Tj0UuFuT+qCou3Pc2raPuc5xVWaoA+7b0VBiGY/WQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=S8YTF3Y2; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="S8YTF3Y2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780300172;
	bh=iKyEwkDOqalQswQ1rmvg6AgbJ6uvYlJ03lXFXs4SB1M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=S8YTF3Y2PivDAnKJlAYUN+ipvO7KPsXbLF83dHr9A2Y6jSuVnr89CiAG78TSxiE5r
	 7s0ZtHs9GiV/9MSP+BX6gEbzCzWp2qiKkuOQFPxR/6PdqznXneuS0SLhY8EIqt51Gh
	 EV10apff4ivtgiFEsEp+MS1IORMf7TzWFJ7rZY3k=
X-QQ-mid: zesmtpsz8t1780300166t38979b5a
X-QQ-Originating-IP: JqpDz2mPNA+ZctIp3x7l0Rxyq9TU/u1A+AoOY1r1WpE=
Received: from PEN1097 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 15:49:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9316155705307074460
EX-QQ-RecipientCnt: 7
From: Cheng Nie <niecheng1@uniontech.com>
To: niecheng1@uniontech.com
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org,
	sj@kernel.org
Subject: [PATCH v3 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon,  1 Jun 2026 15:49:22 +0800
Message-ID: <9FAF3DC4DEDDA72F+20260601074922.209222-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <D4787203018006D6+20260601073635.200015-1-niecheng1@uniontech.com>
References: <D4787203018006D6+20260601073635.200015-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M/5qe47GLMYOBizVx65eWdFouzicF4e+xCRO1KzC2oEf7Lw0p0hXIXkr
	p0uhtN/YY8D4m1g+cHhHTdBJjF0h52DtlovCrFPmrSzMavIoHge4Ik3SWtxJrTQ16DPAl2t
	kth3MK+ZuS/CSrzlTw76awjLUBvujLUWsQ2OGWMkjzSuWRxeOm5HF5jX2Fes2vHcUIpnwPg
	gwm8Qo6lAcbHach7rDWoIcjgrWvkMsPEpbUw0A49JRUAF8RSRS6ujKycgjuYSTG5/xTn7tr
	NNrVo1gJTRrvrSd8aj0Y/91sSEJ//Mer2bqUfBnIA57oGIMiwgUJJpUTyBkhGDFgCDss1AF
	TieRCsbwM3EForRowVGRvLtS6nM/zyWOcIdDXU/eQYnNVp2aJGNsQWfREUk3eoBLmSLzSI/
	a2FygrRXXmUqHATw8cQgXj8BqnC+dx656NMSkblwXXU9sLUHgIWmboNz3NwdgxxBuWNe78y
	VNTijUojZyBimbJXj2ZGPAr8VerBBsBVH9kupTs4Uuc0ooquhGfqhSHUUGk1g8qboZIbcDq
	MbLu7rkRzdoz8vkp0YI7IFfU1EsADRj7pPJrZu1xPP4U01mKGZSdQgdJpIp8Pz6D7X35rTK
	SFsuD+h+aEAnF3t6VVhmQUImE8p9ZtIDlt+JKN2hEPvIUak3jlznaxVsjp4JnrTe6ZciIsk
	oZ+dClC9lPhTmGvfll2BMZToz4TLyNL9dNAxD2pBTQOnGzB50ReCF+9IvfApP8/bmbRi0A5
	RuaVb54KgZrRcRXFvTtOKBx+3AnsaGNdsWJtCMc/JLeL0Uy3gjSq6lPo03X1S6O2iU1lrJM
	wNav9Q641HP84YCvvNpsLgYaRvHcBj5loZNHs12Mhjz7RGhrzfmZTdeaoP00qtUv5Gy6JL4
	2TDuRuhECi1SvQ7HXdvRZmpjFfEG1PfDtZGB4aonj0S3sUhl8WgRZGrYRUBkANiqzgUVOU0
	Gfe2yo7W2zv8hv8iH/rKAoQRfNg4q2yTEGzzpTzvSYSsdszs8osewkw1ViwS0QdUIxTqZBp
	lL5xz+X3O6987R3iW7xoc917x9p1g6oQMyaCQzRG3Gk7o0i6Y8DuZ72+Unr1VHWVz3W0v0G
	+7vz369VwLvq045jp1wvElUCS5sIDQyhYJiF78a/t0MwBSsMoxXv22cch6SbooCEVt2Igk4
	Dlh2rY33GYDnIA5zSVgfe/uB2A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

