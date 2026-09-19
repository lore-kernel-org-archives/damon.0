Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB912931D3
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781792; cv=none; b=u6ZF3XKbkl3S9arxYr6LSpSGxTAANwNvp4xWtQCxigzlBhTqA6wptcHiEMP/TXRYcsQXsZfSPoTYgIgSdV8QrlllyQ9gtYjkt/4fu2iDFoES1Rc9JP2/c7QB6B0KCi9E3ZuafRZRFmQAuVjJlEOYJMwQ11ykJKuwNbnWHH0fq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781792; c=relaxed/simple;
	bh=+kGKG445nyvAiGYIIY0i2EtQeVZDHmPPBiWyA4tsmOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdURp5RCn6Ka9p2DaaltnM7B2iriYRuGnXYu0PpuRsrFPWYETU2cbT6+JxUzXG560JjCsZcsG0YURmsuWKoRNaKiC46wb9i5AkUYo6Mz/1foQHHfEHBiz1KBwIbLx8vkNsBiFJY7E/RRHegN285Cw6U4SFL/ySNvEo0+qtfXv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ2TDPc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ2TDPc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3AC1F000FF;
	Sat, 19 Sep 2026 01:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781790;
	bh=HQnxngAbYvXUK/VgBaHHVp3UZxOzVIXS06Zg0ub2+UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZ2TDPc761nXVx++Z+Cir5fZqWv/D9PaoZ2kBjqWc02J6KBfEs+l2/g/tXqJUKPyp
	 v00z1agTJDCrtxn+8wk6oRt6BbTkkYJD6DrQqjAWjlPx8TKKsAXse/2VSNRSvrfdyH
	 bfvEIhRuHVxktDwC9hiPLbSD5SHlXCXJD+UoovleJpioWmXabM7wTlJzNRfdxb9YUz
	 p2MPrClpuXwjWZyhfreyrJdx9Q7Lo6WNW9g+BjGRa45G9Jp/5i7GTi/Jg96rIzP2WR
	 9JanaDL5iAPml0Cgzmbqu7V8s1/UHruLpJk5Mo6K05Qjz8K72JtESnxKspFfHMIVl9
	 Mao0zzq5oUobQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/7] mm/damon: add complement argument to damos_new_quota_goal()
Date: Fri, 18 Sep 2026 18:36:22 -0700
Message-ID: <20260919013623.89644-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919012327.DA7141F00898@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 01:23:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] mm: damon: hardcoded false complement flag when cloning quota goals
> --
> 
> commit 9116ea6f94ac9ade4ef359ba8351ef835957bf80
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon: add complement argument to damos_new_quota_goal()
> 
> This commit extends the damos_new_quota_goal() constructor to accept and
> set the 'complement' flag value. It also updates all API callers to use
> the new signature, which aims to prevent mistakes where the complement
> flag was previously set manually.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 9fd08cbfacd8c..932ca3ad0e593 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1262,8 +1263,8 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
> >  	damos_for_each_quota_goal_safe(src_goal, next, src) {
> >  		if (j++ < i)
> >  			continue;
> > -		new_goal = damos_new_quota_goal(
> > -				src_goal->metric, src_goal->target_value);
> > +		new_goal = damos_new_quota_goal(src_goal->metric, false,
> > +				src_goal->target_value);
> 
> [Severity: Low]
> Does this code discard the 'complement' flag from 'src_goal'?
> 
> By hardcoding 'false' here instead of passing 'src_goal->complement', the
> copied goal initially loses its complement state. While it appears
> damos_commit_quota_goal() immediately overwrites the flag with the correct
> value, passing 'false' defeats the purpose of the explicit constructor
> argument and could create a brittle pattern.

Makes sense, I will fix this.

> 
> >  		if (!new_goal)
> >  			return -ENOMEM;
> >  		err = damos_commit_quota_goal(new_goal, src_goal);
> 
> [ ... ]
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 5ff0436c58441..bba97ad449110 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -929,7 +929,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
> >  		 * damos_commit_quota_goals() will kfree() the dst goals.
> >  		 * Make it kfree()-able.
> >  		 */
> > -		goal = damos_new_quota_goal(dst_goals[i].metric,
> > +		goal = damos_new_quota_goal(dst_goals[i].metric, false,
> >  				dst_goals[i].target_value);
> 
> [Severity: Low]
> Does this discard the 'complement' flag from 'dst_goals[i]'?
> 
> Hardcoding 'false' instead of passing 'dst_goals[i].complement' might
> break future tests that attempt to verify complemented goals, as the
> destination goals in the test framework will lose their intended complement
> state.

Nice catch, I will fix this.

> 
> >  		if (!goal)
> >  			goto out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260919011359.88921-1-sj@kernel.org?part=2
> 


Thanks,
SJ
