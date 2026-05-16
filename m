Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546B37DEAA
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778965451; cv=none; b=JMvsRcqOi2DkD82jbOBFmo/ad13QoBHrsGmjOze3Xv2W6tYC6ekjCL26Zy5uXaqUmfgIKZg5l9ukGtvYIrP60vnuPbzvV54ollDob4F2guUAMCB6ci4049toNKPkO+2QMAD+LIUNXLNJmiazTslQBfxWfCC772Ppu4OD5yxEbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778965451; c=relaxed/simple;
	bh=A8UrwxnJyTbkNKJFRY/W/SfMc11SJ1ohzLrCgP9cYxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed+gqbHWIf2e1g+BT4UjR14lgYQk2kq5/UnCcMBluNZYp2LZhv84dYVXyjtsO4hsgMWaMsFDCXE9OFu8KoAXDVHH/+QR5/yQxkMKd4+altniNfrV5gCnVLMmx7Er72dajuYtAF0xS3hxeSKrYSGDNKfCM/OoG6IL7WHyr7aE+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmf6lO+K; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmf6lO+K"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so1510240d50.0
        for <damon@lists.linux.dev>; Sat, 16 May 2026 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778965448; x=1779570248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O47MXZLACGVXkwBLvK8wvdJrmJyHZnllVL8QQ770hw=;
        b=cmf6lO+KG8XSZFVbl4fuOa16rJ/HpO4ep5hwP34OrxVq4GFUwy75ZuYoJl7tyK93HW
         u2YcUlmvjypdb6q7ZYYTmBdauO1l0dLoYf85GMMyMgocVWddwoRwps1gUeTb7Hecczkl
         o1hY1EtdKD64BYsw+J8I6MKu92oZduOD8IniGgDIIYMiUzDPsSIbGnit36HxeVZSs3jI
         qJCCtF0BhOCf7KZpQ7YUAZDmPaR/hkuyv0CFFcCm4zkr+lQblGEMBJ0Yra0eU2epWfE9
         3i7Cfl0JOMCGXdqDwEb3DAD3RCXWv5mOoLPVgKZEiwjDi8UbzxV2BpyPPj0rdR0U6K72
         wGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778965448; x=1779570248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3O47MXZLACGVXkwBLvK8wvdJrmJyHZnllVL8QQ770hw=;
        b=CZOg3ullvKHqtuMkxnK8vx3TciBPWhWPXflBZcIdH0L8b30xsRTchti/rHvedCgP3E
         NJN4qJVHXL0q6Q8Vs1FB7szXCHc5c/NJoli4OxwkAD1C/5TR5cEs6lVfbhwQomCgzN+D
         br8LV12bKzFQnxLVBLneztOJtirNyTaJ2KlO9muk0TOaCigrjJjRW7NNxqiwrVq1O3Po
         qi7d06vMbCuD/vmcx9h7GchF3pC0oj5hYW4HtLAr4wUh8bQhKdC8saWYu/zrVukGEJH7
         z4vBqL6PIW2sU54euQzdr24uvkuHQhBkO/fF2N4t3/8GqHjhMPsYMtqo+2SYht/5qgd3
         BwUg==
X-Forwarded-Encrypted: i=1; AFNElJ/cHFQi4Plno2USmbwjCRewqa/90ZgMzrhL5Uhydrrx7Lpa7widY6JiXUQnLgRWge/iOuOJqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwL1tyrPNoGGo1J7gMFTr748mo+BwQUsFJXP1MRndGgypWNGOum
	KkULl6IvN4CuEL6ivNA4Ct9+fKUJEtB/os9ce8JEDwJbfZq89/iP/3I=
X-Gm-Gg: Acq92OHfns55vKIiduY6B24yORnCyxQw6rAbjTEl3rtcPY9XgIaF/uUI7AgPI4Duupq
	pufHRcwKPlE0xPC6zn6bqjuKY+Xx+oxS++6nPQKAaGwRD27nFcKs9iwLY8ZVXryPnuL2sWEpX64
	dAMsRTsFYAPxdA32c0JUHPl3N/6yeyWc2vFfygNrBJodft1B4gizyqnE3jx95AUGe4ivA/B9+z7
	0zp9ofsv37kdZ2jOQY5NPeAgONWu4BGj9NE7MxEIUnN7TzXnKO0qoagU1OYQ6EFmgAn2cCs36BK
	S1fBaq1tdEiXdLi6y2zc3c1B5vCFGRkgdBeTStoXtL8c9vaUjziUtN+kioUiJjQt3JOgiM/vB6V
	4u54RGMLMRmiujROvqWZVWQ4mkucsixZr9E30BffoIy72bhrkIrqOPmNanpE3SBkE7vyVlsGK6w
	qYkwNTXiDReHBL6xLaN3Ycd0lcO0hUrpIB/P1NL3EUlsBQUbYEHcMuJT8qEoHQUlrfvhwIq41Vc
	w==
X-Received: by 2002:a05:690e:c43:b0:65c:1302:ee48 with SMTP id 956f58d0204a3-65e2286ae3cmr9596405d50.54.1778965447840;
        Sat, 16 May 2026 14:04:07 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86bc02sm4342876d50.4.2026.05.16.14.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:04:07 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 3/5] mm/damon/core: floor effective quota size at minimum region size
Date: Sat, 16 May 2026 14:03:55 -0700
Message-ID: <20260516210357.2247-4-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516210357.2247-1-ravis.opensrc@gmail.com>
References: <20260516210357.2247-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CONSIST quota goal tuner initializes esz_bp to 0, producing an
effective quota size (esz) of 1 byte on the first tick.
damos_quota_is_full() rejects all regions when esz < min_region_sz
(default PAGE_SIZE = 4096), so no regions can be tried and no
feedback reaches the tuner — a bootstrapping deadlock.

Floor esz at ctx->min_region_sz after the tuner computes it, guarded
by an esz != 0 check.  The guard preserves the temporal tuner's
intentional stop behavior: when score >= 10000 (goal met), temporal
sets esz_bp = 0 to halt migration; the floor must not override that.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index fd1db234ca304..d33c4360cbd60 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2650,6 +2650,10 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 		esz = quota->esz_bp / 10000;
 	}
 
+	/* avoid cold-start deadlock, but respect tuner stop signal (esz=0) */
+	if (esz)
+		esz = max_t(unsigned long, esz, ctx->min_region_sz);
+
 	if (quota->ms) {
 		if (quota->total_charged_ns)
 			throughput = mult_frac(quota->total_charged_sz,
-- 
2.43.0

