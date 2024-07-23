Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696D139D04
	for <damon@lists.linux.dev>; Tue, 23 Jul 2024 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721706922; cv=none; b=tvPNVtEx9TSFX6+/bo0uV30mV40CbvOCMxHi7JOpT74E//OkAVI1vHbznVHjgXYJ3tq3f1stRi5Kq6p2tZ8alQZYB4hkKwddSRculH77FlBuTqT811k3P3ETb7BQ2rIj6FxmQ0EwliDgscEMs/ekDGLFMk8ndQSaSgrYNJFcHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721706922; c=relaxed/simple;
	bh=2HeMVEV1L4ZGnsfbi0DLQ6wLcP2BNx6k3oRbGb1XtLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WMwR9X0vc32dYjbgHLKppLpOn4lhVpCtc6GEFt1oFs379GIlCXXWO35hRIkE9CmnlOX/oShrlWVxvsGtfQlwAbiFB2JqzhAH8uY7fyS486IvViCKa2tMSKdWXtAKDJWeqGe9rdAQOvr2GDLhZxBpnxwW41kwafR49vgkb28VUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMlepPhd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMlepPhd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cd487b5470so963929a91.1
        for <damon@lists.linux.dev>; Mon, 22 Jul 2024 20:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721706920; x=1722311720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2p0RnXBXScYnMr+fs4pThEFf34PIi37xwRHTjB7LssU=;
        b=BMlepPhdFtxE0zCy+GpgybRoiK8JGhaVKCThwxZG0atrObWQ4SiCeEgdo/kVvV/fu8
         kJ0cbpwlw/OuVa6Q5t0ETUIs/nH2z/47bbeGxqjZt/vwLzX4L8lcNVfBPyJK9+uKeqcB
         hfSWTRkUgmRODjwIiAKojWrwEqQ2Ag85d9xyClEUAew2nXk4HtYiCuxTvnucq92TgaTt
         YNr2U4dH6WGim8CeZKO4mph9C+NzQeLrx5m0XzIe7oBEjQxLOBqlxyVRJNImjHjqkBHS
         yuVaZLIL2J2A6qu6pygDYIKjbbpM9ZvZxGKGcFTO/14Qo4KfoWbpvESiBtHQSd+vKOBx
         6diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721706920; x=1722311720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2p0RnXBXScYnMr+fs4pThEFf34PIi37xwRHTjB7LssU=;
        b=Qh0r6655nkAp37uteP9fp9w7B0MHeLgWhdlsu0mWzsmIbK4Va+9f5sWvqk6BLuVTPi
         SlJzpyRz4kA+bUDZwyEg7NG4NwMhLiAlMuz3vJ0czlZ30BsZ+rr74SwFy4wTpqknA7ml
         qOhIxvsB5eU1zGGPEpQg3MDXoSuSMRqjFcFgeon9sDmim7J8RJnqATQJ4rjbiCXnTW0a
         g7WwkvtCrqCxKINoLz3GXsJOJsvsJLjQtAyNn2F189NYITMhbTwJZYW7mC9yAnUbFlGf
         9MAYesSoF+EwYF0bIMiODYUph/d6Qwee/Kapla0lD2AHi8Sz+sYKkPWr6czbElVxyE3e
         mm5A==
X-Gm-Message-State: AOJu0Yx6Q0pBFTISulC4eOg4wTzPS0wvVUVelcotmdIqJBJggYe9hMco
	6TFVFh11Xe+x6rfUIzJFiSfVoeYSc8zG5h6Hpsjkk09/h+/012S7
X-Google-Smtp-Source: AGHT+IF4Xzkp0jdQnpvfnVe1sLE5NxasDzZVMgfCpy9HYMw5CBoE58UN9jo12Spg0OG9dr0aHUq2vQ==
X-Received: by 2002:a17:90b:1b45:b0:2c9:6514:39ff with SMTP id 98e67ed59e1d1-2cd85d8dcbbmr1435980a91.33.1721706920209;
        Mon, 22 Jul 2024 20:55:20 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf80a9a4csm7946372a91.55.2024.07.22.20.55.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Jul 2024 20:55:19 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH v5]  mm/damon/lru_sort: adjust local variable to dynamic allocation
Date: Tue, 23 Jul 2024 11:55:13 +0800
Message-Id: <20240723035513.20153-1-flyingpeng@tencent.com>
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

Link: https://lore.kernel.org/all/20240711081051.66560-1-flyingpeng@tencent.com/
Link: https://lore.kernel.org/linux-mm/20240719174234.47017-1-sj@kernel.org/T/

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
v4 -> v5: rebase on latest mm-unstable tree.
v3 -> v4: adjust release point, tweak format, etc.
v2 -> v3: don't change histgram array in damon_quota, dynamically
          allocating local variables
v1 -> v2: don't modify global variables and change the histgram array in
          damon_quota to dynamic allocation
 mm/damon/lru_sort.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 4af8fd4a390b..0b35bd5fb659 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -148,12 +148,17 @@ static struct damon_target *target;
 static struct damos *damon_lru_sort_new_scheme(
 		struct damos_access_pattern *pattern, enum damos_action action)
 {
-	struct damos_quota quota = damon_lru_sort_quota;
+	struct damos *damos;
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
@@ -161,10 +166,12 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* for each aggregation interval */
 			0,
 			/* under the quota. */
-			&quota,
+			quota,
 			/* (De)activate this according to the watermarks. */
 			&damon_lru_sort_wmarks,
 			NUMA_NO_NODE);
+	kfree(quota);
+	return damos;
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
-- 
2.27.0

