Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91E22172E
	for <damon@lists.linux.dev>; Thu, 31 Jul 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999459; cv=none; b=LzHnNlDbYpIIDJonL67nGuS3OGi09xHHhWxjgfjoe2e9SRwdmmfdbcMszwbr54kjtXPHv+NVMVBCdHsuIT1I0uAQ/EVGQa0AIuFLo93Yv9XThn0MoTXC1bKidTXZQA+sen0ConzDT10GhqceIIA3FNvpegKrynXmEBWEiZVOHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999459; c=relaxed/simple;
	bh=T+U1llJWqanj2eP8cHM7nhvCfUiqnhYB4EmMGd2LH1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEJyyHOolVVclbryeHQ9SYdfD/BAIz8y0sO9x3sYEa6XXwK42g+FXAZ7XKCDcD3WKUsy0WTZiH0qydi5CqAtXHv0TxoquU4Cw6wRt++gK3GemgQ+RIcRbC4LpmvAJmRQR9M+UDPj7ySILHzLfQuvelq4PDLWhkAuLE6qqwnkAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErgBfNHh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErgBfNHh"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so169285f8f.1
        for <damon@lists.linux.dev>; Thu, 31 Jul 2025 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999456; x=1754604256; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuVXeYr7FDtql94sM1ldGgDheznzgmdavsiQoAB2NVw=;
        b=ErgBfNHhcA01EtUViG1Y/+f2fwCFK6IZljcr2yImQN2O/qeSZjjAHXyeW76IWkNaTW
         v7U6AoO3mJ1kUuweim0j9vD24qkcdEsKm+BeUoUx3fuGrjx5qOLI8N5V5v5QCatoXmXi
         /M8kkgZJ/Ta1xnFLq8L7qTn6yKqSuUIMAg+XM+u2wIeKzqaA6Wqy1xwRy6RoKBef+FtJ
         ffEJw2crq+QS7Spr5GX8IJw4T3LGCHKxsV85woYd8pxiZtta++tGBAEQML4Q76NVTFP+
         sD+vBbjAT6LAT3U8JGLarAnTZAoriqYqtsELPGgoMlJ80I0/pDYVFeWbPrhevwpM5Qy0
         hAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999456; x=1754604256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuVXeYr7FDtql94sM1ldGgDheznzgmdavsiQoAB2NVw=;
        b=CNt3yFBShDH9s2NZk5wb3cIlMrfmQH5m9KjHST6Fv2qu5bJeV2FF62qHnBEKiJgMPa
         qeHiL4Q5DQDWpDwIm57Hd2sigesN6jy9RsfSlMwy5C2dUS1dd8Dj5XYmCbyNTCw/0aRO
         KSmzBSHl9GzZ1HMLNiokPvC6vBWodX+/0J0RdSaGaj5X3Du5apfmukdBIzOlpjlhEaWp
         CguBoPR1knjxocdeAZgDn1GJ90uQCQba/5rPxiZ8wQ6YJgDB9uiOe5RoMYdtGDj1m8um
         NZBifE7qwRiMiJ7WfHkSEPDNr+oaKSfsTbyFtu+9hbEphxZaLXMiIKOWYCTK8Y0It4O1
         bVhA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSn2R3njYto/+Pg1nBgvWUFFD6rn46flTk4MqCFkb0X3hy/8MHFPq/Y8Lo1G7pY99/tJ94g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjSsPpIgY4k6AYFxVncciuHr2nb8R9JpG3jqh8szEJRFkUmdDC
	Ye4fT9Pkyu4pH7gJy5z8iljWVYFqRuIdk3HAQMBOc4bM1brmJ6EfUOSI
X-Gm-Gg: ASbGnctcUKz/sBokvo44PsNinepj6JcXKIm2mClCeQPrcPZV3qwwwx+o+XFwaMkBnAn
	CO0m441MbWaTWxIF+18r34gEeCCYcH/tDKiLqCo61RXUzd5bY8yg+/+Z8X7oLQUU+TWvAhpC02a
	Zuwq5JqyTr+FppWxRIKrpWmDrdpwKidkJz+GhaEhf5OO2QharSYZisLDEGfe7SM7AShcZaQRBMC
	DCdfMWWfCXb/lenGWJAkfy33uPaGuXsOJUAFJlKKHWndaal9w/xJh7hZtDo/fRccM1zOOD4bDrz
	ZbfeEwAnEOv2NdFe8HzQwOafzKb3j6pveJKGjkkLqCeVirKb/xS0chtYQMj0gZp/tNxCtyfCXEr
	4ngd3RO3SaZBdP/BmXol+DnSAZcrwTZSKKCVFk28vIUDHIbbTGFMF/H4Tf6W1x9xxYVuaTJVFgq
	sza7YdmDo=
