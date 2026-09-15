Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE82FD696
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452589; cv=none; b=hhS3E91ll+8TZ8bMpzlT3/cdk5BYgosM1lXVpMvyOPMMly3p9y1fLnx1WlptGnSEzfpZHRyOU7Sr9VmgBu+k1z2/YredkLvU4SZNS1/2NG2vZez/lZIkwr8YnoiibUcjsM4wouEVy8NI4DW7CxAkfY1efzEiYdIGP+fxykWKZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452589; c=relaxed/simple;
	bh=BopVM12HDLADxYa9oYvGmWcr4H5e+xesHUsEg8nv++U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocUvi1gDeXwOYNE91tbLWq/hJwBolX/q1jXus9JNcf9gJyDJnm8X/IV9AkOUK9p6dG90Rdyb6mugqOj6nPeduqKm5JMz4doty33wcB6/d6G6pK8Ax21ZJHRHEdErELO3DGeneirPR83mS5Cm7mYIj/ceNPW2fx0f8CDW4NLeIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDf09YI7; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDf09YI7"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7355e411so20947475e9.1
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452586; x=1790057386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SI783VUJkGIZm3nVSym26fZ6VNUHxk9Ukf15drWnbdY=;
        b=MDf09YI7bvRbcwnzAUqh+oKN8CUH1V5+kq5C7raBMeCdTSLYzI1LNOv4MlNsEEBEl/
         ROEVbZbI5k+Ij2ZuB0Z7Rmztv2+I2hMRij0G+tURr97w30xtgeSrctZTHccFbg43dnFx
         /PROAHeDiDXdRhlN2hYcNpB2X2SGo0s+m4Xbc0ituzFNrgzjAp7U03EUonO/hZRLBaZO
         /tfputBrUzMw97h/vFJNOCytUYDyy2KiMy+jbgOJs5BLYZpT63d9zIjABWMeQci9TZ2p
         qNpGELWrd3Q7kIdd++0bX1qp+SeXFuiySALttqgRcPjCFLIKg9R+Ii+mQroCQJ6BwJVd
         glcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452586; x=1790057386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SI783VUJkGIZm3nVSym26fZ6VNUHxk9Ukf15drWnbdY=;
        b=KOR0r/GuIkfC7X2ry3dewDHvsHysJbn4RfOqRsmj8VqBIT4CY7/2rkXhz0R9GRmAfW
         vApdzyC2DKDKyjA/YWq0+DBlT+Fv0gmXBDYzXbVo5xd9f1px5C9cbDUpv92nbrgnzFgP
         iNmthtmTdu866YPtNobASQZuaRwIVYi+xSvksBjtBlCvhac8J1PcB7dUTawdqUzvqZsq
         RaxKqzvz5eP+c3oM3K000Hp+M7P7XDfFv7I43VslYnOanWlWOA2Exi7aCRbU5AggBes1
         8B3WX+ZZYJrQ7lgggHkzu/fjeBPcmjGtAQis1Fn6kzvjPIlxYqpvyPPweUCC6raRQWj8
         ejHw==
X-Forwarded-Encrypted: i=1; AKwUvBxwl4m2aLCEE8OI7Wia7jNYYaRGdSSDXnbpLePcXy/StoNFtYBJ444PKzR8I4hQ1xxpmKZbKg==@lists.linux.dev
X-Gm-Message-State: AFuF++l5w1aWJe9tazdDNjG3dAZMA0o52euTykjB9t2Up3tzaswjdEI/
	aLEew90+Q+Relikg3STQ5KzRudy81ZI+4Cb1OTTRjj8aghzvciUBjW4Y
