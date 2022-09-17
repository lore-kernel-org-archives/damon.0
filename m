Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BA2119
	for <damon@lists.linux.dev>; Sat, 17 Sep 2022 13:35:06 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id k9so40270182wri.0
        for <damon@lists.linux.dev>; Sat, 17 Sep 2022 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pkEmitpPxttXVrpaoXcyyBb0DXbZJ4MfwB1UQBeB4Cs=;
        b=qbRXEL4zHM3yGua4NVlehiIP+BhPgK6DA5XjrXFMVDQDH/g92j3jQf3chqSXiALt7V
         3wJtFcqTL3R2XTOUxO+0/GyFYhuqY2OtEZm43Y4i3drArYiiRv0U7AEsJtmdmg0zmSwc
         gPqzfVyMKXkhhCnc9a6w+unr/TkIyESTmovLB2qcFXJ4Ux0PFWAhRuZL5+bneyltPOy6
         Cjvvs99IovHeWnQDFzhImtP2QRvNvXUQO3ndrvCHdLtg9tdmXFmHWl1mkdzhZ+1G72Xi
         qmjJVPh+Gg732G2DOc5VlSg12BQp8aa2ViTc00qhdQrBJaenBjWNvNb/PFkuvTiQa/CW
         tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pkEmitpPxttXVrpaoXcyyBb0DXbZJ4MfwB1UQBeB4Cs=;
        b=OaHljlyjJ3F+wBAj6ajFuAfw0h4+wjo0Tg1CYBK9WanZabOusD5XYO9E6+doxBF7/r
         O3BaiK7PfRU4TT2CgVf/JekNUr4vWoCAgTrkQrVCvmkJqkGyECEEBQn5DVIF/rcVhn2K
         c7eWVY4GM8yHUKx8/FEEzbGYiLK5syCzSQWUR6RbDESVkkRizj8JdOhTLKg8ZMe08izt
         9qcrQUpWVYxlHu1EA6yg+3+cLFPFOEYhx255GFKOR1ITdSHSveWbypNpw6LSmQH+vpk+
         TkbPsXHGRXqBISoYIyx9qO4cyf8hDZnJgZBEK/ZnqFJ8fgL79rDcJEX4Enx9S4wPLghF
         jgtg==
X-Gm-Message-State: ACrzQf3oJmotmIWpnP7mLOyOQ/8W1j9qHqJGs5Vh+RUFH+20XT8pctbd
	tIUJ9oTG8X9MhZpd0ohUBVgszPmFsEEPcyJ/zw==
X-Google-Smtp-Source: AMsMyM4gE5I3IlyBp0J79uc7L+wMEfIaoZ07VvSB9hb3Ma751C01ggmVhpzAE8qEQZegCZTZaHZq1lPKZ45O7RIjrJg=
X-Received: by 2002:a05:6000:70e:b0:22a:c7f5:c5f7 with SMTP id
 bs14-20020a056000070e00b0022ac7f5c5f7mr5751144wrb.333.1663421704553; Sat, 17
 Sep 2022 06:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1663407558-21316-1-git-send-email-kaixuxia@tencent.com> <20220917111230.114618-1-sj@kernel.org>
In-Reply-To: <20220917111230.114618-1-sj@kernel.org>
From: Kaixu Xia <xiakaixu1987@gmail.com>
Date: Sat, 17 Sep 2022 21:34:52 +0800
Message-ID: <CAGjdHunWLqgkhCjsB6t3gV4fzVhBs6=Nj1va1sdCbrQ=Fyu53g@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: rename damon_pageout_score() to damon_cold_score()
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 17, 2022 at 7:12 PM SeongJae Park <sj@kernel.org> wrote:
>
> On Sat, 17 Sep 2022 17:39:18 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > In the beginning there is only one damos_action 'DAMOS_PAGEOUT'
> > that need to get the coldness score of a region for a scheme,
> > which using damon_pageout_score() to do that. But now there are
> > also other damos_action actions need the coldness score, so
> > rename it to damon_cold_score() to make more sense.
>
> Good idea.
>
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  mm/damon/ops-common.c | 2 +-
> >  mm/damon/ops-common.h | 2 +-
> >  mm/damon/paddr.c      | 5 ++---
> >  mm/damon/vaddr.c      | 2 +-
> >  4 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 9310df72e1c5..75409601f934 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -130,7 +130,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >       return hotness;
> >  }
> >
> > -int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
> > +int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
> >                       struct damos *s)
> >  {
> >       int hotness = damon_hot_score(c, r, s);
> > diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> > index 52329ff361cd..8d82d3722204 100644
> > --- a/mm/damon/ops-common.h
> > +++ b/mm/damon/ops-common.h
> > @@ -12,7 +12,7 @@ struct page *damon_get_page(unsigned long pfn);
> >  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
> >  void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
> >
> > -int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
> > +int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
> >                       struct damos *s);
> >  int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >                       struct damos *s);
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index dfeebffe82f4..e495146e49e9 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -287,11 +287,10 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
> >  {
> >       switch (scheme->action) {
> >       case DAMOS_PAGEOUT:
> > -             return damon_pageout_score(context, r, scheme);
> > +     case DAMOS_LRU_DEPRIO:
> > +             return damon_cold_score(context, r, scheme);
> >       case DAMOS_LRU_PRIO:
> >               return damon_hot_score(context, r, scheme);
> > -     case DAMOS_LRU_DEPRIO:
> > -             return damon_pageout_score(context, r, scheme);
>
> I'm not a big fan of switch-case fall-through, and want to keep the order of
> cases here more similar to that in damos_action definition.  Let's change only
> the function name.
>
Ok, I'll follow that in the next version.

Thanks,
Kaixu
> Other than that,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ
>
> >       default:
> >               break;
> >       }
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index f53c2ff2bcc8..ea94e0b2c311 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -673,7 +673,7 @@ static int damon_va_scheme_score(struct damon_ctx *context,
> >
> >       switch (scheme->action) {
> >       case DAMOS_PAGEOUT:
> > -             return damon_pageout_score(context, r, scheme);
> > +             return damon_cold_score(context, r, scheme);
> >       default:
> >               break;
> >       }
> > --
> > 2.27.0
> >
> >
