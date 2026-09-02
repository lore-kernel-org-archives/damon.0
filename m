Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5E388E5B
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338692; cv=none; b=EnGcpFr5WbVRlZ/fADVZaloz4iP83CFmmOGfm97aIHkJHd0Hi8hF6DMRsIDqUdA3Cnaqm8i+vW0SxigehtEEdmjW1gQHonMQASbaRbo90QIIB0vLAS/vjgROF56N/h6YxfCHQfSDfIq/oxojTO1Hp+0JGJTWuFkPdVlDK7CxSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338692; c=relaxed/simple;
	bh=W9gAYG0X9XJxEJUSM37YRKmyz4ctudzKtZ3GvTGFjQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2Pc0JNJB/g8S/CvpdTaHJI6J2GjKcsABs+ap3oM4mtbVh2QjkrfwraW8nqun23VIiT8A1e9rthWnmmRIjN1ZcM3zmQE56gEy9MaBhsYqOCoRg+Pm4PkHZ28wIXTby5FVNTgU0zgEDO/fyr1f0Mmb8bCGOFMxaqBTJAtugYv2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPpJd1VY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPpJd1VY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8520161fdb9so1029386b3a.3
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788338687; x=1788943487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uexc1NDi5NdMn1KWK0fKne2QitDNcH/zJBrubqnXvz0=;
        b=sPpJd1VYYQpNKAjyVIocEPvX84YYKZcX9OaWy7DdVwcpg42PhMNSl0F9M5u4idjUWe
         UsBRj7h1VIeAXv3ZmnJmdQfeHFPzNGeSxOw59P8sJTywRsuELCgmV8FlzJhYdrfFtOf2
         Bc84aLQ7tuc50ktFqWLpLY2+TfkFa5oVk4M/4cnYUs1PCZUo56SicAlodYDA1Yt693Sl
         voDOVrVi93nYa5XFP+S0ihpTzFgH71d1m3W88evia3WH7y2cIRx5NBPRtyJmjcKc49i9
         Y7D6pyuGHXByr4lyBLiMtD+vxv2YSdhYaEaEj6xeUzIIa/OqiRL7KTacho4HRrJoiGK7
         JX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338687; x=1788943487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uexc1NDi5NdMn1KWK0fKne2QitDNcH/zJBrubqnXvz0=;
        b=PL6SkaAGo1ZlcDrCptIyNeewcfU8KgRvP+Vb6Kcbo8MZCvVdr7bzhN7y2STTN1heYq
         zyj+00++ISexjvKI2kDZSOnBHfYzRiERd0/tffJqg1WqMyHdR55SsJJqAfnqTXZ2fzCc
         3FwXwWQbcvWzFpwBwhwnvloP0Lrq0b4XXWBRkpR0azObgdbqXSzPYuOwaQE2M+n07gdz
         i1AvRPo5FEo0Brnvmng2uKLXqnErZ9kuoSZgmGXYFxX+KMayVWTZFBSyfa783P8basJT
         IrtUDSNDKQiuW3bBRTuzL0NAZQVe5mNRawuGeC8cZtwx+sLAZtXE7SQ9bSVU3qSiMvpR
         dqQA==
X-Forwarded-Encrypted: i=1; AKwUvBw1FPEKu4XMMv5EOUB10O7C7Lo0yBhlnzhDyXAa2SpvIN67QgbNPo98X2R90CZz90KwsKRJRA==@lists.linux.dev
X-Gm-Message-State: AFuF++l3oyHts/Tnbp/pbm54IeW6pZkoKtm4yPtKgPVQjCw70l9Bs6en
	Hgj0u9kZPBFq4PeH769sTMZKkmmC5SRE5EtaEQJIO+Xc994J4Dm0FzxI
X-Gm-Gg: AYBFou2+Gkl29/un90faaxl27lGGkMuvjBv+/hWB3koGXGnpe/Pd7ItV21Ebl6J+YpG
	iVJORvF4XIufRXEw6MRoDo6GdaMI/Z1rx6OycPdoCFBRcVB1oGLbSn7TU4ZIHsmFcEBr6J94Ugq
	0yEs4M7pG9Lnp0DF8lSl+mzBxVJDd4NBPNFRZQGyRiQb/93JdyGLLoqorAO7Si9lduaUmbMzunQ
	NpvMbKdkHZ6VZC8KexHK1x26TVhVdGUBhGX3+etoogO5RO/4yPGicDeQHvfkBXQ7Y41qft16ysT
	HtQ3LaB8k5rR7pVvELZW/1zQj4rX9xlY/xoxzKzSf0cAIEQhVPp0jH0JeAiTVzux0jGlpbGSM6m
	Qxg+OivoKNZstDEkaRlXJfhw7AY8UDYORat1rkT95nRTL8YGNAiP/rQP1YGeonrY8S1isCLYcIL
	QNmDqOiPlN//usl5IqyBFKjhD+7habGyFQGFXTZ+zCGx3vAWWfQycTukoO8ndZLzdAbu9jTium2
	PY0yDrOOUJKW6xU
X-Received: by 2002:a05:6a00:124b:b0:857:726d:2709 with SMTP id d2e1a72fcca58-85ed3f6e6e8mr5014011b3a.21.1788338686927;
        Wed, 02 Sep 2026 01:44:46 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db29deb9fsm1047430b3a.16.2026.09.02.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:44:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 16:44:45 +0800
Message-ID: <20260902084445.27170-1-aethernet65535@gmail.com>
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

Changes from v2:
- v2: https://lore.kernel.org/damon/20260902081825.18931-1-aethernet65535@gmail.com
- Changed patch title, v2 title is truncated.

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

