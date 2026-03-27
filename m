Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4657378D9F;
	Fri, 27 Mar 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633562; cv=none; b=S+xOCtmU9XzJV87lWfRyVZtY4uH44lSKmkYGPtqCfOUUGCb+XfXsJyegtGDf09d052XWZksm2vsRGoiKpRDsTFB75iTRZKcQSMAMeXaBvFAXpOcYxlyVd4hyN+OJL9NatmULN7J2kWExa7eoOF5BMLVln6ZlAVUmXLUfciyncE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633562; c=relaxed/simple;
	bh=z/CH+fL/zxceLK7ru9wfJerm4tn4XlbqqXD2+K9ew8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca9W1JV9HYLxf+a14FZ1mZWBBpBQlJNyIOneajJOCrtsl/rTQWlh/enIYlG/ZYF7OzvXE8xC7wreNqlYPYSOd9RpudBXLJm7j03RiE44aHdTLqmaMLA13zjnmxdHElHrm9zL/ANFgktpxEEFuLkX/9CG2FhO7X7SOAt5ZtL/NuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCccbtx6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCccbtx6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774633561; x=1806169561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z/CH+fL/zxceLK7ru9wfJerm4tn4XlbqqXD2+K9ew8Q=;
  b=mCccbtx6cOon7UL/w/PTm4DtDkvCs9qqXikcofuBd0gqWRMFc8F2oqQ3
   FYLXnXKAeizpIo3iUtAztUTt+EYHc0AZpJEDNNdsCZaDhwyiWiOu5ZwsL
   GMwImVU79UMkP6qJDxSl+iMt26/rWGn1FiyK7DN3SeKt2kxQp6kX8xDSZ
   yvzasMO6GDQrm8bZcUQFJaHxG2hQ36G/jve+neBwCA/F+lGxLOyUZy1NO
   91Ra+SukWCFXwf9wX7a7f9lzyQwBPLPxb0R88vhUh2LGTGpEIdzBeJ8ga
   khz72JP63KpdVrVkXH49b9HMISkvq2OeH0e5LJD969rF/EE2/C5NWZisS
   g==;
X-CSE-ConnectionGUID: NYYSukx+RkiCn0WRijppIQ==
X-CSE-MsgGUID: u3Pp8ludS5mVH+xuzMemCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="87099746"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="87099746"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:46:00 -0700
X-CSE-ConnectionGUID: AH8IA/21QmiQrQt0rorvmg==
X-CSE-MsgGUID: mLSgDg5XTiiWjXhKV+dBVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="229873595"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Mar 2026 10:45:58 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6BFq-00000000AXt-3xVj;
	Fri, 27 Mar 2026 17:45:54 +0000
Date: Sat, 28 Mar 2026 01:45:29 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Law <objecting@objecting.org>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering
 module
Message-ID: <202603280122.ldJtc5AT-lkp@intel.com>
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260328/202603280122.ldJtc5AT-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603280122.ldJtc5AT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603280122.ldJtc5AT-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/damon/tier.c: In function 'damon_tier_apply_parameters':
>> mm/damon/tier.c:280:15: error: too few arguments to function 'damon_set_region_biggest_system_ram_default'; expected 5, have 4
     280 |         err = damon_set_region_biggest_system_ram_default(param_target,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from mm/damon/tier.c:13:
   include/linux/damon.h:995:5: note: declared here
     995 | int damon_set_region_biggest_system_ram_default(struct damon_target *t,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/damon_set_region_biggest_system_ram_default +280 mm/damon/tier.c

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
 > 280		err = damon_set_region_biggest_system_ram_default(param_target,
   281						&monitor_region_start,
   282						&monitor_region_end,
   283						param_ctx->min_region_sz);
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
