Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349148B382
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017454; cv=none; b=jZpo763GeTW9pPIYtKFjrJwkyDr3q3sKU2DAw9nuySBtQ7PQDzzwJ7NFYEDydvzWXZlBQupR0FjSrQsLwxZLivJArLDeFyxJQGTjdY8qqHqDYNOq346ILVVSEaezktvCUTw2dkxLuDVZH9adcNbG1kUXYIG/s8vQrY+QxZb1s08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017454; c=relaxed/simple;
	bh=HjCVzw7Q8l8RkE6zeXR2bJYUYrPC8QIyPmsAPfT8Ck8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/YnZrqfqa7eAGCt1KLkdvGCrC3KDHwPWrvPFEdpWmyULoVlUKR1POgJSLCDjTUIj4ulzBRQ92QAGYIgBZnb4ir/HuBW8gkeH0d8nuRDT/UW/0Tysf3uHlIPdhmZzupLTCAPw9Ij/iU+On1EROxM/ajse2Fv8xtqwi7yX3F8ACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIr3hHMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIr3hHMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1897B1F00893;
	Tue,  9 Jun 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017453;
	bh=vcCk9ICfkX2KjvdqQgVSrumyV/d2oORcNDoVBpH4YBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UIr3hHMpagTQACmDIHqwYjdiztlwFGOBk/hAEXnIba5OU4ynlLkXxIrNq6mhC0buc
	 JzRJlhex6XKI4TjmqcZILw0u84mNhW2WFY+IRMRmEbXIugrPo26Fk2e6kfubbcG210
	 XJOhgpS4XBGvwS7otkWocWOtem9IA6y3to4es9zE9j6kw+wl1ecIPRd4X9NxwoEGRb
	 1qq6Sscn+IJbobvCIUJQfvZdn1SsOed6q4ZV060umilU3jGjISMAeGQd5OYWvao6tY
	 4f5o5Venec5pWQQP7WFDsPdbN8otDRuYueH5yfflmb/oEQnu4GMWjqXF6QwskjAZ/X
	 PflAvhhfEMGSg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/2] samples/damon/mtier: handle damon_start() failure
Date: Tue,  9 Jun 2026 08:04:04 -0700
Message-ID: <20260609150404.70367-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609145814.70163-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 07:58:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 09 Jun 2026 14:35:38 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Resource leak (struct damon_ctx, struct damos, struct damon_target, and struct pid) on damon_start() failure.
> > --
> > 
> > commit e95eb25cfbc21e60927df5e7e4eadcf5468c1c41
> > Author: SeongJae Park <sj@kernel.org>
> > samples/damon/mtier: handle damon_start() failure
> > 
> > This commit fixes a resource leak in the memory tiering DAMON sample module
> > where failing to start the DAMON contexts leads to memory leaks and
> > indefinitely running contexts.
> > 
> > Link: https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org
> > 
> > > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > > --- a/samples/damon/mtier.c
> > > +++ b/samples/damon/mtier.c
> > 
> > [ ... ]
> > 
> > > @@ -185,7 +186,15 @@ static int damon_sample_mtier_start(void)
> > >  		return -ENOMEM;
> > >  	}
> > >  	ctxs[1] = ctx;
> > > -	return damon_start(ctxs, 2, true);
> > > +	err = damon_start(ctxs, 2, true);
> > > +	if (!err)
> > > +		return 0;
> > > +
> > > +	if (damon_is_running(ctxs[0]))
> > > +		damon_stop(ctxs, 1);
> > > +	damon_destroy_ctx(ctxs[0]);
> > > +	damon_destroy_ctx(ctxs[1]);
> > > +	return err;
> > >  }
> > 
> > [Severity: High]
> > This is a pre-existing issue, but it looks like the exact same resource leak
> > pattern exists in other DAMON sample modules when damon_start() fails.
> > 
> > Looking at damon_sample_prcl_start() in samples/damon/prcl.c:
> > 
> > 	err = damon_start(&ctx, 1, true);
> > 	if (err)
> > 		return err;
> > 
> > And similarly in damon_sample_wsse_start() in samples/damon/wsse.c:
> > 
> > 	err = damon_start(&ctx, 1, true);
> > 	if (err)
> > 		return err;
> > 
> > Since they return directly without calling damon_destroy_ctx() or putting
> > the target_pidp reference, do these modules also leak their newly allocated
> > contexts and PID references when damon_start() fails?
> 
> Nice finding.  Not a blocker of this patch, though.  I will separately work on
> this.

Hmm, but...  They do destroy the ctx in damon_sample_{wsse,prcl}_stop().  And
users cannot trigger damon_sample_{wsse,prcl}_start() without calling the stop
function first, due to the current 'enabled' value based skippinng in
damon_sample_wsse_enable_store().  So, this seems not a true issue.  Let me
know if I'm missing something.


Thanks,
SJ

[...]
