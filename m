Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5C34214A
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594224; cv=none; b=HNN88jni+4C8sILL/Mg58LqiejMAq8ZxWS0TyuDk2h4TyoxAtUJRa2X6q8iW6GLI6tJjXtUt8ZWeqJpjsVw3iNahmfOMvmihOYASXGiHtKhNT4Q86PeprAwTu3kPrmpbzpNaqhKyDRT/C/JIwgWhcxDEdHaEB1hfVJOFA8FP/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594224; c=relaxed/simple;
	bh=mwxDZNjCIUyAWJarUaUJ1iUefQRtMkUouuSmzv7JAZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFcp+6+Yq4IkKI2K9G2iwG3UNB2miEOZwTA1/CtGyF2bFLEi/6zJlyUaKcX9fs1e5YlZ0oR3VrdnWkeaSN+9UuSkDUKpQRDb87oCQj3V8F+9vCEN6Dd5WAGja3XE08KHWtoTp8702ApkyDd5oJyjC2KcJFagI8SCVJh7YyvE6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ2wffq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ2wffq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F901F000E9;
	Thu, 13 Aug 2026 04:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786594223;
	bh=f43LXvgjXxKWbVz4bTUjnEvLlTfvzA5z58WNQHWBASU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJ2wffq9lE0ViWi5HbCQyee/QsIFqGLp7kVtqOwohzxIEXnw3TmN05kvfwF2Y8FkR
	 aTNVHvK5Z1pO3mQa9XcN7h9nHa4zxxgQIOXwrmWWQO3LNnL88uYVhpO63v1vAbOcji
	 3LLr6JU8JeEret1ZCEz3R4YOYnKfi8Z3dPtQAyctX3oXFaPqjdJcg8by9IU3bRp4Ow
	 2sl5mqH6Cd2dfA3VFrIGoSjcG//71rIGPtb9uVBFEvhzS+E1p2bfrCkgVAjMPWHg1y
	 tpYlxa8e95NFXjfatbafr+fA9QJIMPJ27JsRaU1dmpdwM/ajnGKYG95ohjpjbDUTWi
	 FYzWCEhG2sz3g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/4] mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
Date: Wed, 12 Aug 2026 21:10:20 -0700
Message-ID: <20260813041021.98130-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813040208.A046E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 04:02:07 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch introduces an inconsistent state in the `damon_ctx` API by initializing `call_controls_obsolete` to true while leaving its identically-designed sibling field `walk_control_obsolete` as false.
> --
> 
> --- Patch [2]: [RFC PATCH 2/4] mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx() ---
> commit 94c12d6bfcca8f83b408960a36d0c0a8519d80c7
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()
> 
> This commit addresses an issue where passing an unstarted DAMON context
> to damon_call() can cause an indefinite hang. It fixes this by initializing
> ctx->call_controls_obsolete to true in damon_new_ctx().
> 
> Link: https://lore.kernel.org/20260803134646.16640-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index af7b77710745d..5080cb12220d2 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -864,6 +864,7 @@ struct damon_ctx *damon_new_ctx(void)
> >  	INIT_LIST_HEAD(&ctx->adaptive_targets);
> >  	INIT_LIST_HEAD(&ctx->schemes);
> >  
> > +	ctx->call_controls_obsolete = true;
> 
> [Severity: Medium]
> Should ctx->walk_control_obsolete also be initialized to true here?
> 
> Because walk_control_obsolete is zero-initialized to false during allocation,
> an unstarted context passed to damos_walk() will bypass the obsolete check:
> 
> mm/damon/core.c:damos_walk() {
> 	...
> 	if (ctx->walk_control_obsolete) {
> 		mutex_unlock(&ctx->walk_control_lock);
> 		return -ECANCELED;
> 	}
> 	...
> }
> 
> This appears to leave damos_walk() vulnerable to the exact same indefinite
> wait_for_completion() hang on unstarted contexts that this patch resolves for
> damon_call(). 
> 
> Does it make sense to update walk_control_obsolete alongside
> call_controls_obsolete to ensure the API behaves consistently?

The issue could happen in damon_call() because it has repeat mode.
damos_walk() doesn't have the repeat mode, so I don't think the initialization
is needed right now.  I will consider doing so in future, for consistency or a
case that it turns out the infinite hang is really possible.

> 
> >  	prandom_seed_state(&ctx->rnd_state, get_random_u64());
> >  
> >  	return ctx;
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260813035001.97364-1-sj@kernel.org?part=2


Thanks,
SJ
