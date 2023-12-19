Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628AF63AC;
	Tue, 19 Dec 2023 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKxIo+tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68741C433C7;
	Tue, 19 Dec 2023 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702952396;
	bh=bMdUl2uM1U9HzkZZycGPzYls2j01kCAcRdaJWF7S5hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKxIo+ttsXwYuS2A/o13gROjgVIStuzRJmAk1ZJ/x5kKOENmzst+VCC2/QR0c9KFP
	 C1S53I64cpV/2Acld30kcDlyuyNo2sUBk6Nq2tjC2WWTBMXsDjUFRxQ5ZSnvubxzjp
	 NaxIh0OKLvsdqVlYRtBHmqAMIuzgoRpthZ4F2nkqWWXUtcDeZprJYRwTnJ4m5OkCV8
	 VuMMYHpe4Al0eIWoYDfKrrsMcTAALcRCAUj2v0jVzRiUYf6pLiGaDimL9OXB38/tNW
	 JbCl2EgkNMjaXKNxu35/9iHjwz43JZ3pxBrSALuGwrCeuiS1Yv5+xb33XUB2atIkhO
	 HgOYxyAX08F3g==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 18/24] mm/damon/sysfs.c:96:30: error: 'counted_by' only applies to C99 flexible array members
Date: Tue, 19 Dec 2023 02:19:54 +0000
Message-Id: <20231219021954.105864-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202312190546.yhWbDA8A-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 19 Dec 2023 05:30:54 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   04cc9f72453632bf9e13e06f85c11147583e5d5d
> commit: 375af4a6e206c1aeb2edb1d80cbb42fd3349b287 [18/24] mm/damon/sysfs: add __counted_by() annotation
> config: arm-randconfig-001-20231219 (https://download.01.org/0day-ci/archive/20231219/202312190546.yhWbDA8A-lkp@intel.com/config)
> compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 5ac12951b4e9bbfcc5791282d0961ec2b65575e9)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312190546.yhWbDA8A-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312190546.yhWbDA8A-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/damon/sysfs.c:96:30: error: 'counted_by' only applies to C99 flexible array members
>       96 |         struct damon_sysfs_region **regions_arr __counted_by(nr);
>          |                                     ^~~~~~~~~~~
>    mm/damon/sysfs.c:292:30: error: 'counted_by' only applies to C99 flexible array members
>      292 |         struct damon_sysfs_target **targets_arr __counted_by(nr);
>          |                                     ^~~~~~~~~~~
>    mm/damon/sysfs.c:815:31: error: 'counted_by' only applies to C99 flexible array members
>      815 |         struct damon_sysfs_context **contexts_arr __counted_by(nr);
>          |                                      ^~~~~~~~~~~~
>    mm/damon/sysfs.c:1666:31: error: 'counted_by' only applies to C99 flexible array members
>     1666 |         struct damon_sysfs_kdamond **kdamonds_arr __counted_by(nr);
>          |                                      ^~~~~~~~~~~~
>    4 errors generated.
> 
> 
> vim +/counted_by +96 mm/damon/sysfs.c
> 
>     89	
>     90	/*
>     91	 * init_regions directory
>     92	 */
>     93	
>     94	struct damon_sysfs_regions {
>     95		struct kobject kobj;
>   > 96		struct damon_sysfs_region **regions_arr __counted_by(nr);
>     97		int nr;
>     98	};
>     99	

Thank you for this report.  I will remove the commit from the tree.


Thanks,
SJ

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
