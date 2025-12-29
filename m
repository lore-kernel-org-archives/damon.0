Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7A329E43
	for <damon@lists.linux.dev>; Mon, 29 Dec 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021288; cv=none; b=HD7I7gxo0ydHhrfWZDL/9uo1U/+r8UaDSPcbfGnVMUOk+hSeY0LCyACl/II2O7y1mEIDJyGXuwPS2qLgsDPXFjFKkDXggX9nXdpcN2DkJWynMvoDPgKmAS0RJk67DRLFnGxgmuk70aoVZnW4GT6zm+4Eg9S9zRZVoehjzUT2wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021288; c=relaxed/simple;
	bh=Xs1tmf9C7xo6l4OgdflDuYGdhYDMGIBEbJwdPqxALW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAajow7cxOVcwOcdZk1UBQqqwetEws7n1pWKIm9FhA4YiCRZPOpjj2nXD8joKWX7EZdIriyCg5m53RVBrV9WTqU0zGH+4JS5PL9eTdRXfpA3r8BBDJiJXbazIGojj/ytNNYaDGgCeTOj0quGt2a5XxxsKXgdgnM91abDLEA0fRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwCRwJlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwCRwJlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C4CC4CEF7;
	Mon, 29 Dec 2025 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767021288;
	bh=Xs1tmf9C7xo6l4OgdflDuYGdhYDMGIBEbJwdPqxALW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwCRwJlL6HQFPm5wxDbBdS7qlRBSIirtH9eKhS4LOK8Hub+XN2GMIxyGQebL/85vD
	 SpFhWQ4ynQyPWv2XANaScssiu405qVIZCc8jjNEF91eDH4lMans2OtOAoPLyU+UYWM
	 98dO+2UmXkf64lkxb9FfWt18TV8ZCzXSUNdL5UgXd3GSPxxGv62vCvZzPQFFLaRXVJ
	 RxrWzkbKErnw0KFwwoumTCHXViTKA+TDEXDdAo2yBlKc3iovPWe5O2KYSWzL0w+hUr
	 kZuOhmniOhry9U7+l8AC2eNJ/I5HH1U/yfJtzesnoCoG93n17SobVQf0uxnoFiUMxc
	 aSsX7I0Vo9s1A==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at the damon_call()
