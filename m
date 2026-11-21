Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295970;
	b=rH9S4znEWU+Yk70oq8vzLzJPgg/9slIg3i8RFqxTHVyKZUmAQxh9a7+tNh2cXq3iOtbp
	 L6MoxNxLGbtpnmnJlHHkkN5YxJLQuH0YTcHWLBqhcp2Q7mq7ABFEpOGKyVaqTUsdbTPrT
	 fnz1fYWQd33BxYFxi0WTmh+2u6m+V7riNOGcuIzFmLSSwQtAH3gT1y6qMR4RBy8RnoNBa
	 4z6nG+K/hL/ZKO3uPKMA+lCTfqYN3RGWCOT9zOnDHTPthpg81MnVoHhfwQV8MkOjPHT32
	 d6ywrqcnouMB5mT+AVtm4XxoobqPuFpWxCVACz/uh7Vqwa3Ii1Hi7AcAc0XSYlR03zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WaTru+7iZeRykjuAQvPQ+D4kS8HXOpf8/kVMpoCZb+8=;
	b=330a6ZB1x9nD/DlHF8Y/ugoBEFtNWwPSKrScXkBzM6wCmdBpK8wa4/oAj44MJbtxeibv
	 ysoENVh4lqerWGyhjFuSN5+DuCQCZbiTLdWV3EwcHXgYp9jS86sofk5br9YJL6WOtUeY2
	 GEJum+hNqWJTWzAb627vvLyvV+UQLW3HIxMjwZ0Z7/ftauC8TRVvAlyRgDuZSqHXSSX3/
	 +ww/k+i/77X8Yeitoqw3eVn8OvqUR4LO3ANw3r3AEdsyq+BzB8Mw29N/2oCMfuYtoque7
	 JnwKnjaIaZtVvkdR3Rayo3aE6nmvbWN6R0SvIi/MyiKsUJBd1qqQO8joyX5BIOAhnDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FexgPKnt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02933606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FexgPKnt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859841F000C6;
	Sat, 21 Nov 2026 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295969;
	bh=WaTru+7iZeRykjuAQvPQ+D4kS8HXOpf8/kVMpoCZb+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FexgPKnt7v63zRWn1h3XidhzBo6LfdZo2iIrNwaykQrZj/PidCKyJqBEbhtma4t02
	 jkRQ2s5CXotH9rH/EXnhtatOaR8w/kqMVUrM2zVWhNWr74jCvGa9ZcFLh4ChxsXd3N
	 m7wPoNJTYOQWVuNv5lVTzxjQ+FEhWxAne/gTrv1WUHAUanyAsShlWnZOAFx3KKTE+S
	 /hJ+zNFFSbb/LKyQCPc3Krq13qY1y9VCypmoyS8q4PKPPUXzubvTFaYqypBGX+E0AP
	 WJfGOfR81TYSuOb6hBHvEF1kt8jXIBhco3o65JK3ud2mrbJQO4QlTPsSQ2QtV+mvIa
	 RxwyivuYK5qNA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Sat, 21 Nov 2026 13:19:20 -0800
Message-ID: <20261121211922.131352-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-227387@kernel.org>
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

On Sat, 21 Nov 2026 21:11:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon/paddr: 64-bit phys_addr_t truncation in
>   damon_pa_filter_match()
> --
> 
> commit 28e4b56e5a2332a155374f4f6e67e8b3da9ffb34
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: support REPORT_MADE type probe filter
> 
> This commit adds DAMON_FILTER_TYPE_REPORT_MADE probe filter support to the
> physical address space operation set by querying damon_report_exist() over
> the last sampling interval.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index e89cb14ee17be..4003ae914f1a2 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -140,9 +140,10 @@ static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
> >  }
> >  
> >  static bool damon_pa_filter_match(struct damon_filter *filter,
> > -		struct folio *folio)
> > +		struct folio *folio, phys_addr_t pa, struct damon_ctx *ctx)
> >  {
> >  	bool matched = false;
> > +	struct damon_addr_range addr_range;
> >  
> >  	switch (filter->type) {
> >  	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
> > @@ -157,19 +158,27 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
> >  		else
> >  			matched = damon_folio_young(folio) == false;
> >  		break;
> > +	case DAMON_FILTER_TYPE_REPORT_MADE:
> > +		addr_range.start = pa;
> > +		addr_range.end = pa + 1;
> > +		matched = damon_report_exist(filter->report_type, &addr_range,
> > +				jiffies -
> > +				usecs_to_jiffies(ctx->attrs.sample_interval));
> > +		break;
> 
> [Severity: Medium]
> Can assigning pa into addr_range.start and addr_range.end truncate 64-bit
> physical addresses on 32-bit CONFIG_PHYS_ADDR_T_64BIT kernels?
> 
> struct damon_addr_range uses unsigned long for start and end.  When
> monitoring physical addresses at or above 4 GiB with ctx->addr_unit scaling
> on a 32-bit PAE/LPAE system, the upper 32 bits of pa are dropped (and
> addr_range.end wraps to 0 when the lower 32 bits of pa are 0xffffffff), so
> damon_report_exist() matches against the wrong address range.

Good point.  We have addr_unit and damon_pa_core_addr() for the reason.  I will
use those in the next spin, like attached below.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261121210013.130397-1-sj@kernel.org?part=14
> 


Thanks,
SJ

=== >8 ===
From 73575b284234823e9b9f78d9bcd614ecba1ecc54 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Sat, 21 Nov 2026 13:16:36 -0800
Subject: [PATCH] mm/damon/paddr: convert physical address for report_made to
 core address

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 8cc5b249d69a0..be3283456009b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -224,8 +224,8 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
                        matched = damon_folio_young(folio) == false;
                break;
        case DAMON_FILTER_TYPE_REPORT_MADE:
-               addr_range.start = pa;
-               addr_range.end = pa + 1;
+               addr_range.start = damon_pa_core_addr(pa, ctx->addr_unit);
+               addr_range.end = damon_pa_core_addr(pa + 1, ctx->addr_unit);
                matched = damon_report_exist(filter->report_type, &addr_range,
                                jiffies -
                                usecs_to_jiffies(ctx->attrs.sample_interval));
--
2.47.3


