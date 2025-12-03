Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33677221555
	for <damon@lists.linux.dev>; Wed,  3 Dec 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749104; cv=none; b=BQCMQwpsg1syounx/kMXFejVFcNFCP9zg2fnsNVgrxK5ggM400TmwbD0b16E4w6jpefRriLZ8RBtm8fsRGJzuWC3nmNvx72TfbO5fqf1yaXY5PfXUnC7t71+vypVhUGEeSfFgjJY1CSM5Avmy1ylKjEDkFf+SOcTjb/BgYK4mVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749104; c=relaxed/simple;
	bh=W1n0AeaetZUL8pTtc/RVjiVYj1lt3369qAgFmxMyL8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDvCIbgxrxLD6cRgz0m7d8d+UaeIV/Ct512B7i9wNrw+Tsp+hE3+Sk59wCGQLRM9OSlYN9gLdBnGNVvU7ctN74LsbdmZ+vNySGYKB9Rc5gIEkvoRIzzgczYfdnj9WCK8BAcjKC3blxtIsY2DWakUsc6WuZ9CMPWhDBEflQpS6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpaobuMh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpaobuMh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso9887212b3a.1
        for <damon@lists.linux.dev>; Wed, 03 Dec 2025 00:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764749101; x=1765353901; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9a/AxV+wC8jwsiLQBhrbX+GTyTSM7uRmBDhsxzqnBc=;
        b=fpaobuMhV2sK/54pC79bzgwFpt/iVzkE3HF9HMdmqe4o5z6J96sHU5lJAocU2YE9s8
         4bLkqhpu4U01wZXv1L+NEiBlG+Ce5ZejNXMgYCzqJu7Pq6YQ9CXHX4jP0LTjif2sYW7c
         oEujSOzD/EM8P816DPjpd1VBQfFndoGdCfr4PTO0IKLpi3Xs9kN4fyjyGBGXcUFZc+sv
         rqOWD68pTxJRU/Wv1JaeLv//ZYi5oTc5FJ+6K2dR6WABDFNSjiBjhJ0VzheizEaDe3Hz
         iXXBvbd9H1KGss9+Y9Yq3be3EaDz+sTlKmyCiT/HFih0vpCbSMeUBYELXf+uE3fZerIJ
         +35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764749101; x=1765353901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9a/AxV+wC8jwsiLQBhrbX+GTyTSM7uRmBDhsxzqnBc=;
        b=frExL5D30BCAwIXL9jw4jZ7ViCy1SWjn2DuTmU9Z4fQz+mQXYlQ1c16VmJNtxUVFOs
         W+m/aWmbvl0425Vx1y/VgaazJcTtxx7wX1msMMiCEdHxf9FCMMiF0Slz+KM+wAYXhoXx
         DhN8zlFyMaNxnaxOdwUup3eHpDUF/wiNEY9Xa6HSvdejCNba+bDYCfygezmuVa7pYQkK
         vAViM9RG3GqQUBI1qkDHclEpI7YwnLF2Ei3tyko0xTbxMhv2fAcVtBMORcaXDq/sY2EY
         8elVIBiglbzz8CU1leeLEoZ5u2mCxfKPvG0o0k7Dg+LnsN4U1/xT0tEVooF7Y3NZm/SM
         h+bw==
X-Forwarded-Encrypted: i=1; AJvYcCWDga38rxbMgxcTukMPhA6y2HOGSiI6dSvQHNHZ7+P1lLJeriyS45suTJO84nf8Z2dGr/gNhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIae1ttwkR2rhgePC3/0gLK5KCjosWdxD/QzT8aEkKGDYCSrcr
	GqLH2VW2WtBiy+FtiKQRijPUQWzwUC46G/TXRJ5Q8/vxCiYaQP/PWELk
X-Gm-Gg: ASbGncvY9NqbtfWnvR5s9X1uXCtJ7pRXh+xq2sOY9tJlj8TVenOuhx18WFQBblCxp4Q
	JxqGDTW4X41mevnaYwqPPodyFUhgmL/JSjxgVB4lalLXoLljqaqhdGEnCW2FHjdd9BYtxgc2diA
	AygW2OmCJH+lAPvb5aMQ3mRp61TEV5R+IfX/z2hwsSJv2y7muIjZd60+mRhFEXhWw2i/rMhmNva
	gibkEh6zCQMP8ybwmGwTzi8BeT2HE4Au8bJgLVjAJ47asDFR7vdv5ZtaYI3JMM/a4AkgrU7zp8T
	X4F2TCxWPkqbS+mic62n22PkcdEZ+d+24dztu9iJltr420MiNhVH4af147dwFTm8u3rNjdmdDuh
	V3Hm+th6jX2VXAR4qzABL9iQqkc6BD2G9YvDO/wABnEuIERLZdwimpXOEAHVVFmUvlrQXsDXL72
	hppgaNO8FOSfL1
X-Google-Smtp-Source: AGHT+IEKnfRdlKVBSs8FMLtPg066nv9w/0bsZDbFhrjOTm0rk01/YNwhJ9ucFUGfG3SebblIOnE7gg==
X-Received: by 2002:a05:6a00:2d04:b0:7b8:bab9:5794 with SMTP id d2e1a72fcca58-7e00e3b938bmr1721264b3a.26.1764749101329;
        Wed, 03 Dec 2025 00:05:01 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7d15f9260a4sm19331963b3a.58.2025.12.03.00.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 00:05:00 -0800 (PST)
From: Jung-JaeJoon <rgbi3307@gmail.com>
To: sj@kernel.org
Cc: Jung-JaeJoon <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@naver.com
Subject: [PATCH v2] mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
Date: Wed,  3 Dec 2025 17:04:33 +0900
Message-ID: <20251203080440.16096-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_stat_build_ctx() function sets the values
of attrs.intervals_goal structure members.
These values are applied to damon_ctx in damon_set_attrs().
However, It is resetting the values that were already applied previously
to the same values.
I suggest removing this code as it constitutes duplicate execution.

Signed-off-by: Jung-JaeJoon <rgbi3307@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index bf8626859902..51dd29685915 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -173,14 +173,6 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (damon_set_attrs(ctx, &attrs))
 		goto free_out;
 
-	/*
-	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
-	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
-	 */
-	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
-		.access_bp = 400, .aggrs = 3,
-		.min_sample_us = 5000, .max_sample_us = 10000000,
-	};
 	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
 		goto free_out;
 
-- 
2.43.0

