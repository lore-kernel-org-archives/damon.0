Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35338D017;
	Fri, 28 Aug 2026 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895259; cv=none; b=hZlVvtRfD2gM6Z1xfIwbHOr8RZlRGPPN478s7oMBozL8a7bNcOM+lIlaJFhcU3qHv+a0ptYE4wxVSz97yJMTvxpNi8qY4h4tlYRJ8NAL/t/4T06M1R+z31CLqXTxraA/SKnmd+q1tr3zzdDM3rNs/eZ4SA43YW+K5Uov3/L2hc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895259; c=relaxed/simple;
	bh=L12kByngmxm0+XcLwhdT9GBJpdEOxar0JOOmR9A9qck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhnjDG5NWNebcuQEuutH/7wLU1/EDj3VvHtLkFCOGOKbmOaW9CjqCDA9DPUi1vkjWuI/VYuyDwvOQ5ZYlIUdkBbHzwL6Rav7iRYynMHE8IvQ9OtHRuLVFv1GqZjGxEKBG/ZBAY5bmUfxzHmIAYWwtg8Ky0FsqSAB+fim5kC+cXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndEh+g7B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndEh+g7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787895256; x=1819431256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L12kByngmxm0+XcLwhdT9GBJpdEOxar0JOOmR9A9qck=;
  b=ndEh+g7BVnxojUxkDSNYguU68wszQlITOMOQrT3h/SksQNjLPfbX1P3N
   gpuYjNGbnx6/ZhuxSnKzhaTIo0RerTOf1Pmn7OKamR0AqLJU7/48gW/r+
   U5W9vJYoXBPoXPQ8gfUjIfka6ofpKh2gj3YZa1WI0TD6fWfbG4TQV+muW
   bYE6U2FCTkDra5Gj/v/HGj0Usp3VkqQqyAujTf1EtImbg+eYNazh/FEBe
   NPpzl6N9Z7/0frQNppY+9f11xzyOOwYm+j0tTQtduN4PcDG3CKHLf2kpA
   L2ZHfpo+i4RdhP8KwrQ7I/drA0yMvraGmOh9Qj2ypCOpy9W6ZBL61ExPE
   Q==;
X-CSE-ConnectionGUID: 5JMFRCwIS+2mbDUJuX5iVA==
X-CSE-MsgGUID: +JTz/Zk5S96Uc/16WbhFyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88525465"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88525465"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 22:34:16 -0700
X-CSE-ConnectionGUID: 2JOw/X5sR7qW4b71mX5Ntg==
X-CSE-MsgGUID: mIi6lFz/Rs6jYJK3+8P47g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="270025508"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Aug 2026 22:34:14 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wzpEB-00000000AST-1pk6;
	Fri, 28 Aug 2026 05:34:11 +0000
Date: Fri, 28 Aug 2026 13:33:29 +0800
From: kernel test robot <lkp@intel.com>
To: Zenghui Yu <zenghui.yu@linux.dev>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sj@kernel.org, akpm@linux-foundation.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: Re: [PATCH] mm/damon/core: remove declaration of kdamond_fn()
Message-ID: <202608281351.Hv386MvO-lkp@intel.com>
References: <20260827163953.83520-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827163953.83520-1-zenghui.yu@linux.dev>

