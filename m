Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74771225CA;
	Tue, 19 Dec 2023 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nArI6kr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BF0C433C8;
	Tue, 19 Dec 2023 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703006219;
	bh=JkZgTQ4qKXLtiKYzb3UuLrz6IohWk/aI+NqOeMDpYgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nArI6kr/LZsFEKmXQrX3eK2optVG8bk4iQq7PNCC9oT4oyLWqfJb+VySSmf1W6Gxt
	 2phb7/EvJGoSsBZWLavr53UKw57uOvQDrlmWhwLPrRqdeSjwuZ9oayCWdVF6HCqo7E
	 oczvcLxlroLfJX3VxbBWEcSpwzHRlE0l60kJn0C0qj2LmNI5TbvwYaNQ+vx1Pr0fIk
	 QLCUuF5ohEfK3LY1KfLf+ca1m5sWlrmmPmEZO/QygJ4OD6dLKEshZtwuj7fhLPv5G6
	 u3dDR9FyT1/fG8Rn8A9BtyCci8qmPdGypnWwsQUS4vCUPIFXwAoXCTTUOEs7pvrTzM
	 hXkvvCehg99SQ==
From: SeongJae Park <sj@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev,
	Kees Cook <keescook@chromium.org>,
	Bill Wendling <morbo@google.com>
Subject: Re: [sj:damon/next 18/24] mm/damon/sysfs.c:96:30: error: 'counted_by' only applies to C99 flexible array members
Date: Tue, 19 Dec 2023 17:16:57 +0000
Message-Id: <20231219171658.107144-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKwvOdkvGTGiWzqEFq=kzqvxSYP5vUj3g9Z-=MZSQROzzSa_dg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nick,

On Tue, 19 Dec 2023 08:47:03 -0800 Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Mon, Dec 18, 2023 at 6:20\u202fPM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, 19 Dec 2023 05:30:54 +0800 kernel test robot <lkp@intel.com> wrote:
> >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> > > head:   04cc9f72453632bf9e13e06f85c11147583e5d5d
> > > commit: 375af4a6e206c1aeb2edb1d80cbb42fd3349b287 [18/24] mm/damon/sysfs: add __counted_by() annotation
> > > config: arm-randconfig-001-20231219 (https://download.01.org/0day-ci/archive/20231219/202312190546.yhWbDA8A-lkp@intel.com/config)
> > > compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 5ac12951b4e9bbfcc5791282d0961ec2b65575e9)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312190546.yhWbDA8A-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312190546.yhWbDA8A-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> mm/damon/sysfs.c:96:30: error: 'counted_by' only applies to C99 flexible array members
> > >       96 |         struct damon_sysfs_region **regions_arr __counted_by(nr);
> > >          |                                     ^~~~~~~~~~~
> > >    mm/damon/sysfs.c:292:30: error: 'counted_by' only applies to C99 flexible array members
> > >      292 |         struct damon_sysfs_target **targets_arr __counted_by(nr);
> > >          |                                     ^~~~~~~~~~~
> > >    mm/damon/sysfs.c:815:31: error: 'counted_by' only applies to C99 flexible array members
> > >      815 |         struct damon_sysfs_context **contexts_arr __counted_by(nr);
> > >          |                                      ^~~~~~~~~~~~
> > >    mm/damon/sysfs.c:1666:31: error: 'counted_by' only applies to C99 flexible array members
> > >     1666 |         struct damon_sysfs_kdamond **kdamonds_arr __counted_by(nr);
> > >          |                                      ^~~~~~~~~~~~
> > >    4 errors generated.
> > >
> > >
> > > vim +/counted_by +96 mm/damon/sysfs.c
> > >
> > >     89
> > >     90        /*
> > >     91         * init_regions directory
> > >     92         */
> > >     93
> > >     94        struct damon_sysfs_regions {
> > >     95                struct kobject kobj;
> > >   > 96                struct damon_sysfs_region **regions_arr __counted_by(nr);
> > >     97                int nr;
> > >     98        };
> > >     99
> >
> > Thank you for this report.  I will remove the commit from the tree.
> 
> Being able to annotate pointers with this attribute is in the works
> (but is not ready yet). Thanks for thinking of this and trying it out
> though! Consider adding a todo to add such attribute in the future!

Thank you for the suggestion.  I added an item for this on my humble TODO
list[1].  Doing this also reminded me that I should cleanup the list :)  Thank
you!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/damon-hack.git/commit/?id=9ef6f86a5cc37


Thanks,
SJ

> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
