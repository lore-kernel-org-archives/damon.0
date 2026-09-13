Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0B2C3261
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789297442; cv=none; b=vEFiYVl4U8wE1EJ2znOrteE/s6+yIwjGhnZGge0hrq3JvRz825BPd5ABhLriPNBMknwL3HLLsgAx7U5WCdR/aCN+YeV4GQqTOphyIRpdtiQj4EV9Z9JgGIUHqY13Yr1h55eaLaFpGyYJgVzFlkCW+sf1JYLN+wmPpPGf2+yE67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789297442; c=relaxed/simple;
	bh=S34iC/bjfhcXhj7YY88XiwaqWViELbyiqoURANF+qOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyrPRBU02cHpAjaxS3ahqNiuP+CNLfrH8ExEezXq76YF01CFrthG8NmpRcQEo++r5TVX/KHX77X9+GCiYrg83gcpXTY3u/8CEjzOJy60R/xTRDvl9I32piMraml0vI4v36LoNc7Lh6BPHdeEG47xszrtZeaGc9nkcO3sE/7JbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLO7Xvrx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLO7Xvrx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso22875695ad.0
        for <damon@lists.linux.dev>; Sun, 13 Sep 2026 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789297440; x=1789902240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jyuRqgAnVGwyya8hRF/5ry5xM2Hr8OUc+TIWxjrQB+4=;
        b=gLO7XvrxdStokFRaCrn1Af8InbWguf6f6rJ7nxOLO+QOkpykyIPmGpyLE3lQnTB0pN
         5behZzu4c4ZxIFXDhCzPFFV2uF8LmGU26Bhi8AULzrVoNPYrnEyjV1B3uUsMlZtchfHi
         UQ4l919mHxrZ7DyiVvPRxkc/DO74nEcKXxadJt8rSh3+v4MJ6u62kW2UxjJuPENHTWCM
         +3dFM0PGPAs/Prblz4y0hlyhiimG1aqqYmKcI8TyMVsnvRvWKrBV12mvC3+Xmg6SxBL9
         ZI6793hvwYEyG72WaixeeNOhB8VYpPlSDG3SCJpw1DSIzN+zpL3idqxXjblIyH2c10iR
         gw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789297440; x=1789902240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jyuRqgAnVGwyya8hRF/5ry5xM2Hr8OUc+TIWxjrQB+4=;
        b=H5/BwZARsJ2gYQIe8NrWWssREVOsiEFl6AflkJdPg2qecqUDPYYTucuoS97UPely79
         Oaly994RPceS3Tbljfkjve7dIGfSvrmg21GTVSdLGebh0GFYuv3WUY0Nb7k+8RCuCyLx
         a6fmdS8I98e5R+eH4ueTl3hIOIBPmwn5YcwlOXjoyOlApbcwYTbC8lDOQf96H6a0iJVM
         bVGu6OlufZvOAbj23tMYYHo7U2xOsVvCKCIDdpXNxPzGzP/cVw1jRWi+1RFXWQv4wXyA
         WKyAM8E1xqUFGUWokUiNP/Y2TNeXiwudsbNEpLRGsWY57xvcK6o2zkLIfKU5SG9gOKnq
         40uA==
X-Forwarded-Encrypted: i=1; AKwUvBzlaCl1u1wn1kwfLLemA9Okmj2CT5ktqbO8TyH2reKCqmo22FxtVHuTOLLA76qWLrLFKzjcfA==@lists.linux.dev
X-Gm-Message-State: AFuF++l9KvVUWQyOtztc+sXGjYUrGTsZtTF1yq9KDYCYuKlo1QrUR968
	IApDz36prjAJJe0Q9QaBPZ+SJfmz+mtv+p8j6DwOpINXAn1sHhlkVG3Q
X-Gm-Gg: AYBFou0qJUh5rskLh39grKV3YDY9E+N71jedvWbAmOKGnnOrXKu1lYQ8FnBMm2d4Y6J
	IwOyiDvPwMgEjpBG5Bqair+Sw2pLnWyRiqLJ/KW0eFfctHrxylGvu4yVq/ZNS41mAFViZnWK0TG
	GIUcVWB0ZiXUrw+4+wusOV3bMoCnvXdXNe6c3sdBXXs1E/4A95v/ASZnfnEszUUfPPBJ5jFCb0O
	H2RQv4WaPF4zcY4n8E8o96aJDQBmuXm+l9RoyNoUkGy+j5nBT3Oz0siW1uyTY1lg3E2Kd7xhVXH
	UjaMOYY1udwGYIf55BpCP5u5Je2A9BopaJz8D8UIJ68LN5zCi/LN9H+Lm+ZxBZZFQoq96R+pX8Y
	QrfPrVFOyMBJJCTtDlmgO87CxMVMJbfkqXb7R4nBd2T1yd1AGT463SAl7KtWa5+PoF9VZvjBeJj
	A8VI23MIGkVQ7t9bYawYG/+NhjKxgf/CsmKW5xAl0Z/Fu0js8LENylpkdeyukW0zasGesbytjwE
	sQ=
X-Received: by 2002:a17:902:e88f:b0:2d8:d4d2:d137 with SMTP id d9443c01a7336-2dd5f1b11d5mr21545765ad.19.1789297440322;
        Sun, 13 Sep 2026 04:04:00 -0700 (PDT)
Received: from celestia ([2402:1980:8858:8cc0:7bda:d54a:257:22ec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cff67aasm32885925ad.79.2026.09.13.04.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 04:03:59 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: 
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core: add short circuit for esz<min_region_sz in damos_adjust_quota()
Date: Sun, 13 Sep 2026 19:01:38 +0800
Message-ID: <20260913110407.32558-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After damos_set_effective_quota(), the effective size quota may be lower
than min_region_sz (e.g., when the temporal quota goal is
[over-]achieved).

In this situation, damos_adjust_quota() will still calculates
quota->min_score.  However, this min_score will not be used in this
window, because in damon_do_apply_schemes(), damos_quota_is_full() will
always returns true, preventing the scheme from being applied to any
region.

Therefore, add a short circuit for 'esz < min_region_sz' schemes to
early return from damos_adjust_quota() before calculating min_score.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from RFC v1:
- RFC v1: https://lore.kernel.org/damon/20260912124406.96535-1-aethernet65535@gmail.com
- Make patch more complete by covering 'esz < min_region_sz' instead of
  covering "temporal quota goal is [over-]achieved" only.

---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ce8c6f99106e..15758525765e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3318,6 +3318,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 			damos_trace_esz(c, s, quota);
 	}
 
+	if (damos_quota_is_full(quota, c->min_region_sz))
+		return;
 	if (!c->ops.get_scheme_score)
 		return;
 
-- 
2.55.0

