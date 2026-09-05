Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C44908D1
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612435; cv=none; b=YhBXPMKhcZemzAitRSVHJEf1pkbJmiHSDXCdh2oiM2rSX0wqhLbnpChQ5nb0mv08gU3yZWXFOAYOq4KhLlUEc7FkAAU4pQUNSfnmnDiFS/UdShJZvNChjjYRqobL3BgSx9gwGWpbzEosV8BDX0gRr6cpun8EUnj+bbk0mnp9n5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612435; c=relaxed/simple;
	bh=HyoJEb4h13ThEffr3wFJxPnbY3zePrqVNCcnR3fUkBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3M2hA4qFYfQ/yB7r2DPZBtd5tOo1RNRtwhu3ZythkcMtYWkHGC1w1ceHwGdPnCnLkcF2JGrIDEx06vSm8IYhJ0zCxbGvvYjC7M1qpTwHQJ9i1p68f9vFwl+1MAXT1w9zr7kKLkU8dl+bmlCFcBzLm36sJF9hC5vLdJtkEiaMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfBAJHLU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfBAJHLU"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1274760a12.0
        for <damon@lists.linux.dev>; Sat, 05 Sep 2026 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788612434; x=1789217234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ziQh4+EYTP4FJ/w1XHqXZYM290fo3MHX7d8c+O4yS34=;
        b=YfBAJHLUfrR+uB2LDUKR88wr8PNK4M3ZqGZ4NyFdBSHVBRckXq4btyQttPrfJvLBvd
         Eny/rApHeppTshUMna96ngWzncapkmspJ/1pMM8tFhtZr7/j55fZ3+rPatgydsmpxNY1
         rsMp7tGA5jbmgJqVSaEHMc4Z4fVRrrVnq6PCj6jHEFH0J31bQBt0Znc5JDZgp1Ng3xzi
         SNvxCcEBerCXFJjCRv+8sXoR33vt37Pl4Lvteb5h//j3MT5080coSiVPIO2RM80fiM5M
         bEAITkuZ31cjsKqEnfEGjW+xTNgm+DjDhkQJaGGtYO6PhYy911Boa7IyMaqJfeBtJhb/
         vnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788612434; x=1789217234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziQh4+EYTP4FJ/w1XHqXZYM290fo3MHX7d8c+O4yS34=;
        b=MSEqgiL/h/G7Y+FagJC2fvKvW0M5RiIDNXedIUjbWobL6u3qjqGU2ao9XctvK5UzuL
         XR/8SXBCxRkrQ4Rn8zskNFGpg7Ko3FYydGKY1vYTasDmyOEZUCd8G3VZMSKG1/blRcWg
         0FwU1c4JU039XWOzNHJyqFETTQms55xHtO349vYzQ6i69K7k4FaJeRKDDdbNAtPQQ9za
         h78OkVE1JHYMZHPHwQsvYJ5Ui0FxJl+sDYxqaulkS6UElovEwdzEnX2MfkJtuj+G0MoB
         Xw2CXjzwEb9GgsJ4IGqQBkiJOfTXZZCwAQSL5Zjeqs1P5X3oxRliOBVKIXxrHXQSGJbp
         xZvg==
X-Forwarded-Encrypted: i=1; AKwUvBxRmPk522YVOhqZAjKTH4JTzqeD7v29StT3jidQS/mso+2dH23wEyIDyiiOVU2atm75NDVubw==@lists.linux.dev
X-Gm-Message-State: AFuF++neE4HvsGcRcyd4lqFItL/XAgADbQykRnr35pn780ILZmNlxQw1
	7/LJZr1JmKf/PDFN9+7vCsbZdpGZg2y700bgkCSp5EsIavPFuXRfof9F
X-Gm-Gg: AYBFou1R+7GhLgmRvma9XuV4hRhp32g9Mzl14Rd82aBoiFfWwXZlAOYvYlsbApbYtFI
	7xp6/i+5HM1P3rW2cqSuBIcm0ppscN/QB+QIx0zCGeDPrBfgbDwnNalOSsdAPrOoh4r8ulQ8FZ9
	Djt4Kk+zcwSf1GvOIHsa51kNKq5TMW2e6WETAsnlK1qX6vIkkbAAPQLiPERQoGYrWiQ+thHzOJz
	b6UeLYUKM1EFCZaoWRorLQJ/gb655MPxBfWOiXI2ysWTdgi9BovNp33YkcepVpX8kjs3KWEgt33
	IpbsE4/9iFbcotqjfl4o+M3YIJlsnFjvfx4F2KeG54fuEUiEve6S2XEPcjdJpe8SF49Jfel0a6R
	mQer9ecWd3tXJW7uMYZUee0MqveIuN7k/dt37EHBa1RFBALTCem7F6JGU5Xtftgja9JQvMkLZac
	ncuiT9mS6pt3CiNmAa+2yY3ub6sRTpz/475apKQCglPmfP2ZGJBIe3a0wj55MrtMuWFw==
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr18020789a91.23.1788612433720;
        Sat, 05 Sep 2026 05:47:13 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([115.164.90.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm9929306a91.4.2026.09.05.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:47:12 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/damon/core: allow esz to be set to zero
Date: Sat,  5 Sep 2026 20:44:58 +0800
Message-ID: <20260905124706.3398-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the esz
becomes zero.  However, damos_set_effective_quota() clamps the esz to
min_region_sz when quota->ms is set.

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which state that if the goal has
already been [over-]achieved, the quota will be set to zero.

Fix this by set quota (esz) as minimum as possible.

Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Cc: <stable@vger.kernel.org> # v7.1.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v2:
- v2: https://lore.kernel.org/damon/20260902082050.19566-1-aethernet65535@gmail.com
- Changed implementation, more general implementation provided by SJ. [1]

[1] https://lore.kernel.org/damon/20260902150301.88535-1-sj@kernel.org

Changes from v1:
- v1: https://lore.kernel.org/damon/20260901105951.106246-1-aethernet65535@gmail.com
- Changed implementation.  The initial solution skipped the
  min_region_sz clamping when esz was already zero.  However, this would
  revert the fix from commit 8bbde987c2b8 and cause a regression.  This
  revision fixes the issue by adding a specific check for a zero esz_bp.
- Changed patch title, original title: fix quota could not be set to
  zero

---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..2b294fb46648 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3091,6 +3091,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
+	unsigned long esz_time;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -3111,8 +3112,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 					1000000, quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
-		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_region_sz, esz);
+		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
+		esz = min(esz_time, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
-- 
2.55.0

