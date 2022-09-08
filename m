Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB77C
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 02:07:53 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so587290wmk.3
        for <damon@lists.linux.dev>; Wed, 07 Sep 2022 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BLF2kMmdrofDBi9O5TGkANVsUhpE8WNQauup993bzoc=;
        b=nczWRa35lOHHeQ8shY0JxNDzyMHqVdRYOe8HN2jvgFdoqs55hP2m9qZLvzNbVdkdAu
         dU0i8dvLoTSTRyHu2GnF4Y06hg47lwqbypR8Nf4LgAR4TtH/pJtLY9GNlPV6I2uqeET4
         ygyhzJ0MlBKvz6/kVtTiobHimOu3uYJ+OjmZEz/PfJZ9hpEwqDkQoWUsSigehgsUkyDB
         bnjkVoesWlE94tFprdCXTOFVtWKkdKEYQQiGbP6zMhVnJsjyMwKsUj/NnrqguNxOhMWi
         stGwck/Zi2MSrkmiQCEsOaakLZyXT0PVfo91GbmyC1iOuKxboKK6mOHxGT4TW0MIAH/j
         bp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BLF2kMmdrofDBi9O5TGkANVsUhpE8WNQauup993bzoc=;
        b=3aoNuHsuAMHNPJ36yI+TqyvSqjqw9GLlFSczM4xQBtxyA1hUTG27jumHHZoAE1ksvD
         YZ+A+6zYZsGlulTR6StXXnFE8UVd0uAOSQP/M1W8lfPBa+g4qk/niaHboz/n21XETz9D
         01cLOr0eNzkL147+bl5mbv80UZgRkmhZ40jUG8fA9fMyefQliFYSRrBBRH+H1ISeSsdh
         0PXS6e40K1DUqGuEWQMEndyWf9bFuagPkrfS7gEESfdtLEVzf4yWqWf7qzXaJ3DVP9F2
         dpEsphs2/Vl6HtOQZi3en1ayv9QeGgESURlyWDlEJUlg4ubQ5TGu6tJ0D3B4cPTP7P5V
         uT7Q==
X-Gm-Message-State: ACgBeo0Z0aLiPfsKCZM1IXMC7DjYJtjXbvvkMrGCb9qJ9tohThhW4BpO
	R8xmnMfC38qgNOl8skloyV407Dh8SqDoH0FnoQ==
X-Google-Smtp-Source: AA6agR6y0eqoFREYh6JFMwVB8xkR/uvm2w5XlkdWiHPsD4CFhbocmlXGD5OSu6iqw+MkKNoKkrowkm5FaTJNVzR5zJE=
X-Received: by 2002:a05:600c:1554:b0:3a6:23d7:1669 with SMTP id
 f20-20020a05600c155400b003a623d71669mr657805wmg.70.1662602871310; Wed, 07 Sep
 2022 19:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1662568262-20925-1-git-send-email-kaixuxia@tencent.com> <20220907174207.61191-1-sj@kernel.org>
In-Reply-To: <20220907174207.61191-1-sj@kernel.org>
From: Kaixu Xia <xiakaixu1987@gmail.com>
Date: Thu, 8 Sep 2022 10:07:39 +0800
Message-ID: <CAGjdHukJ+HVxZo66oVGnETy6Zm+LMDyVS6upEzQ14ucpj8NvXA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: remove unnecessary switch case DAMOS_STAT
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

On Thu, Sep 8, 2022 at 1:42 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Thu, 8 Sep 2022 00:31:02 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The switch case DAMOS_STAT and switch case default have same
> > return value in damon_va_apply_scheme(), so we can combine them.
>
> Good point.  I have a comment below, though.
>
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  mm/damon/vaddr.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 3c7b9d6dca95..94ae8816a912 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -643,8 +643,6 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >       case DAMOS_NOHUGEPAGE:
> >               madv_action = MADV_NOHUGEPAGE;
> >               break;
> > -     case DAMOS_STAT:
> > -             return 0;
>
> IMHO, keeping the 'case' makes the code easier to read, as we can find what is
> the expected flow for DAMOS_STAT here immediately, instead of asking readers to
> find what are the actions that not specified here and therefore fall though to
> 'default'.
>
> Also, my another intention here is to mark 'DAMOS_STAT' is supported by
> 'vaddr'.
>
> >       default:
> >               return 0;
>
> That is, 'default' case here is for DAMOS actions that not supported by
> 'vaddr'.  So, I'd like to keep the code as is.  Maybe we could add a comment
> saying 'default' case is for DAMOS actions that not yet supported by 'vaddr'.
>
Yeah,  it might make sense to add a comment here, thanks.
> >       }
> > --
> > 2.27.0
>
>
> Thanks,
> SJ
