Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31511291C00
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409903; cv=none; b=Ai5lrPWTv7n+lDJtP8gLUcYWWOn07wdxr5PuFJeYunDqUb4j95sfEz+QnUUvV+Auc0ZxJsN3+NPmJ9/D0EoTGNq44B57wm1A7ThKijO1V9rxNvfd9N08ffhtiqZcc83MlAvUN4Q1nHUpCFQq0kigULMKew6aBNDa95M0sxYkjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409903; c=relaxed/simple;
	bh=WuLM+P87VVTSZ3k8GOvsJHCApWTDHF6DnatJBUi5Vdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez1nJrrpnvxtw3J0m/bXsd04zjpYX5+j6sBtQ8gMG5iDwMw8+8t6H2H3jnoUE274dUbHPO/rc+/itXSeyWXz1G3fAxopGFJ5mvJt7UlbwtuxQAnlSSD/eMdG8ua3qitVfQYqX4+61NGcvEjnPTaSHXfausrtqrVm3hrqyHuKeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmaoxLMu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmaoxLMu"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55b975b459aso4319929e87.3
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754409899; x=1755014699; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT77AFoRCXiefdPf44N0XGcSQAI6gJsbqbSWQ6+ZBn4=;
        b=PmaoxLMuQ/uKgVyc3j1bqyRP0nrnAdAx3XlFZPXbsifN7/zwefJSPipE/+Wqf9bRYT
         XUVuHqPlzZY4TdlbP+D2pfJXbTO9kmPrJo088ao+U3izxBs90oGLgWrAgnZGodrBDAk8
         Uw7ZjPsfMwrcZ6cSUDqCtWj02QTrkuSEBDB459KK7MWHY4PXcf9wxinMk4nI0RMpOPkD
         Ldj6s5wo0/XlbccZmoYnLHDMfLk1UwGQ7Npmm5fDroI2j6ya5MFPQ53jwNF1N28rkekC
         eqPjl9k/rlxqhY3z1kI4NJQ4WS0SOJWiHorvpCwKpTyhvQB2m8Rkdx1xWP/vdESxZM1L
         OqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754409899; x=1755014699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT77AFoRCXiefdPf44N0XGcSQAI6gJsbqbSWQ6+ZBn4=;
        b=m1NM/sl1rOedMXvzDd/HrvEwg3sbjykSNxReqdsKkuudwt1/oXQPcynvKLimmDxKuF
         QxkAbiMWvaLTJtqO6WxgsYFj6qRcFELdeqPHLgFTOVJm7Cyn1QkMW4WH9DHv3BCF1whp
         zJpZWz8puwyjtO5guf7RS4Fbcd0ODIAo2/uV5YI3PwUqh1rHu5sEbVYxKmmbUM6DDCbI
         A6k01VO3L1b2/lI8KYz8KdVCTBbOqwDNFI+eLO+3CCcPoV6DU/6ppGse5xr1LG0o49UI
         7lIt+1dsN2Z+rBbR82ALrIeQsaA7U1wZp8Yt3yVw4SozJFVY+yPQ4VuTg5ofWVnclIJ8
         jczg==
X-Forwarded-Encrypted: i=1; AJvYcCVCSpqhzOCTAH83VFqK2BuH3U/rcmuc9CiXxBhNZ42w3VNXtvcmQ7PGSGoV1iJJj0oYhj5wsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCA8zFr6A9QVt7OgFb1T8A3HyaVB0/fOKIh8Qo1OK5FBNQQk/7
	ZCQDnY5eIe5vGBeNgp4ETf+AfZQ70D7pJP/0G060tqvcDaWDY3YX9YZY47IHNLFUx/w//Eltw5M
	Eoiu3Chms1xhIpsBxKhoXQtQqNME8CE8=
X-Gm-Gg: ASbGnctmXGEWMoHX4mJFP5RyIhD1ZoiKrxqlooo3Z5b80+vUGrnhQR53TPCk1l8q/LX
	QFze/R/SaQ8vFtHQ31vyFRohm2cnBC2MCnX3/nsKf63L0/SZZumgwyUynd5bQBixB8LvhYX/QSv
	K7eYLnL3ATxM57UqheuCu2jqv6ty+JqcZUkkd5MG4nGc8iMLae5EExnnGwyXkHtn5eOedfnE/1n
	8TRluZ3k1N6JSbv9sS/cPRCfwQI0wbZWnY3g+QG5GhmhA==
X-Google-Smtp-Source: AGHT+IFjax6pie9jgnCgNgfHFz2sXo8Dk/SpZPEL3z3/dh+/3xNXkVz6YdtqSg0MX/SSGuzKrzz8UvwsVpEApVdkHts=
X-Received: by 2002:a05:6512:3d04:b0:55b:8a6f:c2a7 with SMTP id
 2adb3069b0e04-55b97ac3da4mr3914505e87.23.1754409898855; Tue, 05 Aug 2025
 09:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250804151929.4613-1-bijan311@gmail.com> <20250804164341.55371-1-sj@kernel.org>
