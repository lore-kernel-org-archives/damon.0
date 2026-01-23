Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE937FF5C
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134279; cv=none; b=HK+FKxt7sI9P0Vv1C9GmgBAjNXXLHuOeu4V8hOQ7GVTH61wtvd+SOxI3XzCQ9WNGfDXaeDlx8q6htdiRbF6COgNfCggUo2iMHtK6/OJZAvKujO7KKfMLGH1RJn6tDs8hXoWxm0QlS0NK/88ZZJydNuSqthSvn7dLXzSiriMiirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134279; c=relaxed/simple;
	bh=iRcGztL59oQz2F9s//Ez6uFEF6sBrjofnUDecH6xjtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGNR78WBzxeJvXzHxieOEfW+F5PO6XBueCicmuSXd4sPEE+NoU7+yp4c3Cdc7kaOVNr6kQA/2e5X5bv07k303lst6LLZNeLdjQsYS/llJHwH043B5cp5rbtZEkZIKZ/HIWke6dbzylfj16HEXryY9nRkCCvlpHQsFwoi32H2qoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt8wlphT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt8wlphT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso954548a91.3
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 18:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769134252; x=1769739052; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qX3VefXiDDiYtgkNsRYKhrdDRiqLN9sZg7x6sg5tu40=;
        b=lt8wlphT+8E69BhFaOC5TVGLYa0eiSqJer3cD4FPa0JnFgfh0Wp2DjdADq23Okh8bS
         HY35sbSV3PaYmOevCRCihZIdUWnd3K0+BZXW8dWqCThAIWExjyPHgs6GYJ3UhXOPTqHF
         tlvPRELjHoOZsDGypHG8q79tNL/yz8p1s9wZvhafNVya+DVaWaHpnWFri3sGtRVQfZgz
         vH0h1biZEfZrBgOSZrtimCqfoL5C1zcy1+WE4AQXuezUIbPI0no4AbPlNagUvG1UDKJf
         cgWzRLJ3fT1s2ZSjAOJTGZhjyFqa/AUdu5lfA/czpulWXVGFEyj8h217ubUnreDf5Ev5
         v9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769134252; x=1769739052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX3VefXiDDiYtgkNsRYKhrdDRiqLN9sZg7x6sg5tu40=;
        b=hr1gNybbZLBXgq3/JIu2pwZklPYDmkqoegD3z1X+oKZvK6/nFrF/rhAxindPRRooSy
         hhseBG0E3mkSKutQcsX5VEwM02wC3QBqqS0nAaSrY4yN8Y4f2TRbD2uQuX/GaHfwcu+F
         06yRAKXTH2K/+/w/vra7l6v2VJ8MTcEQcIdhZQJe8QVO4Zk8/UMqGrlyXrSB6KwB6W94
         cydj5i64zGm13VVUX5BgJSTEQ2PE+SbJjAndqkMgU6nyWy9HoXZuH1ge19xdGnP7B/L2
         H1xo/A0BFPxwolhC1QdQVAUQ9dZwXytIpeEvHj0SyO68D/CYBr54G6aUnAnV2mI9CIJV
         SgdA==
X-Gm-Message-State: AOJu0YyI0oYjtFWiek3RFwZSEXrUHjSYf8pHHTiDuK5E/6rgqC/Plgw5
	H2bLNZWkiz6oMFuA9WmzQI9scnVdDD+Fe2BgP7j/vkrHUQL9nxFNSex7iYzVjGjq
X-Gm-Gg: AZuq6aImTKgt2W2RQVYU96ZxNDg4vwujYJRGg9De8gFqhMP3g2ONz/+4+QFyMg1cEMR
	TPxRR5aI43AF0RIhhmbCEyCnZaeVlEwxZuJEPt8HpiPr6nZOCzX64dfkCAuwRcETrS7B7A2MjKc
	0RtTgy5p7kBrCwHfyqJcFfdlpNFmKc/E5NfxyMPy357vAWDENQ80pVEH8S0jaN3MNHs0sj68Qas
	Q9f7wE9zH5xhdEMMJXyOATNFA3c/w0kJL+/i4FyBFa1FEAYkmX+/Yw6EtX9j35GG+xCHFG6jXQ+
	8fsOC0Q75KUJFSd9U8AlyiSa+gpS0weWyOwCobeqnm0OaxmQA3esR64QLqQlPA6B18SxFGoIAOx
	7dIemcjqsEfAPf3iy7k6xoK4F3lp+4gVTCat6vZ5ep+UikqGixdlo/R9Qel2/HcSYtfU14YDq0u
	kdaSthv+8A9iA5b333bqKP2J2TNQ==
X-Received: by 2002:a17:90b:1b48:b0:34c:2db6:57a7 with SMTP id 98e67ed59e1d1-353670151f3mr1113610a91.8.1769134251481;
        Thu, 22 Jan 2026 18:10:51 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:a458:c153:e5c3:234f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3533521707asm3544251a91.8.2026.01.22.18.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 18:10:51 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Fri, 23 Jan 2026 11:10:10 +0900
Message-ID: <20260123021014.26915-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON currently only provides PTE accessed-bit based access check, this
patch series adds a new perf event based access check.

Since perf event-based access checks do not require modifying the PTE
accessed-bit for pages representing each damon region, this patch series
also includes a feature that allows you to set upper and lower limits on
the damon region size to enable access checks with finer granularity.

Using these features also requires modifications to damo, but these are
not included in this patch series and are currently under development in
the following branch:

https://github.com/mita/damo/tree/damo-perf-for-v3.1.0

Any feedback or advice on the patch set would be greatly appreciated.

Akinobu Mita (4):
  mm/damon/core: add common code for perf event based access check
  mm/damon/vaddr: support perf event based access check
  mm/damon/paddr: support perf event based access check
  mm/damon: allow user to set min and max size of region

 .../ABI/testing/sysfs-kernel-mm-damon         |  11 +
 include/linux/damon.h                         |  42 +-
 mm/damon/core.c                               | 202 ++++-
 mm/damon/ops-common.h                         |  39 +
 mm/damon/paddr.c                              | 106 ++-
 mm/damon/sysfs.c                              | 402 +++++++++-
 mm/damon/tests/core-kunit.h                   |   2 +-
 mm/damon/tests/sysfs-kunit.h                  |   2 +
 mm/damon/tests/vaddr-kunit.h                  |   7 +-
 mm/damon/vaddr.c                              | 690 ++++++++++++++++--
 10 files changed, 1425 insertions(+), 78 deletions(-)

-- 
2.43.0

