Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA682D7DE9
	for <damon@lists.linux.dev>; Wed,  6 May 2026 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087055; cv=none; b=SHJZ5MczyevEjfDkKHpsvUsduc8L24L4dlYfoVOw5BVDLmIygEUU5OYVRk2XEvxa6n1vRowQgJfonYfNc37tqC5a5eqJCydF3rsib58RDO3EWmLdIF7l/9wZMO6HuNzcPkbu6RE6lIrD3JHMcRTY2vVn8axJ+csz03d0zeb94qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087055; c=relaxed/simple;
	bh=4UI+2eZ+UknPfi18ejYxp4jQODvmDJu5ju1azPgqxEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF6Oj0ARugbXpX32Dl3Jn1sjF4Akbv1hJGo8AfHNVx5z2HwfxjGdzlv0wBUgr2+I8fbTjbEHALFLzbenEV9lTByouTPrDoBOyFiSABfGqXV9mG0z+B7J1Uq4HqZsYouxP5sde1bWB37dFOmgK0tgpfJq6QDXXh8hatr0CUHaXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azr/WfrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azr/WfrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA20C2BCB0;
	Wed,  6 May 2026 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087054;
	bh=4UI+2eZ+UknPfi18ejYxp4jQODvmDJu5ju1azPgqxEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azr/WfrUM3Ice7YlRBg8rNbC5P7Su8HaVhk94dTm36d13X7WVC8mzligE/w6Chie5
	 YBKVSumPUuxQKCAgbiqcEs44A/cc2xMo0wsIphSiqXjrzJqkSpV5TA9WLQDmMF3+KJ
	 n6QTo9XHaAN9D2b4SXHJygEJ5/utmyadNyJLI7DiuOVncNaOCvGi5QSggvkIv+/wlc
	 r4e/WN5LsWxXU6+6ZSLdsYYlFnkNNsa7uZirkLHeaA8Ou0WXyF8BiHRUaCjjGaA/0l
	 fSId+miRZXj+N1xbWKxK/vIh+c/c2IUltqT10FOeZ7qrlQks/qFBIUb87Jiztm2CY5
	 jkXv7N9l/XtWQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6.y] mm/damon/core: disallow time-quota setting zero esz
Date: Wed,  6 May 2026 10:04:10 -0700
Message-ID: <20260506170410.10617-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504142622.B36A0C2BCC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 04 May 2026 14:26:22 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Integer overflow in throughput estimation permanently breaks DAMOS time quota mechanism.

Mild issue that not an issue for this patch.  Read below for more details.

> --
> 
> commit 352051c643d14056b79b910e005f54b4d071e250
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: disallow time-quota setting zero esz
> 
> This patch fixes an issue where a slow DAMOS scheme causes the effective size
> quota to fall below the minimum region size, which prevents actions from being
> applied. Because no actions are applied, the charge statistics stop updating
> and the scheme is unexpectedly deactivated. The fix ensures the effective size
> quota is always clamped to at least the minimum region size.
> 
> Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
> Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 48747236c21c..12c2e584659a 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1026,6 +1026,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  	else
> >  		throughput = PAGE_SIZE * 1024;
> >  	esz = throughput * quota->ms;
> 
> Since total_charged_sz accumulates lifetime processed bytes without being
> reset, can the throughput calculation that precedes this line cause a
> regression by overflowing?
> 
> In damos_set_effective_quota(), throughput is calculated as:
> throughput = quota->total_charged_sz * 1000000 / quota->total_charged_ns;
> 
> On 32-bit architectures, total_charged_sz * 1000000 would overflow when
> total_charged_sz reaches just 4295 bytes. On 64-bit architectures, it would
> overflow after about 18.44 TB of memory processed.
> 
> Once total_charged_sz * 1000000 wraps around, the numerator becomes extremely
> small compared to the denominator (which on 64-bit takes 584 years to wrap),
> causing the computed throughput to instantly drop to near zero.
> 
> > +	esz = max(DAMON_MIN_REGION, esz);
> 
> Although this clamping ensures esz never drops below DAMON_MIN_REGION, would
> the scheme become permanently throttled down to this minimum region size
> until the numerator catches up again after another 18 TB of processing?

Not this patch's fault.  The user impact should also be trivial.  Please refer
to my previous answer [1] to the similar Sashiko question.

[1] https://lore.kernel.org/20260505150012.29007-1-sj@kernel.org


Thanks,
SJ

[...]
