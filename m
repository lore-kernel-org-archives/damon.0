Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC08F51
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 23:45:36 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3e78d07ab4fso133392237b3.9
        for <damon@lists.linux.dev>; Wed, 07 Dec 2022 15:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXsz6/Icjh465llNxu4s0rXYIhAO+R+B34XNkGIo6eQ=;
        b=Be1pHwvM4e7ouSG+ZY6N9k/NiEQ4tzzDVuXyq4CEbwd9ADrS9FJ3QaPyXtXz2d1OdS
         qYzdxL6v4h/5A9aQJcky67nIla75qGdrJ85MwA1KqQc3qgPS4YtS4Vut3e6qnGU82G3o
         lQHWwLuJtztifl8vYx5gAgBC8BNMgctCbp72zj3JslJx5k3nQosHW4HKSGteEit76fR3
         Yc0mGCeHk7bo4xicAjtUfwALdzwuGnKwQvDu1x0nLwq6Qb3WzoqCxfZ4zEUbgJXsd/oH
         bmeiO9/QSI7+8qvg60KDx7Ti9ptHefiR2pn2ij2Gs6XWpl2Ld/c0+UgyzbpAfe7ooJHE
         Ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXsz6/Icjh465llNxu4s0rXYIhAO+R+B34XNkGIo6eQ=;
        b=LnVz2+zzrcyAl12axkDrrPQ4Ou/vp8JWF1PdFiudNLSPHv6rryEYzWQgtK9tWxLZBT
         tG18t8ObU2EKOj01q+3EwRpNXIQfM687Gp84JHcoye6IHNnSvKiEoaCW5QA/VHP2+iRM
         099T9VeW7oKc/IJkNE0BS2l+d9c4R3+TmHSCqUTiDpOtWGJ+rxf/2z+K2uIozR+CBHo+
         fVOXMRtWr+lRcHZSoPON8El9IUNAOFtBPuGp+SvfJN50etPe8w1gNi8in+RTKdLA01NQ
         xRaQY2AWvyqqScLwAC0u16SPluHjIq8/q3+qphv108NkOsh0+eN9Wak8BR+HvQyyGK2s
         Sksg==
X-Gm-Message-State: ANoB5pnRvxIMXsm72DR/uT2IMkN5wAREQgKT8HnkH4I6xfQZ+Q5AS5Me
	N9hds5oSrnwqcFCTO89ugjmEnSr4RIPDIhcBu2Y=
X-Google-Smtp-Source: AA0mqf52bzfVlI6LIM25NDvI3hhBqrvEmEgMvsJj/HL3v965u91m6cU3HIkbbbsGBTFyKyJOp/lVfoCS00snfAfx8RU=
X-Received: by 2002:a0d:cb43:0:b0:368:e8a:3b1d with SMTP id
 n64-20020a0dcb43000000b003680e8a3b1dmr21578440ywd.469.1670456735268; Wed, 07
 Dec 2022 15:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221207230152.22938-1-vishal.moola@gmail.com>
 <20221207230152.22938-2-vishal.moola@gmail.com> <Y5EdR1l1Ho3FyrY3@casper.infradead.org>
In-Reply-To: <Y5EdR1l1Ho3FyrY3@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Wed, 7 Dec 2022 15:45:24 -0800
Message-ID: <CAOzc2pynRnO9ME5L2VohYUU_qSWcL14cwBsGPNGWW7XJPVo3HA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] madvise: Convert madvise_cold_or_pageout_pte_range()
 to use folios
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 7, 2022 at 3:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 07, 2022 at 03:01:50PM -0800, Vishal Moola (Oracle) wrote:
> > @@ -424,28 +425,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >               page = vm_normal_page(vma, addr, ptent);
> >               if (!page || is_zone_device_page(page))
> >                       continue;
> > +             folio = page_folio(page);
>
> Maybe we should add a vm_normal_folio() first?  That way we could get
> rid of the 'struct page' in this function entirely.

Yeah, I'll do that. Many other callers will benefit from it later as well.

> > @@ -453,13 +455,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >               }
> >
> >               /*
> > -              * Do not interfere with other mappings of this page and
> > -              * non-LRU page.
> > +              * Do not interfere with other mappings of this folio and
> > +              * non-LRU folio.
> >                */
> > -             if (!PageLRU(page) || page_mapcount(page) != 1)
> > +             if (!folio_test_lru(folio))
>
> Why has the test for folio_mapcount() disappeared?

Oops, that page_mapcount() should have been replaced
with a folio_mapcount(). It appears I accidentally removed it.
