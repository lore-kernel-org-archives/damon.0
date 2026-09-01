Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA6376BEF
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266491; cv=none; b=K+ZrlyZ5nTHqV1T2TYgo1g9mU4lMEMz0Ryg9zFUlz+uIi4TDNB8M6oBg1YKlXhitawn9N8TMnRQ64cpAYpQvm3boJGHKDlSQbK6AucA3q/C1eQXgNOQpvCFwNjLNu82H7WgsAxbrjlmzVSUKq8Kn0eoPvwsp4BDpeZL4YQng53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266491; c=relaxed/simple;
	bh=b8gsAP+P4ZBYdXqjS0oXJ6Oj9aG7F9plGT4MLePL0x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+aaEMgKywG2SGFa6TFWSDNU4XhBoqvl1LinJmpgZOAuLBh9LchLb3OC9uSDXdgfpU54e0vVUUQ7eLUYiIx61E4DS/SGmhgKGWU2JsL1cB3736rJWpIT9pq1f1wnEZI+T5+mepk/WYgivgFpIRtVpV74YOaQUFUYJpHSjiza+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEDInNOZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEDInNOZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d7200b2e15so49918035ad.3
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266489; x=1788871289; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UYiynw6vM0fgHMzi4l0VXX5lqoSkw24de4a4ijW/A5g=;
        b=bEDInNOZSp4OSjX8Wvv6WUArENpke74SsEZ3fUcWeSr2sJHtydHh0sbOyoz1ok8bz3
         eLAgR79Wfpt/dZjRqrY1uIK57rKI+z+D8ZG8gCOolJClzE7yNwdQvYCdBkBKP/iDrKk5
         gK1Q1b6EVeT78fxOHhppmUkKslr6HaJKoDmaGzrRdv5v4Nd/APEoqWon3cXRcmPvz5ho
         KgduGBhX7ZVFeqUAhmSYevn0n+674V+CMGy75L24roaI0UPwHzs4xyN8ql6WAIRwpog+
         vfXwkYJhHcDebTpX69q2l1GHTYcz5Qw7OxvcqoHWNNj1Lfr99zcjrzcG7k+95ym7ubIg
         vp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266489; x=1788871289;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYiynw6vM0fgHMzi4l0VXX5lqoSkw24de4a4ijW/A5g=;
        b=Vkj/vp7eYXQsEUnSv14SegOhur92d9bRWezNn9ZxwpW406tpRme24nnKrSeNA0qP8O
         Gn7vh7UhlItvOUoDASIOgcHlFfq6nkEDOC8I9t0bYoczoCz+Ik3gSPlRxX+6VtIHdLKY
         8sl31HcQrVR04TNmTAXf7mYVTXr/DqkxzX/M/9fsCl9lS1lJhVWenDfWcNWtQBUV/+iA
         QO+MxPbaV3GcRu2nY6KXxQFJYyOUwIpxcBhWzq0JaJ5TpW7G9EGwAfjoDFko4ciSwDNC
         9cCLDi2e/Tt5/vzIw9lXI6Knt0nj+jRhOx11A283Xj5ChR/KtoYuVljBbZ1tk5sIbSyX
         8Ewg==
X-Forwarded-Encrypted: i=1; AKwUvBzamtVA97pbD5lr1efftZluo2vNR0UWjYjYEdffUbKC6/e1Xej7YznZQjiGPTFsd3SWLiJr4Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nZ7rOPLBaDphgPpbcifdDGJkW4Gx7NWi6WtbMTpKj42/QunY2l
	KJYwzo+R6N3tvsI0gndW8OL0Z6PZNML5w99G88OamtWAZVknxuWGYNAZ
