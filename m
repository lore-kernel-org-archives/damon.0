Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CBC2B9BA
	for <damon@lists.linux.dev>; Thu, 25 Dec 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766632243; cv=none; b=J3j4tySouP6ESSdv1OKoJoN3F9UUvOzu4qNR4kEVT+KnOkO8UOJhK9FG27jbwVF6uXqVrN9jmeyGk3aFLCILbTLn2ahRV1yweS84iQgjxmRx9xPiVq7PiA/4LXRXaGn35qW2l1u0G9TeAn6CEltbKyhwLcm8zH8DVTPPmYnkalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766632243; c=relaxed/simple;
	bh=GMeKFc7HrG1gZjIOYkj6QNzVDwfWLQLzwT56Ji1aOKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhaWebdasXpjqisJA4/h+QTEDW4p5oebTi+G488YPXUexpuZIoD39czGLyCS/xJzBjxnu7AZJPLkZf9iur/DB0jol8NY7FMe1k4TTdNHx/HY7GOlL8P8JkpsR2iB8DimmgWgIqtTCo0oC4H7A/sr6effR7SoScMQET2rSe2pQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMDYvB1w; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMDYvB1w"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64306a32ed2so5478372d50.2
        for <damon@lists.linux.dev>; Wed, 24 Dec 2025 19:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766632241; x=1767237041; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQpZi4UJdiEoSRKQp+EJ/hQpHOcHhJkN7UpOORPmbrk=;
        b=BMDYvB1wiOYLyOfS9yjE2xM7RvUa1hg6lG/IfVqRKE/wjbEEKrkY4QE6rHgGpd9Nfe
         2AxR+r7li4pPK7ml3DTT+fylVc2Cf1sW55mBzcuss5/nJW61pMQLSsy1iOkCOlxRiPyA
         JkC4e9QHlxGEKzcTclFFzhyCQfBNwcGEQBh7DnwK+navTxqZQR0B411ZlDDIwIDLVTIm
         PXM9GMTVwkF7FpWmhM09F2Tr6AnolxOsnBY5XWeRmrWwAZNDgcfybDll58s329be+L/S
         oUaJcsgqU5g3/3hex9+1B0iF2sZnsW83S9lUNnYp9hAAX42xh9w+FOyLFjyx0bDfERmD
         EX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766632241; x=1767237041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQpZi4UJdiEoSRKQp+EJ/hQpHOcHhJkN7UpOORPmbrk=;
        b=hINViPYlDad7Q1sBBi/+wht6SHV8dTMkEqzxG0U4+wJEt+CjDxn/9GveQzy+6w+tlR
         i0D1u6o9nYkUHvUffVFKCT8unkncyLNzcbpLrLmREWfEhC+vXlaQpSk/VQS/U8/gN/qa
         /0ONfGbi4x/OOzgYfahdvHtYCA5GeHbNv/3pBdXqGttiadMq6n5kjUz9/KAhYHGh2XVB
         aN4zMkQuRYylFLs5cnGo1hZomVAAeN3Q5bmLFDTgxlxyC4YXh0+4yw9r9NuN73Z8rv45
         n/GgQ+Wn62QgKtman4MET0JZY6rqH5xYTfCAYbC1CzeWrM+5c4j3P9RJ6FBcLVYNorVD
         N08Q==
X-Gm-Message-State: AOJu0Ywcvv93A3XfwkEuEk/EFd0MijNbIY0QFlJsl8iaSPE0FezXLmcN
	nqS8KYJ3vHCBjJwrFOGAcpiRUc7OCKn/QlJkh9VKfY3rCXQ4Loezk8e6kyM42Z21cfJ+ABSv3+M
	oq4+Dybe4H27vYDvgoT3vu+676eJtRK0=
