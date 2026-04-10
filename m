Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2E28D8DA
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815701; cv=none; b=BmmyCUQW5MZaHo7UE+f/QqyVhHPhQowa9bF4qgLfrx6p2tqnvj/8pMzaKgeLN8yx4y0OeahfC8p7DGnGad8P91Ti6ktXpRKO2bXbTTS1hOGbNA31FKckxW9OSs2GJPatnSxcZhfz9cw9tf7bUsJmTQuHwFif+3CkqOL6NyXCCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815701; c=relaxed/simple;
	bh=LeLjc7Jd0wmDkCYv73k+OSkGArn1kaeBGoqV1oPRKic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdPL3h0ax/SE8vMdPulL8s7MxU6d+/Qk5yE33ZfY0Oj1T49OWVrBhDSFxrUlrmCUTuUae5sKRhAmn3IPrCnC/tP4rmQmT8jjMa9PfQUfHUu8oJdtgmdfD72SWSEqzQKvDK/UPut7AkCuz+bHSDZ7qxvD/qG4td6dZF/8scopLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7FDlaAg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7FDlaAg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso712561b3a.1
        for <damon@lists.linux.dev>; Fri, 10 Apr 2026 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815700; x=1776420500; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex06fw8ZW4mGohg3CG9/QbBROQUogUR/vRM+h93FYi0=;
        b=h7FDlaAgvldxQW5+6Q22pXRqb3g7KiLvfpEI1Z8NxcZJZpZJJwQaHZs4FcciavtKNR
         GNHzj71eo07V8cneF4h+cU0KKTKJ+mAtV+oUTiB8X8bJpXL9t1XIq9gRiySrrpVc7+co
         nfB8zmntPWRTfT3wL5DwNsIUlsdcT7V5cZixpW2UouaS9cDRN4+78GpQfV8WRdzAVnum
         TVKWeWgUXShdGWymBxiOrTGa/J+wY/MTN7rm3PPiE6Co2BCuvDw4xpq7RFZKWrMPld4M
         2ONP42oGjOWhURZ3Ki84QrRQtydbx70RAxjFJFWJsBAAhBn1WCrq/uPfPBO9ubBLM+W8
         XhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815700; x=1776420500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ex06fw8ZW4mGohg3CG9/QbBROQUogUR/vRM+h93FYi0=;
        b=LXCB9IcCFJ7SjhCIpllF2F9VoSEdWMn69dMhNTI2Uekr4KzVvA1PlZdIspRLyUoRam
         MgdAcHDla0xg4kg8J57zTSMGi6v8O9JN2h8pzVBYPS/1edQOm+3Y8MNjq1fgUnzvkT3D
         60wWEmQvh4GcpaZZ6SoZxRMvkdAm9ESoWguswcUhSNBf4F/393QusWCLWOClRbpVLuN9
         82r1uQdD3adFERoHGgBH3lqhWDV9zK/ZTnj7YkbjAoDIeZeAMxgdo7vk51LBV2wDzrrJ
         rFWlS0jj15TEnURXahDHfCZmW7E9FKS65QH7V7NnTNO2FPA5kuXP+NwxtanYwM8a9Pkz
         TH5Q==
X-Gm-Message-State: AOJu0YwLOBrHqAvkU6XWONm2zd827IPD/X2mRguAS1rh0MJpusjcpJFO
	NWPdaGbKFrldWpN68myAi1r044bAFWIulknPag/5y95hxOx9LUOF4R9t
X-Gm-Gg: AeBDievJnsGLD8dCNl6+34CZTY+yz57ys53OLPICG34rkE1T9qtLRIg9rrvbnWZ0qkr
	uCFd1lpt46RYIUpFuCIwgwob+wR/iuUZzaxNg27fGPbQcdXhH6TEah/vhTLpyevR+K9W8bOxPYm
	EKy/cQoMzWo0XXpIYiGNUB+R8/feFOIdQGVgdqLm95j+TFu4iTY5Bu3Vn61wn4Cf57BKZ0Gb//q
	ejfsn5qVfa581+r53fq0edOROAE7jLXGvsiaeTDzx5lOwCbTZCl2j2Lrg0wyoTpNkBDmjdqE3Qr
	e+vCdVZx1KJxlecAldk16MUa2+Q/33h3LsShUuZN8lclLG+I1oYJm7CyvI5RjN0lbufSlDjIWZy
	h+7/oo8JKF2pWWpwIgJ+ly4egsc7pb0IU5CQUriYxtWpnd1EYpBh4Q6TTlwVaPCEBpFCIurzCAa
	D5j+nJHSNrA9YvF/fWOPamItGPRVZEyXd8cvhIvQ==
