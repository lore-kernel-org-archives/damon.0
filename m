Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154870;
	b=eyOmxz8Nc5CaI4tPvlxBFGrDYDqr0Z6i3NM1q+Pdb6wheHdQGS8ivcrRLGkptYn+TN/K
	 03zZnrDvd0RnClZxJGC2/8kXPRfDABqxuEXN51VGiwo6LMwiO4J5LnZeI/lVTV09IoAZY
	 dYWawqmQ7aiKEiazFBqXPGHm6zprR6TkoAdlaOgdiFqzEK+df1slRHABzmU8af7wL7Oak
	 irRHJIWjcYW1XKC2tMfolfVRNQqePg6OxCxodh926iEoAIayCM8xufsCr6S9/03YnowDC
	 VJrUD8/I9AsAsQ6LoTpk+ZvMija/s+Lbk8zqAe/WVzbGT4Kr/wAZNomKsnHVDZ84TvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qcJiPZgN8pOzganoOrgFc2rVZ3r5oqkHfeWdy+wn69g=;
	b=DYOlEKJkTzgQiH4RhR+LY1Mfv3PJsHgbu2tn/+FQ8nfeJ0o2eflTFHHPWXSGsgo42klu
	 FSZIbr6jrs9dAh1S9UkgWi/Koo+0jX6SjNmMKZAlRFEgZkbmwL4fweo1sS28Jdae7uAvK
	 z5fI/kP0DCDCFt47agziK4wJdBb4bPYfeLQOGEY5Rfp4m2/HO5xDFpDi7oBuxx/Tz6RuP
	 TKE15YVaQfO+PKglXcXlsXZmsdvzYsiT8Ct9HxzCh6N4f9NkYY9Vi/Zm7DxmurVTnCpVM
	 h6k1fCNnxGY7ECK5w4zYyGcIZL3nexG+UaM7/EJasQZWuZwjy3GIzV6pplnsnJrjJcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HglOJQvF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1E606A504
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HglOJQvF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41211F000CF;
	Fri, 20 Nov 2026 06:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154869;
	bh=qcJiPZgN8pOzganoOrgFc2rVZ3r5oqkHfeWdy+wn69g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HglOJQvF8hFc3qx1LYrKqBI4k40AOZzxok/k0qZ8fU+ee+4sa4lnrKmoGZeUgY+PD
	 ZCQc6Ii4Ng9cB2tRTPsRUYVyJL7Ar+7dAgquxnkW5MOv4LnRCEkc2E7LrBKJEyKOQ5
	 ApdPktoFcOFvyzhgCAo2TiMmJ3k3L1pusU25R5jrvuCFb2wqwsibtM38yjGDwAbnm+
	 Hn8eP92dZ5AcRKe7IbPtfZ/rKPcqlm4draL4B6F/ToKepI7p/hHVcjYj4o2A8yRpK1
	 Vn426Yx2YruMERQxKrLBLmfV6X2t0ZdIj2Xz5kUPrH5Tg/SH9tF5fUPN3xcbFRIaOV
	 Grq6eB8NTTVOg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/reclaim: set memory PSI 0.05% as default quota goal
Date: Thu, 19 Nov 2026 22:07:36 -0800
Message-ID: <20261120060741.92121-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120060741.92121-1-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
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

DAMON_RECLAIM provides a PSI-driven quota auto-tuning feature.  Because
of the DAMOS quota internal access pattern based region prioritization,
it means the coldness threshold (min_age) is also auto-tuned.  It is
tuned off by default, though.  The feature is expected to be only better
to be enabled.  Enable it by default.  Set 0.5 milliseconds per second
(0.5%) as the default auto-tuning target memory pressure ratio.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 2241b3e9145ef..d297b1596704b 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -69,9 +69,9 @@ DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_reclaim_quota);
  * compared to this value to see if the aim is satisfied.  Value zero means
  * disabling this auto-tuning feature.
  *
- * Disabled by default.
+ * 500 microseconds (0.05% of default quota reset interval) by default.
  */
-static unsigned long quota_mem_pressure_us __read_mostly;
+static unsigned long quota_mem_pressure_us __read_mostly = 500;
 module_param(quota_mem_pressure_us, ulong, 0600);
 
 /*
-- 
2.47.3
