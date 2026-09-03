Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402A31F984
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405246; cv=none; b=W5Vsc20LNF/FNqP0nhBVOlZmUcyjql/pY5uMzceneO4Edwj+N3nLu62WHfc8s4YusPnQ4f3uL3WVHPWz+hQWdWsx/wCyR0gOrLl/Rl/Zc5oRmdXzOmndJDmGVGs9+QmWQqioPX/SuMd2ZJmx1JBFo4kBVhiDG1nGyAGrKQlTXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405246; c=relaxed/simple;
	bh=Gdn6FlTTrtnoQY7PyAJfU2F9mE8bnDKAHVlEH3i2pI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBjWwzvmTBzqwxKC94YT0nqwfRz9M6VQmiOEjF+JMXB1ombdsgeDJPFFW03NfO2Scy5VEJy131eou+jXUMczVnhFjWGS8KkJ9bU6giPPIn9Yrbjy0vt/Al4uCNmNa5PMwL587UA/6N81ZLrFB0TbuEQAWOCUOXD8aD6xubRbjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZXFhxHA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZXFhxHA"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d9004f39d3so22250565ad.2
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788405245; x=1789010045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vESU/1COBgvnCI0rsLCZoKytSIIaf3V11jedMnJg7JU=;
        b=aZXFhxHA5NJS5xHSfYs0O/Zd35WnfZW1ssxaVEylSIxHE7Odt4LkWHI6EAc7oSVrr1
         cGeBDbFjSlsSruQk/1N8qsB4oC1dVM7Gczn4/UeXbGNvC8LmkTU/9/UQEdaOWVXXq71M
         dCxivI5+D3dpwR1tVmuXSCPfz3q7nHxaI0wlXbtDipOYy3k9lqpE6amrwYKsnBZEJASy
         9Lg5WSv8ezkErFiqvBPASptzsNOVS+H/YLnss/dZVC19l9R8qWUCNDtCYVmGfht6kMsj
         jovkxr4TDdM/FfOzLdEOjCtim8MU8swJF1735nCUR2Y65gIpmIzkzbPjAMtqtAo+eOCQ
         +CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788405245; x=1789010045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vESU/1COBgvnCI0rsLCZoKytSIIaf3V11jedMnJg7JU=;
        b=PxlyXX/DAjLWOENCiOM3Pi1VKDxJdJ9DMzyoGe35e9bm1ApQUA4FAI8cWO8+7VERvy
         kj2YIr0BirC937lgjG+7FBbqYyDBjJAPAw3atz/UA2oJXcrInkP2CQzuyUBHIPj90C5I
         4xuQnQbbxlxSv9JGtwWc4lf/euFwTtxA7JMPnRHGo9SNpCG6ratoFIZGiJ2KlecwtT3A
         fCKSUSWRelkEsKgt57aJbPRGrqQopadr1fpm//p3tb4N3Ja/4rAOihKvJzq/Kpu7+7UE
         tsWhIGgZfgDXJTg9b1CM9d/AKvrOYz4bKVeqIB9UyGtA3oA51hSyphrkeaWVJypk8gpG
         UctQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzhP9j9MGQMnWNkGkq1IablFfokFs/pY7EWBYXjoi+FiPf8bQqupS4ioxAvVSMK9ctfHCYww==@lists.linux.dev
X-Gm-Message-State: AFuF++kmLQBFo0dQoqfjTmh5Akk7XV/NEJqkMgsEYOrecN4yBgiWJyBc
	v0fXb4N72+gBcGOXKYZOPhKQvLsAK5Jq0nY8+qnFolEhaVo0JMH3GYhS
X-Gm-Gg: AYBFou2X3wHrdJ2Gr4Va1ZOCe5cUVH+Ul0M5ZzdI3lXExDSWQ7Nf4Q610F3OAltqSt9
	muwuk7l61Z9O5Zx2ze/hPIQvmWrZXTEA2YRCw2pBFi75JchtuCi5EnPxsYw8h0kvQHOumkSYTnD
	q+yD2w/2s+A4O4TBhmJKVYnVocyAP979WEGtP1ALBO4+fI4i/hUfij42NIBEV6LgM9eYc5LVsJV
	omSYG8s5roII6zeuFUFU0FoUxIsG+J7UFpp0ziZuJZxj2LacTfwkrBbCMAEr/aKNYoTkvDCIkzk
	5tyqvxrR5U6mRbbIVWm9zw1ZPDDFMnpq++Devl5WTUYDMdr4IP5u/CXjQgzX/oc9ZIpkimG81er
	MUe1cuUXYORLifjNkqpDMryOCTCUsM8YEdozIJJcj8HjF6HHtyeuaFn+a0e/Dg1/zfoVHxv0xBT
	8jwOrsPi0O9dRsoezd7IbjetSJMhGBDOJ38Y4gQAjA6WvNEmLQ3242vdnAh6a8jLYdB0UiDHE0x
	/IJ4uaMXcyXAN1DVLw5sdCtDKbI
X-Received: by 2002:a17:903:1aab:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2daf1b16445mr104380145ad.3.1788405244535;
        Wed, 02 Sep 2026 20:14:04 -0700 (PDT)
Received: from localhost.localdomain (vmi2317720.contaboserver.net. [84.247.152.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe0e0d5bsm2824825ad.12.2026.09.02.20.13.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 20:14:04 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon: fix misc bugs in kunit, quota goals and sysfs refresh_ms
Date: Thu,  3 Sep 2026 11:13:28 +0800
Message-ID: <20260903031345.82679-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902002725.108635-1-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

> Patch 1 fixes the DAMOS quota goals commit unit test to cover a
> mistakenly uncovered case.  Patches 2 and 3 fix the bugs in DAMOS PSI
> goal initialization and eligible_mem_bp online commit, respectively.
> Patch 4 fixes the bug in DAMON sysfs refresh_ms file handling.

I reviewed and tested the integrated four-patch series in mm-new:

  a20e38846efb..72dc8fdaae62

The integrated commits had stable patch-ids matching the posted patches.
DAMON KUnit passed 42/42 tests.  I also ran test-only eligible_mem_bp nid and
two-kdamond refresh-isolation regression cases; they passed 42/42 and 43/43
tests, respectively.  Both test-only changes were then removed and the
worktree returned clean at the unchanged series tip.

These were functional UML KUnit tests.  The fixes look good to me.

For the series:

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Tested-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian
