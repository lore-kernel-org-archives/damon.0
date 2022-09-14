Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146C2F2C
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 08:21:49 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id z14-20020a05600c0a0e00b003b486df42a3so5882498wmp.2
        for <damon@lists.linux.dev>; Wed, 14 Sep 2022 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hMSGdNlxtlPnxBGnbW3hM3kVsWE36K0xZy1a/tGPCkg=;
        b=OQ4OIy9GOmeg5xzg7T70zjN7bKVToFE5zPr9Nz/6JKhryYv2DnGvHEQx4x1dURBNcz
         /capUXEu7BWPsUCVFTsrM082PdGmXG+dK4UBgZRzFi6mfeREO/rsb7s+MnIEfItare5C
         RqBkttw568pesaBzzvvtn8MZuhcEnchA+pOrkSINlcEzW5YDnr2y+0hzKLsk8LHia2hK
         njVh6Ro/FGDSXmfAb1DQLo4iGeqb662ZAeLKsOd/57x7MH7gbxVL5okwrVK4x2snrEAm
         9CBhOxpbIBX0F87oSjJsMQoNU5uTAsswiCsavEgUmU9dKHAEIHSAAVKJfFY/jLkrEg7u
         sijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hMSGdNlxtlPnxBGnbW3hM3kVsWE36K0xZy1a/tGPCkg=;
        b=XAZNlDAYgIjPLd2/Og1DTQsKxf5RljyC03p+i9pXY3ny6cE1dVXBlflI2FhDGWivjk
         efj5Pdm+S2kDGpfwf0fPCwrtQ7eb5wOWlHPS1zw4LwyymsZ7EfqDc8ZRSCGiN9sz4plg
         wX5vCrHVkO2yfWELeCQ90wFZwdnRtUZPfdp4biv11MFWwzBCnBrJcNUSJnDrN89PdfsR
         TvXsso4j7scGITTHkj+InY3xzsmkVZ/Oj53MMyaXat8h5gHd2n1+WbOYAg945lGosDEm
         dGN9plAn/s6ihvB7HHJAwl9D2LAFABnJlce0DcYziuT5TyOp965IuBF1zFj9ehn9ReHO
         YAAw==
X-Gm-Message-State: ACgBeo3+869YQY53D5v9pU9dTPv/WetgWpqRJarh5cOY+UMkbZY8pfx1
	pMMqWBwAn3qcDqgXcBQbaPm84cL5pW26+LF8tw==
X-Google-Smtp-Source: AA6agR4YcAj/dzl4amYqbHPoxvGWmBXtsFhboQ8tAV5cdG/5kn6jrtldNeNEHKltUr5P27JCbuBNDHhcbWAKR1wlaI4=
X-Received: by 2002:a05:600c:1912:b0:3a5:f4fc:cd40 with SMTP id
 j18-20020a05600c191200b003a5f4fccd40mr2104290wmq.205.1663143707737; Wed, 14
 Sep 2022 01:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGjdHu=8pGmyBpVMpf-V=6w7hZHLmG4WH5EsNchn_+GqikTDxQ@mail.gmail.com>
 <20220914080404.58913-1-sj@kernel.org>
In-Reply-To: <20220914080404.58913-1-sj@kernel.org>
From: Kaixu Xia <xiakaixu1987@gmail.com>
Date: Wed, 14 Sep 2022 16:21:35 +0800
Message-ID: <CAGjdHu=rixLvmd37eXxpH8R_V8x1RaTH-f-G=WtJuCGDz+N5DA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/damon/vaddr: indicate the target is invalid when
 'nr_regions' is zero
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 14, 2022 at 4:04 PM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 14 Sep 2022 12:02:05 +0800 Kaixu Xia <xiakaixu1987@gmail.com> wrote:
>
> > On Tue, Sep 13, 2022 at 11:11 PM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Tue, 13 Sep 2022 17:11:27 +0800 xiakaixu1987@gmail.com wrote:
> > >
> > > > From: Kaixu Xia <kaixuxia@tencent.com>
> > > >
> > > > When 'init()' and 'update()' DAMON operations failed and the number
> > > > of the damon_target regions is zero,
> > >
> > > Well, I think that could be a temporal failure.  In the case, later call of
> > > 'update()' could success?
> > >
> > Yeah, the kdamond while() loop calls 'update()' periodically to fix this
> > temporary failure. But for extreme scenarios that 'update()' continues to fail,
> > we should have some ways to detect this case.
>
> Even in the case, kdamond will do nothing but continuing the main loop while
> sleeping sample_aggr interval (5ms by default) for each iteration, and calling
> 'update()' for every update interval (100ms by default).  Waste is waste, but I
> don't think that's a real issue.  Further, continuous 'update()' failures mean
> the process is in some weird state anyway, so I'd assume the process would be
> finished soon.  kdamond will also finish as soon as the process finishes.
> Users could also find the strange situation (nothing in the monitoring results)
> and finish kdamond on their own.
>
> Anything I'm missing?
>
That sounds reasonable. Thanks for your detailed explanation.


Thanks,
Kaixu
>
> Andrew, I found you merged this patch in mm-unstable.  Could you please hold it
> until we finish this discussion?
>
>
> Thanks,
> SJ
>
> >
> > Thanks,
> > Kaixu
> > >
> > > Thanks,
> > > SJ
> > >
> > > > the kdamond would do nothing
> > > > to this monitoring target in this case. It makes no sense to run
> > > > kdamond when all of monitoring targets have no regions. So add the
> > > > judgement in 'target_valid()' operation to indicate the target is
> > > > invalid when 'nr_regions' is zero.
> > >
> > > >
> > > > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > > > ---
> > > >  mm/damon/vaddr.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > > > index 39ea48d9cc15..65ff98d49ec0 100644
> > > > --- a/mm/damon/vaddr.c
> > > > +++ b/mm/damon/vaddr.c
> > > > @@ -598,6 +598,9 @@ static bool damon_va_target_valid(void *target)
> > > >       struct damon_target *t = target;
> > > >       struct task_struct *task;
> > > >
> > > > +     if (!damon_nr_regions(t))
> > > > +             return false;
> > > > +
> > > >       task = damon_get_task_struct(t);
> > > >       if (task) {
> > > >               put_task_struct(task);
> > > > --
> > > > 2.27.0
> >
