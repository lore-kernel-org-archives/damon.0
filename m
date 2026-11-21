Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294822;
	b=HDo8CF8f0aW0TOJKZO7xg1zFq7L3+yDglEnSRfhu1rMo1RDnf2u0a32KX0BOgGM5g9lP
	 PeZOP+T9Mz2o9utfFfbCY63AjfisJT/D3/+Pj9zpbyXmZjCYhr8CYfY3HD4f0Ru0BNQK6
	 3Yk0KmCGN3hdMP63HQsGqhL1AsvqCnWC6Yk52O1HWMBMBPIOJg8BJq2p1Lkiz6fLjz8v8
	 65m0wOa5XzACf3sFL3VrPLmlp4YKGyLELZ49cSUhThhKcMFwOqSew+Qyt4m5wRJLEOveK
	 UOUstv+CVPQlTFFv8w1ZjguFC+Wig05Rc79/aVWJNTIF3HANfHhftiO1i1J82bduOYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qODSwcOx8drR2fM0wupQ27EAjv8adfz4mjkG8/g/heQ=;
	b=fsJdNf0eRvizjBcDrVFCC6lESfwkIQuWmZYIUwacRNw+WnMoQK1iEALItCnGYp6vFrpu
	 AkFu/8qNgud/c7kbvWDAQ0BQHh9tSStKKfg/Y+2CwwyDtKWeAz5+JtjCzjRBgmdgFVEd3
	 DFvqna4yYrS9CW6gpCv90j9qJT7Zy/Bunqz9Zwf/tHcgReSQUMSLUM62MdjxUTnGJCKgE
	 PuHbSollPQcSHWSimcmf//2Pa2hKoISSTs25mtPRF7hdrg36UhkvsrVLGGYlEZDkozf5u
	 2+YrmZ+nUO7LNQAucYPx5q/t+LMMKfCdyTnXodnz/qvdxSf7iTouPnPLxN1K99Gkzjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aujIHuk6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABD606A339
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aujIHuk6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BA51F000D8;
	Sat, 21 Nov 2026 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294822;
	bh=qODSwcOx8drR2fM0wupQ27EAjv8adfz4mjkG8/g/heQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aujIHuk6lVyURbcrdaYhrf3EnzzJ2w76FvZPXEfe19u2bY8RsIomGM+iK+fHShoLf
	 kl3uhZ+6pvqGcuJP4w17CaThwSD5dkZWProPeRrCkG+FFL29yQAbfEMGxYlYTFicYN
	 Z8SKvLMsR1Ae1zkGRV7UwTdzohceM87UBZd5tciW8+9l3/UnV+yayKF/VZED5n1wV3
	 KFZJ0a7QNu+18ilyC0x1zcJYdYfGoptssJNtdZpjUrcpbLuQgcJu6My4NJ6wn8DNyO
	 bz+C/I5F/3KNpl4UEIogWlMyYnNOU8gGU1i1iU4eXiRtaCASpVhjtyU+un0XiOqBuL
	 2pAK7ayF1E3EA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 02/27] mm/damon/core: implement data attribute report queue
Date: Sat, 21 Nov 2026 12:59:46 -0800
Message-ID: <20261121210013.130397-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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
index 986404b547ebd..b51741bb60e26 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2333,6 +2333,25 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
@@ -4307,7 +4326,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed)
  */
 bool damon_initialized(void)
 {
-	return damon_region_cache != NULL;
+	return damon_region_cache;
 }
 
 static int __init damon_init(void)
@@ -4318,6 +4337,16 @@ static int __init damon_init(void)
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