X-Gm-Gg: AR+sD10RtZs1KlLFNbecFyUhszD/ZxzXpitAnctkc94LthbW6z7hAbYfVJaoigShjfA
	cu3kF/h5+VXBLTP0oi6VIaeiH9dXL5yEVv2gSOPFObB5Y1FcAJyDPiBj36RwVfIF4jDmU7MdU0K
	THNrjbcsC+7ZzpCDD8rL+AcadNtO4Hpu4AfgWNOMwljw+O7xW2PcGFiFvghFb0OEl0/v2V7WtN+
	UJ6du/5JcZGrtnkq+aB4j+hYuCe1w+HH0G+Ac76lRHd57ujTjBxzooAj3Ei4X2z6dAtbSdEXGDh
	BrOlzi0ToStus+CUDfk9Od9n4RCurnRG7Uj3UTfV0PchmSKrdeyjBgE1KVypBs6S9reo3OJHiOQ
	l+u+U/jrRWRiETcJ3pKMlE6yFJJATkya8bzR7YbLRbuFxbd4D3zoNoUgVZUH+jM3g3O+AxUMl1Y
	vkQqvga820X8/cQJCHKso9vwYn5jfvuNim/XH1rvK1v6Lo8Nka/mJRUuOZqjqbD3dhNLqDFW62c
	z0EHne8TIFfREgK
X-Received: by 2002:a17:903:1105:b0:2d8:d4cc:be68 with SMTP id d9443c01a7336-2d94a930366mr99475175ad.21.1788266489409;
        Tue, 01 Sep 2026 05:41:29 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988cabasm51180135ad.65.2026.09.01.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:41:28 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org,
	sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: fix quota could not be set to zero
Date: Tue,  1 Sep 2026 20:40:50 +0800
Message-ID: <20260901124138.8460-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901111440.A39471F00A3E@smtp.kernel.org>
References: <20260901111440.A39471F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 11:14:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch places the `if (esz)` check after the throughput calculation, inadvertently reverting a previous fix (commit 8bbde987c2b8) and causing schemes with low throughput to permanently deactivate.
> --
> 
> commit a1511f591a76665e55c325a03d3d47bf4ba87dc6
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix quota could not be set to zero
> 
> This commit modifies the damos quota setting logic to skip clamping to
> min_region_sz when the effective size quota is already zero. This is
> intended to allow the temporal tuner's zero quota goal to be respected.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3f89cfdf5f022..fdec7c0fe913a 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3122,7 +3122,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
> >  		else
> >  			throughput = PAGE_SIZE * 1024;
> >  		esz = min(throughput * quota->ms, esz);
> > -		esz = max(ctx->min_region_sz, esz);
> > +		if (esz)
> > +			esz = max(ctx->min_region_sz, esz);
> 
> [Severity: High]
> Does placing the if (esz) check after the throughput calculation inadvertently
> revert the fix from commit 8bbde987c2b8 and cause a regression where slow
> schemes permanently deactivate?
> 
> If a damos scheme with a time quota processes regions slowly, integer division
> can cause throughput to truncate to 0. When this happens, the calculation
> esz = min(throughput * quota->ms, esz) evaluates to 0.
> 
> Because the new if (esz) check is placed after this min() calculation, the 0
> value causes the check to fail, skipping the max(ctx->min_region_sz, esz)
> clamp.
> 
> With esz == 0, damos_quota_is_full() always returns true, bypassing all
> scheme operations. Since no regions are processed, total_charged_ns and
> total_charged_sz are never updated. This leaves throughput permanently at 0,
> resulting in an unrecoverable starvation loop.

Thank you for pointing out this!  Yes, this can happen, and this is what
8bbde987c2b8 was fixing.

damos_goal_tune_esz_bp_temporal() will set quota->esz_bp to zero when
goal is archived, so this need fix by adding a check for quota->esz_bp.

'''
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..c07ae66caa49 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3118,6 +3118,9 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
        if (quota->sz && quota->sz < esz)
                esz = quota->sz;
 
+       if (!quota->esz_bp)
+               esz = quota->esz_bp / 10000;
+
        quota->esz = esz;
 }
'''

I will change this in next revision.

> 
> >  	}
> >  
> >  	if (quota->sz && quota->sz < esz)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260901105951.106246-1-aethernet65535@gmail.com?part=1

Best regards,
Rui Yan
