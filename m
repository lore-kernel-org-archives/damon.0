Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D14E61C;
	Wed, 22 Nov 2023 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCrX36+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCB0C433C8;
	Wed, 22 Nov 2023 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700679052;
	bh=Aef3Nc8tBndl7jMTaRxytqDcQd1lyM7XV+tBkvsy5Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCrX36+o2bNWDKv/uOYN/dOlFDd3Ps7g0faIiNY2BAtI/6gOBULDCZb7tswMpjG5X
	 xVsr/2dTgj1TSZwhBth6IePCvSJRk7RwMYdPz/NK6wn+zgfbxCM/VS7H30d1rryrp/
	 JVARuJWkh8c4In+mqqFpXl017T97qgtuS+UlqP2ZfR0WLmOPKh2QAOXJwoEy/upGka
	 DggcuD5X7tUk2l9zhbo7h+ehk91ArBDtRSk+81RjRgkVNIl7cEo/jv4s1TiWuolW6C
	 3b7upywJe8UmyVxdbmUELgPEdwWNMaGFeseEKJSGiqbqg08c5iYw7K0iye0oSKNi/1
	 oh40DOwammhmA==
From: SeongJae Park <sj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild@lists.linux.dev,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 32/42] mm/damon/core.c:1150 damos_set_effective_quota() error: uninitialized symbol 'esz'.
Date: Wed, 22 Nov 2023 18:50:49 +0000
Message-Id: <20231122185049.102436-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aa9343f1-b0f9-4452-82e9-d63192ecbcd7@suswa.mountain>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Nov 2023 04:13:36 -0500 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Tue, Nov 21, 2023 at 05:36:02PM +0000, SeongJae Park wrote:
> > Hi Dan,
> > 
> > On Tue, 21 Nov 2023 02:37:12 -0500 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> > > head:   54ffd8ae08121d8cbce1874fe46970cce643a2c7
> > > commit: 28cef0e565adbb4175f12ffffce9d0680979de60 [32/42] mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning
> > > config: x86_64-randconfig-161-20231121 (https://download.01.org/0day-ci/archive/20231121/202311210420.URG3QSAS-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20231121/202311210420.URG3QSAS-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Closes: https://lore.kernel.org/r/202311210420.URG3QSAS-lkp@intel.com/
> > > 
> > > smatch warnings:
> > > mm/damon/core.c:1150 damos_set_effective_quota() error: uninitialized symbol 'esz'.
> > 
> > Thank you for this nice report!
> > 
> > However, damos_set_effective_quota() is called from damos_adjust_quota(), which
> > ensures at least one among quota->{ms,sz,get_score} is nonzero.  And
> > damos_set_effective_quota() ensures quota->{ms,get_score} is non-zero at the
> > beginning of the function.  Then the function sets esz anyway, for non-zero
> > quota->ms and quota->get_score.
> 
> The problem is in the "non-zero quota->ms" situation.  It uses an
> uninitialized value of esz to initialize esz.
> 
> 28cef0e565adbb SeongJae Park 2023-10-27 @1150           esz = min(throughput * quota->ms, esz);
>                                                         ^^^                               ^^^
> This is the uninitialized variable.

Ah, you're correct.  I was out of mind.  Thank you for this kind explanation.
I will squash below fix to the broken commit.

    --- a/mm/damon/core.c
    +++ b/mm/damon/core.c
    @@ -1147,7 +1147,10 @@ static void damos_set_effective_quota(struct damos_quota *quota)
                                    quota->total_charged_ns;
                    else
                            throughput = PAGE_SIZE * 1024;
    -               esz = min(throughput * quota->ms, esz);
    +               if (quota->get_score)
    +                       esz = min(throughput * quota->ms, esz);
    +               else
    +                       esz = throughput * quota->ms;
            }
    
            if (quota->sz && quota->sz < esz)


Thanks,
SJ

> 
> regards,
> dan carpenter
> 
