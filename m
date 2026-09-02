Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA000423EB7
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342149; cv=none; b=NvKjOLrz9XPnGGYUQZBSo2ugYDlBaJ2HLahjGu7iaLGg4lItHC1jKIWVRpYoa/aEU1fNr7yhRTN7q39zN8Ke69pr/teihuUko6qKKc+yeOpiov9ncLG7wTUgdtVA/i4qLqaCsBZaVC3RgEG1yZVybmiLgkEkBqrA539S4CnL/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342149; c=relaxed/simple;
	bh=KI7eAEKAT87nrCWtHPF9is+nY+LslPUsAJlU/0s5X14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxnXckkeEqQ9ticaTkPGWT0IhUXn9gIjigTeGPxi6+yAx9Unr7kvDsUxZprPCernenU+SbGa3opEC6y1Ry1T6uSAT1Osbe56N62GXh+f8KETJsIDnWXfrFYJk74qGcXGpQg8voaksu7jwMigYGf81+27DtpPWKjIGqMVETIpZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuFSwBVo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuFSwBVo"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-855d2bfae95so2254721b3a.1
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342147; x=1788946947; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DcRVqHOX6F6y9n25N9YDOVb5e1bHL9NhWkPrHNT6REg=;
        b=CuFSwBVox0gE3W8VbRhFMV1RQgkZC2L1tzI0Khdmyfq2ucGnZMQyCvJ/s+dvSRfJpg
         k6oWZF2N/y3uNuCJtCwFSsRcMpU3pDlVZRXeRi0W1gVywlebBoz+nAlePDwkQ+iO0AYA
         2lKr59WNnb2CYhB+Fc/QdXxFUL1HbY9uPB3engXdKNoQyHT17f5IfHhU5o5va3Soe6Sc
         N5DXRM7q8zbcfR1NBKX+Yp6XFucitLF7e1iSaDlHqUeRXFOp7Chrd4W2pQ2JhZvgxvWl
         g/XmuRQP61c90g53rg/AOZ/gJcwo8IudRbn/23frlizjtrhyLsxR1Y76RN5cVIlEfx5l
         VS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342147; x=1788946947;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcRVqHOX6F6y9n25N9YDOVb5e1bHL9NhWkPrHNT6REg=;
        b=EQ8FcSniXxfYaXYwYz0wgmNuz3i9wfSsep/awcrCMX0IpqH/JwON3MoqIp5+ckgQND
         zNfTfHyv5EMwCjonWVETnK+4EqIHcBJ2IiTlbe9WDiB60id3iNIhQPbOh1Y+uJqHEzln
         AtkyQ94WhKc6rIxwCwDh6A1fpoKzS1rCtq0wjZ/RyxLepE0/rTLT5KvPiWtuyUp7t8NT
         YtgLNJiYy2hU4bhryVZgetmj71QJwDtSVIya2oWI7rMVg665MaeBEn4b2su46q03UIx5
         cpcAu2k0vWYybCIbNo8l5Iusul3I0VCegugKv1BndTX87R7NWlAcnk3Vidyx7VNaF+6t
         selA==
X-Forwarded-Encrypted: i=1; AKwUvBxjOMrPONHbcdRRZJAQJQubgP9AalE6idptoA7/+TBDs2zTvJuJ7RVYo0Vw0iMqS6OdU34ZiA==@lists.linux.dev
X-Gm-Message-State: AFuF++lrsDpe5FjAuUXcmArpsA5Z56hoy4V9TIAov+MuBnqlgpAWtOsD
	vDj4zOeMcvQJo1SfZwVdbvUNqYnG6zOkqFpDPwltzMyT1qJiyU/FQa0k
X-Gm-Gg: AYBFou1alQsofCDFCuJynhdL1QvMfFIUV6EpoN+kTVAFiq9MaeilmlL2HU14DPZAang
	7lyIy8/JHwJYy6VhD7tBiH1Il+uc7OElKLfObzI/928kngi3MuCawPZFGB3W657mDROJYpln/We
	I98slDtwQ36c9Hlg/viknb6sTQBiz5V0NZ1nZbXNvjji4CbBewjBG/62XC/1I55yVG9L3sUwVmb
	z0tFUpnsbZOI7l6fkp3YxQO890sMyVaEtzz5ZptxqwyUODIFvco2y8qpUVektOtWpIhqat+WT1z
	sU60gAj+P1YzwlL3v9lkpAtaaP7v4KHtMzJM/9tG05xctm4fytNRU9O6PUYcR3dT4X4cYvYOZst
	3bFjz1DEJpaCc8uXMzk2f350Mb4AOtlX0sC+bFJFZ4rFjzZT3DNlCHXOhK3uXBj+SyTHbN2OUC3
	ebsFmvETd8N7M8YWgdDkzZY3nuleUtzC47shIAlnZRiEeUsHcCyvWMeq5mSr4Px6dC7Ib1+emdf
	4c9nUWdWUVADxNAvw==
