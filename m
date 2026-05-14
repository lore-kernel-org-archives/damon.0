Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF543B6347
	for <damon@lists.linux.dev>; Thu, 14 May 2026 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734416; cv=none; b=SX5CGOPqUbfM4CUX7S9ZuGGjR/Kbjw3XT1Lqa6/+F3XLA4kzbEyLQnIMBAT+EIdZW7gUb7C+zaodjDWG30c0QH7EEY14UVpNC+Xp0WaNLHiUh1bGpKYUDF7WeiSPupvkZL6kH76cHEN5JuQR2dsLZxoq7Oi3xNA6zLMNbd8SpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734416; c=relaxed/simple;
	bh=KuvKJs5uR62XHCAKmkS5sWyDY8OS9huZabrDYGKC5+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3evbRRTMfmdLN9Gpt6AwuKMd7hw2Ogyvor43NGeJ1jUyLryDdiVvGVEFDRZqO+4f9Kv6ojbftIh3c2TYvQvep3K+bU05jQBvoqw4NHKlT7dwxV9IYoS0OQ8IQYrkk41SF8cidPxdQTg5lkXwHLs+kMxtcJXqZgzTLEyS/yHBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0Zwg0Cv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0Zwg0Cv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B11C2BCB7;
	Thu, 14 May 2026 04:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734416;
	bh=KuvKJs5uR62XHCAKmkS5sWyDY8OS9huZabrDYGKC5+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0Zwg0CvHjEtizpD+oZ1bl3vuyLFbhHN2XfHPovtIhH02IrywMwGmyXD1DDrOfHS6
	 QC76FwnqQFtLnv7/aPmtJrTpxAPDczSZNkz7F3JOSSHdjFqj49hkcKwVkCL0PzUT65
	 WjXuzDeC2DMYrCiI83FvZn1q9F+eKZT5sJpY8Ai6zkWiU2mLXRlLxXCHaVg8cAfnO4
	 pHJ/wqbNpLw+rNma1NOm8J48Prqf+dG9AdRq8yrvDobXF7RhsKitCqi391invIUnzd
	 U1WtFLVa+MzRKlUzuVfX+wbSqalRjBDhiJKUtJxFLOAF60IjHP71q6Dh7RE09bYlRd
	 aKkW0A3JcBuWw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.18.y 2/2] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 21:53:32 -0700
Message-ID: <20260514045332.95813-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514015620.BBD3FC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 01:56:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] NULL pointer dereference in damon_lru_sort_enabled_store if module initialization fails.
> --
> 
> commit 1c4b8a292830197d1c3c21bb2ed871fd37b99120
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
> 
> This patch updates DAMON_LRU_SORT to dynamically detect and use the fresh
> status for the enabled and kdamond_pid parameters when requested. This
> avoids stale parameter values if kdamond is stopped unintentionally.
> 
> Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 42b9a656f9ded..0c2274fefd763 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> 
> [ ... ]
> 
> > @@ -330,42 +316,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
> >  MODULE_PARM_DESC(addr_unit,
> >  	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)");
> >  
> > +static bool damon_lru_sort_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> > +}
> > +
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
> 
> Can this result in a NULL pointer dereference if the module initialization
> fails?
> 
> If damon_lru_sort_init() fails during boot (for instance, due to memory
> allocation failure), ctx remains NULL. Since CONFIG_DAMON_LRU_SORT
> parameters are registered as built-in module parameters, writing 'Y' to
> /sys/module/damon_lru_sort/parameters/enabled will invoke
> damon_lru_sort_enabled_store().
> 
> In this scenario:
> - damon_lru_sort_enabled() safely returns false (due to !ctx).
> - The damon_lru_sort_enabled() == enabled check is bypassed (false != true).
> - damon_initialized() returns true (since the DAMON core initialized).
> - damon_lru_sort_turn(true) is executed.
> 
> This leads to damon_lru_sort_apply_parameters() calling
> damon_commit_ctx(ctx, param_ctx), which unconditionally dereferences the
> NULL ctx, leading to a kernel panic.
> 
> Should there be an explicit if (!ctx) check in
> damon_lru_sort_enabled_store() to prevent this, similar to how it was
> added to the read paths?
> 
> While this vulnerability is not strictly introduced by this patch, the patch
> misses the opportunity to fix it while addressing ctx nullability in the
> read paths. The same vulnerability also appears to be present in sibling
> modules mm/damon/reclaim.c and mm/damon/stat.c.

Sashiko reported [1] same thing before, and I'm working on it.

[1] https://lore.kernel.org/all/20260419014800.877-1-sj@kernel.org/


Thanks,
SJ

[...]
