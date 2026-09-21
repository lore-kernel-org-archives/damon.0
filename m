Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B64B8DF2;
	Mon, 21 Sep 2026 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003755; cv=none; b=SRR20GhjCkNetNSXj0+QPVn4eYCNaMmTsgId3bNN6WgMGQHUVcocEXn6IIswCnhWD2rwESuX/eB7pjTPtR8T9S0qTTIPfOc5EM7PYl3Qeq3c4yh+SLpPvIpqpC1a+fRPT2K0G/jbDsr+ur/FB0P2F+SUnyX6OptjHtE2OeTO6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003755; c=relaxed/simple;
	bh=dItxma8qc0SkoheGjWCNg7RiKY5jxIzSc/QRGZ4Ae9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg0AjnP4V/qk14AWrXRVEaFTCN8A4cVVyNMydDM0F1dVy8nEfnWuwMJ1qfnYWoNeVXvQ4E/lbZKx0uEcE+4AqTuIrPBMLGVfCW/vLC+2ziefrFePiijI1hbWNl/igxul7gaYUjbNwhocn2rMNgKf5F9xRqcHAkWMIsj8gT2ldr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWgeKyzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWgeKyzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06FB1F00893;
	Mon, 21 Sep 2026 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003754;
	bh=YZi9IVNfJSY7xxoADBVX0u2PfclU5VsMjaW1uA9UFkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BWgeKyzFjdqIj4tW9+UBBQAuV5uAkWPL1DXxt2dlrnleSInIzPDC/OCzQPyJlVlmd
	 SzIgeTw1WNHB2g/GbOEemtZPaq0J3qNjQEHL3MrmKqchXkpYKNydcyeErIUVd6z3gi
	 d7/8lVYaf0FPwXRYx9auipAG/RoQfJjtyYS6idYw+Cslo55S9LnJqk8Y+Fdk4Kujj0
	 cTVGjte27A9Ghxl5UQ58h24uOTUrDjEPyuQrsv1Vg3/UjoNg6gzHEbaF1J1sRfLWqb
	 SLEktZvY0vMp+P+b125uSntGrzRLnicOrFueh0ReYtxcXIcLww3zLtMIhiudE59eqa
	 G7BEEAsrvpO5g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	SJ Park <sj@kernel.org>,
	Xuewen Wang <wangxuewen@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/damon/core: skip quota score setup when the quota is full
Date: Mon, 21 Sep 2026 08:15:43 -0700
Message-ID: <20260921151547.78472-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921151547.78472-1-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

In damos_adjust_quota(), the quota could already be full.

In this situation, damos_adjust_quota() will still calculates
quota->min_score.  However, this min_score will not be used in this
window, because in damon_do_apply_schemes(), damos_quota_is_full() will
always returns true, preventing the scheme from being applied to any
region.

Therefore, add a short circuit for 'esz < min_region_sz' schemes to
early return from damos_adjust_quota() before calculating min_score.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260913110407.32558-1-aethernet65535@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2258b72da7a7..98c767b9e6ef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3368,6 +3368,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	if (damos_quota_is_full(quota, c->min_region_sz))
+		return;
 	if (!c->ops.get_scheme_score)
 		return;
 
-- 
2.47.3
