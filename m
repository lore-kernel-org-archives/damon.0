Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C271238150;
	Fri,  9 Oct 2026 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513618; cv=none; b=cTUraWGDskV8mupRiarGapQKRw3ZcwjPSsIzxYrraKc+7AaUG2msLeV4hxwWVlflzFMfKbSICKRLb3+TpN2dkKVMLmEdAiVPGPuRrOtQKTJ/WNCtOkKtsiJAcNEvdQKP49whWES8yTY1pSxh3m/7J590hPxzeZE+YB7ABW/AUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513618; c=relaxed/simple;
	bh=U1npSJzejD5mBi1v3j4ledYzhzb7UttD01lckDzSJgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS4RDim8zkr7ONYE1C73bXZzk0buKQmXoeT/IWN4AP9/rSniBPKJXIiOm9oQzj/6w2nFB1vsxYyC2fo39BgGL6wzrMj/TpghGVggG1rtbGxlu09NyhYB4qb8VF/rHI+VzYfPGMZrR8J31NMujwnM5leKFzBVvtMd9ykYWZlXjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhTIjZaf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhTIjZaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791513616; x=1823049616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1npSJzejD5mBi1v3j4ledYzhzb7UttD01lckDzSJgM=;
  b=GhTIjZafquIS0jrH0Sm+qRtjzk0lweRckopbiEbI46USacPCuRVOV90R
   q1xJqgOehyEi3cBUD83DYyY7WXZwT1y1A0pJZGf4D9T0zJhvJxd8A+hCl
   mxyC+b5ilT6aGMJZj4ZlW+Z/seDC49doIr29rr+XdLlmRsnBlRBJ5bfC5
   ePCtzECyxA9Hy2pDZ2/ip1B3S0P8/2YVkUUu37CPze9OYxWXHsazawCyB
   EeAZjxYyGCy4NatnxkhPfAHaspJmqmG6z4oDJGcRP0dQ6l+lPM4znJrA1
   /zjbdI0lJz+ZLiVrvP9rAlVOMSK8DhUbu9ybwlwz9RPv3pLhpLmHZL/01
   w==;
X-CSE-ConnectionGUID: 3owiiQwwQ4+CemOTG/uutw==
X-CSE-MsgGUID: /fnyUAPeSWaf33JnlZv+Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="312480"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="312480"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 19:40:16 -0700
X-CSE-ConnectionGUID: NKB6IehzQ2+GXVXta22VSw==
X-CSE-MsgGUID: gByQKVSEQGSzQsBZiCzfjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="280369"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Oct 2026 19:40:13 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xF0Wn-000000005Ce-2mWk;
	Fri, 09 Oct 2026 02:40:09 +0000
Date: Fri, 9 Oct 2026 10:40:07 +0800
From: kernel test robot <lkp@intel.com>
To: Suhaas Joshi <suhaas@s-joshi.in>, sj@kernel.org,
	akpm@linux-foundation.org, aethernet65535@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: Copy only installed probe in
 damon_split_region_at()
Message-ID: <202610091039.fhMXCn7d-lkp@intel.com>
References: <20261008151944.113714-3-suhaas@s-joshi.in>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008151944.113714-3-suhaas@s-joshi.in>

