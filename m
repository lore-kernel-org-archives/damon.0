Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790D7C
	for <damon@lists.linux.dev>; Wed, 21 Sep 2022 03:30:07 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id ay36so3556400wmb.0
        for <damon@lists.linux.dev>; Tue, 20 Sep 2022 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=56+9vK6+9Zc0jZec7X5/qk5UPRRtfTDGK1I5XcbnItc=;
        b=nErNZQUgcNufXSE8BUWNJuAKxo7Q+Zg94NoK1Pf4O6rPrEwzsJu4Z8+JkOIsXjBa/q
         xEOgvvWvp0TPgfuJ0z8SMHfXsQZo41jsWyM/43rPIPKN2/rXlIF8/3Fjb0L9vVS5EhVp
         Cuu3JZOKqjVVAwXwlzGCV7BCSZXFn7JnqnICWz7k4n/IgQczIUcqk2zIprenEncSp8K6
         MhPuh2vcFx3ATfe/Wj1r8GSct90u/7XzIjk6xCVTre6gQzYcdOtwPitpTSv0UInS5y0b
         Tf+5UH0YbyyIxCejJ/RId6PBAwz5K7j22caIcmKLNpKxDY52Fk2hc2VLCaNdg7Q5W4JK
         mo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=56+9vK6+9Zc0jZec7X5/qk5UPRRtfTDGK1I5XcbnItc=;
        b=JBnvtEagCu8QzvenwIiTaYR6AawaLnJFzp2JHK5DdaEKsFn74+LMDzNChRura6Dl0J
         zAEpD+fbRCjLjfnivXwntsKkQ7YwkLWYBnrGf5SkwBMa7Lj5VQUSFgN8ziDTVIAXAJ1Y
         LznkWG+CBvV+b2g4e98dB7hBcZNEhJwV/WA16A9TswbG2KZLm5gJfZmOTKWTwFzOnRAF
         Ec4gVcBCFIvurpkHjQYJ67HE1EJe0iJ9boTY+7m79vmEROfJ7C1Qzq38SXO+JMAJiXs4
         h7OI/vWAqiISEAu5/iq6GQk1P2RUuWMOpsl0NIwqHbeWSk1Gk0XPsCw2jDPX1EOhxRko
         BF5Q==
X-Gm-Message-State: ACrzQf1BQl+1gpNMEMId+fPpY4EtfqP+pBAyc1yj/PcJlmBl7Q0ufvIX
	MQ00PnN3OOSqldxlyqT0D76LZCyWtW8/qL7YW6yy5eqm3Q==
X-Google-Smtp-Source: AMsMyM5MkIkfbX8ti06vv/pyhUf8jnriKf/fmUSk41UTtg4/FCjgcpmrDxt3qx8Qd8AIP4YPOMlOynAjNWknNY3FRZg=
X-Received: by 2002:a05:600c:1909:b0:3b4:aa30:40df with SMTP id
 j9-20020a05600c190900b003b4aa3040dfmr4362300wmq.205.1663731005317; Tue, 20
 Sep 2022 20:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1663645461-21084-1-git-send-email-kaixuxia@tencent.com> <20220920164331.59056-1-sj@kernel.org>
