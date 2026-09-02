Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663F43F0B0
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390784; cv=none; b=sEqEgW0fgi12iJUg7WRiR94jsLCxPLXD2IaZctppEU4YVj9c3mDQaA9J/34xQGuXCAmZubjpL9bl8iUUhpTYpP524vEkgWO3sT1x7vBnVLxf2FpH6SO/sdk/qHgqQlee/+tapyzrG0a18tUU0zNZ9tpqGaNdh2j+3o8juerSInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390784; c=relaxed/simple;
	bh=JMFpftqvtzAK7T6uDBXYST2tNQp4P622trlIeP6sid4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXTNv+gETyE3K+cm2wiGLhSrgcRWzCwDY2TnVd+ZLLGCdKZJTawwbPpM2FFZIVjkP2c63gBSBtsXHq/KgNkKTBKd75YoKo6kNp9F3sRvEiAz9lb2EESQC2tG2dI9BnO0w6ZerKZ+E6baP120gSUfT72BmymwNqu1XXKcNbZRLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgNSItJ0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgNSItJ0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-396750cfee6so1448113a91.2
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390782; x=1788995582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oANsTqPYV0zfdfhrNmsez3y2Ei2vdqKIizOLng4NKB4=;
        b=pgNSItJ0rLPNGgIkHelJu4OBEyxkK8rUc+3c7JJE8FUKFoUrraRqTsKhHc5TN1ERr1
         MXuSCEQ++fpKNoAKjc8g8pddxN7KG1mfeG98ieYa8LVtaBg58UdMwu1YYswTGq8NfLDX
         aOG9yxn8lXpHbkKpMUSjtaPZjehHvODydfgMzKYRHOsdKvIZMeojVuhMsQPs6JodFkj0
         1zRnYWa0M5EmUy81p+yVdclbHjv3qWAIED0/l7L0uppH1r8Tc5oWB7/UAhZ6jYfUPT/0
         4FHypl+qNdzCSg6wMemfc+OwkvyrePycJ2kEyVvNP5T+p02DuttcjL2Wd8F8yiPNVZMD
         2oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390782; x=1788995582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oANsTqPYV0zfdfhrNmsez3y2Ei2vdqKIizOLng4NKB4=;
        b=EJoIRTlArFrvr1U3Ykv7cHJRCHYr3088F09PveIhH9PchK3HW4GYCM1MzL2AtfRJY7
         w88kTkgfOeg89RXu3dQJQf+HUslT6Ldr44yKPWH+59v9uHLa9D1V6HMYQNuJEyiJxDz5
         Zo0fKMe74EBRZZ6W/krwO19tUqD5AyMJzP41u/F1x4gdtQ0cmVJ1JSRmxQJyopXdESYq
         M7QBwryWYLGwOS5RNi9sboe5CeW6rtKZc8aG7Cp6x0uTELpGp6xHyK+3c8vffu5mUrEv
         rRDEvojmq+Z9G426RJLRhOXNjWAVYmKw5fGALjA2y1EHiSVjcAtOBKbb9sd0BIM/U3wJ
         ktMw==
X-Forwarded-Encrypted: i=1; AKwUvBwIKHwP0c6P4rbsD9pMcmWMuxXJw5sihodxqGxNyPlktmGLD3MANejccXn4mAfMH7cD9VQALA==@lists.linux.dev
X-Gm-Message-State: AFuF++nHY1G/ntJnAgB295VSDbW0fZ8dJM36oYHnbjPPOeSeAKE/YxTf
	LNgC4GlBBs07l14WKBYlvGpF5sG7niyRsFMB64KxzbRlbvy+s5ZilSyj
X-Gm-Gg: AYBFou2VfRX2sjZ1l/mKX0j8HKT5HL+gplTqjfhyee4OtN8zIleuPC5P+s6FjaWB86u
	y7LZVXzet2S2NMEFlPJOFDEjasjdOZyXx/IKjXvClHmPtz2W2RG1SPS0qTwWd8edDr7PM7uICyo
	LReC23IJok6hXgylsPDZes3pO0XY+wSIebgWZHI7VC6Ltz8ecDmbE1pfoybUUTIMT1OY6AHWWCF
	Rze85VVLF8k8yZXkCH+O5pxnw+8gtGU39uVnBnX0PTn87hiVman6uc2bqjC9e5NsJvYZ8eEc1IY
	1sU/1rX15hCNjvOKHnquty5n3kqvuI+on5oaPGqGZewAxGo14zxZKQRdZTMqG+p9SA7FMxISgP3
	H+UzloU43WNef73wEToVUSA7INZe66eS/pLoiLJeDtmNW1w+Yvqe041T++ea+CD1fxkiGVjd24g
	1gHczQzzVp5zCikvkHR9guTpkO8Ci8vXs0dobevT3gTM3YdJbUWCylxuJLrZeGP1g2
