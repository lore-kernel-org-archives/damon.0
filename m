Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C723815D
	for <damon@lists.linux.dev>; Fri, 26 Dec 2025 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715582; cv=none; b=KYhltH80qS41QJY9mM2mkAjPyzKs+1UORSkg3GE2tREhZONaXBQzApi7Tz6e0Hbo8lPY3RwgSDLqP3JV8CsDup/z1Pqtkz7y97aXO6XuVhe52p4RUCT4QN0po3pgVVaxkM81Eh2q7PRKJhnjOqAZA2Zj40mx7NeOkUv4FhLVcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715582; c=relaxed/simple;
	bh=NG9FFsJucgMhimXfl727tAJZl4k+2y0nW3Mt7ZqFxtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkMNcadQgpkKSzvBa2DiuQXo6/yfU0eDvLEHee/DnvrEBiNQwxCm87ux8NjuZL5Ye7kLrZcyQkVWdGzpceyPcIG3OtNHw6XQ6JuMeqsd7/XWpMc9a8CB+/ZVmSJ0od2o5C/1Sf9l8lSWnPyAhnzd3eV2ag+hVXlmeRTEG7e2x5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO5+vdBl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO5+vdBl"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78fb7ab7562so43251917b3.2
        for <damon@lists.linux.dev>; Thu, 25 Dec 2025 18:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766715579; x=1767320379; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7MwV7wnomdpUA3QvJZeGbNIM+Niz71u03D9NfQ2Qt4=;
        b=cO5+vdBl0hLpVz/fl9FfB+DhHseTa7BpiKUPvGbFaw4gKt1EHNvSJfGXUJi7gP9hhA
         CcI/LGoc+K7ZiJim2/HPo9sGwGLmWCOEA1ZMydeePnwtDQ4BWfV1sOzRz7ycZzCF1Lcm
         3q+4wCb8x6ZJm7u8cjMt8JtlYYqx4UzBmFJs9KYH0zaglcNeH7Ki8ZjGTC76NihSiJAT
         t79PbRzjhf88R9YAPox2emdys97OMahDIWYOT5VvVVhSblGbVvBV573sKQFPsUSztO7O
         bCTnBOI/jdgGL0hyuiKszLbNmVZ+U2KzOyCZH2b9G8gsvIRGy3j1FIbu4vK6nb4LTykT
         SR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766715579; x=1767320379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7MwV7wnomdpUA3QvJZeGbNIM+Niz71u03D9NfQ2Qt4=;
        b=Ar6uYhQlYAyjImxq5it0fDX2YG17oFxsj+2s3wEQl4J9hfCpbin004GdPm2y3UUc2Z
         l8p7GBBEe3oZ1hj0PSZR6or2pPFok0X2UNGZb36OiBUhcw42P7KsPhcsWxQdi8Bo0GXn
         iyr0SPvwciXcmaJ142vj7xbliLRLz/wZFUdvB69HfskoFJaPiCskRn8HXd9/ygFa8l80
         IQ7fRL1RwP0QdzllwkB9LXtuMSDfGAcCL19cWuhOt8ddgxrCvJOqDpbn6QRhSggmZV30
         Q1mOKUIcGcoGXoWV2rlX0/oxBXF4XAV4QdJbKnbhMpZYbIGz7YKr/2ZscGWoG/aKzo23
         5GQA==
X-Gm-Message-State: AOJu0Yyix+auHzcv2nCpERmZNZwxVV1DFQ2sAqbb2rnXQiOJLtRKsjt/
	GVoykStmaXiB+nnyHeoPVQd342g9/aaELH23nPIGR32nCeaZ+64w3uvF1QEDNS5DIcrpsfZtz9R
	GOO8FzbmU19xJEu/KpeQWGXAThjd2UrBIzT75/ng=
X-Gm-Gg: AY/fxX5xC0aI7d8pe37Nv8eRu9XMmKcwu89/HKIqqr/sarX7lSRf4lHlHDFp1QFZcJP
	b/9XhM1njquuYfia+J8F0eglMOXfBD8amFfkJyDlmuU4F+SCulvwVzzAGYKRggYtMld8hCcI6Rb
	hRTmeRWG0YWIuy00tP64FztHaN4M/Dss4cAz/W5WDoraxcDrVdGVlmQ/2jhaxrWcAgcoBwuyybh
	l9PmfcCHQZh2nftWK9Ph/Ld9hEKUR2TFaX2SxK6ABmZEZRreMB+CUimUu0jtWh+mX7CTh61
