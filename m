Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A42B2DA
	for <damon@lists.linux.dev>; Fri, 26 Dec 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793215; cv=none; b=OOZSSvtqAc75jlQhgdmNOa6T/qWdO9KSYumGHTdowX1hr1b87B/oDOMdI8esIxtXXzdy7SQBFWgXoJxXEgxS2DFwpvK2vMqyBhzcwbcRz1PtZeLjMX5gFrXUS14bMHnb+9m1nmn0+rD17gOXFWbuo3As0shAKy8RP8R8KOevzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793215; c=relaxed/simple;
	bh=hov6AVhV5b5XsGFbd5CK+f1wMm5hJtZzruAXbkOy6rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITx5X31n9Li7j0kqViXc2ZXhELInbxKQNcE0DH9aTYDuLQrwDBjO/cngeSdSJ9Po7wTVg6CctjzG7y5EM/YsbEvDUF7t3gzWs3XlR8IxFHTGM6sHUK/DdEpVsS0ZGqWOTfCGNcWxbllGe0v2E5hAmaVmIqRra+UOs7hQXwTV7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loxwqfxC; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loxwqfxC"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64472ea7d18so4943837d50.2
        for <damon@lists.linux.dev>; Fri, 26 Dec 2025 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766793213; x=1767398013; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JTcSmilid40WVSQLI0qecHKHI64cGOCVGN86fIcYR8=;
        b=loxwqfxCZ6hWz+keRRztovK3WHDyem4YSSu6DXUVU/sLMP3cxXnwclxM14OSdR/PRB
         6ow542sSSwmTnHMJc3Ic4QlYIqBgrT/y4FoknW7Db1ve3jzMRDOtaC1txNUE3mYtRwUL
         ddsZUKzOetL+oJhpDwG7oRZEk2TNw+f6LXZ/HstwkUVpXI3LAgCbpGsSN6UtEbdsRSLx
         kzrVePgsw4px9DOrli8+J0P4qhzeU9kSVtb1wMvYH4LO+N4XpC72HE/M/Io629AU3xHH
         lghefoKLAxlsY92Vp3ouuxPiawyOU/56m2K6O6QCuptMNmdbHZY5VS+aN2OHXu4La3f4
         WX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766793213; x=1767398013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JTcSmilid40WVSQLI0qecHKHI64cGOCVGN86fIcYR8=;
        b=T7dvCmBnYe2lbSlGGPDWlgGvcMHPduEA7EjtBPIYq9EHvajd4XZCJvSEj5rlasRQxi
         aWQ+3VoJTqCyyOvQ8xwK0Ez1ML/4Ju0LpYeiFGgwH93/otYDq3obPXrWW5FIBGlyQdz5
         AuOwfxA3oUHKOGwV86dx7uXdhYPc2eovLy98BUIQuaqqgfL4f9Eubv+WuB0241I9nOtE
         NH9PNIcoHqvYd9H9o0fF011v4ak0i/SK1dsvI3BRrnHo38htbIW4ObSs9X7orsjPRCiA
         gPau3MEMbdldYvPalds1EI6TP035VhFz0MYqMerM7LAAfXfQWKTwZFbAKZp4Z/iB8VBN
         HfSw==
X-Gm-Message-State: AOJu0YwGQsKEQdBzz6naWBwcvpc4vbrlHBjN7pVsKHoV9XoH9h8I/8e3
	yn/PdyxtyBxM8X9cVauZGnLTVMgnL6B08QlGw7zQ18zvgCwCYn6I+6iJjLT7Ad73MA3+BrdRoEa
	utWs9Om+0GrsG9AVPD9PhG+6oM21cMgA=
X-Gm-Gg: AY/fxX6WfrjKCQAdivtdmfw02fX7Ff8hA7J/M1x27+5bCPvM4cD/ggSRD/mtqPjjtn6
	NXNLyyXYpeCKG+hyD1hlg30fKp0KIkM3v9eyDUeLHNX4ksc4K83iyrj/rPKrtUSm1QSeKcrLCKX
	q4Uwj05x78xN9AfEgzwd65mFg1+N/rGtzikRSj443uLSFEBxQTqCsnMr+7+Qy6efywMoeiLjH+p
	dsWDQ2XHJXz9jp/DI/ZqXetgTReiqLXZmzrGEK8+gzrCQp/jKilu7aOiOqCE2dPzUjC0P6aY96I
	+xJxQhY=
