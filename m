Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0FF143748
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754225064; cv=none; b=s8aDzChDRhn9gZevbgSi+yCsFO7NxYg62dEmtkle1p8Q/WrIUVZS/4FJWFjv+bOYmfXe+sI1+vTql/aeWLC7POp6mF+BkmL3azAcazTmY0SM9jkFX7/L7pjGxELGsQkt+8dWiVf4Wddaw2eaoraZ3R7725BCvzu/K+igO4CQ/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754225064; c=relaxed/simple;
	bh=HuvKvFKeJC2q8Od7pCax3MWla1mvYNkLzbu1AscGnKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kqp2d/K29vLTNAB0QClbjHHvl+LR/L2IuDNXdYIiYbYiys2Yp470x5pFs2H61NameKstf7oIMk0uRYsAF9fsI00L3kZV2/3T8I8jBzk3Uni0ojBu/I/Q0E/q9JS1bTwnN4UJRlupTqlLKi9lFaal+CMFPLzdH2IHhDBot7Sw8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOucqI3v; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOucqI3v"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6197e13b6b8so1196485eaf.3
        for <damon@lists.linux.dev>; Sun, 03 Aug 2025 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754225062; x=1754829862; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyXXliHYkRsANTFZ/BhTtFGJcz7TAeDhl3fkIu9ScTo=;
        b=QOucqI3vB2IzG8BSDEsNUaC5w3lxBfW8xqsd9CjI7C9MgCdt1ujaxEspfb9cK+Erm7
         Wh5V1Rc/nz32buZjIpnpiiE8znGhlfxKpMoxyZGUdBGvoelwjt3SkQZVPJ+sHtQNhiDy
         rwVQa6cGciD+9XeV/zflte2mP0KUn6ISVwiHwrTdX8fxCBuA0wXYoNIHUH/LvaEclrvo
         G6lTj8Cbw+p/JF0ch0YYXKvq6mRucsAGxAjcOGOuOxzPaBxpEMrqGo3kUPAQsBJmlo6X
         DQVhZLgIGMmP5nlPqEsVueWNHERw1OSOaPV8tKt4Zudop4TiZ2l02Yaodiy31d2Tp2V9
         9T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754225062; x=1754829862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyXXliHYkRsANTFZ/BhTtFGJcz7TAeDhl3fkIu9ScTo=;
        b=ARSQP+qB01vh/fBYO5BOrA2JS80dx9Moxf4qsh9U75DDEHHHPLujeAZBgFBU6ENxGf
         Orvj0/wrs7YJDvC+uzjvXksGTWsBvFrG5Q0ldbfZIbScoXu7qCePch2tccQ8v4i49/MO
         gAwp5wtMKRH9SR/GHTrb57jBlOosroEkwK48v+qA8aAxb/Tg58B+uY9B4xFytv9dkj4o
         znfzzQ0Oh5ycpZ/skacO0AE5dzkDSmyiSZ2jK2UHUXkolqKpd/4KDz+QLWVhtw57G23a
         Ld2Vl1Mp/QioZ0rdSREGiQikm80Ee1Map4UzPldqFCD/iOYWV2TjnZpGqyT6XPx/xXT9
         sq7A==
X-Forwarded-Encrypted: i=1; AJvYcCWRZhq+s6ZScF+SWLdLMsnO4hU+YBlOkRxp0WycY2BPoGyyoyF7OooAwPmQm88idtyrei7rDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyG3Mw5avqpkO9/EGvz5LrVlCxX6Nz6W9LF9+ZxjE4tvRoQL2+r
	IZMRUCiaYoGtAZKicj3qICrp4Y7inbGVO8B3LeDHO04bkDY0NElq8D6GbwhvyDHKbiWNirBcpbE
	v7C1VkZRjfi3T2wyClQ+eiGGAtX4onnM=
