Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4BF15575A
	for <damon@lists.linux.dev>; Wed, 15 May 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786712; cv=none; b=T4gFzZtg/gk1XZcboGrrcj6JGQKgVI/SzDdroeoI/BC5+zS0atEs6mHz2nBwez2Mz9s2tgSmH+Be/GhcreTIjy9K4LFit68hflzHjbaEz4fKjwswzrp8cbGututYVcEkvPAWdJBX2ZZ5yx7o12GuOeJJYVsHM31aWol3z+sLzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786712; c=relaxed/simple;
	bh=b1YHGKG4pPLsEz+xjOQOd63XKwncxOLztIHGWjjUzIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3zLHzvLm+sccdo8vskAmZ/WhnF8ruYzpdbIUaOmnQJPSGS9HmOs8mxIf+RMLEoOehFJoNSsrsUJ6LcBkwFgpWrgIcoJsvKEzV9YAt1WTez0DjS49hrE6LiF9fHLs6CDHJDV+cGyoaztEZCT3gdZWWc03T+iy8Ypywaf2IE7qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krLhQhy3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krLhQhy3"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f71e4970bso8306281e87.2
        for <damon@lists.linux.dev>; Wed, 15 May 2024 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786708; x=1716391508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHcTLazfYr8Wmv38UTue9nrXkjfCD1IY5FpaS72ofto=;
        b=krLhQhy3X2YJ918gB3qhtvNc3+mfuaTmjScHQHoN5WlvcCLuteFNsjlNp8DUOjVPLA
         IgTAZ9o8O8P/JRfUvhPN4QjmuWrVt27yZKIymCVXerbeLptcUfsfTyTsCLoqPsnYBnfF
         i4WdGguOIp6e5YjdYvii1ajopK5EcYFOySsalIs/kBK9+PzoDBhGA9VENcxrzdgCl+Nw
         2GKRoy4P42r0Y6TwtN9ABYLoow1nHiuJ3Fhg6mYsGrTMX2ITYUdu4kRBesihQ8Yc7FxY
         H3zXG4mkaXmBIjr4vGOwmf1zH28sHarcdpq4Pmz0uDsWOvBUtNyKXNfAhTL6h7/hGFks
         F3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786708; x=1716391508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHcTLazfYr8Wmv38UTue9nrXkjfCD1IY5FpaS72ofto=;
        b=VoBG+wIJ7WUzkvwICQcmVxuLk4VQopxhKi/BQXQV+0gDsKiV5VuoKDhm7N6UTNp4CF
         Og2VYksFSvUqJm+2EREJR+lOwL5kE/gO5VSBDgCbciREiO9K/7+Q1u9TS7LxGzLPQU/M
         1Lt20s3YIUf+j28AWdIftId8tom3+Qz0jzoXqM/OJE/taAXp6Y9R7HmKUD1dnF2pzPs2
         C9+8hbwscFeqI7O2+YLVFU5GpmSpxkH7KWgw1oR23+iyQG/bPUAWIfS/CxvJ/JOpulWA
         ESJ9+30Cr49hbG7S1q+PYq6skVSrct4W5GMwhTNS76/z+hn38IjPcxCcXn6w1QbeJr6A
         pZQA==
X-Gm-Message-State: AOJu0Yzpo9W+fvu0Wfg1Nv4QnpJLDESBwvmGonaWQs1ADSse8+24HOMV
	mXbQ4aAP1pJBtb/jcEVG2qW7shdaWkknsq53f/UN+jVIFVNd5VELdh9Kag==
X-Google-Smtp-Source: AGHT+IHw3v+cHarKRf+Ug4o8GwK1kOrzD9Lx70DcgBmuE4D9G2PWhsolumkAq7WX227zGcH/3yrBkg==
X-Received: by 2002:ac2:5f89:0:b0:51d:6790:b788 with SMTP id 2adb3069b0e04-522102779dbmr13286495e87.56.1715786708311;
        Wed, 15 May 2024 08:25:08 -0700 (PDT)
Received: from localhost.localdomain ([176.59.160.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33c3sm2646048e87.161.2024.05.15.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:25:07 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org
Subject: [RFC PATCH v1 0/7] DAMON multiple contexts support
Date: Wed, 15 May 2024 18:24:50 +0300
Message-ID: <20240515152457.603724-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Currently kdamond uses only one context per kthread
and most of its time it sleeps, so utilizing several
contexts can scale kdamond and allow it to use
another set of operations.

This patch-set implements support for multiple contexts
per kdamond.

In pseudo code previous versions worked like
the following:

	while (!kdamond_should_stop()) {

		/* prepare accesses for only 1 context */
		prepare_accesses(damon_context);

		sleep(sample_interval);

		/* check accesses for only 1 context */
		check_accesses(damon_context);

		...
	}

With this patch kdamond workflow will look
like the following:

	while (!kdamond_shoule_stop()) {

		/* prepare accesses for all contexts in kdamond */
		damon_for_each_context(ctx, kdamond)
			prepare_accesses(ctx);

		sleep(sample_interval);

		/* check_accesses for all contexts in kdamond */
		damon_for_each_context(ctx, kdamond)
			check_accesses(ctx);

			...
	}

To try this you can use modified kernel[1] and
damo[2]. I also have written few simple shell scripts[3]
to collect data for damo.

	[1] https://github.com/onlyoneofme/damon-multi-contexts.git
	[2] https://github.com/onlyoneofme/damo/tree/multi-contexts
	[3] https://github.com/onlyoneofme/damon-multi-contexts-tests.git

Alex Rusuf (7):
  mm/damon/core: kdamond_struct abstraction layer
  mm/damon/core: list-based contexts organization
  mm/damon/lru_sort: kdamond_struct abstraction layer
  mm/damon/reclaim: kdamon_struct abstraction layer
  mm/damon/core: rename nr_running_ctxs -> nr_running_kdamonds
  mm/damon/core: multi-context support
  mm/damon/core: multi-context awarness for trace events

 include/linux/damon.h        |  48 +++-
 include/trace/events/damon.h |  14 +-
 mm/damon/core.c              | 497 +++++++++++++++++++++--------------
 mm/damon/lru_sort.c          |  31 ++-
 mm/damon/modules-common.c    |  35 ++-
 mm/damon/modules-common.h    |   3 +-
 mm/damon/reclaim.c           |  30 ++-
 mm/damon/sysfs.c             | 306 +++++++++++++--------
 8 files changed, 629 insertions(+), 335 deletions(-)

-- 
2.42.0

