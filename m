Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6427C15A
	for <damon@lists.linux.dev>; Fri,  1 Aug 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064685; cv=none; b=BCchgeg4O+EX36cGNgUcfGf2vuhAktpnjYX6h7jBVeVjeJqDo09T/Tj+WfixbD+DkU1eCqC68Y8Fq3xcaGfT100k/8EVBzu3ySpTGnH3kZ390gs+gGFr+fy1pZTfUCGhEpv+eLV2hfbCG+UhxiTLfiKvYEzbu+eABxEmzx0GkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064685; c=relaxed/simple;
	bh=ZqGWkIugTmcWjCg90gz55wSsF8q8LwzcgSdXgUZaJt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiJBN+SGCv6jsneneGBJOdxDqTpmF8ses/7GucOheaWduIRlCi1R+J1kh5swAIKxIMJjaHQFDLo4U9teHpcZ/l6RujSVICf0dy0yNYzB8qHgqNt76WO9qO4UNq10ebGi5E/BSiVfQsuladtkNXhM6hLUoWc00SVTMd8ScEiDtfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixiZolj3; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixiZolj3"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2ffaa884a44so1340722fac.1
        for <damon@lists.linux.dev>; Fri, 01 Aug 2025 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754064682; x=1754669482; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDM74AkLUFGDbMniQpaGkJ4N3t+PhBITmSskxxmk844=;
        b=ixiZolj3XEmJhZjx1q346OaycCxvdLfK5ZQKcZbN5rcdw228BVFhAtGrY4UHtbSKMb
         iDcpwFcyD6KcL5TZZlzDEFwFwc07VseJPS9fWq1fm+3j69AkoZtBOKZ5d8aKGfy0xJUB
         b3oJQRwCdtje1wmhVbupv6/yaS9PvvuM+vBQzjgwOfMrkEE7CyEsQMGDYE7g5UPtRDuY
         //DcmqIiUV7fzfqnjKkOEUXga7tyd7zYiq0FBhWTl/j4z5lOEPn5T4bQ5WxjmpPowzg4
         YhKTTiZV6G0myEt+YISTWodKtEvtmcTOz5eDPISuq2zgY33xi7yRn1gCF6BjmzAUwdG8
         iuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754064682; x=1754669482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDM74AkLUFGDbMniQpaGkJ4N3t+PhBITmSskxxmk844=;
        b=J7+mqIOAnFwjwNKNbOyqvNlnFukLt9MXTnOLPtztiv7WC3kCFIItmw4g9VeZXxGwSD
         2WNJq6qmuxhYW4t8/+Qu0BIq/O7MG6zj6YzNW///gsiojV9hkHTt0fzmp2tajFFeFeJT
         VqbJFnhMEjQhOdIhR2Xoc/pnurd6b4/nfV/WL50ppZ2G0XwkQQNnBVCsG5nKsPbkpSPa
         iR9Aiaz80DVJeNSolxooZJB7cde6y6Mvirly62d7miosJQbtbT0+K/VaTC8emOu/Fyoj
         E6dnEELJjX8WIeY0KXJCQ71WR9lkrtdP7JES23KDU1w+x42kN6ceQDovkqgL60FxeOeY
         WOvw==
X-Forwarded-Encrypted: i=1; AJvYcCWFfk/5xadJNUKhmAnzcCkre/KDMTbezBsl7M89jimM94C9QvtOX+YLDhfcFrl9dOgVTFmInw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxG/Krl9uP7XP+Ufihrk2f/ujydvtx7HanC7XmGYB/j+J569LV
	IzOjpDsJS7eObb+44CqVWFsVcnG0KJ1dKAbvBH3nP/ApUxveGZ4VKPzEadKtV4KmYvXpPFfHaf9
	erUDm2rSq6jZkgZAZMGiyoQIeY9zWYVY=
X-Gm-Gg: ASbGncuhtWrTpGn/geDAxHfF9f169rLutd71fOxLkZAX/GHPPhAQzsAgq6udjdaz94P
	+vTCYAHPDlog59aFTgM4+WSs3LBYjSjQcF1lpwR4PgXUVt5cmku5iHUO/tcwXH1dxZSixpszntI
	Ag9toh205xo+q5e23qFkqXR83TvNdKJaKTPNEd74EF8/xObTcbDi7SvhBegXZrCcAMXG/wd0xMX
	WV3
X-Google-Smtp-Source: AGHT+IH2Nb7B8EopMRNCEjFAeodu4t1D/XqmvTxU9PJF2g4XsvjezeiAFWqhc86hVcoLxEDqbT84ahs9DxtNkrc2VWw=
X-Received: by 2002:a05:6870:9e95:b0:2ea:83c5:1e27 with SMTP id
 586e51a60fabf-30b66ad7e05mr167005fac.12.1754064681671; Fri, 01 Aug 2025
 09:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250731175827.16060-1-sj@kernel.org> <679e90f5-cbeb-4078-ad76-a075fa5d7afa@sk.com>
