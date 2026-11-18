Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968553;
	b=RLzG8yXGuXJBBayze46AOXpjp8qchEl8F9IJgLleZI0rreHeteYFniYKEeZ9JJaBtVh5
	 H8m/JD8UnonqvZ//lFRTR5Aiv7YtELXSDfA4zIx1nsOeXYi1Ru6gV+0pkMEoXVI/uCXea
	 pm833vH5y4g1S1ynclp3uhmo1v61y/TV2H6J+nKGBO5A1VhKK8x2+O7G5JsvRaDoJQ5iI
	 sBWJyX9F5OOOhA3X30rYAlHQs/JA2E2A2VY9QmbSkuPzPRELcFIuniaAsNGdf3r+HLXZq
	 cJtGXO0U08lt49LThMZjlFH3+zA6kHW6vo+Wo0sASwJ8lQZq9U9Mrdr5mJlKDTBuJMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C57fSdsXcJ5YLRwB6q77RfzZshy+TLbem32PMMf0Xsk=;
	b=ciL3M1IjJIQ8vkWkchEsDBv6+tmVu4sfulf0w30XjoiUeatuCyrOssmb2KeHzeeIOirI
	 9/ie+NRWBnpVtgpOizW2fF4P1+v0DxlPGYgPowV9dO3FHt5dUrFMDNStAH0ch5+7wdyBH
	 tcODuTuX0ES5Opjr9jRGUuWfY5prown9/KixrirDuE6wpagPCXyUOCiBocuRjghxIBdae
	 jt9X1hX0GvshKb8SgOehtCCS7b6B04C0s2ClK6scgeQ2he382O0raZ6TBVzSq3BcU3J9K
	 9VY2wRIK8v3cd5CCs7ATAlAvOCEs4or4JqZY6iedxVQTTvJ8K/orpcKJEdZIOpPKJJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nC++JG67;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE90606A33A;
	Wed, 18 Nov 2026 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nC++JG67
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370691F000CA;
	Wed, 18 Nov 2026 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968553;
	bh=C57fSdsXcJ5YLRwB6q77RfzZshy+TLbem32PMMf0Xsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nC++JG67OvodX7YCUzxqOSda3I2OMlBtEcWKzg6EkbYO4taqtoV30yM/okz8P9qx6
	 /zRNELjF+7E0yvmzugdWui4CaVvvR53mkrmPw6xR4vZRT+8aRp8kgs8eAIZ4kF2XXW
	 yjhomMWrHD0RIY0+PTWN/1SU2RedG++a5Xr+l3MQ5jM8hIiCovsB+v9ONRq9kSNP4M
	 YTlJaZm+LPaT/ef9s44Znv+0AqvOL0Omgb2NRrpN1EV6mV4RjwVDH/HEK+pl5PyeIJ
	 fPKiLswVxKfFbs4I6ua6bQglHs5OnLw4uYHikxy4tk3tiPdLkbIQkagCXUOf+1TdVx
	 85KJIVGicYjcQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 02/27] mm/damon/core: implement data attribute report queue
Date: Tue, 17 Nov 2026 18:21:57 -0800
Message-ID: <20261118022225.100659-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0a056949604f9..0e9c1079fdb22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2334,6 +2334,25 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
@@ -4308,7 +4327,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed)
  */
 bool damon_initialized(void)
 {
-	return damon_region_cache != NULL;
+	return damon_region_cache;
 }
 
 static int __init damon_init(void)
@@ -4319,6 +4338,16 @@ static int __init damon_init(void)
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
