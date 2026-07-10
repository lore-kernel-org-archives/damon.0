Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE618FDBD;
	Fri, 10 Jul 2026 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643040; cv=none; b=Z0KJNfMxVIz8He+j3OEP4oc9454Qi8x4EIuKconJ8l7HMLsWvURooo/sqaJoCN1zCaZDPT1ijm838HhCDFucPorIRVNzwPob8NlvohBFuyCSDsxQ1pw5VzXzGKlW4QNvscgNh81qvSyrSWOKh9oCx6MaK/iGN4/8g0hQlldL0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643040; c=relaxed/simple;
	bh=RQ2rlxFHdwSG/upgmjkGZQ1xYTrL37W/RTg+2FEFktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE7/vIcpSLsKPX7cN9UGbAVSV5KyU64JunrU8K99+UDk/aOGrbgHjlTv/h1L/BLaGjTs12WGumUW4afHPfReFhQwJ0huly/ian+dSgBoPzBQWqA/qnY8BDjoYrfHW7dyFhigKhUERvwK8oZ3N827UbWOmICjRurAuiOrzx1ntDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6uQQOD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6uQQOD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4F71F00A3E;
	Fri, 10 Jul 2026 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643039;
	bh=kxd4/9TvByhr/rgk5a0bpEO5crurTcFohmlFktpxcC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6uQQOD2abNdpVUmW4Q//rXdEFonp+j3IZcE3TB5fO8ayGwXXurfopmhSyOgBNBBk
	 C6JzjYvS6WKLgYB0jh3MY8ouVimSz2x5kktY81Eiu5Njdm9jh7EKHVVEJWi1VVh3Xf
	 LN2pL77fjVgj6l1zOb4DCSE9UlCae/NGW7udXKbzzSZCHUxCBsi3/qDJztXHHrjB50
	 ZmJXsNWO547J0jHYn9lVyD+1dQr5j0McfcUH52Zj8+aygnhWa6zscFFiFM1/Hg9Nii
	 +mqIYvaRYw6+lxcZtVll+yCUspxlpxoaqzolYZ3gC2snoE5r1wXprb4Goz4PjvVi/O
	 RaDpl16libW9Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 03/19] mm/damon/paddr: set samples in apply_probes() if requested
Date: Thu,  9 Jul 2026 17:23:29 -0700
Message-ID: <20260710002349.111414-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
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
