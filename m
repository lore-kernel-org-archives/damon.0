Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793223A9BD
	for <damon@lists.linux.dev>; Thu,  1 Jan 2026 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767229647; cv=none; b=Exx2yin+hd64PITeHyUKxzx5C7GMz1rpXTJeVW7JiNHxETNBhs8PxK5GgjVq9u2bZFaFEnYIIu8vZhvrRPFjaqaHTGwqJOmipXgm0n+DzDlDPKF1hnJZavmtFm4NL4Gh8vlp8xAbjb/fr+rPz9JriVLpXCmH/m9u9NMnssUu148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767229647; c=relaxed/simple;
	bh=w/+kUX8a/yf9L25nKIO9ALHkZgkdObA4tDU7pmNcWyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDGW1YSKjQXrLUf1RSJAXhg7RKSex6XUhct6h8x1H5lTwRk/BANZx3jBBoX6aFAQhEu2AZU/oS+ZgiMeAsWnFWyCu990j0xQIlujSkXpxwbh0WGD8UOynZI7r5x2M9VQJ+G2JrXSxs0z+GN3uM5peAmmYSOgljbBCafEZVj3MV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4KqxjPt; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4KqxjPt"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786a822e73aso99666037b3.3
        for <damon@lists.linux.dev>; Wed, 31 Dec 2025 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767229644; x=1767834444; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCLZDaLm2L6JswOmFkluz4sNK2gYaYWfod70ZwLuR1E=;
        b=F4KqxjPtUpUTG4UFNaz+i5XCVScq7QJFFVNBSSwIsD/FRdeQjbLIva45cb5rZqyqDh
         lqgC4mBcBtfMukQFv1qDxd6bqxsYKF0q3eThiRbsmA3wLid6uNCDqCOEzocUuWvTmxlQ
         WwaQi3TRh33ctaIhHkl1GzovZmbalSDEBkmukt6Qjhd8hgbKq7T/F9UtWtAwFwCfsSy+
         D2q45tHXpV7mfo4BkKRPb4ySl/FoKsbOP3XSmu9KENoFOf9KHMJvV5NBqd+1B2CYtZ/z
         Dix8n8GZ/1mPTlcybyyllvrlb3FYU/AKmVt3YNrrv6bIXLkgKI5fxBmBVtMgfRYo+Zw/
         NWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767229644; x=1767834444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCLZDaLm2L6JswOmFkluz4sNK2gYaYWfod70ZwLuR1E=;
        b=lTro/RftgoBoyjZHadLo+IxdMpULfejtH7YxgPvHcAR2XOTYe7ePl2J3Jh+Wq/B5Qb
         YhloY5Daf9KV48CJ8mVhHowkU8PFFF5bH34dvzzbpkofWXYJxAM0LwKq/x0yHiZJ/Ar0
         RPR/se426H5WtMtBC93K/YZDU2aYKZl5QekRaavS5NP1L8gzhWWnsuwoDrQezFawbtpK
         dCCO/dnpgZdn7sPBScvrBefusGtnY1XiIL2nNUX0E2VPbor/z1v+Sist7azAwaS3jNKe
         RcbQrIqOEg7r37AhRchmu3AATA7irIYktNPPM8liCDRNzBJrWz9WLdHERCo9os+BKbvW
         Awjw==
X-Forwarded-Encrypted: i=1; AJvYcCUxhtBcy9FMJ0S3Dv60Sydt4IGXoTPLc3c9Hw00AHgxxLIYiL4YjHi7/WpVZZWCbpbGSmPPDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWX5sWrN7phcHGYtWfbnXeqJ6QvTPF6u5L+zBgyzIhuD/DQoJ2
	tUhVM99Pj9l1UIbZbSiUAXurpjPAr+lbjd7oYSyPUsvvbdYNxPDD7jDzhD1ypKJHxSVftjopOIn
	wPgDO0Vyb18x9dP0CLUKwdY2GZ2NIM+8DrlLa1oI=
X-Gm-Gg: AY/fxX4L4EtB7gLY40zm6PqsvzJu04Wnz2hLdcLVQQhU27ly7/sVH95awjtYV9U1h/I
	mEVOD7dpeVTHQSoDF3C9dOQ88cAKl1zUG0dkBBpRMGIb1OpB7nY2KYD0JNQRV0AWWhih7/TnWif
	ZKJ+sNCO6Ed3Yl4tXUaCXOcFlwfKuKg/cOpaCmYK7+E7M3lfbWCKCdCkkMO9lBMax6RVIEM0v4E
	jzKnDNe8UOPWKb+9x8dOvw/j3dHJxnMr6YhdvSwndnZrQzn/8bxeASY2aosji4PlUtHuUgoV/Aw
	q9qD0vY=
X-Google-Smtp-Source: AGHT+IE8AcGAnGEoBO4Yb3pW+KwclBfnwWg4JRryk/uwFkoneK5K6k2fj2iNYeV0VCcRixn3NLZQ/XAJl+Y/ge6rzIs=
X-Received: by 2002:a05:690e:1519:b0:63f:b18a:7812 with SMTP id
 956f58d0204a3-6466a85b095mr27554748d50.40.1767229644497; Wed, 31 Dec 2025
 17:07:24 -0800 (PST)
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
Date: Thu, 1 Jan 2026 10:07:13 +0900
X-Gm-Features: AQt7F2qRKINMM5Amxei6wbd2xIBkigXILcsVOtv_fPrcfVGcvulJURB03OoLv6w
Message-ID: <CAHOvCC65azs4BU2fyP-kxvFWB3ZPCfyZ7KCO8N1sc0jtTENmNw@mail.gmail.com>
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

You probably know better than I do.  What I'm saying is too general.
spin_lock is good for short collision waits, while mutex is more efficient
for longer ones.  However, I'm saying that mutexes place a burden on the
kernel because they schedule internally.

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
>
> Thanks,
> SJ
>
> [...]
