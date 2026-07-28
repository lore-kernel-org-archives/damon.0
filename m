Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D23B27EE;
	Tue, 28 Jul 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216498; cv=none; b=F3rt4qrhJvQUkfsnD7rnfcVaseIpylIDr7bu3ylZhGMmFN9ov2aJ7Vu1uXwOouqsXVySIG2vh0mhHf1/IpYSqO/gJazdsEp388QJyGpXfVixNIg4x8c+EFAfW7UGXbn1NHIGg30WdwS857KtqIA1TIXLRKQWLPT0sRQUFr0/t5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216498; c=relaxed/simple;
	bh=1t05AbHVrLXlFhP/qpvUei8pI3XpwUaMplCyDmx/dgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwqFHB2I2BTeX0mSo1qr3jpAk9zDUuvkF1x16A0cT5SzxfMhWekvaM6UVAeLit/DTM9Qwc1Et9ueQ/b6Ir45y+lkJNHFkQ2V63oZBdz1q0N22mr3eRaeuT9ADwC9Ug7fOBdhHDrBMCTBeuJaAui7MoUvJgKwrKdvRJrV8OIerrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7X2J0Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7X2J0Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D851F00AC4;
	Tue, 28 Jul 2026 05:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216496;
	bh=aBR1l4Zj0+i023n+HnH64fP1p7WsoVeRpc+Aylgoc74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C7X2J0DhOnfEw52l3ItT+sy4tCQecZ9jUNbSz0uS4JvDnbZejgQ/f8BOcMp3iknJL
	 vOrIozcx+8laxAA0T4YfLbWeFzShipAWwlRNlnZDBKdNElGulHXSBQHTWqReXuCAy6
	 bGxgVviE/FagYfD/3Vu3lBf/S/KBNId2i6qNMG9PtWTxOW4GBtIFOoNP83EyADrcpS
	 hgqRuJE08yp1hOY6Pm2yLk8mQUQxi7e43SxPxSL9Se/4vYkCMHqmb532Dee0ukuRQd
	 DvLd1cCb3iPjPDcmshF0bRtp9GOawv/n0sXJpOAHx4gwlSSivqVr50os00C6Q/d7rc
	 Hvc97VpO4unGA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/10] mm/damon/vaddr: remove a debug message
Date: Mon, 27 Jul 2026 22:28:02 -0700
Message-ID: <20260728052811.192712-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a debug message in the DAMON virtual address space operation
set.  It has not really been used in a meaningful way for the last few
years, though.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0648400b2d65b..95899b217b2af 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -192,19 +192,10 @@ static int damon_va_three_regions(struct damon_target *t,
 static void __damon_va_init_regions(struct damon_ctx *ctx,
 				     struct damon_target *t)
 {
-	struct damon_target *ti;
 	struct damon_addr_range regions[3];
-	int tidx = 0;
 
-	if (damon_va_three_regions(t, regions)) {
-		damon_for_each_target(ti, ctx) {
-			if (ti == t)
-				break;
-			tidx++;
-		}
-		pr_debug("Failed to get three regions of %dth target\n", tidx);
+	if (damon_va_three_regions(t, regions))
 		return;
-	}
 
 	damon_set_regions(t, regions, 3, DAMON_MIN_REGION_SZ);
 }
-- 
2.47.3
