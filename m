Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2118E02A;
	Wed, 29 Oct 2025 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701449; cv=none; b=sLrAMj8x4CCRGt6ILw3uL4qmbaEbOrAFYCDOEZnVj+8yBbXzEU11JEXPaxhz+7zMh8NZHLW8nFfNfwW/379i7rMn5rC7/OZkapT4Nc5QRAwvq6ooiHuF1Y6SFYhKD0JnmuGiYG+IyvOWjcgBlYppI9SFeisMaiYkU6oyxIqkMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701449; c=relaxed/simple;
	bh=EQ3bCZVkdN7EmwD6AJ9LPqgIC7BgFpto7zSZs4VVicg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hiy6Mb6qRMh8qUzRROkQTnfkxLyWnqRgvebPKfMCzizHscAevFjXXItEVh8nyL5nxiZ/SLWRZLvzceLb8+IsasRYjYoSFDTSYP4PZOXdY/4ma3Z2jdqxh74t56cxZf3sWxOxCVgIH397PyeE1p1Bpqq3Fa/aXBZ6zCR+/6pIHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQS9ejdW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQS9ejdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9091C4CEE7;
	Wed, 29 Oct 2025 01:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701447;
	bh=EQ3bCZVkdN7EmwD6AJ9LPqgIC7BgFpto7zSZs4VVicg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQS9ejdWNO3Nbu7CZGOCbhwse4nNjgQROuhmP7+TM3dqdM451+M6oR30jF6RusXNo
	 n9F41W1NMQb59DJ9KQUcDMReSA3EtfZVhyosoTRlvg5Qw6LErwqQs3VYBQO4pNLl5I
	 JE1qZkKJMsY7WzYklJZL3w2LHf7vQiR5Xh36UR/gAAbuBfM6hGgc6Nq4lFji/lJvuh
	 6Wk+HS+mX30qdTFiMh+MIDdYNGqZ5MjJ9BIyq8Zaitbq4NC9r3PU2XWheGWBDwLpcc
	 yAr2Dmgm9MG5wn1lHoEa5C5TUeCC88ZZopnzT5tU1xkjArB73VYrg6ZuNFqzeGSpom
	 kyIWxMI633VOw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH] mm/damon/stat: set last_refresh_jiffies to jiffies at startup
Date: Tue, 28 Oct 2025 18:30:36 -0700
Message-ID: <20251029013038.66625-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028143250.50144-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Oct 2025 07:32:49 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 28 Oct 2025 07:19:14 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Tue, 28 Oct 2025 14:19:27 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> > 
> > > In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
> > > avoid unnecessarily frequent stat update.
> > > 
> > > On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
> > > jiffies wrap bugs appear earlier. However, this causes time_before_eq()
> > > in DAMON_STAT to unexpectedly return true during the first 5 minutes
> > > after boot on 32-bit systems (see [1] for more explanation, which fixes
> > > another jiffies-related issue in DAMON). As a result, DAMON_STAT does not
> > > update any monitoring results during that period, which can be more
> > > confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.
> > > 
> > > Fix it by setting last_refresh_jiffies to jiffies at startup.
> > 
> > Nice catch, thank you for this patch!
> > 
> > > 
> > > [1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
> > > 
> > > Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
> > > Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> > > ---
> > >  mm/damon/stat.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > > index 6c4503d2aee3..6dc3e18de910 100644
> > > --- a/mm/damon/stat.c
> > > +++ b/mm/damon/stat.c
> > > @@ -132,6 +132,9 @@ static int damon_stat_damon_call_fn(void *data)
> > >  	struct damon_ctx *c = data;
> > >  	static unsigned long last_refresh_jiffies;
> > >  
> > > +	if (unlikely(!last_refresh_jiffies))
> > > +		last_refresh_jiffies = jiffies;
> > > +
> > 
> > How about doing the initialization together with the declaration?  E.g.,
> > 
> >  static int damon_stat_damon_call_fn(void *data)
> >  {
> >         struct damon_ctx *c = data;
> > -       static unsigned long last_refresh_jiffies;
> > +       static unsigned long last_refresh_jiffies = jiffies;

Please ignore the above suggestion.  It will even not build, like below...

.../mm/damon/stat.c: In function ‘damon_stat_damon_call_fn’:
.../mm/damon/stat.c:133:53: error: initializer element is not constant
  133 |         static unsigned long last_refresh_jiffies = jiffies;
      |                                                     ^~~~~~~

> 
> Actually, a similar issue can happen again if DAMON_STAT is stopped and
> restarted by user.  That is, if user stops DAMON_STAT just after
> last_refresh_jiffies is updated, and restart it after 5 seconds or more, the
> time_before_eq() on damon_call_fn() will return true, so stat updates will
> happen earlier than expected.  Shouldn't be a real problem, but better to avoid
> if possible.
> 
> How about making last_refresh_jiffies a global variable and initialize it on
> damon_stat_start()?  To avoid unnecessary name conflicts, the variable name
> would also better to be changed, e.g., damon_stat_last_refresh_jiffies.

But, please consider the above one.

And I just realized a similar issue exist for next_update_jiffies in
mm/damon/sysfs.c file.  Please feel free to send a patch for that if you
willing to.


Thanks,
SJ

[...]
