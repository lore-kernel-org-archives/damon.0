Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715D225A38
	for <damon@lists.linux.dev>; Fri, 26 Dec 2025 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766773888; cv=none; b=c/sY9hEXznKcBMGQm5LK+i4RDeOzsQNvvAF9Qz8Jp8AoPrVQunkzzuXYheV0gmlhMhrhsH2KTtC44ZmcNM9AHuFwXWIk3mffXXECVs51QVuWR2+xZ+d1UlnPZhZ+GLl+QYZl/np5z2wVwSwFJMkbT0E03OIO+rw12isKXnrOmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766773888; c=relaxed/simple;
	bh=NOaIavykneT1/nXk1srM06FQDWvwc4luIp73kXT/Jgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dafR5wy/KycezuIBVp2pGBm3gBiu+Q8WG7b89zjyRm+kPSg1ZaNf4HjVyD0KiVUwTuAnWncF6RLSULqlrDgrzWYWWOCdqIDXcxZC6r9/ajCDl614UENhbsVSU6sz/P9PtZyH3+qMSFpsf95xvWDpQ5pyYBArp9O6UFjVsI+SmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f07vnWZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f07vnWZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E62AC4CEF7;
	Fri, 26 Dec 2025 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766773888;
	bh=NOaIavykneT1/nXk1srM06FQDWvwc4luIp73kXT/Jgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f07vnWZybr1Fd80YLpaHtrAf1fjWWQkFsESDk0xJ6RrAvnQwxS0dEeWh5PmE6mBsF
	 agOrcTxF9ggXw8TSoAqT3na9YQkiokul0nzWs9YC5N/b9UV8xuDqW8T+cZLa30b7+d
	 ME1Z9SjgELSGWPpoK4vvb6BsRLX53K8nu8GNDFUt4VhMFl5u6rkBDPonhMQym8OCAZ
	 cJQOwGSIJrDwU/1qrAeMfJIJzeQwChakaNMKHpG+8sXPh1rPeCgAFB6WFP3mrTdAgX
	 VBEObCQx8RUVtpKDyQ1S2gfGUmoE7U7wHwEHrmiacyEDk31Jl9sT9RBGV2GRK3Ys7x
	 FF3cNrgaYULdA==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
