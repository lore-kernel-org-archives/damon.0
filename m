Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27827934B
	for <damon@lists.linux.dev>; Thu, 11 Dec 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765438740; cv=none; b=K5Vmf+MhzCw2dMScQp0yIU8BvFaZ2aSXvnFHKoZIvCzLeAgprYZeZ2aFgiakcCdbzaF84loqnjGe4jh+iQEazH+JgB1QJHHYuPmvbk05gbfHqy8d+fiHlUEk2KlkUTjY/HfvBJ8E9LKKC7Mz21ms1uNTveVETaxJqH7bNDwqnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765438740; c=relaxed/simple;
	bh=tcft1rmvzVUXkGYCh8ePLQkyqUpPp+RNoBWR1EmZNAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBSJ2cv/HBNe8k3aVGFB3n17nIoDk6rHZI4lmjb8HtD2zyB38c0/kcHWqw+9c64ukVsOtO2RK2yo9AX5ynmujrR0WmV0aIJJJ+Vl1nvPwsdBvvh3kYaDctqRo0U8aqF4qPwe5nZgqQG2kpF6o89AvG7tjHg27iUBt/mnKdAfLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UebfNURf; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UebfNURf"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-640d4f2f13dso677765d50.1
        for <damon@lists.linux.dev>; Wed, 10 Dec 2025 23:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765438738; x=1766043538; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qNo3c9NxnL7bsmTxmb83lgmRtKUwugbuBdQv6CrEYfQ=;
        b=UebfNURfJd5lLjx7h2h1Ef/MEjfiTyzht5JSbWVrYWC1Q4EEIruitSHGmhTOsQMK4u
         u/sZU1DjHdNgXYjj7WUuBoPauUbfC9ComSkGLVJzjtT2pZVP7Q2+ojVVY3povgJWA17C
         +P12eKgmSzBDWP/rRNG664kBJR68ujD55ME1OvSeoaIgjUlJ4eqohSS7E6PIrmCOLE7I
         uJk6uS+lXXSRoueNMQ2Aq2Q43YE+OwF5+xk/d0o46BsDoH9qe/LgWeWBGbvPACmfv4Ev
         eH7+PA6mfxVnbhJdByOwZD7VZCCGhtMPHQDJ+b7RJvYtNjnsQGJfcahEa/Z8Eg/pBt7w
         WA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765438738; x=1766043538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNo3c9NxnL7bsmTxmb83lgmRtKUwugbuBdQv6CrEYfQ=;
        b=WgZN0vMUXtD0rf2JEYFA4g79cUUpV6N3LO7niw3HOxlMPQcmM8ObxLRz8UOolCN2en
         l30dugueuGiIcZfUHUUK6iPzApHju0ZjF6ZDtBTpg8bZBYmYhwz1EzTGXiohLxsPb/Tg
         RCEPtqT+ck/wTkzbclhI56yj9ustr6CX+S6/EBWsZ1Zu4ZEw9lxHceeHZbuwON+ncGaV
         UWNnDs1wL7J0OKwsHaSJpPywSbd6X8Hojobv/vs6EnPOQKloRu1t0fD6EI0gs9gi+Giv
         Gykxrxz6xopgFBi4R+z3ENa9tMgcn0BUeDkc8gL8PrkTCCRH3dfvVSuDECeoPDNeIeja
         uMdA==
X-Gm-Message-State: AOJu0YwhooAjvAvbc+VNhtzH+yhiHqlcGhDZpzvXYnzWX9tavs8SHARQ
	b1Kui3WOMUYNr2ZnLxspQqo5QK72A0WSH2Hhhzi6UJK2rXR5wGnpCDBTUSqzUpLzvCs53W2KSBH
	B7l9gRLhEQs8K+Emiw1oTCD42cDO7H6Y=
X-Gm-Gg: AY/fxX7mHlIXQjWXyzCEcqpZna0WNgJVpgZsfgb50rT8fZy09pcP9ZCNQ4sOVTkZJCI
	uQAJYQTaDbLAWjmRpE6dg2qXOiB+5YXGnh4EhZiUlE8LDhZu7k77eL0XIr5+RYSu8ZsYfOY2HjC
	fom5r/9K2z+Qp8wPxOhWFmu9UKac1hMnfZ4Ug9gTMgdYbKI81RNDekyXrCrA010UDa24f4iB9Ws
	9c+jwzizXNUC4w/1Ys7LR2doPHAoNG6oxy1+V1DodlM4Li9XvDKEB8at4D5DFHyiWqT5uEu
X-Google-Smtp-Source: AGHT+IHPJDzZkPfFWBRgIOOZ07OMuTeR68RB/IPPWWNP79q/gQ1l2vZiSyv0mLlqZr6Mb12rmnfV7LhG5GwljUcSfyE=
X-Received: by 2002:a05:690e:1345:b0:644:4259:9b62 with SMTP id
 956f58d0204a3-6446e8fc163mr4180596d50.1.1765438738281; Wed, 10 Dec 2025
 23:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6bJLf=LuBpm90n5poz8Sqhz9wjXtk5ypbPwkvhb1ptag@mail.gmail.com>
 <20251211060413.60534-1-sj@kernel.org>
In-Reply-To: <20251211060413.60534-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 11 Dec 2025 16:38:46 +0900
X-Gm-Features: AQt7F2qkI0dCCYHs9Len6GIYpErZ3A-Zu8QVXmNkIzVYVohQsczhTaiydbVhr4w
Message-ID: <CAHOvCC7epLcuK-58kaROWMof9dq3ZCm2WV218KGv7kcDMf7q-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 15:04, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 11 Dec 2025 12:29:59 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Wed, 10 Dec 2025 at 11:54, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Tue, 9 Dec 2025 21:20:42 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> [...]
> > I suggested removing the dealloc_on_cancel condition from the patch.
> > When using the damon_call_control structure, if you only use kmalloc()/kfree()
> > when canceled without dealloc_on_cancel.  However, currently, in other modules,
> > since it is static struct damon_call_control { ... }, kfree() is not allowed,
> > so dealloc_on_cancel condition is additionally required.
> > Because kmalloc()/kfree() and static are mixed together,
> > dealloc_on_cancel condition is required.
> > As you pointed out in the previous email, kmalloc()/kfree() has the burden of
> > memory allocation and deallocation, and static has the disadvantage of
> > increasing
> > the code size.  Both have their pros and cons.
> > Among these, I proposed unifying them into kmalloc()/kfree() methods and
> > removing the dealloc_on_cancel
>
> Thank you for kindly clarifying this, JeaJoon!
>
> >
> > >
> > > Meanwhile I find the feature might look complicated, or not well documented.
> > > Specifically, dealloc_on_cancel should be set on only dynamic-allocated
> > > damon_call_control object, but that is not well documented on the kernel-doc
> > > comments.  Are you saying removing it is an advantage because it makes reading
> > > code easier?  If that's the case, how about improving the documentation?
> > >
> >
> > dealloc_on_cancel is only used in mm/damon/sysfs.c.  Here, since kmalloc
> > the damon_call_control structure, the dealloc_on_cancel=true condition is
> > required.  If you want to keep the current code as is and only change the
> > comment, it would be clearer to comment it out like this:
> >
> > De-allocate when canceled.
> > --> To perform kfree() if allocated with kmalloc() when canceled.
>
> Sounds good.  Would you mind sending a patch for that?

Would you like me to send you the patch with only the comments corrected?

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