Date: Mon, 29 Dec 2025 07:14:39 -0800
Message-ID: <20251229151440.78818-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC7KAmj8hb8GtTJ+P_GUGqjP1WO8uqnpFjMPQmKFrc1oZw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Dec 2025 12:38:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Sun, 28 Dec 2025 at 02:42, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sat, 27 Dec 2025 08:53:21 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Sat, 27 Dec 2025 at 03:41, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Fri, 26 Dec 2025 10:48:31 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > >
> > > > > On Fri, 26 Dec 2025 at 04:50, SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 25 Dec 2025 11:35:33 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > > > >
> > > > > > > On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hello JaeJoon,
> > > > > > > >
> > > > > > > > On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > > [...]
> > > > > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > > > > index babad37719b6..2ead0bb3c462 100644
> > > > > > > --- a/mm/damon/core.c
> > > > > > > +++ b/mm/damon/core.c
> > > > > > > @@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
> > > > > > >   */
> > > > > > >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> > > > > > >  {
> > > > > > > +       if (!damon_is_running(ctx))
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > >         if (!control->repeat)
> > > > > > >                 init_completion(&control->completion);
> > > > > > >         control->canceled = false;
> > > > > > > @@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > > > > damon_call_control *control)
> > > > > > >         mutex_lock(&ctx->call_controls_lock);
> > > > > > >         list_add_tail(&control->list, &ctx->call_controls);
> > > > > > >         mutex_unlock(&ctx->call_controls_lock);
> > > > > > > -       if (!damon_is_running(ctx))
> > > > > > > -               return -EINVAL;
> > > > > > >         if (control->repeat)
> > > > > > >                 return 0;
> > > > > > >         wait_for_completion(&control->completion);
> > > > > >
> > > > > > Let's assume DAMON is terminated between the damon_is_running() and
> > > > > > list_add_tail().  In the case, the control->fn() will never be called back.  If
> > > > > > control->repeat is false, this function will even inifnitely wait.
> > > > >
> > > > > As you said, there are cases where kdamond is terminated(stopped) in
> > > > > damon_is_running() and list_add_tail().  It may be a very rare case, but
> > > > > I missed this case.
> > > > >
> > > > > >
> > > > > > I think we should keep the damon_is_running() as is, but further check if it
> > > > > > was terminated without handling the control object, and remove it from the list
> > > > > > in the case.  Like below.
> > > > [...]
> > > > > However, the damon_call_handle_inactive_ctx() function is to post-process
> > > > > the duplicate addition of control->list.  Rather, it is more efficient to
> > > > > prevent duplicate additions in advance, as follows:
> > > > > I have tested the following and it works fine.
> > > > >
> > > > > @@ -1467,11 +1496,14 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > > damon_call_control *control)
> > > > >         control->canceled = false;
> > > > >         INIT_LIST_HEAD(&control->list);
> > > > >
> > > > > -       mutex_lock(&ctx->call_controls_lock);
> > > > > -       list_add_tail(&control->list, &ctx->call_controls);
> > > > > -       mutex_unlock(&ctx->call_controls_lock);
> > > > > -       if (!damon_is_running(ctx))
> > > > > +       if (damon_is_running(ctx)) {
> > > > > +               mutex_lock(&ctx->call_controls_lock);
> > > > > +               list_add_tail(&control->list, &ctx->call_controls);
> > > > > +               mutex_unlock(&ctx->call_controls_lock);
> > > > > +       } else {
> > > > > +               /* return damon_call_handle_inactive_ctx(ctx, control); */
> > > > >                 return -EINVAL;
> > > > > +       }
> > > > >         if (control->repeat)
> > > > >                 return 0;
> > > > >         wait_for_completion(&control->completion);
> > > >
> > > > I think this is not differnt from your previous suggestion, and thus it has the
> > > > same issue.  What if DAMON is terminated between damon_is_running() and
> > > > list_add_tail() call?  Please let me know if I'm missing something.
> > >
> > > I think it is good idea to insert a barrier() between damon_is_running()
> > > and list_add_tail() to prevent context-switching.  What do you think this?
> >
> > I don't think barrier() works in the way.  Please correct me if I'm wrong.
> 
> Yes, there is no need to use memory barriers.  Since each kdamond runs
> its
> own damon_ctx, the concurrent access problem can be sufficiently
> solved with
> mutext_lock.  The problem discussed so far can be solved by applying
> mutex_lock to both ctx->kdamond and ctx->call_controls.
> Please refer to the modified code below:
> 
> @@ -1496,14 +1502,15 @@ int damon_call(struct damon_ctx *ctx, struct
> damon_call_control *control)
>         control->canceled = false;
>         INIT_LIST_HEAD(&control->list);
> 
> -       if (damon_is_running(ctx)) {
> -               mutex_lock(&ctx->call_controls_lock);
> +       mutex_lock(&ctx->call_controls_lock);
> +       if (ctx->kdamond) {
>                 list_add_tail(&control->list, &ctx->call_controls);
> -               mutex_unlock(&ctx->call_controls_lock);
>         } else {
> -               /* return damon_call_handle_inactive_ctx(ctx, control); */
> +               mutex_unlock(&ctx->call_controls_lock);
>                 return -EINVAL;
>         }
> +       mutex_unlock(&ctx->call_controls_lock);
> +
>         if (control->repeat)
>                 return 0;
>         wait_for_completion(&control->completion);

This diff assumes holding ctx->call_controls_lock will avoid the context be
terminated, right?  But there is no such guarantees.


Thanks,
SJ

[...]
