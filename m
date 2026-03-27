Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB436C5BC;
	Fri, 27 Mar 2026 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583636; cv=none; b=BqONB0BJII71R2hgln/LuSvWyJoHspXyQdq5QyXhM0SlW6nCxIS5z9xeZLo7+eE3k5M8fqY7jv0szLPtITzYxCs58QM0Br2am+9DRhr/cXsoOWZgl1CoxNpu92wsdwUhwW26HUoDHiMfHIt1W16mKVs/pmTYmoSmepTqGeiQYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583636; c=relaxed/simple;
	bh=3MHg1RUQO4rudmiuUy+mHrqVWAXUBdNAiLi8JqcLf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4Y2drJH854U2MlzBuJnErTZHF1WpJgwP2pYRKS464EMIoYhB9hi1uXwX7WBlxkditnu1A85+i4WzemFi0CPia5kobUloCQ0ACbShrzNMUiwCfvoHQS8+LhRIz11G3b56t2ZML+cNdiREVBQ5G/4o4LbXIGTbKkNi1hoJwu1uzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpnKQCIt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpnKQCIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E29C19423;
	Fri, 27 Mar 2026 03:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774583636;
	bh=3MHg1RUQO4rudmiuUy+mHrqVWAXUBdNAiLi8JqcLf8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpnKQCIthhpYQViR4eiqkUx/JtLQkvYNH98ArsRlc2fFcawW/XWjcUs1J9HRlmv9T
	 zuHJ6cgbL6jGdPob9bmcLVbHKHqfd/H07BJ9NLqZ26xQAxomx40F2N8CVx/Vm8sJCG
	 Roq4PNNdlU6JSoRdWOB4+WsQ5cVrghM78yCKnseBH6TMvnhhjCuAMg/ZPyDSNwsfbX
	 E85fF1Z500VMuaUWGvoBJCyBay2Fr5EicQwwqjHw/QFfH0pgRxMirVz/uhpiCDRskX
	 ICbYVgCnqKmGly8UdFU5kD/iwFHOfy4XL+mtgrT0RO63lNgCl9E69Fa38QadwzpX3v
	 nb35zI3oOR5hg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 20:53:54 -0700
Message-ID: <20260327035355.68068-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327022014.66567-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Mar 2026 19:20:13 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 26 Mar 2026 19:15:45 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Forwarding Sashiko review for doing discussions via mails.
> > 
> > # review url: https://sashiko.dev/#/patchset/20260327004952.58266-1-sj@kernel.org
> > # start of sashiko.dev inline review
> > commit 36b78ee39968830aca3d375219a2cfce73d0d1d0
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
> > 
> > This commit fixes a race condition between damon_call and the
> > kdamond_fn exit path that could result in a deadlock. It introduces a
> > call_controls_obsolete flag to prevent damon_call from waiting
> > indefinitely for a terminating thread.
> > 
> > Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > 
> > [ ... ]
> > 
> > > @@ -3062,6 +3042,9 @@ static int kdamond_fn(void *data)
> > >  	damon_destroy_targets(ctx);
> > >  
> > >  	kfree(ctx->regions_score_histogram);
> > > +	mutex_lock(&ctx->call_controls_lock);
> > > +	ctx->call_controls_obsolete = true;
> > > +	mutex_unlock(&ctx->call_controls_lock);
> > >  	kdamond_call(ctx, true);
> > >  	damos_walk_cancel(ctx);
> > 
> > Does damos_walk suffer from the same exit race regression that this patch
> > fixes for damon_call?
> > 
> > In kdamond_fn, the thread termination sequence executes damos_walk_cancel
> > and only later sets ctx->kdamond = NULL under the kdamond_lock.
> > 
> > damos_walk appears to use the same pattern as the old damon_call where it
> > registers ctx->walk_control, checks damon_is_running (which verifies
> > ctx->kdamond != NULL), and then unconditionally blocks on wait_for_completion.
> > 
> > If a user triggers a DAMOS walk in the exact window after damos_walk_cancel
> > has finished but before ctx->kdamond = NULL is executed, wouldn't damos_walk
> > successfully register its control and pass the damon_is_running check?
> > 
> > If so, it would then block indefinitely on wait_for_completion because the
> > cancellation phase has already passed and the thread is exiting.
> > 
> > Because damos_walk is invoked via state_store with the global
> > damon_sysfs_lock held, could this infinite wait block the entire DAMON sysfs
> > interface for all users on the system?
> 
> Yes, and I'm working on it separately, as I also replied [1] to the previous
> version.

Maybe I will make the next version of this patch as a series of two patches,
one for this one and the other one for the damos_walk() race fix.

> 
> [1] https://lore.kernel.org/20260326135146.90670-1-sj@kernel.org


Thanks,
SJ

[...]
