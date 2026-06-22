Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA03B6361
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136223; cv=none; b=VLQBVObWDxIdVNgHFPPpYBAWNfpaoOqGu44QPOEWhRuBK8KkrUWwVlx/xOYB+ulCFbF5Vgoq96QlTknh66X37FxbG9U0tILucSFTe0N3rsPaPBOQsP39pqBcUbvkdV/w8YZEmXe2hScDBQX1EaLXm7Ut9gZLnwJLa/msRsyAzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136223; c=relaxed/simple;
	bh=8Gu2tJYFoyb5VwElQkcHWnUWNuKHdvLf5o6HzO83OjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3L+SxlMhhb7wJCthoFz+oDb5NF7XSOG8fdnhb9+SjXPnZq0id8HV2xj4B8QbMSdFWFVZHfOqVHgJTZS7kq29+K/yyAK8/sgRf7i2pipSDq1E/W24QhhK94I9Zttf7/Q4X6N5IRi/gJu1OOOmYfIuuxj4YvOZg8gCQaDQ28HzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9fWYHnA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9fWYHnA"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845438a46d4so2280718b3a.3
        for <damon@lists.linux.dev>; Mon, 22 Jun 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136221; x=1782741021; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsDqfnUc8Eb+3zE5VclFey58OVxE0obrmPbjDO3qhv8=;
        b=d9fWYHnAs0iVm077cgVFtv0xMFox5j/W79/7blQD3v+T+Taheg72136xe73H9tXzJi
         HAeZ5wgrFniTc38056lMarZvE4rI/mCg2ZIJlID87C2addUwv+wngxqn2bxSCq9EGPvD
         w8H5T7/36rXuA4vhm6gqI9Ww4YboVb66oXNS9KG3FFpipxkYLW38+UmKtA9WKFySQTYW
         D0XDQHPgCw9p952W7xaNUgtbEZSgN7/VGoTWUiqcnPmx43BmdJsBIQKet9Xz31rs0CM4
         idgrgtd/1nh//lvx5Ic5jP5OOPhyoELzkJb4tYJcDyv29qSV2rnihITkAeH4WdI0ot82
         pDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136221; x=1782741021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsDqfnUc8Eb+3zE5VclFey58OVxE0obrmPbjDO3qhv8=;
        b=DBY1eSoSpkxNzcxcdgv713w4LEXuoF2Hn30vtQOHoUVs4/o7wktUogJ5Zx3P0mMIed
         BZs9fS9CxrshJIwIrm51ZDzgI9Ff9YOS6ccJeLawoy2XP8LDU0ClZXigqf4zTkszhXc2
         vHqQJj/4Tq/vO3ORVT3zTBNTM6SzaiAfZ9Cs7gNk6za8F41lo874LrScK8AGBs1iIckq
         362nNYdWg9e7Fm5s/KPh7G455WS1Z+ORV2rXWMTbmMo7i4VJSL4v7FnGg7ybw2GH2ozF
         jF5GjyL63rjgG7mX+IiQQUivKlymHubkIG36vtcxCAW1203yHDbcq8z8ZuaWXX9oDXYf
         5gtw==
X-Gm-Message-State: AOJu0YxFjwnQtsIqqWyBGY+ZnfumjkN+0tQKkoDVxFOEjqSmtedxGVjM
	CJncEjUycf7Sdk6GHe/RNQIrpb6foOEYJmobP8ENE5DHKNDO3tPTTPR7ojZ4cQ==
X-Gm-Gg: AfdE7ckUIwO+fVguhBgn85Ad18zsmP7el0kIcvA+Nuv4+KfBdXaBeLa1+yb340RkIdU
	tZauKe4UEIpocF1+Ffjj6MusDLHpm8Khh/qKy1ZKMUw0iFrKekXQp5nwMRWAn8qYhMWsHd5pRWe
	YfDgtxUjkrcRTYCuK5gGrh7xgwV1GcBdCl8e5bEnjIqR+YzEMD/viKnXYUOmoJKCfvfNzSdZPGF
	WdSJYgLjRIHteT8cvKQMB4wlPIzw2PESYUAMXdVpee4zlP+9ddFd7dsScwoMcq/GG1O3Gb0N/C7
	rO+6y7uIBikA3USIuDL2Lg8E8mE9/xzezOJsIQMnACTV+znA1Qh+utT7oUeUKyzl2tRROfTqxU3
	eP27EXjcYuqlFjlShJxBgdUm6dhLstjeWAEpLZy97JWWD9bRrwfMJBspSehA3YBHbkV2hxsRITC
	owZdVfrzP53R1hmqjDsMWE0D9gLA==
X-Received: by 2002:a05:6a00:2d82:b0:842:2280:5386 with SMTP id d2e1a72fcca58-845507bcd5amr15524294b3a.16.1782136221256;
        Mon, 22 Jun 2026 06:50:21 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:47f:2522:acac:f810])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea146asm7606177b3a.43.2026.06.22.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:50:19 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	ravis.opensrc@gmail.com,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 0/2] damo: support perf event configuration
Date: Mon, 22 Jun 2026 22:49:31 +0900
Message-ID: <20260622134933.35773-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims to make it easier to specify the perf event settings
proposed for DAMON by Ravi's hardware-sampled access reports patch set [1]
from the damo tool.

It consists of patches for the perf tool and the damo tool.

[1] https://lore.kernel.org/damon/20260529165640.820-1-ravis.opensrc@gmail.com/

* perf

Akinobu Mita (1):
  perf python: Add access to various members of evsel

 tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

* damo

Akinobu Mita (1):
  damo: add --perf_event option

 src/_damo_fmt_str.py |   5 ++
 src/_damon.py        | 106 +++++++++++++++++++++++++++++++++-
 src/_damon_args.py   |  79 +++++++++++++++++++++++--
 src/_damon_sysfs.py  | 133 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 314 insertions(+), 9 deletions(-)

-- 
2.43.0

