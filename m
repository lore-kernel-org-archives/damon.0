Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DCB38CFE8
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329511; cv=none; b=RiIm42MJR08hijNlfM6Vv7Ez/if7tjJUOoT8Y1q5DFTgVCV8QOGwS19lipZI1g1FdUKI1EZA5rAbg9xPh2MQQiYzVG9m/g+PAcTLtTYo57wxdFGTIczixo0z6Kk5rY1rtmjV9A/9r0RLV0qZWJe/VHtuf3C4+iVkD1dLFFwGFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329511; c=relaxed/simple;
	bh=xteZ1mR6rPor2VJorfhK5IusqQzqaGoR5u5uj8VFHC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2ATC5uPNcK96UnHMo21KnAj/Y+cAOP9g9CtCyis+EYqUsLRq7ebx8fbUxfUNTw3eSOhCDHcwBupDfd0VfuYu5YT6215UUAf5aPdVgQBVdU5CvqhOjxz1l4aP+DUmLwWiyMAQ+x4F90YtS02JWkTlGaUUBfJdxgw3KKw5PO1NrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqQmEtaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqQmEtaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CAA1F000E9;
	Wed,  2 Sep 2026 06:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329510;
	bh=K2QGHiHA/ADOkBkMOS1O22Lypa2qbiVCuuSV//88eow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqQmEtaWPYhzLqr1Z5hq2QseRd6jc1wfvBawvK3NHGWfFytNo4YY6EIre0djaJRa3
	 SnWH4/Y7pSgC1MA4UWHSp8t7vBI7pBN6lhhUkOT8Deme8BRq9Fb/kcOG4AYmUX5lvp
	 f/lANLaiZXClMbHjwMFaHpIhWQudMucka1zsvwX3h/RTaN0O5kG7MHnR7ccmdzpXvf
	 YiroI55f2e3mD8pFfzL086AK1V8F3JF9iTtOxozfO2HSQjtbvc/SBoZ3GtrtF+g8Gn
	 T8oVoFPZvQFk+sKWD8qJ48l7tFi836W7ZlSNP/YZCZQM+9hXaLWZ2CmQ38E5YpEp0e
	 5jlENbOZezqCQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 02/12] mm/damon/core: remove debug messages
Date: Tue,  1 Sep 2026 23:11:41 -0700
Message-ID: <20260902061143.104268-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902055210.2D9401F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 05:52:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch removed the last usage of `str_high_low()` but did not remove the now-unused `#include <linux/string_choices.h>`.
> --
> 
> commit 43d661e4f50bbdfb8a2cca56bf761ac52256d5cd
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove debug messages
> 
> This patch removes several unused debug messages from the DAMON core to
> clean up the code.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index bda8e23c10560..3e42f370ea67f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3729,10 +3729,6 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
> >  
> >  	/* higher than high watermark or lower than low watermark */
> >  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
> > -		if (scheme->wmarks.activated)
> > -			pr_debug("deactivate a scheme (%d) for %s wmark\n",
> > -				 scheme->action,
> > -				 str_high_low(metric > scheme->wmarks.high));
> 
> [Severity: Low]
> Since this removes the last usage of str_high_low() in mm/damon/core.c,
> should the include for <linux/string_choices.h> near line 18 also be
> removed?

Good catch.  And this is the only finding on this version of this series.
Maybe reposting entire series for this small change is too much.  I will ask
Andrew's help.

> 
> >  		scheme->wmarks.activated = false;
> >  		return scheme->wmarks.interval;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902054747.99370-1-sj@kernel.org?part=2


Thanks,
SJ