Hi Suhaas,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Suhaas-Joshi/mm-damon-core-Copy-only-installed-probe-in-damon_split_region_at/20261008-204926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20261008151944.113714-3-suhaas%40s-joshi.in
patch subject: [PATCH v2 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
config: csky-randconfig-1001-20261009 (https://download.01.org/0day-ci/archive/20261009/202610091039.fhMXCn7d-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610091039.fhMXCn7d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610091039.fhMXCn7d-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from mm/damon/core.c:4295:
   mm/damon/tests/core-kunit.h: In function 'damon_test_last_region_quota_reset':
>> mm/damon/tests/core-kunit.h:2519:38: error: passing argument 1 of 'damos_skip_charged_region' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2519 |  skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
         |                                      ^
         |                                      |
         |                                      struct damon_target *
   mm/damon/core.c:2500:57: note: expected 'struct damon_ctx *' but argument is of type 'struct damon_target *'
    2500 | static bool damos_skip_charged_region(struct damon_ctx *ctx,
         |                                       ~~~~~~~~~~~~~~~~~~^~~
   In file included from mm/damon/core.c:4295:
   mm/damon/tests/core-kunit.h:2519:41: error: passing argument 2 of 'damos_skip_charged_region' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2519 |  skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
         |                                         ^~
         |                                         |
         |                                         struct damon_region *
   mm/damon/core.c:2501:32: note: expected 'struct damon_target *' but argument is of type 'struct damon_region *'
    2501 |           struct damon_target *t,
         |           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:4295:
   mm/damon/tests/core-kunit.h:2519:45: error: passing argument 3 of 'damos_skip_charged_region' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2519 |  skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
         |                                             ^~
         |                                             |
         |                                             struct damos *
   mm/damon/core.c:2502:32: note: expected 'struct damon_region *' but argument is of type 'struct damos *'
    2502 |           struct damon_region *r, struct damos *s,
         |           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:4295:
>> mm/damon/tests/core-kunit.h:2519:49: warning: passing argument 4 of 'damos_skip_charged_region' makes pointer from integer without a cast [-Wint-conversion]
    2519 |  skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
         |                                                 ^~~~~~~~~~~~~
         |                                                 |
         |                                                 long unsigned int
   mm/damon/core.c:2502:49: note: expected 'struct damos *' but argument is of type 'long unsigned int'
    2502 |           struct damon_region *r, struct damos *s,
         |                                   ~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:4295:
>> mm/damon/tests/core-kunit.h:2519:12: error: too few arguments to function 'damos_skip_charged_region'
    2519 |  skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:2500:13: note: declared here
    2500 | static bool damos_skip_charged_region(struct damon_ctx *ctx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/damos_skip_charged_region +2519 mm/damon/tests/core-kunit.h

79500f5843f453 Donggeun Yoo 2026-09-28  2489  
18793c04abe665 Liew Rui Yan 2026-10-05  2490  static void damon_test_last_region_quota_reset(struct kunit *test)
18793c04abe665 Liew Rui Yan 2026-10-05  2491  {
18793c04abe665 Liew Rui Yan 2026-10-05  2492  	struct damos s = {0};
18793c04abe665 Liew Rui Yan 2026-10-05  2493  	struct damon_target *t;
18793c04abe665 Liew Rui Yan 2026-10-05  2494  	struct damon_region *r1, *r2;
18793c04abe665 Liew Rui Yan 2026-10-05  2495  	unsigned long min_region_sz = 1;
18793c04abe665 Liew Rui Yan 2026-10-05  2496  	bool skipped;
18793c04abe665 Liew Rui Yan 2026-10-05  2497  
18793c04abe665 Liew Rui Yan 2026-10-05  2498  	t = damon_new_target();
18793c04abe665 Liew Rui Yan 2026-10-05  2499  	if (!t)
18793c04abe665 Liew Rui Yan 2026-10-05  2500  		kunit_skip(test, "target alloc fail");
18793c04abe665 Liew Rui Yan 2026-10-05  2501  
18793c04abe665 Liew Rui Yan 2026-10-05  2502  	r1 = damon_new_region(0, 100);
18793c04abe665 Liew Rui Yan 2026-10-05  2503  	if (!r1) {
18793c04abe665 Liew Rui Yan 2026-10-05  2504  		damon_free_target(t);
18793c04abe665 Liew Rui Yan 2026-10-05  2505  		kunit_skip(test, "region 1 alloc fail");
18793c04abe665 Liew Rui Yan 2026-10-05  2506  	}
18793c04abe665 Liew Rui Yan 2026-10-05  2507  	damon_add_region(r1, t);
18793c04abe665 Liew Rui Yan 2026-10-05  2508  
18793c04abe665 Liew Rui Yan 2026-10-05  2509  	r2 = damon_new_region(100, 200);
18793c04abe665 Liew Rui Yan 2026-10-05  2510  	if (!r2) {
18793c04abe665 Liew Rui Yan 2026-10-05  2511  		damon_free_target(t);
18793c04abe665 Liew Rui Yan 2026-10-05  2512  		kunit_skip(test, "region 2 alloc fail");
18793c04abe665 Liew Rui Yan 2026-10-05  2513  	}
18793c04abe665 Liew Rui Yan 2026-10-05  2514  	damon_add_region(r2, t);
18793c04abe665 Liew Rui Yan 2026-10-05  2515  
18793c04abe665 Liew Rui Yan 2026-10-05  2516  	s.quota.charge_target_from = t;
18793c04abe665 Liew Rui Yan 2026-10-05  2517  	s.quota.charge_addr_from = r1->ar.end;
18793c04abe665 Liew Rui Yan 2026-10-05  2518  
18793c04abe665 Liew Rui Yan 2026-10-05 @2519  	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
18793c04abe665 Liew Rui Yan 2026-10-05  2520  
18793c04abe665 Liew Rui Yan 2026-10-05  2521  	/* 'r2' is not processed, it should not skip */
18793c04abe665 Liew Rui Yan 2026-10-05  2522  	KUNIT_EXPECT_EQ(test, skipped, false);
18793c04abe665 Liew Rui Yan 2026-10-05  2523  
18793c04abe665 Liew Rui Yan 2026-10-05  2524  	/* 'r2' is last region, it should reset charge_{target,addr}_from */
18793c04abe665 Liew Rui Yan 2026-10-05  2525  	KUNIT_EXPECT_PTR_EQ(test, s.quota.charge_target_from, NULL);
18793c04abe665 Liew Rui Yan 2026-10-05  2526  	KUNIT_EXPECT_EQ(test, s.quota.charge_addr_from, 0);
18793c04abe665 Liew Rui Yan 2026-10-05  2527  
18793c04abe665 Liew Rui Yan 2026-10-05  2528  	damon_free_target(t);
18793c04abe665 Liew Rui Yan 2026-10-05  2529  }
18793c04abe665 Liew Rui Yan 2026-10-05  2530  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
