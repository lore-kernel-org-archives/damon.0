Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6C1E885A
	for <damon@lists.linux.dev>; Thu, 25 Dec 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766630147; cv=none; b=vBCvRCBEENe3tdCag0reVtc1EIk29e8AvZiSvRsFSUPv8kaYFUugaTIR4N5EnPOzAtTwDf2uv7GuW0RWrcW0qZegL4lqAgPI9yj2HkpnmiFFLpPPdhsk8a3uBkbu5Dz/MsoOyQkf2aCnHcy3ckgIiSLTM7bvAkZE1IvGpI5Zz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766630147; c=relaxed/simple;
	bh=I9CL8C47QIXmWwDCcJli4UHP8Cc82gp4SKjbxhLEJmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ3SytF1sw8YGljl6+ZTA7U7L1CW3z+f2vVbOV/TIpjibY9UqoMB+qnFvvbbs6MejEevOug/Cu4U0Xc7wmwEqCEFp/9bnd9TOQ4+biX1H9YENkD3BDuv9aDNq3YgQPPJTnDyYKn2s8C1b4Q5zgDShJHHAzugdJRod6UXXMaxb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkF6vz8b; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkF6vz8b"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-786d1658793so56268047b3.1
        for <damon@lists.linux.dev>; Wed, 24 Dec 2025 18:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766630145; x=1767234945; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k058UDgg3LCnjnLtE2FrkVFFN7BHHlc8PNQkuIVP+vA=;
        b=ZkF6vz8bNXEFO5LM0AhQuNME/KqyUJZ2XfMRYjvLd9GCl0O9dmUrBLyk2FOAWqwM8l
         /vDBZciRIi3leM+i9Sgj0wXh2hXyshg0ifwObJeiuC3MRTR2N14UCaCHPPbDu3YpvSIc
         pP0Jj/RUqNpOSZoop0yqJqIzjk3szNi9qs1Ne6o1C9rKJgyvMnWErYQrmJiWMEj/M5gq
         ZQEN6At7abf4+eOWgx5SJrBTZMKtE/1nIzeqZSl1QGfENAaP1FJ76X0x8aGJrSyIuuwD
         cKLtbn4mxUrAvX9IL4rXwWKW0LZwjSYdffWXEW0R585Rbr5tZeoS61url1UcOtDedml9
         xW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766630145; x=1767234945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k058UDgg3LCnjnLtE2FrkVFFN7BHHlc8PNQkuIVP+vA=;
        b=KlNRcQDdiLAVhWoW4su4WOGX2UC4dQ6NhcANp3EtAVn2Z8T/UyP5mFA0D1XIOvMrih
         C6ak8tCIVFld4xg6o4toZb/qtSOMr+PbC8tr3iQ1IL52OBHI2ia/hmmah02Y+0CJMcXe
         kv7ur4uAnSkhAx7pagra1yUhT9ObvxO0qnzsKct8wl6DtWfdrsCeVJlagQumzgODSoQO
         /oiUYKp4/pTKI7V6IdaciQ6//ZUX3D8OioIgCsEYCswTxz2+XMyMepRJ/NpDB6M/NCgs
         qoRh2MWt1xNj7LDYG0/GsFW5sA7FMw0LZYftOqd+SDqSN/xkKTj/PcPjuLJDKK0+5BPK
         6b8A==
X-Gm-Message-State: AOJu0YxVhNza0PGHDC53W4LAMWYdHl7AooZ944K7khqHClMK8ggFvLSi
	UeWIqNGoD6xfTPqniQI5V70PN76VQNAV06thIhyjnURp8FvMPHl6V0c0/2K6PJFlC1aW30twlzk
	lv5p4RJTA1BaYWFos1JKqfvEGjH4U4eI=