X-Gm-Gg: AY/fxX7KWwnn0bz/6n3OMs03b3A1ZpqbI28vxBtieHzx88ygCxzCA9DdcyC3xKNbYyp
	HO5Vci+OqraC0dwMADnt7PUthUfZldS1JRPdAvd7p+xNFymjuVfHZs+j1/HdN/gMmA/FNio7gcT
	CU7t06MTNS8bXAZpTZ+bFmmICDYq9uuqXhlUHCl+kr33NZnMafAa67HR75vcRKRHNgxf1azhgpb
	ASZoSYLaUSBXVp1lE7sV3UslHcJgau75Q2ssM+nxDx/gINU9S9YxKihZMBzayea5LsEr8IgjjZK
	dk46ljE=
X-Google-Smtp-Source: AGHT+IFI/4jYIrbnYLxGxYERk0hWCg/zYIwlO8H0PSAGU8doebIcVkjcpRIgVRxR9/d9/XaOOElXqzjwwAEBVgnfZT0=
X-Received: by 2002:a05:690e:588:b0:63f:a399:3972 with SMTP id
 956f58d0204a3-6466a8afb75mr13151737d50.56.1766632241049; Wed, 24 Dec 2025
 19:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251224124355.31667-1-rgbi3307@gmail.com> <20251225010722.14746-1-sj@kernel.org>
In-Reply-To: <20251225010722.14746-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 25 Dec 2025 12:10:30 +0900
X-Gm-Features: AQt7F2pSRmmDbIKVYa6sVJn212ElrKJ-ezt0GwJxsUDhXwpEW3IpcJ0OLS-hIGM
Message-ID: <CAHOvCC4dYGqY2pMQktBbO-NWKGE2XXeA1e+6BrP2QtsjM2Dodg@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Dec 2025 at 10:07, SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 24 Dec 2025 21:43:54 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > The kdamond_call() function is executed repeatedly in the kdamond_fn()
> > kernel thread.  The kdamond_call() function is implemented as a while loop.
> > Therefore, it is important to improve the list processing logic here to
> > ensure faster execution of control->fn().
>
> That depends on how critical the performance is, and how much complexity the
> optimization introduces.  I have no idea about if the performance of
> kdamond_call() is really important.  If you have a realistic use case that
> shows it, sharing it would be nice.

This is because kdamond_call() is called repeatedly in kdamond_fn().

>
> > For ease of explanation,
> > the data structure names will be abbreviated as follows:
> >
> > damon_call_control.list: C.list
> > ctx->call_controls: CTX.head
> > repeat_controls: R.head
> >
> > the execution flow of the while loop of the kdamond_call() function,
> >
> > Before modification:
> > Old while loop:
> >
> >         CTX.head <-----> C.list <-----> C.list <----> C.list
> >         ^                   |                           |
> >         |               if (C.repeat)            if (!C.repeat)
> >    restore: only one        |                           |
> >    list_add_tail()        list_del()                  list_del()
> >         |                   |                           |
> >         +                   |                       complete()
> >         R.head <------ list_add()
> >
> > To process C.repeat above, we use an additional list, repeat_controls.
>
> Your above abbreviation didn't explain what C.repeat is.  Maybe you mean
> 'damon_call_control.repeat'?

Yes, that's right.

