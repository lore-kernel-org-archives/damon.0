Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6543515F0
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511786; cv=none; b=me1jVTSJ4rs8zTzUmg0abHGJjwObECea7lqQc8i2yjkHh6SHo5UIeC+PUm7N2mpt0BRQs5vfFjkzUwSE5NhiZn4QYh28H2UJO8d5M8BgYysL9gYngGGtI/Fk/83MI7BRDkwaDPnKCsp2eUijhTf6EW8RsLKh7D6YqTtnLQjbp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511786; c=relaxed/simple;
	bh=E6vWeaQxs8rVGdtAUPAmdY6vU3yUUQSm04409HMSd/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASCkLazAF+8xHTsmTMxCUTVVznau6S/9mIiQj7f+ESq3qEIj3PlsRsGZfY02uGX+0dJa3Hq9WUzxYYsZ4lJ9BAU8xCEIkNz+okOY6AdtNg2+77ho4h3pAAJoAHxzdgmCwfZU5LzyKlY8eYc6OFMBiEIgk/KGOR2RkAM+fK7Ll7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGGVvQFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGGVvQFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E321F000FF;
	Sun, 27 Sep 2026 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511785;
	bh=mRytbnzR/OGpDwDJCGjKI75QmyE4863UvNMoGnp79vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FGGVvQFn5zLR8rqJ8Bd053D6VI6sjStVTHVMmT3kKbax2t1HGo+BMU9ssXFdeOvbQ
	 6eT7S0mP6eZ4jMhk+AHI3dX6MCEr9f2CvJVZGDpkaidi1UKU4W5bC/bYnLx7ZevPLg
	 1W1LVhs4chv72jqcHBJolKT0sP1jeaJVqW7/DK6z0NwqqAIYXgR/dlP7jtY2k2+Whw
	 VALlxuJYbA0FwC4mCoJPp3Ii0ggYUJgVSAVvsopr+8YnaPSZ3iRwQuOmD7rRcphQyp
	 U2uDOTqQzZ+1w6siQCSy/as8XofChhKDM0peU7krIaYNzwCA1q4rl2fUPpY8dW/HBp
	 mYSmi9rZ1muAQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v4 1/7] mm/damon/core: introduce damos_quota_goal->complement
Date: Sun, 27 Sep 2026 05:22:59 -0700
Message-ID: <20260927122300.51076-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927121715.19E841F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 12:17:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm: integer overflow in damos_set_psi_current_val on 32-bit
> --
> 
> commit 4f53a2ca54f02309422119354f04050f15950222
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damos_quota_goal->complement
>     
> Introduce damos_quota_goal->complement for specifying whether to use a
> complemented value of the given goal target metric.  Add the field to
> the data structure and implement essential core support.  Handle the
> flag in the quota goal commit and current quota goal metric value
> retrieval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 733025b367457..270ce9c85a2ce 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi_total,
> >  		struct damos_quota_goal *goal, struct damos *s)
> >  {
> >  	u64 last_psi_total = goal->last_psi_total;
> > +	unsigned long val;
> >  
> >  	goal->last_psi_total = now_psi_total;
> >  	if (last_psi_total != U64_MAX) {
> > -		goal->current_value = now_psi_total - last_psi_total;
> > +		val = now_psi_total - last_psi_total;
> > +		if (goal->complement) {
> > +			if (val < s->quota.reset_interval * 1000)
> > +				val = s->quota.reset_interval * 1000 - val;
> 
> [Severity: Medium]
> Will this calculation overflow on 32-bit platforms?
> 
> When reset_interval is configured to a value > 4,294,967 ms (around 1.19
> hours), s->quota.reset_interval * 1000 will silently overflow when evaluated
> as a 32-bit unsigned long multiplication.
> 
> If this wraps around, could it corrupt the complemented PSI value and lead
> to faulty auto-tuning feedback? Does this need a cast or different typing to
> avoid the overflow?

No blocker.  Sane users ain't set such large reset interval with complment flag
without a test.

> 
> > +			else
> > +				val = 0;
> > +		}
> > +		goal->current_value = val;
> >  		return;
> >  	}
> >  	/* uninitialized last_psi_total; make no effect this round */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260927120533.50484-1-sj@kernel.org?part=1


Thanks,
SJ