X-Google-Smtp-Source: AGHT+IH2ZFQ8GgZ8BOanNglgLtEm635duvNuVsF9Wfc8H6UNreiOxRUqdz6IgbwI87pzbFD1cL2acGM0/OKe7xcIPlc=
X-Received: by 2002:a05:690c:7409:b0:78f:ac82:51e7 with SMTP id
 00721157ae682-78fb403c2d2mr349347387b3.40.1766715579436; Thu, 25 Dec 2025
 18:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4dYGqY2pMQktBbO-NWKGE2XXeA1e+6BrP2QtsjM2Dodg@mail.gmail.com>
 <20251225200051.1069-1-sj@kernel.org>
In-Reply-To: <20251225200051.1069-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Fri, 26 Dec 2025 11:19:28 +0900
X-Gm-Features: AQt7F2pXT0e-4_oBLK6sV7pkwmAOSOx89g1eFse8oF9DsLlLzTCpYPnqVGTG6DM
Message-ID: <CAHOvCC4f2xPK_LwFoisdqr_wX-RbdW9KUq48+82CMC=5ViF=ag@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Dec 2025 at 05:01, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 25 Dec 2025 12:10:30 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Thu, 25 Dec 2025 at 10:07, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Wed, 24 Dec 2025 21:43:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > The kdamond_call() function is executed repeatedly in the kdamond_fn()
> > > > kernel thread.  The kdamond_call() function is implemented as a while loop.
> > > > Therefore, it is important to improve the list processing logic here to
> > > > ensure faster execution of control->fn().
> > >
> > > That depends on how critical the performance is, and how much complexity the
> > > optimization introduces.  I have no idea about if the performance of
> > > kdamond_call() is really important.  If you have a realistic use case that
> > > shows it, sharing it would be nice.
> >
> > This is because kdamond_call() is called repeatedly in kdamond_fn().
>
> Yes, it is repeatedly called.  But, my question is, does it impose overhead
> that great enough to make a negative impact to the real world.

I agree that the overhead is not that much since there are only a few lists
added to ctx->call_controls(CTX.head).

