Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8F15821F
	for <damon@lists.linux.dev>; Fri, 31 May 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158316; cv=none; b=csROla49zY7OXxOj5rEoy08Or2Cxa68NXCVi5g2orSYxh9aTqBhG8RgFR1R9S06ssAPiNsh/HolJyB4fhbwlzQDERfoSGmPoaCFKh+a4keLJxUIvz7uaPYqhpIWPawmYRHK2uSlkZluRI7d3aHdDGSEpYADlCePfB8FGh7T+3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158316; c=relaxed/simple;
	bh=Xu57Mic/VAKaleyjNmq1lGIViGbB5waeZAH4tcozFGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8OtzZolRnErBadqRrbqQ0M3E6sSH029nWnLRwG92IVzuqg9SugHdZ1H2YDSG+3ntDsbwDsJ44/Yl7aBeuF+41BeuamYz6m2AzpjjvJP3GSMlrPH+jhlL1hDb/UCcbbA2rMQSvPUbkwDsW/fVgh+z69iRV/eC+Wp3EGxqe1cAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyY4P1a+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyY4P1a+"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b78c65cadso2630962e87.0
        for <damon@lists.linux.dev>; Fri, 31 May 2024 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158312; x=1717763112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7dB1Vaphz7QEh8gd4ZhHWs9xIKs+tgKhKDy/GfFnHg=;
        b=VyY4P1a+i+tHiseQC1MA4zbx8JZ3oSPISA5m/iLd1MwkueTfThDs9SEz293PhKDkDI
         Infc4JRaJsXpCo63m0xUHVNH8q+QzPQtZ07D/3jnpu76y96K9yXtc/K1t5PcxOu85p3c
         UCsusVxmElUqSyOt9NIWYf/dE5dxWKWT6RIPUjdm7GY/XnCil/tT3SxTXZTsCbzkzq+a
         kdS6LHwWt4/CKIOEhVSLbdb+XXN24vUzMG+2+TTkteynuhUkQsyI6os7I5D3bux4Hga/
         rXEl78RfnnMZKP7jMToRu+KBLLrB5W13d4yzZhBgTPUyBKW/oU8gxRz9Gkm6V22VcxGS
         dUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158312; x=1717763112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7dB1Vaphz7QEh8gd4ZhHWs9xIKs+tgKhKDy/GfFnHg=;
        b=s7YtEHRHX3PSFs6Sepnb1QIChesWSkWwAaWWuJoXSdFpNyrxn/i1JjLdP7VOcg0/2D
         6JBV4fHClIFKQQMMICsr1H3jZDopGBhkXSElLrnSrAfAXbKiymbDAuehvAoCznWToVsb
         WeaRDN2PEvD9JeO7RzggUbRlxFTWghwWPQ4dkSor9qV07kAlajYcmsegD5mdVk/yy7FC
         yp2LTnj1sTJ7M2lsm9MAlL5ubBtzlxaA93rd5LaDl5G2KARoWeuX4bx7/q7LPi7I9bm3
         E3/LLcBULTTMbiBEEVVzJJgWT2iS8iwkE6zfv0AbCWioITfCOihYUURVtzxWJOZ8IXLx
         2j9A==
X-Gm-Message-State: AOJu0Yxmy1myhhffHUjQZYc30xbhk4p2RSrE7KLPZN/34mvAQewQlIfN
	rE0kCTbCurgO996hx7aAHMOb4DofhW3h+IautJk2rBNgyjAxu7+nCwyinw==
X-Google-Smtp-Source: AGHT+IFDJf8CDdfg5tectpVEIPPxxiv3USawMSYJR1CnwC0UYvEK8mgBZOpp08KjenScRFalwvicoQ==
X-Received: by 2002:ac2:4989:0:b0:52a:e2cf:b00b with SMTP id 2adb3069b0e04-52b8957ea21mr1255904e87.27.1717158311981;
        Fri, 31 May 2024 05:25:11 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8ce24d60sm71688e87.290.2024.05.31.05.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 05:25:11 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] DAMON multiple contexts support
Date: Fri, 31 May 2024 15:23:18 +0300
Message-ID: <20240531122320.909060-1-yorha.op@gmail.com>
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

---
Changes from v1 (https://lore.kernel.org/damon/20240515152457.603724-1-yorha.op@gmail.com/)
- Compatibility for DebugFS interface is kept
- Kunit tests build/execution issues are fixed
- Patches from v1 are sqaushed, so that consistency between patches is
kept
- Added/Fixed comments about data structures/functions

Alex Rusuf (2):
  mm/damon/core: add 'struct kdamond' abstraction layer
  mm/damon/core: implement multi-context support

 include/linux/damon.h        |  80 ++++--
 include/trace/events/damon.h |  14 +-
 mm/damon/core-test.h         |   2 +-
 mm/damon/core.c              | 509 ++++++++++++++++++++++-------------
 mm/damon/dbgfs-test.h        |   4 +-
 mm/damon/dbgfs.c             | 342 ++++++++++++++---------
 mm/damon/lru_sort.c          |  31 ++-
 mm/damon/modules-common.c    |  35 ++-
 mm/damon/modules-common.h    |   3 +-
 mm/damon/reclaim.c           |  30 ++-
 mm/damon/sysfs.c             | 303 +++++++++++++--------
 11 files changed, 872 insertions(+), 481 deletions(-)

-- 
2.42.0

