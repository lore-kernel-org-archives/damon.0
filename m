Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881C33688B
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781883; cv=none; b=rC640OLzBPcRSyaQ+++2gWFX2c5MXeEckHue8TALexsrKKSH0vyS9yRBqitGpyEqQrixdiZooz7QB7oX6bphSRZ3ODWixA8GiChOE8B2G9lYIwtlPPpdMRTnHOib+K7CtjkVDB8MaW3NQj4AU1mOpL1TtIJbGocF6Q+2tw3gibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781883; c=relaxed/simple;
	bh=LnpTJIirvRjxesU0mciflnFYm/drNP2x11AmIBr4kEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrbfoqFs9gnXS8hKh8/lrK+nCnl7RiF4VSwBZ8n6OooTP+TrU4/R2fFDc8LHA4oSc0dzO2sx5sGjFm5i9F1IbJbpWh/JTLCyhO+XCA51X511jeBmH5DBdDDpNtp6uaXT2k0VRjXM2I8OE0mXKipHZMqDOMH5V82hX+5Nddo49Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI5Q3P+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI5Q3P+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BCC1F000FF;
	Sat, 19 Sep 2026 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781881;
	bh=e1BUJQ/abwTQIiNzlnUTAOXVGHza7H4pq3J/+2VAeZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MI5Q3P+4i3t1+rQ8/THcXljV1mQV+ko4J76eosWwPE9Z56O9HEYxtE7OuSVikXgcD
	 RyeKUgrV3wGeIAKKQyZemDbpeVqLxJXT5kjBQxRUUVcG0ItvEwpTzHLX+22kVTjAxR
	 JH40StXr7VhyiQaP0kFEzfgn5i8kadYaw5/MbkltoJO+C7+HF+BvfqT0jwHnJrDpai
	 9t/AO4uZfyFWy23Y2YyttdaqLOeUwByjqhPBGy5R8okXEiEq7qm4wCFKkG8xi211oG
	 NtTJdyP2TJvHt/dAY1u53k9OdddHey1qaabVUfpTGxhhJAABnzqv2MKP6fs0HjN1sT
	 ExsIe1Sib+ciA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/7] mm/damon/sysfs-schemes: support quota goal complement flag
Date: Fri, 18 Sep 2026 18:37:47 -0700
Message-ID: <20260919013749.89856-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919012635.E49A41F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 01:26:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: integer underflow in DAMOS_QUOTA_SOME_MEM_PSI_US complement calculation
> --
> 
> commit cd02e1bd14a7884bf9a21f0cab584b1a0f9992ce
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: support quota goal complement flag
> 
> This patch adds a new sysfs file for the quota goal directory to allow
> setting and getting the quota goal metric complement flag value.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 06af417bc9a2f..8f083611741fd 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -2869,7 +2898,8 @@ static int damos_sysfs_add_quota_score(
> >  		if (!sysfs_goal->target_value)
> >  			continue;
> >  
> > -		goal = damos_new_quota_goal(sysfs_goal->metric, false,
> > +		goal = damos_new_quota_goal(sysfs_goal->metric,
> > +				sysfs_goal->complement,
> >  				sysfs_goal->target_value);
> >  		if (!goal)
> >  			return -ENOMEM;
> 
> [Severity: High]
> Now that complement = true can be configured via sysfs, does this expose
> an integer underflow in damos_set_quota_goal_current_value()?
> 
> If a user configures a DAMOS quota goal using DAMOS_QUOTA_SOME_MEM_PSI_US
> with complement = true, the actual elapsed wall-clock time between
> evaluations can exceed the configured s->quota.reset_interval due to
> routine thread scheduling delays or high system load.
> 
> In mm/damon/core.c:damos_set_quota_goal_current_value(), the accumulated
> PSI time (goal->current_value) could then exceed reset_interval * 1000,
> underflowing the unsigned subtraction:
> 
> 	if (goal->metric = DAMOS_QUOTA_SOME_MEM_PSI_US) {
> 		goal->current_value = s->quota.reset_interval * 1000 -
> 			goal->current_value;
> 		return;
> 	}
> 
> Unlike the basis-point metrics below it, this lacks a safety bounds check.
> The unsigned integer underflow results in an erroneously massive quota score.
> 
> This causes damon_feed_loop_next_input() to evaluate score >= goal * 2 and
> return the minimum possible input (min_input), severely throttling the quota
> size (esz) to a minimal value.
> 
> This effectively disables DAMOS scheme actions for that window, despite the
> system being under severe memory pressure, which is exactly when tuning
> is most important.

I will fix in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260919011359.88921-1-sj@kernel.org?part=3
> 


Thanks,
SJ
