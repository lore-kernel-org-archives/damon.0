Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33813396B69;
	Fri, 27 Mar 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615901; cv=none; b=QZp1k/x2+wKAHCaUfGqebRhUhGtQ/uVxWkC2P9kSMjq3SgGeWVzPaCJmIMvbAO1aEhsaYDa4DzsDi64XBftwqbm4NwCdqEP4hFC9mpjXPQCW5niTrzjMYmqCscs/LHaU0grR/Y1JOJtTzUeJm4ycVW0JLeNWY6cOTVuHfYlK6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615901; c=relaxed/simple;
	bh=igR2uwWnIP1vFte7MCw7gFeiS0hftkmp0XPSK5xd0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjLrOFpsvRjb0WUvDSdSzJzLKJl//RGKk3tTPptOmzHIXZ2w6GqLpb4v28+/6ohHs4Rs8Lu7xIqfpDtBLX6/Apg4PKD8tFLbUHWGWNRMsAtBlqGLquKXXOsN9XfotGGqvrsMOKuGUwItfe42BqoAMWRac27uBY3RXj/JKmbVSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lW+svofX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lW+svofX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774615899; x=1806151899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=igR2uwWnIP1vFte7MCw7gFeiS0hftkmp0XPSK5xd0BI=;
  b=lW+svofXR1dcb7xz1skBx55OYpbI+0167QdgBl+c2uI/NLfnknDEM2sV
   RNiQfh/vrZ5V2GjPV2QRYqMLOJVk9KkQCNCEHTP/wkzoFSNbpeip94Eox
   Q2eoHCx8+aRdc+ULHYFnVfJRzWAx2nO7U4G0nqLjiaxHEPGjrF3mwzSkZ
   Q9+kjMMufibRNTiJFgrqhW7D0ijTxO7/H+fhjoaIOIbqpPyLc6OTdXdk4
   EXePy9fIEj7y+w7Aeg13+UZGiWIw79t7kPUIjfTo7tkQJt1eq46Anlvwh
   dMr+jPwM6awZy8zXbq4FhKid23XA0g7rYwgUOX7tS/qHoQFzD+ocvdExz
   A==;
X-CSE-ConnectionGUID: j8ze4pDoR2adBQZUEI0Nsg==
X-CSE-MsgGUID: k1+CI9PlTOGQvPvAY0xw/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75568912"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75568912"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:51:39 -0700
X-CSE-ConnectionGUID: nq3KOzv7TLGgC553Odh24w==
X-CSE-MsgGUID: Uc94TcatTb2g+eOOvM9m6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="221981797"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Mar 2026 05:51:36 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w66f0-00000000AIn-07pQ;
	Fri, 27 Mar 2026 12:51:34 +0000
Date: Fri, 27 Mar 2026 20:50:37 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Law <objecting@objecting.org>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering
 module
Message-ID: <202603272022.tcaGCvSO-lkp@intel.com>
References: <20260326072737.341964-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326072737.341964-1-objecting@objecting.org>

Hi Josh,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Law/mm-damon-introduce-DAMON-based-NUMA-memory-tiering-module/20260327-033827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260326072737.341964-1-objecting%40objecting.org
patch subject: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering module
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260327/202603272022.tcaGCvSO-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603272022.tcaGCvSO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603272022.tcaGCvSO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/damon/tier.c:283:30: error: too few arguments to function call, expected 5, have 4
                                           param_ctx->min_region_sz);
                                                                   ^
   include/linux/damon.h:995:5: note: 'damon_set_region_biggest_system_ram_default' declared here
   int damon_set_region_biggest_system_ram_default(struct damon_target *t,
       ^
   1 error generated.


vim +283 mm/damon/tier.c

   243	
   244	static int damon_tier_apply_parameters(void)
   245	{
   246		struct damon_ctx *param_ctx;
   247		struct damon_target *param_target;
   248		struct damos *promote_scheme, *demote_scheme;
   249		int err;
   250	
   251		err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
   252		if (err)
   253			return err;
   254	
   255		err = damon_set_attrs(param_ctx, &damon_tier_mon_attrs);
   256		if (err)
   257			goto out;
   258	
   259		err = -ENOMEM;
   260		promote_scheme = damon_tier_new_promote_scheme();
   261		if (!promote_scheme)
   262			goto out;
   263	
   264		demote_scheme = damon_tier_new_demote_scheme();
   265		if (!demote_scheme) {
   266			damon_destroy_scheme(promote_scheme);
   267			goto out;
   268		}
   269	
   270		damon_set_schemes(param_ctx, &promote_scheme, 1);
   271		damon_add_scheme(param_ctx, demote_scheme);
   272	
   273		err = damon_tier_add_quota_goals(promote_scheme, demote_scheme);
   274		if (err)
   275			goto out;
   276		err = damon_tier_add_filters(promote_scheme, demote_scheme);
   277		if (err)
   278			goto out;
   279	
   280		err = damon_set_region_biggest_system_ram_default(param_target,
   281						&monitor_region_start,
   282						&monitor_region_end,
 > 283						param_ctx->min_region_sz);
   284		if (err)
   285			goto out;
   286		err = damon_commit_ctx(ctx, param_ctx);
   287	out:
   288		damon_destroy_ctx(param_ctx);
   289		return err;
   290	}
   291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
