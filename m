Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37932741B5
	for <damon@lists.linux.dev>; Wed, 18 Feb 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402819; cv=pass; b=sV2e3kELN1ngjHYgUop0pEmCHlO6naLvJhwi7N22YbNkuDQHPKxJsGM74rBlFHNZx04zIZ3wPm02XbUgOsoUta5ZM0upRAG/EsIrUmGDdpKu3XyzoXgqSEn9FhVRa96Fzja7cMfIpAQXk5GIbLeT18rsICYc7gmV06mV1JfR9wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402819; c=relaxed/simple;
	bh=LxGVYgrBMlRN5L5LEEoE1iqAE2THS1TgIQeCEfV8VEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgHhvssHOnxDffZR0j1ofuGYP12S8zDD3ZNtRZm16rZM0339TM0YkfqdDy6Cy8liSgU+AJuq2npYwS9MXR+aiRbSKf+uM06ILQ1BPD4gHngeTL1In9HZaD1HkSTNkGaX3rpVJxz1WRr+RCGWY6RMAdpQvL6p5m+yZCjSMJVJIxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huvg/wts; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huvg/wts"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89473dca8aaso65827136d6.0
        for <damon@lists.linux.dev>; Wed, 18 Feb 2026 00:20:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771402817; cv=none;
        d=google.com; s=arc-20240605;
        b=aY1xlbJj0U31zx/5V44KSiOLJa/+ZuncneHAoAvAv6gFh7/MpXHtkpUFZQC2oFqY//
         DdDssUll4qtEaW0wMLnj88ZNrXhOa8+i5HrqjfcdwWv51P1ku5264j+evVb6xkI6BQrE
         unzSP+JLQbniIw7MFp77UCxL1USUiteBccRwrR6oYN8USeVuvpsKwtSUCzHPOnhivehE
         7CZNjwk5wgwDMbVfXOutmpybwmZruQJvLKTkzpcrorBNBDQc4dxDJFzYHVjR2pfEQ6T+
         11hKnykkEWei/sz7ozXViTZow6cFPL9TucJivduR4gm862uq/bcjsQ2KT5DcK35XRpGp
         AuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vcm1IT3zELxLry4e5l0iwLd7LMT8NXfx6hphRIF4GAA=;
        fh=LuNIxDwrU8tBU0lHgCDdCWufQL5TCnYVCcwzLcZSFis=;
        b=DKKN9lPfOJjCnpveZLw6QDKXtUR4/U/AMEq+qgoPUrhfHZlJzpYoqv8+jtzWHNaafQ
         qAupNZbl9SMaHKIvX9lWhteskRZ5cbJBxgUdDmFBv94faExfJBHBjQNRVGSewonL8mR/
         byEytmftqUrcrGJTiFz1CkWNKky+HSomoBqqCtYmyAj3yRy6ALmMmgrMRm67m0gu+TBE
         idFbdY0zOuoir9KKC6FCvgkVFsLbd7LDzcLmf2uMp8yCsGIDyo2BIdKmXerfyM/iQMiE
         zb2wsc6vn/SpRmcLvkwcDLroNLHpYgLCVIhND9RRfR6DQKeCRg6LNCC5K75jVMKtiKaU
         U+NA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771402817; x=1772007617; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vcm1IT3zELxLry4e5l0iwLd7LMT8NXfx6hphRIF4GAA=;
        b=huvg/wtsDKb01npeoU7ouEYceDafFFISk6O3FTaeuk6vBhAuw/JbZ/EsWrxLjub8We
         SnDexdpQwe7zv3EC+QXXOVuw0klVDnClWIimg5f6uSENdNkAUEdY6NXhn9t1xiHiWgzk
         58Q38MAB+EH73FTRLpm7toqGYr01EsNev4oETaX1H2Lk84iMinYoji0dpjjn6kR/JTsc
         PeA6jVSTlpCRSRwRafOimFoKNPTB3rDkrHUsnnG1UMrDSomtXmhDpW/tmdex4MeLcKC3
         ENIH0RZ0Vyx3nn/y6GaeUYWmexoyOdosQn27H/w4dujVXSeCzVax8jfiMR8QeHfC9poF
         BijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402817; x=1772007617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vcm1IT3zELxLry4e5l0iwLd7LMT8NXfx6hphRIF4GAA=;
        b=lyyeW318dnpU73Yo7mjVlVj6U6A0M/n0YuRuJRk0Myx4KugOBvnVRJi7h5pg9TGief
         etIIHCLbUwCbrm5NUF7ibE7Pk6FWCLkJf/X6BhIb5O0v2bg+WCqOGfqTw1cBrh3DrLtL
         ZjyHXE0ZbsEv74mR4NoQkt+Z38eNF0C59LXBYTGdWRQaKhlighBNlP8v2U9Un3omTzI4
         r0Yd8z32lyxWRnPGXXvlSmYdoJ9jW0Hr3VYA3oc6gr5b9W0EtqsSGHUC0Za3CVm8rQ40
         nYrnwj6enkIHgGECR6FwTnWM1gFs3O6AjvP3qz1cEKN9dAoJrwgqM2DQVW189DzLJsHA
         w9gw==
