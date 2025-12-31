Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35C30B525
	for <damon@lists.linux.dev>; Wed, 31 Dec 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161426; cv=none; b=nIjdyxnJYH+H//B2o6LEuz/y5z3DjYgwjp/XzKYITcQzWU8bmN/Le06XfaebgbgOnEzOOW9lYkbt/APWQbqAef3V2MuBWz2yZ9wgbm7wO4hcsaAGTmZT7onSwgHG+KGAEa0O4p4ETZZk3ckQAzzbLiNEmLvAxDB0VpCuxHamT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161426; c=relaxed/simple;
	bh=hWfZsyZ2l6YbJYR+z8l86A15hxWyl1DJydbIXt4wEDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQLiYAX9I6aO+w9N5W2Ci6kXAbUAVlI4vjyXT3E+A5t+5XBGs35nATnHThH7LA8li8O5S+Dnx1+pI+GVQbIVPkmIzVErrbzA8LTBX6CSMmaGKLzXulo6QZz/w+spBWg5Nn/ikpyhbCtluV8fCquQQjudxRjBQQqt8Vs3rzHuyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evkgv7Wu; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evkgv7Wu"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso5961615d50.1
        for <damon@lists.linux.dev>; Tue, 30 Dec 2025 22:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767161424; x=1767766224; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9r9q/HW6R05VC9wcqM8cgSL8izLlZTtlEdqX2u0aDRE=;
        b=evkgv7Wu240onDqzP/pE3ISmWf0J8ek6BVStcAlZ9Fo7PgSdLQqmoIc4tAr67ExnuZ
         GhjaxdVyAn+bYBmyd0o0AwYGe2d77TlRBF269hytMeZDouMBadEZxae5B1kEct24Cu72
         LHu5AYVMohyBAaXam54E6vGqZ2PIZA/bW9DRJK1QJjnygNfaXaE1LUlmE7Z9HGWU7eYk
         k3xWewm0fckOc/ZAdBw76q2rOHUwQa56cdybMj8Qdlg2u/mwUKobiw9f60XRB0Cu9XlU
         rE3ofEFd3O1lOep+JTSEG/u3g+a9cFTC132dpOaY5SExNOBmwKGi1h9FiOubDclPjuEj
         AbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767161424; x=1767766224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r9q/HW6R05VC9wcqM8cgSL8izLlZTtlEdqX2u0aDRE=;
        b=iDsx0KiwiP+pLE54SfRKMRuQZLx6lYyyjEiFjS9efuYsnz/1t2x8VZ1GnXXlt3yoFh
         Q0LMqjsYf+g0eYH4RH1ExIOyH4ScpgNk3y2MVR41h5mXk1TDhQkgYbZXuZYDTDMpPVtD
         N1VdkxgRSzZdTPERrP4hLHICICOmN0ZYmVCossqvMM3f/AF0MLGf8O3JqHCpNYl9brf0
         SB8+2r1v9dmJfJkULQgFARrfhfQr1NdMaruE0Yj4vcypWpbEnwAhvzcTNWnJi+B1ALpR
         w6CZMK5nEa7X/eir7ZXd1RaGjirf7oZYSU1pDJm9JhFw+jAsv3V2uXphqRQn6wJVhqHZ
         vUmw==
X-Forwarded-Encrypted: i=1; AJvYcCVF7reIe6IzgQXYiZH2YdfeoevY95m5tZLX4fMvC+shUBy96QfZkTzZV7YQgNx//YeWcTY6nw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9AS9YMP4LkThaVOZGJphJTZbB+29e2ysNKKg3zmb+hBlGLOZO
	p+CE6FH4yXD1HcwxOt/kpYC4dImckobw1ELvCS39N1VeaXLPpSeCpkiGEgIJ9WN7Fkjup4zPJ5K
	TDPdDYukjO77hmhfhmyfmO9PwjMJ03gw=
X-Gm-Gg: AY/fxX5vOKb8m80dQUxkVfqqoKI2h9DNcMExiLCn9HcFSP3IBeD6EUZXTF8+ucHQ4aG
	6aNK8/IjSfpF1PPbw4fdiYSx5RRYHQU8nQy/BYj1zxsHr7cr2GCwEWadry7z1NrpZl4GI1Ydb+m
	R2EXtuS6dqUDPapInknQ7EQHPXlDo42M9H7XrS7rVzCjkUDKut3LQB6zoIKJjAowHgXC6yf7QGg
	c998MNk0+EJ7QAcnSQp2YSQu1DE4bSleV77KWg+Afdu8MDrGHMV7dJXuHwttFaP77MdO8DM
X-Google-Smtp-Source: AGHT+IG3CiE4VfA0kxmBTa3Oj/2sOXVFrfx5YN7l9eOI8MZ7NTP4vC6JxNH8znKQ52+tXTwUuMXTKsNTq76opOCbBFA=
X-Received: by 2002:a05:690e:1206:b0:646:5019:f3e3 with SMTP id
 956f58d0204a3-6466a9239f4mr29417133d50.82.1767161424034; Tue, 30 Dec 2025
 22:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4FhpLrknhvWbDd=cxaLUyxHFkFxBDYSC3waeg4FC+TBg@mail.gmail.com>
 <20251231045948.77624-1-sj@kernel.org>
