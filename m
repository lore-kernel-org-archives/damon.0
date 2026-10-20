Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503196;
	b=D15F5Y0l9FquMQDS3QBp7d1BOWIyfFFfmZvYMpzFJaT8GvetzmMx5d97Qq4Hg6pd/zfh
	 8QK0az8TFGqiFbdoirRSsXrd8KAXY4eY3/KzZRpfieskoEW8gnnse3erzM9+Kdv2wd+SZ
	 qfYUVQisTKxWuQj4QwzcypdRP8VXj70mJo/43B07TayVPESvlehBleKYKF13sZoJ1NqM6
	 o+V62nxKHNDRmRrqZxHk2yRozHGi6Iz+CFZimi9UcgE7syrV2+Ex9Tp/wP2aH9Kj6anb5
	 b8WWLL1X6yd3elOQXPOxkEGvxjhBTWgzgDw3kjx/BN1DXzm3smz55s9zgzWxGvpNwhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503196;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=CGrzPuac4BCqviRdihOooPny/4+gPoANGJ4ge/fXpto=;
	b=HWVeOX1PWg31e45TVTSgBWmrgwjxKezj6DkuKtGwe2RkbdjJvAqTy3tCvWKsN3EW09Lv
	 rl7d/LKhGxndw5xpdlfFxvsgSrBNDZiRj43/zRZ3sxREkVcLzA5RCvkJtrgqt35i83aO4
	 la15vdj11jBN8M02wBkuRQ3prDfHQhCfqvVe0kiSRXUHlW2elgwenGpaFSLIk9b2VNxMS
	 dvghduEGTa3w1rBxtCH8lT9ZxlOup7tS8+vJmjNSYzjQT10UcaQZFGrw6r0aFr2LsQ+X8
	 poSa7xIQHua1Umr82pgvCXj4DhFxSmExUqeySp84eB92kIwD3GwZ5CfKWstOAucKZVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SYMhujjY;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186F606A327
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 13:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2186F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SYMhujjY
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CGrzPuac4BCqviRdihOooPny/4+gPoANGJ4ge/fXpto=;
	b=SYMhujjYXT7SQgfydoLP1stjj1ocdmWvEW6oVNA6z65TUczBhtqvsIDYw6fnaZFmNwq9YVzzR
	pI5s3Ne8X+PS8UJeMYG3QinHxAbWXPYlAKfX+wZL87XDZaI3OEQ7SjPbNVItz1TAozqQJFB5ReY
	rWrEEmbxVFBDIFYaonvC56U=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j8Cz11mS6z1prKf;
	Tue, 20 Oct 2026 21:33:01 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A9A684056D;
	Tue, 20 Oct 2026 21:33:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 21:33:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH] mm/damon/reclaim: allow disabling watermarks to force reclaim of cold pages
Date: Tue, 20 Oct 2026 21:32:33 +0800
Message-ID: <20261020133233.3920818-1-ruanjinjie@huawei.com>
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

DAMON_RECLAIM runs its scheme only while the free memory rate is in
[wmarks_low, wmarks_mid].  Reclaiming cold pages raises the rate, so the
scheme self-stops as soon as memory looks plentiful again, which is wrong
for a VMM parking an idle sandbox that wants cold anonymous pages
reclaimed immediately.

So add an ignore_wmarks module parameter. When set, the scheme uses
DAMOS_WMARK_NONE, so damos_wmark_wait_us() always returns zero and the
scheme stays active, bounded only by min_age and the quota.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 .../admin-guide/mm/damon/reclaim.rst          | 17 ++++++++++++++++
 mm/damon/reclaim.c                            | 20 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index ec7e3e32b4ac..ef57f60a9105 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -159,6 +159,23 @@ this auto-tuning feature.
 
 Disabled by default.
 
+ignore_wmarks
+-------------
+
+Ignore the watermarks-based scheme activation condition.
+
+If set to ``Y``, DAMON_RECLAIM runs its scheme regardless of the system's
+free memory rate, so the reclaim is bounded only by ``min_age`` and the
+quota.  This is useful when cold pages should be reclaimed even while the
+system still has free memory, e.g. to squeeze the cold anonymous pages of a
+just-parked virtual machine out immediately.
+
+By default, ``N``, so the scheme is activated based on the system's free
+memory rate, as described for the watermarks below.
+
+Changes take effect when the scheme is rebuilt, i.e. on the next ``enabled``
+``0 -> 1`` transition, like the other DAMON_RECLAIM parameters.
+
 wmarks_interval
 ---------------
 
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 45d5557cc575..03b9a57694a6 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -112,6 +112,23 @@ static struct damos_watermarks damon_reclaim_wmarks = {
 };
 DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_reclaim_wmarks);
 
+/*
+ * Ignore the watermarks-based scheme activation condition.
+ *
+ * With the default ``N``, DAMON_RECLAIM runs its scheme only while the
+ * system's free memory rate is inside [wmarks_low, wmarks_mid].
+ * Reclaiming cold pages itself raises the free rate, so the scheme
+ * deactivates as soon as memory looks plentiful again.  For a VMM parking
+ * an idle sandbox, cold anonymous pages should be reclaimed immediately
+ * even while the host still has plenty of free memory; setting this ``Y``
+ * makes the scheme ignore the watermarks, so the reclaim is bounded only
+ * by min_age and the quota.
+ */
+static bool ignore_wmarks __read_mostly;
+module_param(ignore_wmarks, bool, 0600);
+MODULE_PARM_DESC(ignore_wmarks,
+	"Ignore watermarks: reclaim cold pages even while free memory is plentiful (default: false)");
+
 static struct damon_attrs damon_reclaim_mon_attrs = {
 	.sample_interval = 5000,	/* 5 ms */
 	.aggr_interval = 100000,	/* 100 ms */
@@ -226,6 +243,9 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		goto out;
 
+	damon_reclaim_wmarks.metric = ignore_wmarks ?
+			DAMOS_WMARK_NONE : DAMOS_WMARK_FREE_MEM_RATE;
+
 	err = -ENOMEM;
 	scheme = damon_reclaim_new_scheme(attrs.aggr_interval);
 	if (!scheme)
-- 
2.53.0