X-Gm-Message-State: AOJu0YzDTtMsJFrvzTzU5bNMw+lM2KqHBZNMmraJh/NT+JzIt7E5wvoI
	Ab5/rvJ2IN7MGoCjnHyJrJ4HZ5xXH6d/SdsxTnJzmCKs4OyjpjB+peshmdienQ9MZjibIKpRbH5
	a3/Rw/ONdtYNIvgPK98kmAy2qLALi8agSdmsOZJQ=
X-Gm-Gg: AZuq6aJaxRvpZrfU9u3Jji12I8DeNVzG6+Go4vGmgqOgTQqWnsd+R5Lpx0LpysZg0OY
	orvx3MapVcAvZHBeV5MSMssHenVS/GxHud29Xmopb6RqBQDwy1tSctZcaQJ9fiF6uOaL9Y7yV5U
	PfZtMVmoMQZyX3Kg7BjjWZRDKRrnXXlHgHtmxaBnhCXXKUxgQY1LtAm+pQZr+Q6oIKmS/mlmkWT
	GULZZZlafSAsZsfoTdb/7V+GAT7Kn2ZLOWxAbsQD7lL9yZ5yaj/BT4KND+wB/PJ06KnK6ty3RO9
	f2s7WjYmf76jek5Yq3WZMZrOlGxAbh4bXg==
X-Received: by 2002:ad4:5dc6:0:b0:895:24bf:d15d with SMTP id
 6a1803df08f44-8974048371fmr195566456d6.32.1771402816681; Wed, 18 Feb 2026
 00:20:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAC5umygPq8+FQWTG73-QPOKHT1P5=N2+qFkrRfZAkL_7G=gQXQ@mail.gmail.com>
 <20260217151545.77290-1-sj@kernel.org>
In-Reply-To: <20260217151545.77290-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 18 Feb 2026 17:20:04 +0900
X-Gm-Features: AaiRm53XB21nt4UMjs9dd2YfUlRro429InniW6JTTyZjtlI0y-cXLRjhiqzLE9g
Message-ID: <CAC5umyj7jb-RUXJPv+YMC5Fd3ST=YinW_t7Sj5kCpoA2d+rDXw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B42=E6=9C=8818=E6=97=A5(=E6=B0=B4) 0:15 SeongJae Park <sj@kernel=
.org>:
>
> On Tue, 17 Feb 2026 22:32:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > 2026=E5=B9=B42=E6=9C=8817=E6=97=A5(=E7=81=AB) 9:13 SeongJae Park <sj@ke=
rnel.org>:
> > >
> > > On Tue, 27 Jan 2026 17:12:23 -0800 SeongJae Park <sj@kernel.org> wrot=
e:
> > >
> > > > On Tue, 27 Jan 2026 21:56:43 +0900 Akinobu Mita <akinobu.mita@gmail=
.com> wrote:
> > > >
> > > > > 2026=E5=B9=B41=E6=9C=8827=E6=97=A5(=E7=81=AB) 15:43 SeongJae Park=
 <sj@kernel.org>:
