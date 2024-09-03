Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE91D5CC6
	for <damon@lists.linux.dev>; Tue,  3 Sep 2024 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391435; cv=none; b=b5/SckzjPIaIQimxoCE8ixsBlPdO1o50KNPd3pbVMQgXFcjc10fw+5yn/p4ojSwvGVdbvCU2SCQQPkJZ8z+N1XUdIb+VJx8HI9/gq/mS4d/z22f1Cf5oPOwXAdfpX9TIIN1IyQtgifrHhqJ4dIXZzp/hw++J1mfPwXVCC92wexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391435; c=relaxed/simple;
	bh=EP3iInL49PGoV1CMuDDe1lXRpteic2nVr1KTrzOyde0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YTHJyHfReTlc4CkyXgmJhJ4Teai0LSJpOrgtdfxEOKpXMbmi8Nx1kF+IviWjUA1lhFmG8+vwVbebHjkslKI0sFjtDkMxb5xzW86Bd6kRbsZY5jDbHtzpQ+XzH99JpXvyoNcwh9An2fuxsMcgaqavAzXho7V2MLhINjNKt9bkPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrk9STQq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrk9STQq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20693995f68so10493435ad.1
        for <damon@lists.linux.dev>; Tue, 03 Sep 2024 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725391433; x=1725996233; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lpr9qgSmZYBMesqbPeUKXEH6JO1CDn5DpSTecWevTbI=;
        b=mrk9STQqR5prptZWeA3grJoYnwZbPRqtPKIkvckidwhyXS+4cZIAz6ivyDaDoFWSps
         Sw/cas2ltWYjqo9jYX4P7LZv//niefahMnU7OAk/ePSOgvs/MkJgi3zXeD/pKZzdi6AP
         5yBrLgS5ccDgaxlw/C6o7iiSN4YQMnEwB9dza42Zy2Lqyc+vgQNRlN+uLTAieSLjPaXm
         0ICcTVvIAqELG1iVzK/hdPBqTdpfEVgRszpMOYgl39er5O/Fu64vBtRDWqt7gC7b6UgK
         u9xXfY8jXHMHPhfjw5JN3AexoGiAMBaODwBAaeMyGLoHb+PBifCEF54ZZWzz4nxEqg8N
         TXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391433; x=1725996233;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpr9qgSmZYBMesqbPeUKXEH6JO1CDn5DpSTecWevTbI=;
        b=ce/C5WVsU+LwoC/iy5WufiRci/LLa0Qxus7tq8SZamLddSkDDPZC7m39L6IsMpLoan
         uMkkjStf1FpVso/c0yCliRIt0UmnAUsxXJxyolg6ZJ9sf93EACgRFob9MQIFzLpuaHJf
         EVC6uSUpaFg6NJ0s33xNyKFOxu+81xgQTf6DHGiOuFvtBjUqmnCLfUUDq6JqHdgSm4Zb
         CSUfA5dmfK4z00c+O8xw4/b73GGrKpW3w28xw0ynlP/E19KTrXUFVD/5Q/jkjZ6M5vK/
         dNTeA9IimxM2Md7vDk/uc87WxwUb8nH3hXM9NFiFUDQRoI6LKa6TxkJRayIDEVr1YClw
         Z28g==
X-Gm-Message-State: AOJu0YysRxUoWa0ZI0axVpQtKTTR3mHfAp0P8mz66Xis9aQreHt41zMh
	SoKMfmShPvasuxbT3I5T7zheRilBMONGrcHNSppEs7zA3SL7mqnQ
X-Google-Smtp-Source: AGHT+IE+WooY/ruxIXLS5FlyLttngCJH0j5DYtgLLgy7wkNisZouVHHwS/rHIMcl8rrXuUVKvMjQIw==
X-Received: by 2002:a17:902:d485:b0:205:6d75:8fdd with SMTP id d9443c01a7336-2056d75914bmr83764075ad.28.1725391433400;
        Tue, 03 Sep 2024 12:23:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea333dasm1865425ad.163.2024.09.03.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:23:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 3 Sep 2024 12:23:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Subject: Problems running DAMON kunit tests with spinlock debugging enabled
Message-ID: <1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

when trying to run DAMON kunit tests with spinlock debugging enabled,
I get the following error messages.

    BUG: spinlock bad magic on CPU#0, kunit_try_catch/209
     lock: mm.13+0x40/0x840, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
    CPU: 0 UID: 0 PID: 209 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00148-g178297ec52d6 #1
    Tainted: [N]=TEST
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x9e/0xe0
     do_raw_spin_lock+0x63/0xb0
     damon_test_three_regions_in_vmas+0x121/0x450S
     ...

This happens because damon_test_three_regions_in_vmas() calls
mt_init_flags() with MM_MT_FLAGS, which sets MT_FLAGS_LOCK_EXTERN.
Because of this, the spinlock is not initialized, which then results
in the error message when mas_lock() is called during the test.

Unfortunately, replacing MM_MT_FLAGS with MT_FLAGS_ALLOC_RANGE |
MT_FLAGS_USE_RCU or just with MT_FLAGS_ALLOC_RANGE doesn't help;
it results in various "suspicious RCU usage" messages.

At this point I gave up trying to fix the problem.

The problem should be easy to reproduce by enabling CONFIG_DEBUG_SPINLOCK
and CONFIG_LOCKDEP.

Please let me know if there is anything I can do to help fix the problem.

Thanks,
Guenter
