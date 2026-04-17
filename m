Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF52C9D
	for <damon@lists.linux.dev>; Fri, 17 Apr 2026 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776384196; cv=none; b=t99jA06xujkqNJLyuRce/OIecUOGt0G6Mw+lM1fB9pDuouYBx58kBEKTH9P2aGzNx4PUSP8dj+YeRrVTZWcb0u5GUMa88c2aWpqBIYPZlU1H0v7OpOF98OWNpjkhk4duUeiKZ842TcixV4ZSJfANcYOa4s2JiEzEzPTrs4W0GTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776384196; c=relaxed/simple;
	bh=FLWmQyZWoaJ/+fLs5A9o7CY1cgdACZZQxykXQ6sPwuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nygGLhP9CeJWkdk3ZI6Ze5xhL84SOPGm8TcMAnNWJmjSzWQvTDUDBMUb0B4Y/xRQBBERWtMnXxSMFedO2OmZ5L3jxE45bdUMsRDGyzWoLp+R+GgVitJb28aE6RgjFZE5A8hP8a6R81Mbk95I3fgZxqk+Fk0n35bnoP+gR4q+GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHOUy6Ne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHOUy6Ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3FDC2BCAF;
	Fri, 17 Apr 2026 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776384196;
	bh=FLWmQyZWoaJ/+fLs5A9o7CY1cgdACZZQxykXQ6sPwuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHOUy6NeIxiJDb8Xpj646JDol7yHSKg02pm6qTrBxK9OEHn5NZT1CSUXqWOCxiy46
	 w5SdBGszx1u0qcV4Y0GO5dCSDsG1Sogbv7Nr55Wm2lH0aEriAB6rINwQ1S7DUbsJTn
	 7737dcM1xa+MAtEo6A9b9qiGCgaZelhrbaRmWzSRbHL2rJ+ZW9inO5A1WCSPBdgdxN
	 Qc0UYKougiIZvaClqqdx1vNkWvB33TvP7BUTLuEAB7HvSMKBbJ1HC2pe+iF19PnocO
	 qFjzT9boP9WseMiWJtvfh0xYdwrx0wo8YrhWmnTQJhAT0FwdeXQJvLsiKtsdDaA1un
	 t1bMbAU4mk3kg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/stat: detect and use fresh enabled status
Date: Thu, 16 Apr 2026 17:03:06 -0700
Message-ID: <20260417000308.58975-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416185159.54460C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 16 Apr 2026 18:51:58 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Medium] Writing 'N' to the `enabled` parameter after kdamond has stopped unexpectedly bypasses `damon_stat_stop()`, leaking `damon_stat_context`.

This is not a real problem.  Read below for more details.

> --
> 
> commit 1171ea4d01e310ec9987bf3cb2d19f8bf89b60cb
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: detect and use fresh enabled status
> 
> This commit changes the enabled parameter's get callback to report the
> actual running status of kdamond instead of the static enabled variable.
> It introduces damon_stat_enabled() to dynamically check if the context is
> running.
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
> > -	if (is_enabled = enabled)
> > +	if (damon_stat_enabled() = enabled)
> >  		return 0;
> 
> If kdamond stops unexpectedly (for example, due to an allocation failure in
> kdamond_fn), damon_is_running() and consequently damon_stat_enabled() will
> return false.
> 
> If a user then explicitly disables the module by writing 'N' to the enabled
> parameter, kstrtobool() will update the global enabled variable to false.
> 
> Could this cause the check above to evaluate to true (false = false) and
> return 0 early?

Yes, that can happen.

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
> >  	damon_stat_stop();
> 
> If the early return is taken, damon_stat_stop() is bypassed. Does this leak
> damon_stat_context since damon_destroy_ctx() won't be called?

That's not leaked because we still keep the pointer and free that when
damon_stat_start() is called next time.

> 
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260416143857.76146-1-sj@kernel.org?part=1


Thanks,
SJ

[...]
