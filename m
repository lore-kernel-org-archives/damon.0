Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A51A5B8B
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588656; cv=none; b=DqVAu8ZFsQ72QXa0lFJ27XpDR6MbvgUq8GBxG33EcsW8fzZ8h0S+xZYN4B/rclXnTg7R/SJtO1xr1xoET3pdSnfQLJ/Dsf3iIJTDgOs/WKMT7aA0Sg4TQoqsEmDI7UcStjMTI6KrtLAUcSsSrkN6B/tB7F58bLiOgwpkZglGPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588656; c=relaxed/simple;
	bh=wE+mCWye7Tzgg6iZGAznPpzEkZgxm+Hb6vjpQHpoUsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBu+JYoDMCWbQJ8NR5nlKzaC2WPAG2OHdVbGe5H7Sm7zJQn0c28Axf26eYxyyIKe5XcaXhzejSZiD4aC/Du6/dOkV/BqSg766FmGhiL2ZrZeZtGf4GvnilIY1ssm4a1xs0RtFgYilTD0pxVieWfvXhGJl2vNiG5kIg339Wl7CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsrZHhN6; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsrZHhN6"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cce83fb5fso3325711fac.1
        for <damon@lists.linux.dev>; Tue, 19 Aug 2025 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755588654; x=1756193454; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A3lRrUmhcKBoeRoSo9KGlZI+P5MDqfwClgrD0+6VbY=;
        b=hsrZHhN6Z/pHiljExI/8Lic8dT32zqRZcjk7/TEa1s5AGlzy6nzNW1IIiWQcbte+BC
         sb0flFCX0fozD3zqvXHBGsWi+yNCJhcgwOLRCfnFseDJLWnNYao8ezzqP1k43mluPtuc
         t3n9i2Lws7yhHpkKX+Osor9/HtuYlrlPiFv5l0Utubf293iK62vvCquc3ds+4RnyYeEV
         a1HkAcbtdhBQaVCB0OCfGlOq85lF++XQISIjYyigrZjvbstq4BtOgq6sZBGpNiLBS83F
         GumfbKLT/dYWU5LJhH04KDNReWz/ZPjBrtw/EN+jKxeDVtUwxnYViDn2iiJsRwUeZzLy
         /RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588654; x=1756193454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A3lRrUmhcKBoeRoSo9KGlZI+P5MDqfwClgrD0+6VbY=;
        b=K+Q3RkuNYupo8Euj9KgCOtKo/NXRyqwro597sgZEKBnPsM8uauNXRI4C00bqwHtMEZ
         MhZWZg71nl2Ys27bWkyJTL8UMDrdiqPzRJ8p8KVUjU1NF+tXDruur6FEj2SSxcq200Sl
         uf/Oif4/iZYbeedh/KDE0Cqm4VySuZDLvIscalA4n+7yDyDUiVeouzXvG+WoMrFor0S/
         cI64WFVAPR5YrHpuTknET6OkMutCoyInyb8bmXm6WUUK/FR4xc7OdsxYhLRwAjo5Pri5
         pDEArUrLr3IrNEDmdzJwaC7OBNgKoffPQ6uTcYKIpvZ97tqpZQ11pn2tO0qgztyTC6Vu
         pSXg==
X-Forwarded-Encrypted: i=1; AJvYcCXiSpEDLgTjpMuVys8WJyoRcjv0PViF7TDd37KRh51q+vWafOS0yJoZXHD02ZHozMA3ZuP2+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7XL0mIDKQBIr7ZqD+fe1I76obSLrFwJo4KHgAXl7XQvUi3x2D
	VwjSYTrZ7LIJTCDioD69EFVfAafWPedPPJPdEABu09wCD8AljKk9LIqfoaO3dTMnwQAYB6v7O2W
	DjbQ5Nq5GIPLFEllWDOu1+rGlqWgEoJA=
X-Gm-Gg: ASbGncsMbiQEvflRc3gcZJjvtaaQvBqNr+kzIzh5W5LKXUXwPHiMU5m4WaOaF4gq0ro
	KTDhqUUFanJZ7+XAthCKc/JaHRijnhq/BqeUVQ1mts3t364zR7jOX6oTn8sKeoxlHYynvzGVVGa
	Bs7hRqiOBVCqgfWmaKXbJ/prTxV6XVbgVumuCmzDLSy80vaBHmBjfPZxrq7yVIpByi/HLFFhdsn
	+Sw
X-Google-Smtp-Source: AGHT+IHo9E+Ay4b6CGxhfla0xIwP4IxvRxaBWauEjxrlr4PbTxTTTGDiDt0U9yiuYkuBZCIvztT3wUwOBRyI4LpPSrw=
X-Received: by 2002:a05:6870:210f:b0:30c:347e:bd34 with SMTP id
 586e51a60fabf-3110c0084f7mr1135578fac.3.1755588654099; Tue, 19 Aug 2025
 00:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250818183803.1450539-1-ekffu200098@gmail.com> <20250819052539.38526-1-sj@kernel.org>
