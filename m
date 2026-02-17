Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3D2441A6
	for <damon@lists.linux.dev>; Tue, 17 Feb 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341350; cv=none; b=WtP/o1DKehsJobkfdkVS5ULDS1WTuyyAJkpFc7AWtKXQF5gTGb7pVmBkMUTueITsLXmU+LWYaQpaEaYkBPP6RPbPRb4cuo23QFAUSuwDigKK6zC55PmuX//0CZsSkF0XEwQl02DxXSUwYGtptbZcqcM9VbxF6Vc7ZTAh2T81cWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341350; c=relaxed/simple;
	bh=MjiioraSJxbsTlui/p8keToiKztIBGtT3UEyB1osHUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKItIPKdjZnbkEtiuaN7zjlDiCRxOC3iI1n1gHPkBsBgBm3thNS5ZZl/Fg/0TZE931h7NOzzWXEZubDHN/j8ETfVzYY2CnzpHy2asmC7DQICX3kDHddf3XL+lU6+phjLWwm9KJ9PxXUhOM4mntRb+WmJBFKQdXdYLCeKZsfB5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVR30+dA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVR30+dA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3380C4CEF7;
	Tue, 17 Feb 2026 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341349;
	bh=MjiioraSJxbsTlui/p8keToiKztIBGtT3UEyB1osHUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVR30+dAntKTyRSukyz9KzauksPJf88hAw4I2OiwR5DHNjfo7E6Cpsu7V4KerzGMP
	 Vheu6O9zacX7eeSfqctonFBM7ymwZzZFOOHm7NiGshwEapJUP/DFy6l8k/NgyOn4dD
	 lAX8Sue2r5g/1yLAavWQSZWLu3PO8WTus4MO6thP9zYRELxVJehTs0RNHfmuLWN8up
	 QkJQxl7PTbHJUyg3kuC7KSNrFQv992royDMJowIvYfzFUInAIyBYK3msI8HRWw3Gm5
	 yemKd1+e0Iv6iunyEv8KNF6Kp4CIQwEbEnE8jkY5cIbyWkzGv3s+rHaTH51tOfOKvY
	 RxDJ8JPBwTqUA==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Tue, 17 Feb 2026 07:15:44 -0800
Message-ID: <20260217151545.77290-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umygPq8+FQWTG73-QPOKHT1P5=N2+qFkrRfZAkL_7G=gQXQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 17 Feb 2026 22:32:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年2月17日(火) 9:13 SeongJae Park <sj@kernel.org>:
> >
> > On Tue, 27 Jan 2026 17:12:23 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Tue, 27 Jan 2026 21:56:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > >
> > > > 2026年1月27日(火) 15:43 SeongJae Park <sj@kernel.org>:
> > > > > Actually DAMON is internally setting such maximum region size based on the
> > > > > min_nr_regions parameter, via damon_region_sz_limit().  Nonetheless, the limit
> > > > > is applied only in regions merge time.  That's why it requires the regions
> > > > > split to happen sufficiently until the real fixed granularity monitoring is
> > > > > started.
> > > > >
> > > > > And I think this behavior is just a bug, or suboptimum implementation at least.
> > > > > That is, users set the minimum number of regions but it may not really be kept.
> > > > > That's definitely confusing behavior.  Actually there was a similar case that
> > > > > number of regions can be larger than the max_nr_regions.  We fixed it, with
> > > > > commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
> > > > > max_nr_regions is unmet").  I think we discussed about similar case for
> > > > > min_nr_regions, but I cannot find the discussion for now.
> > > > >
> > > > > So, I think it is better to fix this rather than introducing a new parameter.
> > > >
> > > > I agree with that.
> > > >
> > > > > Maybe we can split regions based on the min_nr_regions based size limit, before
> > > > > starting the main loop of kdamond_fn().  Similar to the max_nr_regions
> > > > > violation, there could be yet another corner case on online parameters commit
> > > > > situation, so it would better to check the case, too.  You could implement such
> > > > > fix on your own, or let me do that.  In the latter case, if you don't mind, I
> > > > > will add your Reported-by: tag to the fix.  Please let me know your
> > > > > preferrence.
> > > >
> > > > You'll be better able to fix it, so please fix it at your convenience.
> > > > Adding Reported-by: tag is fine.
> > >
> > > Sounds good, I will do so!
> >
> > I just posted an RFC patch series [1] for this.  I will drop RFC tag after the
> > current merge window is finished.  Please let me know if you find something
> > wrong there!
> >
> > [1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org
> 
> Thank you for posting the patch series.
> 
> I tried it and found that patch 2/3 made things worse than before in terms of
> monitoring at page size granularity.

Thank you for sharing the test results!  

> This is because, in my evaluation, new
> target processes are added without stopping kdamond, so processes added later
> are not initially monitored at page size granularity.

Nice catch.  But, the min_nr_regions based region split of vaddr was triggered
by damon_va_init(), which is called before the kdamond_fn()'s main loop.  How
the regions were split before the patch?  Probably I'm missing something.
Could you please clarify?

> 
> Would performing a split operation like damon_apply_min_nr_regions() within
> damon_set_regions() solve the problem?

Yes, that's the plan.  The split operation should be done for online updates of
total size of monitoring regions and min_nr_regions.  I'm preparing a followup
patch series for that.  While working on it, however, I found it requires some
refactoring and cleanup that taking time longer than I expected.  Meanwhile I
was thinking your issue is only at the beginning of kdamond, and I didn't want
to make you wait too long.  Hence posted the series first.


Thanks,
SJ
