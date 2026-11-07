Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088833;
	b=CuZT49IL1+kHXHcQBmmY7WriDwgt+4Drrty2gRa8/3U4GPFP2QxjdpVIdF4uF2Xf16t3
	 aa/v0drJ3DkXR+zI8CcOSS+6v9MuENNBIcCSjoaflihAMfvTkrp1WqGxH0y0hwvx633Q0
	 KUzv8FqEM2RuOuCMrnHa9U+rILeObYXWtClnr311nz9xQAJbpHpqj0WQ4ZYXHFtfokHHh
	 qnPoxDpfzz6E3WyxdWCwPuBoINnIPLrPYfpVT+t8+nv161gAeLf0nel/8a0KTIlIiNeJH
	 MUtHwXDqHTAlub3iUJpy91SCJSmLRDyfaCQWrcyqxsKvTwviAiDBHOsqOULhBXl9+Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088833;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YJGz7I7p/AgQ7qim32bWeDztlYgVQCLK2LaoTD7wEVw=;
	b=2qwghOZToQAw+c8RV9J3CHl59X8vY8PWrmnLa49i1VdJ4c2ik7hzc5IHNQXNkIMeG7Vi
	 /TzArExnECkpZjMI/Ln2vBelOfbmObhdCS9TSMGHoSk0UYFJqgvSuT4M54Gv3ZnjE7c+4
	 pycFRBNXiz061a7bx4kIcHgK6qLN9EUX2XISL0OyKta5m56N4jnS3nA3XzR+lmnP6Twg0
	 NikCwpBE1VIuasqBKCnmdCdJZs2cPP4y34pRtBdwePrDna+T83fjV1Ct8Vs0cOYAagOUx
	 8axL9vlH0gbpQ+bxP0LALSEIzbygHs9kKbf19DnYfOKip+hhRL0/UsvqO5UI95BvnwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oui3YcWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7A606A339
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oui3YcWg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8911F008A5;
	Sat,  7 Nov 2026 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088832;
	bh=YJGz7I7p/AgQ7qim32bWeDztlYgVQCLK2LaoTD7wEVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oui3YcWgTyHT/b1HeHr7nKHqzAN+cTjrI839oHsP4imLid3duglI+zzqrfXWPG1g4
	 nT9CGhvde8GTdv2lnnU/2PJmbieoexL9pbaytkgUX8BESUuWZLdYCAUhWSAwP0pTOD
	 hZQ6IZq1+hlqoj4ptMAMAigbhhA+G8qtkV/qc9K2mI8tRgsRH3N9d+gsQLdNg2jNJL
	 T5PFMZzZQ8KOLtc7U6p+0B3gPsYSSdGbypAl/KGVya8JcktErSwVIa13ijS5AvxQaE
	 B6aAydbkVFh1dzgvahkPN8uMogbkVwiH1JI+D7S9g7k9EMggjHvIEV+XI5DD8XMA+R
	 yhqOFmzIzg/1w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.12.y 1/5] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  7 Nov 2026 14:00:24 -0800
Message-ID: <20261107220026.304899-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203347@kernel.org>
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

On Sat, 07 Nov 2026 21:52:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon/core: inaccurate tried stats on split failure in
>   damos_apply_scheme()
> --
> 
> commit fe019f891ca813eff979dfc83e95ba297bc45135
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit changes damon_split_region_at() to return an error code on
> allocation failure and skips applying the DAMOS scheme in
> damos_apply_scheme() when splitting a region to fit the remaining size
> quota fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 81d44e41de210..6ef77741b783b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1470,7 +1470,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  					DAMON_MIN_REGION);
> >  			if (!sz)
> >  				goto update_stat;
> > -			damon_split_region_at(t, r, sz);
> > +			if (damon_split_region_at(t, r, sz))
> > +				goto update_stat;
> >  		}
> >  		if (damos_filter_out(c, t, r, s))
> >  			return;
> 
> [Severity: Low]
> Should this return instead of jumping to update_stat when
> damon_split_region_at() fails?
> 
> At this point sz holds the non-zero aligned remaining quota, and
> update_stat calls damos_update_stat(s, sz, sz_applied), which increments
> s->stat.nr_tried and adds sz to s->stat.sz_tried even though scheme
> application and filter evaluation were skipped.  Because quota->charged_sz
> is not updated on this error path, persistent allocation failures across
> subsequent regions larger than the remaining quota will repeatedly add the
> remaining quota sz to s->stat.sz_tried and increment s->stat.nr_tried.

No blocker.  The user impact is minor and  constrained.  Also same issue exists
in the mainline.  If we want to fix this, we should work on the mainline first.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107214525.304638-1-sj@kernel.org?part=1
> 


Thanks,
SJ
