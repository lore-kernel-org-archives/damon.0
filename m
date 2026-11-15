Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774549;
	b=pHUNACxDt/r0nyMtcr43lV+x9TghS4Dvj3KLY12ZO+pXb6nNT68nG2wmA+GRP5ApPKPc
	 7uinyfbJ8a2A3C6/H9p4Fea96qpNgeUzVYmeJ0LACaUr1QTBbMG3ax5EM8j5aw3bW7/Jp
	 Wj/zWwFbfSFvegepux6VdBFyPuMPWHXK+u/3IQpxRam0WF10RheyukakXdkFrITLPXy6d
	 JPpWZH4BhiQplZfAjgZZCsEfeedeBWywx9UmvV59lVRXc6sDxVi8xTehKcTeF+ccNb9wW
	 j6760vrVean+FbneskTOY7yRtJOWaQaPWKHrfkO3pIGGXeU2050+kobcWAU25zCof0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ARYlsg/n7vm9LXNMaknzvoX3MBFuukEjb8T+Kwqr2mA=;
	b=ziHRRtWjv8ANT0bGPjm2UTh3bGQCTCyHpBWM3ApMqjuaBO+oQk0/N2TRxt9jj1xXrX4f
	 cA08Wo62bY7T93wJ3Wm7mqm+zrLK3mmojHzoremRZPw1ls/t1dlJVExHwz5EbRyuyiN9t
	 5GrkFchPvoOWXflsZFpzZzHbSTGLEaOKk99jsPJX4EsOuXTRoOVxriMD5bDpHjUy05YrY
	 TRmC/FSkk+M5TFcKEGuqitJJiuT779AF+E+Ro0zoF1yoRLtRwE0etdD813wWr6fSi63ok
	 fvFZJjOUSTMWcpKufFVEtIGVfvOlAncpUZYr1n3nAh0SzoqnSqPBvzbtbTuWPeD3JmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrYHf+aD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507A606CC95;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrYHf+aD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DEE1F000C6;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774549;
	bh=ARYlsg/n7vm9LXNMaknzvoX3MBFuukEjb8T+Kwqr2mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrYHf+aDyjeGulLS0Qi/lr/Lu6h/exWci9yJRgjUqTadEBun+0tUWoAWrHVaSKecq
	 vleP6oiOGjHlDrFOL6lvW0FkNKpZmrV+WIlGXRLlF3mGoba7abva5MdOLTTvn+/+5T
	 9wRJNtJNZkYqpmWm0fPM2Vj+9Ht3o4lUb6LY8jW0DMf/IPEBSdDPrOITEfXQGr1sRH
	 URxrvfroT/gOz4jbXJeWlA5uY0OEVKT6t2mssWJkwuevSLbaUH7zpj0Z74iOxtwZpg
	 ZT31ZvOkTwXq1/YHuMA1e+Vlo/A3dtr4RJXGDOWlfgVo56n3b0Bo8EYL0xatGwG7ka
	 1H8ZwfTSIwT4w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 20/27] mm/damon/api: introduce user_report report type
Date: Sun, 15 Nov 2026 12:28:38 -0800
Message-ID: <20261115202849.99134-21-sj@kernel.org>
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

Users could know some data attribute information and willing to provide
that to DAMON.  Introduce a new damon_report_type,
DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0e43b669dfc49..329d8202b41db 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -753,9 +753,11 @@ struct damon_intervals_goal {
 
 /**
  * enum damon_report_type - Type of &struct damon_report.
+ *
+ * @DAMON_REPORT_TYPE_USER_REPORT:	User-generated report.
  */
 enum damon_report_type {
-	NR_DAMON_REPORT_TYPES,
+	DAMON_REPORT_TYPE_USER_REPORT,
 };
 
 /**
-- 
2.47.3
