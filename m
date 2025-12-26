Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A56FBF
	for <damon@lists.linux.dev>; Fri, 26 Dec 2025 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766792546; cv=none; b=QTaX0NJAWyz6t5Y1J/1iAnOeN1noA+jkU4FJbKkwnWZu2JuPryjfJjHzCAcg6/Vs4OscSnFeVjH4NAB+79zJjo1KB6fB4xbz8kSaLEUAT+KCTL0rQGJiwFslCFcMDlYo3b2D3909HOr4Mzq0rxi+H8O6OG1CwwNUy1uZruMdWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766792546; c=relaxed/simple;
	bh=+AGEuC63Ukq2CTAPd3FBLFClTzAzmPwpjjnRg4a41dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVH1vKaXgzszUxvcYxRkCr+YvinMdWrM6JNxrG4GwZI/2XJlz8m+vdgyuG8v4ibAik6KjUwXCGcQwSsVNzoB6H+UsXUn53De3cbj49WCwB0tBM3tE/zpKVXl5usQI07OSAqlaDHkIyRrn27fosq+AlTE88t2FywXjskPbCSCODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDskSAXM; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDskSAXM"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64455a2a096so6060254d50.3
        for <damon@lists.linux.dev>; Fri, 26 Dec 2025 15:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766792543; x=1767397343; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fAZppyva63DEjptZqcQdtviylUco9oD9YcVtJdE6l+o=;
        b=kDskSAXMhbLAO5RNg8I5G/RyeQbxCqnSwTqYmDiN0tQRQGgrzb0Y909kxRsv9oezNN
         DobnDAgDzJraN46A2MTVM0fyH1ZHPb5k9IiwycoP3NOt+7lkSMsFHbHT5R+Il6DJsGyp
         fvAQA0cUmA7eLEHWX95Pp/hEc66vJjLZedDJBjkgzdNghqAxGeKrOq/06ZQKcIUSLEK9
         zaxSJgj2KPbETNnb456zk84Xgd1CYdZefwxi/3b+XvBYR+MgG1El48mbwhebyvVHUq5S
         qBokbpPib1vh+KiZKfmE9XALDoV16dHqKqjRz/ZQlRMpZSTT0bg2MiJjc+WA2+8S6O5W
         Gedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766792543; x=1767397343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAZppyva63DEjptZqcQdtviylUco9oD9YcVtJdE6l+o=;
        b=p6KRUYuP6C1wpShFhyXAkEWFf6w0kbRwDxcUeTkzd6Zo54xI4XWOzhrT7h6CImC07X
         JOfTgQCFSGU/aVipKfulTcvruAbZ6BXl2WvT88t32VQWihq+MZ7ZMW7r/xHu5fcVS5Ch
         x6HJbynJoNoJhR6enDBwnEUCQT1VZlonaZtLeFl6EMtoQhVoScGxW8ZmAptrp+ZlA9SY
         6GbNbIhTnnd63ZYYlou8uOjG2BqcFlovon7kEUDUc6zQ0Bg8wQtRuHccHI9aExadP8zj
         Ca6kM3eVHgeKWbZk5oZZ4sVCq+fx/AQU5JMz1RkK1DXUURO9WJm1UEK5WEobmWt7wRbS
         yu+A==
X-Gm-Message-State: AOJu0YyBrdusvAY4GHXwhXn8DcD2fKdQrpc3X13VoMfT9izkmUp7bi9C
	kiE9yWk+C1s1lcRetDev62PEUapOD+7parFYSnziI7vNhuEYH9JZodWWijMzV89OLnkFj4kc+VH
	iit+r9ZC40wm6aHnNX266Oeyh+bZ5jHI=
X-Gm-Gg: AY/fxX75bZE+Xp0nJBEbAOIhRSKupzOmFYM3LR/+ccZbvqF4CRkJglxV9bkdvLElxBq
	giYIrUqmF50mLv63Gx7527Epk9AMAWdHsRpjgnjxVOIErm+fYs/uVhFv0KUbP/4hByCaswB+VZF
	b8Qmqofk5/IOyYn4vCoDJ0axkMggQ25lIVBho5oWDHx3s/FDeO0kJI1jEQIbKPWefjuaC7K/wfk
	/ssNCFCXIQ7CPq479RVkzf4Fk0+QQ5oclq/vrJ6SWue0VSHbEJ92zCODZwkdRYySYeza/CW
