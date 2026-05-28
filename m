Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F022D8DD0
	for <damon@lists.linux.dev>; Thu, 28 May 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976988; cv=none; b=DQLmF1MRKgrRXPntzKCEIY8EfK/2RpwZ5pIx0DDjX2yyh/wiHYu9DjIq3NN1mIzuS+xwXWuvccIRFRUSnIY2vsQ1i1SC0vqlRfwiLh1dT2Wl1pc9AHR9rNUkmqqrwvBqAhhXLMWkzlRRKBO6UY4qWv4Xt70ISr76x5dh6AzawAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976988; c=relaxed/simple;
	bh=PeHGadW8BOTnOZ5eW9Hwdkz8L8NECKnfkOG4ACEpSQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Shlyr+he5UR8Xxxgox0nJRPLbBs3dyUFt4r7zgN/AyAst+ogeXKgy2R2RVCJbeBVofHb4ehZG47qMFlzBe2HkBC5O2IG/Tjxtp10U0I6mjQX76BNeGOTq1QzQkyrx3RLNIAs6GRhxzBh+dJ32OlJwJ8pVLwH3aaFvtx+B1WlGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/2/XyrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/2/XyrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613E01F000E9;
	Thu, 28 May 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779976987;
	bh=0ede5RCyH74h2/QHpzLd4vPqL3n1Z1e1siLS4FXasVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/2/XyrSE0drrN7YC6Dn9KtKIOHk+YnuoTKiSNcDwXRGdL3AfwYH+HqLJdldSTz9h
	 OUZJ7USnOPPWnzsPJOiwL6x7ewHw2L5iZBWbQ3hQD+YqfYYYXDEsqe/1Xk6tZbPvHo
	 XQNtSRCKtuQ1ri7UO2JT0iDYDs+nJxuSzAMje9SgzqDgf2tDHk45i/c1vKlGDTgwei
	 iKEz4JpwkaKOEbmhrA4DkOKalWInZJYyPsVYW8uyhp1ocqlcz4JIPwIal7Q8HkQh7x
	 v5oBOTWeMdGJ8eBb/vaH9JqXjS1pcpskJKRIfJ+J+0ANNJuXAcphbHJZwYjyXRuGes
	 OVRzNupUGhaKQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mm/damonn/lru_sort: handle ctx allocation failure
Date: Thu, 28 May 2026 07:02:58 -0700
Message-ID: <20260528140259.153124-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528072956.650801F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 May 2026 07:29:55 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Module load parameter 'enabled' causes unconditional module load failure.
> 
> Pre-existing issues:
> - [High] TOCTOU race condition between sysfs store and module initialization leading to data corruption.
> --
> 
> commit 98350211104d3088f79c58844d29a85c013ac178
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damonn/lru_sort: handle ctx allocation failure
> 
> This commit attempts to fix a NULL pointer dereference in
> damon_lru_sort_enabled_store() by returning -ENOMEM if the damon_ctx object
> failed to allocate during initialization.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index eca88ed941b32..8298c6001fd09 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -476,6 +476,10 @@ static int damon_lru_sort_enabled_store(const char *val,
> >  	if (!damon_initialized())
> >  		return 0;
> >  
> > +	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> 
> [Severity: High]
> Will this cause an unconditional module load failure when passing the
> enabled parameter at load time?
> 
> When loading the module with modprobe damon_lru_sort enabled=Y, the kernel
> calls parse_args() before the module's init function damon_lru_sort_init()
> is executed.
> 
> At this point, damon_initialized() returns true because the damon_core
> dependency is already initialized, but ctx is still NULL since the module
> init function hasn't run yet.
> 
> Could this evaluate to true and return -ENOMEM, causing the entire module
> loading process to fail and abort?

DAMON_LRU_SORT is not a loadable but static module.  So this cannot happen.

> 
> >  	return damon_lru_sort_turn(enabled);
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is there a TOCTOU race
> condition here between the sysfs store and module initialization?
> 
> The kernel exposes module parameter sysfs files via mod_sysfs_setup()
> before executing the module's initcall do_init_module().
> 
> If a userspace process writes to this sysfs file concurrently while
> damon_lru_sort_init() is executing, could it trigger the following sequence?
> 
> Userspace sysfs write happens right after damon_lru_sort_init() allocates
> ctx. This callback sees ctx != NULL and calls damon_lru_sort_turn(true).
> 
> Concurrently, damon_lru_sort_init() continues, reads enabled == true
> (updated by the sysfs store), and also calls damon_lru_sort_turn(true).
> 
> Does this concurrent execution of damon_lru_sort_apply_parameters() and
> damon_commit_ctx() on the same ctx without locks lead to list corruption
> or double frees?

Again, DAMON_LRU_SORT is not loadable.  So, no.


Thanks,
SJ

[...]
