Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642833A1E7E
	for <damon@lists.linux.dev>; Thu, 25 Dec 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766692207; cv=none; b=t4V+8xVyS47UNYaZNmbEy+Fh1cU6Vm7WanEwcMddYAxPwrtemS9mAvJoftLqe2kD97uuz8d+bFTNzUJRJjzzhzwEmoUizp54U/Cbuzp0eWD2EfkU+/kM6ouMW0xMZalN898DbXZzWFY4SVVgFG3rkUyPSzX8fTTuwqBLWN+HSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766692207; c=relaxed/simple;
	bh=KOtxKlXefkAfyBN1DZ6tUsou0yWYNDQEK3ITRT5fs1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXzKe25FMYR5y23M+IAOFysCv0yNc6RxBGGx7qpCP1WhEjYobSrMsXd0vVUpWNe6AAEiPIbmDeRCfsMoHOJWepCtkp4z+E+A2IVrTU2XtUlSyr4z2XZa1kGgSUd4HSDEjNC8mtn6I8I4a3s1b/0Z744v90iK0L/TdSGY2QXWyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZUFuh0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZUFuh0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F30C4CEF1;
	Thu, 25 Dec 2025 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766692206;
	bh=KOtxKlXefkAfyBN1DZ6tUsou0yWYNDQEK3ITRT5fs1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZUFuh0SCbKl1+1Z5hciTksFvZ+TTDISB8ok7m4Th6FLuYdiSUhMC3PzuQxbwXvKr
	 Tewu2vGD3kQzdy2WL6a9dY67wGocYRvtYcp9xSaiW6TC9+j2702yT5HSNmIBtkdQH/
	 f7+vP1kDYyTijj/lRKVSR9bD1IFP4un73dhMrqrdpRHABHIevoy32vx4iltw96ZTmk
	 PIXmBri1Jyn1XWq4Na3VGSPyYVVMLtbG2B08TV2LEr0m7Kp/O+Zjm7r/CyB1zaBPlV
	 r2ntua+eEZ+XBcyPt6Jk7y6U2Ph/UHDKOqju6F+D47BpFPn5Kt4taUaeH4ThzxHZNf
	 NHI+ETeRqaG7w==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at the damon_call()
Date: Thu, 25 Dec 2025 11:49:58 -0800
Message-ID: <20251225194959.937-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4zwbiLXRTHav67GcngiVZ-5GESqkY9juLtqAfWQW1UQg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Dec 2025 11:35:33 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello JaeJoon,
> >
> > On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > >  cd /sys/kernel/mm/damon/admin
> > >  echo "off" > kdamonds/0/state
> > >
> > >  echo "commit" > kdamonds/0/state
> > >  echo "commit" > kdamonds/0/state
> > >
> > > If you repeat "commit" twice with the kdamonds/0/state set to "off"
> > > with the above command, list_add corruption error occurs as follows:
> > >
> > > 4-page vmalloc region starting at 0xffffffc600a38000 allocated at
> > > kernel_clone+0x44/0x41e
> > > ------------[ cut here ]------------
> > > list_add corruption. prev->next should be next (ffffffd6c7c5a6a8),
> > >          but was ffffffc600a3bcc8. (prev=ffffffc600a3bcc8).
> > > WARNING: lib/list_debug.c:32 at __list_add_valid_or_report+
> > > 0xd8/0xe2, CPU#0: bash/466
> > > Modules linked in: dwmac_starfive stmmac_platform stmmac pcs_xpcs phylink
> > > CPU: 0 UID: 0 PID: 466 Comm: bash Tainted: G W 6.19.0-rc2+ #1 PREEMPTLAZY
> > > Tainted: [W]=WARN
> > > Hardware name: StarFive VisionFive 2 v1.3B (DT)
> > >  epc : __list_add_valid_or_report+0xd8/0xe2
> > >  ra : __list_add_valid_or_report+0xd8/0xe2
> > >  epc : ffffffff80540bce ra : ffffffff80540bce sp : ffffffc600a3bc00
> > >  gp : ffffffff81caec40 tp : ffffffd6c036f080 t0 : 0000000000000000
> > >  t1 : 0000000000006000 t2 : 0000000000000002 s0 : ffffffc600a3bc30
> > >  s1 : ffffffc600a3bcc8 a0 : ffffffd6fbf49a40 a1 : ffffffd6c036f080
> > >  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
> > >  a5 : 0000000000000000 a6 : 0000000020000000 a7 : 0000000000000001
> > >  s2 : ffffffd6c7c5a6a8 s3 : ffffffc600a3bcc8 s4 : ffffffc600a3bcc8
> > >  s5 : ffffffd6c7c5a6b8 s6 : ffffffd6c7c5a6a8 s7 : 0000003ff3f32794
> > >  s8 : 0000002ab38c9118 s9 : 0000000000000065 s10: 0000003f823a5cb8
> > >  s11: 0000003f823264e8 t3 : 0000000000000001 t4 : 0000000000000000
> > >  t5 : 00000000fa83b2da t6 : 000000000051df90
> > > status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> > > [<ffffffff80540bce>] __list_add_valid_or_report+0xd8/0xe2
> > > [<ffffffff80255c86>] damon_call+0x52/0xe8
> > > [<ffffffff8025c9a8>] damon_sysfs_damon_call+0x60/0x8a
> > > [<ffffffff8025daf4>] state_store+0xfc/0x294
> > > [<ffffffff80dbf1fa>] kobj_attr_store+0xe/0x1a
> > > [<ffffffff802f070c>] sysfs_kf_write+0x42/0x56
> > > [<ffffffff802eef4e>] kernfs_fop_write_iter+0xf4/0x178
> > > [<ffffffff8026545c>] vfs_write+0x1b6/0x3b2
> > > [<ffffffff80265782>] ksys_write+0x52/0xbc
> > > [<ffffffff80265800>] __riscv_sys_write+0x14/0x1c
> > > [<ffffffff80ddf124>] do_trap_ecall_u+0x19c/0x26e
> > > [<ffffffff80deaa38>] handle_exception+0x150/0x15c
> > > ---[ end trace 0000000000000000 ]---
> > > -bash: echo: write error: Invalid argument
> >
> > Thank you for finding issue!
> >
> > Also appreciate for sharing your detailed reproducer.  Nevertheless, I think
> > the reproducer can be more detailed.  E.g., you could explicitly explain the
> > fact that the reproduction step should be executed only after starting DAMON
> > with the kdamond, and the kernel should run with CONFIG_lIST_HARDENED to get
> > the output from the kernel log.
> 
> Yes, as you said, I ran it under CONFIG_LIST_HARDENED=y condition.

