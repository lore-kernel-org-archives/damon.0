Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EC7FBA8;
	Fri, 31 May 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181806; cv=none; b=uV3Qvj6Y0T0BErVPvkqzRkXfOADmncH3k66eH1QobNCtB8nr1sZaTieBLjmxVn9WQkTFKxMUADyB79N3RhwsluDj++1oMnz4o2NorempJO61kun33SWc0BDw8pmZQH0ARTF33c5YLQNqV5VdvYeXU22FfaRd29l9fQ5F90gGGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181806; c=relaxed/simple;
	bh=PxMGVz5tAuVNrqojcuopIgpo2O7ZCcFtKQPOhIiYcws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH9YeMn1BCxC0xkOFdHnbEvpgaOUjjoE6dlmQ1kWSCBDd5pb9G+cfRWxWISDekKc33RXhB1GshRqp0qiSGtfOkpYu8ygoGSeO5xqxNq3sFIdUT7FbeOCWhSv3UayWR14clZp56JCdtIdkeJmR9Mz95ZspGfetYmQsFmtiB6OhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkRbAW6f; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkRbAW6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717181805; x=1748717805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PxMGVz5tAuVNrqojcuopIgpo2O7ZCcFtKQPOhIiYcws=;
  b=jkRbAW6fSQ3KSeyPnaicb58zUDrDJLfwYXqf+H0YYGBGCXNCJpeRspyV
   p01bjmrB3J+dzTaUaha7T8sSE5AyHLWIOfXhbjLyI2sCZ/53KR/VR1705
   2wX5qsqKyq6Hqgi2vtvl9Px/HaZsIbtcqqioUUDoL1lXay7kNHHVi8YfF
   26LHX5mB5GosfOR0s1BI/WMExyAI3z9/wm5ukwAXXH8JbicMtd4Wui56L
   fnWnVhfq6IEELzxOjaHDHJFC1K8UoVp1/9gvicHTc9+wZTCXEqlT32NMD
   i3x+lg1SLkX/v0+G5pepS5A0W/3MN7PwyD5q+hOJRI5PAUJMC8G4vLOiS
   g==;
X-CSE-ConnectionGUID: UGhcLY0dRbCOTCTo+SmiKA==
X-CSE-MsgGUID: HlYTwUzpSxWI1Kri+IFHQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13581628"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13581628"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:56:43 -0700
X-CSE-ConnectionGUID: 8Jj/XliPTnu+Coa4J6fq3w==
X-CSE-MsgGUID: WHWbobLnT4CKsPSPzFH/xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40685325"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 31 May 2024 11:56:41 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD7QY-000Hfn-0w;
	Fri, 31 May 2024 18:56:35 +0000
Date: Sat, 1 Jun 2024 02:55:55 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Rusuf <yorha.op@gmail.com>, damon@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, sj@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: add 'struct kdamond' abstraction
 layer
Message-ID: <202406010253.LLixn74L-lkp@intel.com>
References: <20240531122320.909060-2-yorha.op@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531122320.909060-2-yorha.op@gmail.com>

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
patch link:    https://lore.kernel.org/r/20240531122320.909060-2-yorha.op%40gmail.com
patch subject: [PATCH v2 1/2] mm/damon/core: add 'struct kdamond' abstraction layer
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240601/202406010253.LLixn74L-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010253.LLixn74L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010253.LLixn74L-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/damon/core.c:511: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Adds newly allocated and configured @ctx to @kdamond.
>> mm/damon/core.c:729: warning: Function parameter or struct member 'kdamond' not described in 'damon_kdamond_running'


vim +511 mm/damon/core.c

   509	
   510	/**
 > 511	 * Adds newly allocated and configured @ctx to @kdamond.
   512	 */
   513	void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx)
   514	{
   515		list_add_tail(&ctx->list, &kdamond->contexts);
   516		++kdamond->nr_ctxs;
   517	}
   518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
