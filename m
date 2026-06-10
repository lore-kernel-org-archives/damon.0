Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8C1C8604
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063452; cv=none; b=pN8ClS1VMTfou4RDLonw03ZoenTbZ7Fq01JQlD0lf0ThnB6UHZkFU03qwHn6dBGzV8wDDsH4hRJfiWCboaDYyYd3EfGlQar8dymD5ANnyGFkvlrOcaHV164IVP9PI62/yrBZYh15QAO9EvzEudLNI8WrzAO3ek6FlYRLQaH7cPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063452; c=relaxed/simple;
	bh=Qb9grHSTXKxZRN6VKU1V9jhC9Nk/wgPN2rwd9isGsz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlsNAVGkPuHINZ2jO6nej2ImOAVTlCEFtm3R2GTkhjIFZHPSLSw7GgNPwIJezpbPAjmADkWzBAVYGIlFck9AF8e9r8PcEjJyQAlvxZvoH+eOcmayROmhEhArZrvn93pZBEwvng4kjXlPeVmsOj0y1cIJ8tRWBgOVoG5RL7Y/NjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbC67+30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbC67+30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE691F00893;
	Wed, 10 Jun 2026 03:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781063451;
	bh=KW5igoZzRt9sFjD2VmB0Zt71Plp1c8CEW1PFJ5RuM2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HbC67+303xewgWQgfNLTqSOJotS8/FTpUOKq1Z82pZ3p0HumSivGPkJei834MNc34
	 yFz2pNI1fpK50QCKK9WT6hRQQpMG3EDLnh13NILJZpzJLv3HhG9NHwVBTqfPLgTsHZ
	 Ycl/dh2wd7TNMwfKmdArKjFtiximuSvQxgst1QLnC+dy8j2r6ybJzSY9BABtvfGsLE
	 ERiq9X2/t4sJhDgGObkfSOa4Ae/y1DJFHU6zvXXPWOrQ9Vfp4Zr5VaHQtBvEORTblD
	 mjiXG6XPmgzjJr6FvTAFuCFHrFkD79EJAOka8MAC/elmDV057KeTBWscRZ2uc+IY4C
	 7H5RBJt535Z8Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 1/4] samples/damon/wsse: handle damon_start() failure
Date: Tue,  9 Jun 2026 20:48:26 -0700
Message-ID: <20260610034828.4632-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610012912.C3E801F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jun 2026 01:29:12 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unhandled failure of `damon_call()` leads to a permanent memory leak of the DAMON context.
> - [High] Concurrent execution of `module_init` and sysfs store causes Use-After-Free and Double Free on the global `ctx`.
> --
> 
> commit 6215f97f729272927aafd065cdad15da2af100a8
> Author: SeongJae Park <sj@kernel.org>
> 
> samples/damon/wsse: handle damon_start() failure
> 
> This commit fixes a memory leak in damon_sample_wsse_start() by explicitly
> freeing the DAMON context if damon_start() fails.
> 
> Link: https://lore.kernel.org/20260609145814.70163-1-sj@kernel.org
> 
> > diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
> > index 799ad44439434..bbd9392ab5b36 100644
> > --- a/samples/damon/wsse.c
> > +++ b/samples/damon/wsse.c
> > @@ -87,8 +87,10 @@ static int damon_sample_wsse_start(void)
> >  	target->pid = target_pidp;
> >  
> >  	err = damon_start(&ctx, 1, true);
> > -	if (err)
> > +	if (err) {
> > +		damon_destroy_ctx(ctx);
> >  		return err;
> > +	}
> 
> [Severity: High]
> This is a pre-existing issue, but does this new error path leave the global
> ctx pointer dangling?
> 
> If the module is loaded with enabled=1, damon_sample_wsse_init() calls
> damon_sample_wsse_start(). Concurrently, user space can write 0 to the
> enabled sysfs parameter, which triggers damon_sample_wsse_stop().
> 
> If damon_start() encounters an error, this new path calls
> damon_destroy_ctx(ctx) but ctx is not set to NULL. A concurrent
> damon_sample_wsse_stop() would see ctx != NULL and call
> damon_destroy_ctx(ctx) again, leading to a double free.
> 
> Similarly, if damon_sample_wsse_stop() executes while
> damon_sample_wsse_start() is running, stop() could call
> damon_destroy_ctx(ctx) while start() is actively using it, causing a
> use-after-free.

damon_sample_wsse cannot be dynamically loaded, so this issue cannot happen.

> 
> >  	repeat_call_control.data = ctx;
> >  	return damon_call(ctx, &repeat_call_control);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does this return path leak the newly
> created ctx if damon_call() fails?
> 
> If damon_call() returns an error (for example, -ECANCELED if the kdamond
> thread exits immediately and sets ctx->call_controls_obsolete to true), the
> error is returned directly to the caller.
> 
> Because the kdamond thread does not free the context itself when exiting,
> is damon_destroy_ctx(ctx) also needed here to prevent leaking the DAMON
> context and its associated objects?

Good finding.  I will fix this with another patch.


Thanks,
SJ

[...]
