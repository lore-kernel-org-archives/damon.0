Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA742CA9
	for <damon@lists.linux.dev>; Mon, 22 Jul 2024 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721626242; cv=none; b=AsEHcjJlycONETk5fY76xiq7FwaFUQ+wx7BEREXSyRFbV0vDCxk8eadv8rZt8ZX8dczY2ThkpiVFhD/VC7AZYjDIDvBzymPhn1w6HzuX9tcwmz6cMWzGMeed8q474PxFnSOrfaZq4OyfbO9bOEEnAnfZ6bBl5yj0BN5i38REyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721626242; c=relaxed/simple;
	bh=AEGzARfpZE2ip1NhmWFqsReu0tF98ycfzOOjWu0u/PI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oLmcRNP0Ao8f0xcItjIEvzYfzyzNOAwr72ustekeO7lCW8DeD/+hGqLbEHjY+9ZCbF5Zj8vBeWTDp7z5h+oyLjf9RjLyGvbzvgP2XV6+BceV54EH3L6KvJSGPAMFGhXfV9N4TuaQClbmyyzOcPwTfCrAt0awG8gcoXbm/xrcGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBOC59+4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBOC59+4"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb6662ba3aso2203748a91.1
        for <damon@lists.linux.dev>; Sun, 21 Jul 2024 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721626240; x=1722231040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNhtdqxoo2IfyTNKdIZ/FoFE1ZAVM6WgQCsH439Eg4I=;
        b=DBOC59+4OAvRG8/zwW+vPvg0dwq8dWSPxr5NZBjfy+ruM6R0gmVvJFmHH7P8VNT/nJ
         uJtQHJpG3ga0p9rfKAekjNumqbKKPdr+u6xGWds9rSK8b8gCJscfDKaXry1OWXE8e84K
         gbpxF8JMyvm9FS0/APGwSgMnnLN3OG1k8jiau9hFoieJ4YqVR4FuACmL6MxYQwbR4QBo
         xTObWFYRMqyOdp9ifNapSHk6n78SA8DuEbBiCz19s89u3m/SEAelNBs27VOaxnFnk+Qg
         E8KFEp1CWg7NYyodBGj9unVmNcDLEM8v73r3B4QbUEso/AtNjw9oD8f02JZIJLli+Ay+
         82vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721626240; x=1722231040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNhtdqxoo2IfyTNKdIZ/FoFE1ZAVM6WgQCsH439Eg4I=;
        b=I8QlSZc6CQRHdIhjlGuOsVIzMX9JLxStlNtC8KpGoxJLxnVSkgbSI0yLccJRPSOmmq
         O3SIzGy8r4NUpbuBFPIYyGDlt/mHN3qXNzAZYrG2vUMHWgrn9ZacxmZsEFOaE0LM7Bra
         vX0XCDGOUzXBoQAGhvp96rp4oGDcomqcYQWMKxVPWJiR+TOBOW2X2wTyN6GMRitjlM5x
         OKD8eRoc7p4z6CJkUQgZeU6GTGrhdBRvf65ILLvR2iGJ7CA3jd4Z+BA+lqZUJEB8RVK/
         z3txhNSWFXJM+hhiLbMNNRtnncyjot62QEs1ovnpS4+rAxW4/2YKIn5a1jOLGgQgGXnN
         pPQw==
X-Gm-Message-State: AOJu0Yz4XGvqLTfzuECQIroQ6PRnKyxxkRB8fItfHpefvNO2HnLn2V6s
	a31kYwPFLgwkRHG6EvXLtFNKfY6CH72En3lt1JD8GJam7dkBnGVm
X-Google-Smtp-Source: AGHT+IHs9NXUYBB74L7tj/U5rPdfdHHZevr3yX2nVe5Htr4tN2dzfFgI7NBDLp6aM+3cgYN59etmTw==
X-Received: by 2002:a17:90b:2303:b0:2ab:8324:1b47 with SMTP id 98e67ed59e1d1-2cd170c92f3mr11162545a91.15.1721626240478;
        Sun, 21 Jul 2024 22:30:40 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf808efe8sm5972656a91.41.2024.07.21.22.30.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jul 2024 22:30:40 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH v4]  mm/damon/lru_sort: adjust local variable to dynamic allocation
Date: Mon, 22 Jul 2024 13:30:33 +0800
Message-Id: <20240722053033.92453-1-flyingpeng@tencent.com>
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
    mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds
limit (2048) in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
    static int damon_lru_sort_apply_parameters(void)
               ^
    1 error generated.

This is because damon_lru_sort_quota contains a large array, and
assigning this variable to a local variable causes a large amount of
stack space to be occupied.

So adjust local variable to dynamic allocation.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 v3 -> v4: adjust release point, tweak format, etc.
 v2 -> v3: don't change histgram array in damon_quota, dynamically 
           allocating local variables 
 v1 -> v2: don't modify global variables and change the histgram array in
           damon_quota to dynamic allocation

 mm/damon/lru_sort.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a65c3..57bcb3b531ff 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -148,12 +148,18 @@ static struct damon_target *target;
 static struct damos *damon_lru_sort_new_scheme(
 		struct damos_access_pattern *pattern, enum damos_action action)
 {
-	struct damos_quota quota = damon_lru_sort_quota;
+	struct damos *damos;
+
+	struct damos_quota *quota = kmemdup(&damon_lru_sort_quota,
+				    sizeof(damon_lru_sort_quota), GFP_KERNEL);
+
+	if (!quota)
+		return NULL;
 
 	/* Use half of total quota for hot/cold pages sorting */
-	quota.ms = quota.ms / 2;
+	quota->ms = quota->ms / 2;
 
-	return damon_new_scheme(
+	damos = damon_new_scheme(
 			/* find the pattern, and */
 			pattern,
 			/* (de)prioritize on LRU-lists */
@@ -161,9 +167,11 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* for each aggregation interval */
 			0,
 			/* under the quota. */
-			&quota,
+			quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_lru_sort_wmarks);
+	kfree(quota);
+	return damos;
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
-- 
2.27.0

