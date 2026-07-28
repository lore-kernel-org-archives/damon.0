Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E8306744
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217159; cv=none; b=t/oRV91EWm8vNhp+hzFaE67mGhe/c0CDygFqTg9AHosBySu6DhRIPoDMkKJLWFTZo3SYUSUdDLB29jK+dVn2cpMKrY7OC5p3sll3hpCXidmuX7wVEzWdyi8KfuhTCyOgkiXrfDiSmivaF3DKah+flai16Q2r9JZ4Pa3TTxf02bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217159; c=relaxed/simple;
	bh=xopjflmkgHij5ijq8VuCXp9bpK62Xo45OFooi+v8oBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4RHtV9nMfULycb20ghNFJ20z0gRci/XWxG0CEy8SxaQ/hd7SLDCDwWaoKyiBIKfSlmZf+P/3xDtv+3XzI3GyruP2IXINT4zam7D5zrQTho22YOW4zCVtqUTE/GQjpRXwXEfou0OtkKwqmDY86vwxsqDPmsVPE1fzYa2iWN6eFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdhACAnZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdhACAnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98AB1F000E9;
	Tue, 28 Jul 2026 05:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785217157;
	bh=izawyRtougwcU+UVtjcMNV5/vHPy1fTiauVafJHxoqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdhACAnZwFUtbJrixLsQFbnCvugZNzdpTWfKKWXxD/bfmPYkWOXNuNZZqLw2lmBbv
	 0qsXbjWQpN44Ek4rDdAS5gjsnVMgkzck3MOpVLKbsbDyLXhlkDTEN7iqRkrO8Slk1m
	 GO+QrF4MKpkf5xsCUekbR1vDIRcLfQPI3Au8bY7JKBIqs99d/913IOZ25AGVi96MUO
	 CGu1ZDL2hFaABIqkdi4AhNN1wyhZ54/jiSzWAlY8I+TCy/Fp2brDNgZeycfBqZYU+L
	 PG+Zc0w+z92joEKjnyGK5iV68mnjjCfOXk0talZ8EUftehCHmCxmaVIfcZUa162lUm
	 tQyqavfVKGp+Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 03/10] mm/damon/vaddr: remove a debug message
Date: Mon, 27 Jul 2026 22:39:08 -0700
Message-ID: <20260728053909.196568-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728053243.B66471F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 05:32:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The 'ctx' parameter in '__damon_va_init_regions()' is now completely unused and should be removed.
> --
> 
> --- Patch [3]: [RFC PATCH 03/10] mm/damon/vaddr: remove a debug message ---
> commit 6f7aa725872ec3ac7c5da1213c336d706d99ebb1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/vaddr: remove a debug message
> 
> This commit removes an old debug message in the DAMON virtual address
> space operation set that hasn't been used meaningfully for the last
> few years.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 4976775fe2762..5ccf70dc8a30b 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -192,19 +192,10 @@ static int damon_va_three_regions(struct damon_target *t,
> >  static void __damon_va_init_regions(struct damon_ctx *ctx,
> >  				     struct damon_target *t)
> 
> [Severity: Low]
> Since the removal of the debug message also removes the only usage of ctx
> in __damon_va_init_regions(), should we also remove the ctx parameter from
> this static function's signature and update its caller to avoid unused
> parameter warnings?

Good suggestion, I will do so.

> 
> >  {
> > -	struct damon_target *ti;
> >  	struct damon_addr_range regions[3];
> > -	int tidx = 0;
> >  
> > -	if (damon_va_three_regions(t, regions)) {
> > -		damon_for_each_target(ti, ctx) {
> > -			if (ti == t)
> > -				break;
> > -			tidx++;
> > -		}
> > -		pr_debug("Failed to get three regions of %dth target\n", tidx);
> > +	if (damon_va_three_regions(t, regions))
> >  		return;
> > -	}
> >  
> >  	damon_set_regions(t, regions, 3, DAMON_MIN_REGION_SZ);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728052811.192712-1-sj@kernel.org?part=3


Thanks,
SJ
