Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C71428E7
	for <damon@lists.linux.dev>; Tue, 29 Jul 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800289; cv=none; b=bHNkpZO6WakWh2ME7GBDFNoCwRWCtoVYqrDLLV1oZoEnJzrx5Lx2bMt4DPk8YEKWV3jGnjvYnKqa7uRoZEy3Xs+4ReKPPvL9x3fUEGG0Q70JzOuZCw6n7J3q1ZhAzGkoUw6yBpimDURVV2dB+200FeE77BHsigOQOP4sGnzkHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800289; c=relaxed/simple;
	bh=mF/M9iSmwUPCANR8m+L/sl6KgXbjtwmHMYdeah62734=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/wSZOQBXgO6ICioOFVaf8YxfH7h+QyNNB0M74o4UuqBhF96btggxSdjYaIbKqOnfx3WPqvbrqM5CvTOzm1RuFGMapr4KN5ORxFqsoynSaAfWUoIMqJUEA0VKd2X1JQGb5HBOcmZu7avDQFQl0TvUGlMkLiC4oJYUmZBE//0pXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxzMGuwy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxzMGuwy"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748d982e97cso5198327b3a.1
        for <damon@lists.linux.dev>; Tue, 29 Jul 2025 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753800287; x=1754405087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HTk2A+A73hmwRAbv/w2ew46OXVZ23/y0J+XLjG1S7w=;
        b=kxzMGuwyv4Urnd4ATmMopCgx+c9LiM8EizKfsubyAVhUVsrRNjEpFSk3XYCxFibVyY
         dz14WVxKwHyDq1OGrdYepPewa1VFKulzjIyp6pNcZC9S/PWCsU6z1fbkczTtwZluQzLL
         wqsdiHIPb1Ge7GH6kxMJKiRS0NmuSC59T+72ZGT90B+OQc8Gi9spj4Q7GcQf61k8zRMp
         l+8h7sBQAKjdZKbKSFXk0FBfgiaTXBYwVfneFhaH7h/PBaHucg9rWzrV3YpzVFKaUAtO
         5oNE6sHTIgdkqTjnt5WdZziY5NOXftY4yeviBKMLp0y0asP77PUb9vT+Ckg2lWJSxTDE
         SNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753800287; x=1754405087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HTk2A+A73hmwRAbv/w2ew46OXVZ23/y0J+XLjG1S7w=;
        b=VagL7+roJ1P+6jAbInY35G9QnnWolC4OhJKQ8bI7Ih0dE9+/XVSfFJ6w7panw1wVHt
         NwppQdmEYHi/MtEDBi9hYUJ/zsoVNm67etlrN0k0PM44On9kZCcFUZmZZekh1WGkwh82
         +bOH4pdXXfFmscp0BRsxnq9Qhppm22J+vSBD3LDsn4Rnq3rIRlCPB4R2j/tG4bEH+qHw
         BgzmDfttCnvbnKLNYzUPtmRiSnVhgaTGR5r4KFxbYvzHvnW88fo6YO0Cbm7Cj9Yw1DiX
         LRj4trQFbI+3u8QPrsVlU8wbzOZex9M13Ykwy8R5KdF7jxYwJEbC4OUQ9e+Q7H4JnIr9
         x/Zg==
X-Gm-Message-State: AOJu0Yz6UCGXN66xA2NccFT9O8o5zE8qZLmuSBlHpyqsY8zO3MixKgIk
	EHVRbUY2QTIqfYR0nXfVAcP0HSKQt6flwdK9XdJ0ORD36Q4DzGfLVSqA
X-Gm-Gg: ASbGncszKFAxW02svKDkgSjmQD5o7vsdOCnEE8Iwe9zHvineYdvuSHFjq649Gn/RGfh
	KqzZO+tff+ig4j0ZTjIBfwO5bxnGv5eCTMMUxt39l9E4Pyq2a9i19Fw/FWU8znKKLswH7nB0j6o
	1RRfBTGjt+4GJidm5mjujuaIK5un3QtHjBo94i3/IL+pjOdzU4o7gTfXl1lmer+F5QHvBpTkpLz
	lf3gWQklze7x+91l/bFjvM4H2xwWBmE4W+0/iJqrLUMFDOWmgInmDVZdH+Za+TTRs9oMt/4B69Y
	3IAcKe7lAuMYsI4HK+PxhM9Bxm/yLu31DiRHgvpX+SgsgwMNuxFEmeBZZfzxDQRpid/1Hz0MDJY
	xJOHl2H7e+UkgmKWM
X-Google-Smtp-Source: AGHT+IFWk9ARReG6XQopp7V7zsh3suvbk0HvFwJmFgTU4AFJ+iwnaGXqnNPcktMWy+/9+rFFzdRzdg==
X-Received: by 2002:a05:6a20:6a0f:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-23d70081497mr25300747637.20.1753800287170;
        Tue, 29 Jul 2025 07:44:47 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b1e5c94sm8317223b3a.94.2025.07.29.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:44:46 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] docs/mm/damon/design: fix typo
Date: Tue, 29 Jul 2025 23:44:14 +0900
Message-ID: <20250729144414.31958-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typo in statistics section of DAMON design docs
- sz_trtied -> sz_tried

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
While studying about DAMON subsystem, I found some typos in docs.
This is my first kernel patch. So if there are any mistakes, please let
me know. I'll try to fix as soon as possible. Thanks for reviewing.

---
 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 03f8137256f5..2f6ba5c7f4c7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -689,7 +689,7 @@ DAMOS accounts below statistics for each scheme, from the beginning of the
 scheme's execution.
 
 - ``nr_tried``: Total number of regions that the scheme is tried to be applied.
-- ``sz_trtied``: Total size of regions that the scheme is tried to be applied.
+- ``sz_tried``: Total size of regions that the scheme is tried to be applied.
 - ``sz_ops_filter_passed``: Total bytes that passed operations set
   layer-handled DAMOS filters.
 - ``nr_applied``: Total number of regions that the scheme is applied.
-- 
2.43.0

