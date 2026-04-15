Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987B31E859
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224216; cv=none; b=Eea4Xt+IFQ89M/scuDUFT84CtQfzuTqPXI3l89GnUaZN+MxfuEO9qjQVUxcrefSAURYlrHVIn2zkGuk9zRfGu7XDFPb2EhAZS7TBj7GoRCsUiQizBL8S7wfefW/FBw/W13P/PCUctjjhj4vEXrpmNASdzstUyYLDiAyt4NOOVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224216; c=relaxed/simple;
	bh=DQU94YiGQqYU5wQ6ulGPg1j5vHgepHaiH3UZGa6/YFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhnPH5Tvtm+HiUxmeyOC32+pMCHw5ww2qgE39cHGk9EO/A6dqVktFmNNicHXXpwn2bWXx82m34FMZFsqrrE69mnISYx82vq+Bts+wXIzQh5ZM9vED+e8D59Q/vdBhSAvuSexj0fkAfPNrjrLi8H1XXLwiPIY0VLoJGO8MITtoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElZsjQcQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElZsjQcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC1BC2BCB3;
	Wed, 15 Apr 2026 03:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776224215;
	bh=DQU94YiGQqYU5wQ6ulGPg1j5vHgepHaiH3UZGa6/YFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElZsjQcQOi1DKvLxC4Ummr9zUQ7pCDmv5ljHYeUuZ2mxQi8mq/YOQhHoF3X/aXDM2
	 nExt3ImvO+df+isbaTVjuVvAMsYq/PIkz24q5IQd2sqPSYrohsolbU5Y47obqi4trG
	 mGJCWll3e+YYCbrCtum8pvehHbkvqR1fgQmrRPHfRxQOBX/HR1hdh9BCcTirU0y6l0
	 ZXlRBTchrM/6wMl/aVEruNk0LGLUKvbOPSlriBT1GpYcxTPi9dDOPNvqIisOrunpGv
	 +5KzIWHNmXHtA3mk5ooCo+AkPjgMcbYHWohhnRTuvNK09hOHj/LR3mElj6vozdWpZf
	 MwQzvzDmgWbtg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/7] mm/damon: introduce damon_set_region_system_rams_default()
Date: Tue, 14 Apr 2026 20:36:44 -0700
Message-ID: <20260415033647.77164-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415013553.43E4EC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TL; DR: Sashiko found no real issue of this patch.

On Wed, 15 Apr 2026 01:35:52 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] Creation of a single bounding box region for all System RAM severely degrades monitoring accuracy on sparse memory topologies by including non-RAM holes.
> --
> 
> commit 8f8f43643f81a1ce41ad12d7eb7416faa6e23114
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon: introduce damon_set_region_system_rams_default()
> 
> This commit introduces a function to set the default target region to
> cover all System RAM resources instead of just the largest one. It finds
> the start of the first resource and the end of the last resource, and
> sets this bounding box as the target region.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 12544c60531d3..91e14caa4f6a1 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > +static int damon_system_ram_walk_fn(struct resource *res, void *arg)
> > +{
> > +	struct damon_system_ram_range_walk_arg *a = arg;
> > +
> > +	if (!a->walked) {
> > +		a->walked = true;
> > +		a->res.start = res->start;
> > +	}
> > +	a->res.end = res->end;
> > +	return 0;
> > +}
> [ ... ]
> > +int damon_set_region_system_rams_default(struct damon_target *t,
> > +			unsigned long *start, unsigned long *end,
> > +			unsigned long addr_unit, unsigned long min_region_sz)
> > +{
> > +	struct damon_addr_range addr_range;
> > +
> > +	if (*start > *end)
> > +		return -EINVAL;
> > +
> > +	if (!*start && !*end &&
> > +		!damon_find_system_rams_range(start, end, addr_unit))
> > +		return -EINVAL;
> > +
> > +	addr_range.start = *start;
> > +	addr_range.end = *end;
> > +	return damon_set_regions(t, &addr_range, 1, min_region_sz);
> 
> Could this create a single bounding box region that includes large non-RAM
> holes on systems with sparse memory layouts?
> 
> Since damon_system_ram_walk_fn() only records the minimum start address and
> maximum end address across all System RAM resources, creating a single
> contiguous damon_addr_range from this bounding box includes any
> intervening address gaps.
> 
> On multi-socket NUMA systems or devices with large MMIO holes, this
> could result in massive address ranges not backed by actual RAM. Because
> DAMON uniformly samples random addresses within each region, sampling
> might predominantly hit these unbacked memory holes.
> 
> Would this dilute the access sampling and cause actively used memory to be
> incorrectly classified as cold? Should the code gather discrete System RAM
> ranges into an array of struct damon_addr_range and pass them to
> damon_set_regions() with nr_ranges > 1 to exclude holes?

This is true.  But it shouldn't cause real problems because of the adaptive
regions adjustment mechniasm of DAMON, as also mentioned on the cover letter.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260415012048.76508-1-sj@kernel.org?part=1


Thanks,
SJ
