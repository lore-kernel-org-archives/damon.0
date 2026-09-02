Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360642DA3F
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342688; cv=none; b=NSgzqrBBe+POMuf0BYYvms4OyCkjJ3j6U0tErrrcZiyMTnyVH24tQ6DIyBMuLtrpozPhTtPtBgx5uIz4Burts3cznlTXZaRiaUSHm/q9PVpzHMugddhDKo+RHIK+vHsvxUjUnhH+IVKwxc76TgvKU0WDpIy7ogab5wvE+gF9KJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342688; c=relaxed/simple;
	bh=kpoO4XC5ZjwGe2R23ONKEYBPpJR/+J5srvdUMCfvzs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9wlJe8Jqle94ZNdTl9yB8XsjK0E61MeXJgpZjfAn4Iihr6hLfjle9rQzttIWhKz3WFXEemTGBl59+g03hF+8NLwhG55tu9dQhfp5U8MWjEcjrzF2wUfO38WajfeUrc9++Qf9ky5hq+ZgCcQINpa9UdbGGW2E3q1+8IaSUxv3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXQLKWKG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXQLKWKG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf452def93so19558745ad.1
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342686; x=1788947486; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bUGd7SiZwszuY692VXLvSRgKuWVCf+DwlqdyCfU6+00=;
        b=cXQLKWKGrriBQq0CtoqluRghB25BnsXZDBgSeakZvE0lDuSj34b9T3AhSqvV6K9oeP
         9aderPPcPIJa9u7dKlrJnU7NQhX/2OXCzhkreAVdiQU6uGF6I6Igj5ZU5E7o+3lpwRLT
         UzrerjXvRh95ftkC5bQ1oAqPnX20cKyZ7fs7hnVCM3d+DzN4gjjy/L5P6ceEyU/z117e
         46X6F+mEFSm92ZFgJtngCOj3v6Xky2tqpxaALBf2oa1DxXmB+k5NSMW0T5ZtZsvaPiEa
         3lVm6fvoL5AudnMpon4NWZm8Ls5V6+HHvisrzQ3ODuWDmgMdnv+zLhw+uJUv8vPrkJ/T
         IPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342686; x=1788947486;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUGd7SiZwszuY692VXLvSRgKuWVCf+DwlqdyCfU6+00=;
        b=owjmFxmojNdRhEwoxSTm5UKExtIGe9wbksDM1AOhaVNddSH73aufPN7q6ooh9AO+tS
         GOAiXuX12gN3lKAD1YdDzzLu7gPWlqdXFvZSpOPZh11/6FwTwrH9nnJp/2UN/Je9qzVI
         M9WwqJOJEkQWq1ZMIK8p2sCYy8szoGhcRdmV0O2kdqw2SyNGhFt3SdOpr7J/zMu8t+gG
         MSQB+zN2azqh2hh0Oi3q1u74NujQvxAweuHPIOM0tBD34s+pPmxUYe63PWlpFxE1tR4L
         R0yuIVx4ZcjjYeQSDzDPvnG4FewwJUfEyKfYzcZlsolzIXymDt4oZlkiTZ03/4aKbiuV
         b3Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwaNBT/RhUIfbfrKQeghtb8NHWJoCvs71CST9ALNsWDSWnOe3r3lbGbsroezadCw/GJy2lxYw==@lists.linux.dev
X-Gm-Message-State: AFuF++lSZMZlcn+Q0ZRyaFWFAdMurKTdL3D76YCUya/P+lfI/oqWN7+0
	cwz+y2xRjQlg7a1d8/NYMUizk/N1xEVAtrfQkxZZtz1tPZEMNrY4tW3t
X-Gm-Gg: AYBFou3vo6aVxTEA65p909PFaRZ5bqzo+2JRZfu2/YEKwLWZl5cKmYvX/Uv8Ipx18fg
	ggZzNsmApsqLHDJQfJKHeMye8nK1SR5++kHKyKHBJcA8NM4YCrFoTLGX7SGG1tGhdaZFjkPd8fd
	qpuhFP5LZhaFtB+ikXW/RjWiXaWdD17nl54NOyJXxxe7ADFMEQIj1CZGGDypIAF5ZPX9mMSTH1x
	T0mOfkXdYEH/RxA4prff/C/VE8j4JumVePWFqW4VgSSn3zWqiZsgOGm1SpQ681EYvjt8tpCjYrC
	zeRDdMQRAOglPXAvCrBj5kuqdaiCq0xwmARquN72b8TRdzytUWB06mScW0M8dDgOp0BT/twLiEk
	2ww4Y70Dy+SUmYAcDzsvXDqZp2G1FioLrQpUrH4I0NXSYqXl7huEko3WzDEb/jtbLPmVYsiGP7j
	1OAO5I31i5jItJcl59ali23sBlYayTsxW+0k5fEL44mXrJ/vEhbNuyHPpb/398dKuojshfMcjd+
	EF13xNoFggUSMmh
X-Received: by 2002:a17:90b:52cf:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-39af57d22cemr1180978a91.1.1788342686482;
        Wed, 02 Sep 2026 02:51:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd21e9dsm11092711a91.4.2026.09.02.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:51:26 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/core: allow esz to be set to zero
Date: Wed,  2 Sep 2026 17:51:30 +0800
Message-ID: <20260902095136.282835-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902083047.6D4081F000E9@smtp.kernel.org>
References: <20260902083047.6D4081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 08:30:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch breaks purely time-based quotas by unconditionally zeroing the effective size quota (`esz`) for DAMOS schemes without goals.
> --
> 
> commit 34629844ff11daf28855cce5457468ad8bc08c73
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: allow esz to be set to zero
> 
> This commit updates damos_set_effective_quota() to allow the effective quota
> to be set to zero when the temporal quota goal tuner achieves its goal.
> Previously, the quota was clamped to min_region_sz, preventing it from
> reaching zero.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index df22621765911..73dc9a70fb12b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3251,6 +3251,9 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
> >  	if (quota->sz && quota->sz < esz)
> >  		esz = quota->sz;
> >  
> > +	if (!quota->esz_bp)
> > +		esz = 0;
> > +
> 
> [Severity: High]
> Could this cause a regression for schemes that use purely time-based quotas?
> 
> If a scheme is configured with a time-based quota (quota->ms > 0) but has no
> quota goals (list_empty(&quota->goals)), quota->esz_bp remains at its default
> initialization value of 0.
> 
> While damos_set_effective_quota() correctly computes esz from the throughput
> and quota->ms, this unconditional check will then force esz to 0 because
> quota->esz_bp is 0. An esz of 0 causes damos_quota_is_full() to always return
> true, effectively breaking schemes relying only on time-based quotas.

Yes, thank you for pointing this out!

esz_bp is a meaningful field only when (!list_empty(&quota->goals)), so
the correct check should be:

'''
if (!list_empty(&quota->goals) && !quota->esz_bp)
    esz = 0;
'''

> 
> >  	quota->esz = esz;
> >  }
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260902082050.19566-1-aethernet65535@gmail.com?part=1

Best regards,
Rui Yan
