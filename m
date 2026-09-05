Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90031389459
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617655; cv=none; b=sUwJkA60jaLEsVSEN5awUuztl1MwNyfPXLqG28Xt5i45Ui1FYIOOj0KsdfaaGcpeq+cDQYhsg2no61DKfXIBTaBR9AjO7XX6+UZ3TT3C6cZmRE4FB3lsWlhD8gSzwfPx3fb8P4sNehdJjYo4tjYJQJriAEUbQ0rXps8XrFvY39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617655; c=relaxed/simple;
	bh=KXg1EAoM0/RMl7c/jKhO4NdJWpFjacna5aRKB0RlsSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssdH6dyQTgTQm2Z4JqqSMsjHMIZOStHisSWK2uY4eJQnBj9bDskqSQk2zwZVbRczqAA3/pC0lUTNsXUv1g7xZEW1It0JkbqsosyituLi+Oyxpc8TqHC41e4Cx6bz2aTxTvmvr5AZWcw23PLl24WjZQuyu9/n///l7Nd2KjO8q9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdZ0Vyj5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdZ0Vyj5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2204562b3a.1
        for <damon@lists.linux.dev>; Sat, 05 Sep 2026 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788617646; x=1789222446; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nUSMR9Rv7P0bE66sYv7P+jDtBU38A8MZQ8qP3Q7v8aA=;
        b=sdZ0Vyj5eMBVw41R+ZAMGhs94BETvh2z+PMrA3DoZ+pamvh758YP9J77PY4VsS+1xg
         8TPOv1sZoTz5d+CWjyNjp5u7Iv1kwY4nDGYhhHk1NZd4vVHOD9fdQ1vq7CblUANJsYFl
         wgsljyBX4UisPxr49/hbn8CHH8WfnSvK92KQwAHUBdc9MSIFLHl/iFYwPn8ZJPjSJ9/V
         kGv3rY9qhteMe8P5ZBd4GH+RUZ+SILYxtUK7gw6xTrr5Zk+oMtMai12bCtFW0AEPiSH1
         9eNxsg1LEr29DeFvF7+gPIKYkBITQmdQnaJIZ5L/IzqpjeebrhQSNJxlHkjec/i8baD8
         y5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788617646; x=1789222446;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nUSMR9Rv7P0bE66sYv7P+jDtBU38A8MZQ8qP3Q7v8aA=;
        b=TSaXDDG1E+hUoSOof7hrBFKoDELN5vJDAfu+cYV7QC+KbUJx0UMCNA8YOOTEwalmBN
         qDfjAqNB0jxtRa2pkICU2JCBMNJh8T2CfAxleBiUCJHXxbuJurCOjY9kbB9l0pkFdw1a
         QXZ18U4+c23fXzm7bNykXOKWNh0Yaq16oRKjfjEh5PGRil60KMylrYn5RFvL8sk2payW
         zxitlxcsBxaBOSC/VzALgA5WiVCucvBNY1k1o0zq0o3GYKcVtxWVLrkN6jgwc5QtKXi/
         5I6bnItmr90spDWVefQGy1ne9aRoxlRxe7KZOIbgha2Aw5PZ3EG9c5BOaNIZbQFJVLl/
         aahA==
X-Forwarded-Encrypted: i=1; AKwUvBy1rkDUaeatk4ZMiH/C1g199rnRRFAd+RiSwbnrokt9hkc4V+dT8ul0y3LOBvXe+56VkqgsxQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kfvfWyhUi7Ef9c9Ixc8LqSERsnVZ7Lpj3feI+TLCLVx9YnW0Gf
	SbGX8iI8Gbi2ws6+h+94RNCJT3rsxuoAbMerMm88M3RkuRKCLMr0xcQY
X-Gm-Gg: AYBFou2dye5jIAxPfIuwsbeZsQL/hAARS+ldg8H7EmGnwg/PjYEdHVC96w6TiS6uYWg
	W9BWeu0/v+sXMpiDfTrPqLwNjLUmW+Te80ZJluSc9MQ4hWd/bXtCXQMD0pSgND15GqJpjyVpZ7v
	3IoAKElEiktCB2f7JoOIZfYeXS98OXEb5vwfEgSgnKa3uSdxVgwHo10sGEZ+JPOy3ffamO0LIb5
	Vpo6fMu4v26EGe1J4DeJExi7qJnLRcEg+EmAfCHBSdn6nvKpBJnei5lJbBmaFdbYQN1ikjBOkCj
	IbMo+McXBE3gBPI8q826+pemNFvAYVDBBqiOgMWqhG18g1Di5txoaBsNChnaK7+YV0x1E1ZqlF0
	n+FTskSEhQNSbubdsl4caIU3RW1wMIKqCnOfFveZEz1QiiuAyXfS23OLmyjGfW+kArf3+JlIbHF
	QQSIOmS4/10fncxolbGmdgA0cUHRxRKtNKh3HkFLwxXjF/MpdNeUz/2FIEJzKrdEPI3PU=
X-Received: by 2002:a05:6a20:a11f:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3da3a0af18emr17785724637.13.1788617646498;
        Sat, 05 Sep 2026 07:14:06 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([115.164.90.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc46b4cd51esm653669a12.2.2026.09.05.07.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:14:06 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3] mm/damon/core: allow esz to be set to zero
Date: Sat,  5 Sep 2026 22:14:09 +0800
Message-ID: <20260905141416.4347-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905125825.BD5D51F00A3D@smtp.kernel.org>
References: <20260905125825.BD5D51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 05 Sep 2026 12:58:25 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit integer overflows in time quota and throughput calculations lead to severe miscalculations on 32-bit architectures.
> --
> 
> commit dc1c35769ce920ee1796367097f9876b2f24a643
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: allow esz to be set to zero
> 
> This commit modifies damos_set_effective_quota() to allow the effective
> size to be set to zero when the goal has been achieved. It changes the
> order of max and min calculations when quota->ms is set to ensure
> that a zero esz_bp results in a minimal effective size instead of being
> clamped to min_region_sz.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ce8c6f99106ed..3e9c9b6385d4e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3259,8 +3260,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
> >  					1000000, quota->total_charged_ns);
> 
> [Severity: High]
> This is a pre-existing issue, but does mult_frac() silently overflow on
> 32-bit architectures here in damos_set_effective_quota()?
> 
> Since quota->total_charged_ns is represented as an unsigned long, it natively
> overflows after 4.29 seconds on 32-bit systems. Furthermore, when
> calculating throughput via mult_frac(), the remainder calculation
> (sz % ns) * 1000000 can silently overflow a 32-bit unsigned long, which
> causes throughput estimation to be completely incorrect and often near zero.
> 
> >  		else
> >  			throughput = PAGE_SIZE * 1024;
> > -		esz = min(throughput * quota->ms, esz);
> > -		esz = max(ctx->min_region_sz, esz);
> > +		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
> 
> [Severity: High]
> This is also a pre-existing issue, but can throughput * quota->ms overflow 32
> bits for quotas over a few seconds here in damos_set_effective_quota()?
> 
> If this wraps around on 32-bit architectures, it improperly clamps the
> effective size to ctx->min_region_sz, nullifying the time quota feature.
> 
> > +		esz = min(esz_time, esz);
> >  	}
> >  
> >  	if (quota->sz && quota->sz < esz)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260905124706.3398-1-aethernet65535@gmail.com?part=1

Thank you for pointing those out!  I will fix those separately.

Best regards,
Rui Yan
