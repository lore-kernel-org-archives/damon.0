Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F554A02
	for <damon@lists.linux.dev>; Thu,  7 Aug 2025 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527739; cv=none; b=IyompC35mKujehQRaYm9xxGI4Eei39jyqSWcCvJ0O7HQXVPX47v9m3bk478sqRD/MAMVWKXjef5SXVynobWYga5LPWIaEzy3kg4Sj5wzyV5IZlDRcOmfBcYnisRgn6tDnnMEh6qXjfq9hMMOevrU3tVHuU5O89EfvPkyez2OqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527739; c=relaxed/simple;
	bh=ZjOifc3000tlaK0hGk3I5QgSPMkVhf0anMnWrqSVVcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImDW4+N1Tf2ky+Mpxyprf4ZDpY0XK+cscuen4JfKgVRJ7JyobTUJeMaWLuF2o3vVgeR1WekuGUMpLq2dZdDP1WffXwjaccPkPCkDPhJuzjTDzdXNVkVG/77a9QrBtCFAYk5jE+GFqrD7ugtssDWNiVxojxDdyoR1ok/sLpB2uHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXmQgbiP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXmQgbiP"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af949891d3aso63893766b.1
        for <damon@lists.linux.dev>; Wed, 06 Aug 2025 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754527736; x=1755132536; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyU0sgZz9qTulaKfMDXTxb3hNbzZ1ImXa4EG7joeiFI=;
        b=RXmQgbiPO2X0PiOoCr6qcZ2wLnz1vqueo8EZSP97L5uBbOhBAywta1+jb8HLIbuuXl
         o/F3dR4Tp8UQ610EEIWRjKV7pPzdctwCnQA5J9/5+zJx+4NCFxzdXY7CXrI6g6j6OkYO
         JZMw0TV1h+ByrClvzHBYpUfR+MlBe/3LlYApQ5kjWFdWyZDwkzwc6MZlNokccoc44qhp
         VbJts4N5Ffwr9/pwG2vpIVqBPB3ZoPUgL9sxTJjKJ6cKgefqTXJ6EjFA6DgfJb+9l+z0
         Dx0wx3opwmEu8LFWL8n8msWJKxtSfb+ITjq3cILkfWbKIj0mn+k2DwHQAFOMHv1BNzUu
         PovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754527736; x=1755132536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyU0sgZz9qTulaKfMDXTxb3hNbzZ1ImXa4EG7joeiFI=;
        b=kAP2P+H+W5haBFC3+exLP0dKlifVU1eOQojsp1P3U+y/oZ/3DDu0gol2D51QSMnIdZ
         3s1d1TjyYZ/6gd0FdM/G71VeuCfRH7caDsCB0xyhOIuieQ7GCc98j1S33ADL/syrbKXK
         bp0vNTFaVqmhQe69px7TIfKk4jEcZ0gKGxIzcJzpa6uzGh6rBabiXiNwCkfuPzx/hKjR
         kcovgDbMJaUa1g3W5SyC7vjsl8hWaOZ1oilDMbVVF1YS7REJqJ7u61UO46DP6Kvo8EUI
         hA74YH/Uy489HgzRrdtwrwu86Z1PBFXmo/EV4m17viwZskqgAUU9AFVC4KYPEuxYsPRj
         bzzw==
X-Gm-Message-State: AOJu0YxLwhFhbSDAyXh5lOB7kKT0ehffSUue/k1zJ9KfdMHE8apF5Yx3
	8mAvlAcRWBzB4M90jYdNZAntMZGzvWJfpX+5N1MjfVsfRIu2WyhWFzJbOVEJm7y7krymAJGcq+u
	LvPZl5bD/1KTriwOPFaPEccIPEG2Y8+A=
X-Gm-Gg: ASbGnctH21YkvrilCGwHc9U2sehtM01ld29sM0q3rJFATDZppHZcMMz7XjtBqaIEYAi
	muwoC8+HU9Oxw65F/KV64ztRsW0d4S2Vy1/hmDOSZAXBcvt2JmNybZlxycB8XL8AFwjQ/ZuZvCo
	wIK0hv13OKREj97hJI2geqOydDxuG/6y13nmlUkiKZUPYL0roEvdHszVvoqilmat6B1zRGNQ0Ha
	qERHHVfoQSbdNth+PNF4JGJxQgP8lQRYhCkJBAboDOhMrm+OrzciWX0NcPMsq4=
