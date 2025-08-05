Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E417BA9
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397475; cv=none; b=UbTn5HE0LrXdHXqn/LMzHwWPCVGuE+lmv0ANO9+ezxkvtwmRQExAWXaV02svQm5lN1/rbK5ISRwUOcQq9hysamUGNZFXvN7UPg5RyhatQdofR4klh8peLEulZ2qA4xJhs7VEIFpZLUHtOLGBHyL3qUTo7JDVcK66JbMnD3Sb7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397475; c=relaxed/simple;
	bh=FmbwoXyzu5ohz6fcdecL+zr2q4BT+wiqqom+QsCbmDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEydEH0Kg6Nt9Pn1L/gKjZmPM5/G/sbeLl+Rt0ZtnLhrnsN1vaD3imudI73wox1lQC3D/m8q5lQXHC6fwjWSArPfXxPrXXFgbpy09ipame1Bpj5TQtcFJ46s0kQtnFlHJlH68Y6dNkd026RC+qI9QC/FEVRqJYHV6PL/Yx8y8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkPOpgVz; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkPOpgVz"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30bbb2d332eso518468fac.0
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397472; x=1755002272; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g04Ntcer02isH2W2d5Orye+n2oyREPifdCN3kZL60nA=;
        b=bkPOpgVzWH8OtU5UzyW9CsNywN2jaGTOyXo+EYa6YvNxnJBtcQtYgYLMQ0Iq/SKEp9
         BJjgZCDsGXoaP8HXEYgIapMcGhTG1bWuXZYPt8oxqkckXUuyPDiaVhVnlcIxBV+CQm8Q
         Z+Omw7YHjsccg0qktPVowJwKjmHvzlIzWrbMVxBLgSCT/SPuirEk4HILiSF/jMa3vWNB
         i+yiQNnGw6Zs1xi7HH/+rN+Ih75Xjw3GZPhJqqLHGO3HkY/C46aF61+sbL6/banN04eF
         +8XS5wY2RR7gqkFw35nelS9Bmw9WQkWXbtFZXqP+sopNmiVu++dDWb1hr6B7nCUVsDFV
         dIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397472; x=1755002272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g04Ntcer02isH2W2d5Orye+n2oyREPifdCN3kZL60nA=;
        b=L+HrlIjOqImg2dCWZnjbsOyaeOcubggmSxl7jjNLuk3V/3mSGPqN2NTqLQros962z9
         JNLCFluGbQIiJhoktHyGsKlg4HMtM6JIinNWdHsx0wHReLTEMcS5wJlUFR1GklqmOtrf
         ZJ+4C8cHMOV/pnr2POleNKtPplcv0R4I9DIUsOuD1YnfZH0o+qqf/UUot2wPEg7oyPu1
         HElyyfQocRbfoE89j94K//1grOQZkvSzurRNLe0KRjOG2o/EiajOt5NHDSt9VcrRKAuf
         O/tYn9E+rQfAS+eAfFuEubPpn/8F7Mn4lNDB6Cm8LadbiIJeAXfywRH26t0wrfMrLqT0
         YQKw==
X-Forwarded-Encrypted: i=1; AJvYcCVEaUolQUmGhaDiPXgy1iIaUhbObno83u02t/WA1+3ENl6g/ISsuFnVdn0mYqKzxBGq5tFpDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDVCOUzz/nawpvaP6+can1pP4MdG1tGZTRIyQuksVqzB6RDwl/
	I2FOnBw+esvoNfO1AHj/K/3XAj2hUBgBHl9CJsOsPjweUq2ycPGhv+SIXgMQ5UkepXkcfESYVRY
	cX5XIUp98AGpwjT6hnfVyzyiDhTdCXj05RkCTnFs=
