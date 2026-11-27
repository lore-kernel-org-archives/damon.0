Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813166;
	b=NBbW+z3z+y9nWb9lcL4QdDoOKsrs1OIcGsoVef2ynzBZo69e1qG2aGt6KLJZMumWKOMo
	 fM1p/GMG9EvLY7/caKjbiA72EXbZLMBEbiG3xFg8w1o8AjqizutnXxAUy9Yy/0D3Yzbn+
	 50Yy6lytHKBGBSaTQLe2dvf7QS3gxmLhy5f66+OMg5FqskpSxfUMr9nJWDGYQK1AyMCT7
	 JlcJOOGcrNYqjg4EHNjMNwq8P6O10U5h3ehVuy5h/h+/MmAPF/IoNH4n1BwGQK8g2dHJH
	 W3weHZcHuJ8uuI0hsNeE3d+lhYttPyW19tcyUvo63iHu8oUhQdleIBae3AD9NXlRI8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sGUE3FRU91WeCWpfrRYcG+pSF95rb2MiyCWB3OFDj8E=;
	b=4HOCPYaPlN0L0cBTuM6YSCxcr4fXma8KN3vCKEkk0QuAs9OBDOlMyGhj5WzCRWCFdima
	 mF/bOgib5z4euImHvrXPyBb05Xwcmdz8t+dyWWkgUFqDS79BOImhyubExUrb8Ig8X4bIV
	 sYHnA0ihix/qO1ilDnuKODyoOurUeV9BeUEZWkIbj9aBxbHMW0QitAj6CiHPIUuNxnwwp
	 6DrJvRC/VFzGimLzq6IgTWLj6AnJeqhlHGvx0vaN/t7JAE/ScV5gazHVkM/yrXMAR1N90
	 j0uO225vdUKN4gK/YnXCk8EDnStajowQPSWkHHniY15CulTxfX6B5dOJbWf/ATvD+ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jawgVaPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926A606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jawgVaPJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265401F00893;
	Fri, 27 Nov 2026 20:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795813166;
	bh=sGUE3FRU91WeCWpfrRYcG+pSF95rb2MiyCWB3OFDj8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jawgVaPJgTsEc/nKhz6RtARNumvb/bsH9EANc9nRTLCtZoO8AUKNmQHHMwt02PiB8
	 CiKAnVSj48yL8+8UcCY39ltzWTpNfW1ZGIEtdTLVoFlSFsg6DA6E4usrSqt2Kdqir1
	 5StqkmqF/vdsBCi/OAVP5R/lhEnbnpgj0RP2HFfc4SKC5Yf/fEZhmczpiEXcTFrCW0
	 iRIoEeWzPi0hbdNmW2l1GunOneaX1sZHasEIHT41tUs1zuDl3/A28Z1NNvPZJLxV85
	 dVK2fn1XRpaezexXtZvw16uOetzNXm3WBuF/SzPf9eYLttoYBrR+Eoi0/P16Xu7qbv
	 aV5+UXr9SiJag==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH mm-hotfixes-unstable] mm/damon/core: do not update stat for core filter rejecting region
Date: Fri, 27 Nov 2026 12:59:17 -0800
Message-ID: <20261127205919.95770-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-238270@kernel.org>
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

On Fri, 27 Nov 2026 20:48:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mm/damon/core: stale region size in damos_apply_scheme()
>   corrupts regions
> --
> 
> commit 2aba0f31066065a1efc163e77a7548d189458afa
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: do not update stat for core filter rejecting region
> 
> This commit moves the damos_core_filter_out() check in
> damos_apply_scheme() ahead of the quota enforcement check so that
> regions rejected by core filters are not accounted in DAMOS statistics
> when the quota is full.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0e6b361f97ea6..e0ea93de100d8 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2785,6 +2785,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  	}
> >  
> >  	if (c->ops.apply_scheme) {
> > +		if (damos_core_filter_out(c, t, r, s))
> > +			return;
> >  		if (damos_quota_is_set(quota) &&
> >  				quota->charged_sz + sz > quota->esz) {
> >  			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
> > @@ -2794,8 +2796,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  			if (damon_split_region_at(t, r, sz))
> >  				goto update_stat;
> >  		}
> > -		if (damos_core_filter_out(c, t, r, s))
> > -			return;
> >  		sz = damon_sz_region(r);
> 
> [Severity: High]
> Should sz be refreshed with damon_sz_region(r) right after
> damos_core_filter_out() rather than after the quota check?
> 
> damos_core_filter_out() -> damos_filter_match() can split r in place and
> shrink r->ar.end for a DAMOS_FILTER_TYPE_ADDR filter.  Because sz still
> holds the pre-filter region size during the quota check, when the
> remaining aligned quota falls between the post-filter and pre-filter
> sizes, damon_split_region_at(t, r, sz) is called with sz >=
> damon_sz_region(r).  That expands r->ar.end back across the filter
> boundary and inserts a zero-length or inverted region (start >= end)
> into t->regions_list.

Nice catch, I will fix in the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261127203938.94339-1-sj@kernel.org?part=1
> 


Thanks,
SJ