X-Received: by 2002:a05:6a00:2d85:b0:82c:9126:31e3 with SMTP id d2e1a72fcca58-82f0c31050amr3292091b3a.26.1775815699762;
        Fri, 10 Apr 2026 03:08:19 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b7d10sm2462891b3a.28.2026.04.10.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:08:19 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH v4 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 18:08:22 +0800
Message-ID: <20260410100822.196999-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410044259.95877-3-aethernet65535@gmail.com>
References: <20260410044259.95877-3-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found some issues.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260410044259.95877-3-aethernet65535@gmail.com
> # start of sashiko.dev inline review
> commit 7a816b41f4b321b6a513227bef0e50f3bc1e86f1
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/reclaim: validate min_region_size to be power of 2
> 
> This commit adds an early validation in damon_reclaim_apply_parameters() to
> check if min_region_sz is a power of 2. It attempts to prevent kdamond from
> terminating unexpectedly by catching invalid values before they reach
> damon_commit_ctx().
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da147786583..2747eef5919d1 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> 
> Is it possible for a concurrent sysfs write to change addr_unit between these
> two reads, allowing an invalid value to bypass the new validation?
> 
> The global variable addr_unit is read twice without READ_ONCE(), once to set
> param_ctx->addr_unit, and again to calculate param_ctx->min_region_sz.
> 
> If addr_unit is changed from a non-power-of-2 to a power-of-2 between the two
> reads, the validation below might succeed using the new value, while the
> invalid addr_unit is committed to the active context.

I believe this is possible, because the current call to
damon_reclaim_apply_parameters() is asynchronous and does not hold the
'kernel_param_lock' during execution, so this situation should be
possible.

However, I'm still unsure whether your suggested changes should be
included in this patch.

> 
> > +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> 
> Does this early check mask a structural issue in the core API?
> 
> Looking at damon_commit_ctx() in mm/damon/core.c:
> 
> int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> {
>         ...
>         dst->maybe_corrupted = true;
>         if (!is_power_of_2(src->min_region_sz))
>                 return -EINVAL;
>         ...
> 
> If a different caller passes an invalid min_region_sz, it will still trigger
> this same trap.
> 
> Could the root cause be addressed by moving the maybe_corrupted flag update
> below the validation checks inside damon_commit_ctx()?
> 
> Are there other ways damon_commit_ctx() could leave the context corrupted?
> 
> If a user dynamically enables features that require memory allocation,
> damon_commit_ctx() calls damon_commit_schemes() which attempts to allocate
> memory via damos_commit_quota_goals().
> 
> If this allocation fails with -ENOMEM, it returns an error but leaves
> dst->maybe_corrupted = true on the active context, permanently terminating
> kdamond.
> 

I discussed this in my previous reply. But I realized there might have
been some misundertanding in my previous explanation. What I wanted to
say is that there might indeed be some issues with 'maybe_corrupted' in
damon_commit_ctx() that need adjustment, but that's not within the scope
of this patch.

> Can a concurrent sysfs write cause a divide-by-zero panic in this same
> function?
> 
> Looking further down in damon_reclaim_apply_parameters():
> 
>         if (quota_mem_pressure_us) {
>                 goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
>                                 quota_mem_pressure_us);
> 
> The global module parameter quota_mem_pressure_us is read twice without
> READ_ONCE().
> 
> If a concurrent write changes its value to 0 immediately after the if
> condition passes, a quota goal with a target_value of 0 is added.
> 
> When DAMON evaluates the quota score in damos_quota_score(), it uses the
> macro mult_frac(goal->current_value, 10000, goal->target_value). Dividing
> by a goal->target_value of 0 will cause a kernel panic.

I tried to reproduce this issue, but without success. 

However, based on the code, I believe the problem exists because I
didn't find any checks preventing 'goal->target_value=0'. Please let me
know if I've missed anything.

> 
> A similar sequence exists for quota_autotune_feedback.
> 
> >  	if (!damon_reclaim_mon_attrs.aggr_interval) {
> >  		err = -EINVAL;
> >  		goto out;
> >  	}
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260410044259.95877-3-aethernet65535@gmail.com

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260410044259.95877-3-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail

Best regards,
Rui Yan
