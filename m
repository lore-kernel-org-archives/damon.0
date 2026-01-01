Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93350276
	for <damon@lists.linux.dev>; Thu,  1 Jan 2026 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767228970; cv=none; b=Q4MJrwWxB0TcVRQoz9VMLuSlAunxjreC0hgMGNPZJJrBqyrJB3jfcu6Np9dBEDIJQeOGdaDy4bb8N/RJF/XR4tNUhO2HqypcYg247No87QQ/VUaXXeLFSPPnSlAAeX/vgEYzMIS2ddI3a93Yuqr+PLJUDXU7p0XxKuH1+PoFK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767228970; c=relaxed/simple;
	bh=AI8Q41tZLS4pcS5kEI2gnLpufrVEd3XmkAkQJu569Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpYvJg2nhKLkHTyneJ+tULFBRbTColTLUzBlX9x6oKuIKgY0g1uBsbeJ3z+U7ijZ97YYwR0Tk4RZA/aPDiAmcZhTe1XsSKIndvuhf9pKfFgV3+RZP0/qLC0BBh8zCddihih0tm6+xFp5iR/Zau4rrkbftwK02npAeQIz6NBsx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/uSPNFC; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/uSPNFC"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78f89501423so126552827b3.1
        for <damon@lists.linux.dev>; Wed, 31 Dec 2025 16:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767228968; x=1767833768; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pyNFHU4ughVI0kV2KMWlLZk3LMIAUnwijKyFOE7M0sE=;
        b=H/uSPNFC54qr384sHIcjCt+/GYNMX3kV8xFhr1zPUOohtoZTJDlOiok9fkIkP5G8qG
         sLqWmFqPpSLEp/UW4siTL99moqZKccNhBYKMIlsjeUxsaNvAQYcQL06FjDbYrZojhTAI
         bCsSH5tX66wqtf+SsFAuqrU6PIUz23xHLOhMOjKKA2PD919bZxTzdpQrhoEunUMqA5KA
         y1cxefKvCet9n17FMfiNHS92HJ7uOsOafZFHJW6VNvxEOJpoUrvhjIYfEGFQWYqf7tNY
         XJEkqQlhswxVavzZH8lYopQ2U4tBVZGNWtfkbGlknhmN7xL3DZ+UsVcd7II92sfZ6/Wu
         CI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767228968; x=1767833768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyNFHU4ughVI0kV2KMWlLZk3LMIAUnwijKyFOE7M0sE=;
        b=im9Gl+N5pqMzjin3eJPbfGyklQv232eeLovV7PXyHrl2tatTtUdaTTF/D00eY0oE4y
         042PZIZ7odPX2KhHgJ3U7BbYtA7tHELqb6uCNY4Sa2kcvuxuUHskYpj/Lkjz8TgwGcSa
         QbtXK66wWlHPkXAi/cSF3aSL+lZky+j09MISOtFx4UrnUcTX+GVHm18AjtnVjTb+7/pC
         /kVEf5L1yzfAMLKMBdRtEMV1/jJZJGAvRAM7rrdbGxmID2QxkiWmI0i32pMHB67LsXFz
         X27NXXwLkDFNODRvBDy3JODKPgrw1FzOAP4U02iVG0+7BxfMRHgKlM0Dm/BLSISaLp54
         8LFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM5IusTwjjTRlj7+GClNYVKjTVn+fX7IV86IQp3MM6u26Ihqi+4/rwznA+WIRmQ3KzygvinQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF40QkhJamtvJMsMhYClXABDcbm/+6uHz3OTQJ5JCLAWB1LbFo
	//62F1qwQBIKAJYAAK8QxtW0JZ+mcktiHyI5giuGnDz9mola8jJsNj2wP7xFDe3ZAXL9LHdEKhO
	PU9wLNUlaFXnWg1uf3a8e3BcU1jaOGIA=
X-Gm-Gg: AY/fxX4D8w0MZj9Bb7h+CyO0iTbwi9ICRnkVWSKfmqifPI8e7cULQnDfvh7zWI3lRuA
	gwWfom4+GTqyrlZXR85D/cPH9546Nh68zIdU4yLF3lglIhLVl+ZCz+08acNPW246JNXAe1MnvBS
	5anqL4wl+oG+eYrCVOvGGQwWelNUMck5agaEHFbSpaysfq1p7t6SQ/nUbt0ipTy1AIbn7WF6AB8
	6/Ok06jeL5Z7sTyjiQpWeIymKlPJCySLcodKMkRxW5GgLaUFt0l9NIZrvvU1r4OKnFZ5540
X-Google-Smtp-Source: AGHT+IFJClY5cvw4t2ao24FSwxCQPmReOjoGPKIaWPe4wwUUqq+ToMWXrNF7UTqHic2eYD1gI6W3btX1uZ28DHWmf3Q=
X-Received: by 2002:a05:690e:e85:b0:646:7b7c:2faf with SMTP id
 956f58d0204a3-6467b7c3083mr28119251d50.20.1767228967798; Wed, 31 Dec 2025
 16:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6F5zLnBF=v7G5k1WdDZZmkBAK94ixzLiPF0W53wdtyeA@mail.gmail.com>
 <20251231152617.82118-1-sj@kernel.org>
