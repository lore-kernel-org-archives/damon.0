Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB47DA81
	for <damon@lists.linux.dev>; Sat, 21 Sep 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726948631; cv=none; b=EvSezdL7NJhpsclKW+Ajh48602gFgwu+VQikzNDybzmVquc7sV5pFGrQ9RANMj24fNsnFua3qVuK/choRzphKtKMkYTvTOS5SLUa5c1QiKMiV8JTpmSSc4/AW4HkyusWnSxQyKJ9ySP+ZbORROeSCQdsr4h1TQd03+VZWCL6gKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726948631; c=relaxed/simple;
	bh=P0yvwIw4/C32i1K3Ca/Q+dUMGKZrikS92mEUTx5/M/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ugvwg5hM08zslc+GejbDhPFFpEsJjG8hGqjLQ9HZF5Hjw8cLrc939YYBGPZCYZcwXLRlTC72/BIex4h+BAPm6ADdBK9d1hRo3B8V8LKKpM6X8IgG6iSjTMxcoIhn83EN2/RVOBopWKi6WyQRnorNzk4+FNSpL1zfNqbApbpMEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKd+uIH0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKd+uIH0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205909afad3so37666405ad.2
        for <damon@lists.linux.dev>; Sat, 21 Sep 2024 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726948629; x=1727553429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tL6Q4yRMI5cAA833hyiACaaa+MFKJlXA+BVwOAtvywo=;
        b=DKd+uIH0R9KO7kJbD8gWu1NIxRCZZr001TcHB48R6ssqpuy0enmhGIbDVDFiY6e/yO
         7cwNKLinKxcQktKDJAT/lUAqRPB55Y90VENXZVN2+vyH1t2aAMvwdotUaPUKnJrG1TiG
         xH1YXiIKQ/i0yxpsWFXyGQ3B9kGGq86h6U0+/ommsxHl1BX7SLQ+A/yQJrLxSkgZYTft
         DUr2rvYaezfa453Th1UEq4t8tdVD1fjfBtkv2RXlB+lJE/zjo2Owl2Q/T5gbmtBowKg7
         cGVmPGSKgB18SyHCXJdEy1fW7Gv8RHdqeVrhYVXESLYGoZdae2eu3GYXLfxYvAWiU1/W
         UJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726948629; x=1727553429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tL6Q4yRMI5cAA833hyiACaaa+MFKJlXA+BVwOAtvywo=;
        b=JnYIK/ucIgOOKwQF6GgyS3rZUbVW//ZneSeTkBvO17WzpU6BlJRlizMmfNUftW9t6z
         efKtxLahSqqlDF2b01F3LPbfEomc5SMhGAZ00awM0eTskwWKfi7InBK5OobYZpxHPB9r
         jCg2mYQmGUeeoSPVEPNEwXlDUeg0xFwifFugT0RNKo1Zn461A2JXiMTzVKY+nFGyKbUl
         ytpJb7yX/doMUHUPAHuvA6s/+sC84wG/o/WJfO1xsKkHqF7ME/PbAT8ez79QiSY2nfpf
         pthbhiKeUEseFzBmINf8WQWao8VJ64mV5T1NC2wnOeF7Ok0WjXSdHHvnerZkJ4DHSgCH
         Va2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMLrZ3Uh2nF9oeXdCHMY+wrQAA5zHkr7yMssm9M43uRo6cH3mPgbI2CDywm8zkVlO/3GJu+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsIC1Mk5sVo1xvRgTLZLYlVdVyioxL4rvIxsbTrzd09KpWXaxl
	xXWK31R7XER10XdrDQiEy8wzwQI5S9hpyFpqcTw42nZRS1+Xfxu7
X-Google-Smtp-Source: AGHT+IHOVPLtF44VuR8xtKWdO1Sdnkq7LicaBWc92K+g37O0VEZI4c3J/dixnkEOEekfoeeN1wANdA==
X-Received: by 2002:a17:903:181:b0:206:9640:e751 with SMTP id d9443c01a7336-208d830ed11mr115040245ad.3.1726948628817;
        Sat, 21 Sep 2024 12:57:08 -0700 (PDT)
Received: from tc.. (c-67-171-216-181.hsd1.or.comcast.net. [67.171.216.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079472fb94sm112006355ad.253.2024.09.21.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 12:57:08 -0700 (PDT)
From: Leo Stone <leocstone@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	ruanjinjie@huawei.com
Cc: Leo Stone <leocstone@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org
Subject: [PATCH] mm/damon: fix sparse warning for zero initializer
Date: Sat, 21 Sep 2024 12:54:45 -0700
Message-ID: <20240921195511.364023-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse warns about zero initializing an array with {0,}, change it to
the equivalent {0}.

Fixes the sparse warning:
mm/damon/tests/vaddr-kunit.h:69:47: warning: missing braces around initializer

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 mm/damon/tests/vaddr-kunit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a339d117150f..3dad8dfd9005 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -66,7 +66,7 @@ static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
 	static struct mm_struct mm;
-	struct damon_addr_range regions[3] = {0,};
+	struct damon_addr_range regions[3] = {0};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] = {
 		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
-- 
2.43.0