X-Gm-Gg: ASbGncsnxc8ECj0yIw8eZ0R3hvPx3elOrhaosMePOCOUxgfF2yGgPE6CO8sNN+G3pOh
	Jj1pmvyYGnLOT+k3E+ta8tGBBq7jCE38zsjwK+OmA01qBy35/N6HMFYpJC/0C0+WHrbPpRG9oAW
	77xufI9GmgUGCk99AypA4jhRgx3CD36IvIXd9bD5N7DuMzMiPmLumicQxNfPexKXixYI1JRHJab
	7bj
X-Google-Smtp-Source: AGHT+IFjKUOh+KeyE08rDNkVXHT8x/gmFVbAcXE87p3aPPCD4UC1L4QICQk/l9A/N3vMB3az3LC3RFYnYoAhZ5NtAX0=
X-Received: by 2002:a4a:edc5:0:b0:619:844f:2d0e with SMTP id
 006d021491bc7-6198f2a39c6mr2981579eaf.8.1754225062000; Sun, 03 Aug 2025
 05:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxMGh7-vDgNzepJKtrhdOF40_U7=NT6Jvm85qtdwGpBZawg@mail.gmail.com>
 <20250801170231.8532-1-sj@kernel.org>
In-Reply-To: <20250801170231.8532-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sun, 3 Aug 2025 21:44:10 +0900
X-Gm-Features: Ac12FXwNKGXN07u7GF6ggxSzpPebZHeA4eQy-Z85lrBCXYiqs3Nq__NxBhynJ7I
Message-ID: <CABFDxMGUO88-CkHa8E79TTkoEm_j5FX3ZBVjChXJ5w0eL3mNSA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 2:02=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> On Sat, 2 Aug 2025 00:34:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> =
wrote:
>
> > Hi, SeongJae
> >
> > On Fri, Aug 1, 2025 at 2:58=E2=80=AFAM SeongJae Park <sj@kernel.org> wr=
ote:
> > >
> > > Hello Sang-Heon,
> > >
> > > On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.=
com> wrote:
> > >
> > > > Nowadays, damos operation actions support more various operation se=
t.
> > > > But comments(also, generated documentation) doesn't updated.
> > > > So, fix the comments with current support status.
> > >
> > > Thank you for catching this and fixing!
> >
> > :)
> >
> > > >
> > > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > ---
> > > > I also found below patch(https://lore.kernel.org/damon/202507302002=
39.60984-1-sj@kernel.org/T/#t)
> > > > So, Is it means that DAMOS_STAT is only supported by paddr now?
> > >
> > > No.  'vaddr' supports DAMOS_STAT.  The patch is not adding DAMOS_STAT=
 support
> > > on vaddr, but extending the support for DAMOS filters.
> > >
> > > Thank you for checking the thread and asking this question, though.  =
I see this
> > > as an important signal of another rooms to improve on the documentati=
on.
> >
> > Thanks for your kind review. I really don't want to bother you
> > anymore. But I would like to check my understanding.
>
> No worry, questions about DAMON never bother me.
>
> >
> > So the basic operation of stat is covered by outside of
> > `damon_pa_apply_scheme` and `damon_va_apply_scheme`.
> > If it's not too much trouble, could you point me to where they are?
>
> It is covered by damos_update_stat() in core.c file.

Oh, I see, Now I can understand the flow more deeply :)

> >
> > And some extension stat (maybe it only renewed that filter exists) is
> > covered inside of upper functions. Is it also right point?
>
> Depending on what you mean with "upper functions".
>
> damos_apply_scheme() in DAMON core layer calls
> damon_operationss->apply_scheme() callback of the current operations set.=
  The
> callback may handle DAMOS filters or not.  The callback of paddr.c handle=
s the
> filters for DAMOS_STAT.  The callback of vaddr.c does not, and Pan is ext=
ending
> it to handle filters.

Oh, I see. Thanks to your help, Now i figure out the flow from
sysfs(or directly set) to damon_select_ops().

> [...]
> > So, I think that I need to send v2 patch, If that's right, which way
> > would you prefer?
> > reply to this thread or make a new thread?
>
> I prefer making a new thread :)
>

When the discussion of "reclaim" finishes, I'll make v2 patch as soon
as possible.

> Thanks,
> SJ
>
> [...]

Thanks for your kindness.

Best Regards.
Sang-Heon Jeon
