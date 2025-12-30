Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA0946C
	for <damon@lists.linux.dev>; Tue, 30 Dec 2025 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767053691; cv=none; b=ntffYUiWbMaNw09QyzRHKwt8Y8XU2TJMhnyvnk5Bf0YYxGp8tTvb87Ms/QAnH4ckAMOvtrkT4O4ltyOaierNArLJsEUibUOqLFZwyl3xNhoQA5Jk9foaeEUs9omZ9yEduyWGwzvRjiIlwEEzTlrpWfwppVGI4O+jbW/ElX2PRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767053691; c=relaxed/simple;
	bh=UsAjHxHARJHmpPilxvIv46htP6iBxp3hH+ra4Xh/WV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAHPNYvDleEtcQnV/2PigFdXYL4rd/+VlvIr4GR0aSzw3uqd4TfBac/deQc2ofzdd4yKzf/+zmzmKz1Me098D+/y9tC+44gqV3vzURZgv6O6LFvDxltEENGV1ElLrtCSJ+MgDCb7ogJLIDx4n4j5YnBzwvs3ndCS2fmeJvabHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKcUnk88; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKcUnk88"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fb6c7874cso84195957b3.0
        for <damon@lists.linux.dev>; Mon, 29 Dec 2025 16:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767053689; x=1767658489; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HbsM/e9eqvn9ArPBzYyguMVBWmbdWJHQH9hQHEYPUeQ=;
        b=AKcUnk88kYX9d3IINF0y3fFVVHPm1wqnT8caQPaknaXr2vrjcxbODSlH7ThYc2sEoX
         xDe5+3uHsZwmI7cIjAGIFK6xtd3OcWWMuZHlgWYDRHtidMJ8CujvP1cRCT/QNz9FDdEG
         2risqiO+RjRH5BoKIAbp0zjxaG4jyIm9VY4HqkJ0mHH5FW+29X5N+Rsr6nZnnCSok2yw
         2e45HFMikS7zs8D9/WzEDdur1Yz6XOmInsSbSfwbKrVP41Iy3W4jdPu8z6iLHCFPGNks
         beqcPdkr2fHbH3Jg51gzeLEUjtH3JtFiLiXVDJZUQYqiS6vW1t9kfIk6sB6RtNiS5Lei
         mSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767053689; x=1767658489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbsM/e9eqvn9ArPBzYyguMVBWmbdWJHQH9hQHEYPUeQ=;
        b=nSOXZVYcjlXpGHWVnzFMHminVoxvtqmwEGK56kSoH6pqQnr42fo6bms/o0yi8XUGVZ
         cZVRenDQTghVtfhDj3qeCLuF711qjsrzfgioAKSEI/eTWVFZi0G6XiaNsyBjUE8M5r8p
         rVWDbwF93Q3it5FX0Ah/Dwt8NNzHoal/ROcmF0kHWlD2PYtMusjnA/lDtaLt9xnl2QdI
         PnFmB6/cfELIbhxEpPw7JAuU6Sk/i5mJb+oPcna4sudszpQdr3xK+SBGahsGWW7SphaE
         35T0AI/pN0rXBxqPk37A2cIy9L5x2X0vXsX1GNRYDLCFmjSog479zmTBHIULsXzpWg7q
         +rbw==
X-Gm-Message-State: AOJu0Yx+VpavOZ+9n/qgVIDCFEJoKGJIScdG71OYXxlJteae2Wk2GFvE
	d9yiaHR5X0UvcK0bG/EUZ7N+79YrGAH2dhzvU8Bqy0kImwu3hf+wvnUc/X0us+V5uMEeH1qFe87
	KpSBJp2aeQOGEv6YMojNr0F0hjT7o0JQ=
X-Gm-Gg: AY/fxX7JzqIuVZSz8+NR2mUxfi1Qdd305Lq89rMk3C3WDiKyisVOG/C1iy87wE2VKQ5
	7KbA/H8N2K6Fxc9exSRSSXOIwdXWls/DyGv8IWw/qo/ho86Kt9V+Ms8Fov7b7MJTUQmG4bYpRMv
	7oUnomA4zHg3rCUdg+MTuq1c4fKlb0WzN8wX+LmYBZOBJN4QXu2LcHaR2o6uH7nArOVY2XuLX3U
	Eg57aAeIugFmOTdxIb0QkreBJpumN2KKLL266CYEjTi2aa/4tHvllkBdzD3pcw9dy18sfie
