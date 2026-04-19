Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA63C1F
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622802; cv=none; b=e3VNMsKwzQ1CU900JwiOAJTaWJOpltxIqzuZr3iMdK6n1BxnANJfWz+1qh7kzNhUQVK6ocIQvoswRoyiB+pkQC19k0+Vm6qeGhY08vvFeyDCpVytVqfRB0dekHLeSLvJizSFR1ZKlXEbo+9ZuNTrb1jWQe1bDE11EJ2hdB2S/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622802; c=relaxed/simple;
	bh=sA86FHgblAt65BZ9RSCl7ttzJLhv8Je3VttYS9fPxmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+xMTswOCBc0qZmeKzU6j0wn3zaAi3D6RSCTgeooV0DriNhKg45bo4nPLp/grdCa/dRPboo1rqJmYvrrDo7IkLinvjLnESBoao5pGXw9H9NevFvXdZ0i0Qb0GAmfM/v6sn1AIDEUjmgHQs6iO299brwlxrFkKhM002UvJ8vDUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogeupe8j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogeupe8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFE3C2BCAF;
	Sun, 19 Apr 2026 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776622802;
	bh=sA86FHgblAt65BZ9RSCl7ttzJLhv8Je3VttYS9fPxmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogeupe8jTVT8fn/l8EAmzf6LUpWotdBab6jw2ClGcMDozuxht7DBImBbO5RxLe3zE
	 fJnGIHrimzhUEZEgfEflELl6YIsgIfJ21UJmYMG3xSE7djoNKL5c5snY1qlxIxVaxz
	 Qd5JKC2/bLwV60r/Sb1jJMUnxf9D3K/GX5BtgDEfDDSfPBkXY1G+7FJxUVyg4uMbLA
	 vTnfeKyEMyVnoREdYLIvacE17t/x1Rz3UEuzcZvhzdAA6KD236qBre2f9tCJ3iYPuh
	 qPT52vyZhP38at4CjOI8Vo0OgApuGiF6BR0LfpC/71t7XM7d0zCHeHfzPpKlzhB3uu
	 PZptY+i2IKJQA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/3] mm/damon/stat: detect and use fresh enabled value
Date: Sun, 19 Apr 2026 11:19:54 -0700
Message-ID: <20260419181954.11159-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419175120.AEC4EC2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 19 Apr 2026 17:51:20 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 2 potential issue(s):
> - [Critical] Passing `enabled=Y` during module load triggers a double-start, failing initialization and causing a Use-After-Free kernel panic.
> - [High] Resource leak of `damon_stat_context` when explicitly disabling the module after an internal kdamond crash.

Both are wrong.  Please read below for more details.

> --
> 
> commit 16eae8a1bf380cdb61d4dd6b62187dd09f8ce859
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: detect and use fresh enabled value
> 
> This commit updates the DAMON_STAT module to dynamically detect the running
> status of its kdamond thread rather than relying on a cached parameter
> value.
> 
> Link: https://lore.kernel.org/20260416040602.88665-1-sj@kernel.org
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index 99ba346f9e325..3951b762cbddf 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> [ ... ]
> > @@ -273,17 +276,23 @@ static void damon_stat_stop(void)
> >  	damon_stat_context = NULL;
> >  }
> >  
> > +static bool damon_stat_enabled(void)
> > +{
> > +	if (!damon_stat_context)
> > +		return false;
> > +	return damon_is_running(damon_stat_context);
> > +}
> > +
> >  static int damon_stat_enabled_store(
> >  		const char *val, const struct kernel_param *kp)
> >  {
> > -	bool is_enabled = enabled;
> >  	int err;
> >  
> >  	err = kstrtobool(val, &enabled);
> >  	if (err)
> >  		return err;
> >  
> > -	if (is_enabled == enabled)
> > +	if (damon_stat_enabled() == enabled)
> >  		return 0;
> 
> If kdamond terminates asynchronously (for example, due to an allocation
> failure), damon_stat_enabled() will return false.
> 
> If a user subsequently disables the module by writing 'N' to the enabled
> parameter, this condition (false == false) evaluates to true and the
> function returns 0.
> 
> Does this skip the call to damon_stat_stop() and leak the
> damon_stat_context since damon_destroy_ctx() won't be called?

I previously explained [1] it is not leaked.

> 
> >  
> >  	if (!damon_initialized())
> > @@ -293,16 +302,17 @@ static int damon_stat_enabled_store(
> >  		 */
> >  		return 0;
> >  
> > -	if (enabled) {
> > -		err = damon_stat_start();
> > -		if (err)
> > -			enabled = false;
> > -		return err;
> > -	}
> > +	if (enabled)
> > +		return damon_stat_start();
> 
> During module load via "insmod damon_stat.ko enabled=Y", parse_args() calls
> this store function. Because damon_stat_enabled() dynamically returns false
> at this point, the code proceeds to call damon_stat_start() to start the
> kdamond thread.
> 
> Shortly after, the module initialization function damon_stat_init() runs,
> sees enabled == true, and calls damon_stat_start() again. This second call
> returns -EAGAIN because the context is already running.
> 
> The module initialization then fails, causing the kernel to unload the
> module and free its memory.
> 
> Since the kdamond thread is still actively running in the background, can
> this cause a Use-After-Free when the thread accesses the freed module
> memory?
> 
> While this issue previously existed if CONFIG_DAMON_STAT_ENABLED_DEFAULT=n,
> does this patch introduce the regression for the default configuration as
> well?

DAMON_STAT is a builtin module.  Users cannot load it dynamically, and
therefore the above scenario cannot happen.

[1] https://lore.kernel.org/20260417000308.58975-1-sj@kernel.org


Thanks,
SJ

[...]
