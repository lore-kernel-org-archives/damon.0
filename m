Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5EB2DF6E9
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123167; cv=none; b=Xsm49egM/z2Rxa30a3fFfGQfXal75xsvJKgzK+rwS+BZ1rZFDjtsr1a6jP4tsGsWniFm31h6DNqodJ0EMd3NcWiCh4X0IMJZ3DfWsjgxyzYDFFDxugRFcqCTHjKVbSYqxN7LjwW8/GKdQBd0fQUyvQMv2upDPajN5tjB51H2SQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123167; c=relaxed/simple;
	bh=2UkxcYpEpjXUSVhtjAB1jX1sZrCQUIpz57c0kmQK6Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3dMqvP2W0qXTvQQKdYS8tiadafK+ATrxWSRGZE8Lgrpe9vIHSjDb/VjGuJJIpQM8WsTruKTjQQyCcW1Ps2UbglT9tqMmcfzwDsvXZtxo4Lj6NDxXGmAmcfJ5smEqq+vqEwUKpN/K6XmW1kGjRonsyxN/NKZbXwcfZK5xIZlILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1CkXX6p; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1CkXX6p"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so1872215ad.3
        for <damon@lists.linux.dev>; Tue, 22 Sep 2026 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790123165; x=1790727965; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLteDfPUx3uF6M02dhFfxPuSSO1R7kydwzqevjI1MZM=;
        b=q1CkXX6pw9fzd4RQ0GwRbmr8jmeX8JqBO1UdnJmqMb9YFwUL4rEc3sK34FEaubxQbT
         br67+sAk6ijyhgUemAto84L6dlq4UQBqZmiHMK+BGLnwGpB1B9QRutZsx4o0dXBoE8Dx
         nsnYXeRR8TtG0zrQkhBKkEK/8yd9PCqaNtEgWTVvtFNaJDk1ZAXMEMAc8BOMW0cSavhu
         F08iT9waEGkwPvQugi2EXH2xf7hxsS35Uuy7KYo7PaT1tKHJThhLET0e+YBA5LUfEV0S
         SBxlg/9AP7n+hBOcLrcrJBvaKTXHdHX3n/Fj9teimlOvrYgMsOyFFCo1oD+CIEwnfu6z
         eJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790123165; x=1790727965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLteDfPUx3uF6M02dhFfxPuSSO1R7kydwzqevjI1MZM=;
        b=j9kc9IlO6B/wm0zwzZeoj3XlhH5AQ1/iEiPYQHu3xZ3D8wuAgRxSoSl9tdHJC6qbI9
         Xq4g2flluJSGwTnqlXDQbT/W1ygk9jF76+M2ZuhLrSus82PVDx/DbTQ5AiRz2VnYjhlm
         zRNBjMfxQ+1ZAyPvqep+RA98X1zCeoWPelc8YerAt9Q2uP1ErvVPXtK167UKF7gbFl6U
         eHoEDmbxHmV6GwIbEtUj0GdeQeFXDKK9yrZXFq71K6q/OixNdiwzh5urRPFxBJzo8aZF
         xjimSnv7S6qT2F/zYlmMDg/fsYi/aiAEJ5bCQrKRC/PBBMVsRse/3OHk3unDIOsbHgYQ
         yjcA==
X-Gm-Message-State: AFuF++kwAplVilwTtthZoWkKoy/mtStnid6dAfr869WC7VXQgJb1ETl3
	NRzsorMggD4KNRpJcIkI2aGyNtO9PYiE6e4S6RJXXOSpfvJwyC1VH4A=
X-Gm-Gg: AYBFou18CTV6TNtjXj9a1Zd8sC6P+y26wQxlatvS41ATQC6e3SVAxSgD5eAZ7kEXp6s
	Bvnj3nHIbPL4Lxj0nSZZfiaoM+Z/n+wdOC4xinbU9RFDVaprO0bv30MX94J7sNLQjZwSeBP3o2d
	oa9e+fZTSkgvNeqe0ptZDb94v26fhRFTjxhkKPmxKrM0LTL3McLdAJ1Ky/zcmyaR/aeCgoKjDLD
	cQyHMfscp08//uVzeipEmgCSbBgmW6x1aROpwsQTBnL9QO+nXj1a61z9hhnEco7XdInZqx+IRez
	xdSrsrtSbKmtaXK0LR73yyZAqtkyn2XW3nDVYbsVglQnQw2ZThPQNJwnL6f1Xf8Gru0f/RT4W5Y
	NTJa0eo/NIceN5JT0QtlZmBie5xkNLxmy/Wvr7OoUMI9UgWoO+v0+MDW+up+2iajq9kDWPTMZ8t
	rz1e8CcCTTm97ka3Ed0ymSIPhbh9I1vg0KzecCurqpDFNYErWwwF2g/a/GH/TWclEhzwsX0hLcE
	aP0OubzDnoeXn97H1stCnOeOENs0a8XIuewyw==
X-Received: by 2002:a17:902:e552:b0:2d9:3850:2741 with SMTP id d9443c01a7336-2df69be125cmr8314255ad.0.1790123165341;
        Tue, 22 Sep 2026 17:26:05 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:2466:805a:e198:cde8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b76sm2176595ad.20.2026.09.22.17.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:26:04 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v4 0/2] mm/damon: fix the temporal goal tuner's size quota conversion
Date: Wed, 23 Sep 2026 09:25:57 +0900
Message-ID: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() hands the size quota to
damos_set_effective_quota() through quota->esz_bp in basis points, and
the multiply that gets it there is unchecked.  On 32-bit it wraps above
429496 bytes, and a wrapped product below 10000 divides to a zero
effective quota.  damos_quota_is_full() is then true on the first test
of every charge window, so the scheme makes no progress for as long as
the goal is unachieved.

Patch 1 bounds the conversion.  Patch 2 pins the boundary in the core
kunit suite, where the new test would fail without patch 1 on any word
size.

v2: https://lore.kernel.org/damon/20260920023111.2466265-1-donggeunyoo.kernel@gmail.com/
v3: https://lore.kernel.org/damon/20260920122411.610213-1-donggeunyoo.kernel@gmail.com/

v3 was posted before the discussion on v2 had finished.  My mistake;
this version was held until the thread settled.

Changes in v4, from SJ Park's review of v2; the code is unchanged:
- patch 1: drop the 256 MiB mention
- patch 1: say what the user sees before saying the setup is unlikely
- patch 1: cut the closing paragraph to "Bound the multiply."
- patch 2: unchanged, and carries the Reviewed-by

Rebased onto mm-new 8d29b5365d52.

DAMON kunit on x86_64: 39 tests, all passing with both patches; 38
passing and damos_test_esz_goal_temporal failing with patch 2 alone.

Donggeun Yoo (2):
  mm/damon/core: prevent size quota overflow in the temporal goal tuner
  mm/damon/tests/core-kunit: test the temporal tuner's size quota
    conversion

 mm/damon/core.c             |  2 +-
 mm/damon/tests/core-kunit.h | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.53.0

