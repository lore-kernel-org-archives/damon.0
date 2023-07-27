Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C52714B
	for <damon@lists.linux.dev>; Thu, 27 Jul 2023 21:16:01 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3a43cbb4343so996123b6e.1
        for <damon@lists.linux.dev>; Thu, 27 Jul 2023 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492560; x=1691097360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6D1dKbMUyuMxqTeEeSi4spRio8knbrwzUbIZXRfX+hw=;
        b=IOAM7fcKQP3AJZ1G53VvO+FMwupcfbqVzToDOoQiJYud3dWdDmJb6Jtd760kWvOUgI
         rl+NquP649J9eHU2kyBq4oFVRVj0tR8rPhz7Ji7xDfcWHJ1ifnhjAhjxOV2uG+bw/7Y2
         dhwWvtJk+kyNFnZzLO8zhXzuFxNS2EeGA+AGfxAVI6WEUk/WYGvd5wsxpCZjV7O4d6Uf
         VL7boBq6vz3GeQ1VQXFX917WhcDwNXpDH0FGGDw6OKSSdcizMPmxExSB+58GXYbTCyFP
         qXqtahtcdKYTb8JUnOHa3XGxA5clJ6igdYnXEvscYlpAvzLLdDk7vHbm1dF/wJiivo1Y
         aLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492560; x=1691097360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D1dKbMUyuMxqTeEeSi4spRio8knbrwzUbIZXRfX+hw=;
        b=eZe3zsCiirtbOCxscc0hVXd7Rhhx/H57JL6MevfQECo4SAlxV9VZDTdwLmghwvlRA7
         79YjPuY3Qbz9Jb0ntdj5dxKjVRXjiPZAk7omvNXJvKPiUyFLyVEuYhBbeBhqlw2RQlLT
         5TLqBubjCp4dcs2wQDqv/7gakLUyAAHSNx/2O0Zipoz4ipHVHkG8L4lgdj0/AKgY1bsA
         pItn9/mYLNNNODu+PeXN06V5W1KwneGMV76VM2kBG82HaX6rciVtCu+Jwr3mgDQ8LDej
         W5JN/uyhUR+bi3C8wxo7xJa2XRfjKFFnEMzFx3iJxRr8epcqk+DQQMPj2mGJL9p/hfGp
         otRg==
X-Gm-Message-State: ABy/qLaB4pAiebYxHqJPou2ZVDk39djyIUguONjcvRbRsAasgfOb52Dk
	rpChmOdoD2RMpolRjXUkFXLMEUD2BPgALcU3FoY=
X-Google-Smtp-Source: APBJJlEDDP8mK0hZ5SSzXDsSCp3U0EVYi57aUTLxXKqR+DlsxeNchSLZb4HqSXKBKuyr3p3G0Qt+ujscvg7RD1LQiwY=
X-Received: by 2002:a05:6808:140b:b0:3a4:3f74:3bd6 with SMTP id
 w11-20020a056808140b00b003a43f743bd6mr500196oiv.47.1690492560354; Thu, 27 Jul
 2023 14:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727183745.682880-1-ppbuk5246@gmail.com> <20230727195453.67611-1-sj@kernel.org>
In-Reply-To: <20230727195453.67611-1-sj@kernel.org>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 27 Jul 2023 22:15:49 +0100
Message-ID: <CAM7-yPQp-3BRcuFjOfEfdsMzUNU2bswKWAdQpOe_3gV1TyH5AQ@mail.gmail.com>
Subject: Re: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ.

Thanks for looking into this.

> Nit for the subject, what about s/drect/directly/?  Also, let's remove the
> period at the end.
>
> On Fri, 28 Jul 2023 03:37:45 +0900 Levi Yun <ppbuk5246@gmail.com> wrote:

Thanks. But I don't know why period is added thou I sent via git send-email ..

> > -     if (pmd_trans_huge(*pmd)) {
> > +     if (pmd_trans_huge(pmdp_get_lockless(pmd))) {
>
> I don't think we really need to use pmdp_get_lockless() here, since we will do
> this check again with the lock, and we have the fallback for the intermediate
> changes.

Agree. I'll change. Thanks :)

> > @@ -434,26 +437,29 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  {
> >       pte_t *pte;
> >       pte_t ptent;
> > +     pmd_t pmde;
>
> This would cause below build warning if CONFIG_TRANSPARENT_HUGEPAGE is not
> defined.
>
> .../mm/damon/vaddr.c:440:8: warning: unused variable 'pmde' [-Wunused-variable]
>   440 |  pmd_t pmde;
>       |        ^~~~
>
>
> >       spinlock_t *ptl;
> >       struct folio *folio;
> >       struct damon_young_walk_private *priv = walk->private;
> >
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -     if (pmd_trans_huge(*pmd)) {
> > +     if (pmd_trans_huge(pmdp_get_lockless(pmd))) {

Oh.. I miss this. Many thanks..!

> Thanks,
> SJ

Many Thanks..!

---------
Sincerely,
Levi.
