Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F752F8B
	for <damon@lists.linux.dev>; Tue, 31 Mar 2026 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970013; cv=none; b=H8sDthRxSznncTQSDFxjmdkrbbwd1FdyqqV8mbi1MHu0VFTb3jcxr0Z0cpmArbU7pw1uEEVyhYm/aTGKsPjgELTClSVcTiKNQQZixRxF05/GiR9O7ynjCWY4eri1Brbwhm596ZwyKtbqe6RKZvYuDx2EnOifBdZ0BndC/4Tklow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970013; c=relaxed/simple;
	bh=b50hZQuKZ+AjZNcD6W3pTN6zVKAcP5lnRPKXgpX8nrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hahGp91Ic2eO4hhNRFeMRQAk9gnzWLreCzR1ZAQpQtJ1903Mh2Zbe8UlsvvPOEF3L39O58no+DfJ2vl3YeBj0GJqnARXeaH9N7dkDiP9moVWiqqeNtxZtr9Zh6EDg4iyhLOZrj+UoN+e5G//6mmYFmPrVupAlTO8DBBL8y0QoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpzduE6C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpzduE6C"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82c2239140aso2354574b3a.0
        for <damon@lists.linux.dev>; Tue, 31 Mar 2026 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970012; x=1775574812; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftSpwco99w6JKZqWu12nQUgnLtfWtJC0vDyWjGnwlNs=;
        b=FpzduE6CtpJF6Y5vNKzZv8g40SMjJ/1iQ1CyqAnqgIS+Uww/hs34/zYixWhYf4A6mW
         iqrj/hSP+Ql0rJGcjMZkIxhmkS7I1V7sufVyO96sJow07K5jMpRZQpuOPWcU3F6yZgow
         AwoiTVXbOC5sDR364VB474AYyzWbublK0MXn/54gMwtPoLu31o1ae3AjYRQ+hgVgnqOX
         YRApCgU94dEhQhFpeHe8g9LXybbJYYwJcvLedAvSLwJ5JmeVPgccMa1wbXrnC1rKB+wW
         sjWPKltLYmXJOeQCdGpWjvHKB/X0A/I8qCElFVNUw4CWFKA+taPOWCUCZD1J6eyuMW88
         uKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970012; x=1775574812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftSpwco99w6JKZqWu12nQUgnLtfWtJC0vDyWjGnwlNs=;
        b=ZYBkBxb0ze1UqkUYkPYERJ2kAict0+z4Gpz9G9rU3O5a1Y3uiJIfZFRUiX2UQDQWJT
         1JMiCQCx6MOz2LFA8jEBdm6vfba3UZN9pqXL2hKs31Za31zPNUobWWbwNikQjCRSE1mZ
         XH394hQ/Rc/BTAQD3GpJLWZDThBbK1kjkfBM2spv4zBCLLA6WX5F3DKMP8ZHbHVBwPXt
         512s0kjeAb0zUwV1BPRwRztKeGgmdIyTO9GL7iXc/8TgCyhlRwnNR0SQasWcN6ukw/NU
         i8isWT0OpUliCI7FwRfSFtr7o/NlL19oQfoXzXVMYi2G+QsoCSpaVOFdmEBgexNNl6oT
         14Rw==
X-Gm-Message-State: AOJu0YxIoBT6in1vYiJ6PjYJZycDBxMj7SHnuHyCt/TiUebcH3YrwSVT
	HzaEthuqFIvzMjRh27O7GH67jMofVxLP5n6OrIRoUTO0DcIfUc2Uf9zbnmbKqw==
X-Gm-Gg: ATEYQzzvH2+SAUlBe7B58epzQWbfcNLkFYivVJXLEAsHYT6GlGQOmSCw96soI5a1PaR
	bde0Ne+hjewwQA09Y3D77Ub4LOzsNyaksO5dME24vZUX9Sw5QYDq0PTmERv7OxKXxkcl65WXUi9
	MQq/P0KN3UZMM1iPqNaUS/YMP4PjrfVg4KOdi4XcUD6e2+5HH2zNFA3FOpU+v89Li5osgEsCmpb
	Ybjwjhu+9MthNQbIRiIRSFtFYpAdIktOSpVpYwHgaGTw3vJ2/61Of6PxzW+KLheZt7auJnw+uSo
	DDSkDX6+0z6+3AhjERMCv1AxEjOQPx7igW0WD/BZJCqR/JP5ws7FiJxpr5kFaEIo0kQ9/AMLucC
	p58U6Co3auyqziwL0gt0sOTOm/dKb7HYhwfOCCHbBk+Z2n/sNoNqZCVzYn9Igp/edNaScG9bfqT
	qCZEffcXledVbd8vYBD38Itlsfq++S1eVa/qm+CwSHOkqLNCz3Gio=
X-Received: by 2002:a05:6a00:1912:b0:7fb:f87d:a0aa with SMTP id d2e1a72fcca58-82c960a60demr15637739b3a.52.1774970011465;
        Tue, 31 Mar 2026 08:13:31 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cc025659dsm6054481b3a.51.2026.03.31.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:13:30 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon: validate min_region_size to be power of 2
Date: Tue, 31 Mar 2026 23:13:30 +0800
Message-ID: <20260331151330.6972-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331150009.5014-1-aethernet65535@gmail.com>
References: <20260331150009.5014-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > [...]
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d72976..205592194efd 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -294,6 +294,9 @@ static int damon_lru_sort_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > +	if (!is_power_of_2(param_ctx->min_region_sz))
> > +		return -EINVAL;
> > +
> 
> Does this code leak the allocated param_ctx?
> 
> Looking earlier in damon_lru_sort_apply_parameters(), param_ctx is allocated
> via damon_modules_new_paddr_ctx_target(). The existing error paths below
> this check use a goto out; to ensure damon_destroy_ctx(param_ctx) is called.
> 
> By returning directly here, does it skip freeing param_ctx?
> 

You are absolutely right. I missed the cleanup path here.

I should have used 'err = -EINVAL; goto out;' to ensure 'param_ctx' is
properly freed, similar to the existing error handling below.

> >  	if (!damon_lru_sort_mon_attrs.sample_interval) {
> >  		err = -EINVAL;
> >  		goto out;
> 
> [ ... ]
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da14778658..6e29d92670c4 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -204,6 +204,9 @@ static int damon_reclaim_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > +	if (!is_power_of_2(param_ctx->min_region_sz))
> > +		return -EINVAL;
> > +
> 
> Can this result in a similar leak in the reclaim path?
> 
> Like the previous file, param_ctx is allocated earlier in this function
> and there is an out label that handles cleaning up the context. Could this
> be changed to set err = -EINVAL; and goto out; instead of returning directly?

I will fix this in the next version. Thank you for the catch!

> 
> >  	if (!damon_reclaim_mon_attrs.aggr_interval) {
> >  		err = -EINVAL;
> >  		goto out;
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260331073231.30060-1-aethernet65535@gmail.com
> #
> # hkml [1] generated a draft of this mail.  It can be regenerated
> # using below command:
> #
> #     hkml patch sashiko_dev --for_forwarding \
> #             20260331073231.30060-1-aethernet65535@gmail.com
> #
> # [1] https://github.com/sjp38/hackermail

Best regards,
Rui Yan
