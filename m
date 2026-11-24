Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534606;
	b=Rb6+mS0GGDbVWt0Oc+XTexEeq3Cbfm5NCC6ziLn6JDTkZSzc9CeKvWC2STN3PiIQMnkj
	 k0Q+zC/B6M/VLf088OtfP20IB4vjv7VY4HoRT/SJtfQvAdcmdG9j4SQtFYvesta8XGjpW
	 WLb/w1Nmma5pRZtH/ekr11YlSZkxcAg5YrtK67dxj9zZOw0f74c2COraAn5A79T0uxU1i
	 8i5uaF6qOKTQ5OsIPiy2GrhduqlmsVt7bu1OFNiTU9VdvHNvgwfbhbCSgk/5ooiXNRiYH
	 lepb38KoVhcBQlaAeFS9Eje41WMvBZxjStOQUp5pmW0eMdnk1pmKzZlc0Ih2c4Z4j8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N++E4pV8FIbWrmNbMjepL9j7Rj9OozUVn9hIC9L/F8Y=;
	b=3tz09B/C0DQm8iEXw+6ZqkHeyFvhwsxij57sM6C48PYvW+X9bToLGxQ6jhm9bYuY0rFz
	 OwD2FZRpFMKePDJapZKVWditsh7Jid20rvtZGzBAqVzbAZhEwhDj+U6J+nApNoZZf5H8Z
	 AH0YXoLLIhLVIVebXhdv6l1pl1DxY1tDz7QDg/Iof7BqKe/ghLvgn2GkJTXE1vUZYG1GF
	 8jhoz9wDkYy0swUn3LjzgpTEmNbROReGeVxsXjuG9bB34ww+5WsHCBRIr1xFAWcYe3h1x
	 W8dMtz44q8ED+7uS6KdBTN6FX8EwbUqjM22KmllZwfwu5pFXU3WeIdwBMIGsMvyhs+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SioBXk9L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C8606A321
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SioBXk9L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851981F000C6;
	Tue, 24 Nov 2026 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534605;
	bh=N++E4pV8FIbWrmNbMjepL9j7Rj9OozUVn9hIC9L/F8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SioBXk9LXlV+XCXAbx3ceUUcS73AYNwgUvJHDFU7vTJoowaZ1FNkoiqXmaPFhAsOr
	 5XJj8tZQGGmqbrqxsSdidwxd3yAXuLZf6JRbRLKLfzxbMEKBp/mALVjP4oN9NyUmyR
	 NcGqzFTUzutQj62MRcA82GYJvTP05H6zpExrbk5MZRz5ogn44xlR+S4OetSgnIdRVu
	 GBMhAmFtrdZA9IKNBuyHyv4VZ7dqtuPBdUDqtedUPi5bmz9EbsV6+WT8aKRc8Q+EqT
	 xTDenoY/s0T7peXAOtfY0jtSqyophi3KyEaEYbKrToyLFrJ6y6LdqzZJKEY3/PKHmP
	 qkDaO/HQzyiyQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 02/27] mm/damon/core: implement data attribute report queue
Date: Tue, 24 Nov 2026 07:36:08 -0800
Message-ID: <20261124153636.91854-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Implement DAMON core internal data structure for queuing received
data attribute reports.  Initialize the queue for up to 1,000 reports,
inside the DAMON init routine.  Destroy damon_region_cache and reset the
pointer for the queue setup failures.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 649a4ac968abf..8293b69169856 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2337,6 +2337,25 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
+/*
+ * struct damon_report_queue - &struct damon_report queue.
+ *
+ * @lock:	Represent if this queue is being used by someone.
+ * @tail:	Tail of the queue.
+ * @size:	Size of the queue.
+ * @nr_reports:	Number of reports stored in the queue.
+ * @reports:	Array of &struct damon_report.
+ */
+struct damon_report_queue {
+	atomic_t lock;
+	unsigned int tail;
+	unsigned int size;
+	unsigned int nr_reports;
+	struct damon_report *reports;
+};
+
+static struct damon_report_queue damon_report_queue;
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -4323,7 +4342,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed)
  */
 bool damon_initialized(void)
 {
-	return damon_region_cache != NULL;
+	return damon_region_cache;
 }
 
 static int __init damon_init(void)
@@ -4334,6 +4353,16 @@ static int __init damon_init(void)
 		return -ENOMEM;
 	}
 
+	damon_report_queue.size = 1000;
+	damon_report_queue.reports = kmalloc_objs(*damon_report_queue.reports,
+			1000, GFP_KERNEL);
+	if (!damon_report_queue.reports) {
+		pr_err("report queue alloc fail\n");
+		kmem_cache_destroy(damon_region_cache);
+		damon_region_cache = NULL;
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
-- 
2.47.3
