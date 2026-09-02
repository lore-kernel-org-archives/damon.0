Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F338DC46;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328077; cv=none; b=MIo0zluem8F5jW3HocQaf+/dzFg6X0GbHt2nP3b+AMmVe1fgtyTvIMZmrsYyyEmqHn2OB8/HObn0Kjj9YAYqk9pNQR32nBR3SWPyfhzx1jPgdyT+UsEpXvDiJMfmv3mFwlVO+c/BY304+eA6sZSGVYw34Hup1ikbPzvE4UTaqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328077; c=relaxed/simple;
	bh=hZcttovCR1StplimYTOK2AOhYDVwKc3kMn+Y2OQc55A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmRaOy+RH3xgWwsLsK+v9VUDMAcmCtNu09bs4VuGOT9ufSUAzPQr9iCLDZ8hMZot/wQEMOXcmAqpFu7M1ZtoRytef7BVxKzFz9odT1t+2xcswmH0mfCJCSfqn11ivbmY3aLguxtceB054FAaxkmoOWaOXFZ8yASu85MtdCVyAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUoiPmmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUoiPmmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FD91F00A3F;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328075;
	bh=/2GY869qZ/WdOTeEodZMAmxRd6cUaT9eWkbGwKB6Io0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUoiPmmq03z/pb7EKGpCiPYdf45lsEaJSgpcEVNGLP7V9FyprLGvAUBD7xhy1y4Sw
	 qoXrgWdYnlre3eDn2J4hryFgCgMUZczJj+sVEQB5XhAWABL0/gtqMKZ26RhAAOX+E8
	 5mZK6VGdSDUd5B3nrxq6+7YS74Kia36vMOGaAjY7UNGqVB3abzr28N9Hx0b1pYiH59
	 94pce2AY6l87qeXrKloejLqv8ilvg1jwU1HqXpmHLadZAVyxti8oC7nQ/Bdj38Oas9
	 LdStC6DskZNiKJsZhvkJJDxDAhZiVFEOhEYRbGRvlWariFc75TAlJxXpoaEgySQZ8M
	 Ezrm9zfSFQKUQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/12] mm/damon/vaddr: remove a debug message
Date: Tue,  1 Sep 2026 22:47:36 -0700
Message-ID: <20260902054747.99370-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
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
 mm/damon/vaddr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c8c32b2ae0402..f884d3f78f30a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -189,22 +189,12 @@ static int damon_va_three_regions(struct damon_target *t,
  *   <BIG UNMAPPED REGION 2>
  *   <stack>
  */
-static void __damon_va_init_regions(struct damon_ctx *ctx,
-				     struct damon_target *t)
+static void __damon_va_init_regions(struct damon_target *t)
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
@@ -217,7 +207,7 @@ static void damon_va_init(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		/* the user may set the target regions as they want */
 		if (!damon_nr_regions(t))
-			__damon_va_init_regions(ctx, t);
+			__damon_va_init_regions(t);
 	}
 }
 
-- 
2.47.3