In-Reply-To: <20220920164331.59056-1-sj@kernel.org>
From: Kaixu Xia <xiakaixu1987@gmail.com>
Date: Wed, 21 Sep 2022 11:29:53 +0800
Message-ID: <CAGjdHukGEje3yQqXSsk14SheJKy9S=qFBndWohbyi2C7=9JO-A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 12:43 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Tue, 20 Sep 2022 11:44:21 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The bodies of damon_{reclaim,lru_sort}_apply_parameters() contain
> > duplicates. This commit add a common function
>
> s/add/adds/
>
> > damon_set_region_biggest_system_ram_default() to removes the
>
> s/removes/remove/
>
> > duplicates.
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > Suggested-by: SeongJae Park <sj@kernel.org>
> > ---
> > v2:
> >  -change the common function name and add kernel comment.
>
> Adding a link to the previous version of the patch here would be very helpful
> for me.  Could you please do so from next time?
>
> >
> >  include/linux/damon.h |  3 ++-
> >  mm/damon/core.c       | 35 ++++++++++++++++++++++++++++++++++-
> >  mm/damon/lru_sort.c   | 13 +++----------
> >  mm/damon/reclaim.c    | 13 +++----------
> >  4 files changed, 42 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index e7808a84675f..ed5470f50bab 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -557,7 +557,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
> >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> >
> > -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
> > +int damon_set_region_biggest_system_ram_default(struct damon_target *t,
> > +                             unsigned long *start, unsigned long *end);
> >
> >  #endif       /* CONFIG_DAMON */
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 9c80c6eb00c2..9e96cb9fb5db 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1245,7 +1245,8 @@ static int walk_system_ram(struct resource *res, void *arg)
> >   * Find biggest 'System RAM' resource and store its start and end address in
> >   * @start and @end, respectively.  If no System RAM is found, returns false.
> >   */
> > -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
> > +static bool damon_find_biggest_system_ram(unsigned long *start,
> > +                                             unsigned long *end)
> >
> >  {
> >       struct damon_system_ram_region arg = {};
> > @@ -1259,6 +1260,38 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
> >       return true;
> >  }
> >
> > +/*
> > + * damon_set_region_biggest_system_ram_default() - Set the region of the given
> > + * monitoring target as requested, or biggest 'System RAM'.
> > + * @t:               The monitoring target to set the region.
> > + * @start:   The pointer to the start address of the region.
> > + * @end:     The pointer to the end address of the region.
> > + *
> > + * This function sets the region of @t as requested by @start and @end.  If the
> > + * values of the two pointers are pointing to are zero, however, this function
> > + * finds the biggest 'System RAM' resource and set the region to cover the
>
> s/set/sets/
>
> > + * resource.  In the latter case, this function saves the start and end address
>
> s/address/addresses/
>
> > + * of the resource in @start and @end, respectively.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +int damon_set_region_biggest_system_ram_default(struct damon_target *t,
> > +                     unsigned long *start, unsigned long *end)
> > +{
> > +     struct damon_addr_range addr_range;
> > +
> > +     if (*start > *end)
> > +             return -EINVAL;
> > +
> > +     if (!*start && !*end &&
> > +             !damon_find_biggest_system_ram(start, end))
> > +             return -EINVAL;
> > +
> > +     addr_range.start = *start;
> > +     addr_range.end = *end;
> > +     return damon_set_regions(t, &addr_range, 1);
> > +}
> > +
> >  static int __init damon_init(void)
> >  {
> >       damon_region_cache = KMEM_CACHE(damon_region, 0);
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index d7eb72b41cb6..efbc2bda8b9c 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -188,7 +188,6 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
> >  static int damon_lru_sort_apply_parameters(void)
> >  {
> >       struct damos *scheme;
> > -     struct damon_addr_range addr_range;
> >       unsigned int hot_thres, cold_thres;
> >       int err = 0;
> >
> > @@ -211,15 +210,9 @@ static int damon_lru_sort_apply_parameters(void)
> >               return -ENOMEM;
> >       damon_add_scheme(ctx, scheme);
> >
> > -     if (monitor_region_start > monitor_region_end)
> > -             return -EINVAL;
> > -     if (!monitor_region_start && !monitor_region_end &&
> > -         !damon_find_biggest_system_ram(&monitor_region_start,
> > -                                        &monitor_region_end))
> > -             return -EINVAL;
> > -     addr_range.start = monitor_region_start;
> > -     addr_range.end = monitor_region_end;
> > -     return damon_set_regions(target, &addr_range, 1);
> > +     return damon_set_region_biggest_system_ram_default(target,
> > +                                     &monitor_region_start,
> > +                                     &monitor_region_end);
> >  }
> >
> >  static int damon_lru_sort_turn(bool on)
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 3d59ab11b7b3..162c9b1ca00f 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -144,7 +144,6 @@ static struct damos *damon_reclaim_new_scheme(void)
> >  static int damon_reclaim_apply_parameters(void)
> >  {
> >       struct damos *scheme;
> > -     struct damon_addr_range addr_range;
> >       int err = 0;
> >
> >       err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
> > @@ -157,15 +156,9 @@ static int damon_reclaim_apply_parameters(void)
> >               return -ENOMEM;
> >       damon_set_schemes(ctx, &scheme, 1);
> >
> > -     if (monitor_region_start > monitor_region_end)
> > -             return -EINVAL;
> > -     if (!monitor_region_start && !monitor_region_end &&
> > -         !damon_find_biggest_system_ram(&monitor_region_start,
> > -                                        &monitor_region_end))
> > -             return -EINVAL;
> > -     addr_range.start = monitor_region_start;
> > -     addr_range.end = monitor_region_end;
> > -     return damon_set_regions(target, &addr_range, 1);
> > +     return damon_set_region_biggest_system_ram_default(target,
> > +                                     &monitor_region_start,
> > +                                     &monitor_region_end);
> >  }
> >
> >  static int damon_reclaim_turn(bool on)
> > --
> > 2.27.0
>
> Other than above mean and trivial comments,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> As the comments are only for trivial grammar things, I will revise and post one
> on my own.
>
Thanks for your detailed comments!

Thanks,
Kaixu
>
> Thanks,
> SJ