In-Reply-To: <20250819052539.38526-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 19 Aug 2025 16:30:42 +0900
X-Gm-Features: Ac12FXyvAGBa2SmkxF-KMcyPgNBPvNMYaluWCiXVi1lPx9WcFpbaMHI5TpDxSio
Message-ID: <CABFDxMFnVMbLDW4ZHo1Z2WHdWtcEjSZZ3qOkc9s7G=YfvEj0-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: set initial quota->charged_from to INITIAL_JIFFIES
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:25=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Tue, 19 Aug 2025 03:38:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> >
> >  /*
> >   * Have the 32 bit jiffies value wrap 5 minutes after boot
> >   * so jiffies wrap bugs show up earlier.
> >   */
> >   #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> >
> > In 32bit system, if quota->charged_from is initialized to 0 as it now,
> > it will not adjust event if reset_interval_ms passes for the first 5
> > minutes.
>
> Thanks to your clarification on another mail, I now understand this can h=
appen
> because time_after_eq() casts the diff of the given two unsigned long val=
ues
> into signed long type.  I might be not the only one who can be confused o=
n this
> part, though.  I think at least I of future will be confused again.  Plea=
se add
> the detail on the changelog.

I am also confused with the above things. I'll add more descriptions
including time_after_eq() as well.

FYI: If we use jiffies_64 instead of jiffies, maybe it will not be
confused anymore. but you know, maybe it can be a big change.

> The above explanation is not technically wrong, but I think it is not
> describing the issue completely.  The above description is saying about o=
nly a
> case that a DAMOS scheme with quotas is applied just after the system is =
boot.
>
> But, a similar and much worse problems can happen at anytime if such sche=
me is
> applied while jiffies value is somewhat that can be casted into any negat=
ive
> signed long value, e.g., about 25 days after the boot, assuming HZ value =
1,000.
> In the worst case, hence, a quota charging window can continue for up to =
about
> 25 days.

Maybe I'll add more examples of problem cases to commit messages. I'll
try it on the next version.

> The same problem can theoretically happen on 64 bit machines too, though =
not
> practically early (about 300 million years after the boot, assuming HZ va=
lue
> 1,000).

Yeah, in a 64bit system. I think this could not be a big problem.
Maybe I can add this minor comment to commit messages as well.

> If I'm not wrong, I think the fix of this bug deserves Cc-ing stable@.

You think the same as me. I'll find the commit and add Fixes and CC to
the next version patch.

> >
> > So change initialize value of quota->charged_from to INITIAL_JIFFIES.
>
> So this will fix only just-after-boot time issue.
>
> I think it should be initialized to the jiffies value of the time that th=
e
> quota really starts being charged.

You're totally right. I first used jiffies(this patch didn't show that
anyway), but while trying to find other reference commits and making
the commit messages more detailed, I got confused. late night issue.
I'll fix them.

> > This soultion has already been applied in commit 7d70e15480c0 ("writeba=
ck:
> > add missing INITIAL_JIFFIES init in global_update_bandwidth()") or else=
.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > I think it would be good to add selftest of below senario.
> >
> > 1. Set DAMON with quota.
> > 2. Wait and check esz is updated well.
> > 3. If esz is not updated after quite long time, set test to fail.
> >
> > but I'm not sure that selftest can support environment handling; jiffie=
s
> > with INITIAL_JIFFIES or near there.
> >
> > If there is another method that i don't know. Could you please let me
> > know? Or any better idea?
> >
> > ---
> >  mm/damon/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index cb41fddca78c..90317a3bcf78 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -366,7 +366,7 @@ static struct damos_quota *damos_quota_init(struct =
damos_quota *quota)
> >       quota->total_charged_sz =3D 0;
> >       quota->total_charged_ns =3D 0;
> >       quota->charged_sz =3D 0;
> > -     quota->charged_from =3D 0;
> > +     quota->charged_from =3D INITIAL_JIFFIES;
>
> As I argued above, I think we should at least set this as 'jiffies', not
> INITIAL_JIFFIES.

ditto.

> Also, damos_quota_init() is called by damon_new_scheme().  We cannot guar=
antee
> if the caller will directly start DAMON with it, or commit it into runnin=
g
> DAMON.
>
> So a better approach would be initializing ->charged_from at the beginnin=
g of
> kdamond_fn(), e.g., inside kdamond_init_ctx().  For commit case, damos_co=
mmit()
> may also need to be updated.  To me, this feels too complicated for stabl=
e
> kernel backports.
>
> What about modifying damos_adjust_quota() to initialize ->charged_from, l=
ike
> below?

Oh, I missed this point. I just consider assignment points not timing.
Thanks for clarifying. Honestly, I think changing kdamond_init_ctx()
and damos_commit() are more accurate solution. but I agree with your
point as well. It looks a little bit more difficult.

> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2130,6 +2130,10 @@ static void damos_adjust_quota(struct damon_ctx *c=
, struct damos *s)
>         if (!quota->ms && !quota->sz && list_empty(&quota->goals))
>                 return;
>
> +       /* First charge window */
> +       if (!quota->total_charged_sz && !quota->charged_from)
> +               quota->charged_from =3D jiffies;
> +
>         /* New charge window starts */
>         if (time_after_eq(jiffies, quota->charged_from +
>                                 msecs_to_jiffies(quota->reset_interval)))=
 {
> [...]
>
> In theory, this can also incur wrong behavior in a case that charged_from=
 is
> overflowed to zero while total_charged_sz remains zero.  Such cases would=
 be
> unrealistic, though.

You're right. I agree. It is just in theory.

> And even if it happens, nothing goes really wrong.  It
> will only extend the current charging window for one reset_interval, once=
 per
> jiffies overflow.  Meanwhile, this fix is simple and can be easily backpo=
rted
> to old stable kernels.  So I'd like to recommend this option.
>
> What do you think, Sang-Heon?

Your solution is reasonable. I'll apply your direction on the next version.

>
> Thanks,
> SJ

Best Regards.
Sang-Heon Jeon