In-Reply-To: <20250804164341.55371-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 6 Aug 2025 01:04:47 +0900
X-Gm-Features: Ac12FXxWesOkMwCOWHF92lfLTOnOe3AMaFMtIU8-8-3DISWjHGn4B8ucLtrl9Q8
Message-ID: <CAC5umyjp_tbcJ3=UdSv0WCiOWytW3arBYp3nwv9i2V24ENmmPw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: avoid unnecessary migration between
 target nodes
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>, damon@lists.linux.dev, 
	Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B48=E6=9C=885=E6=97=A5(=E7=81=AB) 1:43 SeongJae Park <sj@kernel.=
org>:
>
> On Mon,  4 Aug 2025 10:19:20 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > On Mon, 4 Aug 2025 21:46:49 +0900 Akinobu Mita <akinobu.mita@gmail.com>=
 wrote:
> >
> > > Hi,
> > >
> > > 2025=E5=B9=B48=E6=9C=884=E6=97=A5(=E6=9C=88) 3:01 SeongJae Park <sj@k=
ernel.org>:
> > > >
> > > > Hello Akinobu,
> > > >
> > > > On Sun,  3 Aug 2025 22:00:28 +0900 Akinobu Mita <akinobu.mita@gmail=
.com> wrote:
> > > >
> > > > > This change avoids unnecessary migration by checking if the folio=
 to which
> > > > > the migration is applied is already located in one of the target =
nodes.
> > > >
> > > > Each folio will get a single target node among the target nodes, ba=
sed on the
> > > > weights of targets and the virtual address of the folio.  So skippi=
ng the
> > > > migration because the folio is on one of target nodes can result in=
 wrong
> > > > behavior (not doing required migrations)?
> > > >
> > > > Also, a similar purpose optimization was already made by Bijan.  I =
guess you
> > > > aware of that and therefore Cc-ed Bijan.  Could you further share d=
ifferences
> > > > between this and Bijan's one, and measured additional performance g=
ain from
> > > > this patch, if you have?
> > > >
> > > > [1] https://lkml.kernel.org/r/20250725163300.4602-1-bijan311@gmail.=
com
> > >
> > > In my current DAMON setup, the target nodes for migrate_hot action
> > > are 0-3, and for migrate_cold action, they are 4 and 5.
> > >
> > > I'm looking for a way to prevent unnecessary movement between target
> > > nodes for each action, making interleaving an optional choice. For
> > > instance, I'd like to avoid migrations from node 4 to node 5 during a
> > > migrate_cold action.
> >
> > Where a folio is placed is based on the virtual address of the folio an=
d
> > the folio's offset from the start of the VMA it is in. So, as long as t=
he
> > interleave weights and the folio's offset in the VMA are the same, foli=
os
> > should not be migrated after being placed. This placement algorithm is =
the
> > same as the one used for mempolicy weighted interleaving.
> >
> > It sounds like you are keeping the interleave weights constant, and I w=
ould
> > imagine that the virtual addresses the folios are mapped to are constan=
t,
> > so I'm guessing the start address of some VMAs are changing. I don't th=
ink
> > I've seen the bahvior your describing in the workloads I've run, but I
> > guess it's possible if VMAs are being merged or broken up a lot, such a=
s
> > through frequent mmaps/munmaps. Do you think something like this is
> > happening in your workload?
> >
> > How often are the undesired migrations happening? Every time the scheme=
 is
> > applied?
> > Also, would you be willing to share how you are configuring DAMON?
>
> I also want to learn more about your setup, use cases, and measured amoun=
t of
> problem and benefit if you have.
>
> >
> > > I've observed a difference in behavior compared to Bijan's patch, and
> > > it seems there's a need for both approaches. Would it be possible to
> > > introduce a new option that allows us to specify whether interleaving
> > > is forced or optional, and then adjust the behavior based on that
> > > setting?
>
> We can add options if it is promising.  I have no good idea about if this=
 is
> promising or not for now.  It would be helpful if you could share more de=
tails
> about your use cases and measurements.
>
> >
> > I wonder if this would be better handled as a paddr scheme. That way
> > you can configure the schemes such that only physical addresses in node=
s
> > 4-5 will migrate pages to nodes 0-3, and only physical address in nodes=
 0-3
> > will migrate to nodes 4-5.
>
> Agreed.  If Akinobu's use case is not depend on virtual address space, I =
think
> paddr is a feasible direction to go.  Note that 'paddr' doesn't support
> multiple destination nodes for now, so development of that would be neede=
d if
> we decide to go in this way.  But, again, I'd love to learn more about
> Akinobu's use case and the problem first.

In my use case, a script periodically checks the processes in a cgroup and =
adds
new processes to the monitor targets, so the target processes change over t=
ime.
(Processes known to be short-lived or have low memory usage are excluded)

As you point out, even without the patch I suggested, it seems unlikely tha=
t
continuous migration between target nodes would occur.  The reason I propos=
ed
this patch is that I didn't want to move any pages that were already locate=
d in
one of the target nodes.

It's true that paddr is more suitable, so I'd like to evaluate it using pad=
dr
and compare which one is better.  However, these processes have different
performance requirements, so vaddr may be a better choice as it may be poss=
ible
to extend special handling depending on the target process.
