Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A613F4DD0
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468090; cv=none; b=nd5lo1/4OkXq3qaM1JGxSwM0ADj9VY2hx2UWdhpg1dL5Gdi+VqnuB6+7DA+JOpsBuP8VCE06Mh8gRYswyfeoTmZ+qeiHeAFDuzNzWZd1hQi2owdxViOVBaPiCOC1oVX9T78CLl5rD1tjkgcbuYX8prMfa0z9ypstL4EbhrstUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468090; c=relaxed/simple;
	bh=1/d9/1GHfWEox65oqmtCNUQIlORzo3GAgvRVXrIJF7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIszLTtPciYX3mW2iQbvlxLwWXHmR1Lo+IXZOTn5vegs8naDlT3ulyC68N3eGsbqzsO96/gw3A9Xc/a0gHECvVtnPEmaY6VOPcI02mKx2AOXqzQg6KPwaJ05sLLiJMpVZwiJYRhfQFFkM5yXTFD8jrHCWeW3myUXgoQrZZazjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMOa7zs0; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMOa7zs0"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35601so1584093b3a.3
        for <damon@lists.linux.dev>; Tue, 15 Sep 2026 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789468087; x=1790072887; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2tI49ctpjTzkTcRuvF4mjqLd2YRMswe7/M8Hsg5gl8=;
        b=oMOa7zs0YlDPQzmunbQKyvzKGrPBI+FU9JV6hNd3Ugxm2/fPfLjGLGyDo+jcQ3uOuI
         hf6wSPoXlIY8PtC+lZ5RcsYWG4RgPVvWxqJBqi+FS+Wl8LOojcvmplNIBJjYE83f+ILW
         qytyjd3ehm1eQJmeWnhsxrdeWEWyycv1wd7s8lEOLWp7aM7qB9Bo3Pwt4Arh/OQ35LoF
         rJk+MvFU4nIV2rPEhgKssFEMlE8ahy0j7NG13yv/yZQtpv0Q6TXRNkJf8GUL2iRjtQYb
         rnkE+RMimB6pnMeHo82dO+U/YeOaJEhg55xcZbNtoYAuhnk35IkOEJQoLm8KttSMAvIg
         LRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468087; x=1790072887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2tI49ctpjTzkTcRuvF4mjqLd2YRMswe7/M8Hsg5gl8=;
        b=OL6HaSyiXFZKboOm6e+LDvSL5Ag56lQJsfH3JgKQShLS3amDfEvLOurk12PGuU1J3y
         EEd2MjiYPhWTlxF41ko5BkHerRjxw5nlAEbUJW7Th2MGPVKSFD0qKZ6pxejw+MTvcwk8
         uMvukM6+kpKxuW35JUnSGw9bRu+TnkLyv9WlJ8yKyxIgyOUz5oGf+M3sfXmbFSeRYKuH
         NGF78kknkZryPCEaLC/f+EaMXHa1+SIVyRv2hSIcQUUyVorPb1cnG+Q1d2MYQpjERhxP
         TYQT5887bVLuYFwkdLopl35z2au0tSXgtDKx+QwUQlbSYjarwl9Ut7BgITuqlWhhuowT
         qlyQ==
X-Gm-Message-State: AFuF++k8PxmqGtPXfXA02xThSe6i6UJKmD0bC/ErBeT1tX6463I41uWa
	zx9/YgUgSIW9XAy2jlDTOlOLwSi2k4Nu5p/G1isUteXGY+wGOzm9uXttK8P5K7Dx
X-Gm-Gg: AYBFou3JWP+m1jVxD5shkaIJAs6pMtv+WdOfJBT7ZKypMOHhLY1StkrP9f8321ESFzQ
	2JTR25aqCvk60KKgnn9dobbKWHhoWTIWgxzQxh0YuhOY1im1cN9WFmCZmI2vOQ0ElAF8/vJeAh5
	iMEie6tKGk/Sh4NgMoi2LEuDyQUGjUN0lmgrBhWIppbnXm8RBUCxRiJ0sCC3w15KWzIJQtyl1Q7
	Mxc7oonwtmgzp8jtv/WUCtFE+P/rQAH4TeWNINYb1FKhR7ovWocrOQcFJhIluYPHrJ7PiplnaCh
	DyriFT+2yW8vGgcN0xJA4cdpzDZPuvtaMC25sElKn27SiWgEa/7IvL5znV9tOH2augqIENZ2r7f
	glGs/7dTy3eMoOGgHDD9OGSlsudrsAbbj1/Vii9tjCSU6QvF15gduYirPOQCjGPXR+3Ey8qnFe3
	UvYBwDpzLATA3ziAdTz7rkOJ/hQ8iAH7d08L61q9U5VWQceshN22MNOy5RYj8otW6oNDFBAC/8x
	WyrnqCiNZ2m6SSznPc8fmk35mvk1FlKf2yCUsH/PfdgC7/yq3wIy+J8vUogHb/pDoQmtvBDZpxF
	WOo5XCbtG3KtNMTK
X-Received: by 2002:a05:6a21:1014:b0:3d3:ad3c:49a7 with SMTP id adf61e73a8af0-3db4061f373mr16009374637.21.1789468087368;
        Tue, 15 Sep 2026 03:28:07 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6572ecasm6465344a12.22.2026.09.15.03.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:28:06 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/1] mm/damon: fix typos in comments
Date: Tue, 15 Sep 2026 18:27:46 +0800
Message-Id: <20260915102746.647-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling mistakes. No functional changes.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 mm/damon/core.c     | 6 +++---
 mm/damon/lru_sort.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0c98f7e267d0..981a153619c0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2447,7 +2447,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
  * This function checks if a given region should be skipped or not for the
  * reason.  If only the starting part of the region has previously charged,
  * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow, and return true.  The
+ * area that not charged in the previous charge window, and return true.  The
  * caller can see the second one on the next iteration of the region walk.
  * Note that this means the caller should use damon_for_each_region() instead
  * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
@@ -2613,7 +2613,7 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
  * This function is called when kdamond finished applying the action of a DAMOS
  * scheme to all regions that eligible for the given &damos->apply_interval_us.
  * If every scheme of @ctx including @s now finished walking for at least one
- * &damos->apply_interval_us, this function makrs the handling of the given
+ * &damos->apply_interval_us, this function marks the handling of the given
  * DAMOS walk request is done, so that damos_walk() can wake up and return.
  */
 static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
@@ -4143,7 +4143,7 @@ static bool damon_find_system_rams_range(unsigned long *start,
  * This function sets the region of @t as requested by @start and @end.  If the
  * values of @start and @end are zero, however, this function finds 'System
  * RAM' resources and sets the region to cover all the resource.  In the latter
- * case, this function saves the start and the end addresseses of the first and
+ * case, this function saves the start and the end addresses of the first and
  * the last resources in @start and @end, respectively.
  *
  * Return: 0 on success, negative error code otherwise.
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index ad8e86dd3a93..273efa3c913e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -260,7 +260,7 @@ static int damon_lru_sort_add_filters(struct damos *hot_scheme,
 		return -ENOMEM;
 	damos_add_filter(hot_scheme, filter);
 
-	/* disabllow de-prioritizing young pages */
+	/* disallow de-prioritizing young pages */
 	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, false);
 	if (!filter)
 		return -ENOMEM;
-- 
2.43.0

