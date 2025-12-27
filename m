Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29422FDEA
	for <damon@lists.linux.dev>; Sat, 27 Dec 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857372; cv=none; b=bcg7TRmVR+C4JZBx7xesgshLtd9kYEWQpftKkX8PQVNI5yzg6d/ZRUgDaPHbuotaW7a+5dHnxFxIDfTZo7TiC9Qo/kWQktlelyDMNupACz7LK7/3soGSYCCOBxakX1tsvOmLM31XoaL3bzkFtuUQVUml51Wdrro1YILP4wmOAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857372; c=relaxed/simple;
	bh=GmEfmocljw2ZGdCriw+M4GF2i0Suwp4h07YGW7Y4lLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPHr94SHvM2Ha9xattyTFE6carSK0w2fjaEo529zB/ELjDNK5DhbUFq6GmSCf0HN3tlIzfqgR6Flb67C0PYf7uBwtC4sNXhOvS3Dt0cuHVedHPvLdjIKemwpHWPiwxWUVdSJOqJ3uwo+DNzaBQ3oBBfLnMYoOvMvT01bq0Bh0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNAZcGe+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNAZcGe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2959C4CEF1;
	Sat, 27 Dec 2025 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766857372;
	bh=GmEfmocljw2ZGdCriw+M4GF2i0Suwp4h07YGW7Y4lLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNAZcGe+FTTNOF8fqTLXMlRWM+/qMu7FnWT6tHKUo8cwQOhdOv/wxE1fKUiwBwAvK
	 3ZbHlr452PJuUxj3NADBzVszHCFdCgAFOg5tKubWAe3lp82vv4bxy8GslVN1tncRWF
	 jZk98OexmUbRHXsbqzzLXuKqA9+tw5uQE+uUcboLTevKBTzaO+JZgBYPzEFdKZmBgQ
	 hyWySJ6aXIv405fURyvfepr8KrJOYq6+VwOh6Nd2DePYFMxGDxx+M5bmtsOBQUIt7P
	 fvqtM0RyhD5EtwurHSZb0S8wsimoZ+hlYDaCTaDsJ6+VDzJoR1aUC4wIRgG2GNA7v4
	 ZThPFYZHSjPgQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at the damon_call()
Date: Sat, 27 Dec 2025 09:42:34 -0800
Message-ID: <20251227174239.273581-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC7HqeGY1uxy7FxLKTFHAJPcWWbKJRjZ06W9bC4oAejOsw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Dec 2025 08:53:21 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Sat, 27 Dec 2025 at 03:41, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 26 Dec 2025 10:48:31 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Fri, 26 Dec 2025 at 04:50, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Thu, 25 Dec 2025 11:35:33 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > >
> > > > > On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > Hello JaeJoon,
> > > > > >
> > > > > > On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > [...]
> > > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > > index babad37719b6..2ead0bb3c462 100644
> > > > > --- a/mm/damon/core.c
> > > > > +++ b/mm/damon/core.c
> > > > > @@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
> > > > >   */
> > > > >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> > > > >  {
> > > > > +       if (!damon_is_running(ctx))
> > > > > +               return -EINVAL;
> > > > > +
> > > > >         if (!control->repeat)
> > > > >                 init_completion(&control->completion);
> > > > >         control->canceled = false;
> > > > > @@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > > damon_call_control *control)
> > > > >         mutex_lock(&ctx->call_controls_lock);
> > > > >         list_add_tail(&control->list, &ctx->call_controls);
> > > > >         mutex_unlock(&ctx->call_controls_lock);
> > > > > -       if (!damon_is_running(ctx))
> > > > > -               return -EINVAL;
> > > > >         if (control->repeat)
> > > > >                 return 0;
> > > > >         wait_for_completion(&control->completion);
> > > >
> > > > Let's assume DAMON is terminated between the damon_is_running() and
> > > > list_add_tail().  In the case, the control->fn() will never be called back.  If
> > > > control->repeat is false, this function will even inifnitely wait.
> > >
> > > As you said, there are cases where kdamond is terminated(stopped) in
> > > damon_is_running() and list_add_tail().  It may be a very rare case, but
> > > I missed this case.
> > >
> > > >
> > > > I think we should keep the damon_is_running() as is, but further check if it
> > > > was terminated without handling the control object, and remove it from the list
> > > > in the case.  Like below.
> > [...]
> > > However, the damon_call_handle_inactive_ctx() function is to post-process
> > > the duplicate addition of control->list.  Rather, it is more efficient to
> > > prevent duplicate additions in advance, as follows:
> > > I have tested the following and it works fine.
> > >
> > > @@ -1467,11 +1496,14 @@ int damon_call(struct damon_ctx *ctx, struct
> > > damon_call_control *control)
> > >         control->canceled = false;
> > >         INIT_LIST_HEAD(&control->list);
> > >
> > > -       mutex_lock(&ctx->call_controls_lock);
> > > -       list_add_tail(&control->list, &ctx->call_controls);
> > > -       mutex_unlock(&ctx->call_controls_lock);
> > > -       if (!damon_is_running(ctx))
> > > +       if (damon_is_running(ctx)) {
> > > +               mutex_lock(&ctx->call_controls_lock);
> > > +               list_add_tail(&control->list, &ctx->call_controls);
> > > +               mutex_unlock(&ctx->call_controls_lock);
> > > +       } else {
> > > +               /* return damon_call_handle_inactive_ctx(ctx, control); */
> > >                 return -EINVAL;
> > > +       }
> > >         if (control->repeat)
> > >                 return 0;
> > >         wait_for_completion(&control->completion);
> >
> > I think this is not differnt from your previous suggestion, and thus it has the
> > same issue.  What if DAMON is terminated between damon_is_running() and
> > list_add_tail() call?  Please let me know if I'm missing something.
> 
> I think it is good idea to insert a barrier() between damon_is_running()
> and list_add_tail() to prevent context-switching.  What do you think this?

I don't think barrier() works in the way.  Please correct me if I'm wrong.


Thanks,
SJ

[...]
