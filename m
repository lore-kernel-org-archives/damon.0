Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D65694;
	Sun, 19 Nov 2023 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb9Prg7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D42EC433C7;
	Sun, 19 Nov 2023 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700416539;
	bh=LZcAEnEUaEeGngJ4ih0zr/Qjr0gCgV6ZBikCHx99Gx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bb9Prg7bb+qwBJHboYckEb0NyeBzAM5Ds011TjUFzpPptiK4ziim1c11f1YpkHoZ+
	 fZdu+f9XQPIx0D5SoxJndKbrjo4u2+X97XNsUGdiUaSoHjoZV/NBy8IJMUH0j1gDDM
	 rkOObZJTF655SPivFG4Z+qIpotmLyQUu1A1/wDSH4P2qRWH0eibdy7Q0O684J08rqB
	 Ggw4vyu6QXBsiqupphdfR5/tnKXx9JjRek3IzZi9xCz/UmYbyGmfGx7pP7sitg1G+m
	 5InnKaNDRkbh1IC/eQNsEC4WwRHyygbORLOiw4qmotoR6HmeJMgU0D4TZMrX4qTa/Y
	 /T1PJcW7fVMGw==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [sj:damon/next 7/40] mm/damon/core-test.h:301:43: warning: large integer implicitly truncated to unsigned type
Date: Sun, 19 Nov 2023 17:55:36 +0000
Message-Id: <20231119175536.81465-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202311190815.NSeoMUOt-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello robot,

On Sun, 19 Nov 2023 08:59:05 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   8dbdd274afed68979a606009d184cc9fd9dcc48c
> commit: c5b4cd2968f94e487351a07c141023e44a2e9d3d [7/40] mm/damon/core-test: test overflow-causing divide-by-zero
> config: i386-buildonly-randconfig-001-20231119 (https://download.01.org/0day-ci/archive/20231119/202311190815.NSeoMUOt-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311190815.NSeoMUOt-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311190815.NSeoMUOt-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from mm/damon/core.c:1689:0:
>    mm/damon/core-test.h: In function 'damon_test_nr_accesses_to_accesses_bp':
> >> mm/damon/core-test.h:301:43: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>       .sample_interval = 10, .aggr_interval = 42949672960,};
>                                               ^~~~~~~~~~~

Thank you for this report!  I will make below fix and squash that into the
fixee commit.


    --- a/mm/damon/core-test.h
    +++ b/mm/damon/core-test.h
    @@ -305,7 +305,9 @@ static void damon_test_set_regions(struct kunit *test)
     static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
     {
            struct damon_attrs attrs = {
    -               .sample_interval = 10, .aggr_interval = 42949672960,};
    +               .sample_interval = 10,
    +               .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
    +       };
    
            KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
     }


Thanks,
SJ

[...]
