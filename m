Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63776E56A;
	Thu,  2 Apr 2026 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095667; cv=none; b=oO/45qza2VD23NwI+HCO/Pr4W4zZBluntRtW1CpoqT2tXsJ7VpxhNR5+3iXWNKiJ8Qqy6wb2umYRj4vGcoN9YQA4u0cn+6odn7dh6r1yYJSMcdhJnedAQAboj6GaGRY8+Sz3pvU/Fxuh1LoIkt/kLLcY4s+mmmM6R0dm+assmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095667; c=relaxed/simple;
	bh=7fWpk4Gb6mbBCpnHLamijCOUzylF/piEazB2Sm2XryY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMr7c8Kvfocxs5PLk57EoLiiBCfjzehf4yYvUFVSQ1fXLqSi+1zbt681DHndoSHUrKIycW/+hWLwJc/ZJbv+SapgWNu/LLaytNUWYlHnBBUV3LoMuLLwS+8DjuRwt2Gi60Y7XhFviWRBm9r8GWvODI9hJ3u2ESbXHIBzpQzL4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSbYePcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSbYePcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AE1C4CEF7;
	Thu,  2 Apr 2026 02:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095667;
	bh=7fWpk4Gb6mbBCpnHLamijCOUzylF/piEazB2Sm2XryY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSbYePcUY+Qt+QuSS5KrYUfKigRw7zQGPLR7J2Kldh27J8+A0Vn/ST2v3YvTJ5Pio
	 JTB96YQ3t4ES/UK//c5Kic324Idu+t5CygT3Yh4FEnsmXWxg8YWPDygSfaIlwjnMJR
	 Rb5+pE96AgpXfmFgxVkYFb6UCK+G9bPZyTIe5+uJJKmfDKjmq3bxLFgw1sQAtv6GO/
	 oB921pAGMCysuTxzf0t8dQF01o+vrwHpJCBIbr1DCY6qDc6aE7XfMyam0buLcHxqZw
	 3RP4hEqME3uL89XZRxeFIPPPC0j2vpBA+DWcquCfRgD8iNvSnxOT4C1QMaUkZNT2ae
	 cGM/PimH3Sh5g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Wed,  1 Apr 2026 19:07:44 -0700
Message-ID: <20260402020745.68554-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402010457.66860-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew, please drop this patch.  sashiko found an issue, so I will respin.

More details below.

Forwarding Sashiko review in the usual reply format with my inline comments,
for doing discussions via mails.

> # review url: https://sashiko.dev/#/patchset/20260402010457.66860-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit 1d53bb9291d3fde393f37b143e637f0d25b6634e
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
> 
> This commit addresses a memory leak by deallocating damon_stat_context if
> damon_call() fails during stat startup.
> 
> Link: https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -257,7 +257,12 @@ static int damon_stat_start(void)
> >  
> >  	damon_stat_last_refresh_jiffies = jiffies;
> >  	call_control.data = damon_stat_context;
> > -	return damon_call(damon_stat_context, &call_control);
> > +	err = damon_call(damon_stat_context, &call_control);
> > +	if (err) {
> > +		damon_destroy_ctx(damon_stat_context);
> 
> Can this cause a use-after-free?
> 
> Earlier in damon_stat_start(), damon_start() is called, which creates
> and starts the kdamond_fn kernel thread. This thread actively uses the
> damon_stat_context.
> 
> If damon_call() fails, the kdamond_fn thread might still be running or
> in its teardown phase. If we free the context directly using
> damon_destroy_ctx() before the kthread has fully exited, the kthread
> might access freed memory.

Nice catch.

FYI, I initially thought damon_call() of DAMON_STAT cannot fail, because it
synchronizes its damon_start()/damon_stop() calls with module parameter
handling function, and it doesn't update the context internal state, which
means the damon_ctx->maybe_corrupted cannot be set.  If that's true, this patch
itself is not needed since the memory leak cannot exist.

But, kdamond can fail for its internal memory allocation failures.
Specifically, if ctx->region_score_histogram allocation is failed, it will be
terminated.  So, yes, sashiko is right.  There is a chance.

> 
> Should we call damon_stop() here to wait for the thread to safely exit
> before destroying the context, similar to the teardown sequence in
> damon_stat_stop()?

Seems that is a workable option.  But given the fact that kdamond is already in
its termination step, it feels odd to me.  I'll take more time to think about.

> 
> > +		damon_stat_context = NULL;
> > +	}
> > +	return err;
> >  }
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260402010457.66860-1-sj@kernel.org


Thanks,
SJ

[...]
