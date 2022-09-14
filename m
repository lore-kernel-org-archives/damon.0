Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96815D5
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 04:02:19 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id c11so23660561wrp.11
        for <damon@lists.linux.dev>; Tue, 13 Sep 2022 21:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sb7rAbJZuS+StHRfXIZQwRnlRn6aCsFhpXPXtu19SaQ=;
        b=WcFpC1SKt4w7D427YmJ5Tdrd9kMBFrENC/xVio9ndDXv7ugPFzvlaqss6cwGm3PSy4
         0RReYbd2KtIqubWe2dAuGIaSWON4ImCNrAGWxG043j2zg0iUfaVoui3LYf+MpEKE1my4
         vOq4BFvk4hnEPlGfyvU65nLJUR5VengC673opgX8gRY0Gu6rxeyeTE59kSLbGTcH8FvL
         S3cjxj10MxzMNN3FBboqWWhbgbRVCcJ0vWfHqlCbrZMrzNMPvpO1yteL0XNWajeRWjE2
         FHGlnfpHl5RQe6tF+jfJOPa2uip6r39wnJetNlVRGvd5o4VbOO7hP+IV9LLczjgj1Akg
         h0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sb7rAbJZuS+StHRfXIZQwRnlRn6aCsFhpXPXtu19SaQ=;
        b=0J4NASQKhSrKDzeGHDblOjt4dNvjZxKNSlMusb4uP3I3DNIcHy4/l1yMHup72mQx7y
         gmiqUXbCgYpkOHsjn6RIjIQCArojTEM/wpmm/4Q0q2raml9XzEfOfLw3IhQyzY/JfeNv
         1Lx53VxRTmh4y1a2nYOBNJUc/880K1vU3sGL07b2zpaZTWTMawLpsIm/Mz0+1c+vQQLY
         Yl1Z/orCGvqH/r8rcwQ4A1CU0IKAvOKeIitNZqngVkE9Nn9F+4+5ukQcrXRfV10Abxsd
         o+nvUgwpLJoDSGlJ+O26ere6dhUMlaujvgnwyWXXEhuCsYtZfmgbhO1JO/VJD/EcYbjL
         6TJw==
X-Gm-Message-State: ACgBeo0kd1yS7oA4gX9f5BHEqJEIzBt4TsgMTcwmM0Ubi642dNS0KwVq
	a8L6nJJXBidkLfC+UhnQcIXG2yg0CLk//qU3G5KJdjWQVkrV
X-Google-Smtp-Source: AA6agR78iSAq9l5/YpX1vG1o7mn5nkeDb44f9QKmbUjxBORze5ZAHwUvoZc3FqrpklNof5cdYldFtGBx9yoIHcIX4S0=
X-Received: by 2002:adf:8b07:0:b0:228:da7c:80ee with SMTP id
 n7-20020adf8b07000000b00228da7c80eemr19716209wra.25.1663128137340; Tue, 13
 Sep 2022 21:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1663060287-30201-5-git-send-email-kaixuxia@tencent.com> <20220913151114.103184-1-sj@kernel.org>
In-Reply-To: <20220913151114.103184-1-sj@kernel.org>
From: Kaixu Xia <xiakaixu1987@gmail.com>
Date: Wed, 14 Sep 2022 12:02:05 +0800
Message-ID: <CAGjdHu=8pGmyBpVMpf-V=6w7hZHLmG4WH5EsNchn_+GqikTDxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/damon/vaddr: indicate the target is invalid when
 'nr_regions' is zero
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 13, 2022 at 11:11 PM SeongJae Park <sj@kernel.org> wrote:
>
> On Tue, 13 Sep 2022 17:11:27 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > When 'init()' and 'update()' DAMON operations failed and the number
> > of the damon_target regions is zero,
>
> Well, I think that could be a temporal failure.  In the case, later call of
> 'update()' could success?
>
Yeah, the kdamond while() loop calls 'update()' periodically to fix this
temporary failure. But for extreme scenarios that 'update()' continues to fail,
we should have some ways to detect this case.

Thanks,
Kaixu
>
> Thanks,
> SJ
>
> > the kdamond would do nothing
> > to this monitoring target in this case. It makes no sense to run
> > kdamond when all of monitoring targets have no regions. So add the
> > judgement in 'target_valid()' operation to indicate the target is
> > invalid when 'nr_regions' is zero.
>
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  mm/damon/vaddr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 39ea48d9cc15..65ff98d49ec0 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -598,6 +598,9 @@ static bool damon_va_target_valid(void *target)
> >       struct damon_target *t = target;
> >       struct task_struct *task;
> >
> > +     if (!damon_nr_regions(t))
> > +             return false;
> > +
> >       task = damon_get_task_struct(t);
> >       if (task) {
> >               put_task_struct(task);
> > --
> > 2.27.0
