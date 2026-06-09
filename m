Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CB48097F
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017613; cv=none; b=E4dRvXytwgrioNgq5nfdZSVoXrzly7nKMPy+946MEKGGtoo23Fxe8PvIue2v5YJbS/kwyI8OBA2adpXR11vw2uxGsqbVn2g5sn57Oe+1iEiMQjEPwd2gDaOEg+rkLe+YhBKGg1uuAwkvTJPR6DTWAyInOHGZtVG3fBLqXNTHDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017613; c=relaxed/simple;
	bh=YJrtMwGsqvXjttDm9v7Wre8jcXL7InUHJyI8SyZr/uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZqb3BvuJa5ujTszglGtmmHpLYNUgCHAZvZCWxvJkr6ygPnqdpAOWhr8bRd2i9lxLt90mu35d8+v/EodJBCESnZhv5YOFprA34jv0HcYkZaX9uPRM5cA81TNhGGmKrj8q8i0Igu90WL3f8ZvQeS5OSrNUpPZ7IGPhxt7kRSm5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVreKo2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVreKo2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB491F00893;
	Tue,  9 Jun 2026 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017611;
	bh=doTy91Hq1NFxNsr3XzKmqz7lBQqKxDEWUEuDliOXRQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZVreKo2zoBw+8A8Y/ME/GFw2CNHiZSPquN8I5NxxFSUX2psThjn7uzo0AIljSuPig
	 7I53upVobMoaQp4HplSlgC//QZvry0aCybDiB7Q/SsuA1oNpPL0L0zIPcOp61YySO5
	 4OGL7ScShjlnkNTYYMKq2JBGsT08gIFfM+AlIDKaaz4KH9U0e3bkGBKCSwnTKZhRLu
	 +xgmcPjT0xbJddj5FTqt0htlWnBxMRtTDnWU8QZN2WGCFpUuyAED0mF078EqpAkmZu
	 owcIqx45s/+GUwUS4ltvpVyXUNjBS8znU3ZIwSmBqKX9B17PdI05G7E1mEeiXILJnc
	 UERYuN2ld7Usw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/2] samples/damon/mtier: handle damon_start() failure
Date: Tue,  9 Jun 2026 08:06:44 -0700
Message-ID: <20260609150644.70505-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609150404.70367-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 08:04:13 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 09 Jun 2026 07:58:22 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Tue, 09 Jun 2026 14:35:38 +0000 sashiko-bot@kernel.org wrote:
> > 
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > 
> > > Pre-existing issues:
> > > - [High] Resource leak (struct damon_ctx, struct damos, struct damon_target, and struct pid) on damon_start() failure.
> > > --
> > > 
> > > commit e95eb25cfbc21e60927df5e7e4eadcf5468c1c41
> > > Author: SeongJae Park <sj@kernel.org>
> > > samples/damon/mtier: handle damon_start() failure
> > > 
> > > This commit fixes a resource leak in the memory tiering DAMON sample module
> > > where failing to start the DAMON contexts leads to memory leaks and
> > > indefinitely running contexts.
> > > 
> > > Link: https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org
> > > 
> > > > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > > > --- a/samples/damon/mtier.c
> > > > +++ b/samples/damon/mtier.c
> > > 
> > > [ ... ]
> > > 
> > > > @@ -185,7 +186,15 @@ static int damon_sample_mtier_start(void)
> > > >  		return -ENOMEM;
> > > >  	}
> > > >  	ctxs[1] = ctx;
> > > > -	return damon_start(ctxs, 2, true);
> > > > +	err = damon_start(ctxs, 2, true);
> > > > +	if (!err)
> > > > +		return 0;
> > > > +
> > > > +	if (damon_is_running(ctxs[0]))
> > > > +		damon_stop(ctxs, 1);
> > > > +	damon_destroy_ctx(ctxs[0]);
> > > > +	damon_destroy_ctx(ctxs[1]);
> > > > +	return err;
> > > >  }
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but it looks like the exact same resource leak
> > > pattern exists in other DAMON sample modules when damon_start() fails.
> > > 
> > > Looking at damon_sample_prcl_start() in samples/damon/prcl.c:
> > > 
> > > 	err = damon_start(&ctx, 1, true);
> > > 	if (err)
> > > 		return err;
> > > 
> > > And similarly in damon_sample_wsse_start() in samples/damon/wsse.c:
> > > 
> > > 	err = damon_start(&ctx, 1, true);
> > > 	if (err)
> > > 		return err;
> > > 
> > > Since they return directly without calling damon_destroy_ctx() or putting
> > > the target_pidp reference, do these modules also leak their newly allocated
> > > contexts and PID references when damon_start() fails?
> > 
> > Nice finding.  Not a blocker of this patch, though.  I will separately work on
> > this.
> 
> Hmm, but...  They do destroy the ctx in damon_sample_{wsse,prcl}_stop().  And
> users cannot trigger damon_sample_{wsse,prcl}_start() without calling the stop
> function first, due to the current 'enabled' value based skippinng in
> damon_sample_wsse_enable_store().  So, this seems not a true issue.  Let me
> know if I'm missing something.

Ok, I was missing this.  damon_sample_wsse_enable_store() reset 'enabled' when
damon_sample_wsse_start() fails.  Same pattern for prcl and mtier.  So seems
the issue is real.  I will separately work on this.


Thanks,
SJ

[...]
