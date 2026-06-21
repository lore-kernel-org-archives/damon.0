Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB322E3F0
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782074160; cv=none; b=NfE6NI+13QKxWZ0hTQZJ5naDooVN2o+RjgZ5NJ/DqBGG/Yvn4SDb/0M655NJSKWX3CgeRoBTOT47NzAG77paRFvnEaVnph7o231ADG57Mr1zwlkwRInGHJknoItGMMMz6Sqq9fVqzNUl+RVjfvdH+fbr+leJbdMZtVZnf/ZAwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782074160; c=relaxed/simple;
	bh=tAw4ZRRtFhb7v8DliWVlMdcis+pjZbbQuZhOppEqGrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+IWV4vG5nZoWI8sLRoNRvp0QkYuomfTt1hzmEz0fK4ppzmt9Z01vCsNniK76Fd8GapJIOq8MAfjer96PniJlfaUEVEI39J3rKpPhaFeSdLxBTYrF/nRxLi5M3ok1CB4ysdHQUsSNKhWGJazo57MCTRq3JHs4B0mO+wsAKxur0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLcVJL9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLcVJL9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7FC1F000E9;
	Sun, 21 Jun 2026 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782074159;
	bh=yir/PHL9eQvhs0P+GyalT/DKl3DSIz9UeD+Qdf64vzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLcVJL9LFpVeVTrcOSxRAnCQGmboyvAacJ9IE6flLJAmXX8GKhAshEn+UGMIjtcYj
	 kmJ4EfYBtAvZj2Kp79ASOMd7s44Mb+20MICq4wDUW8bxZ3ugUww/Q8o6NMgJB7/DKI
	 IbFrZMuUx85/NaWnxWN2NngvjvbpRfe09xSdsbBlJMru9iJJSI4gCKN9jEErYhzuLr
	 Z4y/SZSPqJ2kDKLQK6DHWavGG7kD7zX5YgJrkm7ZVrYWCsxteSRDMsDJlAvgCAN1n2
	 dFKHxgNJ9OyQkdSUfv7EE833IrFzEvnhf1Iw9qLmZyNb41YV+aDtqnhrgVb4tSti99
	 IwjdoP/qrRjLg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 09/17] mm/damon/core: remove damon_verify_merge_regions_of()
Date: Sun, 21 Jun 2026 13:35:47 -0700
Message-ID: <20260621203548.10718-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621180955.442ED1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 18:09:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing size-weighted averaging for `last_nr_accesses` upon region merge causes erroneous age resets and corrupted metrics.
> --
> 
> commit 6d81112ae07520e7dd1deaeaf23912d17d4d8a57
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: remove damon_verify_merge_regions_of()
> 
> This commit removes the damon_verify_merge_regions_of() validation check.
> The nr_accesses_bp field is no longer used for a real purpose, making this
> validation unnecessary.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ee19238d62f5f..94d8ec2965451 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3114,20 +3114,6 @@ static void damon_merge_two_regions(struct damon_target *t,
> >  	damon_destroy_region(r, t);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does damon_merge_two_regions() need to
> calculate a size-weighted average for last_nr_accesses alongside nr_accesses
> and age?
> 
> Currently, when two adjacent regions are combined, last_nr_accesses appears
> to be omitted from the averaging logic, causing the newly merged region to
> strictly inherit the left region's history.
> 
> Because kdamond_merge_regions() iterates its merge loop until the region
> limit is satisfied, a region merged in the first iteration will be evaluated
> again in the second iteration:
> 
> mm/damon/core.c:damon_merge_regions_of() {
>         ...
>         if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
>                 r->age = 0;
>         ...
> }
> 
> Since r->nr_accesses was size-averaged but r->last_nr_accesses was not,
> this comparison evaluates against mismatched data. Could this frequently
> cause it to erroneously reset r->age to 0?
> 
> If so, this seems like it might break DAMON schemes that rely on region age
> (such as pageout schemes meant to reclaim cold memory) by continuously
> resetting the region's age. It might also skew policy frequency scores in
> damon_nr_accesses_mvsum() if damon_set_attrs() is called from a user context
> before the aggregation interval resets.

Good finding, but not necessarily a blocker of this series.  I will separately
work on this.


Thanks,
SJ

[...]