> > > > > > Actually DAMON is internally setting such maximum region size b=
ased on the
> > > > > > min_nr_regions parameter, via damon_region_sz_limit().  Nonethe=
less, the limit
> > > > > > is applied only in regions merge time.  That's why it requires =
the regions
> > > > > > split to happen sufficiently until the real fixed granularity m=
onitoring is
> > > > > > started.
> > > > > >
> > > > > > And I think this behavior is just a bug, or suboptimum implemen=
tation at least.
> > > > > > That is, users set the minimum number of regions but it may not=
 really be kept.
> > > > > > That's definitely confusing behavior.  Actually there was a sim=
ilar case that
> > > > > > number of regions can be larger than the max_nr_regions.  We fi=
xed it, with
> > > > > > commit 310d6c15e910 ("mm/damon/core: merge regions aggressively=
 when
> > > > > > max_nr_regions is unmet").  I think we discussed about similar =
case for
> > > > > > min_nr_regions, but I cannot find the discussion for now.
> > > > > >
> > > > > > So, I think it is better to fix this rather than introducing a =
new parameter.
> > > > >
> > > > > I agree with that.
> > > > >
> > > > > > Maybe we can split regions based on the min_nr_regions based si=
ze limit, before
> > > > > > starting the main loop of kdamond_fn().  Similar to the max_nr_=
regions
> > > > > > violation, there could be yet another corner case on online par=
ameters commit
> > > > > > situation, so it would better to check the case, too.  You coul=
d implement such
> > > > > > fix on your own, or let me do that.  In the latter case, if you=
 don't mind, I
> > > > > > will add your Reported-by: tag to the fix.  Please let me know =
your
> > > > > > preferrence.
> > > > >
> > > > > You'll be better able to fix it, so please fix it at your conveni=
ence.
> > > > > Adding Reported-by: tag is fine.
> > > >
> > > > Sounds good, I will do so!
> > >
> > > I just posted an RFC patch series [1] for this.  I will drop RFC tag =
after the
> > > current merge window is finished.  Please let me know if you find som=
ething
> > > wrong there!
> > >
> > > [1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org
> >
> > Thank you for posting the patch series.
> >
> > I tried it and found that patch 2/3 made things worse than before in te=
rms of
> > monitoring at page size granularity.
>
> Thank you for sharing the test results!
>
> > This is because, in my evaluation, new
> > target processes are added without stopping kdamond, so processes added=
 later
> > are not initially monitored at page size granularity.
>
> Nice catch.  But, the min_nr_regions based region split of vaddr was trig=
gered
> by damon_va_init(), which is called before the kdamond_fn()'s main loop. =
 How
> the regions were split before the patch?  Probably I'm missing something.
> Could you please clarify?

Before applying PATCH 2/3 ("mm/damon/vaddr: do not split regions for
min_nr_regions"), the damon regions of processes newly added to the monitor=
ing
targets after kdamond started were split by damon_va_evenly_split_region().
After applying PATCH 2/3, the call to damon_va_evenly_split_region() is
omitted, so those new processes are monitored by larger damon regions.

> > Would performing a split operation like damon_apply_min_nr_regions() wi=
thin
> > damon_set_regions() solve the problem?
>
> Yes, that's the plan.  The split operation should be done for online upda=
tes of
> total size of monitoring regions and min_nr_regions.  I'm preparing a fol=
lowup
> patch series for that.  While working on it, however, I found it requires=
 some
> refactoring and cleanup that taking time longer than I expected.  Meanwhi=
le I
> was thinking your issue is only at the beginning of kdamond, and I didn't=
 want
> to make you wait too long.  Hence posted the series first.

I see, thank you for the work.

In another evaluation using paddr, no new damon regions are added after kda=
mond
is started, so applying the current patch series enabled monitoring at page
size granularity.
