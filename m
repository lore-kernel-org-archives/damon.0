Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EACD26CE36
	for <damon@lists.linux.dev>; Fri,  1 Aug 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062485; cv=none; b=pbJyjCn/L2G8jLd/6GO0E3jaQmD9t9N6Q71keDA4hKHNj7tX59asidLYh8b7XB+w59vJ6LP/CEJq2VkfhvjH8HOxl6dSlI10LXdMH169gYudIbwUuoGnXuTQf8YhALl3n0Nno5J7Ol43rH2MEbzcVZAl87iDgcgJ7uBEv8WLP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062485; c=relaxed/simple;
	bh=yHFqA2IlHeLWKfi7Gxt/swAWC7RbjejJhWtFmQfs/iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPiTBUowF7+zcWvYwNLIGkK0PDu4IxmnArus914cRceaxTwdJp3px7UE62x9ve0Htishp9VEH8BnpQARdbZ7E5uzEPvXOzqDRKDZvEE70jUHpIwqx4eGjHufNzEf6HjV2wQtytsoUZpfu7gIXo/tuypYocXRjNAyle0ZtbC7cO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMJDGbBa; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMJDGbBa"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2eb6c422828so2421600fac.1
        for <damon@lists.linux.dev>; Fri, 01 Aug 2025 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754062481; x=1754667281; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofe6Q9A+agjL2oCVwUrX1X8DXac9+wkgPKORpc2QcHk=;
        b=XMJDGbBan/IV697cR7RF7LAw7jq518lHqml4lOuXlFDiMJ5gu0LHqbAYro43XvLz+v
         mwHjSVUKCNZ0k76r0ZEZ3DSbmn0gnoonuw86Xh8+E5JNX43oVoLPNmFhk/AYI5KmU6bM
         RCp/9Nw9EkRaYuhBnKnYtU5y7BopFDmSs5SKTexc7SbZMH6t8keg/I19LagnxW75BEQH
         EjQY7JBmkDt3wVx9LRQcIA9eSGtqGdO9jX+ge20W8llnNtdIdosFV4J6/qYLgZoNiMHi
         cYfGQ8XkAHBt6V8iNhmjEFNY5Nw/h0uGX7m8Qa5s2BFwnppqv4CbuWvdQtTch1GEIfjx
         HurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062481; x=1754667281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ofe6Q9A+agjL2oCVwUrX1X8DXac9+wkgPKORpc2QcHk=;
        b=U2moorZCP4zQqNIsTljKomDWCv4NQT9GUgxQDsCiTUdcX3wWnb7I/9emi/00DzRSJF
         xzK8VfGRQJ3KViyzh3zGa0jzK9R8OXb3CBmiPWAiGApd+u5wScMUdp7O4xyuQg8mlFMW
         NtRFQTqRdhnKl9SCgbPmV0bXepHIEZgRsI96735AIx9aONvugVEx6FokF+Z5bnGREgU4
         oIipTpCShdHD1qR7cHuqKCceVW2AiS3LLD1HGBLeBHUUtxu2dqlTcs4yMXZ4ELZeTso7
         bSH4D0EMDjXC2IhFSPVrnJ+9vpGfMKkohZ8PL5LXqI1mplhqY+dAq35tD34tIwlZwyQQ
         5LyA==
X-Forwarded-Encrypted: i=1; AJvYcCUWT34CurfEbY9mQgOhAC5AaHd9JewL1KXWglqxQjdq+FrYXgPeONUo243ktG+k97sLxXDU4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxahabJzAwiUAyHoNfn9qjD8+zQJaFF39fJFLSqk4vnS+9bPsua
	O7umVJCJP2YlhgtH89IIbbCeSyLTZHLYpsGtz+MOfvCTxkIyC8Bc9o3XCeCn608wExbDPEYfG1j
	uYBRikMtlXwhluvlXOrSkfP3ad8L+XWM=
X-Gm-Gg: ASbGnctolSsnqIaK92jx6v9RrpdibWMUhlesoDu5/0I57r8Z8Szn3ZORWBVI1r1Tu2C
	u2IBjEHdkkTyhS4i02RcKoWlA4FQvX7cbebCneZZXVcKSPhI/ywHjxWi2i0/WwS0A47aQPO8EJ8
	3aII2X2SM2ksZ5lSrSC7Q9uFbJYLq7BqrTsN+z10VkqCriX5Lhi2mz3qbGgxqsuOO10p7fCTwvk
	kWe
X-Google-Smtp-Source: AGHT+IHN/OaWoq1Bl0J7hNhQm2fN8vIhDjZXkH9pvZf1y8Kg55hrcYAt9FM7VpJ1+NJ7ArOll3YbDfO7FWH0OYoFrVY=
X-Received: by 2002:a05:6870:63a0:b0:2ef:88fa:e0c3 with SMTP id
 586e51a60fabf-307aa6cfa18mr4334721fac.13.1754062481183; Fri, 01 Aug 2025
 08:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250731132230.80046-1-ekffu200098@gmail.com> <20250731175827.16060-1-sj@kernel.org>
