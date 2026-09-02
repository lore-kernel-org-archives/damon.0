Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3638DC7E
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337243; cv=none; b=bmzU4lx6hSNHXrPQuo4DSCVAjr9uy6KrhDMcFbiTY87G0uZQ1Tx8Go6aUSHZlS8wt8HTlgEPV25DI/VesOs/qGBiowb6ybyLLVcv+Ens1cPWdCuGYkSxphruf0Nwpuxkt11+4dSoeU9Owj4HNtiitVuC1XWoRgt7WUTLsqpkDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337243; c=relaxed/simple;
	bh=/N08HHB3j4IdAUsjRLdoa6VRu+ufxXx1qoUkqfxRshc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HozthPFgj7Is0tF4o+vR8/lJqmPxLFcgD77hIDJb87AiqZZurse6rD82xaYojEgts2BI0FGDooWs3kYEyn4oN+gGM4bYPYMF5DOKQFPdg+TGcwvn2fdhbRC7x4N+1vre+cXEXsdZEd9kDNZb1y8G1MTj+7D0di9mrY+adxvNvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Khj2Fu67; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khj2Fu67"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso641825a12.0
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788337242; x=1788942042; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C6stb0h/TUGkigOyr7jwbkqUiojuR7BYoo9mkXkmykw=;
        b=Khj2Fu67JVymLcBjbVUaarAVFqpO7F9u1lkY5YqVjAszDEytGF0/auID4QkLcI/R6l
         vdNOgip3bYra0j8v3seIQ79s3SUCdufe2zqRh/0LJQ/vkrzdPWEVjLiwGNiHe2RStW3A
         5PtwYYrh8T1PyBBVzTfIX6GpEI4+62sgBbkp/POAoKzsKgatm+HmR1LW5vN18CU9kOGI
         h03FvwlOOpDoBbsVUYrm9yo509idffHym3aOe8kK3ITUCFPzpwxu9NyQ3dys+O2sL0+0
         3txTRAWk4RmsL7rqoAQjyB3LUYqogcv46clWBFgtnHw58iEd2ZJpehX7VHQp60hG+T8x
         dnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337242; x=1788942042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6stb0h/TUGkigOyr7jwbkqUiojuR7BYoo9mkXkmykw=;
        b=SU6MPmYtFHGxW3c92fEggj2AutVrAlpo0BMYm9dllAL/M81CEZehFmKt62fJCGLJxS
         XkFrKQ/7ZYUitGDLyLRz2NR1AqeK+IX4qx9lAR0g7tIeZe7DH0yIvhe9etRpeQmBZH9O
         1/4nyTqx5vbDtsKu435B1rx24Wv+7TKjOUFipLpuEERKA9hklTei1Y02IFsc5l4FY5IQ
         p0JmL9IZvBHhuoKohZ9UzejrRBIS394U2ODd0o/PlMUxhnyASjmsUUh8aNHYxSTCTZ3c
         Uv0sJ6QPEra60WrAPIoGCEw0I1RBu3HYNSS9dUbmvKhQpOPJ90M4xDmoVv5xgAuYsPkT
         T/WA==
X-Forwarded-Encrypted: i=1; AKwUvBwXpsIqX0k2s6kDa8oyKoZ8sjYXpsQQE0Z4CUzLsv7U7HFhqCYDOcvvDt/q7wDj0UhV1B+btg==@lists.linux.dev
X-Gm-Message-State: AFuF++kXOecEDh6wEpX5xRxO1fq3YmMGAhRnAkrgBM4V9t0X0seM/xl+
	xii8rqnDjlZ17KkgAE6dsy2D4t0zeJmMSSdg9FEvG8TAcA2fQ9zYPg7T
X-Gm-Gg: AYBFou24h4I2amxf5NUR3oSwTBO0MiJTpoo+zmQKRNx1aP9sA/4vmsLvcPnVtk9tHln
	Eb6Ic1hEWMEgzIQsy2Dj3z339rdt2PLpoif2XCiRd0kbMxJPo6Ceh2Nz5ZysoPLuLyTZNEH0PxU
	+ivyQF9tfmMa3E+Z7kJhBXLWej/R9SkUfv3ulHThYK7Oq41mZ5tULrhKRP6BIMVU4EHsd7t302J
	g/aFbkwq1cu76jI9iyWvTsQceQ22Ba+ya7ayfjuxkc4wZaxcXo4zhSP3y568iy/8oVgd3ZCnonK
	SwoPVSoAkUqMKF7h1Doa2JICAn6d1LqRFbwE7HszliOMvDuta64zFqdSW/cb29uG6lHgDsHtqnR
	AcvKobHVt2rRf+mweOJ2Z16FPfeMwYPLZHZgnnUOrh3vS513VVx7+G+pVBOI2u1ndUg8chyZc1U
	x2gvZFPGY27J0sI95I1HCsOoyoV1le/LEEhQeQJBm0oHO5b7xm5/6bm4/aECuTjGm0jB78OIUkE
	LGeMKI0lC/PnhndeTkgTuOrbWkq
X-Received: by 2002:a17:90b:3c89:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-39aee066dd0mr5075947a91.13.1788337241788;
        Wed, 02 Sep 2026 01:20:41 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae3c72584sm4119404a91.17.2026.09.02.01.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:20:41 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: allow esz to be set to zero
Date: Wed,  2 Sep 2026 16:20:50 +0800
Message-ID: <20260902082050.19566-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the effective
quota (esz) becomes zero.  However, damos_set_effective_quota() clamps
the quota to min_region_sz, preventing the quota from ever reaching
zero.

Fix this by adding a check for zero esz_bp.

Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Cc: <stable@vger.kernel.org> # v7.1.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v1:
- v1: https://lore.kernel.org/damon/20260901105951.106246-1-aethernet65535@gmail.com
- Changed implementation.  The initial solution skipped the
  min_region_sz clamping when esz was already zero.  However, this would
  revert the fix from commit 8bbde987c2b8 and cause a regression.  This
  revision fixes the issue by adding a specific check for a zero esz_bp.
- Changed patch title, original title: fix quota could not be set to
  zero

---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e13a154aa4b9..8e3ded1a2cf6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3133,6 +3133,9 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 	if (quota->sz && quota->sz < esz)
 		esz = quota->sz;
 
+	if (!quota->esz_bp)
+		esz = 0;
+
 	quota->esz = esz;
 }
 
-- 
2.55.0

