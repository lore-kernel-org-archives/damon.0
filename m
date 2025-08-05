Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD61D5CEA
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397615; cv=none; b=ox9EYSa0LaTjeYMG3xyb57i/R5yMzn8ACjtCznsxhRt63O2NJRIuKR5URbFGB/nAmdg5yiY5EFFZtrye7t67RkwoaPOrANE12u0MpK8leADTAv62wCrVOPQVwmoFWO8Tyr0xM9mMIRPT4wSw5srP1q/5WSKWfKc53IVntremdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397615; c=relaxed/simple;
	bh=DbhJzAaN+VQ5mhPPcGfEiBWDtKIMJFl0qscg5DT2XXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqYVkolyUvA7mNSdwGVHCv9KVX/+46jcPJck8kNvAcYavbgFAikT1xQ8hrK+qNq+UHMVvg5xi9OrFjf6klVpowj4mxZ5XGjm/y/JQdrraSaBQeRnMs7V7dWUzQBfApICHVZUwcicDm7Y4iVjI4KDyn/1nEDMTPbzB245VDO5N2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbuwwTOK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbuwwTOK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23aeac7d77aso48566885ad.3
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397614; x=1755002414; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kv2WQYohyJtHe0R3wq52sTzttlbIqo5mh2LAfmPMI3s=;
        b=nbuwwTOKrB4gf2oVTAOWKumvx2jnLCgPC6A4l3PgKNnmfUVCklgUr3iYhvnXlZQmX2
         pBrzZl0y561j2KCpXiHfiWmH8GsvxWY4ix+hq7kUTA47ooWO7mj+Bp8+ZEVwbRkdFxix
         Z4RWH/4GCiuzycHy9idDTIa11mC0mR1Jv0nFAltlBlFrkFeOb0EtM6dp009evY3wOex4
         6VdDkWH08DfvHN/pL8BOGp0BbnRcKqVYMBPYN1Ppj4O13rygORo6PbzmX3DXOqgelyWE
         ipOpW0fXa8TQwLOfNtHVUKc45RsNaVoGdcAbJr1PId9kPlPRH8Mr8qVTAUq2DustMRTk
         2/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397614; x=1755002414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kv2WQYohyJtHe0R3wq52sTzttlbIqo5mh2LAfmPMI3s=;
        b=qMgQhCy3xVMzHabcJPwQ/q1nBtyORjUh8LK9hr7n0tJRvxLnnBNuWnrIIcKqjPMU9i
         gpTxTdIcz0hRMRR7VuYkXZ8rqSBfskJMTMo1yQtZ9iPeUubtbju7cSCwPXyV1USDPFM4
         Z9wwp539OscquT0Mzuy7MmS3HX/YnL+x7I7kV/9hFa/294b7FZjXynnwUn4VXt+6otKr
         u+K4QPPbnrfbEvpaDTCgVqq7INHfn45JejjKubRtJ/2V/ocsjVaS53jPh61UY4iT6HEr
         Ov2MC2RuW+PdUrvyZ4+koV0uUruERpvioKc40NeVHyAiXMJV7SvL1GF1w5Umf4950euj
         Rnqg==
X-Gm-Message-State: AOJu0YyOw+af4nJ1HgrsqGrOEA1DmY9IqO4nhru1T4I/4/RSlY460j/k
	8JJQGt6IzBxkBOhYIOfADf6QaTvtSS1PLTO5u+Q5Bsn6G0nK1MXlGSfc
X-Gm-Gg: ASbGnctIi/9xg+ktyHKorOABcz+wFzYBM+Jdst2/FO5UZ6TufNEL84mRVpOYKevuTyZ
	bIt52H+/mCsHA2yXG+5vAS6d+AfFU6IwTimgIi8wzeLzPLiChQDd2PBU0FSdsqNu71HBlEQ0dnF
	Jae588sbKxbdukAREMMg17xNSkkANPhH1SK+J3FCk43lmx6/BwhHI9n/0Hfz0iqieSkkwRhUd6G
	bTfaCgchICxyKthsk/Gay0fY0wEgdc/JNRdWXxPvktViTfcrf6B1IJ9zY2Z/LXQTgKvOXROAA9x
	gBagiFnhgbvC2wv43FfU1vkR6ZlKyng54zRj3XM5CGn4NnKgsnrUh73DO2ybJKZOUJbz9URo9gg
	lwDnKHWPYCMIF/VLCkJnobqPQykU=
X-Google-Smtp-Source: AGHT+IFY5kB1KV5C1poWITqdcW+VQrnByTdSHae+6L/MEv9sSfTL4PyH/fc3hPjyUva0mXiJU3Fu7g==
X-Received: by 2002:a17:902:ec90:b0:240:3c51:1063 with SMTP id d9443c01a7336-24246f8cb59mr199307215ad.23.1754397613404;
        Tue, 05 Aug 2025 05:40:13 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d347sm131088085ad.140.2025.08.05.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:40:13 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v3] mm/damon: update expired description of damos_action
Date: Tue,  5 Aug 2025 21:39:40 +0900
Message-ID: <20250805123940.13691-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowadays, damos operation actions support more various operation set.
But comments(also, generated documentation) doesn't updated.
So, fix the comments with current support status.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]:
1. change baseline from damon/next to mm/mm-new
2. Add note about DAMOS_PAGEOUT and demotion.

Changes from v2 [2]:
1. Add reference design documentation to describe support of each damos_action.

[1] https://lore.kernel.org/all/20250731132230.80046-1-ekffu200098@gmail.com/
[2] https://lore.kernel.org/all/20250804143816.29654-1-ekffu200098@gmail.com/

---
 include/linux/damon.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f13664c62ddd..d01bfee80bd6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -110,7 +110,7 @@ struct damon_target {
  *
  * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
  * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
- * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
+ * @DAMOS_PAGEOUT:	Reclaim the region.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
@@ -121,10 +121,10 @@ struct damon_target {
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
  * The support of each action is up to running &struct damon_operations.
- * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
- * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
- * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
- * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
+ * Refer to 'Operation Action' section of Documentation/mm/damon/design.rst for
+ * status of the supports.
+ *
+ * Note that DAMOS_PAGEOUT doesn't trigger demotions.
  */
 enum damos_action {
 	DAMOS_WILLNEED,
-- 
2.43.0