X-Google-Smtp-Source: AGHT+IFQwMopH6azHH9WIpfqyaRZ5dbJlxtTcRscsdnncSFoc6hUjK52CP/r7T5PFLOBcK4Y/4ju5GykKep2RTRqt/w=
X-Received: by 2002:a17:907:7e9c:b0:ae3:5e70:32fb with SMTP id
 a640c23a62f3a-af990105cdcmr469979166b.4.1754527735982; Wed, 06 Aug 2025
 17:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250806234254.10572-1-bijan311@gmail.com> <20250807001924.76275-1-sj@kernel.org>
In-Reply-To: <20250807001924.76275-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Wed, 6 Aug 2025 19:48:44 -0500
X-Gm-Features: Ac12FXy1RsWB25PBoiuQCuL0TSug1jNHZq5fTiL_FTzQznrao8zQPdz3aIU7wRQ
Message-ID: <CAMvvPS7mcevjD-b2vz1P+grQfffVA0bx-x5WcUQ8=JApD+UkHw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: skip needless update of damon_attrs in damon_commit_ctx()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 7:19=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed,  6 Aug 2025 18:42:54 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > Currently, damon_commit_ctx() always calls damon_set_attrs() even if th=
e
> > attributes have not been changed. This can be problematic when the DAMO=
N
> > state is committed relatively frequently because damon_set_attrs() rese=
ts
> > ctx->next_{aggregation,ops_update}_sis, causing aggregation and ops
> > update operations to be needlessly delayed.
> >
> > This patch avoids this by only calling damon_set_attrs() in
> > damon_commit_ctx when the attributes have been changed.
> >
> > Cc: Bijan Tabatabai <bijan311@gmail.com>
>
> Maybe above line is added by a mistake?

Sorry about that. I added it because my internship ends this week and
wanted to make sure I get notifications on the status of this patch
(e.g. email notifications when the patch is merged in Andrew's tree).
If it's inappropriate I will remove it in the next version (unless
Andrew does it himself).

> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> I have a trivial comment below, though.
>
> > ---
> > Changes from v1[1]:
> >   - Compare entirety of struct damon_attrs
> >   - Apply logic in damon_commit_ctx() instead of damon_set_attrs()
>
> Thank you for doing this!
>
> >
> > [1] https://lore.kernel.org/all/20250806164316.5728-1-bijan311@gmail.co=
m/
> > ---
> >  mm/damon/core.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 6a2fe1f2c952..80aaeb876bf2 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -570,6 +570,24 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
> >       kfree(ctx);
> >  }
> >
> > +static bool damon_attrs_equals(const struct damon_attrs *attrs1,
> > +             const struct damon_attrs *attrs2)
> > +{
> > +     const struct damon_intervals_goal *ig1 =3D &attrs1->intervals_goa=
l;
> > +     const struct damon_intervals_goal *ig2 =3D &attrs2->intervals_goa=
l;
> > +
> > +     return attrs1->sample_interval =3D=3D attrs2->sample_interval &&
> > +             attrs1->aggr_interval =3D=3D attrs2->aggr_interval &&
> > +             attrs1->ops_update_interval =3D=3D attrs2->ops_update_int=
erval &&
> > +             attrs1->min_nr_regions =3D=3D attrs2->min_nr_regions &&
> > +             attrs1->max_nr_regions =3D=3D attrs2->max_nr_regions &&
> > +             ig1->access_bp =3D=3D ig2->access_bp &&
> > +             ig1->aggrs =3D=3D ig2->aggrs &&
> > +             ig1->min_sample_us =3D=3D ig2->min_sample_us &&
> > +             ig1->max_sample_us =3D=3D ig2->max_sample_us;
> > +
>
> Unnecessary blank line?

Sorry for missing this!

> > +}
> > +
> >  static unsigned int damon_age_for_new_attrs(unsigned int age,
> >               struct damon_attrs *old_attrs, struct damon_attrs *new_at=
trs)
> >  {
> > @@ -1198,9 +1216,11 @@ int damon_commit_ctx(struct damon_ctx *dst, stru=
ct damon_ctx *src)
> >        * 2. ops update should be done after pid handling is done (targe=
t
> >        *    committing require putting pids).
> >        */
> > -     err =3D damon_set_attrs(dst, &src->attrs);
> > -     if (err)
> > -             return err;
> > +     if (!damon_attrs_equals(&dst->attrs, &src->attrs)) {
> > +             err =3D damon_set_attrs(dst, &src->attrs);
> > +             if (err)
> > +                     return err;
> > +     }
> >       dst->ops =3D src->ops;
> >
> >       return 0;
> > --
> > 2.43.0
>
> Other than the above trivial things, looks good to me.  Thank you again!

Thank you!
Bijan

[...]
