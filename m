Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6951279DB1
	for <damon@lists.linux.dev>; Tue, 22 Sep 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048195; cv=none; b=WKjMFMnOdiGJllROy++N8qdoYl9DwqFDs+cU+dU4UJNCPFc0lFWjEX4JIeq+wM7Y01C2rLHw+yhxf8wHJ7IUr/VpQCHps1pRHD/TnSB/RMjYnIf+nPYOvFKLwcFDFXV8rN/xHQpKpAmNo2V74YwK7b6S3ksvnJU7DKn0U8ss0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048195; c=relaxed/simple;
	bh=mkJuprWMIIS2VO1KTqhXiU2uQTQ3HYE4NPAu/U6qwm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdIiMn9DdNcV65QKblYWi8S0Apyy/LId4RlhrsA4xrBKI8ap02n1YlcINwCi+emMm/3ePKPXiwkjckUutLJCmpQb0KADPtLfLvPoIGJecl1hfA/wF1nxxUvrOjMQwRECbMvyTLsnkBMDia0TjgKhZHT+ingB29cRIAS/vpMdw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNp/Qz7L; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNp/Qz7L"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so1964540a12.1
        for <damon@lists.linux.dev>; Mon, 21 Sep 2026 20:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790048193; x=1790652993; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xjaz0tU8TY0TcueO7EZLXNwxMWHUXDu0d5R0jWTxtYk=;
        b=WNp/Qz7LxYQcok4jXkP/hj7Mb+Va/yD1gm0x2nK9VDzYNyPyuxvxPyjRevP4wg4KA2
         +FeKyCJNe3g7Aa4731JkOXIlDr/bkSnPWFbx4E4+JOoFfb92Z9WeJA4amOstORvAwGbU
         wj7HknACQlDqedqxtmREPV2t7vMpkXpErA4nce3HPcd+eYVkruGTzOf81ryAgZrMiddq
         AGU28F29thZERztrGXPqTPMgKK6ZZ7wYBUsbUtonP4i49rvnyPVPFtbh2ooqtkvothlb
         tdtsqjUxh9Fq1VqrBDyhCg+GBhlXSA9CtGPU8JbaCthyXG4GWEs9+F02d8Frjk4RAp6Q
         2ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790048193; x=1790652993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xjaz0tU8TY0TcueO7EZLXNwxMWHUXDu0d5R0jWTxtYk=;
        b=g4vPLS5T3mKVLSg03L9meLb+rIcaWHVJgDUIAHcNQyCEttZ3QzDj1Frx5z8wDshCm4
         RN3skn79XZDBsCWsCy9qNiDTGMOvGr14lNgJjgmsY4JKWYTU66ZDOKWiuy4QjBcwaAzM
         bsSJMTIP1l3K3yVOmvdrqI7jazQuLrFX6qEBBf8zqe+5G5zbdDKS/Bza2Ys6fDDg2q5n
         EZcqkanLvyRzVrBPnOvVPvPY4zOk8K/lC4H5lG6UyJ4aE6pBvu1hWizgL7bxlbit/LA1
         OcUeJAXkcDpMazGu1VY2PJD8krrawciPvvA3dnEHTxQ2aeSiTc0Xpd0kCPB1N7FDXCxw
         pgHw==
X-Forwarded-Encrypted: i=1; AKwUvBzdoahrCt7RtONiQaOlVoRJE+TJPZCqwyooMQIFsew08dOvFCpjxNFDt4LSiLZhVd3lYd/OAQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k3129DdxYmqhy0MWSUQLKiWBQTXOkqnwbaOp1YLPKbUdMT26bI
	NiEB3XT3ifmcofMKEYk3iFYDkP7cAWnmAxFjjmAvPUbyiVqlMSkDPmaE8cg1JzabjIfcXwyK
X-Gm-Gg: AYBFou24hDavLzJ/yTs0L5R7Bpq0x26m+SL+ay9+sJ+vR5emm5IYd/KAAcLjTfHEv78
	fNNd+8TUN+v3aPc0kTkAsY7zsYfd74Q+1GRNznLC8X4/jVSoN5on1USIP35nKpIYepIegBetbXU
	+U6y/ocb6GcMom99NgCoTe0/Lwkd/y7REtc/rmk1g7qfgFdS+LUX/eS9ZFmiadH02W4ImjacA2p
	h+7JvihrIV1lYzfyvymRFxUitbuaUUfx28ano1PNXoHkVpPORXkSYNYRmM34fg/aJHdnIjfOxq5
	mXBXw31k5o8PIisN9cG4+fnLLVLGeZrjrKfU4zdQiHEtvtxFzJ2i5l/KHT1SojkOW3mpv9r8Tuc
	TbcCBzjT0gsp1Pskt2OsH2ic53K8tGqVb3hHqWKWB2RiIBun+MHEB3jmRCyorkqv9odmUnCZQkc
	OLVQ2dg+s0MZWSKw+TTG1Acv8ajltgxxFc5LZxfiMMYcE1OF/giw+SqrC/bEx4tImke9umcNJAF
	Hl6K3Hw4x3INLVj5ayGYPPRP7XhVx20oWkMcXfAa0fKRC9c9nAPcgzQlTVD8jg=
X-Received: by 2002:a05:6300:68c9:20b0:3dd:a197:7371 with SMTP id adf61e73a8af0-3dda19774d5mr7923602637.74.1790048192813;
        Mon, 21 Sep 2026 20:36:32 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f2a28cddsm1235667c88.10.2026.09.21.20.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:36:32 -0700 (PDT)
From: Zhijian Han <hanzhijian1991@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj38.park@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: fix typos in comments
Date: Tue, 22 Sep 2026 11:36:18 +0800
Message-ID: <20260922033618.2862687-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling errors found by codespell in mm/damon/core.c:

- "widnow" -> "window"
- "makrs" -> "marks"

No functional changes.

Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1..c01b7e2a1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2328,7 +2328,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
  * This function checks if a given region should be skipped or not for the
  * reason.  If only the starting part of the region has previously charged,
  * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow, and return true.  The
+ * area that not charged in the previous charge window, and return true.  The
  * caller can see the second one on the next iteration of the region walk.
  * Note that this means the caller should use damon_for_each_region() instead
  * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
@@ -2486,7 +2486,7 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
  * This function is called when kdamond finished applying the action of a DAMOS
  * scheme to all regions that eligible for the given &damos->apply_interval_us.
  * If every scheme of @ctx including @s now finished walking for at least one
- * &damos->apply_interval_us, this function makrs the handling of the given
+ * &damos->apply_interval_us, this function marks the handling of the given
  * DAMOS walk request is done, so that damos_walk() can wake up and return.
  */
 static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
-- 
2.43.0

