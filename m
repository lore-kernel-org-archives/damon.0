Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4800F4F1
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395345; cv=none; b=WaHKdPBFYrhP5TNWyDe8gYd1xpvo+ATl5sgCuvJpsZZzbAoP3JGWf4mdU+FhXcKCOry8a+D9cMpUE+9B5w9WReeg8vUsyo8OpLTo7O3xv0M4nIUyFTJE5+/Zu/9nHQQPtLFBz8SFxavLzJ/WSwztSdK3HCxfCFjW7lWFwZDdyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395345; c=relaxed/simple;
	bh=0nsY8qdPm6jR37RCpvnMjgz3rDYzal32QB7ViYX9VXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxO+t9qKHWeAhA9hpbm6CCr9g0sCJVmkROo7GBAnG+06xjJh3mAbqGX3pnjVv06W5bsaqdxzHN/BW+7spZVrFyinVLVrZ8C1AAtDzc/UpCg2MBkF4pWCw/S10b1RA/YvfnmPExBgJgExRh7NKpe3ukr4S/QEHSvcVOJRwhRHWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohaUPE3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohaUPE3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3EE1F000E9;
	Tue,  7 Jul 2026 03:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783395344;
	bh=1LCg/k50UjORn44apEAf64sbEfvKpdWQIT5coWulB9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ohaUPE3Nu0OgJoAuu/zN1j9AdCMMnVojP5RCpRqT9jy6ngCkgpGAX6X+xPRwq0Ggu
	 Koj6k5ErUllzqqgCps9kc6YS6lSd1LepOaM/cIxDnakOWu7xhFPn5dBvVUcKBjmr75
	 57CKeLaqS/AbwopfPz+ReUYoamJLASbgrMKNRwk1mswCgsgCox1DSBCjWc7/0y1vR3
	 SD0rWh6VbniQn075kvdFXsPs5cWE1hKPuaQ3lBg4yTFOpSyFbnOFkLJgQhoLG9HmFD
	 WZBUjaSEOqC/sTywmz/yfLaVdjPO8jVjwxrJ7ly25wTQ9+gPYFZ+Pl1fZEJpyECqB3
	 5pJvPiz6ywcpg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 11/16] mm/damon/core: get merge threshold from probe hits when weights are set
Date: Mon,  6 Jul 2026 20:34:47 -0700
Message-ID: <20260707033448.91993-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707000330.97519-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  6 Jul 2026 17:03:28 -0700 SJ Park <sj@kernel.org> wrote:

> On Mon, 06 Jul 2026 15:18:01 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] Region merge loop terminates prematurely because `max_thres` is unscaled for probe hit weighted sums, causing a failure to respect `max_nr_regions`.
> > - [High] Adding probe weights to contexts using operations without `apply_probes` (e.g., `vaddr`) silently breaks all monitoring.
> > --
> > 
> > commit f896f3e81bf75b446b16cb4f79f6673a154b512b
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/core: get merge threshold from probe hits when weights are set
> >     
> > When probe weights are set, DAMON merges regions based on their probe
> > hits weighted sum.  But the merge threshold is calculated based on the
> > access frequency.  Update it to retrieve the maximum probe hits weighted
> > sum in the snapshot from apply_probes() ops callback, and generate the
> > threshold based on it.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index be026c86384e4..fa78d8d592aa3 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > [ ... ]
> > > @@ -3726,9 +3727,18 @@ static int kdamond_fn(void *data)
> > >  
> > >  		if (!access_check_disabled && ctx->ops.check_accesses)
> > >  			max_merge_score = ctx->ops.check_accesses(ctx);
> > 
> > [Severity: High]
> > Does setting probe weights on a context that lacks an apply_probes callback
> > (like vaddr) silently break monitoring here?
> > 
> > If a user sets probe weights via sysfs, access_check_disabled will be true.
> > This skips check_accesses(), but since apply_probes is NULL, neither callback
> > runs. The accesses are never updated, and all memory appears completely cold.
> 
> I was initially thinking this is no blocker.  But, since the core layer params
> validation patch series is merged into mm-new, fixing this should be simple,
> and we don't really need to rush for this series.  I will fix this in the next
> spin.

I changed my mind.  There are many features that supported by only specific
DAMON ops implementations.  We allow setting such configuration, and later add
supports if needed.  It is arguable, but I think keeping the consistency is the
right thing for now.  I will keep this behavior unless someone argues
differently.


Thanks,
SJ

[...]
