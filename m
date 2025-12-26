Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2715E97
	for <damon@lists.linux.dev>; Fri, 26 Dec 2025 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766713725; cv=none; b=JIDGRs7z4lo8U4xSQYDjp+StXoCqkYsPTSbYur1/ZbTfPE6LD5izSBVQ7NUEa3ajevOekDD4kUT2n5n80N7CJXJid827tHHg0p05DeAeZY8Yg5YQ14J7oD1RCThsCbnTOKLq0GZvYwaMSnOgMEIc9gquAZ+ReuIW+gghZ5ZMxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766713725; c=relaxed/simple;
	bh=1VusNbaNgCDO/BzmKWB/nXc+ZO9dGXQkDKxreVm43i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHOoKZgV+5ViawyxK1NEsz1zcCaWaaDIJ5r6YA7zzu/oERtxJSGQdPcL9nnRr/Ozx9RE+SqbxvMdS0TdOVMKoWj91u0EDw6VjfAAjOxc3Dozg8re4QMnOVczJ5AwxLSbGgc4lRkK39JovdRHbsaf4Hb1ghSkyGU61Gofdd88Dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsUFkg8t; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsUFkg8t"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fcb465733so42321357b3.3
        for <damon@lists.linux.dev>; Thu, 25 Dec 2025 17:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766713723; x=1767318523; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0ep1z35kb4XqhwawCGHg9stDipapmGII2XgTZosfBE=;
        b=SsUFkg8t4DBRmoIbKD08uEbQeYJlxg3kXa5aeK8s1GQOAxtizx9Pa88W5mEQkduqu7
         LXYotwoNR4maMovoB457iWuR83amW0wec/qkXKhu6Cw2Ctg3Z1UafTV4fBEXJxgHD2+y
         zlHIRPvHCqxNujPVt7RBhcFtLA06csT/hCHODJ2HHKQ6zzAaNDQ/I7o1tFDymbgkyANS
         frZhgSD6i7R3NRgALIU6/TszrxrDMaZv/wR2lMIx73yrqqc+l5ehzySGyxOeqprmDdG7
         ugfZph70h7T8Z0CI7X36P/nl17Ad03g7rfweYDLa7P07dymsov+Z+4S8YPvwG8CNFg2S
         QPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766713723; x=1767318523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0ep1z35kb4XqhwawCGHg9stDipapmGII2XgTZosfBE=;
        b=bPd8N937pxNEUMAVg1jbzQ0Jlhq14h8eph2M7PSZVG/UUHFV7fE6LEVxP5mIHT4itl
         v+mmpOQT53hCBnFPs2IomieshcxlXhr3c2NFZnX9AjUYt2ngYTHim1IkVw3AE/jwnaZ5
         YK7F5tw2W/yA36431bL39IysfPUlejdiVN1jR2PQqPRWnokmpQxaJI224eHnCkfyIt7M
         AewT7aPAA1RwweVCex+Q+Ul2Vda2P3dHDf51NiaXswznr8i6s+i+ACtsosu/PyQ+Kfnf
         VXvHIolauN7F9pmcXYbsMj3GC7vtzN0d4IXg5Vypy2Z54Xl+4AqqAEJjxRDDuY7qUQrQ
         WXSw==
X-Gm-Message-State: AOJu0YyXPFkcMMA1RWhpRlz9n6eAA4wojum6gvABfurTntutMehRFeTI
	3F9EQhgbyCKQtchZ/wzXgpwl0qybbV3HESrD4LTp4ZkIHiJp/hSzv3HwhyEFcVxd47adXHPGnIg
	qHayP2ssFoTsGMwkQ7KRmCX6yk7GeIUU=
