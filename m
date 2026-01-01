Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17125BEF8
	for <damon@lists.linux.dev>; Thu,  1 Jan 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767229932; cv=none; b=IH5rF759CU8q2wqf/HhSroNVAJNn4yvPDWrFEpZqaW8SJKavgPtmBljntWP8/QG4rZ9o7qKHvWwFsDH8qBx3BEYb1RLhIoQzBCKqC12Zxi8o8QrpoEq4AAGw7W/l5DiLNSMSRosz2NSEaYcJOAPn/Ov7z/Lnz2IOVX0i0Myye1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767229932; c=relaxed/simple;
	bh=kftd48ofAncyH4cisr7k3otzpyx71FhghE2cwB0bZIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGGJdJoC5lh/5XyhNVapmsbGTr0yQqKjytUC0xxaRNPKvhbUGBGWZ0XSwwgYCjEL5lHWtV9ajXFwB6hBd5CzPSPTiClBxpXySTjJZtzbd9aw/DicvmdoetevNcm0WXnAtqZ8o9Zzt8A8VqPQw/LVHH5L9A44FhIW06lSPK9Wl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvJ2l6kI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvJ2l6kI"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78fc520433aso74767807b3.1
        for <damon@lists.linux.dev>; Wed, 31 Dec 2025 17:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767229930; x=1767834730; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8+YvY8jh0MaB/P/rCzj15WPLVkdajRGID3PPob1nw4=;
        b=WvJ2l6kIGQnIxK5u5ciRURr72IyhYMnQWQG5AT0wTEpJaHb0nSWp409x5v1KB1rBNP
         o2A7pm8cQpv/6F7sBKxh2cJ3OtONTBZDqC82Bl+/qPWaBtxiNmzzU8fWX6+Tc53+/ejI
         wG68YDII4mqMmVoRpmyVVk5KWgUCq/8Y6hfyM4hHBZUPPbrBXmmZ5N3WwWX8RysS7eBi
         Pn1nBvXAzD9P2KpkGc8cK4AazbWntfNJlsAaMIKTHgab5qdU/0AxWtV7wtEC2GkiTP7n
         JvVCNbSelp+Y8EKT1df/6UG34Vum2qCUyg0JlB7rvHdGTsw2VZLlkffqF+cTIRfm37xR
         mzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767229930; x=1767834730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8+YvY8jh0MaB/P/rCzj15WPLVkdajRGID3PPob1nw4=;
        b=d0TJ2NWMAL2p0twp8T1mAW+D4KRWH4mM85IcviFQgBhTJ+86T+dj66aMtIWkdCoELg
         R9qYTAxAmgQXFwyVEZwW/qv13+H0si85vS8qf8o1E3hZpJGgY2nYWnSDE4ZZuUDvuvkv
         xwQTBmPNhlTTV0jw6garnXTxfXWY3hgCzTkPOseQkUHq8iyn+chJbFjsUowhyl64eJHN
         S7woRFBzhxH4wy07EDmqcAODUpPV1sBm0IbyTbjhE5jIfaGLNwmrDKbhD194o9uw2z7W
         SlM0MHwf1Yjs4/I0U21BLf2MLmn1j1mvau2FHaDytqtPJDZn1UXtl44DqM3BJWnbCVQD
         VdVg==
X-Forwarded-Encrypted: i=1; AJvYcCU6pjbHmWoAZN62KoAD0KG7bDePN6vU8GilhVMbyyYCSSiZsx9Yb1hzOyvgijuigzv7cGTvPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8KUQW8CJFOzq1DF8OHq9CjTOsf/LkYZ6z8xSVX9ttGT8jwMtb
	LSEIm0VfD9kpuwpVX1/ORbgV4gqqSzJBtZ3dGZauIzbOEpimykxquk6yhiKfg3IQnfjZxKnpBTH
	5QdhpUe1MhMmGXt8A1dBq1PLB+M2Ep0w=
X-Gm-Gg: AY/fxX5PhaLdcHOu3ZvlCGRshnf0Zea9VSib+QHywU9+6JuhUYg0PTEVPPnbZWi13FT
	PTXVJg3YZ9a7kJHQkv5XGKe67/zZHAwWbSSjcTWBBz6voTSGEn3J9gTM7jL9PvDpSlYNZL8wKSz
	G7QmzaZR+ub6TkmpzkF6obu2zM2AoTYp9UczQwj0W2NNS95+29SbzyheR2l1Yjtq14Rww1rPJ1p
	MPzITW7tkcp1uEfoRTFxpW/v1aAVXRkzwPheKnDb8yW4/7hBYnsH3lvWjZXWMitFQ662Zi4
