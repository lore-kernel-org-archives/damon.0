Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71021853
	for <damon@lists.linux.dev>; Wed,  6 Aug 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509775; cv=none; b=sKEGAyI3YPuSdxl1Wtsdl2QKLQ0TMsKkNvI0YuwnytoHV4wlvXLyCMhDUnf/xpCGj4ZLPcCOn1p25QNS8wIrAjmC6JWKxBse4RFnNA5bNya7L8Hp00Z0bisYl6tLuYqXCjdaHGiUIOdRrkI5louD8oLYozQ778ReNhYLtzir6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509775; c=relaxed/simple;
	bh=GfCriFzxRrWEtaC+Am2QR0otEdYtr8VGmprO/3rEIdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=to/L2CEYLUxcXZrKFOG73i+uvg/Fdo1pYKrBmM6wdxBd4E/8EapVkCaGu8c//Hqj12/aMWRb+9hpmocQz9PZuMJmH4MRoz9tDNOJWXWzT++bp4ZxTzMk+SLZRB/7XBbuJkavygWZ57o+1L64cxrcZODdqqN5mvDm4o2QoE/ZnMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBa5zBXf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBa5zBXf"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so286200a12.2
        for <damon@lists.linux.dev>; Wed, 06 Aug 2025 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754509772; x=1755114572; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzyWsZ2VS7UdwxNHeGlEc8995qxMO9wJq8rXT5/QHs0=;
        b=bBa5zBXfmcp1lMixeOJPXxBKt304/Nabqb/NVwlVAtaPpMT4nyu/EBVuB5CBEF9/zn
         rYfnP6CQ5LdslBjleiX3/qb25wrsFAZEn7+ATYTvvv0k2CnH4hn33q1xJJuNefuoPbFx
         faATVQcuH4xRVqXMbuQKJkIELcKn2MbSLYLSjMHFfrhwka+NI8IOtlIE/bmTaed9ZBcp
         vuqBbyffaNmdfBaloOMP0d4GZleVxJ+fQS8FuJhoXXwpaaSBRJ2HRpjtd9ST7loRu8gk
         /SraouRqR0kyCQTvHvszj9EYYpGFHSwLrPEGqN85JbPFt7YzwisQng8UgWGpnqFKK5Na
         X8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754509772; x=1755114572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzyWsZ2VS7UdwxNHeGlEc8995qxMO9wJq8rXT5/QHs0=;
        b=H0HVMyrzA+dAbsyfPdn7kMZcLL+VFGyFkYKSLQ1IC05pTqCqanM8q+CL2l8+qB8IC/
         6EB0+7vUlTEDPpppEDReha7sSW4VCFgEkKwIMu7HWSwqAEzmcO40HOmWfZcDnLNYdqmB
         9HxYZFSZ6eXDJSPEzljiRLnCGpodXrMhSJ8kxS6LXdiunr3RW4hLfnaN1y4sRR2nBz2h
         /VH1MedgGOqps/mOclE2ZbTYns8tGlCuNo0tPmCzgbAtXcXyu3oLyRT2lfEUTcJhxbuz
         hTSDc22gcrI1YqbJjZDdoA8tOZM5Z6sWWtaVBJmJqWjiORfuDUSNy9h4NkaF99i3776n
         PCVw==
X-Gm-Message-State: AOJu0Ywx+QFp4KwYhQywaSKaCTv5WGPxKMh52sIQ32qMsLp34G3+iRP3
	jEnTwwiilVnIdMBL3S4zwiK8Sv9D4kzphaDqhqSSQbYzDQvtHDnuprfMyKRCnVYdPlK5EXih3dz
	1BvekIOt5loy72CuOrvM49h/zI2f58oc=
X-Gm-Gg: ASbGnct97mUOljqDPycRQk2F4Wswn7gWYfxXSQCODJ3XPoLqfwHvy1y2sznu2iXUedb
	X2KLEetyC9i52HijL9ZM8368m7XFWQ/vaASG/jqneOOJ9hJRpZgdDGOdIWxf5FdRetG3lCEyX9Q
	gW87/vX/VyNLuyIRC8b+xQvThJp/Midae+M1vM+0uI9A9uxo8xcRDBSfNYd/VydMSNJDjFqQqWD
	8EKmEN19hLk4xgalKHW2W2DOOY5xom2haQOaFOy
X-Google-Smtp-Source: AGHT+IHukw8BGGSuW8sM5wvXX1qfAZ4M93eqA3YKb60zFiqlp++MkcgH8j5+d0SXTAfe/GHRE+5PKfydrhljxI3QUEY=
X-Received: by 2002:a17:907:3c89:b0:af9:3c4d:e978 with SMTP id
 a640c23a62f3a-af992bcfc70mr330720966b.41.1754509771931; Wed, 06 Aug 2025
 12:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250806164316.5728-1-bijan311@gmail.com> <20250806190911.49728-1-sj@kernel.org>
