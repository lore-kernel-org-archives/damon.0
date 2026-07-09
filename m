Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D320233933;
	Thu,  9 Jul 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605966; cv=none; b=OaFK2GMH6NF+AmqSUTeWLMetujsgKma62ia2uqj7gMfRRp03y1mW0smF+gqu73CjBji/9CsMdCr1dg4ElJSrA/hlVDxShCBn/jDQtNYwIAhkrmsdhulFsmQQ/oafHsX9+fdcs1CU+gdySaFOObM8IGjw/t7JDPFabHkfBm2zYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605966; c=relaxed/simple;
	bh=RQ2rlxFHdwSG/upgmjkGZQ1xYTrL37W/RTg+2FEFktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwHiYhbVH+ByEuJjS/olmE42XOzo2NM+s5GZv74iiQy6Df/etrFOd33C5WIxupVCaYO+TYwAc7YgyJtl7VaS+0t0FMf+syDoK6/8/+XnVYiLHWrEv2FxYGm496LbxCVWop8plItaWel5whaugi8RhuOzef6mOzCFyAis5xD436Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn+mcbgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn+mcbgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0BB1F00A3E;
	Thu,  9 Jul 2026 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605965;
	bh=kxd4/9TvByhr/rgk5a0bpEO5crurTcFohmlFktpxcC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kn+mcbgwp2zvPHW+COUjmO1ihT1Ei7R32zOzj7EohG69YDOQBWD0vzPjMOxRUG5fk
	 iePqk9X9/xucR5VPmeluUrkabQMt439s2Av1cWD9VqAwoxWB0povfkqhF5GqnO4HKW
	 95SkKCGrPNLXtuvlMmC05ZRBDEZsIJj1GfogUEiLve8NVJXW+Mv4i3tAV6ZlHltEE8
	 rzRK7XB+pfnjOVpnE9xMbbPzJ5VGoW6TDjuhCQkIpRiWBj3vYfPTXzLsyALzK7yn1S
	 RX4dh7lR4wyzjJFce7tBXyn5pIQE6R+hRRhqg/bjSe0blNn5sph/TirM6xVuwoPxkl
	 gqCB8j8Y9sEHQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 03/19] mm/damon/paddr: set samples in apply_probes() if requested
Date: Thu,  9 Jul 2026 07:05:41 -0700
Message-ID: <20260709140600.90950-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
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
