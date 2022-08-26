Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BD2F23
	for <damon@lists.linux.dev>; Fri, 26 Aug 2022 20:33:00 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id lx1so5169775ejb.12
        for <damon@lists.linux.dev>; Fri, 26 Aug 2022 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FH9MO19ipUPbNSVtDvQwc3Bw3OL77ONLKCGO58YGE44=;
        b=BuSgMPpHaFBWRCG4Zya+4Hcz0JuqQvR6ZxS6UpU30lbJeZPyrdHIpEkJvOQEXxffLZ
         OBZy18wVn2Nm9xCc8Z7ZJm+6vAqNH4jf/eiXXEpghaUrakkAi46bLrDltgm/FnEhn/0a
         8f/E4RwUQBmZvLHhWE0fs0Yml+DPGBmZkg1RyGh6S8Ek4Kp9GlL5G0uyMbAG2wbNB7v9
         7MXDe9YXPkCo2gDnO78pd3E4rrUJ0r/DnS12AsFq9rqGWRvv7sVuYQ0kqmbCpdUuYYy3
         EiZaV6Axnd6nRO5uruyJDYvGuZ16TNfPPnybOmTLVSoCCllw3Kxd3AyTxLEa1W3x+iWe
         S8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FH9MO19ipUPbNSVtDvQwc3Bw3OL77ONLKCGO58YGE44=;
        b=deLl634/4J5G9MFD64Zf66HbY+1hVOgn4Ti70z9wLjiaw+XXv7k7s/0WKFwN1FB7tf
         x2eVRt1ra1iba1yPxQfKBxNzQQ+RumZpp4CuZSTK9D5nSQPjbuMp3ex/+PbkF5vUJLN+
         +DsHxNLU1tGiyvl7fAUigGIhTAOO1kV06vEbUZMpy7drGgz6iU3PAnTuFiq3GXIr943z
         PtqLYJ2ZuHrzYQ6aNlmbCLWheuYGDOqhx7azYWrSltcZ+PWAtReh6gTlmlBVrJWLfFp5
         tpPRPuzVYnj5TH61BT173P0McAM0iMkjEq8bGV/MlRSk1S9Nsa02wZBi3MazqXQQc+gE
         MeYQ==
X-Gm-Message-State: ACgBeo3XNAmkktiWf4DoIEjpZ6z4mDNzW6a44gGEcaWOwDfZc+bbzkj7
	bYDuGYt1VMlZTnigPjf6KdMiCz+0TkCMKdc2cQ==
X-Google-Smtp-Source: AA6agR43VVkMEfkCWjMmFcf4/NgkWhvqCYSTnzYGN0aee7HtPwQnVLF2Hb0tzOlZM2MGiheSLDq7TQW7w5dagMZP2hU=
X-Received: by 2002:a17:907:7e8f:b0:733:16da:24bf with SMTP id
 qb15-20020a1709077e8f00b0073316da24bfmr6442681ejc.349.1661545978504; Fri, 26
 Aug 2022 13:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1661502678-19336-2-git-send-email-kaixuxia@tencent.com> <20220826170818.50050-1-sj@kernel.org>
In-Reply-To: <20220826170818.50050-1-sj@kernel.org>
From: Kaixu Xia <xiakaixu1987@gmail.com>
Date: Sat, 27 Aug 2022 04:32:47 +0800
Message-ID: <CAGjdHumMbS_jzt_HbTbmwrxOuY5yOC5U8Dq+A5AY_w78CBOHGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/damon: simplify the parameter passing for 'check_accesses'
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 27, 2022 at 1:08 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Fri, 26 Aug 2022 16:31:17 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The parameter 'struct damon_ctx *ctx' is unnecessary in damon
> > 'check_accesses' callback operation, so we can remove it.
>
> Thank you for the finding, but this wording is not 100% perfect, strictly
> speaking.  The callback operations indeed use the parameter, but the internal
> functions called by the callbacks (__damon_{p,v}a_check_access()) aren't.
>
> Could you please update the message?

Thanks for your comments. I will update it in the next version.
>
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  mm/damon/paddr.c | 5 ++---
> >  mm/damon/vaddr.c | 5 ++---
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index dc131c6a5403..6b0d9e6aa677 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -166,8 +166,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
> >       return result.accessed;
> >  }
> >
> > -static void __damon_pa_check_access(struct damon_ctx *ctx,
> > -                                 struct damon_region *r)
> > +static void __damon_pa_check_access(struct damon_region *r)
> >  {
> >       static unsigned long last_addr;
> >       static unsigned long last_page_sz = PAGE_SIZE;
> > @@ -196,7 +195,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
> >
> >       damon_for_each_target(t, ctx) {
> >               damon_for_each_region(r, t) {
> > -                     __damon_pa_check_access(ctx, r);
> > +                     __damon_pa_check_access(r);
> >                       max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
> >               }
> >       }
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 3c7b9d6dca95..c8c2f306bb6d 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -532,8 +532,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> >   * mm        'mm_struct' for the given virtual address space
> >   * r the region to be checked
> >   */
> > -static void __damon_va_check_access(struct damon_ctx *ctx,
> > -                            struct mm_struct *mm, struct damon_region *r)
> > +static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r)
>
> I still prefer 80 columns rule[1].  Could you please break this line?
>
>
> [1] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings

Sorry, I missed the warning in the new 100 characters rules :)  Will fix it.
>
> >  {
> >       static struct mm_struct *last_mm;
> >       static unsigned long last_addr;
> > @@ -568,7 +567,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
> >               if (!mm)
> >                       continue;
> >               damon_for_each_region(r, t) {
> > -                     __damon_va_check_access(ctx, mm, r);
> > +                     __damon_va_check_access(mm, r);
> >                       max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
> >               }
> >               mmput(mm);
> > --
> > 2.27.0
>
>
> Thanks,
> SJ
