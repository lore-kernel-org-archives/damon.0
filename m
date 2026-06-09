Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949792FDC3C
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969350; cv=none; b=Jkl7YoJhN5HB31o3eK9iwIFqXXRwP4Te071Bw0gyioavBsepRy4Mon0JWhb66pVgTNyHqOptXnJmUUH6x3FikgbgbZ9HbcAv+OIc3hmsjqZFsAyZbuXXcDh+mJ85eUAvLE0ixljhe56WHmk1x4GB9zvXfu2Da3GqseUVnEFkdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969350; c=relaxed/simple;
	bh=qGQRJ+KQsBJH8ofhjePHvp9QMHtuZ2JBPOhsd9EAJJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfnJdRNw5sS5Oj5xOenl5B6tbgVWakVor3CIAwiSzMsWgckcxj42QxmhT7DP3qcHdZzZsyFCVLTv89oK/pz90XH+kx0021RzqFzWqrnsFEPLHi8SFxjHWMHDp/No03t7hZM2OM14C76nlrVbAjymu2YTqOEEv7EBfK54hp2Vc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlZ2WxIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlZ2WxIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F361F00893;
	Tue,  9 Jun 2026 01:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969349;
	bh=TJARZ6cZnNhFjHz8zElFT32Vu0NOwuJrHZc34ZYGVzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SlZ2WxIgHpipREg5Zu8SYyM9PKddnh5QjxeT7Vn0tGGo0mIP6FqCUCUUlD/UwwfNs
	 w4Bj9zroC7S3lzCGyHPCyd3gj+BUsYsQuxmgMivk+dWxHL51k3HMbMEIu3H2HYxjHo
	 C1n/0bWM8Un/ul/VjTNKKjxDzFGDB+IhQc29EL4sasL/gXXBGUze5Mm+s3BLGVvHxu
	 Sfb+xQvTagwW3nykPGmav0uFPFmD1F+1r0NsvNwnIIf2DF+2EtXpwPzVyfzvSbm355
	 eh3CXYajip1MSxQX42smplDUKNWYMlhUw5fskIaqMnbBEH1gScUHd9MDvSQAOfhGSy
	 wt/ibNrVS6vVQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] samples/damon/mtier: handle damon_start() failure
Date: Mon,  8 Jun 2026 18:42:19 -0700
Message-ID: <20260609014219.3013-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609010616.328991F00898@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 01:06:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] `damon_stop()` aborts its loop on the first error, leaving subsequent contexts running and triggering a Use-After-Free when their memory is destroyed.
> --
> 
> commit 6da87efa9d6982132beff965026bf155183e5c93
> Author: SeongJae Park <sj@kernel.org>
> 
> samples/damon/mtier: handle damon_start() failure
> 
> This commit adds cleanup for damon_start() failures in the memory tiering
> DAMON module. When damon_start() fails, it stops any running contexts
> and frees them to prevent memory leaks and exclusive mode locks.
> 
> Link: https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index eb1143de8df17..66b591f2180fa 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> [ ... ]
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
> >  
> >  static void damon_sample_mtier_stop(void)
> 
> [Severity: High]
> This is a pre-existing issue,

So not a blocker of this patch.

> but does damon_stop() leave contexts running
> and cause a use-after-free here?
> 
> Looking at damon_stop() in mm/damon/core.c:
> 
> int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
> {
> 	int i, err = 0;
> 
> 	for (i = 0; i < nr_ctxs; i++) {
> 		err = __damon_stop(ctxs[i]);
> 		if (err)
> 			break;
> 	}
> 	return err;
> }
> 
> If __damon_stop() returns an error for the first context (for instance, if
> the kthread exited prematurely due to an allocation failure), the loop
> breaks immediately.
> 
> When damon_sample_mtier_stop() calls damon_stop(ctxs, 2), this would mean
> ctxs[1] is never stopped if stopping ctxs[0] returns an error.
> 
> The subsequent unconditional calls to damon_destroy_ctx(ctxs[1]) in
> damon_sample_mtier_stop() would then free the context, its targets, and its
> schemes while kdamond is still executing and dereferencing them.
> 
> Can this lead to a use-after-free?

Makes sense.  I will separately work on this.


Thanks,
SJ

[...]
