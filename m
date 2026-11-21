Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795229807;
	b=EifSPRzz06Aig1qVuMUWJ6Zj8snQxCOSz+fpxi26mcOdPJOiMjxJGPMLwK+sL3lzMbc4
	 qoauRxCeDqiShenC2e97jIxlf8PD44jPmtM5ipdZTfomoVq/SbQxjV8QgNrC12NuOySMT
	 ehp2qDBptXjByz1h/0nfMlCo6baF3g1PD7MqpurV2hcwqe2eHswI0LJvW3G63P06jW1g2
	 a1ZQYbB649SPWcGcfZvfbbr+0B+i+h/CK+xo1hgKpLBCPC3pUGE28Bzn8uUwPplwJkof5
	 1ZqfosoNiAVZcH55wdL2Sm5I4gNG+XKFhhAIVUccJ6tRFuynoZLcXp5o0FXpgNQfnkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795229807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sQ0URJXLHPyhV0pqjQJeFam3yZqKvnQul1dVgNuKRU4=;
	b=L6BcMNjb77Asp0TaT2wk4jJYLA5iEAccTUSrgxIa4vOhNplrj0X1NOcBbSHeyPBrC2qi
	 v6JYKOpMgIernAvp0jYZ9Z6cTrjEixwcDdNHZb0L0DP2HV636zDM1Xi3QTtgawePTNOiC
	 0ulvSbj+N1LLfF4VuU8Mkpkkmfh81FRI29OY6LwHQSi+RCzH+S0TLTN3/YbDq1a4xDZhx
	 rGAiDpO+62UOXqYQ4NIzb/gcrVfazHG6bicXB7DIJx1KsD17f45B+RMtUSEHv20df85RY
	 Eb+QoVpXANHLqFlExXLM1m+jJikcNPvS8LcairmYWQHUw9PYI7zR1r/RC0PLnv3t70Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N5eMFGk9;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83479606A6BE
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 02:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83479606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N5eMFGk9
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38644aedba1so1607880eec.0
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795229802; x=1795834602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQ0URJXLHPyhV0pqjQJeFam3yZqKvnQul1dVgNuKRU4=;
        b=N5eMFGk9SiU3+Uvp5NBU9DddysQ33f5bJ+G/FNCxTf/BOoMOpWqnKdBnRwLgG6HWMl
         EtsST0taoq+C/6Sj3y3FhnS5lWLHjZ1M2qwAIDZWbANRqoonm/7u/pJWMPQcJdkpx+ZO
         k4IROo0N80QKsrii5AQk2P91D3O70bl+OpnCrWo+sLz1MKmuHIv5rnN2yaluk6YORHyt
         G83+E40xzsn0UsyrA0jpcpMMtkTaz/2dLtNapClcYO4Gt7AoHhl8HzSgyGDwKudV1iSY
         oA5/krsAzuH3xjD9MXleYnqUgngGHnQhSPs21Cw6HnVDbbKeBcmpWyR4pSpx3FMAOnxq
         SQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795229802; x=1795834602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQ0URJXLHPyhV0pqjQJeFam3yZqKvnQul1dVgNuKRU4=;
        b=nnyyBvbQpBz648iNvA59VDAg/P/a7QEfeD6UPSUqd/Cilk5Zbarm2/Eu4T3l1J/Qew
         xVIgvXROsyLatGrYy6rdaD5sLAJd+YoEQud8o8qENNc8gbJeD+YBhWkLj9TA6wZ/KrYl
         liLi7c1AZ+zBJgcJ8NSY32HtP5rWOxqZvzX4OSJ3q87fZNwTRpjW30AX3RvJNYfoSyUn
         MyQR7rOOaw416olt827MVBXN5Sf8zGkRytk2Fon7pBZ5CIA3xkiE791hN89BZMdLedWS
         Va4GqVY21k/x16XldFcTWlnOQyToqAq75VtLpuxrf+dbL751HC8UuYLcYYM7W2LTa+Rv
         KQzQ==
X-Gm-Message-State: APuU4Z+xFGu4hRWB9l7J2CXtI2E7KF7zAqp29viZ3QMzhVgYcvZLeNGM
	8yzclCLdkFwil8PGFSlZT+TjSJuAkbwvQHTD7sxauQxuO+F80NsFO4WP
