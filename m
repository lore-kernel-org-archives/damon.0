Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25691FC8
	for <damon@lists.linux.dev>; Thu, 25 Dec 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766692861; cv=none; b=snCJ4S3UYnjwhmrsT0XIEjPK7UscuYK+oQI0johFmi5Nmbtni/72s91vVT81AKW7kQZI9x+oZYQxp6oIo8auAE2Zg1CfW6ZV2FPuTDt/c2qS/bEIpEl9XA/3ror+djkOjQdQ8jRfiZ9piv9uTg/mW8RPAfd7QpNZtUXL9wD3jJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766692861; c=relaxed/simple;
	bh=vKAiaWTw332zPI04HxC+785AxWPKLose8xlFW+2UClg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcACkcWAzkLfaBEmhOblSb51QgnlXeLukOjLKlu4S+h58NF07lu0IN+V8KxDmR5s4Gw/hFPARLWaDHtEdVGOHRy9bWWYcb6Jgjmh225nIA5u/QRarvWpmZ1d2AclNDAzu2GdJheAndvpyQzTIjHWy067RXwpmyP39XPNLfVmKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFlJQpLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFlJQpLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F222DC4CEF1;
	Thu, 25 Dec 2025 20:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766692860;
	bh=vKAiaWTw332zPI04HxC+785AxWPKLose8xlFW+2UClg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFlJQpLoXDfxxH5vI/D5/D9YNXjil7LQmlo9BVZ3SfLYbJe0yJLnejlPbOmRVPhay
	 ZlOyC1O4kke6d55uhtPGAEf9gfhDKY53JfpUQzVy7alBX9J8m6tx8DcAgj3kN1mDPl
	 iHzzVxDXMnzK7HQqyT1vQgumP+6BBjCJ868Lj8T5t/RcF2pUadjj0PWFAYWYm5L9sQ
	 tojYBo5u0S7eIuFdArqJ5Uh/rUKt2dgJV/hOtDuTtmgqruw0FvbofP5kcDtW/1hHYF
	 G579nNyC7Az0LcuRduPMe++lS7aFCKX0hHgrtJRcfbTz1Vqkb3FJgt7XKtbjOlkVS2
	 vVwpOIqsipOiQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
Date: Thu, 25 Dec 2025 12:00:50 -0800
Message-ID: <20251225200051.1069-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4dYGqY2pMQktBbO-NWKGE2XXeA1e+6BrP2QtsjM2Dodg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Dec 2025 12:10:30 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Thu, 25 Dec 2025 at 10:07, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 24 Dec 2025 21:43:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > The kdamond_call() function is executed repeatedly in the kdamond_fn()
> > > kernel thread.  The kdamond_call() function is implemented as a while loop.
> > > Therefore, it is important to improve the list processing logic here to
> > > ensure faster execution of control->fn().
> >
> > That depends on how critical the performance is, and how much complexity the
> > optimization introduces.  I have no idea about if the performance of
> > kdamond_call() is really important.  If you have a realistic use case that
> > shows it, sharing it would be nice.
> 
> This is because kdamond_call() is called repeatedly in kdamond_fn().

Yes, it is repeatedly called.  But, my question is, does it impose overhead
that great enough to make a negative impact to the real world.

> 
> >
> > > For ease of explanation,
> > > the data structure names will be abbreviated as follows:
> > >
> > > damon_call_control.list: C.list
> > > ctx->call_controls: CTX.head
> > > repeat_controls: R.head
> > >
> > > the execution flow of the while loop of the kdamond_call() function,
> > >
> > > Before modification:
> > > Old while loop:
> > >
> > >         CTX.head <-----> C.list <-----> C.list <----> C.list
> > >         ^                   |                           |
> > >         |               if (C.repeat)            if (!C.repeat)
> > >    restore: only one        |                           |
> > >    list_add_tail()        list_del()                  list_del()
> > >         |                   |                           |
> > >         +                   |                       complete()
> > >         R.head <------ list_add()
> > >
> > > To process C.repeat above, we use an additional list, repeat_controls.
> >
> > Your above abbreviation didn't explain what C.repeat is.  Maybe you mean
> > 'damon_call_control.repeat'?
> 
> Yes, that's right.

Thank you for confirming.