In-Reply-To: <679e90f5-cbeb-4078-ad76-a075fa5d7afa@sk.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 2 Aug 2025 01:11:09 +0900
X-Gm-Features: Ac12FXwjNZJQjbIOiTgT3KYsCiAQtRxXi14dWMv04SFrqWS0XfUeDLfizECzg_M
Message-ID: <CABFDxMHamJ0m8Nq1L-4WNz4OwLaLVQdwV=X4_ZpK7Vd+RSTHVA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>, kernel_team@skhynix.com, damon@lists.linux.dev, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Honggyu

On Fri, Aug 1, 2025 at 8:35=E2=80=AFPM Honggyu Kim <honggyu.kim@sk.com> wro=
te:
>
> Hi Sang-Heon and SeongJae,
>
> On 8/1/2025 2:58 AM, SeongJae Park wrote:
> > Hello Sang-Heon,
> >
> > On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.co=
m> wrote:
> >
> >> Nowadays, damos operation actions support more various operation set.
> >> But comments(also, generated documentation) doesn't updated.
> >> So, fix the comments with current support status.
> >
> > Thank you for catching this and fixing!
> >
> >>
> >> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> >> ---
> >> I also found below patch(https://lore.kernel.org/damon/20250730200239.=
60984-1-sj@kernel.org/T/#t)
> >> So, Is it means that DAMOS_STAT is only supported by paddr now?
> >
> > No.  'vaddr' supports DAMOS_STAT.  The patch is not adding DAMOS_STAT s=
upport
> > on vaddr, but extending the support for DAMOS filters.
> >
> > Thank you for checking the thread and asking this question, though.  I =
see this
> > as an important signal of another rooms to improve on the documentation=
.
> >
> >> If my understanding is correct, then we need to fix Design documentati=
on
> >> and comments both.
> >>
> >> However, since it will be fixed soon. Keeping current status is also
> >> affordable. So could you check this point as well?
> >>
> >> ---
> >>
> >>   include/linux/damon.h | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >> index cddf82eaac4e..0870e9f48b0f 100644
> >> --- a/include/linux/damon.h
> >> +++ b/include/linux/damon.h
> >> @@ -128,7 +128,7 @@ struct damon_access_report {
> >
> > Seems you are using damon/next as your baseline.  If there is no real
> > dependencies to damon/next, please use mm-new as your baseline.  For mo=
re
> > contexts about that, please refer to the DAMON maintainer-profile[1].
> >
> >>    *
> >>    * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WIL=
LNEED.
> >>    * @DAMOS_COLD:              Call ``madvise()`` for the region with =
MADV_COLD.
> >> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGE=
OUT.
> >> + * @DAMOS_PAGEOUT:   Reclaim the region.
> >
> > Nice!
>
> But doesn't it make confusion about whether this pages out to disk or doe=
s
> demotion to the lower tier memory?  It's because PAGEOUT action doesn't d=
o
> demotion, but it looks "reclaim" includes pageout and demotion together i=
n my
> understanding since /sys/kernel/mm/numa/demotion_enabled was introduced.

My intention was just to synchronize with the Design documentation.

So how about changing the description to `Page out the region`, Would
this be also confusing?
I feel like it would be clearer than using word "reclaim"

> Thanks,
> Honggyu
>
> >>    * @DAMOS_HUGEPAGE:  Call ``madvise()`` for the region with MADV_HUG=
EPAGE.
> >>    * @DAMOS_NOHUGEPAGE:        Call ``madvise()`` for the region with =
MADV_NOHUGEPAGE.
> >>    * @DAMOS_LRU_PRIO:  Prioritize the region on its LRU lists.
> >> @@ -146,8 +146,8 @@ struct damon_access_report {
> >>    * The support of each action is up to running &struct damon_operati=
ons.
> >>    * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all act=
ions except
> >>    * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS=
_PADDR
> >> - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
> >> - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
> >> + * supports all actions except &enum DAMOS_WILLNEED, &enum DAMOS_COLD=
,
> >> + * &enum DAMOS_HUGEPAGE, &enum DAMOS_NOHUGEPAGE.
> >
> > Thank you for updating this!
> >
> > But, now I find this place is having outdated information that partiall=
y
> > duplicated with the DAMON design document[2].  I think the design docum=
ent is
> > better to maintain this kind of details.  What about keeping the high l=
evel
> > information but giving a reference to the documentation for details, fo=
r
> > example, like below?
> >
> >      @@ -143,11 +143,9 @@ struct damon_access_report {
> >        * @DAMOS_STAT:                Do nothing but count the stat.
> >        * @NR_DAMOS_ACTIONS:  Total number of DAMOS actions
> >        *
> >      - * The support of each action is up to running &struct damon_oper=
ations.
> >      - * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all =
actions except
> >      - * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_=
OPS_PADDR
> >      - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
> >      - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
> >      + * The support of each action is up to running &struct damon_oper=
ations.  Refer
> >      + * to 'Operation Action' section of Documentation/mm/damon/design=
.rst for
> >      + * status of the supports.
> >        */
> >
> > Thanks,
> > SJ
> >
> >
> > [1] https://origin.kernel.org/doc/html/next/mm/damon/maintainer-profile=
.html#scm-trees
> > [2] https://origin.kernel.org/doc/html/next/mm/damon/design.html#operat=
ion-action
>

Best Regards.
Sang-Heon Jeon
