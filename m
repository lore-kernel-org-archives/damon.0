Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D923EA83;
	Fri, 10 Jul 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691222; cv=none; b=Nr39QR3R0TOZk8uraL6vciulu+jyIx3ppXKUH9PGtnRJVK1tDOxYu3sylSZTQ4OwEyPy2pRnkJgxkRlBflILpBk0Ssb7pRlwPrbvIkM4X0/gHTZ7zvS/93t24JNfZ/UqMqi71ba0xbQKMdquQB5aJdpFwM/CJ6oOzkn+G2CaRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691222; c=relaxed/simple;
	bh=RQ2rlxFHdwSG/upgmjkGZQ1xYTrL37W/RTg+2FEFktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5UxHzQrkAjBM97UZPq+AH/OcYuWCIpYJKcXb0TxCG07D8fLktRUMe/6MTLGsB94TRn9d70S23jIWy9+m8HWj2qMhRqKiaF2TVYzr9wjzmraFQFvgP2AaVasTL8pgRRC1Z2skZS6v8ICCv3u4mAFQciEI2Q+s5x0Zv+KaQZ6YS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiOcr6Dm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiOcr6Dm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449111F00A3F;
	Fri, 10 Jul 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691221;
	bh=kxd4/9TvByhr/rgk5a0bpEO5crurTcFohmlFktpxcC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oiOcr6Dmh94dmKWV3A0I2BvdJp91mwGZdLaB5ePDtBfTVstyBCeEO08SmKiq0Y1Q8
	 USjp1vA33eU/gRHhzA7Z+8SiciWLyRJSZHaY6qdtYJimUpA8RiJhIxdnSDfGeyDK0n
	 +eOuStmqTcP5WfqWjY8yWw2LGumOhexAOwc3OC9newKii115fGg92ijE7drBU11i0F
	 IkNZrGwo5wkbuyqmgGmCSiGnVILzVmSXL+h5f2NzOMW8QzZNzuo5NWZsmZgfY3GvHY
	 tnNT1Deuf80OVF97N6HHG1+FeN0pHnckThmvp9TiLzCswtiUBUZFjh+2vdG/FQodbF
	 A9wI3uZwLHwtg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/19] mm/damon/paddr: set samples in apply_probes() if requested
Date: Fri, 10 Jul 2026 06:46:32 -0700
Message-ID: <20260710134651.18084-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
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
