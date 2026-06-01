Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB637F8BD
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300163; cv=none; b=Ps0LwN7yWEcacYAIPsSyV/Tl4h9cci8qTfLMRYauz8rtAl2qA7twaCu1QwZ6f50DHun3rHHs24SS8vgN5L7vnWv5hK+9/YyOc1S6zxIYI8U+lL29/Im3d8jWPgERBZNL3QGf/sqlo9sLBapi/ojVTiWnubItHKHpJJrCCYWMDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300163; c=relaxed/simple;
	bh=0aE6h/5Gor35FT0+47VDSaRxZdUotrOoDslgItJm8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtMkfnI8XB/oyJxw7PT5A33SN7Tft4IfcjFHL/IYuoLSO4eV8vnm55+amHSiNjBmca3NEN56MxQnNSxdos2fNiLdh4tnUKUgveUdaxfjV7ZtI7Qpm68r5Ae80bXOimZqLwmQuqn7cIQ1TTwL7mzcE5zNZkjF5sgcn8aaLVXnzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iJWubnZu; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iJWubnZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780300139;
	bh=ea62rNturdRY4XhPqvTtukJW98iV/DZwMOLJ/F5D8vs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iJWubnZun/6JXwWwyKBES70kPEdA2PDRD+Gpj9FJDKg45hNtZXNimTAdIcoPupW7x
	 Jl6CSkS1AlKd4qKs3sWJaOxAtibmuQQOmoTOmpy32nMKTQEWdiHExehV8C7Gr2LcVJ
	 QJofNlsZfGvPJxGvcMgFGXYyVskrYZGy/iJWKYBA=
X-QQ-mid: esmtpgz12t1780300133t483c7627
X-QQ-Originating-IP: AuBRQDf+rRPjo7dNJJXoqZJl3lWoOPaEZfnf7IeH34E=
Received: from PEN1097 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 15:48:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15829220135844779042
EX-QQ-RecipientCnt: 7
From: Cheng Nie <niecheng1@uniontech.com>
To: niecheng1@uniontech.com
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org,
	sj@kernel.org
Subject: [PATCH v3 1/2] selftests/damon/_damon_sysfs.py: fix memcg_path assignment
Date: Mon,  1 Jun 2026 15:48:39 +0800
Message-ID: <13D41964888D2DAC+20260601074839.208530-1-niecheng1@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N+Pc87eOxrZlcuhRfieXgWE8Lf/Xf4ufFbYsZEzZIQ9CD4fKJVhLS2Bc
	BHU6ZQO3e33IFmdOFL9EOu9r06AF66/HfDFRoO7XqD716eOP9uOWU4PYVYrzpbyBZtQe+5A
	IEMfPTs2b3ojERoS+PwWTh/bIbbPn6+5z6FgJnQlbQ37ArTuvpT0wAgr2ZlZzetVeYKPAKs
	TjPhy0Fm/1JkOOmDfOvYf3BUzp5qv1auucyqnRtVBqE4NomrX9nVSNq4h9woIBBgCbNycTD
	HfS3rdoBAczzRRcwNlkRnDEruvDiQjq8BvTGjWVXi1gC3T396EEX0f/PG9DbBIAd9/UiHzc
	6qikehy/UUua4hXqDe4z8QgknOWyuaxzRKjq2Nm97C3wLld2QvUYhMvERm/ozQfGy26/BBv
	m+zgK0RLQ+uyR9QcPLTcorH6b2m17gSIcOxJ1pWMxXoS5/5cbMcFm9Qpd34yfj0x9mpFnKR
	+Jqml2KdKXsonywl+ZMDqKCDmO1r781t1DIegrchdPErxucIoCTn6SgyhqeV9bDqwMO8J99
	sTCUfWbJCb8BEHRJTmsUlTR8lbrp3vkOaBWwpQOfk8Yl/NaxLvODlS0/ynWnLxEiFTsUzb6
	XbPlT4WpHwPSiDZEhbNvgtHZennKMv8E5lkMPbkFOKUegt4L01oghlrIxKk9CFwO9BPlhw0
	vDmsXvdz26aOt0Ixa3wznszD/+shCvQYSMae2nztTlSMb4XVbQBlZ6/LyyY7r99C2vXe+7o
	BJh7QriLr9gDBPl/0tOgcWV1JUBqJ3HDTH3fR7OazMkSzBzp6EplwqgzCsz4xpN/tHnFBIV
	nMds/rHB3814o79t7/vbFMS5A5iDklHeQnXS1BbzApF2PwRT3xJAeRlgGOb39+8Tmwo+Mxb
	SrRfJEOza0DWZJIUZlq96QD2LyjEVqaEOr1r72xqnl7EUJyXxYbS7zYxDFknmg9EHNVr8Cr
	wF343etjbXwmY9wuApir/+onS/i/gjN0/d0ZSQamEMywTpH2xEgG4VP9BCZ+Ad2pzcBmGJz
	vyNzeCLrheQ3GvUBtL6GIZpvKXif0A16ndVWGaaLqYq79pnXYwXWsmKQEjsl7vS3vYUuhtj
	YZEdeSPgb+LjLlX6YJBzU/LBoHNqcl2bLPLWhSQuArTvrsicR+vlqoVJsvHdIv3IdSq6eek
	TaDC/2MelKeSP0PMmHGCQnDtF8Whitd/8S/8
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

DamosFilter stores memcg_path for sysfs staging, but the constructor
assigns it with a trailing comma and therefore turns it into a tuple.

Fix the assignment so memcg_path is stored as the intended string.
This makes memcg filter staging and follow-up validation use the
written path correctly.

Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 8b12cc048440..43075892215e 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -271,7 +271,7 @@ class DamosFilter:
         self.type_ = type_
         self.matching = matching
         self.allow = allow
-        self.memcg_path = memcg_path,
+        self.memcg_path = memcg_path
         self.addr_start = addr_start
         self.addr_end = addr_end
         self.target_idx = target_idx
-- 
2.51.0