X-Gm-Gg: AY/fxX6S4zpcn5b6+wQSgQiwvEChnNxWpvPchVeBKPMF8fq2QWk+u7fTa7v5bQk5Rad
	gHrgUEtlJD1djhMx/hdA7na2Oac1nIcJ2SyoV59VQkCih5QvUO/mYyXw6tN4TnlZMFXW/7P0z5y
	eJWgUAxM2z9HzZ45Mtcmmr6GQUnBpnuvzCR1WXTlGQ1wSyTRvekg2QbUYwNxfYCczXP2MqE5tjs
	kJIhnJtiTXzCGoO2Mgejjpb+EQONm/8sd9LdUIRmk0moXMji9D5gJX2JOeQgaitXczXNwmN
X-Google-Smtp-Source: AGHT+IFNGh+EhBl5YKWIccHNZjnVnlz9LeE/BAUD/ku8d3EKlnra6wOjAaLjvI1k6A0RAHKbL7wcOwKeI7dwj6eJuLQ=
X-Received: by 2002:a05:690c:600e:b0:78c:5dfe:1b57 with SMTP id
 00721157ae682-78fb4144855mr191337757b3.38.1766713722643; Thu, 25 Dec 2025
 17:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4zwbiLXRTHav67GcngiVZ-5GESqkY9juLtqAfWQW1UQg@mail.gmail.com>
 <20251225194959.937-1-sj@kernel.org>
In-Reply-To: <20251225194959.937-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Fri, 26 Dec 2025 10:48:31 +0900
X-Gm-Features: AQt7F2oTYniRPCSfdt7CQ8r-hSgU5_yIqPxO-RpmUG-RrdVNJtAYkSSbx8YfbGQ
Message-ID: <CAHOvCC6PQKAK5WojmVFqBw0V-TZ+11CM_2uq4z8TxsyEu3gLVQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at
 the damon_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Dec 2025 at 04:50, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 25 Dec 2025 11:35:33 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Hello JaeJoon,
