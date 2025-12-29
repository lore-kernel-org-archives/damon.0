Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0442264A9
	for <damon@lists.linux.dev>; Mon, 29 Dec 2025 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766979551; cv=none; b=bq/FV6hr4dFjcZ5KtbMt4HqSQYk9aZAVOYLZTkeAJ+5K46wFIFTyycXd6TJ+iWqHgvIAu8i27VHGpzw64C7LsTPlp6mHjnBkRrD8n4oOdpntLPEDXREErkY4tSfMa6kN3l8ZemHShlPrlweMwKGd8B+iH7GAB2PQrwPTYYqKc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766979551; c=relaxed/simple;
	bh=zFVZi6DOjACsavzTRTR+p7X7w2BGWdvRIIRhA0FpJQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojvIiyhGJZIpUOUPjPXS/88STFT2wqMuQ4Bp+sGG9dTPeXvgJQEEGEjFD01IZKtS4oWvfhonVOLKhTUkTNtPFV35W51AdWNyJ7e9nrmpybIth9+VMClDgZ92zAiNBFBasyUYxEJfszRPsSu2PZ7SG7GA3oB7MFXJJdPPRNE8QUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf4wg/m3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf4wg/m3"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-786a822e73aso76127497b3.3
        for <damon@lists.linux.dev>; Sun, 28 Dec 2025 19:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766979549; x=1767584349; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec38jWe/KrrUFJROzDPN7mPmD+4inQ2VXMt0xla13TE=;
        b=Lf4wg/m3LGruQs5zEmSOLBH4w35POs3LQ5n73mQDuo984Wuk2opdcmWAnJw9D12G1P
         Qs28bvFgUjOtTNKggSnQy619uJ15GaTTx/5tZNBA8e3Xg3WZM4mF3ZA72SrxEy38/E75
         qax9nvVTGVLIgjzZmqGJ4LakpnC5AqGQsZV0/tt6cUrZawXkkOOGuRY8jdWMNnErRQkK
         Gc3WUlb0ik8B7xb5PBLZ2xWLgb/md3MZALmTbUPPVl0lvWNwIUC4CyBvyEXRW+0ojBKr
         T6+Loc8XG+S6NswKRZqX/+ICH8Z3dBHgIYubZ1ero9DzGKroQs/6EZwHv8/gAQ1d5bdZ
         tSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766979549; x=1767584349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec38jWe/KrrUFJROzDPN7mPmD+4inQ2VXMt0xla13TE=;
        b=TeVXVAvhF48mwgxMFDhVWvuBxV+iLGJSKcOrOsadc4UZQ5RajdFF3BsQ7Fb3HXXDNG
         id5vad54rmky3oj/YbH0JqZpeRyGlAsNASc9NKUsPQdNo/GXlVjHlPOZDhHzU9SGSjq5
         Aq1KW3YuEZxHDhdSh/peqM99qWzt30/W5eby8ORt2N6oWFcy0lyQp+hHlWBNgELbfRJ4
         9FfSc1h0y3JhRnFLr0UD6sk804Hxtu0gfTABkjFcDfd+hRlYzj7QN+B0hrNBVZa+OBcb
         x7B/iqdFT6DI5t7H4BUZk8bfm+hx1j22iM/HE0PNsVhlxu8KxQOcKZcyAbZ4UvPuGDk6
         9iRw==
X-Gm-Message-State: AOJu0Yyk9709wCdw58JiBAQceUs+wiIT/N3x6kDFs48WK+XK4YVzQ4Fj
	gtLpuOwLtMppBTV20ofRWb/Mp7jawc3ljLcKUrjQo9zPEoFmMHL0mRZoxMlVFFoSmA2Z97VcmfS
	E338wJp/WELVQgFqEki6I5YOBcpPeb0+adF8ui6Y=
X-Gm-Gg: AY/fxX415XCIUgPAg2jVqnHymOfOmb+nVHCqLELq3iTi+TK+yDq9bAn3eHH0QwORmEJ
	MjHFDhxQJ/YtmNxrSvf95GRCYrm8ANB0mbx82ez2X+v9eJ7nZ58c1FqFZWj6mqXLVbyoieAHQl2
	NdX7gEnwcUl99P3l/IzRKBZ8AliYSpCPxUtp05Z+dXUBrJoyhCUQdB45eao+xrDTjmQHrj41Ip3
	DmimS4vmR+DAaTn8by5ma5J2sMJpRMog+iBXhdmNndYyH/jiwPKMf+u6kmB3d+civyNVIx4
X-Google-Smtp-Source: AGHT+IGMny9fg2k7Qgju0UYglg0kRUQjni0y2DiDufbvlgIlQAJlK2OlV8/96K2ETe8W7aLi49b3kLRDvZ1JRDHcJ+c=
X-Received: by 2002:a53:b549:0:b0:645:6c99:bf17 with SMTP id
 956f58d0204a3-6466a8afe74mr19566506d50.52.1766979549111; Sun, 28 Dec 2025
 19:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC7HqeGY1uxy7FxLKTFHAJPcWWbKJRjZ06W9bC4oAejOsw@mail.gmail.com>
 <20251227174239.273581-1-sj@kernel.org>