X-Google-Smtp-Source: AGHT+IGWDE5Zp4wjstAjn/bJPigaugwDh5nqHV4zC8agPZgz4iwoP/AoWWwMZiCLso7z9MaoOtDG74GvqD3NmLEfrlU=
X-Received: by 2002:a05:690c:6c87:b0:78c:10d6:1e8b with SMTP id
 00721157ae682-78fb3f28e07mr271445467b3.26.1767053688721; Mon, 29 Dec 2025
 16:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4f2xPK_LwFoisdqr_wX-RbdW9KUq48+82CMC=5ViF=ag@mail.gmail.com>
 <20251226183122.254549-1-sj@kernel.org> <CAHOvCC6L7TAX5Pu4pLVvYBsGc7tVYexgqJmiZ7UEhu7N4_jubw@mail.gmail.com>
In-Reply-To: <CAHOvCC6L7TAX5Pu4pLVvYBsGc7tVYexgqJmiZ7UEhu7N4_jubw@mail.gmail.com>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Tue, 30 Dec 2025 09:14:37 +0900
X-Gm-Features: AQt7F2pifKyEAF_NYMZ2gSwBpLyyKdjYsBNwTOXlgNDEAHSZnzjBiki3Rp1xTEU
Message-ID: <CAHOvCC7ondk_Gjhetb7Wtsz60c1dRmt_h9MwT8uwh0vwaktDLw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

I will reflect the above in patch v2.
Would you like me to resend patch v2 ?

