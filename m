Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCB2F7F17
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269635; cv=none; b=XuYqAUgckunM2Nm0KynlIsdbqMqQrpO6u4FacoP5JOVzNAKBk4Ssik3xtkA0NE3CLTLobSzC6C9czWVyoonpi/Ccay+ckyta96RUuxCBNsw2Tq9BbqSItOs3iAiQRXZdqkuujtyeY8RUg+LQimiMxJvbcpJcWjXTaiyiuATU9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269635; c=relaxed/simple;
	bh=Fdt7c58cgzv9qRfEnMp55Hod5QOA+poGei/WelaD4Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5/EsnNquXFkqbTGkD8PwA2ETUaTNaw8xzK8F76Ifhsr9F5CPfLwnqSNmBxM8DG0/D/rRDArLgcMhCPFttxInyjizPUPnmruQTz40mZkufOnWfkdBuYQkEVVL0nOpmXo0DThoSwSx8lHV7NExmUf9Nf6qXykpoPzbrxo5NJlTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izmWVE7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izmWVE7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369A11F000E9;
	Sun,  5 Jul 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783269634;
	bh=lEJTNPWkSxjEZErMLt36AbPYx+4csG104nqOnPP5h/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izmWVE7uyxeoW1+oof/9qgN9Nyu6959o8lSC9mqXu0BBuumwy3w/Mko7SeeBVTBoY
	 Jt3cVafNkJ0gGHbBZK7CtD+Vwy9CjIGm5PiDyoPhFYNdzS56wmpbgs6HIPOZSFvmp8
	 BJ9z2oQCwX9dJtJxz8WUAWmGcDbVhscarZHcG2gBg6rZ85JWNfFQiOzxOqYmsIX5KA
	 GB918uZM45XHplVXxjyWqXDW6ERr0x+M2pwQBFgFdsKd6WLOKc+N+jpR+jnEgbh8c6
	 t/dx2JBqlQZJvuOY9LiiT4p7MLWX1s/GjsBr5kSrNtdPUHx32GcxNTdr6JTrxJO2sR
	 nt9Kx4OjiZeaA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 7/8] mm/damon/core: remove start, end check in damon_set_region_system_rams()
Date: Sun,  5 Jul 2026 09:40:25 -0700
Message-ID: <20260705164027.101734-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160651.626791F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 16:06:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removing the explicit `*start > *end` check causes invalid, inverted memory ranges to be inconsistently accepted due to post-alignment bounds checking in `damon_set_regions()`.

No blocker.  Read below for details, please.

> --
> 
> commit f561b43e79bb90540b8053e4d95593cfb96f6d1d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove start, end check in damon_set_region_system_rams()
> 
> This commit removes the explicit start and end validation in
> damon_set_region_system_rams_default(), relying instead on the bounds check
> inside damon_set_regions() to catch invalid ranges.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3846,9 +3846,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
> >  {
> >  	struct damon_addr_range addr_range;
> >  
> > -	if (*start > *end)
> > -		return -EINVAL;
> > -
> 
> [Severity: Medium]
> Does removing this check allow inverted ranges to bypass validation?
> 
> Looking at damon_set_regions() in mm/damon/core.c, the fallback check
> evaluates the values post-alignment:
> 
> mm/damon/core.c:damon_set_regions() {
> 	for (i = 0; i < nr_ranges; i++) {
> 		unsigned long start, end;
> 
> 		start = ALIGN_DOWN(ranges[i].start, min_region_sz);
> 		end = ALIGN(ranges[i].end, min_region_sz);
> 		if (start >= end)
> 			return -EINVAL;
> 	...
> }
> 
> If an administrator configures an unaligned, inverted memory range
> (for example, start=8191, end=4097), the post-alignment check might still
> evaluate to ALIGN_DOWN(start) < ALIGN(end) and accept the invalid inputs.

Yes, that's how it works, and I find no problem here.  No bad consequences like
kernel panic happenns.  It it might be confusing and better to improve for user
experience.  However, I don't think this corner case experience deserves the
additional complexity.  I want to keep the validation simple and minimum.

So I will keep this as is unless others chime in.

> 
> >  	if (!*start && !*end &&
> >  		!damon_find_system_rams_range(start, end, addr_unit))
> >  		return -EINVAL;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705155600.96555-1-sj@kernel.org?part=7

Thankss,
SJ
