Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15F24DCEB
	for <damon@lists.linux.dev>; Thu,  1 Jan 2026 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767236315; cv=none; b=mCNCJlP2q44p4Vfqt0CY7sfRrjQ/eyiboy06O8DSlMGJt1vE3xeveLbWdwUZ+2/Ur0SnUTJvbGa9wp8SkzBMepxiLXp9ksSXczYS8q1SryvbeJFuTbDjbhYWPbEL8hKV766pLeb8hJtc3qXSSbkzaCWq066imyFwO+qpSVc/dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767236315; c=relaxed/simple;
	bh=m75hsT8RWIPq7UtpZnmnezUHE9721/YA2vWe47dXprc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHQQtZ0IWyu4tSOhoFJ1BvuT1WdnQhCUJ7jHPdvzfs+9snYqXoREACZUmGaUf9Gz/mseh8k5HQ5WxtruxXOOD3LlELyRAs5MevDqDZBmHcCjnwCFgxp9q7pAqHCtOKobNUuoDPXYImbtokOyKWpuC8R1RINT2lA2ldbjNl8raUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWPhBV8q; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWPhBV8q"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78d6a3c3b77so117849587b3.0
        for <damon@lists.linux.dev>; Wed, 31 Dec 2025 18:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767236313; x=1767841113; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9qPVyC1carZwgVVH75m9TaECbDsPsKfFm26AaARR8o=;
        b=FWPhBV8qAiUAhd0akUWyTYya3CURdaT8ol87jQV/35124Q/NBzK5Ut1M5LRQQ2M9wL
         oB63o7owfGsjQfaRUQnLiq7+LK5raRqEThm/APh1Ugn3kuudf/RUXQCtyy8hGcuJwwA9
         9N6+9YoHb6KXEGwnMY214UNnZ6ECIK5W3dQzntajf4z8tqX0G0gOHMujy7YwNV17oWgo
         uKbkmhulS99SR0phyBYSkKIwNsXAqHE5NrACZO7zPf83m14IrF3X1SialF6y6z+3UIUF
         X2K5ShhXWg4RviwlGxwJQxsKFN9UPDVMhgrDpPxf9xPUojkfAkqqJMLw160tCmTUu2f9
         bgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767236313; x=1767841113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9qPVyC1carZwgVVH75m9TaECbDsPsKfFm26AaARR8o=;
        b=PbBLT3weULuetk2GQETZ5PisqbDLoXx+yWplP9wFdEOERb8yFRJM0+92CS4o6+91dd
         +9un8933qdvDI96BRokCT/bUO994OxodtKZmr2RLFKPgFEdIdgRaZvY9oYUmEPdFvfUC
         moau62iue7rBcYY0ml5rNbSIibYb7luphYGGlkQwJkyihCxc+Yo7Zcue5cetqtx7EheK
         4P4x36cloJeA4Cq2C62rY7Z9oOmFmZMOTvJhtzia5Kz5zyAJQVq4H7+7b4ZbAMYJAiP/
         M2m7ipVuiocxMFFH++YYCQTKiAPGQ1EKCGnsXsvPzM8cSViYcW/y4N8dFyub+4NRLICg
         e6VA==
X-Forwarded-Encrypted: i=1; AJvYcCVImIfP6nnbtWl0yqES2VGHc6PppbTfvh6EJtYiB+vfN+/97ZdqR8vtpoeIkDtbDTFbwd+kbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH7qQEoFa0i26ewMhE53skV7LmJaILa0estxH+fU11BbMSn+Eh
	te9P2YpG8yXsCPBA083HrN4/ZSNAZQqQOf3rMkZxFy6zdhFcJPRHEMAUtr5QzyxQ5HM6oaOE6Qb
	2+cwYQbdUb5RVFwSi7JtjrCZzDKHdmNydJdQ0
X-Gm-Gg: AY/fxX4gZ7fzmYdhd/z3SY2q0Nnkaaw1NE1AVizOpGtcVrgUX0TrjQaLnh4Sl14daOQ
	uv6zIOqc93BDllmFBFu3TwaGSjxHA9DD368uHHnrC4DEGdsxO0ZqC2D1wV9Ixtf4tLrg79pYP+5
	Zq2JJiTYE6Bf/8w6N58jsiMeDggk39fTfaB3Wjoz8ISa488X5aS3FM5+rKsT4D+RhakhZROrDA5
	joLM8rFM2+8N2QU50CBNn9JISotFDIMOx5UC3MO60j3ExTJJ+3KJIYlscob1SArcMA0Nfvr
