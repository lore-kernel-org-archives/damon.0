Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155019;
	b=NbG4Xxq80M7d2HH0W2Hoo5oGGGjgxjmRhXtB3GrVZjX4jp/cLjGUcHq/BZgvs2t5SMNo
	 zxkLVQTZlynMid8OF8A7WJCcFjQK1tggxMVoVEMlz5JRdBnpulZlDv32vSeBim9HIOZQJ
	 nUJ6DeAG5cLQP21vZfoFN3vuO/63tcVK4Nwkdvfm+F41MYBuHGD0+KBC2KC9yfCU5jlC2
	 in722x2+pBV/q5Bz/UYXm0blHps4XeT5xGVUKjChv4ZPsE6E1EyS/7FLiK6Pm2VQEw5IM
	 9Vnf8ff4LawsT6aOg2sLtL4sXrs0vz/NMRF3RRopxwh0G17oIT+LsP0/4V2UzJZA54Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155019;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=D3jriHWWTJBoIKf4eSRYhB262kHqi+/i8ZptpC+x1wo=;
	b=0aHUxRZEclXhvURUeObxyIOWDS8OvVjknQL3snCHWiwWQkevGhrQIEaW54y7DQGVSz85
	 m3R57mlbcfxl27FOwHIG5FT77hYLl/bODVZJSDeSVZkVFwJmiwKRi4zkAvIodTcf7iNZl
	 xYztuA1AEPLSguK8zYeZ6LHCu7VMRu8v61fnBt65mCCzw5LgdhpUBfvbJAzRLVYQiI7JQ
	 tKm1f/KPqmuNyuSyLuTrWa75YiPysWcKiH+1efPlNWzRrtrVJ3AQ+zdLaa44hjxvcdM5m
	 aGnZ4FSP0+NllxIp8P88Wuv18sVm6EG4KtixuOt90pBPQsDrs0M/3V1hSmuswxtIhbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1TqRhmzC;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF603606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 02:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF603606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1TqRhmzC
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=D3jriHWWTJBoIKf4eSRYhB262kHqi+/i8ZptpC+x1wo=;
	b=1TqRhmzCLRMWQJRBcT0arpnkxWoLiE1ZEMrxdfGvEL4o8+7xFtf//Lbqqsl0t0BwcGOholHuK
	CD27pe6zL3M+uJw78If21G68tCgNmo9XT47Jzsoc9jH5X+3iEDS3+idkG5wmydcWVEsCcoriN6z
	OCtacQJf5lbKL3oGytcO8d0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jDs2M1H0fz12LCy;
	Wed, 28 Oct 2026 10:36:59 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2572F40579;
	Wed, 28 Oct 2026 10:36:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 28 Oct
 2026 10:36:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sj@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] Docs/admin-guide/mm/damon/reclaim: document how to disable watermarks
Date: Wed, 28 Oct 2026 10:36:28 +0800
Message-ID: <20261028023628.795637-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200008.china.huawei.com (7.202.194.74)

DAMON_RECLAIM runs its scheme only while the free memory rate is
between `wmarks_low` and `wmarks_mid`.

But some users want to reclaim cold pages even while the system has
plenty of free memory, and it is not obvious that the existing
watermarks parameters can already do that. So Document the setup.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index ec7e3e32b4ac..23fede7d1cdb 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -193,6 +193,13 @@ DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks the
 watermarks.  In the case, the system falls back to the LRU-list based page
 granularity reclamation logic.
 
+To keep DAMON_RECLAIM always active regardless of the free memory rate, set
+``wmarks_high``, ``wmarks_mid`` and ``wmarks_low`` to ``1000``, ``1000`` and
+``0``, respectively.  Then the reclamation is limited only by ``min_age`` and
+the quotas.  This is useful for reclaiming cold pages even while the system
+has plenty of free memory, e.g., right after an idle virtual machine is
+paused.
+
 sample_interval
 ---------------
 
-- 
2.53.0