> > >
> > > On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > >  cd /sys/kernel/mm/damon/admin
> > > >  echo "off" > kdamonds/0/state
> > > >
> > > >  echo "commit" > kdamonds/0/state
> > > >  echo "commit" > kdamonds/0/state
> > > >
> > > > If you repeat "commit" twice with the kdamonds/0/state set to "off"
> > > > with the above command, list_add corruption error occurs as follows:
> > > >
> > > > 4-page vmalloc region starting at 0xffffffc600a38000 allocated at
> > > > kernel_clone+0x44/0x41e
> > > > ------------[ cut here ]------------
> > > > list_add corruption. prev->next should be next (ffffffd6c7c5a6a8),
> > > >          but was ffffffc600a3bcc8. (prev=ffffffc600a3bcc8).
> > > > WARNING: lib/list_debug.c:32 at __list_add_valid_or_report+
> > > > 0xd8/0xe2, CPU#0: bash/466
> > > > Modules linked in: dwmac_starfive stmmac_platform stmmac pcs_xpcs phylink
> > > > CPU: 0 UID: 0 PID: 466 Comm: bash Tainted: G W 6.19.0-rc2+ #1 PREEMPTLAZY
> > > > Tainted: [W]=WARN
> > > > Hardware name: StarFive VisionFive 2 v1.3B (DT)
> > > >  epc : __list_add_valid_or_report+0xd8/0xe2
> > > >  ra : __list_add_valid_or_report+0xd8/0xe2
> > > >  epc : ffffffff80540bce ra : ffffffff80540bce sp : ffffffc600a3bc00
> > > >  gp : ffffffff81caec40 tp : ffffffd6c036f080 t0 : 0000000000000000
> > > >  t1 : 0000000000006000 t2 : 0000000000000002 s0 : ffffffc600a3bc30
> > > >  s1 : ffffffc600a3bcc8 a0 : ffffffd6fbf49a40 a1 : ffffffd6c036f080
> > > >  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
> > > >  a5 : 0000000000000000 a6 : 0000000020000000 a7 : 0000000000000001
> > > >  s2 : ffffffd6c7c5a6a8 s3 : ffffffc600a3bcc8 s4 : ffffffc600a3bcc8
> > > >  s5 : ffffffd6c7c5a6b8 s6 : ffffffd6c7c5a6a8 s7 : 0000003ff3f32794
> > > >  s8 : 0000002ab38c9118 s9 : 0000000000000065 s10: 0000003f823a5cb8
> > > >  s11: 0000003f823264e8 t3 : 0000000000000001 t4 : 0000000000000000
> > > >  t5 : 00000000fa83b2da t6 : 000000000051df90
> > > > status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> > > > [<ffffffff80540bce>] __list_add_valid_or_report+0xd8/0xe2
> > > > [<ffffffff80255c86>] damon_call+0x52/0xe8
> > > > [<ffffffff8025c9a8>] damon_sysfs_damon_call+0x60/0x8a
> > > > [<ffffffff8025daf4>] state_store+0xfc/0x294
> > > > [<ffffffff80dbf1fa>] kobj_attr_store+0xe/0x1a
> > > > [<ffffffff802f070c>] sysfs_kf_write+0x42/0x56
> > > > [<ffffffff802eef4e>] kernfs_fop_write_iter+0xf4/0x178
> > > > [<ffffffff8026545c>] vfs_write+0x1b6/0x3b2
> > > > [<ffffffff80265782>] ksys_write+0x52/0xbc
> > > > [<ffffffff80265800>] __riscv_sys_write+0x14/0x1c
> > > > [<ffffffff80ddf124>] do_trap_ecall_u+0x19c/0x26e
> > > > [<ffffffff80deaa38>] handle_exception+0x150/0x15c
> > > > ---[ end trace 0000000000000000 ]---
> > > > -bash: echo: write error: Invalid argument
> > >
> > > Thank you for finding issue!
> > >
> > > Also appreciate for sharing your detailed reproducer.  Nevertheless, I think
> > > the reproducer can be more detailed.  E.g., you could explicitly explain the
> > > fact that the reproduction step should be executed only after starting DAMON
> > > with the kdamond, and the kernel should run with CONFIG_lIST_HARDENED to get
> > > the output from the kernel log.
> >
> > Yes, as you said, I ran it under CONFIG_LIST_HARDENED=y condition.
>
> Thank you for confirming.
>
> >
> > >
> > > >
> > > > The cause of the above error is that list_add_tail() is executed
> > > > repeatedly while executing damon_call(ctx, control)
> > > > in damon_sysfs_damon_call().  The execution flow is summarized below:
> > > >
> > > > damon_sysfs_damon_call()
> > > >         --> damon_call(ctx, control)
> > > >                 list_add_tail(control, ctx->call_contols);
> > > >                         --> /* list_add corruption error */
> > > >                 if (!damon_is_running)
> > > >                         return -EINVAL;
> > > >
> > > > If you execute damon_call() when damon_sysfs_kdamond_running() is true,
> > > > you can prevent the error of duplicate execution of list_add_tail().
> > >
> > > The kdamond might be terminated between the damon_call() call and the
> > > damon_is_running() check inside the damon_call() execution.  In the case, the
> > > problem may still happen.
> > >
> > > The problem happens because damon_call() is not removing the damon_call_control
> > > object before returning the error, right?  What about removing the object
> > > before returning the error?
> >
> > damon_call() is called after damon_start() --> kdamond_fn() is executed,
> > This is a problem because damon_call() also occurs when kdamond is "off"
> > only in damon/sysfs.  So, my first patch solved the problem, but the
> > following also worked. I tested it.
> >
> > And it seems better to keep the existing method of releasing
> > damon_call_control.  Since the damon_call_control structure uses both
> > static and kmalloc(),  it's appropriate to release it in kdamond_fn() according
> > to the condition control->canceled && control->dealloc_on_cancel.
> >
> > My previous suggestion regarding this:
> > https://lore.kernel.org/damon/20251206224724.13832-1-rgbi3307@gmail.com/
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index babad37719b6..2ead0bb3c462 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
> >   */
> >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> >  {
> > +       if (!damon_is_running(ctx))
> > +               return -EINVAL;
> > +
> >         if (!control->repeat)
> >                 init_completion(&control->completion);
> >         control->canceled = false;
> > @@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
> > damon_call_control *control)
> >         mutex_lock(&ctx->call_controls_lock);
> >         list_add_tail(&control->list, &ctx->call_controls);
> >         mutex_unlock(&ctx->call_controls_lock);
> > -       if (!damon_is_running(ctx))
> > -               return -EINVAL;
> >         if (control->repeat)
> >                 return 0;
> >         wait_for_completion(&control->completion);
>
> Let's assume DAMON is terminated between the damon_is_running() and
> list_add_tail().  In the case, the control->fn() will never be called back.  If
> control->repeat is false, this function will even inifnitely wait.

