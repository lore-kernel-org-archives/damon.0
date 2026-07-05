Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7D2BEFFD;
	Sun,  5 Jul 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267317; cv=none; b=PjlXiGlWUQOPFdtGsIL5bwiwN24vZpMpwwNC5CAXySCn6CvKcTyIVXA1F8E5pKhLl28hrD2Xb6PfbHsbaqteyot7jjL7frrD4XM0QiqWDpohfr2HdBctz75ab6MLB+v954exotxDkF7NITYCubzii7tZyG4Czc0ihOiCb670xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267317; c=relaxed/simple;
	bh=HJQcidpUpSoaFDrjW7LdUf/3O9Ylf2kc/fs9bqgKr3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B10KApQYblu//3wSRlvI/S3tWIRnF2Pz2tmrEgMJ5TH1I5IgwhKQgcZB5dvvvp5+Q/O3TOtRZJjWLPIRf4aXjNKIVDajfLTV6KgYV8nW79nL15oXA1fDnrXpPrEp44Ur2zPsaAg8kIkkbQCQR9jm8OKZoIXW9FQWr52fDXEgga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW3jYsUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW3jYsUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3F41F00A3D;
	Sun,  5 Jul 2026 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267315;
	bh=d/v/dE+FlmtwJgj5yRteS0MOxCozSQuxW5M8Uj1RzSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TW3jYsUnmaIGxOT+B9VeJzZobrosiaK2eLvMXlwywcCygVzqc/gMMSTKxzwIN3ap/
	 oRVVZEPnGJNJX8fHf2cRL2F6Sz5vqP/6NycQonk3kUS/iAIoqvQcdr3M9x1eBsiWLZ
	 ORVfD85j2H0NKv1K4oc6wh0B55C3ZUQleqEfKNUZT1cT9eyiio9GgyAhOwvtddVJjb
	 PFc8eGzR/nWVr0LhGbLSU8tD7rZM/8fL4ICAwF4PbHZxL6a0eTB2M8m1ZooaGqus1e
	 x6Kh8IdkjnLbM9H7leZGgG7VTetv/iRNyF5TMceYsn2PayU0AQJaU4+o92rAx8Wpo7
	 50V3wD0vaod2A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 11/11] samples/damon/prcl: do not stop DAMON for damon_call() failure
Date: Sun,  5 Jul 2026 09:01:38 -0700
Message-ID: <20260705160142.97308-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() failure was causing the context to be stopped, but
asynchronously by the kdamond thread.  To handle the race,   the caller
had to stop the context.  damon_call() is updated to do the stop on its
own.  Remove the damon_stop() call from the damon_call() error handling.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/prcl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index edeae145c4a8a..842099bd62286 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -113,10 +113,8 @@ static int damon_sample_prcl_start(void)
 
 	repeat_call_control.data = ctx;
 	err = damon_call(ctx, &repeat_call_control);
-	if (err) {
-		damon_stop(&ctx, 1);
+	if (err)
 		damon_destroy_ctx(ctx);
-	}
 	return err;
 }
 
-- 
2.47.3
