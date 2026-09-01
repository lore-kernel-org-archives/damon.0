Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE4CA6F
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260385; cv=none; b=NMKKB9rKJe8SNQ33mnu3cu7Mcg8YFCXuEtYeHbiEcdHZjp6b7lOzJF+msE5S8HXiLwAFUF95lVUlS0Kslu0viVmF+51tNxJ/X0NDZuVLqd8bMDpZXIuSkrPRBLLKfFDJ7+Kb8jcBrupayhYVbspFU6AmgoBcyKRKpblU34/6SNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260385; c=relaxed/simple;
	bh=v3cXm9aO3Rd7JzKEU3sl/gy92NwMmpNDErCtcvlmbAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sq2pbWza2NOz2MRpCPDF6+QylUEceyX2VUg2Y409oveLafte6w1fmxMfMeaMaLOx4MeAgK3MocSP2qWA5CMQHrInQdeQf+Y3GZj5zqD9Jlhy0DSUkUUCfNIPUQ6pGF+GYDa9E2gT83zr6B0169+ZAoCGU2BgLh3leF4cFTmEr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUYIZeuK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUYIZeuK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so873720a91.0
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788260384; x=1788865184; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5kRAIEtptDuoDIWPjplgkKnNy7su8uVe41K8WELHNS0=;
        b=cUYIZeuK6Z7cmK5B7aysnA/XC8M5hkHrz+pBVCm6nXa2Vq7WAmYsBrxNDEnwb/nTA3
         rsXVRgT1wDsRreYp70YXZPqDDH1n5VV5HUwHVWIvmbW6WqfRkEO2lf40XZJcIg44znPA
         WQCUWXInEUFF17ZjqlDipKRO+y9jYhe/5oSRb04Zwf+Cdau9F8nXUCvXl0GLkB4Mg2mx
         WZVul9unU/+qvR/KpjrggQdVSdZ2KHdzcznMkchKU2WPqkKCnkMsgqcJfroMbXG5Idx3
         4nda5Up9cphOjICBjgOMLqbVu5WEGFHoH7k7D9vmWIpcd6ndmQsSLu8SbGdX6rVt8e/A
         640g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788260384; x=1788865184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5kRAIEtptDuoDIWPjplgkKnNy7su8uVe41K8WELHNS0=;
        b=IIaXbGVES23ir/CJCDw703hxbYgW23eGtMJ5RQ7mXCX/T9RDGnAFJ+KZsSGkbYbFeW
         M1jDmZ0zR6ViKPJf6qYiWWSO6js20ybRKmrnHSVt1bf2gZCbZsw+jnygJLF3BmyurfZf
         YeID87HR0wWmvSeXDZ/yZ16AOx+A9rRqfmGxB6FILEt9lQaiF6t+xVm9j1hCosuO87OA
         IW09pKrg6N4vENXdrA5oARdGkwhvGyNQ5gc00/Hb+VqZCy4cn5PXq239Zmnhvmpb58Dj
         rKZrR9X4h0SMAmUjfA+G7fKJZdElvhlnmENzA0wxSzGX59sCoercGzp+5l7HpaAoYcrD
         hG9A==
X-Forwarded-Encrypted: i=1; AKwUvBykemMvXlkW9GZ1XVI6w2QWZkyl1AIQkabOk8OQk+D15UD0Zg/CAFiDo54NImnUwsh23zL4Zw==@lists.linux.dev
X-Gm-Message-State: AFuF++li96ecZ+ginbuN0lck4fvXhiPspkTHIsr4zulnexLOiMo4PGfq
	OvsyA2WWLs+bo7iQlUFmYMKcqkb7mbFObbjfC1bqNyYh++OqMnqnPilL
X-Gm-Gg: AYBFou1hcihX4ZxlbJuWD5ZeHTBF9rkaDxWK7d9opc/0acnqlsQiB0mdzb097iMfhx8
	BwIWc4dlAmW+fsiKWRR1F8k8St0YCdkAIERNIA6xd+Syu4J7hWtqebAOMoVEqLg4dEbWrt7TZVB
	PIirMOmsBbCXnhBXU9XT1KAVsKU40VKWhGjwiD9Bevr5Zrpa3tYpOn0V9+6E3OowuFK1/RKPc7D
	wibcxp9mwbswZtb7ADOqGy+nj1JZNv0lmyoyaqhNOtVVkJ74HVuUadLb8PGQVlrxXnaNDb4vSpA
	V3yI6V6l+ZjcXZkR+vNKAKZ5z4UUiZ8p7UjwkEykNOMO4jdBcWCNlMQUD7AimMY2m3aF8Xvg+RK
	zr1hzyuuiNmTTKLR5MwNadPbRjKBOZBBBA4kpNa3XAWesdaRLckMGu8WV8l4vIjZgIiUkMWLqCj
	1t0szLTnefl9MtXdXToeVqGU3DbUn354jFAOl6XyYDqW/f4dhkFTVySrqHrb3G1U49
X-Received: by 2002:a17:90b:4a01:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-3990f772f5emr3422761a91.4.1788260383779;
        Tue, 01 Sep 2026 03:59:43 -0700 (PDT)
Received: from celestia ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d499811sm6303184a91.10.2026.09.01.03.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:59:43 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: fix quota could not be set to zero
Date: Tue,  1 Sep 2026 18:59:51 +0800
Message-ID: <20260901105951.106246-1-aethernet65535@gmail.com>
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
quota becomes error.  However, damos_set_effective_quota()
unconditionally clamps the quota to min_region_sz, preventing the quota
from ever reaching zero.

Fix this by skip the min_region_sz clamping when esz is already zero so
that the temporal tuner's intent is respected.

Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Cc: <stable@vger.kernel.org> # v7.1.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53cf32f1d515..0258769b8727 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3114,7 +3114,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_region_sz, esz);
+		if (esz)
+			esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
-- 
2.55.0

