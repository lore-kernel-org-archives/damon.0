Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092411;
	b=KykbWwqlRChVoLv62GM+kgyt3lH1RVwIPyxc5U+nYkzy6W1Ax53CijTVvyZOU1TH9+AZ
	 m4rEskLZNSpyjJmmSFTu/CBpXeg1+A/2mVUlTwvJHJytYxDiteRfqN4fD+bqt/mwuMIpG
	 IQ/QGkgq5oH4OCOVyIqTmCnVQ1xkubrbdMSqtiLkhfFGlwMDeMrqDgyZSlEEUeoXL93il
	 c0Bowq8C3HjwaK1Uu7NwCzaU+3A9BULCrTGr6btyfZ1NpBLVUp/VXoWVCK+OL/od5VHD3
	 dqa6v7esn0FSiEU0ZX4Nm2bYoF1GHbXdWKCqZzXUUj4lCjSeQljkWPhaUzqgS9Gd4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092411;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2nPedpe9fvXNxnCnfL0oF2XIPr3VRkJl9pVL7wPawBk=;
	b=YpYlEe35ve+1AAvnzIPwQWlcagW5XDBB2iDjlXv4RFM6jZkElef/CaD+L0LJJ8gpLICV
	 4y1ZEFfHAJ6I26Gn0OBWGE2yA0OLekS+mbGF3X47nbg6vn1KHv0qC+CEAKdTGdrlfWHbH
	 nx4JwfDYWsokBPTGg0/UAFfszrRG3z6UFwlXh9pfiIHqCpx9uGf/whrY3/Aaz2HYAQC9e
	 xBGjCLHHVJd9D47UoqL8KZXWUVFtD9PlVinNOOPp/zvLV16PwiVzsHeCP2yEO4Bo8qIYd
	 6YoBy3rhyipOpyuyq8Rpo/qUVcI02pMP+PfxwdiUHUCQTSa+VCZLTPRlGWfRnNIRV+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ne2+iWZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE1606A32C
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ne2+iWZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EC51F0089F;
	Sat,  7 Nov 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092410;
	bh=2nPedpe9fvXNxnCnfL0oF2XIPr3VRkJl9pVL7wPawBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ne2+iWZTrSTy58Ahwlyxyb0R9k5m1UmL7ars3odDrkX2sDT9klY0gUPSfNaYiyW1/
	 WhRvS2QRDgdBfvPQR+e+yNnX2GC9eLj8HRJWE8Tn+9s+nv3o8Wpt8r+EPKhBp/iODH
	 kJDI/m5MKooUAXTmph9rDYBeJy4rtHz6NA82UTAAw3yF2JeLNt5p5O+gwbmCTa3jen
	 rQqGk8BByLRlqIjPfIM0ABpvsRGbAzUPK5CnO/V2blMmgP0J3B/58TUdyAmrCOOJMt
	 UonnMEb+6Rx9dVPtfR1Q6vLoFV7bxyJtwDzptaHEQra1J3lnBE6+POQ7ZgvekNfaR6
	 dZjomrnvy/Deg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Usama Arif" <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.1.y 1/2] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  7 Nov 2026 15:00:02 -0800
Message-ID: <20261107230003.340646-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-203373@kernel.org>
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

On Sat, 07 Nov 2026 22:56:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon: inflated tried stats in damon_do_apply_schemes() on
>   split failure
> --
> 
> commit 2d405ecddea503227b3b4138fe63cbeb95dc50b9
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> This commit changes damon_split_region_at() to return an error on memory
> allocation failure and skips applying the DAMOS scheme in
> damon_do_apply_schemes() when splitting a region to fit within the size
> quota fails.
> 
> Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
> Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index f0da5cb2b88a0..9206737d05ae7 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -810,7 +810,8 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  						DAMON_MIN_REGION);
> >  				if (!sz)
> >  					goto update_stat;
> > -				damon_split_region_at(t, r, sz);
> > +				if (damon_split_region_at(t, r, sz))
> > +					goto update_stat;
> 
> [Severity: Low]
> Does jumping to update_stat here inflate s->stat.nr_tried and
> s->stat.sz_tried when damon_split_region_at() fails?
> 
> Unlike the !sz path right above, sz holds the non-zero remaining quota
> when damon_split_region_at() is called, and update_stat unconditionally
> accounts it:
> 
> mm/damon/core.c:damon_do_apply_schemes() {
> 	...
> update_stat:
> 		s->stat.nr_tried++;
> 		s->stat.sz_tried += sz;
> 	...
> }
> 
> Because c->ops.apply_scheme() is skipped and quota->charged_sz is not
> advanced, any subsequent matching regions in the same pass that also fail
> to split will repeatedly add sz to s->stat.sz_tried.

Good finding, but the user impact is trivial.  Same behavior exists in the
mainline, too.  Hence no blocker for this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107224800.340250-1-sj@kernel.org?part=1
> 


Thanks,
SJ