X-Received: by 2002:a17:90b:2f43:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-39af64e2f29mr1362561a91.10.1788342146822;
        Wed, 02 Sep 2026 02:42:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d4637a3sm10573887a91.5.2026.09.02.02.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:42:26 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 17:42:34 +0800
Message-ID: <20260902094236.281347-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902085336.6F0B91F000E9@smtp.kernel.org>
References: <20260902085336.6F0B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is no fundamental difference between the Sashiko report in the v2
thread [1] and the Sashiko report in this thread, so I did not foward it.

On Wed, 02 Sep 2026 08:53:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Schemes without configured quota limits (unlimited quotas) are completely skipped and never applied due to the new `!quota->esz` early exit check.
> - [Medium] Incorrect quota evaluation for very small quotas (`0 < esz < min_region_sz`) breaks the early short-circuit optimization, causing wasted CPU cycles, artificially inflated statistics, and broken telemetry.
> --
> 
> commit 4718f859e447852ff19b6830ab8bf79106ad37d1
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> Subject: mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
> 
> This patch aims to fix an issue where damos_quota_is_full() returns true when
> quota->esz_bp drops to zero, even if no regions have been tried. It attempts
> to resolve this by adding early checks for zero quota->charged_sz and
> zero quota->esz.
> 
> Cc: <stable@vger.kernel.org> # v7.2.x
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index df22621765911..f8c784df24600 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2655,6 +2655,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
> >  {
> >  	if (!damos_quota_is_set(quota))
> >  		return false;
> > +	if (!quota->charged_sz)
> > +		return false;
> 
> [Severity: Medium]
> Could this cause an evaluation loop that degrades performance when the
> configured quota is very small?
> 
> If a quota is configured such that 0 < quota->esz < min_region_sz,
> quota->charged_sz starts at 0 at the beginning of the quota window.
> This new check will return false, bypassing the subsequent small remaining
> quota check:
> 
>     return quota->esz - quota->charged_sz < min_region_sz;
> 
> This falsely signals available quota. Later, when damon_do_apply_schemes()
> calls damos_apply_scheme(), the size is calculated as:
> 
>     sz = ALIGN_DOWN(quota->esz - quota->charged_sz, c->min_region_sz);
> 
> Because esz < min_region_sz and charged_sz is 0, sz evaluates to 0. The code
> then jumps to update_stat, which increments nr_tried but does not increase
> charged_sz.
> 
> Since charged_sz remains 0, the next region will also evaluate to 0 and skip
> charging. Won't this loop wastefully over every region in an O(N) fashion,
> artificially inflating the nr_tried statistics and breaking the qt_exceeds
> telemetry?

Thank you for pointing this out!

So the issue is that if 0 < esz < min_region_sz, then
damos_apply_scheme() might incorrectly increment nr_tried.

I believe the solution should be to ensure that esz is never less than
min_region_sz if esz is not zero.  However, this may cause unexpected
behavior when users set quota_sz, so additional documentation may be
needed.

That said, this is already out of scope.

> 
> >  	if (quota->charged_sz >= quota->esz)
> >  		return true;
> >  	/*
> > @@ -2750,6 +2752,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  		if (!s->wmarks.activated)
> >  			continue;
> >  
> > +		if (!quota->esz)
> > +			continue;
> > +
> 
> [Severity: High]
> Does this unconditional check completely skip schemes that do not have quota
> limits configured?
> 
> For unlimited schemes (schemes without configured quotas), damos_adjust_quota()
> returns early without calculating esz, leaving quota->esz initialized to 0.
> With this check, won't unlimited schemes silently fail to apply entirely
> because the loop unconditionally continues?

Yes, thank you for pointing this out!

So, this check should be
'if (damos_quota_is_set(quota) && !quota->esz)'.

> 
> >  		/* Check the quota */
> >  		if (damos_quota_is_full(quota, c->min_region_sz))
> >  			continue;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902084445.27170-1-aethernet65535@gmail.com?part=1
> 

[1] https://lore.kernel.org/damon/20260902082931.4536F1F000E9@smtp.kernel.org

Best regards,
Rui Yan
