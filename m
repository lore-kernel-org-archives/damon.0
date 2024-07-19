Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CF5CB8
	for <damon@lists.linux.dev>; Fri, 19 Jul 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380270; cv=none; b=Gq4BxUisQFP+tm7OXBzkRIXLxENveUGQoqYi8Eo5XS6eMowxLGupbqPD6KYrhqNvZnkJNrD1ffzbkbWFvz5Z2P6iN8df5VLDy/R9EK/WGTCEXJNWZQN58sU+W2ygsejNz9o8Ndo+REEeCg/7lSeG50bEuGrw59PsfMF9dPO40EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380270; c=relaxed/simple;
	bh=d4vLL2oXw3iUUW1jHNvDr2o/4Yu+fLdYIzmUpoZEC7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swVa3JR2/ddeQSZDDKqXTxRPvlapwFz8/5Veu3HMKE4Jy6AY5hgYup97urnzyNNwxJ/WU12GFf/M2JPF7eNqmmrQnnAVROVsASl2vRg0UMSOp0Rch3NaHgoOjLyBVC2dwS8tAA+eC9PX2NplEAkn2fU/wlw2+/BEGLLsbAQqm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prlnkq8w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prlnkq8w"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc611a0f8cso11780675ad.2
        for <damon@lists.linux.dev>; Fri, 19 Jul 2024 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721380269; x=1721985069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdjuNsU4ostj0/0Bn7wO28Y1aC5KCfM0NOR+CoZUy3w=;
        b=Prlnkq8wUcY2KDiS3lStmmAsQwOT5Oy1I5khJNsV+GLgK2jsDiW9JwAZA1JuuHc2VA
         6GNflG/G1q0drvoeIvSAaRZXURN+BQtiEEv5OhrXg4t3L5yqRmtyZ0K4bVxdGq1o7wiw
         UhKI+hDCdvs1OG+9VZFb1gkrh37Px+tPY2IZsSX0xdX8h6j0Ck1rHB17kBa66WA6YyKU
         Qj6i70dJN5/1WN/TUfc6brpuKxxglEZO2RLfg5HlLKbVVOQzWSO1P1T8j7wx4Ko2hJdI
         7O4fFJqli7CsKdmOyBkQS5R5HsXUXHMuqaj6ZRAcS7FC6KNN00ZrcXTvfwQ2LbrBS1NL
         8MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721380269; x=1721985069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdjuNsU4ostj0/0Bn7wO28Y1aC5KCfM0NOR+CoZUy3w=;
        b=l+n0OL9NnUR0H54L7byW7Dwjxpx/n4Mc6dLIhEbJeqBaCmHha19PGZDDr0gOeiZ0KJ
         KdZYio71uYz9ewbosEerw+m6GgnI/mpebfA1X5Ng40pv1eQn8Ch42G/vbVIzzamqwf0T
         SOAztcjPByRBQpACNWSdoSZUhKhcp1KENhKcKexqtx250hn+rFROxHoLyqB/2M/Mue1B
         G+QF7+4x8GNoNSF132UY+lUcyYOwpjRWjaY7zC7hz7nToJ9iCxBWhWzUshv7ROAuXHEx
         PBplAmuSJLjNci6pjjc3SmKXZnIPfrJimb+fP/Qlcp6VWFOr8EWu1Pb0b0OGkR8KNGzp
         RWSA==
X-Gm-Message-State: AOJu0YzM3yIKJfYn6NJt5GjeiJdC2iyMAVLc+4bE15wSg3NPtJ8OnkjZ
	cI+7CKqU9wFXtJc1aKK7KOQ19zpz/9qDnEdHUisUMgATmwB2mOTF
X-Google-Smtp-Source: AGHT+IHcfEr3jDbOD0qLgShj5xc7X/HykqcTE1R7T6Jbef8j74/Lzf7cwsVR9imGm8KzYTkADY1gtg==
X-Received: by 2002:a17:90a:ea0f:b0:2c9:6cd2:1732 with SMTP id 98e67ed59e1d1-2cb51e52059mr5928717a91.0.1721380268406;
        Fri, 19 Jul 2024 02:11:08 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7735c2e6sm2225329a91.34.2024.07.19.02.11.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 02:11:07 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH v3]  mm/damon/lru_sort: adjust local variable to dynamic allocation
Date: Fri, 19 Jul 2024 17:11:00 +0800
Message-Id: <20240719091100.42649-1-flyingpeng@tencent.com>
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
    mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds limit (2048)
in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
    static int damon_lru_sort_apply_parameters(void)
               ^
    1 error generated.

This is because damon_lru_sort_quota contains a large array, and
assigning this variable to a local variable causes a large amount of
stack space to be occupied.

So adjust local variable to dynamic allocation.

v2: Change the histgram array in damon_quota to dynamic allocation.
v1: Modify global variables directly.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 mm/damon/core.c     |  1 +
 mm/damon/lru_sort.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6392f1cc97a3..ac2b736c9115 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -375,6 +375,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota = *(damos_quota_init(quota));
+	kfree(quota);
 	/* quota.goals should be separately set by caller */
 	INIT_LIST_HEAD(&scheme->quota.goals);
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a65c3..3b417e413bf2 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -148,10 +148,14 @@ static struct damon_target *target;
 static struct damos *damon_lru_sort_new_scheme(
 		struct damos_access_pattern *pattern, enum damos_action action)
 {
-	struct damos_quota quota = damon_lru_sort_quota;
+	struct damos_quota *quota = kmemdup(&damon_lru_sort_quota,
+					    sizeof(struct damos_quota), GFP_KERNEL);
+
+	if (!quota)
+		return NULL;
 
 	/* Use half of total quota for hot/cold pages sorting */
-	quota.ms = quota.ms / 2;
+	quota->ms = quota->ms / 2;
 
 	return damon_new_scheme(
 			/* find the pattern, and */
@@ -161,7 +165,7 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* for each aggregation interval */
 			0,
 			/* under the quota. */
-			&quota,
+			quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_lru_sort_wmarks);
 }
-- 
2.27.0

