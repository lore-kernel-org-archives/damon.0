Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D93BCD3F
	for <damon@lists.linux.dev>; Fri, 29 May 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046442; cv=none; b=onUGIL8QAHU2sCv45MRJiLlhVuEqg0LF7chd+vOLw0T+dMIpy/P5mqmfZLSo+dRUkrbRcy1nIh78MrAxYlvUACQpLWvhpa1oAreH1xk5wqkmGe4B/0wRiWDyKQ8k990a+MUNa+18TYGLn+A/sYYAx42tkGHhgG2Hgr3DgnVb/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046442; c=relaxed/simple;
	bh=vklZS+F0UdfrHjMTBGchkgs5NC7WdZIykknOrYnrgD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCValglL6W/1/BqD33h93/He7QT0VTvDmz3mYzUjPjyp6g6c48F/59D7BwGcsHQZoOv9Yqc3rJsaaOIGjRyU5+0/PrNMxSVnzrHO5WF58abl3p4cTHDsMuVd1APCp5ewYz71t6mg4+jUNi+e6DiJeDu5NBF4OWzGgq/P21GusBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oXBNPcL9; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oXBNPcL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780046410;
	bh=pwZkHXqKqxkxLcfcppEkvJjtNsDiBPN5huDHZl9Eqqc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oXBNPcL9l43i+7hjlYwOT9Vzcu9sz183zszbRotKOezN1hoUFJa9r9YVXdtW5p+ai
	 irhp5lFv/99r8V34HAdpw1qvEZBr0xNuofjaW7NVA0Dnpw6g1YXmZdxwFynCgKHTsR
	 VlVcnwI2F+cSqfAKfITK+OmSwv7MyPvzGmUL5dk0=
X-QQ-mid: esmtpsz16t1780046399tb2a1703a
X-QQ-Originating-IP: CJUn/onq9sVAsdQEE4Dgz4kIeQDPJjAROSdjJs85g0k=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 17:19:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8377059717619170860
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
Subject: [PATCH v2 1/2] selftests/damon/_damon_sysfs.py: fix memcg_path assignment
Date: Fri, 29 May 2026 17:19:48 +0800
Message-ID: <9EAB27169F5D0F3D+20260529091948.1702421-1-niecheng1@uniontech.com>
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
X-QQ-XMAILINFO: OMCYmVIWJe6uos5vFmn6Hv3b1VLW0y7mvdHhjV+Aqw2safJnkJceOqCk
	4I0tpRTv5bjYZBZ0J/7EfDLyU/doSnAM6fNBLs5lD+UvveN5+LV7dHP5kZ7sC0JaJMQbSR8
	BcUezDcrK8W0KPMFImStnIAynQ/3XgD+Md3caTKZ69IfUoDSR2YqHXKhCM4a69MmUUH5LQh
	4LVn/TSDjlBkvdJ1X6457D5Hg5WKDrFX9dumxehSZUffMpvfiIjJTKyGC/MY57Dl5wdxICA
	lI/pCX7AwPtCHSE0CjStDl+9Eo/0oS8UFPJbMxYUPElM1wAAt6+pXTleqEySweD3pXtPJyt
	+b9TgHC1QJRha4xdbTWn+GyU9QQsfuCTmuDxlxljnmfcLcFMm8/X34po+jYA7HX9Z7gLClE
	ZRaY82RsQvEgckplIQSMYCsOw1DvHa983i51pGfKTqH7Zu7OTz3L9bRvNHcTDH8DqS7JgX+
	AK+i59hiR0/eSA8lNcWN3vCNSiSNCHHxfhAKJTUmRaqafeHEIGg1qKpdeXVLpOuorj2LVa8
	PRg/gr1P9W0YaKYi/KOIWW9sLE4R6E6xhlYMkjWMMMsBP1rsaw6p89fN6i8HXUyeZHfcnRF
	wSiPMr8yCkJopIX5bGm9WpTwlF1fTJN+ILkQpqrVJdi2Upyf2Sh0eB3C+EG53raG8WApa0M
	6BnL6IFAfxsTYmiIjE9zYw5ZPhRlA01lwnwqJK313E/XDEejCjvLQ52QW6062nM+dWKJN5M
	+iOvqrT3bHmiRbAkRbqb/OSZ9xmXsbZxZN+Hp3ECLDK4h92Ti3Aj68A+xQk9ybM7dQiwAas
	BBzCCXoPl6u2zzsW6VOYiy5hrZiHnK3hNfrbFmuh9mM1uHXwtMsPacDRwCj8LVFbXkUb3nx
	8MlIZM9wWPP/+DGnT1+DXx5o8E0My+Sga6TE1R4HHpsFPKM+m6pV9lCTZSgJZuOOQ1tVOed
	1Y8xMOntoVlnKbVlXVxZ32eCpwNzikHJg0JuQvclFfep9Tvf+Shg+2zoYC1s9+U6tmJSYge
	TBPrcqFwJmw5MJcd6yZ10tKS+nFO5MVhDG55HVg0as9cstELSGrcrr66GbHNk=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

DamosFilter stores memcg_path for sysfs staging, but the constructor
assigns it with a trailing comma and therefore turns it into a tuple.

Fix the assignment so memcg_path is stored as the intended string.
This makes memcg filter staging and follow-up validation use the
written path correctly.

Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
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

