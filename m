Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFB76405;
	Fri, 31 May 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183682; cv=none; b=q0hYCVuzw7VK6f5due3ozTGLxanZRQ76BLlh7pdGlvahrr3V9p6GoSeVuBYC0ktjt6lmueg2Bmuq7SrJKSwT6lBPCAi0UCzADgG3WaAPj9rnlbvK3N/L2eaMVkuqcPACRk8uAP1VgCxtrzBXj1j5wlvfMO8jcOUZB8/wHOwV1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183682; c=relaxed/simple;
	bh=RF7m/eMaL/E97jUQyd+gOCRQbAW9R0vzgMkqgXGP+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg+qmwgu5oDRiF1J0jf2yodV8b1egm56A10zvPIQkymza/WKU1wdwo8Z4pr7ror1b36CRK1pu1X4CZlRaqoG/uOJFoxVPz/CCixFp5eKp6y9yvDwI0vSODERHIYE8JoVzjAAYGmqPYW/KvIQ25mdw4O/fpJy5fkZycFmtXhbK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZTuLJLS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZTuLJLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717183680; x=1748719680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RF7m/eMaL/E97jUQyd+gOCRQbAW9R0vzgMkqgXGP+RU=;
  b=EZTuLJLS8lD9PLJ2zVUwtK3fmT/CTNvEqgsiQ3EfL+vO45kD1Y58cczu
   5P2F2bmjgOMOLEl0vkpeouhHeMcM4Fyxq0t24mBojrBw9qfQnxtyC36vA
   0nnaII0MduoeoElPk9PwH6oZq452gfbVqgM+B7ZyeylBU3ftkghAMCWkL
   6pHpFhCuAP8N7NcOk+9Ww7ZmpWvEnuCnsscwAS4xsrE1CuQLtrvqH+XZ5
   MeaJUiU27BcIQrser6+FYN6SQzsB+f1ueJl1ErUV/BIpbLKJ6KlclQDzq
   Q9NuHYp5FeVEJIfi6/QDaTwwKT5e85HrmrO47KWQLUYdPePZENIWp8hrg
   Q==;
X-CSE-ConnectionGUID: DURaVn7AQuOEtqV2TLC9+A==
X-CSE-MsgGUID: rE6ReBS4SUuE8/lrkVWkew==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13498472"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13498472"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:27:59 -0700
X-CSE-ConnectionGUID: p5Za7zBeR4CIiD+gCTtvZA==
X-CSE-MsgGUID: kec2dWNeR2mdEuFViOhSDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36196331"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 31 May 2024 12:27:57 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD7ut-000Hip-0y;
	Fri, 31 May 2024 19:27:55 +0000
Date: Sat, 1 Jun 2024 03:26:56 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Rusuf <yorha.op@gmail.com>, damon@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, sj@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: implement multi-context support
Message-ID: <202406010337.eZEQ5XmV-lkp@intel.com>
References: <20240531122320.909060-3-yorha.op@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531122320.909060-3-yorha.op@gmail.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.9]
[also build test WARNING on linus/master next-20240531]
[cannot apply to sj/damon/next akpm-mm/mm-everything v6.10-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Rusuf/mm-damon-core-add-struct-kdamond-abstraction-layer/20240531-202756
base:   v6.9
patch link:    https://lore.kernel.org/r/20240531122320.909060-3-yorha.op%40gmail.com
patch subject: [PATCH v2 2/2] mm/damon/core: implement multi-context support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240601/202406010337.eZEQ5XmV-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010337.eZEQ5XmV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010337.eZEQ5XmV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/damon/dbgfs.c:10:
   In file included from include/linux/damon.h:11:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
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
   In file included from mm/damon/dbgfs.c:10:
   In file included from include/linux/damon.h:11:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
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
   In file included from mm/damon/dbgfs.c:10:
   In file included from include/linux/damon.h:11:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
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
   In file included from mm/damon/dbgfs.c:10:
   In file included from include/linux/damon.h:11:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> mm/damon/dbgfs.c:400:13: warning: unknown pragma ignored [-Wunknown-pragmas]
     400 | #pragma GCC push_options
         |             ^
   mm/damon/dbgfs.c:401:13: warning: unknown pragma ignored [-Wunknown-pragmas]
     401 | #pragma GCC optimize("O0")
         |             ^
   mm/damon/dbgfs.c:446:13: warning: unknown pragma ignored [-Wunknown-pragmas]
     446 | #pragma GCC pop_options
         |             ^
>> mm/damon/dbgfs.c:1125:13: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1125 |         } else if (!strncmp(kbuf, "off", count)) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/damon/dbgfs.c:1132:7: note: uninitialized use occurs here
    1132 |         if (!ret)
         |              ^~~
   mm/damon/dbgfs.c:1125:9: note: remove the 'if' if its condition is always false
    1125 |         } else if (!strncmp(kbuf, "off", count)) {
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1126 |                 dbgfs_stop_kdamonds();
         |                 ~~~~~~~~~~~~~~~~~~~~~~
    1127 |         } else {
         |         ~~~~~~
   mm/damon/dbgfs.c:1101:13: note: initialize the variable 'ret' to silence this warning
    1101 |         ssize_t ret;
         |                    ^
         |                     = 0
   mm/damon/dbgfs.c:893:13: warning: unused function 'dbgfs_destroy_damon_ctx' [-Wunused-function]
     893 | static void dbgfs_destroy_damon_ctx(struct damon_ctx *ctx)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   12 warnings generated.


vim +400 mm/damon/dbgfs.c

   399	
 > 400	#pragma GCC push_options
   401	#pragma GCC optimize("O0")
   402	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