As you said, there are cases where kdamond is terminated(stopped) in
damon_is_running() and list_add_tail().  It may be a very rare case, but
I missed this case.

>
> I think we should keep the damon_is_running() as is, but further check if it
> was terminated without handling the control object, and remove it from the list
> in the case.  Like below.
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c3ae55b940cc..23d8602f5a49 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1649,6 +1649,35 @@ bool damon_is_running(struct damon_ctx *ctx)
>         return running;
>  }
>
> +/*
> + * damon_call_handle_inactive_ctx() - handle DAMON call request that added to
> + *                                   an inactive context.
> + * @ctx:       The inactive DAMON context.
> + * @control:   Control variable of the call request.
> + *
> + * This function is called in a case that @control is added to @ctx but @ctx is
> + * not running (inactive).  See if @ctx handled @control or not, and cleanup
> + * @control if it was not handled.
> + *
> + * Returns 0 if @control was handled by @ctx, negative error code otherwise.
> + */
> +static int damon_call_handle_inactive_ctx(
> +               struct damon_ctx *ctx, struct damon_call_control *control)
> +{
> +       struct damon_call_control *c;
> +
> +       mutex_lock(&ctx->call_controls_lock);
> +       list_for_each_entry(c, &ctx->call_controls, list) {
> +               if (c == control) {
> +                       list_del(&control->list);
> +                       mutex_unlock(&ctx->call_controls_lock);
> +                       return -EINVAL;
> +               }
> +       }
> +       mutex_unlock(&ctx->call_controls_lock);
> +       return 0;
> +}
> +
>  /**
>   * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
>   * @ctx:       DAMON context to call the function for.
> @@ -1679,7 +1708,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
>         list_add_tail(&control->list, &ctx->call_controls);
>         mutex_unlock(&ctx->call_controls_lock);
>         if (!damon_is_running(ctx))
> -               return -EINVAL;
> +               return damon_call_handle_inactive_ctx(ctx, control);
>         if (control->repeat)
>                 return 0;
>         wait_for_completion(&control->completion);
>

However, the damon_call_handle_inactive_ctx() function is to post-process
the duplicate addition of control->list.  Rather, it is more efficient to
prevent duplicate additions in advance, as follows:
I have tested the following and it works fine.

@@ -1467,11 +1496,14 @@ int damon_call(struct damon_ctx *ctx, struct
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
+               /* return damon_call_handle_inactive_ctx(ctx, control); */
                return -EINVAL;
+       }
        if (control->repeat)
                return 0;
        wait_for_completion(&control->completion);

> If you don't mind, I'll post the above diff as a patch, adding a 'Reported-by:'
> tag for you.

'Reported-by:' is OK.  However, please check the above again.

>
> >
> > >
> > > >
> > > > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > >
> > > Could you please also add Fixes: and Cc: stable@ ?
> >
> > I don't have much experience with this, so I'm sorry,
> > but could you please give me an example about this?
>
> No problem.
>
> Please refer to https://docs.kernel.org/process/stable-kernel-rules.html

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
