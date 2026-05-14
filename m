Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FA38889A
	for <damon@lists.linux.dev>; Thu, 14 May 2026 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737381; cv=none; b=IhcarChM2r+5Fwdr09zn4QTbZ5Ui1obn/DLovkpI6CSnXblxE01OBr9nqVMMRbXgO2P6bL4JrSp7b6PUrxcAWM5pJujq19LE1l0bcd97BS2vTJEHBiLcbvM3gR+CBqNP14Wi4iOOTW56o3vjWAbZzAlenSuQWathjgpAy8crEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737381; c=relaxed/simple;
	bh=/RnUib3eXMTsF1XoahcEvgUg4uvTMKkG+0CYuDbMG4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQKyUdH7Dh1VXwvKwLFPLKYt11+R66NfM3b+rJDi+/zWQ+H2Udf6c608L72+flRpAqN0u8eAkGqqVSSRkDBkAk7g5pwoB4ZcqL1y3CKplxLqvpQ2lOz42MySnLVS3mZccXel2d189SRUX70n73Bkazdf33nze/duDPZB8PvXsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqFkB824; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqFkB824"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD1C2BCB7;
	Thu, 14 May 2026 05:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778737380;
	bh=/RnUib3eXMTsF1XoahcEvgUg4uvTMKkG+0CYuDbMG4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqFkB824ZyzTgmcc5/w/5IuEBoIQFspKYFzlzjR+pUJJ7X5B9mXC+UrF8wKqHFgr0
	 cT6D0iua2iKm1Yh8IlMw5BaYa9s93MAYAL0I+u+lF63ijdQm/8XBn54fAtV/SLFiEZ
	 MDOHhfv/ADJkT3tcy8a7Nj2Z+QePUUoai2JUVvaxYfj07FlGLz0ia4rumyltH6Eus1
	 IJAJkp1RqqJBEpaqtCPh3xmpcd8r1SWB1J0ZzHLWsvNAIuOCWDpmvHI+umM6k+38EG
	 hLzZlFcAZjlIBXcKJiB6wHrrqLs22VJAzgphD2piFi/Jed82qvdrre+GBVutLAG8OX
	 HF7Z/tgoKa9bA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:42:51 -0700
Message-ID: <20260514054253.116346-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514021725.2801FC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 02:17:24 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The patch fails to fix the state machine deadlock that prevents kdamond from restarting, leaving the bug described in the commit message unresolved.
> - [Low] The patch introduces calls to undefined functions `damon_is_running()` and `damon_kdamond_pid()`, causing a build failure.
> --
> 
> commit de09cefa1bba6b569eff518a49dbc5fb07b59452
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
> 
> This patch updates DAMON_RECLAIM to dynamically detect the status of the
> enabled and kdamond_pid parameters. It aims to prevent users from seeing
> stale status values and being unable to restart the kdamond thread when
> it stops unintentionally.
> 
> Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
> Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org
> 
> >     For example, the issue can be reproduced via below steps.
> [ ... ]
> >     # # even after fixing the wrong parameter,
> >     # # kdamond cannot be restarted.
> >     # echo 1 > addr_unit
> >     # echo Y > enabled
> >     # ps -ef | grep kdamond
> >     root         815     803  0 17:54 pts/4    00:00:00 grep kdamond
> 
> Does this patch actually resolve the restart issue described here? 
> 
> Looking at damon_reclaim_timer_fn(), the state machine still appears to
> deadlock if kdamond stops unintentionally:
> 
> 	now_enabled = enabled;
> 	if (last_enabled != now_enabled) {
> 		if (!damon_reclaim_turn(now_enabled))
> 			last_enabled = now_enabled;
> 		else
> 			enabled = last_enabled;
> 	}
> 
> When kdamond dies, the global enabled and static last_enabled variables
> remain true.
> 
> If a user writes 'Y' to enabled, the timer sees last_enabled == now_enabled
> (true == true) and exits without restarting kdamond.
> 
> If a user writes 'N' to enabled, the timer calls damon_reclaim_turn(false),
> which invokes damon_stop(). Since the thread is already dead, damon_stop()
> returns -EPERM. The timer misinterprets this as a failure to stop and
> executes enabled = last_enabled, reverting enabled back to true. 
> 
> Could this leave the state machine permanently deadlocked?

Correct.  The enabled_store() part porting was incomplete, similar to the
matching lru_sort patch.  I will post a complete porting.

> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 7952a0b7f409d..dc435aefd44f5 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> [ ... ]
> > @@ -220,6 +203,13 @@ static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
> >  
> >  static bool damon_reclaim_initialized;
> >  
> > +static bool damon_reclaim_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> 
> Are damon_is_running() and damon_kdamond_pid() defined anywhere in the tree?
> 
> They don't appear to be declared in include/linux/damon.h or defined in
> mm/damon/core.c.
> 
> Could this patch depend on prerequisite patches that might be missing?
> Without them, this causes implicit function declaration errors and
> unresolved symbol linker errors.

I informed this and where the dependent patches can be found, on the commentary
area of the patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260513050501.216835-1-sj@kernel.org?part=1


Thanks,
SJ
