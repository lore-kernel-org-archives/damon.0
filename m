Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9CA322533;
	Sun,  5 Jul 2026 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285075; cv=none; b=IjHf/wADRpCHrk0H6CUnPk74s+9iAHsNIJGteZyZarrT2I4Pz0PtvaU9UM9Sb2wSgdjv4TEq5jODpBiiS45yETBTNY4UJtM6gMweIbUYklQs3cjJR7LBIsCoi50gGVwxuJslVAVslvmxZefJJiIav+YgYUZTk1wd+4LX43jP6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285075; c=relaxed/simple;
	bh=RQ2rlxFHdwSG/upgmjkGZQ1xYTrL37W/RTg+2FEFktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmFmiZ5vvMN+xBPXZno4bNyZyJ0dEQsM5L9z2C4AhWlFk7YzwJtLK1XptcOA4ukGU1xrcbCTp+EG7l7gCmGVWg6JlrbWfMHRJnnvQD1Z20aB28oonzOPIXDh2KG8TJSTpYt5xXXha7YbsbIlVu2gEosh7UA/kifykESXPZx9kOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQAI4ROA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQAI4ROA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3531F00A3A;
	Sun,  5 Jul 2026 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285074;
	bh=kxd4/9TvByhr/rgk5a0bpEO5crurTcFohmlFktpxcC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQAI4ROAjA71sUSmR/akrtuf+fPsxQHduGEIUvugrwRgbjiakZj9NZmgqslxjmNZz
	 ZgK0N/6FbFl04/fLaOweJN7VEy96aos6B3ZtYqI0htRhbNvE2Pfrbdc7ynOdjw7Llp
	 OBur9DnwZ/fD5X6im47r2Gb2+D/gHgGcP7lWEm2dW9efDlAY+Yvv8KXegFBfWYrg0x
	 qMtBJHBD7tvCBP6nVHczC8SnHjLpGpYg7Bd9qFSvneyhLzKscxrx/zPHFERpNY5FRQ
	 61F0PjPy0ePsyXAQ8nrS1TBpbRyxBhagUKeepAu6mLNuto+C2JcUvQr1QGUo/KAMT6
	 pWDwlkvCc5AwA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/16] mm/damon/paddr: set samples in apply_probes() if requested
Date: Sun,  5 Jul 2026 13:57:25 -0700
Message-ID: <20260705205743.98656-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apply_probe() callback implementation in DAMON_PADDR is ignoring
set_samples parameter.  Respect it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b13bf7c6eade3..ff4fcca949660 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -178,6 +178,10 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
 			phys_addr_t pa;
 			struct folio *folio;
 
+			if (set_samples)
+				r->sampling_addr = damon_rand(ctx, r->ar.start,
+						r->ar.end);
+
 			pa = damon_pa_phys_addr(r->sampling_addr,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
-- 
2.47.3
