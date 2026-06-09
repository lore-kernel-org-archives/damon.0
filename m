Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91033EFFCD
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017105; cv=none; b=tPgev8RHPTAApkkwYZjqa4TlPCTDyq8Rw7jlS1pFINk1BX27UGlUutPKN7P6wbF0b65O/lMAgayIdYgrARnXSuWGFXPEipvNpq+aHBap0gSr/3wb0vIfw4FYyQzZ2GZqZPJZ4QxRA3+ft2MlNmKMa4rBNdpLOI7Lb37v/THn59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017105; c=relaxed/simple;
	bh=TFVEHHD8yZaonm1ckyX0+SrZFplauvzspybDhG4BB2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGT83SnIc45Y70+e6Mh8PhTTJgFuhiUoXDD9uufooVhj/A1EaeUgrS4XWdWVWVUIWIrlfAF0+i58PwU1JjM0jYn30G8wScfYXNA1VR+BdE7kYu6DNE4ezAt/x8qNAL3m7HY6PoOSz3U5/RN3az1wf9I+Y6vc1Y+SehUZF5/rNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmwENx5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmwENx5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A21F00893;
	Tue,  9 Jun 2026 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017102;
	bh=WsHOxxedaMnU1A/5SKsmxkq2vIyb1+Iq7ruUDj73bts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OmwENx5ssl103XWojeHd7yWhu+IdKAs9dopyQR9dE9x1opMrJ8uh3Dz+l6pOTD3Wu
	 yTUCaoc3JH38bnlpL0njZbbZBAL/gGyRNwrmYbKQZTfEjczF9cnbaBe8X1GFLn1v0f
	 LnNeR0RY4fw5upo0+inziXuOY8d/o5M5PtX79PmdHHi4O4FGVpOgM74tREeKxvSFTI
	 oSk6SObSe57nQUWX709N+4npBPA6l9lBO7EA2sB5D4c2As70wYVCXSOh26JD0SF5kV
	 qlvzfKM8qcoePq+uRnuzbWNxGyVn42iTJV/Pe+TYtFrZGt4zkO438Xpi2+f57NojKI
	 +k83BV9gTtRSg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/2] samples/damon/mtier: handle damon_start() failure
Date: Tue,  9 Jun 2026 07:58:13 -0700
Message-ID: <20260609145814.70163-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609143539.9E6BF1F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 14:35:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Resource leak (struct damon_ctx, struct damos, struct damon_target, and struct pid) on damon_start() failure.
> --
> 
> commit e95eb25cfbc21e60927df5e7e4eadcf5468c1c41
> Author: SeongJae Park <sj@kernel.org>
> samples/damon/mtier: handle damon_start() failure
> 
> This commit fixes a resource leak in the memory tiering DAMON sample module
> where failing to start the DAMON contexts leads to memory leaks and
> indefinitely running contexts.
> 
> Link: https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> 
> [ ... ]
> 
> > @@ -185,7 +186,15 @@ static int damon_sample_mtier_start(void)
> >  		return -ENOMEM;
> >  	}
> >  	ctxs[1] = ctx;
> > -	return damon_start(ctxs, 2, true);
> > +	err = damon_start(ctxs, 2, true);
> > +	if (!err)
> > +		return 0;
> > +
> > +	if (damon_is_running(ctxs[0]))
> > +		damon_stop(ctxs, 1);
> > +	damon_destroy_ctx(ctxs[0]);
> > +	damon_destroy_ctx(ctxs[1]);
> > +	return err;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but it looks like the exact same resource leak
> pattern exists in other DAMON sample modules when damon_start() fails.
> 
> Looking at damon_sample_prcl_start() in samples/damon/prcl.c:
> 
> 	err = damon_start(&ctx, 1, true);
> 	if (err)
> 		return err;
> 
> And similarly in damon_sample_wsse_start() in samples/damon/wsse.c:
> 
> 	err = damon_start(&ctx, 1, true);
> 	if (err)
> 		return err;
> 
> Since they return directly without calling damon_destroy_ctx() or putting
> the target_pidp reference, do these modules also leak their newly allocated
> contexts and PID references when damon_start() fails?

Nice finding.  Not a blocker of this patch, though.  I will separately work on
this.


Thanks,
SJ

[...]
