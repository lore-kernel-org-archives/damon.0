Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1B25A2DE
	for <damon@lists.linux.dev>; Thu,  1 Jan 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767230538; cv=none; b=PKqmxG3h6Odgdh/YF5nwsjHzixtrwtgTe/B6NOplLP1DwSJf/7isdtbqr8f/zA0IrqcferKAfC84zMrcu77R7/XB6/V/LtzfIfC+QT9egLYQ85t8Wxbke4Y+VOXt85aiCgNYglg1prz1wYPy9CXKhXaGqvpO5fSZHMYti2247A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767230538; c=relaxed/simple;
	bh=88nXh/IcZ3CB4IQc1W4TNVKebbzFPI2U9p+u/L7nqTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbAvbDVCr0OPp6IFjUMwO5X4le1p8bkPAbN/McT+xRowpCd6av4reLDROY1C7waIIWwH8MFww1S0Oiz/rRyKeyRgovERBl3A4TSOx+45i9c0ri7O2ET82+KrnRoclMGllwvw4K6Bm9Fu//pEe2oiIqUEfUa7FRD7Kj7CloyEsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j64j8Iwo; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j64j8Iwo"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-644715aad1aso12978507d50.0
        for <damon@lists.linux.dev>; Wed, 31 Dec 2025 17:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767230536; x=1767835336; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RQOdNx1mSguhKTRvTy27tgDNO5v6Rp2RNeV+ObddlJE=;
        b=j64j8IwoH17npLDb5x+YI8s/W0uWwoGjB9hTYsZ9i9wLrJtKG81C/y94Qi+cY0nTt2
         /2U7yGRMFWt7kGds4liQx/pBlfxqwNffVzY6BMu97FpdSAxYTblIjOa/aLNFA/xivRlm
         JqnD46o/wQRPQiFr8iKYAq9cfcLJSPpW4vD/QmWpRYAgydOqBgr70QPFYpcC0fjzReJB
         03REZnKKsfFwjfuCN22ARNlkKXNBuRe20C6f1y11v3dOPeVECvbGNMmmOQLrjgHu/vnc
         1YHuhRBo15qR59g9lC66kOCXHN+hmLglS43QRqvo1WagWn+jkkz5cKwe2wT8OLX9KYzM
         NF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767230536; x=1767835336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQOdNx1mSguhKTRvTy27tgDNO5v6Rp2RNeV+ObddlJE=;
        b=DEiYCperJWYZnA8zu1SoY/D5BdgV25GKze6MsmbdGYd6ZKh+ojLBS+NkCm7hQUdggh
         4JtOStBoovHdanlq3VdhSpGMfwqnhkvSel18J4f2xB2HB95jC3Dug9CaxmZeMm28a4km
         PoAhIIPtplo24hqTpDlWdXbQg/0T01dweS0xpM/u/YI19Y1t98KDkJONfMpecH6PJsCZ
         cRmN4R6Nooq3Ao/4uRKTDgN5uOweS3kZUNU6a2W1bGNikjzr+8UlNaOhRxu3/k33fFWq
         lnNy4v8DQ5Gqctn9OtPLaMdnz2U3xQlX26A42DNDGa4ilIyFxRokRO39KL2Q/zcQTXJZ
         951Q==
X-Gm-Message-State: AOJu0YxzB5weC66Od5l1G9chzqnxiAQ4FxuuTCNPtfMC8n/2dX0fuxP/
	EwTz3fdHUhHEcVJQA/0hcNCbzpeetXgOkKpld0IbJIvEDUkye/v/+NCY8RJIhfvnFmYTVbWlArG
	SmdEwP7D6oMl7gfXsSTsPnIpvnXA1Nfw=
X-Gm-Gg: AY/fxX7TWegF/dwPc5dR+9qO+HmTvkanEpmiMlDJ79mSR071FwgVmEuawfKI5uFhbEb
	cvmZwUGsmitmDMtEktycTkPx2PzzSQBbFxTZAHFgKJBOw9K2xc7aFfrRPXL1NY7avOgPwydUokW
	Klw+rPv4aheMRPuaY+O5GxHmmMP9YBSnIgAvovxevVssXHOUCynTX5ZKJI5PzzDS9hxYda/8bAR
	Ie7darf3/EB2egKOsdXGpPTf6iQrbM4fJiJmFqr9njV943R5fUf5Muy0yDmn4+B1n88KiZN
X-Google-Smtp-Source: AGHT+IF7ZajupyJjQoLfH8qqmN3ySL+FWmQGBP39A4phKP+l1pLEwwJhnDzjVj5FiIaT2KDPsQ+lupx3dsEKY9sSZjE=
X-Received: by 2002:a05:690e:11c6:b0:641:f5bc:692a with SMTP id
 956f58d0204a3-646632c32fbmr34527753d50.35.1767230535662; Wed, 31 Dec 2025
 17:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6RwVzujJcuosiignDEQoe038eRJHuJVLEtJ4-qP8Ot9w@mail.gmail.com>
 <20251231152931.82221-1-sj@kernel.org>
In-Reply-To: <20251231152931.82221-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 1 Jan 2026 10:22:04 +0900
X-Gm-Features: AQt7F2qhPoI7ln7WyMGehJD_RyHX25rNZn4_5PnbevoAL3lkM0FHo51O7_FvLR4
Message-ID: <CAHOvCC6BUnJhu4xpm5xtr2ErHWkzu9BPbMJ_gy0VtCAkFOPvKA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, rgbi3307@nate.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Jan 2026 at 00:29, SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 31 Dec 2025 15:23:49 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Wed, 31 Dec 2025 at 10:28, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Mon, 29 Dec 2025 16:57:15 -0800 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > > On Tue, 30 Dec 2025 09:14:37 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > >
> > > > > I will reflect the above in patch v2.
> > > > > Would you like me to resend patch v2 ?
> > > >
> > > > I just found my fix [1] of the bug that you reported has a race condition.  And
> > > > to fix that, I think kdamond_call() will anyway need to be modified.  I will
> > > > shortly send more details as a reply to the fix [1].  Can you please hold this
> > > > refactoring until all discussions about the bug fix is done?  Sorry for your
> > > > inconvenience.
> > > >
> > > > [1] https://lore.kernel.org/20251228183105.289441-1-sj@kernel.org
> > >
> > > I ended up sending the new version of the fix [1] without changes on
> > > kdamond_call().  Unless you have concerns on the fix, please feel free to
> > > proceed to v2 of this patch.  Thank you for patiently waiting.
> > >
> > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> >
> > My patch for the kdamond_call() function further improves control->list
> > to behave as a FIFO.  This also improves stability against the control->list
> > collision issue encountered when damon_call() is called.
> > If there are no further objections, I'll send you Patch v2.
>
> If you want to say something about damon_call() uaf issue, let's make a
> conclusion about it first, rather than mixing topics.

I agree.
I hope you first resolve the damon_call() issue, and then move on to v2
for kdamond_call(), which I patched.  That would be clearer and less
confusing.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
