Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6D7261D
	for <damon@lists.linux.dev>; Fri, 12 Dec 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524639; cv=none; b=MctST9mZGJuittVasSXv3x2lZXH9DE+QSag4yQ8o25o3xtu7owQ90O+QkeACVEAfZEVVZEwQRtYxidhtrqdEdBBprrjXls0hNcmqICuO3LG39GQfum7p73BEc1pXsf1TZo12R5ZrHyhFajifjGoj+Vlv/LqVGYGj/lCMbaEfBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524639; c=relaxed/simple;
	bh=a8ToLTXWuq8isc6w/+8kZ/8l78d6KuCAN1LthUj43vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO3bGr+noYidX27sIGAmO8OPWyqB7fN5OgOU5Y1X2SPkJ+a2IRLhBIZuM17RSIMIvEfhsjBMvScbe/TCwlI5xm4m0ZAPSSdva6+dnZ5fkblAWAOvB/MumHfHPjyPqhKkzKFGAwvoOUfh0km3oQo81YhCohPuHd7FSOk6wpYJqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4jJRZ54; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4jJRZ54"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78c8d74bf4cso8450067b3.1
        for <damon@lists.linux.dev>; Thu, 11 Dec 2025 23:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765524637; x=1766129437; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbY/nvu9k0jdFLf6PceIz4U/m+vG+cifGKFXmRqaXwk=;
        b=b4jJRZ54gQm6i0o+nNbZ8RP6ccZeQwTYQcMXPVx32tSkiAvjFfDnvLHCxqhzB74TdW
         w7aycGy/lJPWYA/HkDq2BJGwcGixhWhKM1QY3Z3rZNuQbVFAJJUJlUsMaCoFX/D+G7lP
         I1BDSYIo/kovlECdLMXGMpt5wUoWqTICj5+bhN07uPRz4AQHXkUy75MeAIt6r4Iwb020
         uXUDHOVMpHg+nUL5hiQ4laMxlbd4/mwn3AK2/FUyiuWg6d/I+X5fWZW4nPqb29zuK43d
         AZzlui125nULSfQNcVpAsbzaJG4003fZz5TGIejTjwbjGF2sjYI+jttNPi2ie1kgMDFU
         fw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765524637; x=1766129437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbY/nvu9k0jdFLf6PceIz4U/m+vG+cifGKFXmRqaXwk=;
        b=IOBanTw/5BO0V1D1ZZKKRvedBIFF8l4cFeJ0ZJKwy8rrYhFLvELf4MlQ/Elb19Q7OJ
         pvgA/RVDAYaSA2iQKCYW6UtPlfUZWsHUAXIc+Ydn0le8uOpZ8qmg4mhE52iuDpLHu4hl
         KfN9nCNVGDwV4Jib/WYfjBbyvARfhKVJuyJ0wN/IEV/4lsvJOGLIxmVUKR13g8iOcIZZ
         Uv/hmX1RUkQGtnfgwT/GNaJjytNFzBo8FZ9ZuLqIQsYmAOy8OjFh8s395hv6FSh0y8OI
         3LthA929zj/j0k0x3oA6o0ojQs7QAlXBI+rLQf0XOHGb8AelL6zucEsQNVAITuU2++tq
         C1tQ==
X-Gm-Message-State: AOJu0Yy0zUDXfUDKoh3jNqo0nuBe0TstmEyXx0uCCwE+ztgkIqkb+fQd
	QCzmokGUbvVQieDrwkdmMO5nULdyJlcqW+udnRjj6TjYVAiA+ZaWA5ecnNByozH/kjJNegVtvsS
	H3hpep1hq7/+p/MLXD5jHyPBk807Tm8A=
X-Gm-Gg: AY/fxX51MvNjadD7fB2tRU82o7SRL9Omtl8boGmaE/Es5jB4ZnsckGMMz2swx6owaZB
	fVUTYxLYg5R3N3Mo/YiO5udwUTfELclZBpMRQFCq43jphr3IGZ6tN/v0+ydFfUD1dJgOS+peGTI
	lMYGQdsvvVgSnAjTTMisgkzS01eTBSkTGeex2ey96vBFmggcacpU1QOkJmPgExYMNkOQ5dATv/m
	j+7Izo7JhJa6ANgwGocGRqs2lWc7tPQ58rsWSSDTYgy4vAEUvVWOULqc/NUO8/hK2QYXYm8
X-Google-Smtp-Source: AGHT+IEzDVXB1bjCbfAIBeJJ9LVwd+PZ1SexNTZG4im+40TkPh9ylFdtSqrLakFNNss0Y8TrUpzAomad+Rqj/W8ypP4=
X-Received: by 2002:a05:690e:14c6:b0:645:591a:cb60 with SMTP id
 956f58d0204a3-645591accffmr68426d50.81.1765524637312; Thu, 11 Dec 2025
 23:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6ixeLQeTJANkAvQhRviLyr7=xNBs-_jeKEo+qF6E3qAg@mail.gmail.com>
 <20251212034613.41033-1-sj@kernel.org>
In-Reply-To: <20251212034613.41033-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Fri, 12 Dec 2025 16:30:25 +0900
X-Gm-Features: AQt7F2qCMypcBYiHBd8_DY3c8sXx5SQAojnD2TiuRCXQxR3VNlNM3OEJCHwUvv8
Message-ID: <CAHOvCC4h_pv59Eb8euiv_=oQ600qJOjs8P8Onc39NrJnEaEV8w@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 12:46, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 11 Dec 2025 17:13:09 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Thu, 11 Dec 2025 at 16:54, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Thu, 11 Dec 2025 16:38:46 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Thu, 11 Dec 2025 at 15:04, SeongJae Park <sj@kernel.org> wrote:
> > > [...]
> > > > > Sounds good.  Would you mind sending a patch for that?
> > > >
> > > > Would you like me to send you the patch with only the comments corrected?
> > >
> > > I was just asking your preferrence, and seems you have no strong one.  I will
> > > do that on my own unless you mind.
> >
> > I have been argued the following so far:
> > "I proposed unifying them into kmalloc()/kfree() methods and
> > removing the dealloc_on_cancel."
>
> Based on your previous email [1], I understand you argue this patch is better
> to be merged as-is, though you agree it has the pros and the cons.  And
> therefore you are letting me to make the final decision.

There are pros and cons to both, so I agree with your opinion.

>
> I was implicitly saying I show the cons more than the pros, so don't want to
> merge this as is.  Sorry if it was too implicit.  Hope now my opinion is
> clearly reached out to you.
>
> I also suggested making the comment better, and you agreed it but I understand
> you are not interested in making that change.  I will do it.

I can also send you a patch for the comment.
But, I've been looking at the documents you've been working on lately.
It would be nice if the documentation could continue to be improved on your end,
so that there is no confusion.

>
> So, all is well and no more action from your side is required.
>
> > I apologize for not being able to respond promptly and smoothly
> > this week due to a busy my external lecture schedule.
>
> No worry, take your time.

Thanks,
JaeJoon

>
> [1] https://lore.kernel.org/CAHOvCC6bJLf=LuBpm90n5poz8Sqhz9wjXtk5ypbPwkvhb1ptag@mail.gmail.com
>
>
> Thanks,
> SJ
>
> [...]
