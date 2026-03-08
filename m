Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F722127B
	for <damon@lists.linux.dev>; Sun,  8 Mar 2026 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772936298; cv=none; b=F2l1vBhra/NVYpmk61UsJ0qLKY8fwgg7IWQk5op2okvbZIJfcv9GHM/n+sg9DZ+0xtqAMxLyafGasouk7j6AvVV16UBUisf+V1K04lj3aiIJVd60MVKU93JSLn9sWB5ntoxz4KGB/0+YHPfqijACbFuH60JxXbgscDl+qBVQC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772936298; c=relaxed/simple;
	bh=MeqH7u4eTIrpk5GIVCE5RxM5iQVrdNO1AjeWs50Td7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZaapTcjBT1KFWOsVVnUaNSBr7MUB9s3JW7Rv6hhn39MJr0AkJggZXfgUG3tR+S+a3Gi3PSwp6YPMbgvzDEI67acp5ciVB4bxPRc8+L0LVhdU0xVYS3b8hbrmO0Av7haCoyIadErbgFOEoRn3nsr5Lo1yHVQN/xunF1OpsNhZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCDKHS0L; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCDKHS0L"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35995cb33a8so3704164a91.0
        for <damon@lists.linux.dev>; Sat, 07 Mar 2026 18:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772936297; x=1773541097; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLs6pe+2XdQCgxeAaSiAQagpBRk3m3MuIZTKss7ZE2Y=;
        b=gCDKHS0LGgkHBn8+Ae+5ZheuX3Lfbz+1HLO3XeVzJ9ex7B1pjGy+46yKAV0O/c8htp
         5IQ3FYXYzDcoxzFf8pJA8x/EPD9hZk3qsW0oEsuFxpF4CnfnP4NYCs5ZXBOw15NWiMzD
         e1SKG8/ghgk2hdGCM91anQByCFMJhzOZVHcf1kcITLr14FRM43D/CZKNsuTN2+jwtN8O
         ETDJ7eOzoy3ydz9GANxfFP/68wExTM+kgG2Zwo3v0jveIxM8uOpy4pOPCJ5IF922OXea
         MjrGgeCj6MfMcbVoxOR3TuHg9jJdKQleorKEry/RP9zCAIu+qcxJX9YdqIdYMw+Zoe/N
         Vocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772936297; x=1773541097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLs6pe+2XdQCgxeAaSiAQagpBRk3m3MuIZTKss7ZE2Y=;
        b=mk3VjvEwTKNPHCHv9f0LBjPJ4qLGu8tIhlAMmGqPdCyg6QXi04w4ueP/QI5JUvs/jz
         5vTdKIdHnt/YdDlb1+5OrizNmUQU/gQxeorQDf0JV+gCQYicnBpDFNGY2u7iwMuSVZtd
         a2hM1myT3lTbe5LFwlmMlWGaQUK5Nf7Erfg1PlprbGlVtH/+waJZUJc7Nx6GLYPfHwUU
         rDJ53cCVCYtemAD562vuY/NZdtJh/c80zY+RM/Z5Si2jaTsiyVHZIN9Z4fNC/ioxtF7M
         XD2cnllJ+nnGA/NExPX9qYb7TkQSAwEmgbs3v7EB8QZHIkkncdF0Gv79KD1Igo92/6UJ
         Cztw==
X-Gm-Message-State: AOJu0YwWxKqGS4FLY/jabmt6Z1S6EDF6kw38CESR35dQD0IPSBpea5E4
	sadaAWKppfw+E3Jl3XEFxePBekGNGDfNOLqFaN69c78+XE43wxkC0GVe
X-Gm-Gg: ATEYQzx0tIRuIR2f4PcHwlxIqsR7ABUPrE8EFxDMOyvSiWn/WBvuAdAMvyQioNggXhg
	aoe5IurhLzTBC1MjRAW2MVXnujEFXUB/ent34StMNnDQJq6TXUqOmpiEJaznBdYfgY1ICGDO7ev
	W1uLgWuc1CL8XvsbQNwA0YaGnFUUaMWVKIrk5H9XmABl31JYVH+KPt0uHTZbMpd38Zie3UMsg4C
	yYXU4RLocDnEtgcPnQsb4Wo0Op+iOpB1ph3Q1dlaHltwajnv+NHzkHu8Wi2/Dha7U84+R04PvDn
	hDcyzwsrI526++rpVKxMusE9jKWvuZHO1EjrWKInz0m7gYZB+C5dqM7Lm5MfMD+LURuSrLwIBvc
	2J9xSH8ibO1DmuoKxIKbv03vTwFa5nzrf8MqgI7VHED24CaDdOZ0STVuRWcimSFQF54IABN8p9M
	S4BeK13AxBO2xSPvmfJ4itYH/w8lpVyQ==
X-Received: by 2002:a17:90b:2e0c:b0:359:8ca0:308d with SMTP id 98e67ed59e1d1-359be3939f7mr5791531a91.14.1772936296532;
        Sat, 07 Mar 2026 18:18:16 -0800 (PST)
Received: from localhost ([2402:1980:89f2:c7ce:61e7:b269:3230:dede])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c005e1b2sm8209446a91.5.2026.03.07.18.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 18:18:16 -0800 (PST)
From: aethernet <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH] Documentation/mm/damon: fix typo in index.rst
Date: Sun,  8 Mar 2026 10:18:11 +0800
Message-ID: <20260308021811.41199-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 82f6c5eea49a..318f6a7bfea4 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -12,7 +12,7 @@ DAMON is a Linux kernel subsystem for efficient :ref:`data access monitoring
  - *light-weight* (for production online usages),
  - *scalable* (in terms of memory size),
  - *tunable* (for flexible usages), and
- - *autoamted* (for production operation without manual tunings).
+ - *automated* (for production operation without manual tunings).
 
 .. toctree::
    :maxdepth: 2
-- 
2.53.0