X-Google-Smtp-Source: AGHT+IHWXW3HAQ2IWb0fPDByyES6LykAonpabAqCQdmat1G1q6oNNSUa6z5qQifEQZr99TfRO77TdqFM0nr2FQzcz10=
X-Received: by 2002:a05:690c:c4ce:b0:78f:bc2b:83f5 with SMTP id
 00721157ae682-78fbc2b8fd3mr421701197b3.20.1766792543250; Fri, 26 Dec 2025
 15:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4f2xPK_LwFoisdqr_wX-RbdW9KUq48+82CMC=5ViF=ag@mail.gmail.com>
 <20251226183122.254549-1-sj@kernel.org>
In-Reply-To: <20251226183122.254549-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 27 Dec 2025 08:42:12 +0900
X-Gm-Features: AQt7F2qXA2NW8S6__pIPvLxhHe9J8Tr2XiSGV87pAHvpagp774VRSyEShoAx2fo
Message-ID: <CAHOvCC6L7TAX5Pu4pLVvYBsGc7tVYexgqJmiZ7UEhu7N4_jubw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Dec 2025 at 03:31, SeongJae Park <sj@kernel.org> wrote:
>
> On Fri, 26 Dec 2025 11:19:28 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Fri, 26 Dec 2025 at 05:01, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Thu, 25 Dec 2025 12:10:30 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Thu, 25 Dec 2025 at 10:07, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > On Wed, 24 Dec 2025 21:43:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > > >
> > > > > > The kdamond_call() function is executed repeatedly in the kdamond_fn()
> > > > > > kernel thread.  The kdamond_call() function is implemented as a while loop.
> > > > > > Therefore, it is important to improve the list processing logic here to
> > > > > > ensure faster execution of control->fn().
> > > > >
> > > > > That depends on how critical the performance is, and how much complexity the
> > > > > optimization introduces.  I have no idea about if the performance of
> > > > > kdamond_call() is really important.  If you have a realistic use case that
> > > > > shows it, sharing it would be nice.
> > > >
> > > > This is because kdamond_call() is called repeatedly in kdamond_fn().
> > >
> > > Yes, it is repeatedly called.  But, my question is, does it impose overhead
> > > that great enough to make a negative impact to the real world.
> >
> > I agree that the overhead is not that much since there are only a few lists
> > added to ctx->call_controls(CTX.head).
> [...]
> > > > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > > > index 824aa8f22db3..babad37719b6 100644
> > > > > > --- a/mm/damon/core.c
> > > > > > +++ b/mm/damon/core.c
> > > > > > @@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
> > > > > >   */
> > > > > >  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
> > > > > >  {
> > > > > > -     struct damon_call_control *control;
> > > > > > -     LIST_HEAD(repeat_controls);
> > > > > > -     int ret = 0;
> > > > > > +     struct damon_call_control *control, *first = NULL;
> > > > > > +     unsigned int idx = 0;
> > > > > >
> > > > > >       while (true) {
> > > > > >               mutex_lock(&ctx->call_controls_lock);
> > > > > >               control = list_first_entry_or_null(&ctx->call_controls,
> > > > > >                               struct damon_call_control, list);
> > > > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > > > -             if (!control)
> > > > > > +
> > > > > > +             /* check control empty or 1st rotation */
> > > > > > +             if (!control || control == first)
> > > > > >                       break;
> > > > > > -             if (cancel) {
> > > > > > +
> > > > > > +             if (++idx == 1)
> > > > > > +                     first = control;
> > > > > > +
> > > > > > +             if (cancel)
> > > > > >                       control->canceled = true;
> > > > > > -             } else {
> > > > > > -                     ret = control->fn(control->data);
> > > > > > -                     control->return_code = ret;
> > > > > > -             }
> > > > > > +             else
> > > > > > +                     control->return_code = control->fn(control->data);
> > > > > > +
> > > > > >               mutex_lock(&ctx->call_controls_lock);
> > > > > >               list_del(&control->list);
> > > > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > > > +
> > > > > >               if (!control->repeat) {
> > > > > > +                     /* run control->fn() one time */
> > > > > >                       complete(&control->completion);
> > > > > >               } else if (control->canceled && control->dealloc_on_cancel) {
> > > > > >                       kfree(control);
> > > > > > -                     continue;
> > > > > >               } else {
> > > > > > -                     list_add(&control->list, &repeat_controls);
> > > > > > +                     /* to repeat next time */
> > > > > > +                     mutex_lock(&ctx->call_controls_lock);
> > > > > > +                     list_add_tail(&control->list, &ctx->call_controls);
> > > > > > +                     mutex_unlock(&ctx->call_controls_lock);
> > > > > >               }
> > > > > >       }
> > > > >
> > > > > Let's suppose there are two damon_call_control objects on the
> > > > > ctx->call_controls.  The first one has ->repeat unset, while the second one
> > > > > has.  Then, it seems the 'break' condition will never met and therefore this
> > > > > loop will never finished.  Am I missing something?
> > > >
> > > > You misjudged.
> > > > If (!C.repeat), it will be removed with list_del() and disappear.
> > > > If (C.repeat) loops through the loop once, and when it returns to the
> > > > first, it breaks.
> > >
> > > Maybe my explanation was not enough.  Let me explain a bit in more detail.
> > >
> > > In the scenario I mentioned, at the first iteration of the loop, 'first' will
> > > be the first control object, which has ->repeat unset.  The object will be
> > > removed from the list.  In the second iteration of the loop, it handles the
> > > second object, which has ->repeat set.  The object is added to the list again.
> > > In the third iteration, the loop runs for the second object again.  Because it
> > > is not same to 'first', the 'break' statement is not reached.  The loop
> > > continues forever.
> > >
> > > Am I missing something?
> >
> > Thank you for your detailed review.
> > There may be cases where C->repeat=false is the first control.
> > This can also be solved simply as follows:
> >
> > @@ -2567,9 +2599,6 @@ static void kdamond_call(struct damon_ctx *ctx,
> > bool cancel)
> >                 if (!control || control == first)
> >                         break;
> >
> > -               if (++idx == 1)
> > -                       first = control;
> > -
> >                 if (cancel)
> >                         control->canceled = true;
> >                 else
> > @@ -2589,6 +2618,8 @@ static void kdamond_call(struct damon_ctx *ctx,
> > bool cancel)
> >                         mutex_lock(&ctx->call_controls_lock);
> >                         list_add_tail(&control->list, &ctx->call_controls);
> >                         mutex_unlock(&ctx->call_controls_lock);
> > +                       if (++idx == 1)
> > +                               first = control;
> >                 }
> >         }
> >  }
>
> Yes, that should fix the issue.
>
> And it seems 'idx' is being used for only this?  If I'm not wrong, I think it
> may be easier to read if you do something like 'first = first ? first :
> control' and drop 'idx'.

It's better removing idx.
Thanks.
JaeJoon

@@ -2587,7 +2587,6 @@ static void kdamond_usleep(unsigned long usecs)
 static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 {
        struct damon_call_control *control, *first = NULL;
-       unsigned int idx = 0;

        while (true) {
                mutex_lock(&ctx->call_controls_lock);
@@ -2618,8 +2617,8 @@ static void kdamond_call(struct damon_ctx *ctx,
bool cancel)
                        mutex_lock(&ctx->call_controls_lock);
                        list_add_tail(&control->list,
&ctx->call_controls);
                        mutex_unlock(&ctx->call_controls_lock);
-                       if (++idx == 1)
-                               first = control;
+
+                       first = (first) ? first : control;
                }
        }
 }

>
>
> Thanks,
> SJ
>
> [...]
