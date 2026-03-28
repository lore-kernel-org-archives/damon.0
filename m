Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8D258EFF;
	Sat, 28 Mar 2026 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774659110; cv=none; b=Wcs5bwcZsZN7LQaDSmTKVIYNuRK2h5lGHk0kN/x9Eh+Qv1BuXeNMR9aMZew6yCW9GUD+muRQJvmnPpJAYmol6cTWjx3TGHuytuVkL/7N6zRv6n4ybHhmgaPzi08r8mEjgjQlajc+uS/1RHxsyy4qF1ZlcXaEPSV5623QbSxQg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774659110; c=relaxed/simple;
	bh=pJYyQZiMQ0KPSvyjj3o15XFMXdymXNI8R8k9OQyW7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvaUNBipWI61bcOtyOJsL8ED8AO5KDYmJDQL4RmqXUW2WnsDPdAHZq5XKcKy1+cysrEmnGo88gZVBVeezqirYXGR8PMWqaD24I+uGz7Cj7WmGv7i7EQnvfIZDtBj5m88PkrKbFv4wgVUirtBkMTPdSu4FJbif60LSfzoyZ5QZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE+0i+EK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE+0i+EK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5851C19423;
	Sat, 28 Mar 2026 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774659110;
	bh=pJYyQZiMQ0KPSvyjj3o15XFMXdymXNI8R8k9OQyW7BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EE+0i+EKbV8nAM1Rna0by0it8TnMuHnF+wWs/zCypZDeJe6H6EHXmg/TY7yhBB+J1
	 SF+3XRzpgS6g2Xp9MoYM7Qq9qKBJHYGdFL34L6idTK26zhkSNuwuPI8FWbLa2MlwtR
	 aMeQTLyXem6nTb4z+arXYuwTSx3QOEF8BxVP7++OEs+A8BXkM0JyDyhN+Pu3uvWc2D
	 16ewrDi2BIJIrN5fLwXvqzwpXRrOZ4Iudq/NuSjNKbd+Mf7GNBEKUkZYrc6CK1Fvli
	 IMohZ3miuTSyDTdnaj9mw7jaO2BUIaFcLMxQcexXoiKPnqc3Z2tQ8ZRt+L9+/pA5zO
	 pSCw5YRQqTOUQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 1/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race
Date: Fri, 27 Mar 2026 17:51:48 -0700
Message-ID: <20260328005148.7435-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328004307.7244-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 17:43:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260327233319.3528-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 9cf54c95f0c4bda07c5dbaf4019d0d731f6c58fd
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: fix damon_call() vs kdamond_fn() exit race
> 
> This commit introduces a new call_controls_obsolete flag to prevent
> damon_call() from adding requests to a terminating kdamond context.
> It removes the after-registration DAMON context termination check.
> 
> Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..9bcda2765ac9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1629,10 +1604,12 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> >  	INIT_LIST_HEAD(&control->list);
> >  
> >  	mutex_lock(&ctx->call_controls_lock);
> > +	if (ctx->call_controls_obsolete) {
> > +		mutex_unlock(&ctx->call_controls_lock);
> > +		return -ECANCELED;
> > +	}
> >  	list_add_tail(&control->list, &ctx->call_controls);
> >  	mutex_unlock(&ctx->call_controls_lock);
> > -	if (!damon_is_running(ctx))
> > -		return damon_call_handle_inactive_ctx(ctx, control);
> >  	if (control->repeat)
> >  		return 0;
> >  	wait_for_completion(&control->completion);
> 
> Can this code trigger a use-after-free on control?
> 
> This appears to be a pre-existing issue that remains unfixed. If
> kdamond_fn() is terminating, it executes kdamond_call(ctx, true). This
> function removes the request, sets it as canceled, and calls kfree(control)
> if control->dealloc_on_cancel is true.
> 
> Since ctx->call_controls_lock is dropped right before the control->repeat
> check:
> 
> CPU1 (kdamond_fn)
> kdamond_call(ctx, true)
>     list_del(&control->list);
>     kfree(control);
> 
> CPU2 (damon_call)
>     mutex_unlock(&ctx->call_controls_lock);
>     if (control->repeat)
> 
> Could kdamond_call() free control before damon_call() evaluates
> control->repeat?

No.  kdamond_call(ctx, true) is called only after call_controls_obsolete is
set, under the call_control_lock.  And damon_call() reads the
call_controls_obsolete just after acquiring the call_control_lock, and return
if it is set.

Hence CPU2 in this scenario cannot execute the mutex_unlock() part after CPU1
entered kdamond_call().

> 
> Furthermore, if memory poisoning causes the freed memory to evaluate
> control->repeat as false, would this proceed to call wait_for_completion()
> on the freed memory and cause wait queue corruption?

So this is also wrong.


Thanks,
SJ

[...]
