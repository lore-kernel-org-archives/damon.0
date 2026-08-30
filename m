Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311022DE709
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066865; cv=none; b=hx5xkETQ2++5qsvDo11arsDPifhFXTgCEY05rsrAglQB79+My1Lb1P1WBsYhSCvz7XLP42DNamBCW5eSkbtyyep4dk3L+DrON/th3qgakX4anXmAhYOVBHa4jcOeveSy3I4F50LGxhawYapLKfpNEn+aXcaJ7/fMgCbFXGsdlo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066865; c=relaxed/simple;
	bh=r0ftD7HCIBo2WTmrRLgxokYhFEMjbae70/mAgw1rVsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh5cxVUlUElmoafWnwhDrmuUmOjQ9lV6QkRrP0uLnTtwUkFO0vrCByt5dlDl9d20IX17smGa+iZJrKPYvJ75Yz8wgfFr+18Ak4TZS8FTM4Tnn3AeswKyV76unuoQ+lclpmdM6TkDHLSq7jlL98X0oo80HWdrklTbMvS3awnxn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai; spf=pass smtp.mailfrom=crusoe.ai; dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b=ZpG+tBVH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.b="ZpG+tBVH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39682983a0fso2932383a91.3
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788066855; x=1788671655; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4psP7AFDz+Kluf5IGgOzZSSfstXE1tXapxgbnPUwWEA=;
        b=ZpG+tBVHBSAfmM91wkNB4owRWPAgA4JdipMHOJ3RwGm4p7KlaNXVWXk6F1wRJxFV8q
         BtVNuyr8WYKYGqBg6iEZgH6JEutYHYbP23pXms+lm+NKTViEUa9/ycOjkuF2uqi4viow
         kDy5savOYLQoA7feLSY4fbxkGWPFEak075jZ3pdTpgoLovK6hn7oNEiUlHEdVsz/QwSi
         Hzu8wnOjcxzC/yvPlj8RlFgpRyZowk5hAFAk/S/kS0mjcxRaVEhKa/MomBXCRrAHUSyV
         5lq3W6dmE03RnufmzQ4wgCPY0kkZCsv2jOIGf55IHSxZHce0ZLa+vTs3t+WBO2Fdq/n+
         JhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066855; x=1788671655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4psP7AFDz+Kluf5IGgOzZSSfstXE1tXapxgbnPUwWEA=;
        b=Ru8e8bCv8/SWubmJoJEBdPr/WfJ4+yNQU8sV1DyE/TJ/yUBJ2qi8B7A71UYpwfZrLR
         wJofs/XaAJtOeAMtNHY2BOfGxaFRwHDiY1QEHEj4Wtft49W2mjWyW1BeRZqficjcvfx4
         LVk8fbNyB7t3XdFYOHUlGGHUAVHMUgUyiEMLeQjlha+TknlkKDKPmWtiZ6pidDTQo31g
         AUJfvyLMlb9bs6agnZnlc0iXqeT63D8WLXmu/+wxBmfxV1vbNkG4zZghLA/hWtWh5TR5
         diJQkNFJkvBz6YmfI1/HATbBrKxO8vPaVzrKQOZ3qkyvFobJEzV6mOxuuKVex46Y1R2C
         sOkA==
X-Forwarded-Encrypted: i=1; AKwUvBwRsAXoUyS7O4ElUlclUUsS54peMPlZ//jStKSk0ZtShv3jCS1lUZYurueSPCwDKVH6WN9whQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lwtoSRhVTUlnqi7ojUxSClV/J+S9zOVJe83qila+tUTXl/PZ2o
	9QOG5L3gOlJMVSpktMwdKHVsuUc2grI6YWqyLim1Vbsl+HZji1v4Xdb8kbwmJrciatY=
X-Gm-Gg: AYBFou29ZHJsHs+Npgze9aKHI+1ZK2xqAD9jBKyJcn/fgx8MhMFdjAkZvPOtmU3HkMs
	Tj18dUcUCPgBgYPK1hIozcpklzosUyGfblYF8Z5K7exptqkvAmRF63Tt25q0qs6DgnL9g5GKw/w
	fYY5Xdwo8B8xzJ2ajAGlg+di4HJiEGvIoLU4tGX+3w8GWic5krH7AjP/gOZYxQOuLWx+424682L
	TAWLjukig7uourCkPpOx96vbSwPoJisBXDrtqGXA675soIa1Me4kFvYHGa+44MOOoWkYjQcKDwC
	t3aBWxjYGvOTYqXVpzjwd+nZczuCdNKgg1P86Txs80r50Imkk8+gV/g6yHJGV3toRQd2rofWJRR
	UU2kgNsXhnob763Je6TXFqxJfo3eJM6MeNbTPqVdmKTBLgxlswBO1ExE1SA4U+U6n7t6RjKPFPc
	LlAfTg6xAJFWAkdAiQ9r5YnXOmWXIiO2aVSIImMcK0jMquBTIPo6i2FgUVpueqpl8Z3BdFaaAuH
	SUoi0gRW5pt7bK9SyLd19wzXQt/A0liv3Hh
X-Received: by 2002:a17:90b:2e4f:b0:398:9bd5:490e with SMTP id 98e67ed59e1d1-3989bd54c43mr16185087a91.21.1788066855436;
        Sat, 29 Aug 2026 22:14:15 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:d101:1d:112c:715e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm22595810eec.29.2026.08.29.22.14.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 22:14:15 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH 6/6] mm/damon/stat: support aging_flush
Date: Sat, 29 Aug 2026 22:14:07 -0700
Message-ID: <20260830051407.50008-7-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260830051407.50008-1-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let DAMON_STAT users opt in to flush-assisted access bit clearing via a
module parameter of the same name as the monitoring context option.
The parameter is applied when the monitoring context is built, i.e., at
enable time.  Defaults to off (current behavior).

Intended for virtualization hosts backing guest memory with hugetlb
pages, where non-flushing aging pins the observed access rate to the
TLB-refill rate (see the aging_flush core patch for details).  Such
deployments can set damon_stat.aging_flush=1 on the kernel command
line.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 mm/damon/stat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b05b68f73e10..e093383ba406 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -47,6 +47,11 @@ module_param(aggr_interval_us, ulong, 0400);
 MODULE_PARM_DESC(aggr_interval_us,
 		"Current tuned aggregation interval in microseconds");
 
+static bool aging_flush __read_mostly;
+module_param(aging_flush, bool, 0600);
+MODULE_PARM_DESC(aging_flush,
+		"Flush TLBs when clearing access bits (applied at enable time)");
+
 static struct damon_ctx *damon_stat_context;
 
 static unsigned long damon_stat_last_refresh_jiffies;
@@ -178,6 +183,7 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 
 	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
 		goto free_out;
+	ctx->aging_flush = aging_flush;
 
 	target = damon_new_target();
 	if (!target)
-- 
2.54.0

