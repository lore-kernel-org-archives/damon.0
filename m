Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBD3C3F54;
	Sat, 12 Sep 2026 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243705; cv=none; b=hYtTYqPW5GSSbJJhTuwzAaGxN9L4DnfRZEcdStDhaDHt+Ra9tlmqyw9RbW+izPlEHym59MDmWwKR/CLPSZHjpaZ1Zm2Zi0nfND9hoPlSAXJVeqD4E6Ljg+jNlJTVC3V+1axm5WCFhJQKI7Fzt7+z/aqDrDp579hg4aT3/1QDnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243705; c=relaxed/simple;
	bh=Ddkx7ZTSFvFyvhnKdja06+laaOkv/3+hcb3Kam2zg7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFtgW3kJe0hzZlIc2DNSp1siZdk0XkzMsTApRB/XkCqVT/cQtXQcZ6knMWkvIVMwqWI/e8f1pMqTCce/zJ07r9hXONcS+xIknttoXFPLpv6UdFzSLX0fUjn5R0n5LmDpNRZCTCFuShMKe1uyNGSWjct3Vykj7/rd9wkq8QD1YCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXJjU9Xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXJjU9Xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533011F00893;
	Sat, 12 Sep 2026 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243704;
	bh=3HzbqHqjQymjaA7BsBDU1/xd02tq5ixlWdlSiDNtUtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXJjU9XusbyGGP+L97Elho25w2Vif+86AiBhcfys3oRgA/4vaaPbrlscSM1GfVy/u
	 2NiL8feZotARccyzksZQN1i89yIAXTqCHbMDiD7wJJaMVIdzJSL5pVkN1k4hlpaeV5
	 bwpy1EJr7gJl8GQ+5VWyNN+czryKWySw2hcy3BMXhe+Qg0vLapXFHqovUWulPApluT
	 FmZzCxX4SaU3NIAG/g5lgOUhZzGVSaPrE3tISnWSXacVlU764YIrr+Kpk2pFjZxFJM
	 vtud5+SvbblJdVrepIpBCZj8+ScGtxf4NuBcVNjU1PwEt20BAEo4vf6DgOVf1hO3y5
	 HqZLykgMnvgoA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/9] mm/damon/paddr: remove pa parameter from damon_pa_filter_pass()
Date: Sat, 12 Sep 2026 13:08:07 -0700
Message-ID: <20260912200814.145612-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_filter_pass() receives the 'pa' parameter, but doesn't use it.
Remove the parameter from the function signature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5abfabaa339e0..2cfdc356b4157 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -163,8 +163,7 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 	return matched == filter->matching;
 }
 
-static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
-		struct damon_probe *p)
+static bool damon_pa_filter_pass(struct folio *folio, struct damon_probe *p)
 {
 	struct damon_filter *f;
 	bool pass = true;
@@ -200,7 +199,7 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
 			damon_for_each_probe(p, ctx) {
-				if (damon_pa_filter_pass(pa, folio, p))
+				if (damon_pa_filter_pass(folio, p))
 					r->probe_hits[i]++;
 				i++;
 			}
-- 
2.47.3
