Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A11A9F8B
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972523; cv=none; b=LWt8d91MS2IO4dMO+J49QS9BXNPbMiBqSKkDHbiWYhANKyZN6JaLlQ1ChqrFjz6loTnhKmHAER4vfl5PoiwAm5OCHKK4uXHQFm/IyhWtQbgByrRnWf4w20VS+rXfE21QwAK8dAZrIJJmytET7e3HnnFoY0Ng0HWpDFED5BTXIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972523; c=relaxed/simple;
	bh=HchBbvHbwqHDndjjFVeO+17+HIWwZyATISU9BOMJ5cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIqotyd9NVWlqFl5vHcbmtX+2it+/ZMbdyr2NGVzwf36uQ7Al3GyZkll3R4Jd0ChLnpoiTqbYgEngJVadQVHQC4PtAL/CMzei+ls7xi3+5qVx4nC/cb/raSX+xNM7fL7H0N6qSrPvJd9tSMPhVSciBnMv8qmw0cRNXLPmrBEQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foWo+Lbr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foWo+Lbr"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b797ad392so5976261e87.3
        for <damon@lists.linux.dev>; Mon, 11 Aug 2025 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754972519; x=1755577319; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlel8KouBK+6JPOwBNhOoRKOe1HSfMeMjQJ7PIY6MhA=;
        b=foWo+LbrzdjObVGPkB/1uvoU7K8su9c+tSPBIMxR17+ADt/gmG3WfJzVHtTxiIe3Ks
         eq5iVF33+YabcY6HBgO6rLiUI87nh0fjtgPuwY7RLnSaZC56Wtakoyz5XE70tD1OZJg/
         1Ep26KJ1BkOFjBMbm217gyhyU65XC3ooQ6NaSyoHs791Fu8VdAHnlsaW0/TA3WDfaqMv
         NbsTIB+W2TV+GElsoaDm9NvG8PnE/+pes7rZG8DAzKtvDDTdwB/xfdIzbaM02S0Z2mZc
         1Q2NNj94z0Mw2lczv7UtY3h9GIjGrWUUcAKUPy6P8yFvxKUusqCfUiGc9IokOLjXepVr
         RVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754972519; x=1755577319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlel8KouBK+6JPOwBNhOoRKOe1HSfMeMjQJ7PIY6MhA=;
        b=igT1SuS4OoInZsutNfj3XHgjjZyB1OpVyo9t3BNc7t0wf2AgIEa77VfsNcGi0LyA0G
         t/guCTUFxxJlBqqYSRvM5y8zPj9oQzccJhzl+I1Wkl/N+8GlqdcEGFEU8AHsgEvzXgdi
         wGpJ6Dq0fz0/NwyjRMgCDvQzWfov42N/dG9VYznUPTNQf0sCxdoExSQHxphPA9dObOoN
         vbq91qSSC8Dt4oyR8FrT+5ZRDlV6I179+ti2GvQoKRoYibaa5Rl7N/itCYQcKDfWUAa+
         CZUVi2c4g7wPWzgP0sARMr8cqwn2sGreWrgiFZerxUt07wT2Dm4mK76HAJ8ekUoTK8ZP
         bRqQ==
X-Gm-Message-State: AOJu0YxDZp8AgKInIEj8ABnjybWPczGXWx4AsUQsh4rWbJbBdZ1KXA8J
	ZmCKA9Hyzc7RLglqS88DU0lN5bFcfIeU1Pm6cZJ3M90Mq8jDaR8zlHssNPk/w3Wjf6BQfr4iJzy
	X1kwAbtnXpVdaKhVeov8SI9bw2UdVwLA=
X-Gm-Gg: ASbGncvj4+yVv84zJwljpjeg3rAxTYVcG4Lli/G4Rk/xZLOeiz/RlLJx+PeQ/7HpqRl
	YEqhatsmIT/Gnl6Awpj8I4wpklIJ53iRRmTFYlB+A9yqY66j0NZ3SsEDdS2Pt72aVPEdaLgI+jB
	wyFXfbvpKwkZ47nUq+lMfzXZgMcIIKVp/3adoCiqwrgbfDnKwX+MB1NPfykqWaRbMgMa28MFkSw
	FcBEqSToLStAsnBOeeh/HcgED6Gc6NNjjY=
X-Google-Smtp-Source: AGHT+IH74vXZaedTS2ZSgfSXRXlcNcRMp1rsGw0tK/rYpD/yGZDhU0cDOo9cJewz0EXCVcZt1kdEBRK+33NGYcuc+LE=
X-Received: by 2002:a05:6512:124f:b0:55b:87cc:eea9 with SMTP id
 2adb3069b0e04-55cc00987afmr4898516e87.4.1754972518960; Mon, 11 Aug 2025
 21:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250811074612.89804-1-akinobu.mita@gmail.com> <CABFDxMH0FfzTfnGgaLK_uKA_8tB6kMcoKiOmi-m5fbJ0L5C9Vw@mail.gmail.com>
In-Reply-To: <CABFDxMH0FfzTfnGgaLK_uKA_8tB6kMcoKiOmi-m5fbJ0L5C9Vw@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 12 Aug 2025 13:21:47 +0900
X-Gm-Features: Ac12FXyNlMeii3pNshDjOXWu5STF2X6MkZctJp7Ea_v8jHexXQtZokG106AX1AY
Message-ID: <CAC5umygi7G=M7vm4vq19b3W7P=WaFWX6WozT8crOvKvLfAzLSQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: do not merge regions when the number of
 regions is small
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B48=E6=9C=8812=E6=97=A5(=E7=81=AB) 0:52 Sang-Heon Jeon <ekffu200=
098@gmail.com>:
>
> Hello, Akinobu
>
> On Mon, Aug 11, 2025 at 4:46=E2=80=AFPM Akinobu Mita <akinobu.mita@gmail.=
com> wrote:
> >
> > This change prevents adaptive region merging when the total number of
> > regions is less than the minimum number of regions setting.
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
> >                                   unsigned long sz_limit)
> >  {
> >         struct damon_target *t;
> > -       unsigned int nr_regions;
> > +       unsigned int nr_regions =3D 0;
> >         unsigned int max_thres;
> >
> > +       damon_for_each_target(t, c)
> > +               nr_regions +=3D damon_nr_regions(t);
> > +
> > +       if (nr_regions < c->attrs.min_nr_regions)
> > +               sz_limit =3D 0;
> > +
>
> I just have a question. Please don't feel bad.
>
> 1. Doesn't `sz_limit` which is already calculated with
> `min_nr_regions` guarantee a lower bound generally? If you meet some
> counterparts, could you share the situation?
> 2. Even in that case, doesn't the split/merge loop generally guarantee
> a lower bound? Are there any special cases where you can't wait for
> that loop?

Thank you for the explanation.
I now understand that the patch was incorrect.

What I was trying to address was the problem when monitoring at page
granularity, as described in Documentation/mm/damon/faq.rst.

When paddr is used and the total size of the target regions remains constan=
t,
I expected the number of regions to increase monotonically because I had se=
t
the min_nr_regions to a sufficiently large value.  However, the number of
regions appeared to increase and decrease.

I checked again and found that the region merge that the patch was trying t=
o
address had not occurred, so perhaps the previous settings were incorrect.
