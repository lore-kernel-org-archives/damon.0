Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA54BA1ED
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769505; cv=none; b=roS2O0yvtBKt2m+MLad5AXXsWQ5sUhcYLUzuyj5P5WMnZb+2FrIAm1clCxwPAHpxxGAEP1vUn86vOoPugx/HJH63WvCpxeyMnKG8bHiI0IaiMd+shXbMAwSYhGeduqA0ok8Hz2wcTjraTCnvJeKA7hpwmygt+ude7WqqMIh3ajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769505; c=relaxed/simple;
	bh=HmRlEKvsiaUzaGJNjBp6Bt9PpaxWq+TWrDMAI5HRAFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfuPJ671RzFJ0Rh/3rodfP+7ToIatrb78HvytCaI3m1ExMUxvkt+Q5gsc5TlvQwnqdnlGTrOtvnpB3GX9dZevlMR6qW2CArYQnd0hmjb2SdDqDZ7F2cSk3uGfpmeCSDPl/4jbM2m90UNPvEX2D48Yyg8bzy67L+wMGYnGEhIxIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnDLVuuM; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnDLVuuM"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48afbc2b18bso488140f8f.0
        for <damon@lists.linux.dev>; Wed, 30 Sep 2026 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790769502; x=1791374302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhTlHttBfOfSCYbgzOBqnm1PlGqLGY0jClNl8O2m0Co=;
        b=FnDLVuuMHTJVlk19uPGD/fcWKpvCFwhUrqu654UJ+PPNtyagITiDwA1cTnGW/lU5Is
         lxEsu6DSI8oWWWMxPInwpusMJDEbjCnCjkwQiLIvFgLF0K8zHuSWkVCO/jQ+KoPz0Ftb
         BV07PN3elUy4C07p4vsCYg0GGuu5csRPFe5f6/BYfNnBPpvMzGRbGXIk5fBnx/O5jJMz
         RORbLgDZvKrhMKdx+fSUCoNZJcK8X5ZsF4DCMuZEuQ24W0bJfPJQom1KtfRxFyeAVw9L
         q3oqzjWV+jbMCRL6XRnbc6v3FeS6KiTbQgQ1QB5LpV9kVmNyyFHMXr9blTGmnHjlB5Lj
         slHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769502; x=1791374302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhTlHttBfOfSCYbgzOBqnm1PlGqLGY0jClNl8O2m0Co=;
        b=upEBUscB579iJWX9q6RPolNVCxtSesgACsxU+ClrdhO6xjPt+uEblzxa3H58OeDLlm
         kpoE+GLGLx1oSae5ShX+K7qCU24iDCgxps1/0u3WoP2i0eG/QFOtgCBD8Sa5afS0fYTl
         sLSDlT3DyouXzXXntdsVifE9ilOOTVWL5XMgNVw3aXx4sCxP8xAhBmRD1ZYrxWLAQn8v
         Ya/9R9719pd7EBS151XE6ydLf/La3BPVT5KyhbSfLBDtJW1rpIzdtNowIXwO3ciGggsZ
         7P4hJdOMBgntl9np4LNKHkXrhiNa35n+kNyKVY+Lqmu3B9kPEYF53ZiwixH7AHqwFL/z
         XpEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOduS3HoEEkJc2ROW3/PwUOzYf2WJMl2V5geDlEZa7pDrO9OLJhpibjXVAIPejNQm7Ab4LvA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIJIxiv5FZawwry8MGDm3LmM+2BQIvOj5Nidt2X/B0gBPLgeY57
	wRb2ZpUMV3MM3dGLZbbLgTjK4ObLV6SNSa84jHrwQQGpMMqwzNJgXz0L
X-Gm-Gg: AYBFou2SK6AKwnBUP7JbIx3x6hMffDxI/wKUo1Uem12iwLDzRr4e7Etx8w15KhCuyuk
	skOvnmrd8BIfUPaV83OCSRdi6zKPdyjyeVOcITovln9Qno3dDqdDww67ewrFUaCv1yZHjbKnANy
	xe4gfgHPavz9U8NvxAZbpwjguqPIeD7DsQXBSpmTHWqKhlJoaF1a2G7KT7p56o589HX0wvRMsJW
	59iDk3jaqctLJh5Ca/02dpttd/ziLBJaXYQXOcz3q4h97WZlh5Wu7mrbt+hnyyhhP08fyTQouXw
	cThhwjMlwuEoVudoyx6kyD7tP2FIkMIDWp8oo2sdtOTJFmL3/KO3XYG0Awrdl8yfwWRaoIlrIDA
	CN178ESKrdNbIcP2K4AnUxjL/evSIVrzmtj+yDNtj8i0YMXm5SoEQyOBffdBZfhacEaAg/cNy6Q
	t3xmMZCkOCHD0JaXUK7eFNydplDKb06KnG8MWWdv8vx/msHpKRGoOH8NFFMhUcqdYlKTqO7Oh67
	2KrkwbTqGrOW/0jmFpXYGXAl9oZPUki+ItY+jcmVPOFCUB6xg9jjScmUvYIa9dYZriWLJIdgK3S
	UTMgmOcBQGZ3rvwA/IeLXsIXTzVeX7BvMw==
X-Received: by 2002:a05:6000:2888:b0:48a:f486:2f4b with SMTP id ffacd0b85a97d-48b024ea6dbmr2815254f8f.19.1790769502098;
        Wed, 30 Sep 2026 04:58:22 -0700 (PDT)
Received: from lima-kernel.telekom.ip (84-115-220-212.cable.dynamic.surfer.at. [84.115.220.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b028b237esm3334148f8f.0.2026.09.30.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:58:21 -0700 (PDT)
From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Subject: [PATCH] mm/damon/ops-common: fix age_in_sec overflow on 32-bit
Date: Wed, 30 Sep 2026 13:58:12 +0200
Message-ID: <20260930115812.138864-1-jaeyeon.lee.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_hot_score() calculates the age of a region by multiplying r->age
and the aggregation interval.  On 32-bit architectures, unsigned long
is 32 bits, so the multiplication overflows once the age exceeds about
4295 seconds.  Then old regions are scored as if they were young.

Fix it by doing the calculation in 64-bit arithmetic using div_u64().
Also make age_in_sec u64, so the result is not truncated back to 32
bits.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260623011652.1354-1-sj@kernel.org

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Assisted-by: LLM
Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
---
 mm/damon/ops-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 77366f42b3e5..7a7429359dc8 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -164,7 +164,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s)
 {
 	int freq_subscore;
-	unsigned int age_in_sec;
+	u64 age_in_sec;
 	int age_in_log, age_subscore;
 	unsigned int freq_weight = s->quota.weight_nr_accesses;
 	unsigned int age_weight = s->quota.weight_age;
@@ -174,7 +174,8 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			DAMON_MAX_SUBSCORE,
 			damon_nr_samples_per_aggr(&c->attrs));
 
-	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
+	age_in_sec = div_u64((u64)r->age * c->attrs.aggr_interval,
+			     USEC_PER_SEC);
 	if (age_in_sec)
 		age_in_log = min_t(int, ilog2(age_in_sec) + 1,
 				DAMON_MAX_AGE_IN_LOG);
-- 
2.43.0