In-Reply-To: <20251227174239.273581-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Mon, 29 Dec 2025 12:38:58 +0900
X-Gm-Features: AQt7F2osd3IZrYaArYmRyOWBHGQGj20PD3b4hoISM9vUO7_MR3MY1NQLMXu3mg0
Message-ID: <CAHOvCC7KAmj8hb8GtTJ+P_GUGqjP1WO8uqnpFjMPQmKFrc1oZw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at
 the damon_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Dec 2025 at 02:42, SeongJae Park <sj@kernel.org> wrote:
>
> On Sat, 27 Dec 2025 08:53:21 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Sat, 27 Dec 2025 at 03:41, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Fri, 26 Dec 2025 10:48:31 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Fri, 26 Dec 2025 at 04:50, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > On Thu, 25 Dec 2025 11:35:33 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > > >
> > > > > > On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
> > > > > > >
> > > > > > > Hello JaeJoon,
> > > > > > >
> > > > > > > On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > [...]
> > > > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > > > index babad37719b6..2ead0bb3c462 100644
> > > > > > --- a/mm/damon/core.c
> > > > > > +++ b/mm/damon/core.c
> > > > > > @@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
> > > > > >   */
> > > > > >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> > > > > >  {
> > > > > > +       if (!damon_is_running(ctx))
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > >         if (!control->repeat)
> > > > > >                 init_completion(&control->completion);
> > > > > >         control->canceled = false;
> > > > > > @@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > > > damon_call_control *control)
> > > > > >         mutex_lock(&ctx->call_controls_lock);
> > > > > >         list_add_tail(&control->list, &ctx->call_controls);
> > > > > >         mutex_unlock(&ctx->call_controls_lock);
> > > > > > -       if (!damon_is_running(ctx))
> > > > > > -               return -EINVAL;
> > > > > >         if (control->repeat)
> > > > > >                 return 0;
> > > > > >         wait_for_completion(&control->completion);
> > > > >
> > > > > Let's assume DAMON is terminated between the damon_is_running() and
> > > > > list_add_tail().  In the case, the control->fn() will never be called back.  If
> > > > > control->repeat is false, this function will even inifnitely wait.
> > > >
> > > > As you said, there are cases where kdamond is terminated(stopped) in
> > > > damon_is_running() and list_add_tail().  It may be a very rare case, but
> > > > I missed this case.
> > > >
> > > > >
> > > > > I think we should keep the damon_is_running() as is, but further check if it
> > > > > was terminated without handling the control object, and remove it from the list
> > > > > in the case.  Like below.
> > > [...]
> > > > However, the damon_call_handle_inactive_ctx() function is to post-process
> > > > the duplicate addition of control->list.  Rather, it is more efficient to
> > > > prevent duplicate additions in advance, as follows:
> > > > I have tested the following and it works fine.
> > > >
> > > > @@ -1467,11 +1496,14 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > damon_call_control *control)
> > > >         control->canceled = false;
> > > >         INIT_LIST_HEAD(&control->list);
> > > >
> > > > -       mutex_lock(&ctx->call_controls_lock);
> > > > -       list_add_tail(&control->list, &ctx->call_controls);
> > > > -       mutex_unlock(&ctx->call_controls_lock);
> > > > -       if (!damon_is_running(ctx))
> > > > +       if (damon_is_running(ctx)) {
> > > > +               mutex_lock(&ctx->call_controls_lock);
> > > > +               list_add_tail(&control->list, &ctx->call_controls);
> > > > +               mutex_unlock(&ctx->call_controls_lock);
> > > > +       } else {
> > > > +               /* return damon_call_handle_inactive_ctx(ctx, control); */
> > > >                 return -EINVAL;
> > > > +       }
> > > >         if (control->repeat)
> > > >                 return 0;
> > > >         wait_for_completion(&control->completion);
> > >
> > > I think this is not differnt from your previous suggestion, and thus it has the
> > > same issue.  What if DAMON is terminated between damon_is_running() and
> > > list_add_tail() call?  Please let me know if I'm missing something.
> >
> > I think it is good idea to insert a barrier() between damon_is_running()
> > and list_add_tail() to prevent context-switching.  What do you think this?
>
> I don't think barrier() works in the way.  Please correct me if I'm wrong.

Yes, there is no need to use memory barriers.  Since each kdamond runs
its
own damon_ctx, the concurrent access problem can be sufficiently
solved with
mutext_lock.  The problem discussed so far can be solved by applying
mutex_lock to both ctx->kdamond and ctx->call_controls.
Please refer to the modified code below:

@@ -1496,14 +1502,15 @@ int damon_call(struct damon_ctx *ctx, struct
damon_call_control *control)
        control->canceled = false;
        INIT_LIST_HEAD(&control->list);

-       if (damon_is_running(ctx)) {
-               mutex_lock(&ctx->call_controls_lock);
+       mutex_lock(&ctx->call_controls_lock);
+       if (ctx->kdamond) {
                list_add_tail(&control->list, &ctx->call_controls);
-               mutex_unlock(&ctx->call_controls_lock);
        } else {
-               /* return damon_call_handle_inactive_ctx(ctx, control); */
+               mutex_unlock(&ctx->call_controls_lock);
                return -EINVAL;
        }
+       mutex_unlock(&ctx->call_controls_lock);
+
        if (control->repeat)
                return 0;
        wait_for_completion(&control->completion);

>
>
> Thanks,
> SJ
>
> [...]
