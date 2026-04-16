Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4C311C07
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776313783; cv=none; b=EJ1GTZCt/aLjE/ZhbrShYvcQSy3/qwEHlZW8OaF3U9/XXQCzqIfS48M1hqIJa0H9Wnw/AXhZq5DEX7Znbgk3MDBZAIV/WjiAum0cqdnu9qeYLJ85xV243/lsJxnjr+AB5KrytIRVAACjgGhz+vjnkWgfUu6Qc8LCGUrcT+N4XNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776313783; c=relaxed/simple;
	bh=WkFVFnHdYhdHlekRRgQg5zicg01Cpmy56V9KEy7RHvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4cLkkNYxwAaCcItkxOXlt94/4mgNYiBUJCoL0/4bQ2cIK3Tn9qPQ21rlEe7Wk9te9dHxvpaxmJIkoWdHllXokfXHEwcXbW0EoWAxbs2bHNe2sWzUWaL31OhysnsKTsEHXlcuRxDzGLCkbtlkd+TwpY6pAilMHZt+UajnQxxFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L24kADsn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L24kADsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BC4C2BCAF;
	Thu, 16 Apr 2026 04:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776313783;
	bh=WkFVFnHdYhdHlekRRgQg5zicg01Cpmy56V9KEy7RHvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L24kADsn8IsO56Z6aWK1Dp5jfNiMPh2bV9hPLMGGapHnklid8q+iOF4lLHWRkCFqy
	 bhFYuwKdY1eJbpcV7CVtU35LwSFfPadXppootnkSyUVBLW5ubrtRx8n4p1V0BRFN7S
	 K8kXohiN7K2kFRPGz8xJ7jJ7rlNLJkZc4E6Z83XEBHO9iLFjaOMyNV4fF+gaNZfZma
	 GRFxgSlbUzP7evAqqssqg3ROCQvr3xqkILhJNlOWzadwg+1Aww8DnvWTAvrn03A4cj
	 R9k3BBw6yWVdnRB87BZxStUmhqvqrmV7kOICLvOBw1JS8GtPn+dS+d3NXIXuIHngIR
	 gRj+ILmqWKJeA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Wed, 15 Apr 2026 21:29:36 -0700
Message-ID: <20260416042937.90822-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416040602.88665-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 21:06:01 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 15 Apr 2026 20:35:45 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > TL; DR: Sashiko found good point.  I will fix it in the next revision.
> > 
> > On Thu, 16 Apr 2026 00:59:35 +0000 sashiko-bot@kernel.org wrote:
> > 
> > > Sashiko AI review found 1 potential issue(s):
> > > - [Medium] Stale `kdamond_pid` exposed to userspace if `damon_call()` fails during startup.
> > > --
> > > 
> > > commit 46eb0a4278ccd2dec190db28b78b0766b8865901
> > > Author: SeongJae Park <sj@kernel.org>
> > > 
> > > mm/damon/stat: add a parameter for reading kdamond pid
> > > 
> > > This commit exposes the pid of the DAMON_STAT kdamond via a new read-only
> > > module parameter named kdamond_pid, standardizing usage with other DAMON
> > > modules.
> > > 
> > > > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > > > index 99ba346f9e325..4901e9a7c3398 100644
> > > > --- a/mm/damon/stat.c
> > > > +++ b/mm/damon/stat.c
> > > 
> > > [ ... ]
> > > 
> > > > @@ -260,6 +269,14 @@ static int damon_stat_start(void)
> > > >  		damon_stat_context = NULL;
> > > >  		return err;
> > > >  	}
> > > > +	kdamond_pid = damon_kdamond_pid(damon_stat_context);
> > > > +	if (kdamond_pid < 0) {
> > > > +		err = kdamond_pid;
> > > > +		kdamond_pid = -1;
> > > > +		damon_destroy_ctx(damon_stat_context);
> > > > +		damon_stat_context = NULL;
> > > > +		return err;
> > > > +	}
> > > >  
> > > >  	damon_stat_last_refresh_jiffies = jiffies;
> > > >  	call_control.data = damon_stat_context;
> > > 
> > > If damon_call() fails right after this and returns an error,
> > > damon_stat_start() will pass that error back to its caller and the module
> > > will revert to a disabled state.
> > > 
> > > Does this leave a stale kdamond_pid exposed to userspace? The newly added
> > > documentation states: "If DAMON_STAT is enabled, this becomes the PID of
> > > the worker thread. Else, -1." Since the initialization fails, the module
> > > remains disabled, but kdamond_pid isn't reset to -1 on this error path.
> > 
> > Nice catch.  I will do the kdamond_pid setup after damon_call() success, like
> > below.
> 
> Wait...  The same question was also raised [1] by Sashiko on the previous
> version.  And I was wrongly saying it is not this patch's fault.  That was
> completely wrong.
> 
> And the kdamond can stop even after the damon_kdamond_pid() call, if the
> region_store_histogram allocation fails.  In the case, kdamond_pid will again
> be stale.  'enabled' parameter value will also be stale in the case.  The worst
> part of it is that in the case, DAMON_STAT cannot be restarted before the
> system is reboot.  The bug is similar to the one [2] that Liew found and
> working on.

The last two sentences are wrong...  In case of damon_stat(), writing 'N' to
'enabled' will just update the parameter even if damon_stop() fails.  Hence,
users can restart DAMON_STAT after 'enabled' value became stale, by writing 'N'
to 'enabled' parameter to reset the value, and then writing 'Y' to 'enabled'
parameter again, to invoke damon_start() call.  Still far from good user
experience, but less critical than the bug that Liew is working on.

> 
> I will hold this patch and fix the bug first.

My above opinion is same.  I will fix the bugs first.


Thanks,
SJ

[...]
