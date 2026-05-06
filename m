Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3FB4968F4
	for <damon@lists.linux.dev>; Wed,  6 May 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086755; cv=none; b=S/brAiEYNkor4adsQujsSwP2US/saGVcQ+VAQlFzzGlFUawG/3UjXgijMRLyFocGlOl4Eq0cK7yUzh0NBbEr+xLAfru+vWRFjMEcL0vHBxaSCDGaCDEKgZD6hV7RsSPrTLLxc3EJg9S/WFGRm3Js7zAiCNDBsZ9xNB4fEgYJ0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086755; c=relaxed/simple;
	bh=5QJhHKKhw5tUQJL73Mu9EmRj9Ess6xJQuctQNikIp0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnlDM9qRT0F7ucnuf0Ue8GBVh2eD9jUPAzq3gTsDbNoeWN8vuPce7Q9Xk/15fpb9v+xGgFXl+Jtl/uNcEGlmLWzcHneHiGE1AZAjG7O6UB/CyRm5BmCh07meGRL46mQ+/E6VGy/8NqAuZZGtrGO/1YcPHpxu2KBJlPbO2i+8OVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovST5b9Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovST5b9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49371C2BCB0;
	Wed,  6 May 2026 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086754;
	bh=5QJhHKKhw5tUQJL73Mu9EmRj9Ess6xJQuctQNikIp0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovST5b9YIjetMpYZsYDTtAZZTYwn7xEz02HxjrK3rWrQ6rndYoipqwnMdXQ2VDtKO
	 cHUnyWHNeiUSRpOQqJTiUgopUJUdJTlbtEaKZ0mj+Ur9GtjMLxLYqtMxYBnvZ0lyxw
	 JqcTWNcREzU7fqGJ9U+d/s926hVkyTILZlEWbFGsvzGiAZ2A3P3qoqrvEuAiGoGpiO
	 FX7ZzV8PttRu3jrG76IrIEBB0ina0VTPp6JOFpYEwZUpmD+DehqFJc3nOfaN5oEqTh
	 G5fon3sUi+/DRr+aGqZ+cpydVXfLtNDfN20jTEvp8cH7R+2Y7ZEPVLEOphQyteOECM
	 2MxKgGhQnkHzg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y] mm/damon/core: disallow time-quota setting zero esz
Date: Wed,  6 May 2026 09:59:10 -0700
Message-ID: <20260506165910.10452-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504180216.17E4AC2BCB8@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 04 May 2026 18:02:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The patch masks a severe pre-existing integer overflow in the time quota throughput calculation, which permanently throttles the scheme instead of fixing the root cause.
> - [Medium] The patch forces the effective size quota to be at least DAMON_MIN_REGION when a time quota is configured, breaking the ability of quota goals to intentionally pause the scheme.

No issue for this patch.  Please read below for more details.

> --
> 
> commit 648433abd4b11fd3f4a77018e7e47105abac1ce7
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: disallow time-quota setting zero esz
> 
> When the throughput of a DAMOS scheme is very slow, the DAMOS time quota can
> make the effective size quota smaller than the minimum region size, preventing
> actions from being applied. This commit fixes the issue by setting the time
> quota-modified effective size quota to at least DAMON_MIN_REGION.
> 
> Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
> Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ed2b750231810..69f8244324b36 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1577,6 +1577,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  			esz = min(throughput * quota->ms, esz);
> >  		else
> >  			esz = throughput * quota->ms;
> > +		esz = max(DAMON_MIN_REGION, esz);
> 
> Does this cause a regression by breaking the ability of quota goals to
> intentionally pause the scheme?
> 
> If a dynamic quota goal determines that actions should be paused and requests
> an esz smaller than DAMON_MIN_REGION, this max() macro forcibly overrides it
> and bumps the quota back to DAMON_MIN_REGION.
> 
> This causes the scheme to process at least 1 page per charge window instead
> of fully pausing.
> 
> Could the max() boundary be applied exclusively to the throughput-derived quota
> before it is min()'ed with the goal-derived quota?

No, this should be fine.  This is not a very technically intended behavior, but
letting DAMOS process one page per interval only when time quota is set should
make no real issue.  Let's keep this behavior.

> 
> Additionally, does this code mask a pre-existing integer overflow regression
> in the throughput calculation?
> 
> Looking earlier in damos_set_effective_quota():
> 
> 	if (quota->total_charged_ns)
> 		throughput = quota->total_charged_sz * 1000000 /
> 			quota->total_charged_ns;
> 
> Because total_charged_sz and total_charged_ns are continuously accumulated
> over the scheme's lifetime, total_charged_sz * 1000000 will overflow an
> unsigned long on 64-bit systems after processing around 18.4 TB of memory.
> 
> When the numerator overflows, it wraps modulo 2^64 while total_charged_ns
> continues to grow. This causes the calculated throughput to collapse to
> near-zero.
> 
> Also, on 32-bit systems, total_charged_ns stores nanoseconds and overflows
> a 32-bit unsigned long after 4.29 seconds of accumulated action time, causing
> erratic throughput calculations.
> 
> By clamping the output to DAMON_MIN_REGION here, the patch seems to permanently
> throttle the scheme to process exactly 1 page per charge window once the
> overflow occurs, rather than fixing the underlying throughput collapse.

Good catch, but not this patch's fault.  Refer to my previous answer [1] to a
similar Sashiko question.

[1] https://lore.kernel.org/20260505150012.29007-1-sj@kernel.org


Thanks,
SJ

[...]