X-Google-Smtp-Source: AGHT+IEykEkaPCHD0X0I6L0ptnL+oTDQcPJEkuriAyEDUp0ZrlA4011Fv2iFVPiLKJUYRQYPeI0lIJC47Kv+zgF/GSs=
X-Received: by 2002:a53:d009:0:b0:63f:b2b3:8c2d with SMTP id
 956f58d0204a3-64663252770mr33509496d50.17.1767236313054; Wed, 31 Dec 2025
 18:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4_unsc9u4kEDBTNxfS3rsiQi5QBTaiu3fGDcGrdryyBA@mail.gmail.com>
 <20260101014107.87821-1-sj@kernel.org>
In-Reply-To: <20260101014107.87821-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 1 Jan 2026 11:58:21 +0900
X-Gm-Features: AQt7F2qk60Y9SeYysM-zJgRnvUfmjuZOg6-DbWG6PFvxlPWAHpnRRFpuE3nJJkI
Message-ID: <CAHOvCC6UEaWx=Jj+x3Mfo5HAGL+6yAnEvJCrkiLe0M2cL+3wsQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "# 6 . 14 . x" <stable@vger.kernel.org>, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Jan 2026 at 10:41, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 1 Jan 2026 09:55:56 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Thu, 1 Jan 2026 at 00:26, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Wed, 31 Dec 2025 14:27:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Wed, 31 Dec 2025 at 10:25, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > > On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > > >
> > > > > > > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > > > >
> > > > > > [...]
> > > > > > > > I will send a new version of this fix soon.
> > > > > > >
> > > > > > > So far, I got two fixup ideas.
> > > > > > >
> > > > > > > The first one is keeping the current code as is, and additionally modifying
> > > > > > > kdamond_call() to protect all call_control object accesses under
> > > > > > > ctx->call_controls_lock protection.
> > > > > > >
> > > > > > > The second one is reverting this patch, and doing the DAMON running status
> > > > > > > check before adding the damon_call_control object, but releasing the
> > > > > > > kdamond_lock after the object insertion is done.
> > > > > > >
> > > > > > > I'm in favor of the second one at the moment, as it seems more simple.
> > > > > >
> > > > > > I don't really like both approaches because those implicitly add locking rules.
> > > > > > If the first approach is taken, damon_call() callers should aware they should
> > > > > > not register callback functions that can hold call_controls_lock.  If the
> > > > > > second approach is taken, we should avoid holding kdamond_lock while holding
> > > > > > damon_call_control lock.  The second implicit rule seems easier to keep to me,
> > > > > > but I want to avoid that if possible.
> > > > > >
> > > > > > The third idea I just got is, keeping this patch as is, and moving the final
> > > > > > kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> > > > > > removes the race condition between the final kdamond_call() and
> > > > > > damon_call_handle_inactive_ctx(), without introducing new locking rules.
> > > > >
> > > > > I just posted the v2 [1] with the third idea.
> > > > >
> > > > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> > > >
> > > > I generally agree with what you've said so far.  However, it's inefficient
> > > > to continue executing damon_call_handle_inactive_ctx() while kdamond is
> > > > "off".  There's no need to add a new damon_call_handle_inactive_ctx()
> > > > function.
> > >
> > > As I mentioned before on other threads with you, we care not only efficiency
> > > but also maintainability of the code.  The inefficiency you are saying about
> > > happens only in corner cases because damon_call() is not usually called while
> > > kdamond is off.  So the gain of making this efficient is not that big.
> >
> > The overhead isn't that high, but I think it's better to keep things
> > simple.
> > I think it's better to use list_add_tail() when kdamond is "on".
> >
> > >
> > > Meanwhile, to avoid this, as I mentioned on the previous reply to the first and
> > > the second idea of the fix, we need to add locking rule, which makes the code
> > > bit difficult to maintain.
> >
> > I think it's better to solve it with the existing kdamond_call(ctx,
> > cancel=true) rather than adding the damon_call_handle_inactive_ctx().
>
> On my previous reply, I was saying I think your suggested approach is not
> making it simple but only more complicated in the next paragraph.  And I was
> again further explaining why I think so.  More specifically, the added locking
> rule, that I previously explained with the third fix idea.
>
> Your above reply is saying it is "better", without any reason.  It even not
> addressing my concern that I explained more than once.  As a result, I again
> fail at finding why you keep repeating the argument.
>
> So, let me again ask you.  Please explain.

