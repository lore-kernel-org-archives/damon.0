Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807274;
	b=LrRuV8tZF/39SZwf+YRrYH/3Ja1YGHkUxfH3vHY9zWAShowr6So2QvXsuajZijtJNA1r
	 QgE29irK67e7f3xN2k2XYYivn8x4nvUK6waBT5Jq8DbH4qnRo55MIw4bm7y1xJhEpg+wH
	 u2PH5aJChiJFZDcWFzkOrKfn4bvrJvP8avS/aOGV7BjMWdiT92+5sMmLRSwVjy+xnNRZF
	 rAf0qSqBLKIItWvu+1Ta/RXkzhFSxe/37weG36JIA6VvoqxAvZEO6DTKFzt8UsMlWSSl2
	 B2UyqUy+S6kuv2S/VLaXa5HXTcAG8NCB7lrPZPjLvwp8RTR4z0dpdOkAf2zArL5WXLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=utyyihQu8TN6QRESsH/hf81T3MrNdClL6kRbHxBQQsM=;
	b=qcznx77GVk44ZVjKqO7bRIRXKDTpG4CMtq+hUPHtR8yRfsFRJw8P+wMtaOOEWhoICMCV
	 EfCIgNeRx7PUwvECt00d/XGgOFhwllYO89fXDo1wHa8wm9lPDyOWWWLp5ZR9PXN3x4pXD
	 Y1lTsnEXR7tGXQ+JnNmTu8MJGz9nqaYoiztUlk02Vt8IDkJSC1V1a6WA29yP7Vj1njy0z
	 OO0wNZL68F1CFWBbcYDz/ct8OBNxA1aLUTVbQWzTwQlHvtJfzjRjQVDuL+4rT6UpBu+7K
	 Lwrx4paDGuokKkG26e9pitguiCHWz76DOYpRabGeqY2x8hine5hsbnsGN5BQhKmLOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PlAfkGF/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA42606A328
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlAfkGF/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743B81F000C1;
	Wed,  4 Nov 2026 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807273;
	bh=utyyihQu8TN6QRESsH/hf81T3MrNdClL6kRbHxBQQsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PlAfkGF/BxL9SxJ5WXeUsapSWT8XAwemDgaP8uhuj5rZ8V88IT6OMtRmCK8VxMdsK
	 qVRxEPQ02tahFQsLb/e6YG6jf3cT3JC0mkaODuA1XWfOHOfeUOtTpLZnYYI033j/aX
	 VGJ0KcEtpQnTLhz+wEZr1nD3Ud47QBRUMTBA3CtqGo6H19+7VaGrTOQAbCGd25RDQj
	 fpkW70zoWzdXiZLJEZD6aCy9F+GGFW28YFPrzyVhnH8gdyWGxiRu6yZTvgW2/yPIJL
	 SPkMtZUkWjDai2500OB8XxglIMc6KlfYz+Whu+IFqey+Oc97Zwlf4YNZfuj1aBY14f
	 vAEQ7KpGTYkTw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
Date: Wed,  4 Nov 2026 07:47:45 -0800
Message-ID: <20261104154746.83311-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-197530@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 04 Nov 2026 15:44:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon/core: 32-bit overflow calculating age_ms in damos_filter_match()
> --
> 
> commit 8785e74923668744015c21ff7266b94722501bbc
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
> 
> This commit adds a new DAMOS core filter type, DAMOS_FILTER_TYPE_AGE_MS,
> allowing schemes to filter target regions by age in milliseconds using
> damos_filter->range_min and damos_filter->range_max.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index d36823f4d0928..d631863b034db 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2552,7 +2554,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
> >  	bool matched = false;
> >  	struct damon_target *ti;
> >  	int target_idx = 0;
> > -	unsigned long start, end, wsum;
> > +	unsigned long start, end, wsum, age_ms;
> >  
> >  	*err = 0;
> >  	switch (filter->type) {
> > @@ -2594,6 +2596,11 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
> >  		matched = filter->range_min <= wsum &&
> >  			wsum <= filter->range_max;
> >  		break;
> > +	case DAMOS_FILTER_TYPE_AGE_MS:
> > +		age_ms = r->age * ctx->attrs.aggr_interval / USEC_PER_MSEC;
> > +		matched = filter->range_min <= age_ms &&
> > +			age_ms <= filter->range_max;
> > +		break;
> 
> [Severity: Medium]
> Can the multiplication r->age * ctx->attrs.aggr_interval in
> damos_filter_match() overflow on 32-bit architectures?
> 
> Since r->age is unsigned int and ctx->attrs.aggr_interval is unsigned long
> (in microseconds), the multiplication is evaluated in 32-bit unsigned long
> on 32-bit platforms before dividing by USEC_PER_MSEC. Once a region's age
> exceeds ULONG_MAX microseconds (about 4,295 seconds, or r->age >= 42,950 at
> the default 100,000 us aggr_interval), the intermediate product wraps around
> and misclassifies old regions with a small age_ms value.
> 
> By comparison, damon_hot_score() in mm/damon/ops-common.c casts r->age to
> u64 and uses div_u64() to avoid this 32-bit overflow:
> 
> 	age_in_sec = div_u64((u64)r->age * c->attrs.aggr_interval,
> 			     USEC_PER_SEC);
> 
> Should damos_filter_match() similarly use div_u64((u64)r->age *
> ctx->attrs.aggr_interval, USEC_PER_MSEC)?

Good finding.  I will do so in the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261104153645.82945-1-sj@kernel.org?part=1
> 


Thanks,
SJ
