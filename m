Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B4367B92
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337131; cv=none; b=mKen+pg288MVh0wamBatFxd4F12Nv9GKHJmzzVZUfEACK+SN/oooRscnQXOanfqgafOmWv0hj/ir6bLQL919HLFmP4UxrTwXO9wRf/+Bcmxx9JtcgiuHie42eL54FQhLTGcqkDxhZQgLvSYrKBLA2iaoArArlV5oO+PieqJZlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337131; c=relaxed/simple;
	bh=A6rLcvnK3adoCDStrd8do6BJqgmVpZd7sCs1Tc7EqNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mV5vn1iP/zcmQTsQS5gT4bQ+LYriLJOMWuSdUzm0XvISmHHey/YM4vt5IK4SfHwyxtKX0MVlfOsuaBFGQjvTqe6uraSHUtHoMgCUS00L4C4oxpBTOUHFIDCjUHgfZ3BLA6A6Ou2QXJ4lpbRdf7nMt2+tiJ+NCpqoI9bin8Nmpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OveYHQn1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OveYHQn1"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39647184c73so1935660a91.1
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788337129; x=1788941929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QPGyS0AHVOfUWMfJXbkr/UK6bKLRAGXdQYLecgn4LSo=;
        b=OveYHQn1dH2SPXVJitz++M5kX//OhNDdiwIHyFwd+uMAk3v1z21Eo6It2VsRzesWec
         AOb7B+7D3ajFt2k3fRN+jTY/kst+bZ0SkD1Uy5sRyiT0uFvL5gGpw1y0wNZMA+VAqZYJ
         yBp7K5iyFa7yQwTr5OaRaOOjVmO3v3FsdwuHNgW3mdrxf+xc6ZD2rIyvHh2tYbowsUhP
         LVaF10CZ2x7Bnvc+6VweUIpFJeyIEFNCSzWQ7y+IIjwMkzn+g9MSg22J7/lfSV+L2mmI
         jtr6NlO7ng4ocCSESb+L9DIrLj/cXmHKU2OHFJvkLkORHW9RPwpOTU5F7tNHDYC6WogH
         f+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337129; x=1788941929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QPGyS0AHVOfUWMfJXbkr/UK6bKLRAGXdQYLecgn4LSo=;
        b=OGczflpjJWolk5cVVqMnz/Mqy+bgbZNI4qujPazs03zqLVIv6RFuV77AhPLQ0h2TKm
         ZxgAqd8iCapf+TMHCafLaVeP+nNb0q2vR7D2rQfoshg1oquVvFgXXoBmN4DPcpHlRGUV
         K0538IZz5Izu4E48T8oGUMn4N7QGRGJKQX0HmYvvT8xJYfIRni0YsqyaDc5uGqAKLBqE
         I0JpuoXUbN8+9EMJL5eoBSP9igi4DBQqjz6oK1q/daaEebYVCyKCRBRAnUDu9Qdv1LCP
         jpOisnL+bUYsEkPoBYZvtHjWMkBeP9n4AXnbcSL2jGGg4d1adZEVEp0F7zeIiwLkA8FA
         netA==
X-Forwarded-Encrypted: i=1; AKwUvBxNm1+ZvkqDRfuk4zbaD98suZH/i0G1yBLgo9HsZjEm79bB2dZNrXsxJ6AFfTzNzuALqQmjWg==@lists.linux.dev
X-Gm-Message-State: AFuF++nsmNywbZwSzVVXt6LrDDXex55hARi2Rk+bNxA+juBhBzxpYw2a
	2Aowc6okfqBxepOKeiz7CVQO+3n/vq6uJc6sTGjdSMw+2SksiGWKLtlo
X-Gm-Gg: AYBFou1V8rgeVGXv0MLOfbuowN5A0xP5u3SovAHLlyNHErgFUqF97NV+XQiuOeNRhrA
	S3d+uACMCVQFnFcvXjMjfrw1hjxRIOimPri6I8dkeEZnyGfjZ61hIfc59d2RphNC9YADIXDJN8s
	hy2MNCZNvpqmkiDjibS+5fHqyWAatnv3UPvLvh9SFp+GM8uKqMPiWOa93RZ/JisHGGQLeaeFlWd
	QoK6T3r6xPX+QVlw7cqeKE8iZ11Lj0kFuXbbdfbV/aICRRW+Tgs42DzDNf5gXpQeNHboW1/1ibm
	JWlANnJHgTLM7doguh0o+TrZTgYnQll6uP7reSikELjeb9F6/RBKawDC7pdUTJBbbtVt06Hujh3
	QUnCo/An3MLk1cSB4uosEXikg3lq/Um7CkRgkpV+y8BuU+xGqLAiXlNR4G1XzQuKx4lnTRu2ttz
	MqyjzbqARfjMehFCExypUEEobMEJ8oIT3UbITAEyKfqbPs3p9+tyIIUQRD5YzsUnqp1X5n2zoWv
	9grIWQorLBGVXKn
X-Received: by 2002:a17:90b:2f84:b0:398:9bd3:d6d1 with SMTP id 98e67ed59e1d1-39af64e0adbmr1153860a91.11.1788337129220;
        Wed, 02 Sep 2026 01:18:49 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75b540sm10430157a91.10.2026.09.02.01.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:18:48 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix false positive in
Date: Wed,  2 Sep 2026 16:18:25 +0800
Message-ID: <20260902081825.18931-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting goal_tuner to 'temporal', if the goal is achieved,
quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
will always return true, even if no regions have been tried to apply at
all.  This causes qt_exceeds to increase unexpectedly.

Fix it by:

- Returning false in damos_quota_is_full() when quota->charged_sz is
  zero.
- Adding an early exit in damon_do_apply_schemes() for schemes with zero
  esz.

Fixes: c7ec7d5f6b3d ("mm/damon/core: handle <min_region_sz remaining quota as empty")
Cc: <stable@vger.kernel.org> # v7.2.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v1:
- v1: https://lore.kernel.org/damon/20260901105925.106186-1-aethernet65535@gmail.com
- Changed the check in damos_quota_is_full() from '!quota->esz' to
  '!quota->charged_sz', because the former is an upper bound, while the
  latter represents the actual quota usage.
- Added an early exit in damon_do_apply_schemes() to prevent a scheme
  with zero esz from being evaluated by damos_quota_is_full().
- Changed patch title, original title: always return false when esz is
  zero

---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8e3ded1a2cf6..de78ad56c8b3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2560,6 +2560,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
 {
 	if (!damos_quota_is_set(quota))
 		return false;
+	if (!quota->charged_sz)
+		return false;
 	if (quota->charged_sz >= quota->esz)
 		return true;
 	/*
@@ -2666,6 +2668,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (!s->wmarks.activated)
 			continue;
 
+		if (!quota->esz)
+			continue;
+
 		/* Check the quota */
 		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
-- 
2.55.0