> 
> >
> > > The process of adding C.list to repeat_controls and then restoring it back
> > > to CTX.head is complex and inefficient.
> >
> > I agree.
> >
> > > Furthermore, there's the problem
> > > of restoring only a single C.list to CTX.head.
> >
> > I had to take some time on understanding what this mean.  And it seems you are
> > working on an old version of the tree, and therefore saying about an issue that
> > already fixed by commit 592e5c5f8ec6 ("mm/damon/core: fix memory leak of repeat
> > mode damon_call_control objects").
> >
> > Please use mm-new as a baseline of DAMON patches, unless there are special
> > reasons.  If there are special reasons, please explicitly specify.
> 
> This patch is based on v6.19-rc2.
> I will continue to refer to mm-new and damon-new.
> 
> >
> > >
> > > Below, repeat_controls is removed and the existing CTX.head is modified to
> > > loop once(1st rotation).  This simplifies list processing and creates a
> > > more efficient structure.
> > >
> > > Modified while loop:
> > > Not used repeat_controls:
> > >
> > >         CTX.head <-----> C.list <-----> C.list <----> C.list <-------+
> > >                             |                           |            |
> > >                         if (C.repeat)            if (!C.repeat)      |
> > >                             |                           |            |
> > >                           list_del()                  list_del()     |
> > >                             |                           |            |
> > >                             |                       complete()       |
> > >                             |                                        |
> > >                           first --------> list_add_tail() -----------+
> > >
> > >         if (C.list == first) break;
> > >
> > > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > > ---
> > >  mm/damon/core.c | 37 +++++++++++++++++++------------------
> > >  1 file changed, 19 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 824aa8f22db3..babad37719b6 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
> > >   */
> > >  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
> > >  {
> > > -     struct damon_call_control *control;
> > > -     LIST_HEAD(repeat_controls);
> > > -     int ret = 0;
> > > +     struct damon_call_control *control, *first = NULL;
> > > +     unsigned int idx = 0;
> > >
> > >       while (true) {
> > >               mutex_lock(&ctx->call_controls_lock);
> > >               control = list_first_entry_or_null(&ctx->call_controls,
> > >                               struct damon_call_control, list);
> > >               mutex_unlock(&ctx->call_controls_lock);
> > > -             if (!control)
> > > +
> > > +             /* check control empty or 1st rotation */
> > > +             if (!control || control == first)
> > >                       break;
> > > -             if (cancel) {
> > > +
> > > +             if (++idx == 1)
> > > +                     first = control;
> > > +
> > > +             if (cancel)
> > >                       control->canceled = true;
> > > -             } else {
> > > -                     ret = control->fn(control->data);
> > > -                     control->return_code = ret;
> > > -             }
> > > +             else
> > > +                     control->return_code = control->fn(control->data);
> > > +
> > >               mutex_lock(&ctx->call_controls_lock);
> > >               list_del(&control->list);
> > >               mutex_unlock(&ctx->call_controls_lock);
> > > +
> > >               if (!control->repeat) {
> > > +                     /* run control->fn() one time */
> > >                       complete(&control->completion);
> > >               } else if (control->canceled && control->dealloc_on_cancel) {
> > >                       kfree(control);
> > > -                     continue;
> > >               } else {
> > > -                     list_add(&control->list, &repeat_controls);
> > > +                     /* to repeat next time */
> > > +                     mutex_lock(&ctx->call_controls_lock);
> > > +                     list_add_tail(&control->list, &ctx->call_controls);
> > > +                     mutex_unlock(&ctx->call_controls_lock);
> > >               }
> > >       }
> >
> > Let's suppose there are two damon_call_control objects on the
> > ctx->call_controls.  The first one has ->repeat unset, while the second one
> > has.  Then, it seems the 'break' condition will never met and therefore this
> > loop will never finished.  Am I missing something?
> 
> You misjudged.
> If (!C.repeat), it will be removed with list_del() and disappear.
> If (C.repeat) loops through the loop once, and when it returns to the
> first, it breaks.

Maybe my explanation was not enough.  Let me explain a bit in more detail.

In the scenario I mentioned, at the first iteration of the loop, 'first' will
be the first control object, which has ->repeat unset.  The object will be
removed from the list.  In the second iteration of the loop, it handles the
second object, which has ->repeat set.  The object is added to the list again.
In the third iteration, the loop runs for the second object again.  Because it
is not same to 'first', the 'break' statement is not reached.  The loop
continues forever.

Am I missing something?


Thanks,
SJ

[...]
