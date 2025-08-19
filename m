Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E4259CA1
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576623; cv=none; b=MOYUboywk13zvzm0/47HB/HnSznOgCI8eHchEJSzbY822BBE8boMqXY/XAJf/neHNRyndkxly/jGfmwBVOlGlLo7yO//5Di2k/V8FLlaDtRpQcj0WkjT6gLeEfV5XFxv9uqIy8HVSyk87z/q7GFakjgAmtcIykBQvK7D45wDHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576623; c=relaxed/simple;
	bh=Ct8DYP4h7623FT1CRn0CsCdshuMSx0q1mS+4qwcuxzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXBhhGs/z7KjY8FJz+Ep9+JD2YntFXsz94PcM0JhShmrhBZK+4bJd9TjCWQUvcYNIokEEONsK678VESw6IXy4I+j3N9uksOPh43Qp+qtt9pjOLy2WFEeSU3ZLr5C1ZtBiiNt5s82PfOtc3SnyCQHCyQxRG/qxo3Bj2oO0/JMm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN1CDyAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN1CDyAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDDBC113CF;
	Tue, 19 Aug 2025 04:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755576623;
	bh=Ct8DYP4h7623FT1CRn0CsCdshuMSx0q1mS+4qwcuxzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fN1CDyAaGE0qO2+jq0hLxayWgaJoaVi82Uus2oAxxH8wd1MOJlCgropkYU/CtEzuX
	 iZMyYl+txKaTLb5k8buB8BcQf1NU5xcYzAY63yH1QZTR7AVh+RcMWsUyeJPxPGlHLc
	 EzFbJj4SKJiteAmgPaAj+ZjtzAj0bD/ooFv2gT55xMII7VrRR9XGOW8gx+Rh42PtLj
	 tSMzc7AWX+6Oec2sEOsRhvQtSoRXyOTfjbtCgNMLGg6bmKbRcyaK3m5WpNUHxFw+qW
	 +cXPC/CSobhPW7j/ii5Waetb6FPQ8hgeCUYVHy+jYgVuHqNhKR+v3gIzw8det0X5mT
	 xpbfihN0yVwiw==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: set initial quota->charged_from to INITIAL_JIFFIES
Date: Mon, 18 Aug 2025 21:10:20 -0700
Message-Id: <20250819041020.37596-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMGRO_Mh-c1RvB3-SWAN2SJZK64qb==sOqb-MhtX56_E-Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 10:52:02 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hello, SeongJae
> 
> On Tue, Aug 19, 2025 at 8:01 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello Sang-Heon,
> >
> > On Tue, 19 Aug 2025 03:38:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > > include/linux/jiffies.h
> > >
> > >  /*
> > >   * Have the 32 bit jiffies value wrap 5 minutes after boot
> > >   * so jiffies wrap bugs show up earlier.
> > >   */
> > >   #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> > >
> > > In 32bit system, if quota->charged_from is initialized to 0 as it now,
> > > it will not adjust event if reset_interval_ms passes for the first 5
> > > minutes.
> >
> > jiffies is unsigned.  Hence the initial invocation of time_after_eq() in
> > damos_adjust_quota(), which is the only place reading quota->charged_from, will
> > return 'true' and the quota adjustment would be done without delay, unless the
> > scheme apply interval is unrealistically big.
> 
> Yeah, jiffies is unsigned but to cover wraparound in 32bit,
> `time_after_eq` casts intermediate value to signed value.
> 
> #define time_after_eq(a,b)    \
>     (typecheck(unsigned long, a) && \
>      typecheck(unsigned long, b) && \
>      ((long)((a) - (b)) >= 0))

Oops, I missed this part.  Thank you for clarifying.  I still have a question
about the fix, though.  I will reply to the original mail.


Thanks,
SJ

[...]
