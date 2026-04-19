Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7251A9F9B
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622383; cv=none; b=Jzez7QOyo/gLymlI8UJpyIQLReBqH2qjIX8+Y/V8J6OtD0eYFwmezxextgrHa71UY2nR082/qQYpepDCSBtpKQYYKd7qroMJwgm4G91V3BCnU+F5fLenPyQLMIeDKGPPWJza44luJOO/OzklS48UoRvIOpbYKHTKre68FBQYIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622383; c=relaxed/simple;
	bh=CLhcEkfTw8OjvNsorXM4Z9a9r3GZ5Cvfkh6/tQhIlJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw+7P87Rc8eI67QC2bMxJRIEHsaAN0PCw7LSQpBfSTOY5FEwx/FCis3RsPsg8Ng1UdY3krsT35ThyPesNL1EiTpNrk6PWzUne+HplaimludcJIgxt735MgF7L7FLBlC01PJfB8qlkyxGE4wqpSxfvZw64XimaQgw8HQrCVmTLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyb4+7tn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyb4+7tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A4EC2BCAF;
	Sun, 19 Apr 2026 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776622383;
	bh=CLhcEkfTw8OjvNsorXM4Z9a9r3GZ5Cvfkh6/tQhIlJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyb4+7tnjPjsV2ZW1p6YltqlU/NjSN+VYp3U656hVPefPzUm+qMScU19QeEuKl8fk
	 h5OqK8YLwDx32cBClIZThTQsbWbF+EdEnjZ+c1Q5Z+RscB34BBl9egRrkdYq1aYXIw
	 CahxhMyg1zekgrQv1RVwpzyKIVEWLVZq3frI/XVVPZZ2vNOlklUk7Ogzvft/BjjDvM
	 YYpiPijPcLw6QEVOgykmJ3URUupXgh3HBTAPq17cl5TuJwSdtoBdE1ksqB3RkQbVm1
	 LZqnsdSlXvYhE+i8W/MaTwnnhlg7fgGsiRxYm+Qsu5nHcQdCb36ofiLp48zV5n86Fw
	 94sZGRGdhjUpA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/3] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Sun, 19 Apr 2026 11:12:50 -0700
Message-ID: <20260419181250.11013-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419172817.E2FA2C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 19 Apr 2026 17:28:17 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] Loading the module with the `enabled=Y` parameter causes a NULL pointer dereference.

This is invalid.  Please read below for more details.

> --
> 
> commit e25c111d55f5d7c99165dbc8b59a5261d640ada5
> Author: SeongJae Park <sj@kernel.org>
> mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
> 
> This commit updates DAMON_LRU_SORT to dynamically detect and use the
> current running status of the kdamond thread for the enabled and
> kdamond_pid parameters. This prevents users from seeing stale values or
> being unable to restart kdamond if it stops due to unintentional events.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d729760..8494040b1ee48 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> 
> [ ... ]
> 
> >  static int damon_lru_sort_enabled_store(const char *val,
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
> > +	if (damon_lru_sort_enabled() == enabled)
> >  		return 0;
> >  
> >  	/* Called before init function.  The function will handle this. */
> >  	if (!damon_initialized())
> > -		goto set_param_out;
> > +		return 0;
> >  
> > -	err = damon_lru_sort_turn(enable);
> > -	if (err)
> > -		return err;
> > +	return damon_lru_sort_turn(enabled);
> > +}
> 
> This isn't a bug introduced by this patch, but does this code cause a NULL
> pointer dereference if the module is dynamically loaded with enabled=Y?

DAMON_LRU_SORT is builtin module.  It cannot be dynmically loaded.

> 
> When the module is loaded as a dynamically loadable module with the
> enabled=Y parameter, the kernel's module loader parses the parameters
> before damon_lru_sort_init() runs.
> 
> This invokes damon_lru_sort_enabled_store(). Because damon_core (a module
> dependency) is already loaded, damon_initialized() evaluates to true,
> bypassing the safety guard.
> 
> The function proceeds to call damon_lru_sort_turn(true), which eventually
> calls damon_lru_sort_apply_parameters(). This invokes:
> 
>     damon_commit_ctx(ctx, param_ctx);
> 
> At this point, the global ctx pointer is still NULL because it is only
> allocated later in damon_lru_sort_init(). damon_commit_ctx() unconditionally
> dereferences the pointer:
> 
>     dst->maybe_corrupted = true;
> 
> causing a direct NULL pointer dereference and a kernel panic.

Because DAMON_LRU_SORT cannot be dynamically loaded, the scenario cannot
happen.

Nonetheless, a similar issue can happen when the init function fails, which is
unlikely, but theoretically possible.  But that's not caused by this patch, so
no blocker of this patch.  I'm separately working on it.


Thanks,
SJ

[...]
