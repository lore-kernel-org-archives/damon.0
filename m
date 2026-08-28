Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6432692C;
	Fri, 28 Aug 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787878552; cv=none; b=B9IE7sJ1046sRwSydT2yvKJW8B8zFvOTzMqcYY3Ly5pcq1b3t6evZKL21O/XV9GbVZbtlULkLDdMOimM4t4c1+z0mV33hOfJawauekF5cgmULPtfajfZlNSJicyGa6UDV//vW3K2zT+I9WKBq0BZfdZ1VJ9t1NKgeE378NWm5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787878552; c=relaxed/simple;
	bh=pxJJ/Gq2BOZaGKWbI4sy8nb0IV9yvaOJO4OZ8lJb3Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqYpk1Q+OgdhSFDK0Kjc03cf270r8Ppk4S40MXkIuqlWeUVFntQkzLKJXO/4LwcnKmrlF5V06tLz0w/gtlBJrajbRiFLkJMeE/S8cMia714yp+qZOnbIvwAIYaYXJVeRmnqu4j+F5q/s3kDGCHQ6swaBCOopgCwYNf9pBg/Kq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdBTlzKQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdBTlzKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787878550; x=1819414550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pxJJ/Gq2BOZaGKWbI4sy8nb0IV9yvaOJO4OZ8lJb3Fw=;
  b=TdBTlzKQo/2RJ0ldl0lyYP8VLhRvpVYtZhPi2XIWwKjqrnfl4MiCFbtm
   AQ/fVukYQ3+85UCdKY1ZqRBI5biDGYXraZEapf60GfS34CE8Bseu1Rdlk
   s8s8oTVI25BxEaX/nox+px7Itr1lGDm6H16qEE/Za1SauEaGPi/N2aJWy
   BuEnc+T9ge6lIaNnmU+3+feesHwM8edN/uhCQI6/RkislZ0ndCp9iPli8
   Sc2I07Mrr/9/z6eh8aruNXFUTgn/UOrHmbV+pHluaT8oyorrjpSZX7CQo
   1Sq6BZCsJ2/6nYtuXrXY6PDXs06cnnDSi2UevSJkHmFI/VveqDB3dsAsC
   A==;
X-CSE-ConnectionGUID: iIBM/cMpSsGzSCSyI7X4sQ==
X-CSE-MsgGUID: o86vHt2TT1qjfrjLrQWbQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92246511"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="92246511"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 17:55:50 -0700
X-CSE-ConnectionGUID: D94VrNDqS12fWXoUw+nM9w==
X-CSE-MsgGUID: TwDvaBS/Q6qrl8OnJjoNTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="271834038"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Aug 2026 17:55:47 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wzksj-00000000ADN-27PO;
	Fri, 28 Aug 2026 00:55:45 +0000
Date: Fri, 28 Aug 2026 08:54:51 +0800
From: kernel test robot <lkp@intel.com>
To: Zenghui Yu <zenghui.yu@linux.dev>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sj@kernel.org, akpm@linux-foundation.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: Re: [PATCH] mm/damon/core: remove declaration of kdamond_fn()
Message-ID: <202608280848.9o0Z64CP-lkp@intel.com>
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
config: hexagon-randconfig-r052-20260828 (https://download.01.org/0day-ci/archive/20260828/202608280848.9o0Z64CP-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260828/202608280848.9o0Z64CP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608280848.9o0Z64CP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/damon/core.c:1941:30: error: use of undeclared identifier 'kdamond_fn'
    1941 |                 ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
         |                                            ^
   1 error generated.


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
