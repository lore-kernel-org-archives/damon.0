Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774543;
	b=Nvn/9/Pvt0dLqGrks9r1bm49W0LxnEom0MdqLKHgxbg12TAjbcoPV3wuFqu+yMfIlLDO
	 iom9i/aGLSnkS7Fg/M4jo1mKb8b1qx1yY8rj2/UX+gsMSlodq+WL5nJNplh0W+Q4aMdsI
	 k7hZbeXt216Z9IGSiUTWEtYJOYDHHoN1f2Re5Y8WfDD9szgHlSbxHfSDU5c0C5Qxqaa1y
	 g/kdub7R97Kwx5bsC1i5/NlG/Z/7VtVwYFtgMLjM65X0q9WT3OBixv3sKTgdINYBbikbp
	 qcjiEE/MEm4rrVPCxjYRHpRHAoUvTW0J4CMcWRZifoJ+6EvKtU+Ymj4dM/2gB5GRkww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o+HeOpjq54P3hj4CFI7ndeEkKRYx17STvhME5Gvi2/U=;
	b=m3K7HRL8t2OtxmlEY1m/C+3I5nOam+ZQjiiKzupesOFcyYS3WtiOcTbAxlaHhlllHG4A
	 M0i6wJXxAi4wLPyv+qBa3RSvoMtoJKrkXsxjfXXnKRoyHmVHJpLDeKa4xw1EmcjmleTcz
	 L5ce70LjZhu5UkSr42SDuhXStXaFOxjjgpjgdGDFhfErp4r6Ucha8UNIn7A5NAXvFKs53
	 5Q5uUdelJy/rFzPA4+UZVwYTk5co/PSN37Us3mWoC/tlgFGQLq2NoDyDfOndf274iH57I
	 EmAGPo7ngclyudoEA6grHkGAoRfVAuCGJLLy1bHoE5v53j0L+PDNgbSe9yKhXC447TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYzPGt9Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3F606A881;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYzPGt9Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1101F000C4;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774543;
	bh=o+HeOpjq54P3hj4CFI7ndeEkKRYx17STvhME5Gvi2/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DYzPGt9Qw+hksAwG4ufwgBQdWrM0ei+25CDBW8kAArPZWpPFIKezf6X4cTCdl8FZN
	 Ss8cAAgj4NOgTFpLzUJfqHfjk56++PYMiHPwD7b5EPI3ddXZzBc+FNIwFmPthnnp50
	 fEpqUSSQmyjbntPSQzgJ5J0X19YYkdM1bR3OGdRPjhouOLrvrJruFMjk5AAbmFDF6a
	 yki3C34upd5J2Wz/3E+yQ9m3PdJ68RnL+4QyXmIl+/f5Fs8i3pGnlQU8pal6cVPEkL
	 rvqLN+U55WTDmaInrdGfVcC+kFa3z2XW7OrDjfvnXLADLN01Mm90cvtvjXZt7xbIv6
	 sGkdrwcEHBa9g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/27] mm/damon/core: implement data attribute report queue
Date: Sun, 15 Nov 2026 12:28:20 -0800
Message-ID: <20261115202849.99134-3-sj@kernel.org>
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

Implement DAMON core internal data structure for queuing received
data attribute reports.  Initialize the queue for up to 1,000 reports,
inside the DAMON init routine.  Also update damon_initialized() to
return false for the setup failure of the queue.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0a056949604f9..3f87a7eec442e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2334,6 +2334,25 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
+/*
+ * struct damon_report_queue - &struct damon_report queue.
+ *
+ * @lock:	Represent if this queue is being used by someone.
+ * @head:	Head of the queue.
+ * @tail:	Tail of the queue.
+ * @size:	Size of the queue.
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
+struct damon_report_queue damon_report_queue;
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -4308,7 +4327,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed)
  */
 bool damon_initialized(void)
 {
-	return damon_region_cache != NULL;
+	return damon_region_cache && damon_report_queue.reports;
 }
 
 static int __init damon_init(void)
@@ -4319,6 +4338,14 @@ static int __init damon_init(void)
 		return -ENOMEM;
 	}
 
+	damon_report_queue.size = 1000;
+	damon_report_queue.reports = kmalloc_objs(*damon_report_queue.reports,
+			1000, GFP_KERNEL);
+	if (!damon_report_queue.reports) {
+		pr_err("report queue alloc fail\n");
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
-- 
2.47.3
