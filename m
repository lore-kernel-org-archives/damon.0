Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5230EAE7;
	Fri, 31 May 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186158; cv=none; b=gipmnun/98vUzcfIHO7pMWobaphcT3ukgWJ4g1vJkxJqVj/CIgZxSP7vi42UIOf5YoKtkikyxcC1pdcqy5ze1ZhLnCnd6LZLzQxx9mHCY80E4mdTZmmLtig48IXC1ZnRpLlCzJcjZcL0+ruwJVAQp1GA9hc8lU1jVRMDo0qgTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186158; c=relaxed/simple;
	bh=P8juHs+PWyQulz1d5mOIjTWKTAUtvRDCl9XVGn2CmwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFuHLTc0LxGTCn3pIjL7GcZ8T306tgyoqQYgh8WjgSGhWFMo+cccDJDtp13VAdSA5El5YXTx4XJC2V2EA0OhYLsP8OlpxGHRIYtJTF5MIJkrHByPdi4aRCYkUAcmH7K4TU5ATW6ERAR+Rm93b3IrtOGXta5LgZ4vxwSmldTT0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPOk50jg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPOk50jg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717186157; x=1748722157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P8juHs+PWyQulz1d5mOIjTWKTAUtvRDCl9XVGn2CmwA=;
  b=UPOk50jgsizjy6dHovAx4fYxdApPvaD8ic+ijy0NycakKrajsXIkTx45
   e4i5IlDnTC+hJIgLqxQ7Z/0O9FiS0B6DxN7OJUQffke9Exk6BRYGsN44F
   OxJ70d776mqwr3SrQzY3kSculI5Fox72BwlitiDhdGi2jyp9iDgzsUSPy
   E9Wy2Gtcjkz/qqIVmTzgH4l4wBGp29Dxqim66Ihys/uoOtVf7LE+r5Y90
   FS64zqdgEjVE7zihqUAR7sa0HpYoxka0aYMXXeCEs+1QX2msdSoyjrdZG
   ZWpHneatofeTZ+Qstmk4XGyMpD29/ZFOfsc++XgESz7ZLxovERpXg6LaE
   g==;
X-CSE-ConnectionGUID: DvUINrpzRJeVOQAGZv/HnA==
X-CSE-MsgGUID: B51GZTPfQu6FiyQ12QsoJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="16698688"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="16698688"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 13:09:16 -0700
X-CSE-ConnectionGUID: j9rLHKtqT+uEwAc+SlEm/A==
X-CSE-MsgGUID: wPeLsLYjTaWBRezONJODhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="41187332"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 31 May 2024 13:09:14 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD8Yq-000Hlx-0q;
	Fri, 31 May 2024 20:09:12 +0000
Date: Sat, 1 Jun 2024 04:08:44 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Rusuf <yorha.op@gmail.com>, damon@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, sj@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: implement multi-context support
Message-ID: <202406010349.tixi9sK3-lkp@intel.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240601/202406010349.tixi9sK3-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010349.tixi9sK3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010349.tixi9sK3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/damon/core.c:513: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Adds newly allocated and configured @ctx to @kdamond.
   mm/damon/core.c:729: warning: Function parameter or struct member 'kdamond' not described in 'damon_kdamond_running'
>> mm/damon/core.c:742: warning: Function parameter or struct member 'kdamond' not described in 'kdamond_nr_ctxs'
   mm/damon/core.c:1596: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Returns minimum wait time for monitoring context if it hits watermarks,


vim +742 mm/damon/core.c

   737	
   738	/**
   739	 * kdamond_nr_ctxs() - Return number of contexts for this kdamond.
   740	 */
   741	static int kdamond_nr_ctxs(struct kdamond *kdamond)
 > 742	{
   743		struct list_head *pos;
   744		int nr_ctxs = 0;
   745	
   746		list_for_each(pos, &kdamond->contexts)
   747			++nr_ctxs;
   748	
   749		return nr_ctxs;
   750	}
   751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
