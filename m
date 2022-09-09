Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C6612F
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 21:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E40C433C1;
	Fri,  9 Sep 2022 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662759573;
	bh=ex7Bf0A+D0ut+bV7nbUASsm4O5uu3FG1xP29PsRanAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/kOBJE9/qBLBeRdYxTX8is5Xov7qBhcvCrkE3pySFEblHSvpQMa092HH+7wFUQjw
	 f41Y9KYPVP+1RAD0veTboU0ghOTpLsMjIrLjtfy+r++xzwbUWfhv9sVz7LdMqxEW7G
	 nX0Yziat8SBqkxOMeXpts373A3PXW1AqAcAehZNYMUujOe6Khe/FgcEQM9nCyZAnSj
	 2RVTOmAsDBdvyTdzeBNdoz4sPLDEEBoit0faAZe49NwG9fd6731/BYEM+qo/MRsqzn
	 OpNeRNFbbACh0oTK1xwsYWqL94elfE5W6ce5nZXf1U84K5RyMF7RndLk+6vRIXCcZh
	 M6Bp5A5AzHefQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Xin Hao <xhao@linux.alibaba.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] mm/damon: Remove duplicate get_monitoring_region() definitions
Date: Fri,  9 Sep 2022 21:39:31 +0000
Message-Id: <20220909213931.136283-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909204520.60047-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As my previous comments are almost only cosmetic trivial nits and I don't want
to make this unnecessarily delayed long, I made the changes on my own and
posted it:
https://lore.kernel.org/damon/20220909213606.136221-1-sj@kernel.org/

Xin, if there was anything I missed or there is anything you disagree about my
changes, please let me know.


Thanks,
SJ

On Fri, 9 Sep 2022 20:45:20 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 9 Sep 2022 10:41:05 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> 
> > In lru_sort.c and reclaim.c, they are all defining get_monitoring_region()
> > function, there is no need to define it separately.
> > 
> > As 'get_monitoring_region()' is not a 'static' function anymore, we try
> > to use a prefix to distinguish with other functions, so there rename it
> > to 'damon_find_biggest_system_ram'.
> > 
> > Suggested-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > ---
> >  include/linux/damon.h | 11 +++++++++++
> >  mm/damon/core.c       | 29 +++++++++++++++++++++++++++++
> >  mm/damon/lru_sort.c   | 37 ++-----------------------------------
> >  mm/damon/reclaim.c    | 37 ++-----------------------------------
> >  4 files changed, 44 insertions(+), 70 deletions(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 7b1f4a488230..6c863b281fb2 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -448,6 +448,16 @@ struct damon_ctx {
> >  	struct list_head schemes;
> >  };
> >  
> > +/**
> > + * struct damon_system_ram_region - System RAM resource address region of [@start, @end).
> 
> I prefer 80 columns, let's break down this line.
> https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings
> 
> Also this struct is gonna be used by only damon_find_biggest_system_ram(), so I
> think it might make more sense to move this into core.c.
> 
> And, as this is not aimed to directly be used by external API users, I think it
> would make more sense to hide from kernel doc (/* instead of /**).
> 
> > + * @start:	Start address of the  (inclusive).
> 
> of the 'region'?
> 
> > + * @end:	End address of the region (exclusive).
> 
> I like the nice explanation: whether its inclusive or exclusive.
> 
> > + */
> > +struct damon_system_ram_region {
> > +	unsigned long start;
> > +	unsigned long end;
> > +};
> > +
> 
> As this struct is only used by damon_find_biggest_system_ram(), I think it
> might make more sense to move this into core.c?
> 
> Below parts all look good.
> 
> Also, this patch seems cannot cleanly applied on top of the latest
> mm/mm-unstable branch.  Would need rebase.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 