X-Gm-Gg: AZFdTZeghnRcRCWVi02ELac7j6HeSWU0vG2yx5OhfIwqwU8tDk0FMZ8thMnJRs2kHcn
	G7Do0OTMBJ6BaA1uHOsZOh8wsWMi4vwKnS+NrK/UYPgx9kHUSIvzvtvx0yeSY86K/REwlhAtxyo
	YwZhRof2TpXb9J3fOnpAqpsvk1/Ek2Mh5VatT4wT7OQYt5fPKOumfy913KQSa1gNi8J2z2sO+aG
	h1CiKYhRE+5jU44RQeSSp4e5Ccpcf8fH6U/D3FxJGd6JaAdUCzCsD6meqiiC8VduzQz0rbkLVCc
	2BBovU/lLUuN8PhiZNT0QqLn3AwRoiPBhOyEhjHz+rMFrtkFHgvn/EMTWHOSbOajXwxnJL3EsZM
	N3UKN+v2aK8icMiFmNFdOFbxqDDvx7RxBZVomny6sxCqEWi1C+n0zbOgMo5cyl5oUscY1bDJlSv
	oDygVqCkl50P5mEGurBLziEwsP+LxKIjUERc/KuHDbVcouE3Fz+/omrzMJwiKlc4/tAo8pi0EDH
	NxNR4ZtOktw4WFescyiCUETrlGPNmeKHzMvj/d3dX9h4fgKWywj7C5WhBAmJq96JX1EyYj/JXCD
	Eh08duMYczIf8k73VRQo5fiC/Uq1+jsZT/GgO7tU8N85Ky3ZwTkizhIyizFfLpA2o9P64Pjm58c
	VNbLm1Nz3QKUehCau/b5iofHpRt4GrzvVfJyjUdKmSrRcqAPOnm+go9J/pBbJRZBtK/L/1din1L
	m+ww==
X-Received: by 2002:a05:693c:8641:20b0:383:50b7:1d78 with SMTP id 5a478bee46e88-38571223ee7mr5312730eec.40.1795229801565;
        Fri, 20 Nov 2026 18:56:41 -0800 (PST)
Received: from localhost.localdomain (206.135.124.34.bc.googleusercontent.com. [34.124.135.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm12071967eec.9.2026.11.20.18.56.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 18:56:41 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Fri, 20 Nov 2026 18:56:26 -0800
Message-Id: <20261121025626.75981-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_wait_activation() cancels damos_walk() requests while all
schemes are deactivated by their watermarks.  But it returns without
waiting when the watermarks check interval of a deactivated scheme is
zero, which is the default of the DAMON sysfs interface.  The kdamond
main loop then runs with all schemes deactivated.

In that state, kdamond_apply_schemes() finds no scheme to apply and
returns before it calls damos_walk_complete().  The walk request is
neither completed nor cancelled, so damos_walk() waits until the
watermarks activate a scheme again, possibly forever.

For example, with a scheme that has the free_mem_rate metric, zero
interval_us and a high watermark below the current free memory rate,
writing update_schemes_tried_regions to the kdamond state file never
returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.

Cancel the walk request in kdamond_apply_schemes() when no scheme is
activated, as kdamond_wait_activation() does for a non-zero interval.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Suggested-by: SJ Park <sj@kernel.org>
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
v2: cancel the walk when no scheme is activated, and leave has_schemes_to_apply as it is (SJ Park).
v1: https://lore.kernel.org/r/20261118235012.14859-1-evanfengff@gmail.com
QEMU: -ECANCELED instead of the hang, 20/20 walks of an activated scheme pass; kunit and 13 selftests pass (2 need drgn).
Found and written with the help of an AI coding assistant.

 mm/damon/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a9..2748f9199924 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3492,9 +3492,13 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
+	bool has_activated_schemes = false;
 	unsigned long max_region_sz;
 
 	damon_for_each_scheme(s, c) {
+		if (s->wmarks.activated)
+			has_activated_schemes = true;
+
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
@@ -3506,8 +3510,12 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		damos_adjust_quota(c, s);
 	}
 
-	if (!has_schemes_to_apply)
+	if (!has_schemes_to_apply) {
+		/* The walk cannot be completed while no scheme is activated */
+		if (!has_activated_schemes)
+			damos_walk_cancel(c);
 		return;
+	}
 
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