On Sat, 27 Dec 2025 at 08:42, JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> On Sat, 27 Dec 2025 at 03:31, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 26 Dec 2025 11:19:28 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Fri, 26 Dec 2025 at 05:01, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Thu, 25 Dec 2025 12:10:30 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > >
> > > > > On Thu, 25 Dec 2025 at 10:07, SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 24 Dec 2025 21:43:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > > > >
> > > > > > > The kdamond_call() function is executed repeatedly in the kdamond_fn()
> > > > > > > kernel thread.  The kdamond_call() function is implemented as a while loop.
> > > > > > > Therefore, it is important to improve the list processing logic here to
> > > > > > > ensure faster execution of control->fn().
> > > > > >
> > > > > > That depends on how critical the performance is, and how much complexity the
> > > > > > optimization introduces.  I have no idea about if the performance of
> > > > > > kdamond_call() is really important.  If you have a realistic use case that
> > > > > > shows it, sharing it would be nice.
> > > > >
> > > > > This is because kdamond_call() is called repeatedly in kdamond_fn().
> > > >
> > > > Yes, it is repeatedly called.  But, my question is, does it impose overhead
> > > > that great enough to make a negative impact to the real world.
> > >
> > > I agree that the overhead is not that much since there are only a few lists
> > > added to ctx->call_controls(CTX.head).
> > [...]
> > > > > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > > > > index 824aa8f22db3..babad37719b6 100644
> > > > > > > --- a/mm/damon/core.c
> > > > > > > +++ b/mm/damon/core.c
> > > > > > > @@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
> > > > > > >   */
> > > > > > >  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
> > > > > > >  {
> > > > > > > -     struct damon_call_control *control;
> > > > > > > -     LIST_HEAD(repeat_controls);
> > > > > > > -     int ret = 0;
> > > > > > > +     struct damon_call_control *control, *first = NULL;
> > > > > > > +     unsigned int idx = 0;
> > > > > > >
> > > > > > >       while (true) {
> > > > > > >               mutex_lock(&ctx->call_controls_lock);
> > > > > > >               control = list_first_entry_or_null(&ctx->call_controls,
> > > > > > >                               struct damon_call_control, list);
> > > > > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > > > > -             if (!control)
> > > > > > > +
> > > > > > > +             /* check control empty or 1st rotation */
> > > > > > > +             if (!control || control == first)
> > > > > > >                       break;
> > > > > > > -             if (cancel) {
> > > > > > > +
> > > > > > > +             if (++idx == 1)
> > > > > > > +                     first = control;
> > > > > > > +
> > > > > > > +             if (cancel)
> > > > > > >                       control->canceled = true;
> > > > > > > -             } else {
> > > > > > > -                     ret = control->fn(control->data);
> > > > > > > -                     control->return_code = ret;
> > > > > > > -             }
> > > > > > > +             else
> > > > > > > +                     control->return_code = control->fn(control->data);
> > > > > > > +
> > > > > > >               mutex_lock(&ctx->call_controls_lock);
> > > > > > >               list_del(&control->list);
> > > > > > >               mutex_unlock(&ctx->call_controls_lock);
> > > > > > > +
> > > > > > >               if (!control->repeat) {
> > > > > > > +                     /* run control->fn() one time */
> > > > > > >                       complete(&control->completion);
> > > > > > >               } else if (control->canceled && control->dealloc_on_cancel) {
> > > > > > >                       kfree(control);
> > > > > > > -                     continue;
> > > > > > >               } else {
> > > > > > > -                     list_add(&control->list, &repeat_controls);
> > > > > > > +                     /* to repeat next time */
> > > > > > > +                     mutex_lock(&ctx->call_controls_lock);
> > > > > > > +                     list_add_tail(&control->list, &ctx->call_controls);
> > > > > > > +                     mutex_unlock(&ctx->call_controls_lock);
> > > > > > >               }
> > > > > > >       }
> > > > > >
> > > > > > Let's suppose there are two damon_call_control objects on the
> > > > > > ctx->call_controls.  The first one has ->repeat unset, while the second one
> > > > > > has.  Then, it seems the 'break' condition will never met and therefore this
> > > > > > loop will never finished.  Am I missing something?
> > > > >
> > > > > You misjudged.
> > > > > If (!C.repeat), it will be removed with list_del() and disappear.
> > > > > If (C.repeat) loops through the loop once, and when it returns to the
> > > > > first, it breaks.
> > > >
> > > > Maybe my explanation was not enough.  Let me explain a bit in more detail.
> > > >
> > > > In the scenario I mentioned, at the first iteration of the loop, 'first' will
> > > > be the first control object, which has ->repeat unset.  The object will be
> > > > removed from the list.  In the second iteration of the loop, it handles the
> > > > second object, which has ->repeat set.  The object is added to the list again.
> > > > In the third iteration, the loop runs for the second object again.  Because it
> > > > is not same to 'first', the 'break' statement is not reached.  The loop
> > > > continues forever.
> > > >
> > > > Am I missing something?
> > >
> > > Thank you for your detailed review.
> > > There may be cases where C->repeat=false is the first control.
> > > This can also be solved simply as follows:
> > >
> > > @@ -2567,9 +2599,6 @@ static void kdamond_call(struct damon_ctx *ctx,
> > > bool cancel)
> > >                 if (!control || control == first)
> > >                         break;
> > >
> > > -               if (++idx == 1)
> > > -                       first = control;
> > > -
> > >                 if (cancel)
> > >                         control->canceled = true;
> > >                 else
> > > @@ -2589,6 +2618,8 @@ static void kdamond_call(struct damon_ctx *ctx,
> > > bool cancel)
> > >                         mutex_lock(&ctx->call_controls_lock);
> > >                         list_add_tail(&control->list, &ctx->call_controls);
> > >                         mutex_unlock(&ctx->call_controls_lock);
> > > +                       if (++idx == 1)
> > > +                               first = control;
> > >                 }
> > >         }
> > >  }
> >
> > Yes, that should fix the issue.
> >
> > And it seems 'idx' is being used for only this?  If I'm not wrong, I think it
> > may be easier to read if you do something like 'first = first ? first :
> > control' and drop 'idx'.
>
> It's better removing idx.
> Thanks.
> JaeJoon
>
> @@ -2587,7 +2587,6 @@ static void kdamond_usleep(unsigned long usecs)
>  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>  {
>         struct damon_call_control *control, *first = NULL;
> -       unsigned int idx = 0;
>
>         while (true) {
>                 mutex_lock(&ctx->call_controls_lock);
> @@ -2618,8 +2617,8 @@ static void kdamond_call(struct damon_ctx *ctx,
> bool cancel)
>                         mutex_lock(&ctx->call_controls_lock);
>                         list_add_tail(&control->list,
> &ctx->call_controls);
>                         mutex_unlock(&ctx->call_controls_lock);
> -                       if (++idx == 1)
> -                               first = control;
> +
> +                       first = (first) ? first : control;
>                 }
>         }
>  }
>
> >
> >
> > Thanks,
> > SJ
> >
> > [...]
