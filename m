Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77663AF;
	Fri, 12 May 2023 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683887749; x=1715423749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2opvhMbatw/DcaVcnQ1fua4laihyL3mGTblF3mM3Gdc=;
  b=c7xAuZ0c7YeFu2i2lqpGaVrz+dfroKJ8jLqwgSaScaHkeoqHovoJfT3Q
   2oBZbutckqQZzDwlTy6XZJoqAzyEHNU4mULehtjiU8i+HGtS3tcpCA+D4
   bgMxcYdHlZF/1tK8cfKeYy0V386ADoIvi7dFekIzmZgxhPHVuRBlPki/w
   H1N8oshm32EWcd8fBn8i7GWHJXT5vKre5mB3jevq7XNe8Nx0iDnPUPkDz
   2fIFeBPCMEo11HdMJF2tPk/WXDjv/LF1eT5GxrbQj/YXe8XNi1mWinLrj
   +YCK8I9TgvJI1T4zkw53UgiOzYhbN2i4c6sHLY/qwconCIJiaFIbTAO1w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378893456"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378893456"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874353843"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="874353843"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2023 03:35:45 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pxQ7l-0004mn-00;
	Fri, 12 May 2023 10:35:45 +0000
Date: Fri, 12 May 2023 18:34:56 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	SeongJae Park <sj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v1 5/5] mm: ptep_deref() conversion
Message-ID: <202305121818.hTDtbbPW-lkp@intel.com>
References: <20230511125848.78621-6-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511125848.78621-6-ryan.roberts@arm.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-damon-must-atomically-clear-young-on-ptes-and-pmds/20230511-215947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230511125848.78621-6-ryan.roberts%40arm.com
patch subject: [PATCH v1 5/5] mm: ptep_deref() conversion
config: m68k-randconfig-r002-20230511 (https://download.01.org/0day-ci/archive/20230512/202305121818.hTDtbbPW-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2d5aca0fcce58b92572fc59bee59a4c5588f2af8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ryan-Roberts/mm-damon-must-atomically-clear-young-on-ptes-and-pmds/20230511-215947
        git checkout 2d5aca0fcce58b92572fc59bee59a4c5588f2af8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305121818.hTDtbbPW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:52:
   include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~
>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~~~~~~~
   kernel/fork.c: At top level:
   kernel/fork.c:164:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     164 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:991:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     991 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:1086:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
    1086 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from kernel/sysctl.c:45:
   include/linux/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/linux/hugetlb.h:1203:16: error: implicit declaration of function 'ptep_deref' [-Werror=implicit-function-declaration]
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~
>> include/linux/hugetlb.h:1203:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
    1203 |         return ptep_deref(ptep);
         |                ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ptep_deref +1203 include/linux/hugetlb.h

  1199	
  1200	static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
  1201						  unsigned long addr, pte_t *ptep)
  1202	{
> 1203		return ptep_deref(ptep);
  1204	}
  1205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