In-Reply-To: <20250731175827.16060-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 2 Aug 2025 00:34:30 +0900
X-Gm-Features: Ac12FXyO7ed5ZJI89Xk8AfdlvOmHKkfzcePLUQXPj3FxvakC6lnlPmJPlnQCHP4
Message-ID: <CABFDxMGh7-vDgNzepJKtrhdOF40_U7=NT6Jvm85qtdwGpBZawg@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, SeongJae

On Fri, Aug 1, 2025 at 2:58=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> Hello Sang-Heon,
>
> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Nowadays, damos operation actions support more various operation set.
> > But comments(also, generated documentation) doesn't updated.
> > So, fix the comments with current support status.
>
> Thank you for catching this and fixing!

:)

> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > I also found below patch(https://lore.kernel.org/damon/20250730200239.6=
0984-1-sj@kernel.org/T/#t)
> > So, Is it means that DAMOS_STAT is only supported by paddr now?
>
> No.  'vaddr' supports DAMOS_STAT.  The patch is not adding DAMOS_STAT sup=
port
> on vaddr, but extending the support for DAMOS filters.
>
> Thank you for checking the thread and asking this question, though.  I se=
e this
> as an important signal of another rooms to improve on the documentation.

Thanks for your kind review. I really don't want to bother you
anymore. But I would like to check my understanding.

So the basic operation of stat is covered by outside of
`damon_pa_apply_scheme` and `damon_va_apply_scheme`.
If it's not too much trouble, could you point me to where they are?

And some extension stat (maybe it only renewed that filter exists) is
covered inside of upper functions. Is it also right point?

> > If my understanding is correct, then we need to fix Design documentatio=
n
> > and comments both.
> >
> > However, since it will be fixed soon. Keeping current status is also
> > affordable. So could you check this point as well?
> >
> > ---
> >
> >  include/linux/damon.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index cddf82eaac4e..0870e9f48b0f 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -128,7 +128,7 @@ struct damon_access_report {
>
> Seems you are using damon/next as your baseline.  If there is no real
> dependencies to damon/next, please use mm-new as your baseline.  For more
> contexts about that, please refer to the DAMON maintainer-profile[1].

I see. I'll keep this in my mind. Thank you for telling me!

> >   *
> >   * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLN=
EED.
> >   * @DAMOS_COLD:              Call ``madvise()`` for the region with MA=
DV_COLD.
> > - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEO=
UT.
> > + * @DAMOS_PAGEOUT:   Reclaim the region.
>
> Nice!
>
> >   * @DAMOS_HUGEPAGE:  Call ``madvise()`` for the region with MADV_HUGEP=
AGE.
> >   * @DAMOS_NOHUGEPAGE:        Call ``madvise()`` for the region with MA=
DV_NOHUGEPAGE.
> >   * @DAMOS_LRU_PRIO:  Prioritize the region on its LRU lists.
> > @@ -146,8 +146,8 @@ struct damon_access_report {
> >   * The support of each action is up to running &struct damon_operation=
s.
> >   * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actio=
ns except
> >   * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_P=
ADDR
> > - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
> > - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
> > + * supports all actions except &enum DAMOS_WILLNEED, &enum DAMOS_COLD,
> > + * &enum DAMOS_HUGEPAGE, &enum DAMOS_NOHUGEPAGE.
>
> Thank you for updating this!
>
> But, now I find this place is having outdated information that partially
> duplicated with the DAMON design document[2].  I think the design documen=
t is
> better to maintain this kind of details.  What about keeping the high lev=
el
> information but giving a reference to the documentation for details, for
> example, like below?

I totally agree with you. Unexpected duplication sometimes leads to
unexpected expiration like this one
So, I think that I need to send v2 patch, If that's right, which way
would you prefer?
reply to this thread or make a new thread?

>     @@ -143,11 +143,9 @@ struct damon_access_report {
>       * @DAMOS_STAT:                Do nothing but count the stat.
>       * @NR_DAMOS_ACTIONS:  Total number of DAMOS actions
>       *
>     - * The support of each action is up to running &struct damon_operati=
ons.
>     - * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all act=
ions except
>     - * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS=
_PADDR
>     - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
>     - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
>     + * The support of each action is up to running &struct damon_operati=
ons.  Refer
>     + * to 'Operation Action' section of Documentation/mm/damon/design.rs=
t for
>     + * status of the supports.
>       */
>
> Thanks,
> SJ
>
>
> [1] https://origin.kernel.org/doc/html/next/mm/damon/maintainer-profile.h=
tml#scm-trees
> [2] https://origin.kernel.org/doc/html/next/mm/damon/design.html#operatio=
n-action

Best Regards.
Sang-Heon Jeon
