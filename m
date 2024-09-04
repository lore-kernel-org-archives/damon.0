Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16443D62
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411619; cv=none; b=NW485eu3Uu/Pi3laXtVl5xzQdTb0nBwvTWom/JDFnvJUUPu5K9W/8Q1YSjHuka22NXIg/MCpuY1Op7kt9bIXNyNfNfr4pg5HsPS7JxFesKfnrkt08HaMp4+cC09CSpFqtEe1u+8ufOXPLDafxEWhzFy3/6cOKSER+hzI+4TY1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411619; c=relaxed/simple;
	bh=CwcYhze9qqIMcUkl5WUYcKc314Oao/Nbll/alQXAjLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oT1DjvEc5jWHyWDt7dAUn3LmEmY20OQcXtR9NzhKplPi/+dDrwSGM3IoISD1UDaXqZPUkT5mU5zFwYazeHm66vHwbxtRmUP4Vnd8/uD1hWwKDxsDdDBOeZ/KMZpA/AE5wdN9O2eK1P26B6+tMGzK7wOjexmUt1u7tC87d37Pz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osc1AtZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osc1AtZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F09C4CEC4;
	Wed,  4 Sep 2024 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725411619;
	bh=CwcYhze9qqIMcUkl5WUYcKc314Oao/Nbll/alQXAjLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osc1AtZucbeK1cUV81ML/OV7pqlkDX5Fqc1hsjr99dlETpPhwP0EJXbIqa9o1QPFQ
	 kLyRb8EkQ+KBwmv9VcYeFZ71MPMmNdag66fTEEZEUngiQhu5FWJ5yr57dXH4DqAnh6
	 JsRFXSRQSUBYEDwuGZcz3m5KZsgfSmzl7rs3t4FKpG8BooIkfPkhqfbdoGWNyqCLiQ
	 e0IRqdhqa4wbGG6SqC2QAbMsLWQb9sAyXr6DFg1sAwCFT8uLB1GW+Re0M2VzviKeNj
	 oVlXsE8gphXpF93tfB82yX7RcyT+8LWMXVwsHqIvB/xSFYRfFh1dcDc6aSGml9WCzl
	 75GxAMcD9OeTw==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Problems running DAMON kunit tests with spinlock debugging enabled
Date: Tue,  3 Sep 2024 18:00:16 -0700
Message-Id: <20240904010016.1451-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Guenter,

On Tue, 3 Sep 2024 12:23:50 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> when trying to run DAMON kunit tests with spinlock debugging enabled,
> I get the following error messages.
> 
>     BUG: spinlock bad magic on CPU#0, kunit_try_catch/209
>      lock: mm.13+0x40/0x840, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
>     CPU: 0 UID: 0 PID: 209 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00148-g178297ec52d6 #1
>     Tainted: [N]=TEST
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x9e/0xe0
>      do_raw_spin_lock+0x63/0xb0
>      damon_test_three_regions_in_vmas+0x121/0x450S
>      ...
> 
> This happens because damon_test_three_regions_in_vmas() calls
> mt_init_flags() with MM_MT_FLAGS, which sets MT_FLAGS_LOCK_EXTERN.
> Because of this, the spinlock is not initialized, which then results
> in the error message when mas_lock() is called during the test.
> 
> Unfortunately, replacing MM_MT_FLAGS with MT_FLAGS_ALLOC_RANGE |
> MT_FLAGS_USE_RCU or just with MT_FLAGS_ALLOC_RANGE doesn't help;
> it results in various "suspicious RCU usage" messages.

Thank you very much for this report with the grateful detailed investigation!
I was able to make and send a fix[1], thanks to the investigation.  Seems it
may need some more revisions[2], though.  I'll continue discussion on the
thread.

[1] https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org
[2] https://lore.kernel.org/jy6263g6em4jsdhp6tknmh2cljpuvq652kvcet4ko3z2xt7pym@ltc5h5twsszu/


Thanks,
SJ

> 
> Thanks,
> Guenter