X-Received: by 2002:a17:90b:4ac9:b0:398:9bd5:490c with SMTP id 98e67ed59e1d1-39aee0b498dmr10034854a91.19.1788390782043;
        Wed, 02 Sep 2026 16:13:02 -0700 (PDT)
Received: from celestia ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083f04d1sm1501603a91.8.2026.09.02.16.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:13:01 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: allow esz to be set to zero
Date: Thu,  3 Sep 2026 07:12:15 +0800
Message-ID: <20260902231311.17490-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902150301.88535-1-sj@kernel.org>
References: <20260902150301.88535-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 08:03:00 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 22:35:20 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Wed, 02 Sep 2026 07:13:48 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Wed,  2 Sep 2026 16:20:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > When the temporal quota goal tuner determines that the goal has been
> > > > achieved (score >= 10000), it sets esz_bp to zero so that the effective
> > > > quota (esz) becomes zero.  However, damos_set_effective_quota() clamps
> > > > the quota to min_region_sz, preventing the quota from ever reaching
> > > > zero.
> > > 
> > > Where in the code it is clamped to min_region_sz, when?  And what user issue
> > > this can cause?
> > 
> > In damos_set_effective_quota(), when quota->ms is set.
> 
> Please clarify this kind of thing (when quota->ms is set) from the next time.
> 
> > 
> > '''
> > 	if (quota->ms) {
> > 		if (quota->total_charged_ns)
> > 			throughput = mult_frac(quota->total_charged_sz,
> > 					1000000, quota->total_charged_ns);
> > 		else
> > 			throughput = PAGE_SIZE * 1024;
> > 		esz = min(throughput * quota->ms, esz);
> > 		esz = max(ctx->min_region_sz, esz); /* <- HERE */
> > 	}
> > '''
> > 
> > This is a minor issue, the main problem is that it doesn't match the
> > description in the documentation, which states that if the goal has
> > already been [over-]achieved, the quota will be set to 0.
> > 
> > Original documentation:
> > 
> >     - ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
> >     fast as possible, using maximum allowed quota, but only for a temporal short
> >     time.  When the quota is under-achieved, this algorithm keeps tuning quota to
> >     a maximum allowed one.  Once the quota is [over]-achieved, this sets the
> >     quota zero.  Useful for deterministic control required environments.
> 
> Thank you for clarifying.  Please clarify what is the problem like this from
> the next time.  Without it, reviewing spend unnecessary time.

Noted.  I will ensure future commit messages and descriptions clearly
state the triggering conditions and potential user impact to make the
review process more efficient.

> 
> I feel like your recent patches tend to lack such clarifications and spend
> unnecessary time for reviewing.  If you unsure, please ask questions first or
> use RFC tag at least.

Understood.  I will use the RFC tag or ask questions first when the
nature of the issue is ambiguous.

> 
> I agree this behavior is not matching with the documented one.  The point of
> quota is making DAMOS not unnecessarily aggressive.  Hence it is designed to be
> set as minimum as possible.  How about below?
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3485,6 +3485,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
>         struct damos_quota *quota = &s->quota;
>         unsigned long throughput;
>         unsigned long esz = ULONG_MAX;
> +       unsigned long esz_time;
> 
>         if (!quota->ms && list_empty(&quota->goals)) {
>                 quota->esz = quota->sz;
> @@ -3505,8 +3506,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
>                                         1000000, quota->total_charged_ns);
>                 else
>                         throughput = PAGE_SIZE * 1024;
> -               esz = min(throughput * quota->ms, esz);
> -               esz = max(ctx->min_region_sz, esz);
> +               esz_time = max(throughput * quota->ms, ctx->min_region_sz);
> +               esz = min(esz_time, esz);
>         }
> 
>         if (quota->sz && quota->sz < esz)
> '''

This solution is much better than my initial approach.

I will incorporate this change into the next version.  Thank you for the
review and the improved fix!

Best regards,
Rui Yan