X-Google-Smtp-Source: AGHT+IEAZAGqF9F6MxR1VLl7olkR5UmCPFUFao00Law/8wX3U6qC8XMgr6p+96BB+k6/+ca/7seKX62CnzUkAcpJmvg=
X-Received: by 2002:a53:adc3:0:b0:641:f5bc:6983 with SMTP id
 956f58d0204a3-6466a8c568amr15091028d50.79.1766793212876; Fri, 26 Dec 2025
 15:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6PQKAK5WojmVFqBw0V-TZ+11CM_2uq4z8TxsyEu3gLVQ@mail.gmail.com>
 <20251226184111.254674-1-sj@kernel.org>
In-Reply-To: <20251226184111.254674-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 27 Dec 2025 08:53:21 +0900
X-Gm-Features: AQt7F2qKCfyxqagV7UlDOzpbncHuGGXw7tVVuiMUC6LDgDSt7Cv44S0l7SIN9po
Message-ID: <CAHOvCC7HqeGY1uxy7FxLKTFHAJPcWWbKJRjZ06W9bC4oAejOsw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at
 the damon_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Dec 2025 at 03:41, SeongJae Park <sj@kernel.org> wrote:
>
> On Fri, 26 Dec 2025 10:48:31 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Fri, 26 Dec 2025 at 04:50, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Thu, 25 Dec 2025 11:35:33 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > Hello JaeJoon,
> > > > >
> > > > > On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> [...]
> > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > index babad37719b6..2ead0bb3c462 100644
> > > > --- a/mm/damon/core.c
> > > > +++ b/mm/damon/core.c
> > > > @@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
> > > >   */
> > > >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> > > >  {
> > > > +       if (!damon_is_running(ctx))
> > > > +               return -EINVAL;
> > > > +
> > > >         if (!control->repeat)
> > > >                 init_completion(&control->completion);
> > > >         control->canceled = false;
> > > > @@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > damon_call_control *control)
> > > >         mutex_lock(&ctx->call_controls_lock);
> > > >         list_add_tail(&control->list, &ctx->call_controls);
> > > >         mutex_unlock(&ctx->call_controls_lock);
> > > > -       if (!damon_is_running(ctx))
> > > > -               return -EINVAL;
> > > >         if (control->repeat)
> > > >                 return 0;
> > > >         wait_for_completion(&control->completion);
> > >
> > > Let's assume DAMON is terminated between the damon_is_running() and
> > > list_add_tail().  In the case, the control->fn() will never be called back.  If
> > > control->repeat is false, this function will even inifnitely wait.
> >
> > As you said, there are cases where kdamond is terminated(stopped) in
> > damon_is_running() and list_add_tail().  It may be a very rare case, but
> > I missed this case.
> >
> > >
> > > I think we should keep the damon_is_running() as is, but further check if it
> > > was terminated without handling the control object, and remove it from the list
> > > in the case.  Like below.
> [...]
> > However, the damon_call_handle_inactive_ctx() function is to post-process
> > the duplicate addition of control->list.  Rather, it is more efficient to
> > prevent duplicate additions in advance, as follows:
> > I have tested the following and it works fine.
> >
> > @@ -1467,11 +1496,14 @@ int damon_call(struct damon_ctx *ctx, struct
> > damon_call_control *control)
> >         control->canceled = false;
> >         INIT_LIST_HEAD(&control->list);
> >
> > -       mutex_lock(&ctx->call_controls_lock);
> > -       list_add_tail(&control->list, &ctx->call_controls);
> > -       mutex_unlock(&ctx->call_controls_lock);
> > -       if (!damon_is_running(ctx))
> > +       if (damon_is_running(ctx)) {
> > +               mutex_lock(&ctx->call_controls_lock);
> > +               list_add_tail(&control->list, &ctx->call_controls);
> > +               mutex_unlock(&ctx->call_controls_lock);
> > +       } else {
> > +               /* return damon_call_handle_inactive_ctx(ctx, control); */
> >                 return -EINVAL;
> > +       }
> >         if (control->repeat)
> >                 return 0;
> >         wait_for_completion(&control->completion);
>
> I think this is not differnt from your previous suggestion, and thus it has the
> same issue.  What if DAMON is terminated between damon_is_running() and
> list_add_tail() call?  Please let me know if I'm missing something.

I think it is good idea to insert a barrier() between damon_is_running()
and list_add_tail() to prevent context-switching.  What do you think this?

Thanks,
JaeJoon

>
> >
> > > If you don't mind, I'll post the above diff as a patch, adding a 'Reported-by:'
> > > tag for you.
> >
> > 'Reported-by:' is OK.  However, please check the above again.
>
> Thank you!
>
>
> Thanks,
> SJ
>
> [...]
