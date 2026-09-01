Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB731C567
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268571; cv=none; b=Ypr42NLwET2ZNsgpK1bOSVcwWrkL4gy1ERn2ieMSzl34MjaFINErRE7Vo69gIRioPMCMo5X0TJeqksJ3KLNImfqYYhpBr8its7k7BPLMBUbZVDMvRf9qt5N3eKB9Kw60Q489P3FOMLzV+DtmX9GlAZO7dyJmnZInXdlxYLEOB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268571; c=relaxed/simple;
	bh=mEjn5pPSM/W2HEBBhXpBLyjKABAKiVFnCfKziJ+ZvCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFnQEo/eWSvl+cGtgGtujj3dYjyrYyvnfpw2/SW9tcBe+ZNVYx3N55UWJmbXdL61lkTmyobyyNDm3F2nv7NQRM7HwF5p60BCHMaApQ/dB1HLUWGKAutYF+aZIrN0CE0ur1lZSHhJ9FLpzu3f1CuT4MxySTOU9OdRMQ7xu/9N5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlofAQV0; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlofAQV0"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso2011215e0c.1
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788268568; x=1788873368; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CCIWMNHkezbHEse9cF0jmSTUVDzXod2VLsShBrj5brc=;
        b=MlofAQV0cCROx13GrBtCqHNM+2xK2RElapA4JCU7/oa0kRA0N9Qt8kHgdXSeggoOPy
         QmedvgD3UgWWRhqi8p81GgjsGPZV+LJkSRW3SdN4qFOcM9M+FACwle4tOlgV6EJTienP
         fqZzkp0M6f3E1Gf2A6CgMHN0niR+CNjCk6wiyxvJqvle0++RmafsmUmrllpyPskBtezJ
         +edhAoHKfOSyL8KLJITK/LxzLt7AOVEkzxcZMWjcVZJSbYD4Scb4lVQLnPrRsRkyFUCs
         n5NP4ckhrjgRUa70uHwDtUanH0pTM6oLXTWe7jvqj9pRHtis1G6lFo4LHjR/kxcD7tJy
         S/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268568; x=1788873368;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCIWMNHkezbHEse9cF0jmSTUVDzXod2VLsShBrj5brc=;
        b=E4h8R6jKvv2OBsKtgk2e10Apa4s0BVHKyby7a6+WL+QN77jfSrdSVblmMBewQKpemT
         QCJUwCN7sBHjzUuGYJX5v5TOrU4kBCLdIJcM+IhCgt2Z3NxcQ7kJfhd78rApO8/OKjkl
         kO1zVRi2rBrmjwfdPJE9EKY5WLF0NdGLd9ubakOxFaAoNiXimSJLXdd9qMuvgJegUrLI
         37cqOrxalabmf55bqu/3YYonFb4CqkfZve3KrWclfzD6bJSY451ld61kEYN+l5tpBb34
         cVPNlqo+cyLHtUQ9BU518l56vmZZMPijEX5IFzFWovyHkTAOTc30fuzz1v+tBRnyOcwE
         ub+w==
X-Forwarded-Encrypted: i=1; AHgh+RqMzl8hJ3UZuFJK9l9OJZSDmHR6L9tdEoC9vIMAjvsMzWL+AyIRmsICltC/x3EP2PTMD8B6dQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mJh7y10/J3xJm8yqlMC1ckjAD3mWys7rC70o0V8T334ISB02wd
	6zP3VDOQKyH68odGLMdEigOJctdtB3zn1/V8QeWmADRp1Pk8k/Jm7NjokUdz+g==
