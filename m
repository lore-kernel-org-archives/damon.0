Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A80237713
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304751; cv=none; b=tAqn2vRmrL6K4HOU4Ep3DbIwqNdioM7XFDdWFUlTv2vFuc5QeIYdNpzTTwSLm/mNKT45+k8WJgt06pNvT32hG5umbIsZH7spovHe0MnoDnu3/Su/8agZSZN0Nd6WsrC5aGANiddtAE2aC6DIHOLmHla5ldIaatH7+gvNPufC+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304751; c=relaxed/simple;
	bh=0aE6h/5Gor35FT0+47VDSaRxZdUotrOoDslgItJm8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwTxuMIzXulWItjYA+h4gD732qAo7ONNiY8DsnnqmZMgpW9PmAQQacaaZBc7GwGMFP1VCZe5PGpitDzD1UUntgAHGPIVcSY364oq5RPM+qtzUxA+BHIxB6PfjkjDTTSD/ahbqk3q9AH13u9+hAMPUv8ra0l7YT+WIdnL/rxF/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=AemEIS1f; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="AemEIS1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780304732;
	bh=ea62rNturdRY4XhPqvTtukJW98iV/DZwMOLJ/F5D8vs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AemEIS1fhNRLY0jn7BjS7V9hm6q/gb1WBHf/aYfDQS66JWDk8dYi16bhDeRgalvR8
	 lkVvGz5xcPXqODKv5n/0RlAAAIjHbm9K3XAQ6BSqMlc1KEqctiJx1oy1B4o7ZHkpu7
	 VvXMW4I6cYQg4rgFy6qAG3JdWRUvYbek5iTB6cX4=
X-QQ-mid: zesmtpgz8t1780304727t4a62472c
X-QQ-Originating-IP: 2bcxmMbH2iusCaR5Nzg0f+ovlfhyFWqjrzOOczmEX18=
Received: from PEN1097 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 17:05:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 41246512580462291
EX-QQ-RecipientCnt: 7
From: Cheng Nie <niecheng1@uniontech.com>
To: niecheng1@uniontech.com
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org,
	sj@kernel.org
Subject: [PATCH v4 1/2] selftests/damon/_damon_sysfs.py: fix memcg_path assignment
Date: Mon,  1 Jun 2026 17:05:19 +0800
Message-ID: <464AE12D4BC6B6F4+20260601090519.240482-1-niecheng1@uniontech.com>
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
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OfLzXF8J7RicL/ZU5lX6H/24XsvdkJHW89YHSaoLnS0I9im0Y0dG2Z9j
	EA4sHOksION396oefkjL7N3ihF+xbBnzd9hGoHKefggKJujqurYZvQEKibLLtt3yzvZqXJS
	q5K8kThs6+M5G8+u2y+d8P+J3ZHc3NM8I9R0AsQlCtqDKzLXQVGDk3y0e7DuhjBFwlYmSpZ
	FN6Fx/2HTMKaV+Cgn1zzUCDo13uKxlBM6zWeVaiIczE8i9Ynuhjl6Azb+n6tcRXMmRhtID0
	0TrEZXZRrKlI4cWZlyM3IZmpt9+hQwbOg3C+Z8euefWAh5I+4iECq93x3iBZlPkMThcSDPb
	Dq/qCj6UD3Y7sc3mOlSBSqMVe3tgLDdsUNsN5mXSjB8j76F/rgjLljhQSs+Lcv7qrGfJRQd
	HsPIxMwtGfkGs+V6MnTcpsmCng2PrSKf90h0RGTIYxuSzMmlyhPKnkB357pw5YGCRgJIXi5
	yfPerX5KzEydoboaqFt2DP/NDwgE9NYgsSwf17yHr8rXGJCNr+CLLCQjf6cCmVSiKbZjt3P
	GGspFhhr2L4+BmV7MkeMrpZCoVH58FtWxjKwC4taAjPJJCiqe1Qi554mjQbvMkEjj/1xLgG
	X4TdpD6+ueK4vpMAF0eiG0O5mVX7rA0HPPYUkh8z5ToO+DkfqY75KRFaRd8mIBZwcES4b9J
	0g8tpqUxZvapoEWoteFa+myMgpB6B4ZaWFOVccOMyS/FPnMFge2IjL3uWZUZmj9Mj9dsFoK
	0gpmyUmqwkcnu3jgU6T/zkhnkgI3nGBCGr1aFLDZlDwQVo79WG2iBkzWRQTAIb8QDDse2sC
	x2oYO5lXQ6vowMjZFOdG9LB/g4OMIHxHA92CIzcwaNpp0u7b3pBMLIXJTBoeae8uiGZESUY
	Z69YePUo2HduZMp5+IbDTB/3ayboLzJ+XXKm2A17v8+IdzqF+7sI/YhRzkDJwk0ppM9Gd9E
	mN6jAaNyH0rvpnkzGxdtqr3EMYdeNc6HzU8PqYiwSfQIOQq1RXrzKxnBOay8aVaF2L4NLh8
	LbGA4oOajEjLomJiAfdfqEfXJRa571zhzkutV42N2T6H0/fb5izQSY5aNrHUxSXN05xYvXp
	HGuRzo67OubF4tpYPXL2OTJK1uBkAvxV2QGslHFW9NQFW0TkNgNBSVmQAgOQO1ccQ==
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