Date: Fri, 26 Dec 2025 10:31:17 -0800
Message-ID: <20251226183122.254549-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4f2xPK_LwFoisdqr_wX-RbdW9KUq48+82CMC=5ViF=ag@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Dec 2025 11:19:28 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Fri, 26 Dec 2025 at 05:01, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 25 Dec 2025 12:10:30 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Thu, 25 Dec 2025 at 10:07, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Wed, 24 Dec 2025 21:43:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > >
> > > > > The kdamond_call() function is executed repeatedly in the kdamond_fn()
> > > > > kernel thread.  The kdamond_call() function is implemented as a while loop.
> > > > > Therefore, it is important to improve the list processing logic here to
> > > > > ensure faster execution of control->fn().
> > > >
> > > > That depends on how critical the performance is, and how much complexity the
> > > > optimization introduces.  I have no idea about if the performance of
> > > > kdamond_call() is really important.  If you have a realistic use case that
> > > > shows it, sharing it would be nice.
> > >
> > > This is because kdamond_call() is called repeatedly in kdamond_fn().
> >
> > Yes, it is repeatedly called.  But, my question is, does it impose overhead
> > that great enough to make a negative impact to the real world.
> 
> I agree that the overhead is not that much since there are only a few lists
> added to ctx->call_controls(CTX.head).
[...]
> > > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > > index 824aa8f22db3..babad37719b6 100644
> > > > > --- a/mm/damon/core.c
> > > > > +++ b/mm/damon/core.c
> > > > > @@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
> > > > >   */
> > > > >  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
> > > > >  {
> > > > > -     struct damon_call_control *control;
> > > > > -     LIST_HEAD(repeat_controls);
> > > > > -     int ret = 0;
> > > > > +     struct damon_call_control *control, *first = NULL;
> > > > > +     unsigned int idx = 0;
> > > > >
> > > > >       while (true) {
> > > > >               mutex_lock(&ctx->call_controls_lock);
> > > > >               control = list_first_entry_or_null(&ctx->call_controls,
> > > > >                               struct damon_call_control, list);
> > > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > > -             if (!control)
> > > > > +
> > > > > +             /* check control empty or 1st rotation */
> > > > > +             if (!control || control == first)
> > > > >                       break;
> > > > > -             if (cancel) {
> > > > > +
> > > > > +             if (++idx == 1)
> > > > > +                     first = control;
> > > > > +
> > > > > +             if (cancel)
> > > > >                       control->canceled = true;
> > > > > -             } else {
> > > > > -                     ret = control->fn(control->data);
> > > > > -                     control->return_code = ret;
> > > > > -             }
> > > > > +             else
> > > > > +                     control->return_code = control->fn(control->data);
> > > > > +
> > > > >               mutex_lock(&ctx->call_controls_lock);
> > > > >               list_del(&control->list);
> > > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > > +
> > > > >               if (!control->repeat) {
> > > > > +                     /* run control->fn() one time */
> > > > >                       complete(&control->completion);
> > > > >               } else if (control->canceled && control->dealloc_on_cancel) {
> > > > >                       kfree(control);
> > > > > -                     continue;
> > > > >               } else {
> > > > > -                     list_add(&control->list, &repeat_controls);
> > > > > +                     /* to repeat next time */
> > > > > +                     mutex_lock(&ctx->call_controls_lock);
> > > > > +                     list_add_tail(&control->list, &ctx->call_controls);
> > > > > +                     mutex_unlock(&ctx->call_controls_lock);
> > > > >               }
> > > > >       }
> > > >
> > > > Let's suppose there are two damon_call_control objects on the
> > > > ctx->call_controls.  The first one has ->repeat unset, while the second one
> > > > has.  Then, it seems the 'break' condition will never met and therefore this
> > > > loop will never finished.  Am I missing something?
> > >
> > > You misjudged.
> > > If (!C.repeat), it will be removed with list_del() and disappear.
> > > If (C.repeat) loops through the loop once, and when it returns to the
> > > first, it breaks.
> >
> > Maybe my explanation was not enough.  Let me explain a bit in more detail.
> >
> > In the scenario I mentioned, at the first iteration of the loop, 'first' will
> > be the first control object, which has ->repeat unset.  The object will be
> > removed from the list.  In the second iteration of the loop, it handles the
> > second object, which has ->repeat set.  The object is added to the list again.
> > In the third iteration, the loop runs for the second object again.  Because it
> > is not same to 'first', the 'break' statement is not reached.  The loop
> > continues forever.
> >
> > Am I missing something?
> 
> Thank you for your detailed review.
> There may be cases where C->repeat=false is the first control.
> This can also be solved simply as follows:
> 
> @@ -2567,9 +2599,6 @@ static void kdamond_call(struct damon_ctx *ctx,
> bool cancel)
>                 if (!control || control == first)
>                         break;
> 
> -               if (++idx == 1)
> -                       first = control;
> -
>                 if (cancel)
>                         control->canceled = true;
>                 else
> @@ -2589,6 +2618,8 @@ static void kdamond_call(struct damon_ctx *ctx,
> bool cancel)
>                         mutex_lock(&ctx->call_controls_lock);
>                         list_add_tail(&control->list, &ctx->call_controls);
>                         mutex_unlock(&ctx->call_controls_lock);
> +                       if (++idx == 1)
> +                               first = control;
>                 }
>         }
>  }

Yes, that should fix the issue.

And it seems 'idx' is being used for only this?  If I'm not wrong, I think it
may be easier to read if you do something like 'first = first ? first :
control' and drop 'idx'.


Thanks,
SJ

[...]
