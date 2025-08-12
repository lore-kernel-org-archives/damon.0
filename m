Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF74CB5B
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 04:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754973854; cv=none; b=igzxUeBTHhfb70YMxkgtJitd2DgrBxaK4ENtNMMk3mZ4Qw5x7hZvj1R7RwHFabtaEDVi9yJZ5zqv8vxa6QHTWq0MW+KS4u/XvxBW1sAcPd3Dd6/kFdUUBpjzcmbX0aTKKmoOXsA/6KB7jtxgd1JFQhykIgyt6nPiZpmliGFG6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754973854; c=relaxed/simple;
	bh=awo8lDw1fnmBb45ZduqoYW3+rtQ3tGOeO6/nw1KuEyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrjmQ4AR+VuFPeUu0MYKjLkaOqGG+WUSV7DgcNW23C386JCNTluzj4rOVzUgtdHzQz7vSl3sB6cVjTrnXgeBHIL/K28JMd6zXSa6ZQuuc05CxbwhPJwcX5mT6OuG2b4H7aSN73AokKnmVAWkSuhrjcAm2HG4LAO1h84rVwIS2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRXu3rrx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRXu3rrx"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55b9a23d633so5439603e87.1
        for <damon@lists.linux.dev>; Mon, 11 Aug 2025 21:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754973851; x=1755578651; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah6pFV3KC04LTZ4T43T6D2w4fm1xnobn+WfujA61Y/4=;
        b=LRXu3rrxmURbZJ53k2O0a26SoA0O0OWT50jvYrCfY4ZeN6blbDU6nRx3JRG2kvm01Z
         LSdU6IpF1O5m7DNCuAqr7r1PRLiplie4rVGtrmx924SP+dmJYQpxq9MC++XCVGdCI0e7
         YaMSzm0NR7uG0khj2dHeC6mfIrQsetKrGofIejl/OHESzKntJw10f1ugg5E4A1CMeEyW
         POYqoju8gx7W003bR2RrR632L7R+iAZHIVus39eQ+3vKQ/RCCzqs1gokzdxLuAk+XYIv
         icCgM/bJ9oMxAL4J0qIC5Vudv1vJuv0i4QobXRGDlwIn18a+iibI5cnPzGbyBxvuEH3P
         AY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754973851; x=1755578651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah6pFV3KC04LTZ4T43T6D2w4fm1xnobn+WfujA61Y/4=;
        b=XoJXgPylcfz/8IGy2f8qYa0CoC1aTlXvwPW3DE91OoMOlM4FKBYzlTNkUNNwodfiYx
         J+z2mAkz+0cna/R4fp5wfZPuYwpgCt6j1BsfG8LViwnrd3mnHtNiEVLKt1eFDQN64YZY
         2/u/ssOV3neUJpVLAVBbq4g9AVfHtmUDK88mCFJmN298S6oBIvbHlJGDVYSuVrXUj0RR
         z0VrDsTlEZ7BOjoKwenD2gAGvprT72AJA1JRWHRGWE1kVBSFd2PHsFTcCr7yE55WGcgQ
         Cg3bBud7zcN1cm3vk0mb/OHYCvXN4qCsZiY6q6hoComGIYngQnCiOqRxhlOTcc2qGc1I
         xmXw==
X-Gm-Message-State: AOJu0YzdeG+RYjqmLDvWA3BmsVZF9MXBmQiGYnn4RLvPMfg+1K9wqbB8
	4AEQyAhNJsg0+TlJqKV7uc6+Br86/9tZFBULSN1XLR+dRUNaLSkY5ihtbNXnWmOGkCjvCuz/gDf
	u6kXYeblUhXaaqokuoPo/IdUSJDq2LsM=