X-Google-Smtp-Source: AGHT+IGCc5uZ6Q6Zr+ExY3v3MnpAaFNuiKpOrpZfNg5ZQDhkIzEhwB4cusuisLKmOh7rlI9U2s8tvivxYvYBnExHtCs=
X-Received: by 2002:a05:690e:1189:b0:63e:3011:58dc with SMTP id
 956f58d0204a3-6466a843f4amr34450374d50.20.1767229929648; Wed, 31 Dec 2025
 17:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6ZPyi=tMK9YhcuWPEzdnTje1ADCWzhs7uJCwHh3SMHpg@mail.gmail.com>
 <20251231153216.82343-1-sj@kernel.org>
In-Reply-To: <20251231153216.82343-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 1 Jan 2026 10:11:58 +0900
X-Gm-Features: AQt7F2qnT-PD4FKqqWfJZ823JyVjjLnvf35NzBoZo0u3yNRx2gXMQAYKNQHa-uY
Message-ID: <CAHOvCC6or4a5YM-byNFkB4q8v8YO=ZrT0VymYQfSXEx84wgeZw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
To: SeongJae Park <sj@kernel.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>, akpm@linux-foundation.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangkefeng.wang@huawei.com, artem.kuzin@huawei.com, 
	stepanov.anatoly@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Jan 2026 at 00:32, SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 31 Dec 2025 15:10:12 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Wed, 31 Dec 2025 at 13:59, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > Hello Asier,
> > > > >
> > > > >
> > > > > Thank you for sending this patch!
> > > > >
> > > > > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> > > > >
> > > > > > This is a minor patch set for a call_controls_lock synchronization improvement.
> > > > >
> > > > > Please break description lines to not exceed 75 characters per line.
> > > > >
> > > > > >
> > > > > > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > > > > > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> > > > >
> > > > > But call_controls_lock is not being used on performance critical part.
> > > > > Actually, most of DAMON code is not performance critical.  I really appreciate
> > > > > your patch, but I have to say I don't think this change is really needed now.
> > > > > Please let me know if I'm missing something.
> > > >
> > > > Paradoxically, when it comes to locking, spin_lock is better than
> > > > mutex_lock
> > > > because "most of DAMON code is not performance critical."
> > > >
> > > > DAMON code only accesses the ctx belonging to kdamond itself. For
> > > > example:
> > > > kdamond.0 --> ctx.0
> > > > kdamond.1 --> ctx.1
> > > > kdamond.2 --> ctx.2
> > > > kdamond.# --> ctx.#
> > > >
> > > > There is no cross-approach as shown below:
> > > > kdamond.0 --> ctx.1
> > > > kdamond.1 --> ctx.2
> > > > kdamond.2 --> ctx.0
> > > >
> > > > Only the data belonging to kdamond needs to be resolved for concurrent access.
> > > > most DAMON code needs to lock/unlock briefly when add/del linked
> > > > lists,
> > > > so spin_lock is effective.
> > >
> > > I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
> > > locking usages.
> > >
> > > > If you handle it with a mutex, it becomes
> > > > more
> > > > complicated because the rescheduling occurs as a context switch occurs
> > > > inside the kernel.
> > >
> > > Can you please elaborate what kind of complexities you are saying about?
> > > Adding some examples would be nice.
> > >
> > > > Moreover, since the call_controls_lock that is
> > > > currently
> > > > being raised as a problem only occurs in two places, the kdamon_call()
> > > > loop
> > > > and the damon_call() function, it is effective to handle it with a
> > > > spin_lock
> > > > as shown below.
> > > >
> > > > @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > damon_call_control *control)
> > > >         control->canceled = false;
> > > >         INIT_LIST_HEAD(&control->list);
> > > >
> > > > -       mutex_lock(&ctx->call_controls_lock);
> > > > +       spin_lock(&ctx->call_controls_lock);
> > > > +       /* damon_is_running */
> > > >         if (ctx->kdamond) {
> > > >                 list_add_tail(&control->list, &ctx->call_controls);
> > > >         } else {
> > > > -               mutex_unlock(&ctx->call_controls_lock);
> > > > +               spin_unlock(&ctx->call_controls_lock);
> > > >                 return -EINVAL;
> > > >         }
> > > > -       mutex_unlock(&ctx->call_controls_lock);
> > > > +       spin_unlock(&ctx->call_controls_lock);
> > > >
> > > >         if (control->repeat)
> > > >                 return 0;
> > >
> > > Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
> > > Can you please elaborate why you think so?
> > >
> > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> > >
> >
> > The above code works fine with spin_lock.  However, when booting the kernel,
> > the spin_lock call trace from damon_call() is output as follows:
> > If you have any experience with the following, please share it.
>
> Can you please reply to my questions above, first?

I have answered your above question.  And, since call_controls_lock has a
short waiting time, I think it would be a good idea to consider spin_lock.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
