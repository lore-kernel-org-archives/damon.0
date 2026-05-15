Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A31EEA3C
	for <damon@lists.linux.dev>; Fri, 15 May 2026 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885902; cv=none; b=b4hGI5poufFdmktwfn+SuEGJdL6+yF/6eqRB+qDqPAZz6CrF4bADmCFPRRnpJ6Ejrvh0owmCsLIb89tqwGPqGu7mLq9UBAHThz60S3NN9ePXbh6D7d/puDEA77RB1npxl/4pjEt7Azt/uE4pHRu5eGwp5OASo0KZ5qV69a5drU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885902; c=relaxed/simple;
	bh=lMqYta+OaeR3A5leh8GM2Wfj7gHBUqFgRKwmP36haRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iv9Fw6z9krsly1VqTqFLfd5S0hFvqpmOQRImi2fk8jRC3Xyr0kLLKEIinSGHLE9hFrHz9uNlghd18vxC9lVSrz0CubWOs6kXRV3Wl32oREjUuIlM65iYmrKwzXqhxq2kMSW62ZlegMqX6/l67qGqgkNjPirLNzGGuVfOhUtyAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hubvDC+d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hubvDC+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FEAC2BCB0;
	Fri, 15 May 2026 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778885902;
	bh=lMqYta+OaeR3A5leh8GM2Wfj7gHBUqFgRKwmP36haRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hubvDC+d3LoXQzkf4Kl95sAC29dqVGccCmCyTJU7EOaVVC0T8D9rWOJlol/hp0PUL
	 3ngS4LFxVFO2EIXC1uTY2/8JMbf9fmYvRi3JWgrV9+w0WjNKSgnJgWmIMazdZA5rEI
	 ZzeT2I7poIGPePuNGI3Z6GKD6tz/gh1EkIt+nP/5huRLYu62O/yb6LW/Vt0VpwKQN3
	 Orideku1WAiQmAru/BYyqOnlPaaoh7JzdsQ/6SR9Fky6/nD5w1Oz5H6Mj+jY6Dygxw
	 BIEVvreI/Z0C8TnL86Daio0INveoXDNb3P230SeWxPE/Xz3LLJc8zKprFArJO4Gplb
	 UNo947w+WaKYA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 02/28] mm/damon/core: embed damon_probe objects in damon_ctx
Date: Fri, 15 May 2026 15:58:20 -0700
Message-ID: <20260515225820.54774-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515011707.C424EC2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:17:07 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing parentheses around the `ctx` macro argument in `damon_for_each_probe` and `damon_for_each_probe_safe`.
> --
> 
> commit e24428c998724cd2c79829fc347f7cc9804f966b
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: embed damon_probe objects in damon_ctx
> 
> This commit adds a linked list of damon_probe objects to damon_ctx. It also
> introduces initialization, cleanup, and helper macros to iterate over the new
> list.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index a8fff5325b010..3ba5a31b51769 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -879,6 +880,11 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
> >  	return r->ar.end - r->ar.start;
> >  }
> >  
> > +#define damon_for_each_probe(p, ctx) \
> > +	list_for_each_entry(p, &ctx->probes, list)
> > +
> > +#define damon_for_each_probe_safe(p, next, ctx) \
> > +	list_for_each_entry_safe(p, next, &ctx->probes, list)
> 
> Should the ctx macro argument be wrapped in parentheses here?
> 
> Due to C operator precedence, if a caller passes an expression requiring a
> cast like (struct damon_ctx *)ptr, the macro would expand to:
> 
>     &(struct damon_ctx *)ptr->probes
> 
> Because the member access operator -> binds tighter than the cast, this
> evaluates as &(struct damon_ctx *)(ptr->probes). This can lead to
> unexpected compilation errors or incorrect pointer arithmetic.
> 
> Wrapping it as &(ctx)->probes would safely isolate the argument and match
> the pattern used by the existing damon_for_each_scheme macro in this file.

Nice suggestion, I will do so.


Thanks,
SJ

[...]