In-Reply-To: <20251231045948.77624-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 31 Dec 2025 15:10:12 +0900
X-Gm-Features: AQt7F2oFtMzI2nAuWyTmZjvN-XE_TbFocFsLbq-V6IK2ZfYmXD_WPSMToo047ZY
Message-ID: <CAHOvCC6ZPyi=tMK9YhcuWPEzdnTje1ADCWzhs7uJCwHh3SMHpg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
To: SeongJae Park <sj@kernel.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>, akpm@linux-foundation.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangkefeng.wang@huawei.com, artem.kuzin@huawei.com, 
	stepanov.anatoly@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Dec 2025 at 13:59, SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Hello Asier,
> > >
> > >
> > > Thank you for sending this patch!
> > >
> > > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> > >
> > > > This is a minor patch set for a call_controls_lock synchronization improvement.
> > >
> > > Please break description lines to not exceed 75 characters per line.
> > >
> > > >
> > > > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > > > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> > >
> > > But call_controls_lock is not being used on performance critical part.
> > > Actually, most of DAMON code is not performance critical.  I really appreciate
> > > your patch, but I have to say I don't think this change is really needed now.
> > > Please let me know if I'm missing something.
> >
> > Paradoxically, when it comes to locking, spin_lock is better than
> > mutex_lock
> > because "most of DAMON code is not performance critical."
> >
> > DAMON code only accesses the ctx belonging to kdamond itself. For
> > example:
> > kdamond.0 --> ctx.0
> > kdamond.1 --> ctx.1
> > kdamond.2 --> ctx.2
> > kdamond.# --> ctx.#
> >
> > There is no cross-approach as shown below:
> > kdamond.0 --> ctx.1
> > kdamond.1 --> ctx.2
> > kdamond.2 --> ctx.0
> >
> > Only the data belonging to kdamond needs to be resolved for concurrent access.
> > most DAMON code needs to lock/unlock briefly when add/del linked
> > lists,
> > so spin_lock is effective.
>
> I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
> locking usages.
>
> > If you handle it with a mutex, it becomes
> > more
> > complicated because the rescheduling occurs as a context switch occurs
> > inside the kernel.
>
> Can you please elaborate what kind of complexities you are saying about?
> Adding some examples would be nice.
>
> > Moreover, since the call_controls_lock that is
> > currently
> > being raised as a problem only occurs in two places, the kdamon_call()
> > loop
> > and the damon_call() function, it is effective to handle it with a
> > spin_lock
> > as shown below.
> >
> > @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > damon_call_control *control)
> >         control->canceled = false;
> >         INIT_LIST_HEAD(&control->list);
> >
> > -       mutex_lock(&ctx->call_controls_lock);
> > +       spin_lock(&ctx->call_controls_lock);
> > +       /* damon_is_running */
> >         if (ctx->kdamond) {
> >                 list_add_tail(&control->list, &ctx->call_controls);
> >         } else {
> > -               mutex_unlock(&ctx->call_controls_lock);
> > +               spin_unlock(&ctx->call_controls_lock);
> >                 return -EINVAL;
> >         }
> > -       mutex_unlock(&ctx->call_controls_lock);
> > +       spin_unlock(&ctx->call_controls_lock);
> >
> >         if (control->repeat)
> >                 return 0;
>
> Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
> Can you please elaborate why you think so?
>
> [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
>

The above code works fine with spin_lock.  However, when booting the kernel,
the spin_lock call trace from damon_call() is output as follows:
If you have any experience with the following, please share it.

[    0.834450] Call Trace:
[    0.834456] [<ffffffff8001b376>] dump_backtrace+0x1c/0x24
[    0.834471] [<ffffffff800024e0>] show_stack+0x28/0x34
[    0.834480] [<ffffffff80014f4c>] dump_stack_lvl+0x48/0x66
[    0.834493] [<ffffffff80014f7e>] dump_stack+0x14/0x1c
[    0.834503] [<ffffffff800032c6>] spin_dump+0x62/0x6e
[    0.834511] [<ffffffff80087376>] do_raw_spin_lock+0xd0/0x128
[    0.834523] [<ffffffff80de9378>] _raw_spin_lock+0x1a/0x22
[    0.834538] [<ffffffff80255c0c>] damon_call+0x38/0x100
[    0.834548] [<ffffffff8025f022>] damon_stat_start+0x10e/0x168
[    0.834558] [<ffffffff80e21ab4>] damon_stat_init+0x2a/0x44
[    0.834568] [<ffffffff800157c0>] do_one_initcall+0x40/0x202
[    0.834579] [<ffffffff80e015f6>] kernel_init_freeable+0x1fc/0x27e
[    0.834588] [<ffffffff80de0a9e>] kernel_init+0x1e/0x13c
[    0.834599] [<ffffffff8001716a>] ret_from_fork_kernel+0x10/0xf8
[    0.834607] [<ffffffff80deab22>] ret_from_fork_kernel_asm+0x16/0x18
[    0.943407] NFS: Registering the id_resolver key type
[    0.948996] Key type id_resolver registered
[    0.953614] Key type id_legacy registered

Thanks,
JaeJoon

>
> Thanks,
> SJ
>
> [...]
