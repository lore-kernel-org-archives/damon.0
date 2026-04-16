Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094C30F957
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776312364; cv=none; b=UUUwFR/C0oDsW+bDSd1UDYquYB1INHChTj1AD3j7QtKVfvaSjbIx7GogCC4Y14DamgDwKKquLbkiuB4k31tbc7Bz0anlIOaJLF0yISKLPY1fDJG6Wli0Kqa8PinHSv0VfHMN071BkgsS99ko8SQihqFl1ieKzJQG+WeCgjlslNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776312364; c=relaxed/simple;
	bh=8wRN+H/SQYxjKdjXgNtCgwHJm/4TKR5Qc1q1r+kXOFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9LJJkQBTzW/SXEyF2pkVwW8KqShaLyAl5qQUQj2wZbi/nOXdxUwbMxSQtrOzxMELX7j/1ayvMzLfQ14Ld2Y/op0MR46Gr6qya1SB/A1v5jyGaSMvbsu0euvf8t3Py9xUQZVUuPzpaC062QkEC/GrbrvetB9e0+SH7SxgbVbu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHAVc/ox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHAVc/ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F475C2BCAF;
	Thu, 16 Apr 2026 04:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776312364;
	bh=8wRN+H/SQYxjKdjXgNtCgwHJm/4TKR5Qc1q1r+kXOFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHAVc/oxDyCTM6i12X7V7feHMaFO6X8J04heZK8FJrl+xKgX4wYzdDQwSKWhLgtQf
	 WUIyw4QAnPv12raLddk6i00uyR4PrdA4MmP1J52QeyanaYXWma2GPF3Jrqp1xkyQfa
	 gGX6FSn2kt7chdgarlXHV4+NjBsYUVhCQyJD4dZCteoDBG1LWKEHLiV5hXaHppOdGi
	 VoChUHog0IkkRZayVG5x+QzvSx4qwSQJWxg+DLyB8t+ZByVWIUsm839SjEzqcnTvsU
	 5dAjYxU6n/rMofvh7HoJ4cuy9kQaOO3m3nbUO3y+QmL1R/a1OWpDFh/RxbFmhgI2o4
	 dpbkRwtNSvL8Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Wed, 15 Apr 2026 21:06:01 -0700
Message-ID: <20260416040602.88665-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416033546.87941-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 20:35:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR: Sashiko found good point.  I will fix it in the next revision.
> 
> On Thu, 16 Apr 2026 00:59:35 +0000 sashiko-bot@kernel.org wrote:
> 
> > Sashiko AI review found 1 potential issue(s):
> > - [Medium] Stale `kdamond_pid` exposed to userspace if `damon_call()` fails during startup.
> > --
> > 
> > commit 46eb0a4278ccd2dec190db28b78b0766b8865901
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/stat: add a parameter for reading kdamond pid
> > 
> > This commit exposes the pid of the DAMON_STAT kdamond via a new read-only
> > module parameter named kdamond_pid, standardizing usage with other DAMON
> > modules.
> > 
> > > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > > index 99ba346f9e325..4901e9a7c3398 100644
> > > --- a/mm/damon/stat.c
> > > +++ b/mm/damon/stat.c
> > 
> > [ ... ]
> > 
> > > @@ -260,6 +269,14 @@ static int damon_stat_start(void)
> > >  		damon_stat_context = NULL;
> > >  		return err;
> > >  	}
> > > +	kdamond_pid = damon_kdamond_pid(damon_stat_context);
> > > +	if (kdamond_pid < 0) {
> > > +		err = kdamond_pid;
> > > +		kdamond_pid = -1;
> > > +		damon_destroy_ctx(damon_stat_context);
> > > +		damon_stat_context = NULL;
> > > +		return err;
> > > +	}
> > >  
> > >  	damon_stat_last_refresh_jiffies = jiffies;
> > >  	call_control.data = damon_stat_context;
> > 
> > If damon_call() fails right after this and returns an error,
> > damon_stat_start() will pass that error back to its caller and the module
> > will revert to a disabled state.
> > 
> > Does this leave a stale kdamond_pid exposed to userspace? The newly added
> > documentation states: "If DAMON_STAT is enabled, this becomes the PID of
> > the worker thread. Else, -1." Since the initialization fails, the module
> > remains disabled, but kdamond_pid isn't reset to -1 on this error path.
> 
> Nice catch.  I will do the kdamond_pid setup after damon_call() success, like
> below.

Wait...  The same question was also raised [1] by Sashiko on the previous
version.  And I was wrongly saying it is not this patch's fault.  That was
completely wrong.

And the kdamond can stop even after the damon_kdamond_pid() call, if the
region_store_histogram allocation fails.  In the case, kdamond_pid will again
be stale.  'enabled' parameter value will also be stale in the case.  The worst
part of it is that in the case, DAMON_STAT cannot be restarted before the
system is reboot.  The bug is similar to the one [2] that Liew found and
working on.

I will hold this patch and fix the bug first.

> Also, I will remove the damon_stat_context deallocation and unset when
> damon_kdamond_pid() failure, because it will be deallocated when
> damon_stat_start() is called again.

This also means my reply [1] to Sashiko's question about the damon_stat_context
leak on the previous version was wrong.  I was saying it is indeed a bug, but
it was not.

[1] https://lore.kernel.org/20260414053742.90296-1-sj@kernel.org
[2] https://lore.kernel.org/20260415235529.86329-1-sj@kernel.org


Thanks,
SJ

[...]
