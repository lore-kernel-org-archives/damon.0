Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C93473C91
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269786; cv=none; b=OA7U5SDuqDm+D+w4WfXv3xFpQLlZ1cEMMu10JhM8fwb78zkcI58MDrkNDawR+qjrfOOcbaqciyAncDfx6Sv4nMuugTAwkKW1adruFmGbiQ/KHKj/KcXT0HyFUYlA3TSN7/g4D0ICIt/G2NatbmPBE7iH9lLpOy2YL7pVXsBb2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269786; c=relaxed/simple;
	bh=W7viru+6ZyNkvqHwemMMo7t/KuQUnVkvdykkM2kFd+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz4d7ujC3QLWzhECYWkXdRTDOVLc3rY/2SFPek63gWDJxjj1oID5bW1Zl7eTZITK3ss3YTPDjrg0fGbBjlt0E+DKJHceTxkaZMCiQwyBe94IKVYdHLZbA1nBd9nQLJxR1nEMBZVAEYM4iHLJePw3oj82m/aOOtbtcZz2S4qTwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gj4Ike7l; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gj4Ike7l"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e57a753f9so20934885a.2
        for <damon@lists.linux.dev>; Tue, 28 Jul 2026 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785269783; x=1785874583; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R0+dte/NoWIbOI7QCYgcUemSYkCmZHXVRujYxDHF6AA=;
        b=gj4Ike7ltWDXz4fnmyTX5H1z6ZzFpees6QMPbGrDaFoRy7u6PtETVHxP3DzdPEnBrM
         Tc7AKinzB2+BFcpCnrpxCb0DR7cgP0KX3kDBuF1YtZUUPP/6zp0+ajBdzatEEgvFC23b
         aym0kI/5y+6vJW+AQzx99RJkAgW8ezzWxLyMGDurgNKm8l/1E4NR6ifDiv7ub7DWWuN9
         aH9UFlDpf2DRcdSWmxmq7uPI0FVIGVrw/AzCClnuey7JJPkXAjaor4XuzGTkRSGiZunG
         5ptiw5Bp/kwiZCrf2Nq9giQvpaf4z3aA4Tf4izpYe1pWRvMYphrwDZoyry0EFLXTvKe6
         GkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785269783; x=1785874583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0+dte/NoWIbOI7QCYgcUemSYkCmZHXVRujYxDHF6AA=;
        b=R53kzMmhQjPaguy3pSLI4lQMzgG6gc64rHpzDqbDeGkkVRwFu4V0CLF6KPQeh13yoF
         kifA13CYHh3GWQuYC5p4IREmSDqHMXh3ApelB5F5bmNext+dBL1ZYxLupFYbrhy2q3Hj
         3MYthDubLnZ0T6oWGdpqbIM38agMJ6g0NsdsgtKC48ISGQ6R2J/jEPd33PO2onV3l/0n
         lGape7/yhYeA855p4eOWmiwHXgG/mgzF/71ZdK45cW+e43JhK+6YxnDfvV22MB53WbUn
         oYeW9/Ei85HHeSFRyUE1ONYpEnIQ5mWzw3rBfsKjVDQUPzw2qfJ5MhMye8EDQWOROhme
         8nyQ==
X-Gm-Message-State: AOJu0YzZwapOumeaj5z0DBxj+rXY7+qQSsm50nbM7dMEoQxbL28yUnHv
	2xbFASVolzRYqbmBwH4O1+4xUu6CyWErXXw09j1gvxKLBaq/7Acu8bcR4QdiRB702j4=
X-Gm-Gg: AR+sD11L3bv6ySBJ1Be1FtEF81B5SjKGuQqqQmC3hUZy5Y548BHh0Dt+UsELvMes8Ze
	KN/v7Y1xepe8BrR6y3BJM5CqmDHha9sHvVV1cX4hMYy4MngYWXN5TMSOZc9NCRwkXEulsVIRrNM
	loUxcPjLKK1pzFX+VwVHGVZ0lFnhbmSJHVDpoQbYF7sdmaGsUhv//lZlyzOmmRe1cHHNbaX21Pk
	Yar3seX9dfwixfB6AQZEVg/HV7Snf1+3BHZhWmHud+cMIyp03Go7VvLdzb92/tYvUVHKZkP28Tm
	qYfd7qIeILA1Fuziw3uly1V4WVl2eZGTzbjzpd7wqBU1eb1P60PH0Ht3AcAL+EMlpl4YYdO4Hjq
	Dabs9O99JDyaIGxfMpQMTFOJb72BloneFayg5mtGO3xx4uVqqKmA8MvuAAdPKpH1qLc/tp996Wc
	pKAvvPZ5cs6c2lMf4hpQZDIm/J1lPELQ2CxEqlSfKVZFQOgr6VuxUZRyyxzA==
X-Received: by 2002:a05:620a:4693:b0:92e:e2fc:26d3 with SMTP id af79cd13be357-9330272f6b0mr424722385a.46.1785269783417;
        Tue, 28 Jul 2026 13:16:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd8b776sm6992946d6.43.2026.07.28.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:16:23 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:16:17 -0400
From: Gregory Price <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: damon@lists.linux.dev
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Message-ID: <amkMVeEWBn5iLIdu@gourry-fedora-PF4VCD3F>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-2-gourry@gourry.net>
 <20260728195705.53F851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728195705.53F851F000E9@smtp.kernel.org>

On Tue, Jul 28, 2026 at 07:57:04PM +0000, sashiko-bot@kernel.org wrote:
> --- Patch [1]: [PATCH 1/4] mm/damon: defensively skip zone device folios in damon_get_folio() ---
> commit 8181b2e77c1b49bcb808528f343f72fdbf9d168c
> Author: Gregory Price <gourry@gourry.net>
> 
> mm/damon: defensively skip zone device folios in damon_get_folio()
> 
> All DAMON physical- and virtual-address operations obtain their folios
> through damon_get_folio(). That helper already excludes ZONE_DEVICE
> memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> this is inconsistent with other callers in mm/ which test explicitly.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 0981a5e3af172..0db1383de5d01 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -32,7 +32,8 @@ struct folio *damon_get_folio(unsigned long pfn)
> >  	folio = page_folio(page);
> >  	if (!folio_try_get(folio))
> >  		return NULL;
> > -	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
> > +	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio) ||
> > +	    folio_is_zone_device(folio)) {
> 
> [Severity: Medium]
> Since ZONE_DEVICE folios do not have the LRU flag set, won't the
> !folio_test_lru(folio) check always evaluate to true for them?
> 
> Additionally, earlier in damon_get_folio(), pfn_to_online_page(pfn) is
> called, which strictly returns NULL for ZONE_DEVICE memory. Doesn't this
> mean ZONE_DEVICE memory will never reach this new folio_is_zone_device()
> check at all, making it dead code?
> 

pfn_to_online_page() says this:

    /* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
    if (pgmap)
        return NULL;

Which is the kind of implementation detail that could easily come around
to bite us. I'm ok dropping this patch if folks think it's too paranoid.

~Gregory
