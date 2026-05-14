Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F713542D1
	for <damon@lists.linux.dev>; Thu, 14 May 2026 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736926; cv=none; b=dvj5RB7EbDUUIXv8kJ8QM61HdUBImvhpXrpF6Jzb7EJItqAXj2xlfZdnffRjiyW0w5AK/vWKXviRVsJAa6iw7YDg3P84lCyb6QjhYfchE5RkWMPWPlcRT350v3R5Kk0LhOJruLmHezQ+ShzgpH36P3/5rDK6X04+UsIu8sz8BRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736926; c=relaxed/simple;
	bh=e+KOJTfV2LJ6qGg2XoYHtzRS9ABKT7sG1DhFFKi3F9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSNydzAQtIzPydicwJvmM1Smxo1iXP/jwhtviW8bMWQjE5cAf1AzSIE1PC709fwhJ2s4MBYwXZV6PM3O699qeDQg5jmSBh+sBpD1EpSXzM86PF5lp3F7WGaJ1czfmyaRAxnp11osgyNOltjZGJMDPL2tv6J9cnI/vRNQvckpKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJQ+aQfA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJQ+aQfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD4C2BCB7;
	Thu, 14 May 2026 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736925;
	bh=e+KOJTfV2LJ6qGg2XoYHtzRS9ABKT7sG1DhFFKi3F9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJQ+aQfA44yb5vKmwx6GaTaIyErZQMEs1vL1GDu2Snc+vReEa1DT9NCtYWjLw1pmX
	 TvQVHtSticyrc2HORZuZqpQanq3pVsyrjcloT2A+WgnhNGwEh1Ysu8B2Nah7vpnlp/
	 mILpTOer9vAxv/+wEEbqMDP9FynkQIXWpHEeQ3uzNBA1wPN0KMz+iB/QfnPGYt36TV
	 uujwcUG/l2c4M2quxH6RCsgc80wqbGjanpZo8wTIBqkdnaPYHKTk8rmzL+wiWSPqm2
	 HzMRq3SgWYe4Zxdgata5OVpgbU8bv0HH0Aaxc431guU53fs/TcBjOa+XSAS8/kETBI
	 +6SO23JuMmVUQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.18.y] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:35:15 -0700
Message-ID: <20260514053517.112149-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514020242.5CD8FC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 02:02:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Writing to the `enabled` sysfs parameter triggers a NULL pointer dereference if the module's initialization failed.
> - [Low] The commit introduces a call to an undefined function `damon_kdamond_pid()`, causing a build failure.
> --
> 
> commit 45d783d4b3fd23532d7c6b975b70fda3e5324f1b
> Author: SeongJae Park <sj@kernel.org>
> mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
> 
> This commit modifies the DAMON reclaim module to dynamically detect and use
> the fresh running status of kdamond when parameters are requested. This
> prevents stale cached statuses from being shown to users when kdamond stops
> unexpectedly.
> 
> Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
> Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 7ba3d0f9a19ac..9446e7a1b476f 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> 
> [ ... ]
> 
> > @@ -334,42 +320,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
> >  MODULE_PARM_DESC(addr_unit,
> >  	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)");
> >  
> > +static bool damon_reclaim_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> > +}
> > +
> >  static int damon_reclaim_enabled_store(const char *val,
> >  		const struct kernel_param *kp)
> >  {
> > -	bool is_enabled = enabled;
> > -	bool enable;
> >  	int err;
> >  
> > -	err = kstrtobool(val, &enable);
> > +	err = kstrtobool(val, &enabled);
> >  	if (err)
> >  		return err;
> >  
> > -	if (is_enabled == enable)
> > +	if (damon_reclaim_enabled() == enabled)
> >  		return 0;
> >  
> >  	/* Called before init function.  The function will handle this. */
> >  	if (!damon_initialized())
> > -		goto set_param_out;
> > +		return 0;
> >  
> > -	err = damon_reclaim_turn(enable);
> > -	if (err)
> > -		return err;
> > +	return damon_reclaim_turn(enabled);
> > +}
> 
> If module initialization fails during boot, for example due to an allocation
> failure in damon_modules_new_paddr_ctx_target(), the global ctx pointer will
> remain NULL. Because damon_reclaim is built-in, its sysfs parameters are
> still exposed.
> 
> If a user subsequently writes to the enabled parameter,
> damon_reclaim_enabled_store() will see that damon_initialized() is true
> because the global cache is initialized, and it will call
> damon_reclaim_turn().
> 
> This unconditionally passes the NULL ctx pointer to either damon_stop() or
> damon_reclaim_apply_parameters(), which eventually calls damon_commit_ctx().
> 
> Could this cause a NULL pointer dereference when accessing the uninitialized
> ctx pointer?

Sashiko reported [1] same thing before, and I'm working on it.

> 
> [ ... ]
> 
> > +static int damon_reclaim_kdamond_pid_load(char *buffer,
> > +		const struct kernel_param *kp)
> > +{
> > +	int kdamond_pid = -1;
> > +
> > +	if (ctx) {
> > +		kdamond_pid = damon_kdamond_pid(ctx);
> 
> Is the function damon_kdamond_pid() defined anywhere in the tree?
> 
> It appears this function is called here but might be missing, which would
> cause an implicit declaration and linker error. Could a prerequisite patch be
> missing from this cherry-pick?

I informed this issue and where the dependent patch can be found, on the
commentary area of the patch.

[1] https://lore.kernel.org/all/20260419014800.877-1-sj@kernel.org/


Thanks,
SJ

> 
> > +		if (kdamond_pid < 0)
> > +			kdamond_pid = -1;
> > +	}
> > +	return sprintf(buffer, "%d\n", kdamond_pid);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260513043902.183499-1-sj@kernel.org?part=1
