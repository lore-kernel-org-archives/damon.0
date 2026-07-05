Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70B2F7EE5
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269401; cv=none; b=iwb80KlSMKk2f+ou6DfGHv+TQkuBGmFfMz2mqfE4HCfkigh3VvNx7kyAqieApZ+nleMNHGV6KRqoiHVLlx41V7aBsZqNnt4u5OhFoUID4eJYlPoJv5612EW+1CZam+3sLoDzwJ/cZ939pWCKh5cb1fqSbsue78Xr8g5Xiackhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269401; c=relaxed/simple;
	bh=lcL4yNJ27LEWLGtyp/mW/9uNgt41lwfssGClbqAFH8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGoczt9Twy0mogUgr7Itjym3DeN/l1G3LaIhMZCK0wBbjV19+e9xX/5w+BXzzly2rkqEms9tS7dZAj9icZc7Raw36ZDi9e+hz8lopsRiBwlVg5Ct2WGovEnFQy6F1F2AQgUV+g8jZhDwNXgT4WdE1fJ0VnnlzpKHYs/xKPGhjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTHfNMLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTHfNMLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847F51F000E9;
	Sun,  5 Jul 2026 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783269399;
	bh=DkvDRGxxAEviXqEJARrkNCCu6RKH1IhCXI+aZQVL49Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTHfNMLI8oM1hmeqiQLfZdrJ3/Y4ZtQqedXC629bB+cC+5PBURdINrC0tihW6OxvS
	 pW+u33kQRvCRI16RetL4Q69zcTGUMxUdaUysnApde9MEK3906fE0QlUfvJrwyKyxcj
	 ciX5fNs/ic64tF0wenq++MGfe/XJjGdtOMxbKrZnKu5RCZbWFSeRXevWpGviXBkpBF
	 +hn0sjyhOkqxpLG28HXq/K9yDJOOdc4Zwxd8f/Y8PjBTu1bcybocUAXbAggC3ba4RL
	 FGFm73HyN+coqb8SGPQgR+qjmN1wbc+XvZ5lEb/YgfbcnbXVuU6Wds/fS4QTo0xYl5
	 mzYl+uP/W2ARg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 4/8] mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
Date: Sun,  5 Jul 2026 09:36:29 -0700
Message-ID: <20260705163632.101590-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705161209.E286A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 16:12:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] State Corruption on Error Path: invalid `addr_unit` permanently corrupts global monitoring region parameters.
> - [Medium] API Contract Violation: `ALIGN` macros are invoked with non-power-of-two inputs, computing garbage values.

No blockers.  Please read below for more details.

> --
> 
> commit f2a479c4ed9e6eb22e5e61615eb62f684e1703b1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
>     
> This commit removes the power-of-two validation for min_region_sz in
> damon_reclaim_apply_parameters(). The change relies on the assumption
> that identical validation in damon_start() and damon_commit_ctx() is
> sufficient to catch invalid parameters.
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 11b70d0a9a6f0..6469b25cc34f9 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -208,11 +208,6 @@ static int damon_reclaim_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > -	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > -
> 
> [Severity: High]
> By removing this early check, does an invalid addr_unit now proceed to call
> damon_set_region_system_rams_default() before damon_commit_ctx() rejects it?
> 
> If so, could this permanently corrupt the global monitor_region_start and
> monitor_region_end parameters on the error path?
> 
> For example, damon_find_system_rams_range() scales and overwrites these
> global pointers before the context validation has a chance to fail:
> 
> mm/damon/core.c:damon_find_system_rams_range() {
> 	...
> 	*start = damon_res_to_core_addr(arg.res.start, addr_unit);
> 	*end = damon_res_to_core_addr(arg.res.end + 1, addr_unit);
> 	...
> }

Users can show and correct it.  And this happens only when the user entered an
invalid parameter.  No bad consequence like kernel panic happens.  So, this is
just a minor user experience issue.  And I want to make validation mminimum for
simplicity.  This minor issue doesn't deserve to add the complexity in my
opinion.  I will keep this as is unless others chime in.

> 
> [Severity: Medium]
> Additionally, if we allow a non-power-of-two min_region_sz to be passed
> downwards, does this violate the requirements of the ALIGN macros?
> 
> When damon_set_regions() processes the temporary target structure:
> 
> mm/damon/core.c:damon_set_regions() {
> 	...
> 	start = ALIGN_DOWN(ranges[i].start, min_region_sz);
> 	end = ALIGN(ranges[i].end, min_region_sz);
> 	...
> }
> 
> Since ALIGN relies on bitwise operations, won't passing a non-power-of-two
> min_region_sz result in garbage address calculations?

Yes, but anyway it cannot be committed due to the validation in the commit.  No
bad consequene like kernel ppanic happens.  So no issue.

> 
> >  	if (!damon_reclaim_mon_attrs.aggr_interval) {
> >  		err = -EINVAL;
> >  		goto out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705155600.96555-1-sj@kernel.org?part=4


Thanks,
SJ

[...]
