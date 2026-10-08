Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5CE3876BE
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476666; cv=none; b=eNIAmwjGRHADjGG54XWJMNCb/IO2r8WDYexHtl1vGVSiP6Was4tDG4SdbQSLK6G5DLfY90fAJlbKLSQ/4dAW6FNyb1/rIfcaTmFqyyB0O6cb6q024iPAZemMWPVhs8P1L5hX3eUbF36go1wcEX48shJidVJJNgNzDqwPM9idn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476666; c=relaxed/simple;
	bh=EVGdoFZuGaJnDSkO79RAK/Oo041FqfATSa4KcA87l1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t14Ki2kODOjUvSBhvkFiJiD4JjxXKyAhyX8zUSNC3U8VFdxeuk4Hq6knCehFS5S1d/F9ARaVwCnJQmRgHTggB0VuWqGjvC82qksDKHMm5gd/Cjr/fu1Hb5cQwfIMfyTi8mQEtJci/OQT6sOR0CnkUOEpO33LnjDw7i7hbJ9R+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kIEh5TwK; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kIEh5TwK"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j0wL72g10zKp3n;
	Thu, 08 Oct 2026 18:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791476655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5bPypBCTKYm/iwPwiaKupGULbBRaR6fxPaTi88ylUjY=;
	b=kIEh5TwK6pPwT3BN773nkeSGSir40AOfj1vsSzuZYu7Q4Zw8KiBPvjAW/mDTs7TtZiurNW
	lczOG0VKMvB3oP7y36vnoW4XFxS2oRMKJbks0TIeTGfRjfWRyFubFn5xAmSw5DcdjmXB1p
	sBvVVgG99XMOgLgOO7ItpVCp1Bfe8bbcFfvvASJ56xH0tu1Er4mHR7dg2a1/ABLUyWst7e
	DTpbcyku/IzuyHq2N1zDxw43gP48UkTvckpbEf2mPEg5Pq0dnOhzmwcJiGVXdgFN7/RXmn
	6Zczo5kc79mrMmcLVNFhdvFrdoiUJD20HwNJkjbUxJxXMo86hrd+UeelIdxzUw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: fix typo and grammar
Date: Thu,  8 Oct 2026 18:20:10 +0200
Message-ID: <20261008162010.4010682-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 146527ebf00b3996ac3
X-MBO-RS-META: j3ekztrcsey7e6x4x3jgeyzcex9sg55o

DAMON_RCLAIM -> DAMON_RECLAIM
set as -> set to

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
CC: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
I hope I got the right git-tree. somehow there's 'damon/next'
and 'damon/next/damon/next'
The other patches will take a couple more days.

 mm/damon/reclaim.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 014b0779ea..a84cea070e 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -19,8 +19,8 @@
 /*
  * Enable or disable DAMON_RECLAIM.
  *
- * You can enable DAMON_RCLAIM by setting the value of this parameter as ``Y``.
- * Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could
+ * You can enable DAMON_RECLAIM by setting the value of this parameter to ``Y``.
+ * Setting it to ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could
  * do no real monitoring and reclamation due to the watermarks-based activation
  * condition.  Refer to below descriptions for the watermarks parameter for
  * this.
@@ -31,9 +31,9 @@ static bool enabled __read_mostly;
  * Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
  *
  * Input parameters that updated while DAMON_RECLAIM is running are not applied
- * by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
+ * by default.  Once this parameter is set to ``Y``, DAMON_RECLAIM reads values
  * of parameters except ``enabled`` again.  Once the re-reading is done, this
- * parameter is set as ``N``.  If invalid parameters are found while the
+ * parameter is set to ``N``.  If invalid parameters are found while the
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
@@ -92,11 +92,11 @@ module_param(quota_autotune_feedback, ulong, 0600);
 /*
  * Auto-tune monitoring intervals.
  *
- * If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+ * If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAMON's
  * sampling and aggregation intervals.  The auto-tuning aims to capture
  * meaningful amount of access events in each DAMON-snapshot, while keeping the
  * sampling intervals 5 milliseconds in minimum, and 10 seconds in maximum.
- * Setting this as ``N`` disables the auto-tuning.
+ * Setting this to ``N`` disables the auto-tuning.
  *
  * Disabled by default.
  */
@@ -151,7 +151,7 @@ static unsigned long addr_unit __read_mostly = 1;
 /*
  * Skip anonymous pages reclamation.
  *
- * If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+ * If this parameter is set to ``Y``, DAMON_RECLAIM does not reclaim anonymous
  * pages.  By default, ``N``.
  */
 static bool skip_anon __read_mostly;
-- 
2.55.0