X-Google-Smtp-Source: AGHT+IHCw7TRuJh2aGg/Nw+v2xuOt+mi8XWdyGvHc40uQSFW40upZ5IOazoX2RAMaX9h6uizaidJkA==
X-Received: by 2002:a05:6000:1a86:b0:3b7:8ddc:87a1 with SMTP id ffacd0b85a97d-3b794fc187emr6918829f8f.4.1753999455654;
        Thu, 31 Jul 2025 15:04:15 -0700 (PDT)
Received: from Yueyangs-MacBook-Pro.local (vpn-254-003.epfl.ch. [128.179.254.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588dd77cbbsm67628505e9.2.2025.07.31.15.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:04:15 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:04:12 +0100
From: YUEYANG PAN <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: Move has filter to ops-common
Message-ID: <aIvoXMbW57IL9X1o@Yueyangs-MacBook-Pro.local>
References: <06734aa15198e542f9defbc1d29fc0731671c3d8.1753895066.git.pyyjason@gmail.com>
 <20250730174506.60001-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730174506.60001-1-sj@kernel.org>

On Wed, Jul 30, 2025 at 10:45:06AM -0700, SeongJae Park wrote:
> On Wed, 30 Jul 2025 10:19:55 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> 
> > This patch moves damon_pa_scheme_has_filter to ops-common. renaming
> > to damon_scheme_has_filter.
> > Doing so allows us to reuse its logic in the vaddr version
> > of DAMOS_STAT
> > 
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/damon/ops-common.c |  9 +++++++++
> >  mm/damon/ops-common.h |  2 ++
> >  mm/damon/paddr.c      | 11 +----------
> >  3 files changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 99321ff5cb92..3ebfa356ca46 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
> >  
> >  	return nr_migrated;
> >  }
> > +
> > +bool damon_scheme_has_filter(struct damos *s)
> > +{
> > +	struct damos_filter *f;
> > +
> > +	damos_for_each_ops_filter(f, s)
> > +		return true;
> > +	return false;
> > +}
> 
> I should have tell this earlier, sorry.  I now think it would be good to have
> ops-common.c own prefix, since this namee makes me expect the function is on
> DAMON core layer.  Also, I use normal 'grep' and ctags at the best, and maybe
> I'm not the only one that that lazy at learning new tools.
> 
> Following the weird and none-public naming convention we have on DAMON,
> damos_ops_ for DAMOS-related functions and damon_ops_ for monitoring-related
> functions would be the prefix for ops-common.c.
> 
> So, what about renaming this to damos_ops_has_filter() if we have a chance to
> revision this once again?

Thanks. I will fix it in the next version.

> 
> > diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> > index 61ad54aaf256..8d5c5c7631ac 100644
> > --- a/mm/damon/ops-common.h
> > +++ b/mm/damon/ops-common.h
> > @@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >  
> >  bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
> >  unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
> > +
> > +bool damon_scheme_has_filter(struct damos *s);
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 53a55c5114fb..daeceed981a0 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -262,22 +262,13 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> >  	return applied * PAGE_SIZE;
> >  }
> >  
> > -static bool damon_pa_scheme_has_filter(struct damos *s)
> > -{
> > -	struct damos_filter *f;
> > -
> > -	damos_for_each_ops_filter(f, s)
> > -		return true;
> > -	return false;
> > -}
> > -
> >  static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
> >  		unsigned long *sz_filter_passed)
> >  {
> >  	unsigned long addr;
> >  	struct folio *folio;
> >  
> > -	if (!damon_pa_scheme_has_filter(s))
> > +	if (!damon_scheme_has_filter(s))
> >  		return 0;
> >  
> >  	addr = r->ar.start;
> > -- 
> > 2.47.3
> 
> Otherwise, all looks good to me.
> 
> 
> Thanks,
> SJ

Best Wishes
Pan