>
> > The process of adding C.list to repeat_controls and then restoring it back
> > to CTX.head is complex and inefficient.
>
> I agree.
>
> > Furthermore, there's the problem
> > of restoring only a single C.list to CTX.head.
>
> I had to take some time on understanding what this mean.  And it seems you are
> working on an old version of the tree, and therefore saying about an issue that
> already fixed by commit 592e5c5f8ec6 ("mm/damon/core: fix memory leak of repeat
> mode damon_call_control objects").
>
> Please use mm-new as a baseline of DAMON patches, unless there are special
> reasons.  If there are special reasons, please explicitly specify.

This patch is based on v6.19-rc2.
I will continue to refer to mm-new and damon-new.

>
> >
> > Below, repeat_controls is removed and the existing CTX.head is modified to
> > loop once(1st rotation).  This simplifies list processing and creates a
> > more efficient structure.
> >
> > Modified while loop:
> > Not used repeat_controls:
> >
> >         CTX.head <-----> C.list <-----> C.list <----> C.list <-------+
> >                             |                           |            |
> >                         if (C.repeat)            if (!C.repeat)      |
> >                             |                           |            |
> >                           list_del()                  list_del()     |
> >                             |                           |            |
> >                             |                       complete()       |
> >                             |                                        |
> >                           first --------> list_add_tail() -----------+
> >
> >         if (C.list == first) break;
> >
> > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > ---
> >  mm/damon/core.c | 37 +++++++++++++++++++------------------
> >  1 file changed, 19 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 824aa8f22db3..babad37719b6 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2554,42 +2554,43 @@ static void kdamond_usleep(unsigned long usecs)
> >   */
> >  static void kdamond_call(struct damon_ctx *ctx, bool cancel)
> >  {
> > -     struct damon_call_control *control;
> > -     LIST_HEAD(repeat_controls);
> > -     int ret = 0;
> > +     struct damon_call_control *control, *first = NULL;
> > +     unsigned int idx = 0;
> >
> >       while (true) {
> >               mutex_lock(&ctx->call_controls_lock);
> >               control = list_first_entry_or_null(&ctx->call_controls,
> >                               struct damon_call_control, list);
> >               mutex_unlock(&ctx->call_controls_lock);
> > -             if (!control)
> > +
> > +             /* check control empty or 1st rotation */
> > +             if (!control || control == first)
> >                       break;
> > -             if (cancel) {
> > +
> > +             if (++idx == 1)
> > +                     first = control;
> > +
> > +             if (cancel)
> >                       control->canceled = true;
> > -             } else {
> > -                     ret = control->fn(control->data);
> > -                     control->return_code = ret;
> > -             }
> > +             else
> > +                     control->return_code = control->fn(control->data);
> > +
> >               mutex_lock(&ctx->call_controls_lock);
> >               list_del(&control->list);
> >               mutex_unlock(&ctx->call_controls_lock);
> > +
> >               if (!control->repeat) {
> > +                     /* run control->fn() one time */
> >                       complete(&control->completion);
> >               } else if (control->canceled && control->dealloc_on_cancel) {
> >                       kfree(control);
> > -                     continue;
> >               } else {
> > -                     list_add(&control->list, &repeat_controls);
> > +                     /* to repeat next time */
> > +                     mutex_lock(&ctx->call_controls_lock);
> > +                     list_add_tail(&control->list, &ctx->call_controls);
> > +                     mutex_unlock(&ctx->call_controls_lock);
> >               }
> >       }
>
> Let's suppose there are two damon_call_control objects on the
> ctx->call_controls.  The first one has ->repeat unset, while the second one
> has.  Then, it seems the 'break' condition will never met and therefore this
> loop will never finished.  Am I missing something?

You misjudged.
If (!C.repeat), it will be removed with list_del() and disappear.
If (C.repeat) loops through the loop once, and when it returns to the
first, it breaks.

>
> > -     control = list_first_entry_or_null(&repeat_controls,
> > -                     struct damon_call_control, list);
> > -     if (!control || cancel)
> > -             return;
> > -     mutex_lock(&ctx->call_controls_lock);
> > -     list_add_tail(&control->list, &ctx->call_controls);
> > -     mutex_unlock(&ctx->call_controls_lock);
>
> As I mentioned above, apparently you are using an old version of the tree that
> not having commit 592e5c5f8ec6 ("mm/damon/core: fix memory leak of repeat mode
> damon_call_control objects") that modified this part.  Please use mm-new as a
> baseline, or specify reasons why you cannot do so.

I'll look into what you said.
I'll also continue to look at the mm-new version.

Thanks,
JaeJoon

>
> >  }
> >
> >  /* Returns negative error code if it's not activated but should return */
> > --
> > 2.43.0
>
>
> Thanks,
> SJ
