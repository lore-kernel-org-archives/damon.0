Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DE35E1BA
	for <damon@lists.linux.dev>; Thu, 28 May 2026 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955887; cv=none; b=kCt3Nm7clFcUEmGTPNNLdHhhEwEgV586ezcn3lYXyWFMFP2tGp10P7ZPZOMojsWzkv+SoyEkYLwea+a2EVXzxY7k+9pO3m0jlKkSONr18uiTV2B5UO20fcJhy+dv2Vk023PII7mEFdsg+eb0hafNWkLOfyB8h0OVFOO7+3HOlvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955887; c=relaxed/simple;
	bh=ae/NeZ3taNXKKvp9HnJVM1by6LAlTPlw0mB2UHLVhT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzOImGEPj3LFrPJOkErr845zcsZ3/5OrNGD0wyouN6fIqeIPu3PCEm77eZimFCKyWLKMK7kt++mC1H+yODauQDAGgGPskaN96UyAWFSmkSbg9EPyrRG+Hi+xbM2QmiQlbYSPvNgOwVf19RCD4E7uXBYgutEFQk3zZqiGDN7ZIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Vzt2yiV2; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Vzt2yiV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779955861;
	bh=yJmNoPx3oaeA6PqMQ34pEZkGLLkXi0yOR8EY4hpMPHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Vzt2yiV245oaZEy+00DqMKw2DFAUlWyO9X25zJbHDIpHAuDBZ5Cm9nZbNC+OJFQGW
	 LIXGFie37/PztMztdDdD5PxWkwrQtjqx69+VawEYalp7iGHG3xHah0YHISRh/Xra+E
	 JoVRvwaWW0yLiPK0T/b5hwyGRBwE3uLHX2IlCtBQ=
X-QQ-mid: esmtpsz17t1779955849t1d49df90
X-QQ-Originating-IP: nZ4UXvetsIyyKOSyybdUT3u/PhenXD2LCe9anBkoWec=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 May 2026 16:10:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7792598639397190847
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
Subject: [PATCH 1/2] selftests/damon: fix DamosFilter memcg_path assignment
Date: Thu, 28 May 2026 16:10:38 +0800
Message-ID: <9B7A70233DF773F5+20260528081039.1192194-2-niecheng1@uniontech.com>
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
X-QQ-XMAILINFO: MoAHuhB82TZgToQTVHt3NDbioWJedjP1nMSJAQ4NgqlJ9mz/3Pey+t8+
	D+L3CU1X/u7ohkhKnb+ebFv5YD9ix3moFjRKVeeMYce2QDwZRifIaaCUL8vTuJqotW42M+J
	dnl9yHbQBYHXORM2yNtGn6B3222ayVeh2AmOKpHFl2mLpI8fPFAkaAamwBSDV1ovnw55EXl
	Z+7kYv5bDhwRjNEFdLvXpdSm4AImdcjbbvgDlPS0jVzR56Jzmx5RvxcqRjEKrxznKW+ZAvQ
	ZZqnUiUm5Uk8l7OqmziSk4y1On3E7noRsY+y8H/v7qh8O0MImbiTloprMZaR06mVJumxpcW
	JpOiwF+1HOpsGtXNvFtjdStRhbJn63fN1/JiCLJJjJGA0Z7QdsPNrzS2cH2Sp951nkxdjIo
	R2g9tztasbqoqbnxrxPV+0tMBXZqs0mDoVwLIgRVvq239whqLo0RP7fxYx49/kEjk94MOOc
	FFbyOo90LvfQpvTCiHUigr5w79xd8zqwV4j4vzVDY6m4y6g958BspPQNO07C6mSgE2TJ+Or
	/7JhDlqJgrAYLYWeA18EkDLdZdk4EfS/rONH2aKBc694kX/hskXk4yr4kLsqhGKtLFQG6t/
	2wDPzSsc1mAy1vJHv92I8AVmapR+zcm3MBXNxcQgAB+vmMaLjujIZOqrpHRkKcuy4IsDnWO
	QCFlzcKLUpurtXPq14t3T0CGWq0nuH2E404J9y6VDFL3lILdCfK73I1p2ZVtx7By54k0BTM
	M50GAhGT1GCoiWrM1ApHRPZW5OSRjRmQ5E0rg+WTeAJNP4zIkRQ4CvPBkyf1nc4zRu/en+l
	lnIjztkCDB3Hs2O5AUNx86qXfGqvtZY/4+5tvZc7ttC04Jr3IJyvcITfURRDiehEkOdRDYO
	/f/M/rf2PjyQckYSzvsAetHSQjVVG0e3F/JCcnCKJkbkgAnC9pUMgS2FFgzusOMHo7zfsuk
	xRY0T6fAE403UAUU+OfIgzgwPcu7q312+t8mZi0BOnv56bKsUNHD2aehUB6cwPvDh1x21mp
	K18elLMyB6AEbl3zUjLjRibyGq3IqI4GYSf/Vwd3VcZ102yvn8bwuh+QCSZ5BPh5u/OzkJS
	nr8/FtqE0QMp+ttWFhq5ol6ynq4iXbRQTnpuXH+9GAbWaOrhhBN+nfzXPMd85bfrBrZJm7h
	SEl09+yngOt7UHI=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

DamosFilter stores memcg_path for sysfs staging, but the constructor
assigns it with a trailing comma and therefore turns it into a tuple.

Fix the assignment so memcg_path is stored as the intended string.
This makes memcg filter staging and follow-up validation use the
written path correctly.

Signed-off-by: niecheng <niecheng1@uniontech.com>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 2b4df655d9fd..022f0d392204 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -254,7 +254,7 @@ class DamosFilter:
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