X-Gm-Gg: AYBFou18bf3QhHoKMMcwOWSu9XCYY7fYAo+NB8vIbbqRGi2Wanj5MLGEZop3j7aOBIh
	IuDoczRPqKHDPtbLD6yi0c0ZPK2ljlDEz1ubDNIDdPuEbVkqSOfCVU/yd6WTDoW0K+JeCACZ09f
	xjFFXpCyGPZcNh3PFnrv/YLG9if+sQLqiSRkvAIyxmgyhaRuK1b6smG7BG3Hlb+CQm7EIM7p7Uo
	ZUCOaeeyObzubv4ukkBPrtKrURYNahLwavGSTXSlhMejHjSTg4OiZS1g+Fev1nHCTvSaRp2/TTh
	31TS6Y2OhEOCxpmwBwWqGNDW4iwj5NV/vzhK0EHtgbP7GQFE4Q/tZ5L3oi7Iaoi7Wy/iP3tVDil
	0xJm8/0LSAGJM3ni1GOe90dZkdY++FktaQ1D0zKbEE6GuixW7KAe6kOg7ivPu9KjteR4yxjBRX2
	LAtOVIYJ96g2bS1nRTiCuH+BdOMW4GCglhAAoVyQJtz29vndvEFmOJdIhgIIqrF6RzWbiLVG5/s
	H0sgMPeVenJ7bo85t8e0E9t/rCgNPKxgq/6fIH71l4ml4pvqKiWXKHY0XqG8Ll9BdDn0FQM4cZH
	//WQ9Ywh+qq266RqwJQp2/7fpIji9aBH4FcvhiFip4VDO2ou1GY1/kN6rnPg/fC6xpJlQx+NCZj
	wU7jjNPpeWSW3+nG9
X-Received: by 2002:a05:600c:4e02:b0:49d:272d:74b4 with SMTP id 5b1f17b1804b1-49e7a6387bcmr171632925e9.2.1789452585275;
        Mon, 14 Sep 2026 23:09:45 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-afd5-c801-cc65-9ba1-765b-bff6.310.pool.telefonica.de. [2a02:3100:afd5:c801:cc65:9ba1:765b:bff6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d27c88fsm44282905e9.2.2026.09.14.23.09.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 23:09:44 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon: fix zero quota for PSI goals under the temporal tuner
Date: Tue, 15 Sep 2026 08:09:35 +0200
Message-Id: <20260915060937.3423-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PSI quota goal without a previous sample is scored as achieved.
With the temporal tuner, this sets the quota to zero for the first
charge window and the window after each goal commit.

The series is based on next-20260911. It fixes commit a68878f83ae6
("mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total"),
which is in mm-new and tagged for stable. Please carry this fix with
it.

Patch 1 keeps the temporal quota active until a PSI delta is
available. Patch 2 adds a regression test for the first round, the
next measured round, the round after a goal commit, a measured round
that reaches the target, and the consist tuner's unmeasured round.

Reproduced with damo 3.4.0 (b41965a) in a QEMU guest running
next-20260911 (x86_64, CONFIG_DAMON_SYSFS=y, CONFIG_PSI=y):

  damo start --damos_action stat --damos_quota_interval 120000 \
      --damos_quota_space 1048576 \
      --damos_quota_goal some_mem_psi_us 100000000000 \
      --damos_quota_goal_tuner temporal

then reading quotas/effective_bytes after update_schemes_effective_quotas
every 18 seconds. Without patch 1 the effective quota is 0 for the whole
first 120 second window and again for the window after "damo tune" with
the same parameters. With patch 1 it is 1048576 throughout.

The KUnit test in patch 2 fails without patch 1 and passes with it on
x86_64 and i386 (CONFIG_DAMON_KUNIT_TEST=y, built-in KUnit run at boot).

Karl Mehltretter (2):
  mm/damon/core: score an unmeasured PSI goal as not achieved for the
    temporal tuner
  mm/damon/tests/core-kunit: test PSI goal rounds under the temporal
    tuner

 mm/damon/core.c             | 14 +++++---
 mm/damon/tests/core-kunit.h | 69 +++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 4 deletions(-)


base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
-- 
2.53.0

