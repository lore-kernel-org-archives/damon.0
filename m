Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD82CCC5;
	Sat, 18 Jan 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737187785; cv=none; b=kEP78rpF9hfyBdoRMWhGWwY2FSrXm9rszRPwvuhl8Uh+DEO2ah03qWnR8fAuRXJwPBHvUWGcItln+TqPOJTIlHALMSkRzYe9i17E02Ow7JioOIamX2TxT+PoLFLWjF8XnS+ZYltOnEN0HsrrmXuIhKCzE8ul++NnmNEaWs+DvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737187785; c=relaxed/simple;
	bh=8Srevssim3A0yKFu3ju2d8b02eg9+nok+xtLRxDZ3QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0VlSeKWHbrbFVbOcu+hAW/tWCK1IdZSJXwqps5IimNOy45jXr6nEVAdgh+7bEN3BSceZus8PB0t8XOVJM5xXCUxLnb1gO+PoqKB6IMQIpNEtHWuyOa8QRzZxr+2FA2IdoCzRZpH87ko+l/ZBBxSlD3BUWJe7CgE5pbOwkP7hUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LezrkkSr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LezrkkSr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737187784; x=1768723784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Srevssim3A0yKFu3ju2d8b02eg9+nok+xtLRxDZ3QA=;
  b=LezrkkSrfutErerzstRqrLjoNXW8eWt2EASiF4DuBoD0aY7AZbI9a70d
   GQ7xNrwAUsH0HCTwKnwimt6oTwzoKAnSrofTU8s+s+SUzDG/D9XEqksMB
   OisqPYzytV0MMCwBo6n8PR92eE+mCFTaQIIjo9cKEeHG3bKS5aVWez+oX
   EErbjozRbymJ8ef/zPKJTYHqytQfBwNLWek1/EHsngwGxDEIuQPHi8ON1
   J+9LsVahcOs0RDI7c2Wym1CRdZRKWl1O6mwMzdMljFa8PaNebk7s9mn2H
   JiMFH7kMmehcwnMcQQ1cwNf+OKajAzaLPecA+a3xzqdKvQvuE3zYcTJDz
   A==;
X-CSE-ConnectionGUID: TxzhheC4QVinLgffP2Fl/A==
X-CSE-MsgGUID: jDEHDWcESmqIYXOgxgPp2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="49019339"
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="49019339"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 00:09:43 -0800
X-CSE-ConnectionGUID: 7zm1jcFgTbefzQpYJ4aTeA==
X-CSE-MsgGUID: LAAR585gRUSq017amnHiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="106056365"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Jan 2025 00:09:41 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZ3ti-000UE3-1v;
	Sat, 18 Jan 2025 08:09:38 +0000
Date: Sat, 18 Jan 2025 16:09:08 +0800
From: kernel test robot <lkp@intel.com>
To: Usama Arif <usamaarif642@gmail.com>, sj@kernel.org,
	akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev, linux-mm@kvack.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
Message-ID: <202501181509.wyig2s2H-lkp@intel.com>
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
config: i386-randconfig-014-20250118 (https://download.01.org/0day-ci/archive/20250118/202501181509.wyig2s2H-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501181509.wyig2s2H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501181509.wyig2s2H-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/damon/paddr.c:12:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from mm/damon/paddr.c:17:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
   5 warnings generated.
>> ld.lld: error: call to __compiletime_assert_374 marked "dontcall-error": BUILD_BUG failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