X-Gm-Gg: AY/fxX4V55jMprNe73XqmJ8yE42nfTqnv6GuMloJgzbDQMk5XswHzQ7a1TCeNhouyo2
	/lvTotg/2Vj8PEb1LrnIE5nMxJ8Otjz3jbHluSMPUeGf9aoAh1NUrH88EVxQnX7WDHoKAThk/FT
	rDRHb0tzlanQIhiJHg3ylJRhTxtjriiiI3USI6xDPD8mpJYEdJo79rZDJThTUXkmjF60KKxNS3p
	bL27lRyzKRlnb+mMFVLY1VMX+Gny0ciEE58BGIODrZ9VQd0L5AdlS7U7oWroDBV4WymdB7oFO/s
	CupstZQ=
X-Google-Smtp-Source: AGHT+IEODZJc0vqbVAwJDOlW779gyJCua0TNMgVvZw14eqfWceSCnIhnO2ONJlqeIRc/TtCmXF/8Cu1NaQboQcjJLpE=
X-Received: by 2002:a05:690c:4c04:b0:78e:3dcf:7aac with SMTP id
 00721157ae682-78fb3f4fdcfmr342775117b3.22.1766630144878; Wed, 24 Dec 2025
 18:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251224094401.20384-1-rgbi3307@gmail.com> <20251225003205.14522-1-sj@kernel.org>
In-Reply-To: <20251225003205.14522-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 25 Dec 2025 11:35:33 +0900
X-Gm-Features: AQt7F2oFkL6Fz1e8PUNo6G3DsBuv1kfHmf4SmplDmSqS-zaXm2g2R20u1oB0lGE
Message-ID: <CAHOvCC4zwbiLXRTHav67GcngiVZ-5GESqkY9juLtqAfWQW1UQg@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at
 the damon_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
>
> Hello JaeJoon,
>
> On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> >  cd /sys/kernel/mm/damon/admin
> >  echo "off" > kdamonds/0/state
> >
> >  echo "commit" > kdamonds/0/state
> >  echo "commit" > kdamonds/0/state
> >
> > If you repeat "commit" twice with the kdamonds/0/state set to "off"
> > with the above command, list_add corruption error occurs as follows:
> >
> > 4-page vmalloc region starting at 0xffffffc600a38000 allocated at
> > kernel_clone+0x44/0x41e
> > ------------[ cut here ]------------
> > list_add corruption. prev->next should be next (ffffffd6c7c5a6a8),
> >          but was ffffffc600a3bcc8. (prev=ffffffc600a3bcc8).
> > WARNING: lib/list_debug.c:32 at __list_add_valid_or_report+
> > 0xd8/0xe2, CPU#0: bash/466
> > Modules linked in: dwmac_starfive stmmac_platform stmmac pcs_xpcs phylink
> > CPU: 0 UID: 0 PID: 466 Comm: bash Tainted: G W 6.19.0-rc2+ #1 PREEMPTLAZY
> > Tainted: [W]=WARN
> > Hardware name: StarFive VisionFive 2 v1.3B (DT)
> >  epc : __list_add_valid_or_report+0xd8/0xe2
> >  ra : __list_add_valid_or_report+0xd8/0xe2
> >  epc : ffffffff80540bce ra : ffffffff80540bce sp : ffffffc600a3bc00
> >  gp : ffffffff81caec40 tp : ffffffd6c036f080 t0 : 0000000000000000
> >  t1 : 0000000000006000 t2 : 0000000000000002 s0 : ffffffc600a3bc30
> >  s1 : ffffffc600a3bcc8 a0 : ffffffd6fbf49a40 a1 : ffffffd6c036f080
> >  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
> >  a5 : 0000000000000000 a6 : 0000000020000000 a7 : 0000000000000001
> >  s2 : ffffffd6c7c5a6a8 s3 : ffffffc600a3bcc8 s4 : ffffffc600a3bcc8
> >  s5 : ffffffd6c7c5a6b8 s6 : ffffffd6c7c5a6a8 s7 : 0000003ff3f32794
> >  s8 : 0000002ab38c9118 s9 : 0000000000000065 s10: 0000003f823a5cb8
> >  s11: 0000003f823264e8 t3 : 0000000000000001 t4 : 0000000000000000
> >  t5 : 00000000fa83b2da t6 : 000000000051df90
> > status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> > [<ffffffff80540bce>] __list_add_valid_or_report+0xd8/0xe2
> > [<ffffffff80255c86>] damon_call+0x52/0xe8
> > [<ffffffff8025c9a8>] damon_sysfs_damon_call+0x60/0x8a
> > [<ffffffff8025daf4>] state_store+0xfc/0x294
> > [<ffffffff80dbf1fa>] kobj_attr_store+0xe/0x1a
> > [<ffffffff802f070c>] sysfs_kf_write+0x42/0x56
> > [<ffffffff802eef4e>] kernfs_fop_write_iter+0xf4/0x178
> > [<ffffffff8026545c>] vfs_write+0x1b6/0x3b2
> > [<ffffffff80265782>] ksys_write+0x52/0xbc
> > [<ffffffff80265800>] __riscv_sys_write+0x14/0x1c
> > [<ffffffff80ddf124>] do_trap_ecall_u+0x19c/0x26e
> > [<ffffffff80deaa38>] handle_exception+0x150/0x15c
> > ---[ end trace 0000000000000000 ]---
> > -bash: echo: write error: Invalid argument
>
> Thank you for finding issue!
>
> Also appreciate for sharing your detailed reproducer.  Nevertheless, I think
> the reproducer can be more detailed.  E.g., you could explicitly explain the
> fact that the reproduction step should be executed only after starting DAMON
> with the kdamond, and the kernel should run with CONFIG_lIST_HARDENED to get
> the output from the kernel log.