I've already answered your question.
Please understand my lack of expressiveness.

>
> >
> > >
> > > I therefore think the v2 is a good tradeoff.
> > >
> > > > As shown below, it's better to call list_add only when kdamond
> > > > is "on" (true), and then use the existing code to end with
> > > > kdamond_call(ctx, true) when kdamond is "off."
> > > >
> > > > +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> > > > +
> > > >  /**
> > > >   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
> > > >   * @ctx:       DAMON context to call the function for.
> > > > @@ -1496,14 +1475,17 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > damon_call_control *control)
> > > >         control->canceled = false;
> > > >         INIT_LIST_HEAD(&control->list);
> > > >
> > > > -       if (damon_is_running(ctx)) {
> > > > -               mutex_lock(&ctx->call_controls_lock);
> > > > +       mutex_lock(&ctx->call_controls_lock);
> > > > +       if (ctx->kdamond) {
> > >
> > > This is wrong.  You shouldn't access ctx->kdamond without holding
> > > ctx->kdamond_lock.  Please read the comment about kdamond_lock field on damon.h
> > > file.
> >
> > That's right, I misjudged.
> > I've reorganized the code below.
>
> Your reply is not explaining how the reorganized code is solving it.  Let me
> ask you again.  Please explain.

I will explain this in the code I have summarized below.

>
> >
> > >
> > > >                 list_add_tail(&control->list, &ctx->call_controls);
> > > > -               mutex_unlock(&ctx->call_controls_lock);
> > > >         } else {
> > > > -               /* return damon_call_handle_inactive_ctx(ctx, control); */
> > > > +               mutex_unlock(&ctx->call_controls_lock);
> > > > +               if (!list_empty_careful(&ctx->call_controls))
> > > > +                       kdamond_call(ctx, true);
> > > >                 return -EINVAL;
> > > >         }
> > > > +       mutex_unlock(&ctx->call_controls_lock);
> > > > +
> > > >         if (control->repeat)
> > > >                 return 0;
> > > >         wait_for_completion(&control->completion);
> > >
> >
> > +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> > +
> >  /**
> >   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
> >   * @ctx:       DAMON context to call the function for.
> > @@ -1457,11 +1459,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > damon_call_control *control)
> >         control->canceled = false;
> >         INIT_LIST_HEAD(&control->list);
> >
> > -       mutex_lock(&ctx->call_controls_lock);
> > -       list_add_tail(&control->list, &ctx->call_controls);
> > -       mutex_unlock(&ctx->call_controls_lock);
> > -       if (!damon_is_running(ctx))
> > +       if (damon_is_running(ctx)) {
> > +               mutex_lock(&ctx->call_controls_lock);
> > +               list_add_tail(&control->list, &ctx->call_controls);
> > +               mutex_unlock(&ctx->call_controls_lock);
> > +       } else {
> > +               if (!list_empty_careful(&ctx->call_controls))
> > +                       kdamond_call(ctx, true);
> >                 return -EINVAL;
> > +       }
> >         if (control->repeat)
> >                 return 0;
> >         wait_for_completion(&control->completion);
>
> I think my previous concern that raised to your two previous approach [1,2] is
> again samely applied to the above diff.  And now you are suggesting a similar
> approach here.  Please explain and answer all questions before you move on, or
> explain why your new apprach is different from your previous one and how it
> addresses raised concerns..

The code above applies mutex and the locking method is the same.
The difference is that control->list does list_add_tail() in the "on" state in
damon_is_running(ctx).
Another difference is that when damon_is_running(ctx) is false("off"),
the existing call_controls list is cleared with kdamond_call(ctx, cancel=true).

Regarding spin_lock,
I'm sure you're familiar with spin_lock, It can apply like this:

spin_lock(&ctx->call_controls_lock);
list_add_tail(&control->list, &ctx->call_controls);
spin_unlock(&ctx->call_controls_lock);

I have expressed my opinion sufficiently,
and I believe you will make a better judgment than I.

Thanks,
JaeJoon

>
> [1] https://lore.kernel.org/20251225194959.937-1-sj@kernel.org
> [2] https://lore.kernel.org/20251226184111.254674-1-sj@kernel.org
> [3] https://lore.kernel.org/20251229151440.78818-1-sj@kernel.org
>
>
> Thanks,
> SJ
>
> [...]