Hi Zenghui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Zenghui-Yu/mm-damon-core-remove-declaration-of-kdamond_fn/20260828-003953
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260827163953.83520-1-zenghui.yu%40linux.dev
patch subject: [PATCH] mm/damon/core: remove declaration of kdamond_fn()
config: xtensa-randconfig-r073-20260828 (https://download.01.org/0day-ci/archive/20260828/202608281351.Hv386MvO-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 16.1.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260828/202608281351.Hv386MvO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608281351.Hv386MvO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/psi_types.h:5,
                    from include/linux/cgroup-defs.h:24,
                    from include/linux/cgroup.h:29,
                    from include/linux/memcontrol.h:13,
                    from include/linux/damon.h:10,
                    from mm/damon/core.c:8:
   mm/damon/core.c: In function '__damon_start':
>> mm/damon/core.c:1941:44: error: 'kdamond_fn' undeclared (first use in this function)
    1941 |                 ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
         |                                            ^~~~~~~~~~
   include/linux/kthread.h:46:32: note: in definition of macro 'kthread_create'
      46 |         kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
         |                                ^~~~~~~~
   mm/damon/core.c:1941:32: note: in expansion of macro 'kthread_run'
    1941 |                 ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
         |                                ^~~~~~~~~~~
   mm/damon/core.c:1941:44: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/kthread.h:46:32: note: in definition of macro 'kthread_create'
      46 |         kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
         |                                ^~~~~~~~
   mm/damon/core.c:1941:32: note: in expansion of macro 'kthread_run'
    1941 |                 ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
         |                                ^~~~~~~~~~~
   mm/damon/core.c: At top level:
>> mm/damon/core.c:3750:12: warning: 'kdamond_fn' defined but not used [-Wunused-function]
    3750 | static int kdamond_fn(void *data)
         |            ^~~~~~~~~~


vim +/kdamond_fn +1941 mm/damon/core.c

b1029f29eb1d5fb SJ Park        2026-02-28  1924  
2224d8485492e49 SeongJae Park  2021-09-07  1925  /*
2224d8485492e49 SeongJae Park  2021-09-07  1926   * __damon_start() - Starts monitoring with given context.
2224d8485492e49 SeongJae Park  2021-09-07  1927   * @ctx:	monitoring context
2224d8485492e49 SeongJae Park  2021-09-07  1928   *
2224d8485492e49 SeongJae Park  2021-09-07  1929   * This function should be called while damon_lock is hold.
2224d8485492e49 SeongJae Park  2021-09-07  1930   *
2224d8485492e49 SeongJae Park  2021-09-07  1931   * Return: 0 on success, negative error code otherwise.
2224d8485492e49 SeongJae Park  2021-09-07  1932   */
2224d8485492e49 SeongJae Park  2021-09-07  1933  static int __damon_start(struct damon_ctx *ctx)
2224d8485492e49 SeongJae Park  2021-09-07  1934  {
2224d8485492e49 SeongJae Park  2021-09-07  1935  	int err = -EBUSY;
2224d8485492e49 SeongJae Park  2021-09-07  1936  
2224d8485492e49 SeongJae Park  2021-09-07  1937  	mutex_lock(&ctx->kdamond_lock);
2224d8485492e49 SeongJae Park  2021-09-07  1938  	if (!ctx->kdamond) {
2224d8485492e49 SeongJae Park  2021-09-07  1939  		err = 0;
6376a824595607e SJ Park        2023-12-08  1940  		reinit_completion(&ctx->kdamond_started);
2224d8485492e49 SeongJae Park  2021-09-07 @1941  		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
2224d8485492e49 SeongJae Park  2021-09-07  1942  				nr_running_ctxs);
2224d8485492e49 SeongJae Park  2021-09-07  1943  		if (IS_ERR(ctx->kdamond)) {
2224d8485492e49 SeongJae Park  2021-09-07  1944  			err = PTR_ERR(ctx->kdamond);
7ec1992b891e59d Colin Ian King 2021-11-05  1945  			ctx->kdamond = NULL;
6376a824595607e SJ Park        2023-12-08  1946  		} else {
6376a824595607e SJ Park        2023-12-08  1947  			wait_for_completion(&ctx->kdamond_started);
2224d8485492e49 SeongJae Park  2021-09-07  1948  		}
2224d8485492e49 SeongJae Park  2021-09-07  1949  	}
2224d8485492e49 SeongJae Park  2021-09-07  1950  	mutex_unlock(&ctx->kdamond_lock);
2224d8485492e49 SeongJae Park  2021-09-07  1951  
2224d8485492e49 SeongJae Park  2021-09-07  1952  	return err;
2224d8485492e49 SeongJae Park  2021-09-07  1953  }
2224d8485492e49 SeongJae Park  2021-09-07  1954  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