X-Gm-Gg: AR+sD134ap+6W4swkGFFP6/4/pjCnygmS+2zTJnEPyZn2jQTlIotYDVL9HVAuIFq4kL
	tt/oywrvhVV034/8nyFUDN10sXoHcpxX2RWP74XFqCmPz9RuGa/6Oa6+H+TyHAZIwhHa+dNqGsx
	VzksYhGGyTYCcwqoW5Dug6e+OGSo/1HcthJyf38tsv6NBUYh6Zs881PgspRMwMsPvm24y/2fQp+
	PmuYsRT7wUiWqnZ5Sac3gxF0tSbxjhNA+F1qGY3SEiZInwDp0nhHCqksA5X3rSn9CTJFD4FLnz8
	+Vetw4ef08CrXDUsc4xw2bIc/8ZcSKe+u2RqtKS/MA31kkhpr6o3EHIwSUMiXXG3825KOWIRZco
	69oFpVG003YnGXYFw+nA58zDsHyuW9RNbuWplz+tuKy5ho2pz7zG1rD2bxDliu52pxrSjOt9Cuw
	A3KDWJSIj6YBJxATa14vC37pbQDbkOFoDkQXmOORDCGL/AWotUQrHbM/U0GoWKVxTTV+umJAQ+K
	jYLUIioHaPmom8XKWm0uFgJXVs=
X-Received: by 2002:a05:6122:512:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5c7bdfc2829mr3065498e0c.4.1788268568128;
        Tue, 01 Sep 2026 06:16:08 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7242ab36fsm10637674e0c.17.2026.09.01.06.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:16:07 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org,
	sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: always return false when esz is zero
Date: Tue,  1 Sep 2026 21:15:35 +0800
Message-ID: <20260901131614.13079-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901111247.907BA1F000E9@smtp.kernel.org>
References: <20260901111247.907BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 11:12:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch breaks the O(1) early bailout for schemes with a zero quota, causing O(N) evaluation of all regions, significant CPU overhead, and corruption of the 'nr_tried' statistic.
> --
> 
> commit dd8f74f4c9d96719d46a1466acabcc4d814aadc9
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: always return false when esz is zero
> 
> This patch modifies damos_quota_is_full() to return false when the effective
> quota size (esz) is zero. This prevents qt_exceeds from increasing
> unexpectedly when a temporal goal tuner achieves its target and sets the
> quota to zero.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3f89cfdf5f022..012e8970f154f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2551,6 +2551,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
> >  {
> >  	if (!damos_quota_is_set(quota))
> >  		return false;
> > +	if (!quota->esz)
> > +		return false;
> 
> [Severity: Medium]
> When a scheme's goal tuner achieves its target and sets the quota to zero,
> does returning false here unintentionally break the early bailout in
> damon_do_apply_schemes()?
> 
> When this function returned true, damon_do_apply_schemes() used it to skip
> the scheme entirely:
> 
> mm/damon/core.c:damon_do_apply_schemes() {
>     ...
> 		/* Check the quota */
> 		if (damos_quota_is_full(quota, c->min_region_sz))
> 			continue;
>     ...
> }
> 
> If it now returns false when esz is 0, doesn't that cause the loop to
> evaluate every region via damos_valid_target() and damos_apply_scheme()
> instead of skipping the scheme?
> 
> If the scheme is not skipped, it appears damos_apply_scheme() will calculate
> a zero sz and jump to update_stat:
> 
> mm/damon/core.c:damos_apply_scheme() {
>     ...
> 		if (damos_quota_is_set(quota) &&
> 				quota->charged_sz + sz > quota->esz) {
> 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
> 					c->min_region_sz);
> 			if (!sz)
> 				goto update_stat;
>     ...
> update_stat:
> 	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
> }
> 
> Will this cause s->stat.nr_tried to be incorrectly incremented in
> damos_update_stat() for every bypassed region?

Thank you for pointing this out!

This can fixed by adding a check before damos_quota_is_set().

'''
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..795f802657ff 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2560,6 +2560,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
 {
        if (!damos_quota_is_set(quota))
                return false;
+       if (!quota->charged_sz)
+               return false;
        if (quota->charged_sz >= quota->esz)
                return true;
        /*
@@ -2654,6 +2656,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
                if (!s->wmarks.activated)
                        continue;
 
+               if (!quota->esz)
+                       continue;
+
                /* Check the quota */
                if (damos_quota_is_full(quota, c->min_region_sz))
                        continue;
'''

Note that this also changes the implementation of this patch, because
quota->esz is an upper-bound, while quota->charged_sz represents the
actual quota usage.

> 
> >  	if (quota->charged_sz >= quota->esz)
> >  		return true;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901105925.106186-1-aethernet65535@gmail.com?part=1

Best regards,
Rui Yan
