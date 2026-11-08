Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169535;
	b=e/48cpQ1tUA7Ok60jpXSfik93YlNRcDZYezOLwZP+DUWicT0zscM41Iu7ch//xncKQWs
	 +nN348nt6fUVZJjUh4GX7K7iMk3BcNvmh28DslwamOyL6aax4UjyJrpOZutUfKGKDJDk1
	 c8HqExPQl1M5cujRWlgF6BSFZ2FthUjI6BBvZpNsCuC3Qvg2CpDU7qyCY+bRA0XY9zzyz
	 LlBf3q8+udozqiydbBjtLmUF0wVe1DAobyIK29YNOc9qXn0C9z/XGh4ZQS0Iu9C08ZC5m
	 pwBFMVn75ZPby2KI2QGkhoAxFi5O9G4hm+j43u1j8+A/+QuJE/Edvw5n6xPRzCXcFWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lUqT5v8YaI9EUU1s6fZT3bdyN4xwYNxjDjc2jWcGBi4=;
	b=FVy1hobeGyeUHEv1KDRvWF3mc3pCIFzML2cKdEYu7qM4prtAdUKrHJUlnUaVBymMZMJF
	 6KkzQBYxtJEgv8TYA9/+OpyCmFYuUBgYNjiPVdQam+CoI0t2jAdVz6cCqk3u+5ZmPorsn
	 rR7DlVUbSOpdc6flNxBUJMFlFCvgwnOsRUdRMyXL0Mu6R+4RiIpg/TFUdtJpuKziod5GM
	 0Uxu+clnZK+kE6y2UkfomV21vze5xmngSa5kIPnrO2i7JsMhxfMKetthiVYZ5Xrmd8kdn
	 1dBxKqk+KOVZ4pa6B0b30MKrW3wenczds9czsEAix1vKfgy55VBeHWpwItrle0nx2hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELqru6Ia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D686086557
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELqru6Ia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2601F0089F;
	Sun,  8 Nov 2026 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169534;
	bh=lUqT5v8YaI9EUU1s6fZT3bdyN4xwYNxjDjc2jWcGBi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELqru6IaxAwNIZ8+Tc45OFVN6yyuai77lcJeNDhYMvPWKYrBGu4d41U3I/zY1ol0H
	 WMPcex/20VhBcwadogTDxD8Bl3QS+LC7AjmMucLkiWPdGE3kO16JOiUnU+pdlkn8cM
	 YRS4m0yD53aU2X4dmauwQ95vw053MS5vf45A2p+D/Zn1SvOowPTSpLD5g2AqdD1IgH
	 vSS4uhrgAkqn/16fTmentlt99wBOnieuAnYB/j2JSWf5OqGRUMFhkZQnGBmtoZt9Oz
	 4IbrqQzXlEqy+LzN9+rMAKRZurNCv/9w2LG6XJbbyBGM4wejSOUMOr+NIGlK17YjOR
	 4S0Dur2/QI5dw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.6.y 1/3] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sun,  8 Nov 2026 12:25:25 -0800
Message-ID: <20261108202527.117086-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-204013@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 08 Nov 2026 20:23:37 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon: false tried stats on split failure in
>   damos_apply_scheme()
> --
> 
> commit 17459070b1916b2d77f607f0fb7f0f9158e6224f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit updates damon_split_region_at() to return an error code on
> allocation failure and skips applying the DAMOS scheme in
> damos_apply_scheme() if splitting a region to fit within the size quota
> fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b5b6d00d7a3b5..9d4a78deaa06a 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1004,7 +1004,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  					DAMON_MIN_REGION);
> >  			if (!sz)
> >  				goto update_stat;
> > -			damon_split_region_at(t, r, sz);
> > +			if (damon_split_region_at(t, r, sz))
> > +				goto update_stat;
> 
> [Severity: Medium]
> Does jumping to update_stat here falsely inflate s->stat.nr_tried and
> s->stat.sz_tried when damon_split_region_at() fails?
> 
> At this point sz is the non-zero remaining quota size, and
> damos_update_stat(s, sz, sz_applied) unconditionally increments
> s->stat.nr_tried and adds sz to s->stat.sz_tried even though
> damos_filter_out() and c->ops.apply_scheme() were skipped.  Because
> quota->charged_sz is not updated on split failure, every subsequent
> matching region in the walk that exceeds the remaining quota and fails to
> split will also add sz to s->stat.sz_tried again.  Returning early here, as
> damos_filter_out() does just below, would avoid counting skipped regions as
> tried.

Trivial user impact.  The same behavior exists in the mainline.  No blocker for
this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261108201456.116824-1-sj@kernel.org?part=1
> 


Thanks,
SJ
