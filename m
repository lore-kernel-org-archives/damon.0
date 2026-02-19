Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E2285CB3
	for <damon@lists.linux.dev>; Thu, 19 Feb 2026 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482518; cv=pass; b=cscygaJClzIyf63DQLwzZWcQBZIORJzwmejoZW0kOZis70DRO9nTMDDxudXP2V/OuSCLoUz7r2Rw18/7rGE67QJEwvgY7TQutuVGBxFHKoplejQp2O8ZXEYlGGZBNgua/DpQ7oTNQeFkBvLN98Nc6yEVzlj88w/t4kCa//Tu+xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482518; c=relaxed/simple;
	bh=qnCIwNM/JcvkFqDAnAGu24pDreG6s/2C1O7x0jy74Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aODOLTTTmaUO4VTxQ8Qxyp1/HK4UhrLdFovu8eZFgyMgGX+sEGODgnvKdu3H0Gn4GMFl8zB6IgapZLQWgDr85EnvHBYjpOW67s2PwQ2czujzlAlCzbls6YHSaIjGquygdI6ULWnC7TYFhustd6TxhQCgPYgRCGj09fE6vkva22Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEc3GGhL; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEc3GGhL"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506bad34f51so4371341cf.2
        for <damon@lists.linux.dev>; Wed, 18 Feb 2026 22:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771482516; cv=none;
        d=google.com; s=arc-20240605;
        b=WuXGlwsebpkKvIipXPpjxLWx+905D6YOiE3SedKGAOg5LRm16SCz9qKCyBxaAWV6Yf
         pe3kalrFVqeiT6hxk0W6uFxcTPRpa4DYJUKgLnHdB9q046ME2ShVrVS72ghwhLtOtTZw
         dDdLqbzKxceNgG3cEOW6tsEPRxuqnV+EcJho+a3hoD3LP0Hzj2bIhHBCCBqp/seqBZo6
         gKlmkKucnPDWE4eOTG0RBnQcpSbtlmcotsZPC/+jr0i0EfXMBW2SkLj9QYFiLx9oC3nA
         V5oB+ilfYbCiDtT0Pu80gIndQCDujw1qhXO4Sf8Kk8auisiUBJP80kwQWU/tudRXPJum
         J8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=817Bfwn3S0/4oB4/kRFFeSWVlnBUn3oIhZargYu38Tc=;
        fh=LuNIxDwrU8tBU0lHgCDdCWufQL5TCnYVCcwzLcZSFis=;
        b=DxP5ZaVwA2ks9i0smMYtV2sZvnC/AWlrKJ20bT0j4tETB01agyQa13GNVuY1EuAS/2
         uPALuN8FIyAS4cP3xIK5BfSsSLk+lxVXrLpOMGb7Xzwls6coFsYARWS4wiAF+gnhHx8L
         jjqnSzHucmmkwH7+Kb/qXG3aJrNBz7rbx48yVoxgv1MfPckSBA1jYMb9WgohqxxCQPhD
         h2QuTje7VjkENz8bqhucDapeoyly46CavkcEVaQCF/rPzD07F2HYqbt70nJQM8brA0HD
         4d48szRsLo8yt1YOM1THiOhC7lvZHzqDx8ajMN8ttWvOukKtHzDM5b5k/W3oK6r4ngY6
         bxzw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771482516; x=1772087316; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=817Bfwn3S0/4oB4/kRFFeSWVlnBUn3oIhZargYu38Tc=;
        b=XEc3GGhLFXn+j2N3NzDXuWk9PyLJafa43AXe9hsUXOpWKTyPaHWb1j8QrPJBNqcKAC
         XfSxlAlrRyCs/XKVuko4W2KSsLBmTx4RHtkZzI5qMsXObP17EF7fpbvnTUb2kMtecWeg
         lfImowx4jOtuWUB4udpOH/FrgyYe7kkQlG/VhbmowisYltsc0S8DCZsIoyQh0DMuCUua
         ZBixH2utdteAbT3/PKGgUFVPRpoclmrsC6p3dWeMVRGYC2zGBNaw8LF6XhukXaFI3ZM0
         e4A+I0gPLfp+/biMTBIVaqwT6bp1srO9dgAx1Iws4DljOkCY9wIWW+8OGeiZ1eNrIH7t
         27kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771482516; x=1772087316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=817Bfwn3S0/4oB4/kRFFeSWVlnBUn3oIhZargYu38Tc=;
        b=c53wwHK7Tq/+kloWpn6CA1IIrsdi5r7AaYuQCP4tymsXJYpWWKl7dnS9ZgB3dSpKEc
         WF7ja/cnpgTK3Mgs+RAZ93heM+cp44t/TO86vkGO+k1riOQE7vYudh9T4zsJ6OBT8Tsy
         u8mddvFZ0H1pB7E5BuEuBCRHvNzpcOAjs+ghJ7tuczW/PRFGFwcyUyTyNzjFBTxg8VsX
         a1kIjI+7YXlZF3kmBP27ibzLGPQHTIqW+DP/Y7wLy3z0qLeAC8Bqb31dlJnjgL246MgD
         134LruWJWnO4sNdBkHPL7JhnVvSqXrRJNR6M5d5JV6EH3Ddndr1ZveHLfAx2V6S6AUxp
         D1OA==
