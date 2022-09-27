Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DA7B
	for <damon@lists.linux.dev>; Tue, 27 Sep 2022 01:52:55 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3454b0b1b6dso86974197b3.4
        for <damon@lists.linux.dev>; Mon, 26 Sep 2022 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Z6mwGmWFe8kc9REvRMpgAR4kMVMlolmnZnXb+8WIi+s=;
        b=KrczsANKZsMTyMklSFvkrdvxJgxIFI9kJDdLp/RYNJ9YvtGYD9R9MKHZ0WZ0lg57xX
         qzCY3744UirNxRKftxwvbkH/QscgxysOQHIllQ4wmOvumns+waBQ3rfoqG3YWj8t8Q/V
         jClKe0yY8Iz7O7VfocOX5ypMwSLaOmywHHlYCR+IMzWLatpVNqGJinBmar9ctO+njQgx
         2aKdMhZrj4Me8wmnJXW485T7m8DL1twJWkK4VYCLr/Pv0ECL0024G9CdkKlRWIEeg7gL
         YbtPq18WroXJfgls+3eyVXT3V1rPg3xZgrgCYxdS3RyNpYIS+6IXLCMpfYaGFifITt4F
         27Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Z6mwGmWFe8kc9REvRMpgAR4kMVMlolmnZnXb+8WIi+s=;
        b=lrbEuUpVuFg5ihIUIrK+ZZMmVZ8dWV9u9Z6bEtAxakpHtXobkj5LzuDuII2qiu6Lcw
         RsDkNaA6s+VwsSJIUZpLs9UwWpexYHKENKYn3TEDlO62o3aFiJakvLEwMZPlg0uAKWSo
         qnMAfvZrK8Dd5/THR+1Ez+IAlQcnGnVOxOaaXNIvu4AvoD0TyvQktBgjp49JRQ7yykUo
         DN1NGRydgBNVT5a8xeacdVHMyQBYGdlht+iROgBxe5qlx/hIW/yniNBIig6ur9Xkp9Y3
         80nAqoCbIM6PjA33iw7eXb4gbL1Eiaq5DsJeMmqcIC8QyfhdfHNzUllCGr7VSAdUjN4o
         Vsdw==
X-Gm-Message-State: ACrzQf25kEObyGXFYdEDCLv9G8EkcVHck5/Tv6TjxakIkeB/MbZad/JY
	z2tQKzaWtf3Pd8zOsBUIuLOg5Ni2twoK2VGzNOQ=
X-Google-Smtp-Source: AMsMyM6gAGGPR+PUOGrG4fFfhdSS86IMK5BBfOlEWtVx3KSbpPeZbjLW4xppB3pBN6UZOgIWqHfGVp6f+kPtGEHGUaI=
X-Received: by 2002:a81:6a05:0:b0:349:fad4:37cf with SMTP id
 f5-20020a816a05000000b00349fad437cfmr23936253ywc.137.1664243574189; Mon, 26
 Sep 2022 18:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220926160611.48536-1-sj@kernel.org> <20220926162326.49013-1-sj@kernel.org>
In-Reply-To: <20220926162326.49013-1-sj@kernel.org>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Tue, 27 Sep 2022 10:52:42 +0900
Message-ID: <CAM7-yPQ-HnFP_h5x-yxLMVkktZ7rRtLf5TQi1Hz6pr9h_2+iKQ@mail.gmail.com>
Subject: Re: [PATCH v4] damon/sysfs: Fix possible memleak on damon_sysfs_add_target.
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks :)

And Sorry to my mistake.

On Tue, Sep 27, 2022 at 1:23 AM SeongJae Park <sj@kernel.org> wrote:
>
> I forgot removing the closing dot of the subject and making the subject
> lower-case.
>
> On Mon, 26 Sep 2022 16:06:11 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> > From: Levi Yun <ppbuk5246@gmail.com>
> >
> > When damon_sysfs_add_target couldn't find proper task,
> > New allocated damon_target structure isn't registered yet,
> > So, it's impossible to free new allocated one by
> > damon_sysfs_destroy_targets.
> >
> > By calling daemon_add_target as soon as allocating new target, Fix this
>
> Also we should s/daemon/damon/
>
> I will revise and send v5.
>
> > possible memory leak.
> >
> > Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
> > Cc: <stable@vger.kernel.org> # 5.17.x
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >
> > Changes from v3
> > (https://lore.kernel.org/damon/20220925234327.26345-1-ppbuk5246@gmail.com/)
> > - Fix Fixes: tag
> > - Add patch changelog
> >
> > Changes from v2
> > (https://lore.kernel.org/damon/20220925234053.26090-1-ppbuk5246@gmail.com/)
> > - Add Fixes: and Cc: stable
> >
> > Changes from v1
> > (https://lore.kernel.org/damon/20220925140257.23431-1-ppbuk5246@gmail.com/)
> > - Do damon_add_target() earlier instead of explicitly freeing the object
> >
> >  mm/damon/sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 455215a5c059..9f1219a67e3f 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -2172,12 +2172,12 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
> >
> >       if (!t)
> >               return -ENOMEM;
> > +     damon_add_target(ctx, t);
> >       if (damon_target_has_pid(ctx)) {
> >               t->pid = find_get_pid(sys_target->pid);
> >               if (!t->pid)
> >                       goto destroy_targets_out;
> >       }
> > -     damon_add_target(ctx, t);
> >       err = damon_sysfs_set_regions(t, sys_target->regions);
> >       if (err)
> >               goto destroy_targets_out;
> > --
> > 2.25.1
