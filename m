Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178341D95A3
	for <damon@lists.linux.dev>; Sat,  6 Dec 2025 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764981589; cv=none; b=pI06YM9uYeT1rsRZr1uelO/t0Lud7mExqWj+cT1svqcLYrSXJZSHJwWpdxRAMNQFSD0Iq6ZNqVGrtm2qFJPuTlFOg3OFu4zH+XWegAgjpzaB6C7VgXLhjiucIKS6WG1ox/fdof/BPHtIpyNWkHkwxEQbF3jHxxi9u+WBlR1ytrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764981589; c=relaxed/simple;
	bh=99Arc8jxbilzt2g29ITO8NEPxhLgTouvGeuu/eUUMeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgeTzcSr4hJ6dLgCv+8mwjr2QWvtEFBkl+2iY+pNyNBU826hF3w9K+YhMmaLZEUvKG3o1D+j7iZFb6olGbti950/P/KeqIiNCgBgabbNIzTUDULGhXjLFT3T5Q7zlr2gVrb1PC8fZhB4vgLHJ6r7cTjALsNBUQkXczcA2mL50nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvwMA2yJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvwMA2yJ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78a7af9ff1dso29020757b3.1
        for <damon@lists.linux.dev>; Fri, 05 Dec 2025 16:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764981586; x=1765586386; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iS/PxCWZGwuJJcdGTqcqS3555N7P9Ocak8WOUuC5XsA=;
        b=CvwMA2yJMaau3mzq7InTyqa9vBm/13srQ5wfaerG5D3GKrFa7tL6kBoDT1li6BL12b
         ZGQUB9k8ll3bS8TRTNTT6zGO2T1fgPb/KztCvQ3v//ekOEg9lwOlF0pMeQB/kfiwQEHa
         0n9ll7weuLqrvblj7lfy3WMt51YyHVRsVuL5n2nLT1vxYZLwTRMVB9fczoNehQjt/0te
         e3Q3cpjxBIGLZioS517sUqeaR6/Noz215t4MAXbFe11jaVB+xwPlhGEdhiOOWGTkujmW
         cLeacJ47TDeSDvK7VBjdl4jqwd+2G8Yp5mFTjrxdYhJ8ytlYWVVMYGXEaoixKQHU+eqT
         YAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764981586; x=1765586386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS/PxCWZGwuJJcdGTqcqS3555N7P9Ocak8WOUuC5XsA=;
        b=ciel8tslU6jusnk+aesCmpxnFzSrO6/q9z7nHazucqmtYA8wTRYjex3Zn6NMrC7RYQ
         J6O+wiVW0EkSF4GTl/PShvw/lZ8CZES2ZJiLn7UctjfYabN7pxolQS2BfFgRa6BEgN9X
         6Qd074CFIHO+WImevI/f45oqLlPwwqDXw842JsZ958yg8HjxltixhkM75Ucab8VAs0Dn
         FaaolAuKlpo9fg7S9q9Mpp9FXqTeUBj5zv6d1wFfFo8RhtDWLkHIAWv2hw78VX5OWX+t
         Vv4psshIw4cdMA1UfKESvmVcNq3m2s/7wpiwJtNKSYXr3fe1+PUnlitAcyjPvz8wCVBG
         xQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjt3NVLXNvqIpT6XseeSbFJVRL83FEdXupKf0Pdz+wYPv3NYeH0h3+28RjSO5C38adOekvIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAmUBwl6UlhJHrcTjzaD7STHJNszHlBbhmH5+BQLsbQvMrWoal
	Nuk/kfkrOIsjyAEhE7KlWrIeZ6VTPe012qncS787RNt5JIGekDEmvyNWPTc4HX9hJMEmCedPqJU
	vidsrCuMsg5USQNWxfAASGFOJUSXfdvA=
X-Gm-Gg: ASbGncsrpSwJXczRsMiHqkMZ+RwCLxWjwn+E96vG7cMubhX+6K1FuMIk4U8TgLr+0GP
	ceOdvUvcLSCN/Qh8tGl+A6OsWEMRjKSGMgSmA2QgRlKNPsTWe9fJBkDQiIBuojT9wiePLTQFza6
	K1ox7aeL8eEEn3vTzJm0E5kC7JMkknISb6O2r/JS3to1xSYa7aumbXdn6LsRffqncM/fSQF8xuw
	ibka1tgbUve6vVMeoZTRUOetxjHBjxrLq75OTZOT9lR9oO0pBUfBG79XSsfV/wvWmBzDj2a
X-Google-Smtp-Source: AGHT+IFNW2ikPffWpMB1hHHqvH6d1j54Kr483iTS45ilSSv6UXPYq8AygE7VN1mbYMiSFkmdAW2f1RCFz5pUEWe2auM=
X-Received: by 2002:a05:690c:ed3:b0:788:7f:98b with SMTP id
 00721157ae682-78c33b09d37mr10716447b3.14.1764981585915; Fri, 05 Dec 2025
 16:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251203080440.16096-1-rgbi3307@gmail.com> <6932b0cb.170a0220.2d16ee.eb89SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6932b0cb.170a0220.2d16ee.eb89SMTPIN_ADDED_BROKEN@mx.google.com>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 6 Dec 2025 09:39:34 +0900
X-Gm-Features: AQt7F2qlyVil-aB12oBUhKCB7DUC91KtzDgwvf1_MltJSfNq8gM-a4Nox-P1RR4
Message-ID: <CAHOvCC4SVz1TH4OaququJUcYfo6hvBE-BcVgZcVBGt=u4HxJog@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
To: Enze Li <lienze@kylinos.cn>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	rgbi3307@naver.com, enze.li@gmx.com
Content-Type: text/plain; charset="UTF-8"

Hello Enze,

Thank you for your kind help.  I will reflect it in v3 and send it again.

Thanks,
JaeJoon

On Fri, 5 Dec 2025 at 19:15, Enze Li <lienze@kylinos.cn> wrote:
>
> Hello JaeJoon,
>
> Thanks for your patch!  I've a trivial comment inline, see below.
>
> On Wed, Dec 03 2025 at 05:04:33 PM +0900, Jung-JaeJoon wrote:
>
> > The damon_stat_build_ctx() function sets the values
> > of attrs.intervals_goal structure members.
> > These values are applied to damon_ctx in damon_set_attrs().
> > However, It is resetting the values that were already applied previously
> > to the same values.
> > I suggest removing this code as it constitutes duplicate execution.
>
> Would you mind reformatting the patch description?  The kernel community
> documentation recommends wrapping lines at 75 columns [1].  While the
> current length is within the limit, adjusting it for more balanced line
> lengths would improve readability.  Also, I suggest using two spaces
> after a period instead of a line break.
>
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#subject-line
>
> Thanks,
> Enze
>
> >
> > Signed-off-by: Jung-JaeJoon <rgbi3307@gmail.com>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/stat.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index bf8626859902..51dd29685915 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -173,14 +173,6 @@ static struct damon_ctx *damon_stat_build_ctx(void)
> >       if (damon_set_attrs(ctx, &attrs))
> >               goto free_out;
> >
> > -     /*
> > -      * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
> > -      * accesses ratio, keeping sampling interval in [5ms, 10s] range.
> > -      */
> > -     ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
> > -             .access_bp = 400, .aggrs = 3,
> > -             .min_sample_us = 5000, .max_sample_us = 10000000,
> > -     };
> >       if (damon_select_ops(ctx, DAMON_OPS_PADDR))
> >               goto free_out;