X-Gm-Message-State: AOJu0YzBqnqR+CBL87YqPbfQbpRYTbsJiShU+1PNNVlOcmnDtZdQD7iP
	/K9hv80Ib/QKkvxQWXAAqrExeGmXMcMoA2CUXMuiYNo0wYEePt8mpxXsKxhtrJ6cpsjx3lZ6KiP
	+rp8ZlSWUag26KKmV0vrAwAQCAOgGDPk=
X-Gm-Gg: AZuq6aLLZ7i/I75vVYw/sE2AtqxCKYn1ywkDoSXs6x5GDFplh31R+mKlXEZz/80eN2F
	5YPkzNmozMWSKQkKSSMKddmNikxEhzPmus7BLHB4ID3HfNahBX1C9gfe0SyIHTdxHHVlC/Wflgc
	nIglbthXwsqp06NFezj/02Iq/KC8u6hVWBV6KR1bsVuasZ+aTi+BRSPGZJMAsMH69Vb60rMZvCn
	+hOmWlmd1TE0JptSJ7F0fcdZIZqCY97yqQyvVdCiqDHZUyerXMkAoI2gqc8Mg1bfDXgig8Ymk5m
	ypUmJTyX4vFsMOU2ZuqkcEsRpwU6hSfgH7Qg3tQPIDrhwA==
X-Received: by 2002:ac8:5715:0:b0:506:20bf:449c with SMTP id
 d75a77b69052e-506f06ee27dmr27157751cf.38.1771482515895; Wed, 18 Feb 2026
 22:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAC5umyj7jb-RUXJPv+YMC5Fd3ST=YinW_t7Sj5kCpoA2d+rDXw@mail.gmail.com>
 <20260218154041.10282-1-sj@kernel.org>
In-Reply-To: <20260218154041.10282-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 19 Feb 2026 15:28:24 +0900
X-Gm-Features: AaiRm52H-T82c6gEOOrtvDPwydmEPc1TQH-vAALFCZVy9SJXLeONDPkrsz0Fz5k
Message-ID: <CAC5umyhNBtcF=O6x3aaQG4uMaSSkzs-kw1E79PHrd_rBLiUeFA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B42=E6=9C=8819=E6=97=A5(=E6=9C=A8) 0:40 SeongJae Park <sj@kernel=
.org>:
>
> On Wed, 18 Feb 2026 17:20:04 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > 2026=E5=B9=B42=E6=9C=8818=E6=97=A5(=E6=B0=B4) 0:15 SeongJae Park <sj@ke=
rnel.org>:
> > >
> > > On Tue, 17 Feb 2026 22:32:43 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > 2026=E5=B9=B42=E6=9C=8817=E6=97=A5(=E7=81=AB) 9:13 SeongJae Park <s=
j@kernel.org>:
> [...]
> > > > > I just posted an RFC patch series [1] for this.  I will drop RFC =
tag after the
> > > > > current merge window is finished.  Please let me know if you find=
 something
> > > > > wrong there!
> > > > >
> > > > > [1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org
> > > >
> > > > Thank you for posting the patch series.
> > > >
> > > > I tried it and found that patch 2/3 made things worse than before i=
n terms of
> > > > monitoring at page size granularity.
> > >
> > > Thank you for sharing the test results!
> > >
> > > > This is because, in my evaluation, new
> > > > target processes are added without stopping kdamond, so processes a=
dded later
> > > > are not initially monitored at page size granularity.
> > >
> > > Nice catch.  But, the min_nr_regions based region split of vaddr was =
triggered
> > > by damon_va_init(), which is called before the kdamond_fn()'s main lo=
op.  How
> > > the regions were split before the patch?  Probably I'm missing someth=
ing.
> > > Could you please clarify?
> >
> > Before applying PATCH 2/3 ("mm/damon/vaddr: do not split regions for
> > min_nr_regions"), the damon regions of processes newly added to the mon=
itoring
> > targets after kdamond started were split by damon_va_evenly_split_regio=
n().
>
> Thank you for adding this explanation.  But, damon_va_evenly_split_region=
() is
> called by only __damon_va_init_regions(), which is again called by only
> damon_va_init().  And damon_va_init() is called from kdamond_fn(), only a=
t the
> beginning, before starting the main loop.  If you add new monitoring targ=
ets
> after kdamond started and therefore the damon_va_init() is called,
> damon_va_init() cannot be called again.  So damon_va_evenly_split_region(=
) is
> also not called.  I confirmed this using damo like below:
>
>     $ sudo damo start --target_pid $$ --monitoring_intervals 1s 5s 10s
>     $ sudo damo tune --target_pid $$ --target_pid $other_process_pid \
>             --monitoring_intervals 1s 5s 10s \
>             --monitoring_nr_regions_range 20 1000
>
> While running the command, I monitor the number of regions of targets usi=
ng
> damon:damon_aggregated trace event, and confirmed the initial region is e=
venly
> split, but the new monitoring target regions that added by the second com=
mand
> is not evenly split from the beginning.
>
> Am I missing something?

Your explanation is correct.
It was only my own internal changes that were affecting it (calling ops.ini=
t()
from damon_commit_ctx()).

https://lore.kernel.org/damon/20260123021014.26915-2-akinobu.mita@gmail.com=
/

So the current patch series hasn't made things worse. Sorry for the mistake=
.