In-Reply-To: <20251231152617.82118-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 1 Jan 2026 09:55:56 +0900
X-Gm-Features: AQt7F2oDGlk4DOh69AZQt05dl7jK2z1FaYePTiI_hMVFnytUE4ig0iBuv4p53UE
Message-ID: <CAHOvCC4_unsc9u4kEDBTNxfS3rsiQi5QBTaiu3fGDcGrdryyBA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "# 6 . 14 . x" <stable@vger.kernel.org>, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Jan 2026 at 00:26, SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 31 Dec 2025 14:27:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Wed, 31 Dec 2025 at 10:25, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > > On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > [...]
> > > > > > I will send a new version of this fix soon.
> > > > >
> > > > > So far, I got two fixup ideas.
> > > > >
> > > > > The first one is keeping the current code as is, and additionally modifying
> > > > > kdamond_call() to protect all call_control object accesses under
> > > > > ctx->call_controls_lock protection.
> > > > >
> > > > > The second one is reverting this patch, and doing the DAMON running status
> > > > > check before adding the damon_call_control object, but releasing the
> > > > > kdamond_lock after the object insertion is done.
> > > > >
> > > > > I'm in favor of the second one at the moment, as it seems more simple.
> > > >
> > > > I don't really like both approaches because those implicitly add locking rules.
> > > > If the first approach is taken, damon_call() callers should aware they should
> > > > not register callback functions that can hold call_controls_lock.  If the
> > > > second approach is taken, we should avoid holding kdamond_lock while holding
> > > > damon_call_control lock.  The second implicit rule seems easier to keep to me,
> > > > but I want to avoid that if possible.
> > > >
> > > > The third idea I just got is, keeping this patch as is, and moving the final
> > > > kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> > > > removes the race condition between the final kdamond_call() and
> > > > damon_call_handle_inactive_ctx(), without introducing new locking rules.
> > >
> > > I just posted the v2 [1] with the third idea.
> > >
> > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> >
> > I generally agree with what you've said so far.  However, it's inefficient
> > to continue executing damon_call_handle_inactive_ctx() while kdamond is
> > "off".  There's no need to add a new damon_call_handle_inactive_ctx()
> > function.
>
> As I mentioned before on other threads with you, we care not only efficiency
> but also maintainability of the code.  The inefficiency you are saying about
> happens only in corner cases because damon_call() is not usually called while
> kdamond is off.  So the gain of making this efficient is not that big.

The overhead isn't that high, but I think it's better to keep things
simple.
I think it's better to use list_add_tail() when kdamond is "on".

>
> Meanwhile, to avoid this, as I mentioned on the previous reply to the first and
> the second idea of the fix, we need to add locking rule, which makes the code
> bit difficult to maintain.

I think it's better to solve it with the existing kdamond_call(ctx,
cancel=true) rather than adding the damon_call_handle_inactive_ctx().

>
> I therefore think the v2 is a good tradeoff.
>
> > As shown below, it's better to call list_add only when kdamond
> > is "on" (true), and then use the existing code to end with
> > kdamond_call(ctx, true) when kdamond is "off."
> >
> > +static void kdamond_call(struct damon_ctx *ctx, bool cancel);
> > +
> >  /**
> >   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
> >   * @ctx:       DAMON context to call the function for.
> > @@ -1496,14 +1475,17 @@ int damon_call(struct damon_ctx *ctx, struct
> > damon_call_control *control)
> >         control->canceled = false;
> >         INIT_LIST_HEAD(&control->list);
> >
> > -       if (damon_is_running(ctx)) {
> > -               mutex_lock(&ctx->call_controls_lock);
> > +       mutex_lock(&ctx->call_controls_lock);
> > +       if (ctx->kdamond) {
>
> This is wrong.  You shouldn't access ctx->kdamond without holding
> ctx->kdamond_lock.  Please read the comment about kdamond_lock field on damon.h
> file.

That's right, I misjudged.
I've reorganized the code below.

>
> >                 list_add_tail(&control->list, &ctx->call_controls);
> > -               mutex_unlock(&ctx->call_controls_lock);
> >         } else {
> > -               /* return damon_call_handle_inactive_ctx(ctx, control); */
> > +               mutex_unlock(&ctx->call_controls_lock);
> > +               if (!list_empty_careful(&ctx->call_controls))
> > +                       kdamond_call(ctx, true);
> >                 return -EINVAL;
> >         }
> > +       mutex_unlock(&ctx->call_controls_lock);
> > +
> >         if (control->repeat)
> >                 return 0;
> >         wait_for_completion(&control->completion);
>

+static void kdamond_call(struct damon_ctx *ctx, bool cancel);
+
 /**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:       DAMON context to call the function for.
@@ -1457,11 +1459,15 @@ int damon_call(struct damon_ctx *ctx, struct
damon_call_control *control)
        control->canceled = false;
        INIT_LIST_HEAD(&control->list);

-       mutex_lock(&ctx->call_controls_lock);
-       list_add_tail(&control->list, &ctx->call_controls);
-       mutex_unlock(&ctx->call_controls_lock);
-       if (!damon_is_running(ctx))
+       if (damon_is_running(ctx)) {
+               mutex_lock(&ctx->call_controls_lock);
+               list_add_tail(&control->list, &ctx->call_controls);
+               mutex_unlock(&ctx->call_controls_lock);
+       } else {
+               if (!list_empty_careful(&ctx->call_controls))
+                       kdamond_call(ctx, true);
                return -EINVAL;
+       }
        if (control->repeat)
                return 0;
        wait_for_completion(&control->completion);


Thanks,
JaeJoon

>
> Thanks,
> SJ
>
> [...]
