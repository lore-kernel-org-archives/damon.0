Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844383C98BF
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763818; cv=none; b=g9YhB3GeZ1I64FH905HKANzyRbC/Ho+KSKrDSjfMIBE51qSty31UfzCaG66g7gy2KZowYgOE5n5/n3B08PynldR/s9qPpfdmr2CwOtG2y+1dPz9SUs1L4NBdUwwG4xJJ+50WFLL8HrnF2X+zfUpX2NGpDZJ69pjfKvffcw3iZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763818; c=relaxed/simple;
	bh=dKesrCco1qqXOhwB2i+axgaAFg6FmbyhkpkA5F9kcJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNv1Q2wKAlHWUGJDgAowPEoqB2Sb1in3+vSmcQnu3nsyzPbwggu95vguEDPb6cInKShcD+F3OfawDAZ62QpaCAsPOJAPqt/cu0A62x04W4/VmFiWEQYZ4wNvk/KrnZbfkmeMqk6qrj9Vr1nGykcwR2cOtzZMqProdkMHPpSWpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doVNJWH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doVNJWH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B26C1F000FF;
	Wed, 30 Sep 2026 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763817;
	bh=wuf6nALUyWZpCCvk/R3GEOi3m8ASlftDatfJOx8mW1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=doVNJWH7810J9c+WaJYHZtDLZYziQJSiYYSkQuel5WuAV8drKNZWMU23SWbwMmcsN
	 bevo9jNddF0Mr4Vb0bD6JEmbeDnlDz/Qu/wvre1GdcQGMA2Pn/51rITJ8tTgzAg3Xi
	 SinG3idF7s+bCOgkIX+GQ6BFEakIsA2rcihMlDC7wTB3ZPwwJgk9UutgMbQH++mg5J
	 pPUrlYf7R8kxxQ41snKvGRJv7rotvpdMQM+6JLiF3YFyp9lsTTErT09J+xbHew88No
	 ps3yd6V1x8EySfKPvKkxH99mbMac8orYfGg1C+3iZFWw2ve1pceUhKhs4N4EqTUFUv
	 0Utn4c6KoCukQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:23:31 -0700
Message-ID: <20260930102333.58847-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930100511.53E731F00898@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 10:05:10 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: out-of-bounds memory access when region split fails on last region
> --
> 
> commit e8c0d519ccfab8bb3783274c1139b24ab75f8aa1
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> This commit fixes an issue where the last region of a target is
> unconditionally skipped and reset when a quota is set, even if it hasn't
> been processed.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 859a6a636ab0e..64ff03b15fdef 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -768,14 +769,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  		if (quota->charge_target_from) {
> >  			if (t != quota->charge_target_from)
> >  				continue;
> > -			if (r == damon_last_region(t)) {
> > -				quota->charge_target_from = NULL;
> > -				quota->charge_addr_from = 0;
> > -				continue;
> > -			}
> 
> [ ... ]
> 
> > @@ -783,17 +781,25 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  						r->ar.start, DAMON_MIN_REGION);
> >  				if (!sz) {
> >  					if (damon_sz_region(r) <=
> > -					    DAMON_MIN_REGION)
> > -						continue;
> > +					    DAMON_MIN_REGION) {
> > +						skip = true;
> > +						goto clean_charge_from_skip;
> > +					}
> >  					sz = DAMON_MIN_REGION;
> >  				}
> >  				damon_split_region_at(t, r, sz);
> >  				r = damon_next_region(r);
> >  				sz = damon_sz_region(r);
> 
> [Severity: High]
> Since this patch removes the early check for the last region, what happens
> in damon_do_apply_schemes() if damon_split_region_at() fails on the last
> region?
> 
> If damon_split_region_at() fails under memory pressure, it returns silently
> without splitting the region. The code then unconditionally calls
> r = damon_next_region(r).
> 
> Because r was the last region and was not split, its list.next points to the
> list head. damon_next_region() then returns an invalid pointer. 
> 
> The next line calls damon_sz_region(r), which dereferences this invalid
> pointer and causes an out-of-bounds memory access.
> 
> Does this code need a check to ensure the region was successfully split before
> advancing the pointer?

The out-of-bounds memory access is indeed occurs due to this patch.  But the
lack of damon_split_region_at() error handling was anyway a bug.  So, in a
sense, pre-existing issue.  I will work on fixing it separately.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930094853.52736-1-sj@kernel.org?part=1


Thanks,
SJ
