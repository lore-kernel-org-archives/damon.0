Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840F47CA77
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789217045; cv=none; b=lEYAqdTqsLbDIS+oSjR2Sc1HLOFlGGF8aOCpFUuvTxIUv/Y6KNfojX8ftW4e3RCDhHrMab3NT2Mv4AmK2d+FhQbGRrdJYJ6Ih3q2Rg+/qWnSG7hykqNSMgwum+H0iLxbze/SxDkEDETfe/7Z/YYUFCUK7Lh0Un56nbkfOUCC4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789217045; c=relaxed/simple;
	bh=eLqv+lkX6bdqEC8uIn+bLdLkhKWAHHUUkudP6LkLSno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8fYRaW+jFkGdZ3rXxdc0MZb+n9j8ft8e3NR4jhLtIp4kgxIujsxruJMYFB5In3JAKKN5o0aXBaETt3R9kqZXIG6otsRaJ23P009Orcz9js6YhOzUBZYFNWTPsJu+/awjor59IISPlIE1IreFgNAUbu50Z/jxbRjxgY44obgP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szlADusv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szlADusv"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso416723a91.3
        for <damon@lists.linux.dev>; Sat, 12 Sep 2026 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789217044; x=1789821844; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fd0BG/EWunOB+q7PV/ZVh026vIj4CU3m1NzQ65Z0ygg=;
        b=szlADusvFo/4iFqUDwxKOWQC4oU3yO4lGw2nn81K/woG2CPZMCSCR0yJTx7VZPrgIr
         +KxZqmYl50K7qpO4IltS5Rv/OVqBUMIq+CwLlC+d/2SeXecMlBWkwOYTb6efknnFxpO/
         Q5TJ3WEKKnbRVM61n138tnJM6krFKZfD9OmydzC/g7JKvEuqxVyluWdat8VKJnGOjA8P
         z+bVY4KB86HuaT387gbDMKBdZaqEAV3Hc5x7iYxkcwyi0CsEjQc85kJk/3BpR+8PjE6q
         fwEGcY750ChlQtvpP+zJNPszZYUbBPcgwZEqd9NAZa8yCdTOPqcwaryjKOL5mbolNGug
         vB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789217044; x=1789821844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fd0BG/EWunOB+q7PV/ZVh026vIj4CU3m1NzQ65Z0ygg=;
        b=qBuuIeFauw5MxCMMOFW2SHzpTCsfGN5MEpGP93ARGm5+s5vtIGWwb6dBElqbGWA4OO
         t7/OijrdQLidNg1z7Ynk0+tc/NNCLYXF3FMJgrb6WCUIKuRSylV3G3Q1mUsNbApGItf9
         wiu6175+X1A3b9JEl7JlFdmZ/KYPPIAoSKY4TrumHTI0ceDVZJKu2uAfMkmfPYaCBxGq
         SyuUwoyXCnk0l6eOenzcA7+p3yYCMsqOEnxzGG39A8jc67TNplk1/mqHciLnMBjVUCn1
         axVzgbnmoIXWpJqe9pNUYNw/GeT3IWy5rAsfTqEuItmfrTsaBdYxt6/b9hoQatWY+dUv
         CtQg==
X-Forwarded-Encrypted: i=1; AKwUvBxsrAK0dwylDOr12V1VpRtk2IZgOnxg5e7yqnHkZDTkyc3bIZ09RhNFCJp4V0lrV9s/X0U1Eg==@lists.linux.dev
X-Gm-Message-State: AFuF++mpDOH8gq6Qxtp1FTqXPo8oTpc2Q+JH7W/lII0BF4ynFhPL1L1I
	TtJzwHqfuwTgHpMBnki9lm5qFQg4elhJAu4MoOuVlXH3xgWsXcH3Ww7O
X-Gm-Gg: AYBFou2elCi5RFl+TP9J+AtZThEpXx/yCixKti8ruy+zoo/ykmRk3uGv6teOqIfqZVs
	Nlm4B19FU8aQiZp+wczsfRIyS1xFXgjQEIPI6GbSgD4CshcVahbn4n3JyNfKaTHBF0ajkNVhD/l
	3cqxDs33GY8VQccu6B2q+hDhkRPMCOk+i2HnNHA9dzmgO+jZeFGQu8T0y411YisoMGZRi+vBeh3
	ciCovMMPOAs9naWwQen9KoN62aEp8wP7RO47wS6BJnICN5H40YJbemKUMX/W8dwr2so3wK+F027
	SaiEa9pZRUs6TghjI9o9b4yQf8kz6vzrddNeCVOFn4uSk1f7cbohm5sRjiCWkJsBDeVV4nSfuY8
	6k1m4EUsjmg9dy3+hNjpI8rNXUcSxRf7Pyk5VboI8pWkJK9WNpa5hClKgIO9b10Ti5xNO+8hVY2
	qOc6K3hrLLU6N4cfsr7/XJ+XkOjeAQI7dxdyoNkyUjFmYxPmZ2hCSQG31Sh+N81xTIwaBn6McCp
	kft
X-Received: by 2002:a17:90b:57c6:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-39dbbeb57a5mr5027381a91.7.1789217043584;
        Sat, 12 Sep 2026 05:44:03 -0700 (PDT)
Received: from celestia ([2402:1980:8858:8cc0:7bda:d54a:257:22ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95713602sm10294840a91.11.2026.09.12.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 05:44:03 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: 
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/damon/core: add short circuit for temporal-goal schemes in damos_adjust_quota()
Date: Sat, 12 Sep 2026 20:43:12 +0800
Message-ID: <20260912124406.96535-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the temporal auto-tuning algorithm, the effective size quota
becomes zero once the goal is [over-]achieved.

In this situation, damos_adjust_quota() still calculates
quota->min_score for it.  However, this min_score will not be used in
this window, because in damon_do_apply_schemes(), damos_quota_is_full()
will always returns true, preventing the scheme from being applied to
any region.

Therefore, add a short circuit for temporal-goal algorithm schemes to
early return from damos_adjust_quota() before calculating min_score.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

I tested with virtme-ng + perf on a Proactive Memory Reclaim workload;
within measurement noise (~3%), no measurable difference was observed.

The purpose of this patch is to reduce unnecessary operations
(calculating min_score).  But, I'd like to know if this patch needs to
demonstrate that it provides better performance before it's merged.

---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ce8c6f99106e..fdcea989f0e0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3320,6 +3320,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 
 	if (!c->ops.get_scheme_score)
 		return;
+	if (quota->esz == 0)
+		return;
 
 	/* Fill up the score histogram */
 	memset(c->regions_score_histogram, 0,
-- 
2.55.0

