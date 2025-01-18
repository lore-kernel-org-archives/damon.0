Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894C12EBEA;
	Sat, 18 Jan 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737196499; cv=none; b=sfAUVjtyR/MkFAAl2KqwfPwT7lN5LTktiBET5nHlJD8PSWcw27zJjdQwEoSNHoF4wOj/S80X9u1m+dkzrGPUylTNbgiPk0tsuHrPfOB8yhFgSZXbzadmLhSdM/HhGyd68+17L4RBH1evDg1AzCfaonqK7cWYqlJxa/8qRQHxNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737196499; c=relaxed/simple;
	bh=ia4ddBUSaq7vcOgmekvbznOSX14SZlhScqAGwgrpnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gdp2Ai2oJRbt8S6ATRy42+FuK8mJL/3L0JkSSO3jJc/s4KDfhMzFELt/bCoqFI1JxRhnh7PUXlUYQAG05QPhPfxRjbsICxGY/xUgzsvNY57RwcTDaQrdh294ehflu3IEcv8Z8Z4wb7x0IOAa+Rt+t8ktPAc+wtlkvv7x5DXOkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e61VuvOx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e61VuvOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737196498; x=1768732498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ia4ddBUSaq7vcOgmekvbznOSX14SZlhScqAGwgrpnfU=;
  b=e61VuvOxuG5vMZEMzcPgx6bMFRP51WybQ4ubyErHcykUDKUcLvXOPObv
   DXB7O53HyDeAsFvrRROroUOyRkbKiFdNXihmfG3JcjKdblvvg+DKwYrWW
   RyOSAsgxWBQ/Qww81ZPdZFA5+A5b789p1vkNErcHBCOPS+WMt6VEYmyU0
   xrKC2HSkQ4tXgZJIbjCt3vqrOaXeA8T1EDUhanwsbXtvwUlzcO6UAwWXe
   E1ju5hNXFuMTYr4CxLcfsnt51GNOdTKwNGTInRlQWJhPpd5Mq5EJxGPy+
   DRhp5aXEB9q6YKZwCvQQIDFk6K9dJRCadtz62gkicmqFFlGpfgAdIDkWZ
   g==;
X-CSE-ConnectionGUID: RKe2bU2ETwGecxCHUspysg==
X-CSE-MsgGUID: xQl+CwG1T4CduS6cnVXG+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37506967"
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="37506967"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 02:34:57 -0800
X-CSE-ConnectionGUID: kpFh58RxSeKyf8r3oqckPw==
X-CSE-MsgGUID: RWTRPelFSIGocFbUQQuInQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="106595007"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 Jan 2025 02:34:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZ6AH-000UJf-0L;
	Sat, 18 Jan 2025 10:34:53 +0000
Date: Sat, 18 Jan 2025 18:34:30 +0800
From: kernel test robot <lkp@intel.com>
To: Usama Arif <usamaarif642@gmail.com>, sj@kernel.org,
	akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev, linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
Message-ID: <202501181819.RVctFodO-lkp@intel.com>
References: <20250116144436.3947318-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116144436.3947318-2-usamaarif642@gmail.com>

Hi Usama,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/mm-damon-introduce-DAMOS-filter-type-hugepage/20250116-224546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250116144436.3947318-2-usamaarif642%40gmail.com
patch subject: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
config: x86_64-randconfig-077-20250118 (https://download.01.org/0day-ci/archive/20250118/202501181819.RVctFodO-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501181819.RVctFodO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501181819.RVctFodO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/damon/paddr.c:17:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/damon/paddr.c:226:34: error: call to '__compiletime_assert_603' declared with 'error' attribute: BUILD_BUG failed
     226 |                 matched = folio_size(folio) == HPAGE_PMD_SIZE;
         |                                                ^
   include/linux/huge_mm.h:111:34: note: expanded from macro 'HPAGE_PMD_SIZE'
     111 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
         |                                   ^
   include/linux/huge_mm.h:104:28: note: expanded from macro 'HPAGE_PMD_SHIFT'
     104 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
         |                            ^
   include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:530:2: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:523:4: note: expanded from macro '__compiletime_assert'
     523 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:50:1: note: expanded from here
      50 | __compiletime_assert_603
         | ^
   2 warnings and 1 error generated.


vim +226 mm/damon/paddr.c

   200	
   201	static bool damos_pa_filter_match(struct damos_filter *filter,
   202			struct folio *folio)
   203	{
   204		bool matched = false;
   205		struct mem_cgroup *memcg;
   206	
   207		switch (filter->type) {
   208		case DAMOS_FILTER_TYPE_ANON:
   209			matched = folio_test_anon(folio);
   210			break;
   211		case DAMOS_FILTER_TYPE_MEMCG:
   212			rcu_read_lock();
   213			memcg = folio_memcg_check(folio);
   214			if (!memcg)
   215				matched = false;
   216			else
   217				matched = filter->memcg_id == mem_cgroup_id(memcg);
   218			rcu_read_unlock();
   219			break;
   220		case DAMOS_FILTER_TYPE_YOUNG:
   221			matched = damon_folio_young(folio);
   222			if (matched)
   223				damon_folio_mkold(folio);
   224			break;
   225		case DAMOS_FILTER_TYPE_HUGEPAGE:
 > 226			matched = folio_size(folio) == HPAGE_PMD_SIZE;
   227			break;
   228		default:
   229			break;
   230		}
   231	
   232		return matched == filter->matching;
   233	}
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