>
> >
> > >
> > > > For ease of explanation,
> > > > the data structure names will be abbreviated as follows:
> > > >
> > > > damon_call_control.list: C.list
> > > > ctx->call_controls: CTX.head
> > > > repeat_controls: R.head
> > > >
> > > > the execution flow of the while loop of the kdamond_call() function,
> > > >
> > > > Before modification:
> > > > Old while loop:
> > > >
> > > >         CTX.head <-----> C.list <-----> C.list <----> C.list
> > > >         ^                   |                           |
> > > >         |               if (C.repeat)            if (!C.repeat)
> > > >    restore: only one        |                           |
> > > >    list_add_tail()        list_del()                  list_del()
> > > >         |                   |                           |
> > > >         +                   |                       complete()
> > > >         R.head <------ list_add()
> > > >
> > > > To process C.repeat above, we use an additional list, repeat_controls.
> > >
> > > Your above abbreviation didn't explain what C.repeat is.  Maybe you mean
> > > 'damon_call_control.repeat'?
> >
> > Yes, that's right.
>
> Thank you for confirming.
>
> >
> > >
> > > > The process of adding C.list to repeat_controls and then restoring it back
> > > > to CTX.head is complex and inefficient.
> > >
> > > I agree.
> > >
> > > > Furthermore, there's the problem
> > > > of restoring only a single C.list to CTX.head.
> > >
> > > I had to take some time on understanding what this mean.  And it seems you are
> > > working on an old version of the tree, and therefore saying about an issue that
> > > already fixed by commit 592e5c5f8ec6 ("mm/damon/core: fix memory leak of repeat
> > > mode damon_call_control objects").
> > >
> > > Please use mm-new as a baseline of DAMON patches, unless there are special
> > > reasons.  If there are special reasons, please explicitly specify.
> >
> > This patch is based on v6.19-rc2.
> > I will continue to refer to mm-new and damon-new.
> >
> > >
> > > >
> > > > Below, repeat_controls is removed and the existing CTX.head is modified to
> > > > loop once(1st rotation).  This simplifies list processing and creates a
> > > > more efficient structure.
> > > >
> > > > Modified while loop:
> > > > Not used repeat_controls:
> > > >
> > > >         CTX.head <-----> C.list <-----> C.list <----> C.list <-------+
> > > >                             |                           |            |
> > > >                         if (C.repeat)            if (!C.repeat)      |
> > > >                             |                           |            |
> > > >                           list_del()                  list_del()     |
> > > >                             |                           |            |
> > > >                             |                       complete()       |
> > > >                             |                                        |
> > > >                           first --------> list_add_tail() -----------+
> > > >
> > > >         if (C.list == first) break;
> > > >
> > > > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > > > ---
> > > >  mm/damon/core.c | 37 +++++++++++++++++++------------------
> > > >  1 file changed, 19 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > index 824aa8f22db3..babad37719b6 100644
> > > > --- a/mm/damon/core.c
> > > > +++ b/mm/damon/core.c
> > > > @@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
> > > >   */
> > > >  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
> > > >  {
> > > > -     struct damon_call_control *control;
> > > > -     LIST_HEAD(repeat_controls);
> > > > -     int ret = 0;
> > > > +     struct damon_call_control *control, *first = NULL;
> > > > +     unsigned int idx = 0;
> > > >
> > > >       while (true) {
> > > >               mutex_lock(&ctx->call_controls_lock);
> > > >               control = list_first_entry_or_null(&ctx->call_controls,
> > > >                               struct damon_call_control, list);
> > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > -             if (!control)
> > > > +
> > > > +             /* check control empty or 1st rotation */
> > > > +             if (!control || control == first)
> > > >                       break;
> > > > -             if (cancel) {
> > > > +
> > > > +             if (++idx == 1)
> > > > +                     first = control;
> > > > +
> > > > +             if (cancel)
> > > >                       control->canceled = true;
> > > > -             } else {
> > > > -                     ret = control->fn(control->data);
> > > > -                     control->return_code = ret;
> > > > -             }
> > > > +             else
> > > > +                     control->return_code = control->fn(control->data);
> > > > +
> > > >               mutex_lock(&ctx->call_controls_lock);
> > > >               list_del(&control->list);
> > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > +
> > > >               if (!control->repeat) {
> > > > +                     /* run control->fn() one time */
> > > >                       complete(&control->completion);
> > > >               } else if (control->canceled && control->dealloc_on_cancel) {
> > > >                       kfree(control);
> > > > -                     continue;
> > > >               } else {
> > > > -                     list_add(&control->list, &repeat_controls);
> > > > +                     /* to repeat next time */
> > > > +                     mutex_lock(&ctx->call_controls_lock);
> > > > +                     list_add_tail(&control->list, &ctx->call_controls);
> > > > +                     mutex_unlock(&ctx->call_controls_lock);
> > > >               }
> > > >       }
> > >
> > > Let's suppose there are two damon_call_control objects on the
> > > ctx->call_controls.  The first one has ->repeat unset, while the second one
> > > has.  Then, it seems the 'break' condition will never met and therefore this
> > > loop will never finished.  Am I missing something?
> >
> > You misjudged.
> > If (!C.repeat), it will be removed with list_del() and disappear.
> > If (C.repeat) loops through the loop once, and when it returns to the
> > first, it breaks.
>
> Maybe my explanation was not enough.  Let me explain a bit in more detail.
>
> In the scenario I mentioned, at the first iteration of the loop, 'first' will
> be the first control object, which has ->repeat unset.  The object will be
> removed from the list.  In the second iteration of the loop, it handles the
> second object, which has ->repeat set.  The object is added to the list again.
> In the third iteration, the loop runs for the second object again.  Because it
> is not same to 'first', the 'break' statement is not reached.  The loop
> continues forever.
>
> Am I missing something?

Thank you for your detailed review.
There may be cases where C->repeat=false is the first control.
This can also be solved simply as follows:

@@ -2567,9 +2599,6 @@ static void kdamond_call(struct damon_ctx *ctx,
bool cancel)
                if (!control || control == first)
                        break;

-               if (++idx == 1)
-                       first = control;
-
                if (cancel)
                        control->canceled = true;
                else
@@ -2589,6 +2618,8 @@ static void kdamond_call(struct damon_ctx *ctx,
bool cancel)
                        mutex_lock(&ctx->call_controls_lock);
                        list_add_tail(&control->list, &ctx->call_controls);
                        mutex_unlock(&ctx->call_controls_lock);
+                       if (++idx == 1)
+                               first = control;
                }
        }
 }

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