X-Gm-Gg: ASbGnctCXoG/88jpatQMDT5/IFM6cP67SP81/5yW0Spw5X459pneKma+GVFJ+YPTJfC
	Zu9PW5numhCVhp/RsnMarY5yhQPL7wANImJRjKQfEVIAmcAxxYf7lZSFt4uP9akm56YHL1AppEf
	uLxFy+o3kY4fsIhHuOPj/utRQQ2XfG8F666XlguY+pHEIjZzUF9sj5Ub+tUesTjGjp0C2zUtyZj
	NhK
X-Google-Smtp-Source: AGHT+IE2TCmwmnktzW4aemXVrlZio5sEcPKysq6nKYup8QSAvfo1joiLW8JM7EYoY51P414A+9V2D5wy/ebY7W4HZIU=
X-Received: by 2002:a05:6870:6492:b0:30b:c1a8:448f with SMTP id
 586e51a60fabf-30bc1a844b3mr1709511fac.31.1754397472093; Tue, 05 Aug 2025
 05:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250804143816.29654-1-ekffu200098@gmail.com> <20250804165005.55515-1-sj@kernel.org>
In-Reply-To: <20250804165005.55515-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 5 Aug 2025 21:37:41 +0900
X-Gm-Features: Ac12FXwHdDXIzK_0THrv08uFiQk4ZLmdovdST6hSwmwefsjdGtMk5MskX2zfudo
Message-ID: <CABFDxMGZQYS68L45N1hKKWkxTK=XUmNCpeQWpzK02RwnHcuYAg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon: update expired description of damos_action
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, SeongJae

On Tue, Aug 5, 2025 at 1:50=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> Hello Sang-Heon,
>
> On Mon,  4 Aug 2025 23:38:16 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Nowadays, damos operation actions support more various operation set.
> > But comments(also, generated documentation) doesn't updated.
> > So, fix the comments with current support status.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > Changes from v1 [1]:
> > 1. change baseline from damon/next to mm/mm-new
> > 2. Add note about DAMOS_PAGEOUT and demotion.
>
> Thank you for making this revision!
>
> >
> > [1] https://lore.kernel.org/all/20250731132230.80046-1-ekffu200098@gmai=
l.com/
> >
> > ---
> > I also watch your comment from [1]. Thank you for not forgetting :)
> >
> > [1] https://lore.kernel.org/damon/20250801233942.1614-1-sj@kernel.org/
> >
> > ---
> >  include/linux/damon.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index f13664c62ddd..d4b3ffd6144d 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -110,7 +110,7 @@ struct damon_target {
> >   *
> >   * @DAMOS_WILLNEED:  Call ``madvise()`` for the region with MADV_WILLN=
EED.
> >   * @DAMOS_COLD:              Call ``madvise()`` for the region with MA=
DV_COLD.
> > - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MADV_PAGEO=
UT.
> > + * @DAMOS_PAGEOUT:   Reclaim the region.
> >   * @DAMOS_HUGEPAGE:  Call ``madvise()`` for the region with MADV_HUGEP=
AGE.
> >   * @DAMOS_NOHUGEPAGE:        Call ``madvise()`` for the region with MA=
DV_NOHUGEPAGE.
> >   * @DAMOS_LRU_PRIO:  Prioritize the region on its LRU lists.
> > @@ -123,8 +123,10 @@ struct damon_target {
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
> I think we agreed[1] to add a reference to the design doc, instead of kee=
ping
> this duplicated.  Am I missing something?

OMG. It's my mistake. I'll make v3 patch right now.

> > + *
> > + * Note that DAMOS_PAGEOUT doesn't trigger demotions.
> >   */
> >  enum damos_action {
> >       DAMOS_WILLNEED,
> > --
> > 2.43.0
>
> [1] https://lore.kernel.org/CABFDxMGh7-vDgNzepJKtrhdOF40_U7=3DNT6Jvm85qtd=
wGpBZawg@mail.gmail.com
>
>
> Thanks,
> SJ

Best Regards.
Sang-Heon Jeon
