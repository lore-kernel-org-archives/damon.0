Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B471448DD
	for <damon@lists.linux.dev>; Thu, 11 Jul 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685461; cv=none; b=BpyhtoAQd+LiMkf6PnLxuMHQGnr85wKjcWhFhjIP1YFQDNUL4GXh74Xq5Cuyv5XigtLbjR/1dSepNhcoHYdxNn6XrrLurApq4ic+mOiV4+pBy9nnGx7t+3H1E5dR/rBWx1ZB6i5Mrcb0aGroy8eDStgWfU4XK3gN50cVHWFh9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685461; c=relaxed/simple;
	bh=/rpdJR7Mdlwmaq2sjOJBMv/uPOZ9bC99DErZtWurLW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BkNfTXkFNOy0b+N81olICEXZnRRQReC5RD6D+lpleTLc29SZtzxSGBoUk3wuHnAcijPcjlEUNFwZSBVjyD84x2FkIsKvQbSz6s0m6Fgev0CgZWwE738VgiOSmeeRL+A5iVYsuJewEInj6omCn+i2MbAJQKJF7P9VMNhoTFLQtD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI6oFTkK; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI6oFTkK"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f6e9662880so28837339f.2
        for <damon@lists.linux.dev>; Thu, 11 Jul 2024 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720685459; x=1721290259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3JIwtNQH+B8K8273KE0v3wae0sdslV4dTP6fUvBIf8=;
        b=WI6oFTkK5Chqeeq34mahI4XTKkPdZbEdvLFo/fH09k5idaxigvvRmG2Rf7j7vMzgOp
         kzCtPmd4H5rJ+Jb+WMfEhfpNKEas6Ed2nKbgtMz4LcU/29RLH36nv4FXC8XM/x+i0T9i
         ImJtaXS8RWLHtXQge7QfeBKbBl+wDhnhshIAW6Y/HD9gWMLUp+jPVhvHOBWBQ2ZVklZW
         h6Trn2IPbUhuZyIqGnZKz4gqF3WGGSe5OXJOjQoOTd1gBh46kFoqyWQjukjShSi2vICM
         cphHLUzmVQqHx7tUnPB894zrBy5TsO85xKLMgP6Jdtj59VGNluVpM6iVg4zD9Ln5CeWK
         v9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720685459; x=1721290259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3JIwtNQH+B8K8273KE0v3wae0sdslV4dTP6fUvBIf8=;
        b=hrJPaU7QMcm82o992dm6RteJcrKggxmqYj55N6ith4BAWaGH+e/ZontzAZkrHyi7wF
         /5wzPoQuXPfKYb0B1Dez2YxVuxBzVQMTyjRech+qY7+suD+OXvdT0yWoi336dSMU3cm8
         hY/oYV8PlLeHjaLPKr1V3UsvmXS6I0nJOgMWWJQzEMO1X/ZWfiswcHbhgpc+/fNzJJAr
         xSzuYZgqZJqObI4x8O+k137qKLc5KWTw1S+QY+j5EfPP/7pDLLGCyZfuIexGonle4mOG
         s7J547wegrArDfxkteUVF9qxRy7/FgcqgYDMBnIUuEf4ZU/vdc+UensEVQkD9CG0fgN1
         1rQg==
X-Gm-Message-State: AOJu0YwrdQTpVNNFD8MUmP3nGtCEO/q2lK1ZWfHXajK6kLoMbZpv+IF6
	qV9DFaIVcmaMnKBo/vHRgtEX7XF6FM36utdBb6pZ+1IH9718z0js
X-Google-Smtp-Source: AGHT+IFefhehruPjYY/dVvRmJ+rWpeZ/N/bCtpYyX8qoPTlV6ijHpguRrZAklGMVQ/nCi5XM7ODKrA==
X-Received: by 2002:a05:6602:3f8f:b0:805:2e94:f21f with SMTP id ca18e2360f4ac-8052e94f428mr518289139f.2.1720685459195;
        Thu, 11 Jul 2024 01:10:59 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c7163sm5060325b3a.86.2024.07.11.01.10.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jul 2024 01:10:58 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH]  damon: using pointer to access globally defined structures
Date: Thu, 11 Jul 2024 16:10:51 +0800
Message-Id: <20240711081051.66560-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

When KASAN is enabled and built with clang:
mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds limit (2048) in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
static int damon_lru_sort_apply_parameters(void)
           ^
1 error generated.

This is because using local variables to obtain some global structure variables
takes up a large amount of stack space.

Changing to pointer access can solve it.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 mm/damon/lru_sort.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a65c3..357ca0b1b7c7 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -148,10 +148,10 @@ static struct damon_target *target;
 static struct damos *damon_lru_sort_new_scheme(
 		struct damos_access_pattern *pattern, enum damos_action action)
 {
-	struct damos_quota quota = damon_lru_sort_quota;
+	struct damos_quota *quota = &damon_lru_sort_quota;
 
 	/* Use half of total quota for hot/cold pages sorting */
-	quota.ms = quota.ms / 2;
+	quota->ms = quota->ms / 2;
 
 	return damon_new_scheme(
 			/* find the pattern, and */
@@ -161,7 +161,7 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* for each aggregation interval */
 			0,
 			/* under the quota. */
-			&quota,
+			quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_lru_sort_wmarks);
 }
@@ -169,20 +169,20 @@ static struct damos *damon_lru_sort_new_scheme(
 /* Create a DAMON-based operation scheme for hot memory regions */
 static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
 {
-	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
+	struct damos_access_pattern *pattern = &damon_lru_sort_stub_pattern;
 
-	pattern.min_nr_accesses = hot_thres;
-	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_PRIO);
+	pattern->min_nr_accesses = hot_thres;
+	return damon_lru_sort_new_scheme(pattern, DAMOS_LRU_PRIO);
 }
 
 /* Create a DAMON-based operation scheme for cold memory regions */
 static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 {
-	struct damos_access_pattern pattern = damon_lru_sort_stub_pattern;
+	struct damos_access_pattern *pattern = &damon_lru_sort_stub_pattern;
 
-	pattern.max_nr_accesses = 0;
-	pattern.min_age_region = cold_thres;
-	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
+	pattern->max_nr_accesses = 0;
+	pattern->min_age_region = cold_thres;
+	return damon_lru_sort_new_scheme(pattern, DAMOS_LRU_DEPRIO);
 }
 
 static void damon_lru_sort_copy_quota_status(struct damos_quota *dst,
-- 
2.27.0