In-Reply-To: <20250806190911.49728-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Wed, 6 Aug 2025 14:49:21 -0500
X-Gm-Features: Ac12FXzxEB8wSXoRu-3qE9z6QIyTH6H8gAezWdHjpR1Yn4gq7IihQeGGFcbaJHQ
Message-ID: <CAMvvPS7Anh4qZu-VewZ61_QqfU9PDCaUpGjxZWeCdioTWkr5vA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: skip needless update of next_{aggregation,ops_update}_sis
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:09=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Bijan,
>
> On Wed,  6 Aug 2025 11:43:16 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > In damon_set_attrs(), ctx->next_{aggregation,ops_update}_sis would be
> > reset, even if the sample interval, aggregation interval, or ops update
> > interval were not changed. If damon_set_attrs() is called relatively
> > frequently, such as by frequent "commit" operations, aggregation and op=
s
> > update operations could be needlessly delayed.
> >
> > This patch avoids this by only updating next_{aggregation,ops_update}_s=
is
> > if the relevant intervals were changed.
> >
> > Cc: Bijan Tabatabai <bijan311@gmail.com>
> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> > ---
> > This patch came from discussions in [1].
> >
> > [1] https://lore.kernel.org/all/20250805162022.4920-1-bijan311@gmail.co=
m/
>
> Thank you for sending this patch as we discussed on the thread!
>
> > ---
> >  mm/damon/core.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 6a2fe1f2c952..1c3d8b92257c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -693,6 +693,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct =
damon_attrs *attrs)
> >       unsigned long sample_interval =3D attrs->sample_interval ?
> >               attrs->sample_interval : 1;
> >       struct damos *s;
> > +     bool sample_interval_changed =3D ctx->attrs.sample_interval !=3D
> > +             attrs->sample_interval;
> > +     bool aggr_interval_changed =3D ctx->attrs.aggr_interval !=3D
> > +             attrs->aggr_interval;
> > +     bool ops_update_interval_changed =3D ctx->attrs.ops_update_interv=
al !=3D
> > +             attrs->ops_update_interval;
> >       bool aggregating =3D ctx->passed_sample_intervals <
> >               ctx->next_aggregation_sis;
> >
> > @@ -710,10 +716,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct=
 damon_attrs *attrs)
> >       if (!attrs->aggr_samples)
> >               attrs->aggr_samples =3D attrs->aggr_interval / sample_int=
erval;
> >
> > -     ctx->next_aggregation_sis =3D ctx->passed_sample_intervals +
> > -             attrs->aggr_interval / sample_interval;
> > -     ctx->next_ops_update_sis =3D ctx->passed_sample_intervals +
> > -             attrs->ops_update_interval / sample_interval;
> > +     if (sample_interval_changed || aggr_interval_changed)
> > +             ctx->next_aggregation_sis =3D ctx->passed_sample_interval=
s +
> > +                     attrs->aggr_interval / sample_interval;
> > +     if (sample_interval_changed || ops_update_interval_changed)
> > +             ctx->next_ops_update_sis =3D ctx->passed_sample_intervals=
 +
> > +                     attrs->ops_update_interval / sample_interval;
> >
> >       damon_update_monitoring_results(ctx, attrs, aggregating);
> >       ctx->attrs =3D *attrs;
>
> Long story short, this (original) code is bit complicated and hence I sug=
gest
> to make this change less optimum but simpler.
>
> damon_update_monitoring_results() assumes it is called only just after
> next_{aggr,ops_update}_sis are  updated.  And the assumption is important=
 for
> the pseudo-moving-sum access frequency maintenance.  As a result, this ca=
n make
> the monitoring results temporarily corrupted, and splat warning once.  Pl=
ease
> refer to commit 591c4c78be063 ("mm/damon/core: warn and fix nr_accesses[_=
bp]
> corruption") or the patch thread[1] if you want more details.
>
> Also damon_set_attrs() is called not only from commit situation.  So I th=
ink
> this maybe not an ideal part to modify.
>
> What about modifying damon_commit_ctx() to check if new and old
> damon_ctx->attrs are entirely same, and skip calling damon_set_attrs() in=
 the
> case?  Doing the entire damon_attrs comparison might be suboptimum, but w=
ould
> make the change simpler.  I assume the suboptimum comparison is not a rea=
l
> problem for your use case, so I think that could be a good tradeoff?

I can definitely do this. Checking a few extra fields is no big deal.

Silly question, but think it's best to get it out of the way before
sending another patch: do you think there's a more elegant way of just
having a dumb comparison function like

bool damon_attrs_equal(struct damon_attrs *a, struct damon_attrs *b)
{
        return a->sample_interval =3D=3D b->sample_interval &&
            a->aggr_interval =3D=3D b->aggr_interval &&
            ...
}

And I assume I shouldn't compare the aggr_samples field because it's
private, is that right?

[...]

Thanks for your patience,
Bijan
