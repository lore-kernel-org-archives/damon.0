Received: from mgamail.intel.com (unknown [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F31C8DA;
	Fri, 28 Jul 2023 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690531740; x=1722067740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7H1DGTtPz3o+QAj240HysVc/w83lxlzbiBKVni7/XEY=;
  b=DAgkVRyI5KD5rebYeeKKLGO5DOQuJJBQtRwJ2xK2Zh4KxM8C3dhgTtsZ
   KeNAPUxL8uNlW6CIW/4dk2vtur+LPppwJK8RB1zQKTzQDVEUqaAmnnrdk
   CEeYIQbBvxpsEUWHXbDSeEvFZqROD1+O/Jh3B2jfSnCtAj6nDvn99+4hp
   /uMkqpmSGmhodItUFb3phxx4JhbVO1fiujwQX5Cebit9OXIXlRZ/0VMxZ
   yAcTcaaEI6Z+ohKQKxOwRBsLXClZNJJju2DONbqRYDbnEeJL+HlY8DzO/
   7Vu+MNcnmbJGftmqzDXt5kkAwC+Zzau3QCe4XTlJhvx0Jr718JqeauNPa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372156417"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="372156417"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797357757"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="797357757"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2023 01:08:57 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qPIWu-000313-2R;
	Fri, 28 Jul 2023 08:08:56 +0000
Date: Fri, 28 Jul 2023 16:08:11 +0800
From: kernel test robot <lkp@intel.com>
To: Levi Yun <ppbuk5246@gmail.com>, sj@kernel.org,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: Re: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
Message-ID: <202307281532.pVsrTsL2-lkp@intel.com>
References: <20230727183745.682880-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727183745.682880-1-ppbuk5246@gmail.com>

Hi Levi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5-rc3 next-20230728]
[cannot apply to sj/damon/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Levi-Yun/damon-Use-pmdp_get-instead-of-drect-dereferencing-pmd/20230728-024044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230727183745.682880-1-ppbuk5246%40gmail.com
patch subject: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
config: i386-randconfig-i016-20230727 (https://download.01.org/0day-ci/archive/20230728/202307281532.pVsrTsL2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281532.pVsrTsL2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281532.pVsrTsL2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/damon/vaddr.c: In function 'damon_young_pmd_entry':
>> mm/damon/vaddr.c:440:15: warning: unused variable 'pmde' [-Wunused-variable]
     440 |         pmd_t pmde;
         |               ^~~~


vim +/pmde +440 mm/damon/vaddr.c

   434	
   435	static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
   436			unsigned long next, struct mm_walk *walk)
   437	{
   438		pte_t *pte;
   439		pte_t ptent;
 > 440		pmd_t pmde;
   441		spinlock_t *ptl;
   442		struct folio *folio;
   443		struct damon_young_walk_private *priv = walk->private;
   444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
