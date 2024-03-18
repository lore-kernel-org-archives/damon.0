Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EF5A0F2;
	Mon, 18 Mar 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799221; cv=none; b=oh7Db3feG+a5m1JB6LG4QMP6LA9txd9dAH21s+5Qdytzdvh8eoi6aTRKH/o12GRgtB/tZUTU6fiaQZir11Od3mcXrBJ3b2YVNSjNC23T/OuubwuB1N2IsfrGdn+rCKjkvtyKlxhNTDeKJKONcz5rveF9Fas0awSjuBV8d/p/FyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799221; c=relaxed/simple;
	bh=GH6BWPSigJxYv51qRplfTJgCiA30VVhLkJmJtG7tqU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syOASxead6bEFq5fr0zqW89vCUoltaxrzhhLuI4H8OIUau7Q2trmCu8YIc5a40bymNP8kPyrg5VEUnksHR38jDBiEM0yR0wmKOzcZzXNLgTF3EkrkYVCmalKMpGf1D6IFem0hQhCPI2HJcwe6PMXw/jtbvC7U1z1hVxLu2hZPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbIDl7lN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbIDl7lN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710799220; x=1742335220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GH6BWPSigJxYv51qRplfTJgCiA30VVhLkJmJtG7tqU4=;
  b=FbIDl7lN/qxN6wv+BoqfLNg+6zvO8yP9AL1QOXetXcrKsiDd1egN3rjF
   fdzw7uZ9Rorkg/BTcan5VcFhkV2AEzXHZ34Giz9XmGOWIFBOmytY8pXQE
   PzlqxNPdX8+BAIoBeLqc4NVDBCAiR/kqTbuxdmSVpbuEDTRZhwUEkR+5F
   WmIEUGSbUtK92F6XH9vJPi0qapurmRG1KcURlCV/en2k1eqDetCDSudRK
   PubbIKsFEJ7QDofbTvaHGg+JPVKrTj3bQZVHemE/mTMNrVP+rBEuXqn6n
   xbTYcnQv2VA05241ED0gb/xTPzYDGkDZi+J1zMyKVa7Mf6gyi9bxUzyqO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="23095578"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="23095578"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13559456"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Mar 2024 15:00:15 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmL1g-000HG7-1M;
	Mon, 18 Mar 2024 22:00:12 +0000
Date: Tue, 19 Mar 2024 05:59:58 +0800
From: kernel test robot <lkp@intel.com>
To: Aravinda Prasad <aravinda.prasad@intel.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, sj@kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	aravinda.prasad@intel.com, s2322819@ed.ac.uk,
	sandeep4.kumar@intel.com, ying.huang@intel.com,
	dave.hansen@intel.com, dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com, antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com
Subject: Re: [PATCH v2 2/3] mm/damon: profiling enhancement
Message-ID: <202403190550.8chO4Zt4-lkp@intel.com>
References: <20240318132848.82686-3-aravinda.prasad@intel.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318132848.82686-3-aravinda.prasad@intel.com>

Hi Aravinda,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Aravinda-Prasad/mm-damon-mm-infrastructure-support/20240318-212723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240318132848.82686-3-aravinda.prasad%40intel.com
patch subject: [PATCH v2 2/3] mm/damon: profiling enhancement
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240319/202403190550.8chO4Zt4-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240319/202403190550.8chO4Zt4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403190550.8chO4Zt4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2194:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> mm/damon/vaddr.c:78:6: error: call to undeclared function 'pgtable_l5_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      78 |         if (pgtable_l5_enabled()) {
         |             ^
   7 warnings and 1 error generated.


vim +/pgtable_l5_enabled +78 mm/damon/vaddr.c

    54	
    55	/* Pick the highest possible page table profiling level for addr
    56	 * in the region defined by start and end
    57	 */
    58	static int pick_profile_level(unsigned long start, unsigned long end,
    59			unsigned long addr)
    60	{
    61		/* Start with PTE and check if higher levels can be picked */
    62		int level = 0;
    63	
    64		if (!arch_has_hw_nonleaf_pmd_young())
    65			return level;
    66	
    67		/* Check if PMD or higher can be picked, else use PTE */
    68		if (pmd_addr_start(addr, (start) - 1) < start
    69				|| pmd_addr_end(addr, (end) + 1) > end)
    70			return level;
    71	
    72		level++;
    73		/* Check if PUD or higher can be picked, else use PMD */
    74		if (pud_addr_start(addr, (start) - 1) < start
    75				|| pud_addr_end(addr, (end) + 1) > end)
    76			return level;
    77	
  > 78		if (pgtable_l5_enabled()) {
    79			level++;
    80			/* Check if P4D or higher can be picked, else use PUD */
    81			if (p4d_addr_start(addr, (start) - 1) < start
    82					|| p4d_addr_end(addr, (end) + 1) > end)
    83				return level;
    84		}
    85	
    86		level++;
    87		/* Check if PGD can be picked, else return PUD level */
    88		if (pgd_addr_start(addr, (start) - 1) < start
    89				|| pgd_addr_end(addr, (end) + 1) > end)
    90			return level;
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