Yes, as you said, I ran it under CONFIG_LIST_HARDENED=y condition.

>
> >
> > The cause of the above error is that list_add_tail() is executed
> > repeatedly while executing damon_call(ctx, control)
> > in damon_sysfs_damon_call().  The execution flow is summarized below:
> >
> > damon_sysfs_damon_call()
> >         --> damon_call(ctx, control)
> >                 list_add_tail(control, ctx->call_contols);
> >                         --> /* list_add corruption error */
> >                 if (!damon_is_running)
> >                         return -EINVAL;
> >
> > If you execute damon_call() when damon_sysfs_kdamond_running() is true,
> > you can prevent the error of duplicate execution of list_add_tail().
>
> The kdamond might be terminated between the damon_call() call and the
> damon_is_running() check inside the damon_call() execution.  In the case, the
> problem may still happen.
>
> The problem happens because damon_call() is not removing the damon_call_control
> object before returning the error, right?  What about removing the object
> before returning the error?

damon_call() is called after damon_start() --> kdamond_fn() is executed,
This is a problem because damon_call() also occurs when kdamond is "off"
only in damon/sysfs.  So, my first patch solved the problem, but the
following also worked. I tested it.

And it seems better to keep the existing method of releasing
damon_call_control.  Since the damon_call_control structure uses both
static and kmalloc(),  it's appropriate to release it in kdamond_fn() according
to the condition control->canceled && control->dealloc_on_cancel.

My previous suggestion regarding this:
https://lore.kernel.org/damon/20251206224724.13832-1-rgbi3307@gmail.com/

diff --git a/mm/damon/core.c b/mm/damon/core.c
index babad37719b6..2ead0bb3c462 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 {
+       if (!damon_is_running(ctx))
+               return -EINVAL;
+
        if (!control->repeat)
                init_completion(&control->completion);
        control->canceled = false;
@@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
damon_call_control *control)
        mutex_lock(&ctx->call_controls_lock);
        list_add_tail(&control->list, &ctx->call_controls);
        mutex_unlock(&ctx->call_controls_lock);
-       if (!damon_is_running(ctx))
-               return -EINVAL;
        if (control->repeat)
                return 0;
        wait_for_completion(&control->completion);

>
> >
> > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
>
> Could you please also add Fixes: and Cc: stable@ ?

I don't have much experience with this, so I'm sorry,
but could you please give me an example about this?

>
>
> Thanks,
> SJ
>
> [...]