Thank you for confirming.

> 
> >
> > >
> > > The cause of the above error is that list_add_tail() is executed
> > > repeatedly while executing damon_call(ctx, control)
> > > in damon_sysfs_damon_call().  The execution flow is summarized below:
> > >
> > > damon_sysfs_damon_call()
> > >         --> damon_call(ctx, control)
> > >                 list_add_tail(control, ctx->call_contols);
> > >                         --> /* list_add corruption error */
> > >                 if (!damon_is_running)
> > >                         return -EINVAL;
> > >
> > > If you execute damon_call() when damon_sysfs_kdamond_running() is true,
> > > you can prevent the error of duplicate execution of list_add_tail().
> >
> > The kdamond might be terminated between the damon_call() call and the
> > damon_is_running() check inside the damon_call() execution.  In the case, the
> > problem may still happen.
> >
> > The problem happens because damon_call() is not removing the damon_call_control
> > object before returning the error, right?  What about removing the object
> > before returning the error?
> 
> damon_call() is called after damon_start() --> kdamond_fn() is executed,
> This is a problem because damon_call() also occurs when kdamond is "off"
> only in damon/sysfs.  So, my first patch solved the problem, but the
> following also worked. I tested it.
> 
> And it seems better to keep the existing method of releasing
> damon_call_control.  Since the damon_call_control structure uses both
> static and kmalloc(),  it's appropriate to release it in kdamond_fn() according
> to the condition control->canceled && control->dealloc_on_cancel.
> 
> My previous suggestion regarding this:
> https://lore.kernel.org/damon/20251206224724.13832-1-rgbi3307@gmail.com/
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index babad37719b6..2ead0bb3c462 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
>   */
>  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
>  {
> +       if (!damon_is_running(ctx))
> +               return -EINVAL;
> +
>         if (!control->repeat)
>                 init_completion(&control->completion);
>         control->canceled = false;
> @@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
> damon_call_control *control)
>         mutex_lock(&ctx->call_controls_lock);
>         list_add_tail(&control->list, &ctx->call_controls);
>         mutex_unlock(&ctx->call_controls_lock);
> -       if (!damon_is_running(ctx))
> -               return -EINVAL;
>         if (control->repeat)
>                 return 0;
>         wait_for_completion(&control->completion);

Let's assume DAMON is terminated between the damon_is_running() and
list_add_tail().  In the case, the control->fn() will never be called back.  If
control->repeat is false, this function will even inifnitely wait.

I think we should keep the damon_is_running() as is, but further check if it
was terminated without handling the control object, and remove it from the list
in the case.  Like below.

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c3ae55b940cc..23d8602f5a49 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1649,6 +1649,35 @@ bool damon_is_running(struct damon_ctx *ctx)
        return running;
 }

+/*
+ * damon_call_handle_inactive_ctx() - handle DAMON call request that added to
+ *                                   an inactive context.
+ * @ctx:       The inactive DAMON context.
+ * @control:   Control variable of the call request.
+ *
+ * This function is called in a case that @control is added to @ctx but @ctx is
+ * not running (inactive).  See if @ctx handled @control or not, and cleanup
+ * @control if it was not handled.
+ *
+ * Returns 0 if @control was handled by @ctx, negative error code otherwise.
+ */
+static int damon_call_handle_inactive_ctx(
+               struct damon_ctx *ctx, struct damon_call_control *control)
+{
+       struct damon_call_control *c;
+
+       mutex_lock(&ctx->call_controls_lock);
+       list_for_each_entry(c, &ctx->call_controls, list) {
+               if (c == control) {
+                       list_del(&control->list);
+                       mutex_unlock(&ctx->call_controls_lock);
+                       return -EINVAL;
+               }
+       }
+       mutex_unlock(&ctx->call_controls_lock);
+       return 0;
+}
+
 /**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:       DAMON context to call the function for.
@@ -1679,7 +1708,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
        list_add_tail(&control->list, &ctx->call_controls);
        mutex_unlock(&ctx->call_controls_lock);
        if (!damon_is_running(ctx))
-               return -EINVAL;
+               return damon_call_handle_inactive_ctx(ctx, control);
        if (control->repeat)
                return 0;
        wait_for_completion(&control->completion);

If you don't mind, I'll post the above diff as a patch, adding a 'Reported-by:'
tag for you.

> 
> >
> > >
> > > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> >
> > Could you please also add Fixes: and Cc: stable@ ?
> 
> I don't have much experience with this, so I'm sorry,
> but could you please give me an example about this?

No problem.

Please refer to https://docs.kernel.org/process/stable-kernel-rules.html


Thanks,
SJ

[...]
