Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D43D525B
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095337; cv=none; b=PnvZPI8jIWZI5aFnqha0CYE1FG96CSKZ1WhcGmDU5oZLj/17na9RoBQCIMmW3d15prrXDeuy6smn0+axPs0h2oxM1nHD2kaVeiq0SQiWhdaPZFEYdSnldi2T6An9PtHOd1TXS1max62Xg3axZ1KP46b69DQJ4KhlSuhwPbMEX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095337; c=relaxed/simple;
	bh=r4VJhsY7I9dZxVLCJ1KGzt3MdiTBJnB7ZZTz6srzQRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDF2z6sE+DZES6IyrErwM0FugamcsTyHc0bpRz+nw1m5nR0YNHVtxMrLsOlop8bcaU2AgFk1Tfn/y/I++jZ9Ibi1GUSn6EZJ60soRh4eb4TR3CZ6nvWxDf7J0Gn6Gy7OR4w3poBgK7O0o8WArDZgbyHI8Lyz9EhQgwmZNB0SCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTv7X+fh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTv7X+fh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3217035a91.3
        for <damon@lists.linux.dev>; Fri, 07 Aug 2026 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786095335; x=1786700135; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikUEXbCxj3hayBZiXKMC/GcUDL0sztIe9+0w0hR5n7w=;
        b=dTv7X+fhgcBxb8p8V6ixM83sQHN7Gh9rdxLzaGW4+FUH05WoWgdhvf3o7xfEiQ3KNW
         yoYg3ut+EOn77gKlKJPFr7W5r7Qshs+7zwD6+BnkL51Jh1TvmRoW/DkN1v9MGaDG4oa8
         /BE2v/gjSzYJvCRHODUzgR/yAYnWPxeVmVQMXtiiMrgnf9oV+0JkSSLv+DA17cs0hdk1
         /iunR6xJW14exkVTFargc5Qp0YKhoBwpl//GRGKm7LnxN+4yeVv/eR0IyDcSBT+XG/b6
         AE4qhqy/hQQDY5PtvOvcxwut84tyVBV5WY3+jsLKODY1G2gBkOrdJf1wWpolQ92lUHcQ
         FP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095335; x=1786700135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikUEXbCxj3hayBZiXKMC/GcUDL0sztIe9+0w0hR5n7w=;
        b=IXJSgKurt5jDGt0JYX5BFA75DsJgHkuBQkzidp+FwhftsGPHow7j3GlibRuEoEdRoZ
         +OQwbtPRbw751FUyzLk1o3BQccdL9gHiVPBgL6M9btUpHOdbhtIUElJoJqlatMsQB639
         /w8Ram/DDB87fTV/aXJyQdcR+MxXnS5P14dyW0aH5M7C4/lZaXIc9mClhRwZp+rX+7Te
         kB9RifrbP7yB+m85uf0jufdJV9JKbAoZMeulHA8WFcM+ef9wZINqik80FN7Ke9RDMxnR
         wEomnj9qG6IeJAhfAmdWegoRj6Xxei6hDJjWTLovkZ3l/NzNo/1ARWwSD2Qi1E68Evdq
         JJxA==
X-Gm-Message-State: AOJu0Yzli4wg7cPVjMaCktga6liYu9LDY5I60wfko2Z0xDvLA9X0VTMW
	574/fRXBvGC1ekhkrEs68wjiTr8wONTD4oZKVJtfZb4wQl5FqjB71FlP
X-Gm-Gg: AR+sD13yznZCnkMTv8IV8FrnPjeIEg1iJHA4n3COejC3SKAfGxO/QLCTMKtGL0nOqMG
	y1ewIr6WJ5ju99KkPnz9ROwaQVeY90EQUw4HclCTUmEcQWjTgEFlrbsACHeiHg49rYGigDVSLQs
	vNvOGxGTPqtVB2mCYIUv9iv7ClxWWdng82lw7iSsmG+SJR0Ax/QavD1iJUAe11M+NVtY4F+BKMw
	G+kCfoeXBteW7fpZrJVwdEFMeu1ClGnrQKT+JdKQSJLgoGuQlFvg4GbTwEeu2VlOk5XL+DUQJan
	2yauPu+QXJSJrvOus2eMZHDPrBNxnHJairjcJ2bRtL8YayiOFz+BP9k/1+lJ7+njLGND61uqPY8
	bSZVQiOU5J4BAKih9lYwMdYnGW0OjezbqhRos/PVaJbG/FWfcA2M9gniwxloB92TNqWiICf70n7
	7wWw8oDx1Kmv15d0bz6WatZNpPf/6NS1Tj8bhQ/UbntNb4z3pFNbjbd3MIqXC1l+cf
X-Received: by 2002:a17:90b:2590:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3903c572a05mr22075654a91.9.1786095335499;
        Fri, 07 Aug 2026 02:35:35 -0700 (PDT)
Received: from celestia ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3926254ee45sm1604269a91.2.2026.08.07.02.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:35:35 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH 0/2] mm/damon: fix nr_snapshots semantics and max_nr_snapshots check coverage
Date: Fri,  7 Aug 2026 17:35:24 +0800
Message-ID: <20260807093526.183009-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both patches address the DAMOS nr_snapshots/max_nr_snapshots
deactivation mechanism.

- Patch 1: fixes the nr_snapshots counting semantics.
- Patch 2: unifies deactivation checks to prevent busy-loop.

Note: Patch 1 should be applied before Patch 2, as damos_is_deactivated()
relies on correct nr_snapshots counting.

Liew Rui Yan (2):
  mm/damon: fix nr_snapshots counting using tried_applied flag
  mm/damon: skip deactivated schemes in watermark checks and add
    fallback sleep

 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 42 ++++++++++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.55.0