X-Gm-Gg: ASbGncsgID0hrDOfJfKL5M7roVNuCg/BlWLVWcL6DkuJk0PsUEA48UXxhCYrog6xHB2
	MnBhjPsSaKeb0CHAROcDS5Jlfz/U2w94952pXjxo8j85Fim68LltfAQBFU2c8xpffCgwkBU77fm
	OYu7K8V10mYA8BkKuzYabkqXt2WM/3TBNAlsX2XrIMFvhGOaV8uzCl6eB6THine9o5EY8RQGyBw
	29H1vmhXYsKwHT+k4aIE1FjzTbU4WQt6/E=
X-Google-Smtp-Source: AGHT+IGyezuLKKKaS1DzvctFW61PSiUphakDLBMHcwt/5TEY46Ao7u3aFQL3C3PTwransaeOtV4TjQKJpQPKkI8oWA0=
X-Received: by 2002:a05:6512:3402:b0:553:2912:cfdc with SMTP id
 2adb3069b0e04-55cd8c09df7mr505888e87.9.1754973850826; Mon, 11 Aug 2025
 21:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250811074612.89804-1-akinobu.mita@gmail.com> <20250811192652.63780-1-sj@kernel.org>
In-Reply-To: <20250811192652.63780-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 12 Aug 2025 13:43:59 +0900
X-Gm-Features: Ac12FXwjFJLIohQ0Y-OoujCPkNVPmjThpPd_yFYU06c7DvSsoYY0x_AgLgWBXgU
Message-ID: <CAC5umyi4On=9cnaw+A29YyNHSkvKy+kMLN2890shTZz4aVWc4w@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: do not merge regions when the number of
 regions is small
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B48=E6=9C=8812=E6=97=A5(=E7=81=AB) 4:26 SeongJae Park <sj@kernel=
.org>:
>
> On Mon, 11 Aug 2025 16:46:12 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > This change prevents adaptive region merging when the total number of
> > regions is less than the minimum number of regions setting.
>
> I agree having the number of regions lower than min_nr_regions is not a g=
ood
> user experience.  We actually made a fix of a case where the number be hi=
gher
> than the max_nr_regions, namely commit 310d6c15e910 ("mm/damon/core: merg=
e
> regions aggressively when max_nr_regions is unmet").
>
> But, could you please elaborate when the situation can happen, why it is =
bad,
> and if you see this from a real world?
>
> I can expect this situation can happen when the user increases min_nr_reg=
ions
> to somewhat higher than current number of regions while DAMON is running,=
 using
> runtime commit feature.  And it is bad because anyway it is confusing and=
 could
> take time to real expected minimum accuracy until DAMON splits regions to=
 keep
> the min_nr_regions?  I have no idea for the last question, though.
>
> Anyway, I think this kind of details would be good to be added to the
> changelog of this patch, in the next version.
>
> >
> > Even in such cases, the kdamond_merge_regions() function must proceed b=
y
> > setting the upper limit of the region size to zero to prevent any actua=
l
> > region merging, since it is responsible for updating the region ages ra=
ther
> > than just merging regions.
> >
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  mm/damon/core.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 52a48c9316bc..34f1844094cf 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2247,9 +2247,15 @@ static void kdamond_merge_regions(struct damon_c=
tx *c, unsigned int threshold,
> >                                 unsigned long sz_limit)
> >  {
> >       struct damon_target *t;
> > -     unsigned int nr_regions;
> > +     unsigned int nr_regions =3D 0;
> >       unsigned int max_thres;
> >
> > +     damon_for_each_target(t, c)
> > +             nr_regions +=3D damon_nr_regions(t);
> > +
> > +     if (nr_regions < c->attrs.min_nr_regions)
> > +             sz_limit =3D 0;
> > +
>
> sz_limit is already set based on the current min_nr_regions.  Setting thi=
s
> smaller may help avoiding a few corner case merges, but ain't really avoi=
d
> having number of regions lower than min_nr_regions?

As I've already replied to Sang-Heon, this patch did not fix anything.
I was trying to work around a behavior that was probably caused by an
unintended setting.

> Instead, what about making kdamond_split_regions() repeat splitting in th=
e case
> until min_nr_regions is met, like kdamond_merge_regions() does for
> max_nr_regions?

I think that's a good idea.
