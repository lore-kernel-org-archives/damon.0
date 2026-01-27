Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BB7080E
	for <damon@lists.linux.dev>; Tue, 27 Jan 2026 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496220; cv=none; b=jiwCNO6S1krZykIOi3CeDbfIojFTynSJQCV7IvcAyd1kEZo9XZC3nyuVAe9DfnEwusLRAI3fVOy6Yjg19LxXQPvONcHNVEpGS4ORT2NICM6rqJFNScDCplgTPoqy0hMuTylShzpavcJDj+Lj8YMTD5qI4nByxDjk3goxh+Vy4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496220; c=relaxed/simple;
	bh=/DzgU3fhnLV9VNqNBiy/YO6B1OMx+Dl218i1yhXY6zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzKYH9TZG8Ch3y9RTThBXmDuydI4kxTBxmVLOGqhxEKqBNQ/9lOOhq4+29gx/BCjOEjNA/P6cIOiRkYFHR9TmahQ7yVLXgSEUux8kqTHAkd1U9zs25YYsbm/aaGIniP4ZRtz9YFMqZh/fRO9xA4wXlxMn0jPJ3DTDYvm7xZedTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Insm5wNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Insm5wNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F110C116C6;
	Tue, 27 Jan 2026 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769496220;
	bh=/DzgU3fhnLV9VNqNBiy/YO6B1OMx+Dl218i1yhXY6zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Insm5wNmX/QyvJdjJEV6Jx/mwLrJ61lu5syOFoT3c9/IAAqSvBw+CPbn2dVuZBT9E
	 3SeLK7FwjkDk8nNzpONR6gydexjlxW+X+hWByjFQ0eAS3fmstaHP5P3hA2rnmZxtOX
	 LvVfCzpmWC2K6Aaz0VIz9i64YguCihFaaHIg9SEuguw1XfXB2+YmAEUo7ZzvH+hxbC
	 1uFfQMZkVE0nsCkgWFELGl8C+5tw/tFFaIfQGkCa4HsJIyBM5wQoDLNAw3D4tgLheV
	 tEG0mk7wRwsACqTdfL30IBmG+QvIWbivzP0wvtny079bNPkw+Z/IpgusGF+G3xBYJc
	 c6SthgOw3m0/Q==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Mon, 26 Jan 2026 22:43:36 -0800
Message-ID: <20260127064338.67909-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 27 Jan 2026 10:29:53 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年1月24日(土) 11:39 SeongJae Park <sj@kernel.org>:
> >
> > On Fri, 23 Jan 2026 11:10:10 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > DAMON currently only provides PTE accessed-bit based access check, this
> > > patch series adds a new perf event based access check.
> >
> > Very interesting patch series.  Thank you for sharing this Akinobu!
> >
> > I only took a glance on the patches, but my understanding is that this series
> > modifies DAMON to be able to enable perf events of PERF_SAMPLE_ADDR type, and
> > utilize the sampled perf events in the perf events buffer as the source of
> > DAMON's access checks.  In more detail, I understand enabling PERF_SAMPLE_ADDR
> > type perf events makes the perf events buffer filled with memory access event
> > information with the access destination address.  The event will be sampled
> > based on time (e.g., one access event per X milliseconds).  And probably that
> > sample data could include more information includign the CPU and the process
> > that executing the sampled access?  Please correct me if I'm wrong and add more
> > details I'm missing, as my understanding of perf event is very poor.
> 
> Your understanding is correct.
> 
> One thing to note is that you need to specify a PMU event that can
> obtain the data address at the time of sampling.
> 
> In other words, it must be a PMU that can be used with "perf mem record".

Thank you for confirming and adding the detail.

> 
> > And one quick question.  Can this work on virtual machines?  I'm asking this
> > question the for following reason.  I'm actuaally working on a similar project
> > that extends DAMON for page fault based access events sampling [1].  The
> > project aims to use page fault event rather than other h/w features such as AMD
> > IBS or Intel PEBS, because my understanding is that such h/w features are not
> > available on virtual machines.
> 
> I haven't tried it on a virtual machine yet.
> As mentioned above, if "perf mem record" works on a virtual machine,
> you can specify its PMU, but it may not be supported at all.

Seems that's the case at least for my setup. :'(  On my QEMU-based machine,
'perf mem record' fails like below.

    $ sudo perf mem record
    failed: no PMU supports the memory events

Nevertheless, I think there should be users who want to run this on different
setups.

> 
> > > Since perf event-based access checks do not require modifying the PTE
> > > accessed-bit for pages representing each damon region, this patch series
> > > also includes a feature that allows you to set upper and lower limits on
> > > the damon region size to enable access checks with finer granularity.
> >
> > I was also thinking about extending DAMON with AMD IBS or Intel PEBS like h/w
> > features for this kind of sub-page granularity access monitoring.  So this
> > makes sense to me, and sounds useful!
> >
> > >
> > > Using these features also requires modifications to damo, but these are
> > > not included in this patch series and are currently under development in
> > > the following branch:
> > >
> > > https://github.com/mita/damo/tree/damo-perf-for-v3.1.0
> > >
> > > Any feedback or advice on the patch set would be greatly appreciated.
> > >
> > > Akinobu Mita (4):
> > >   mm/damon/core: add common code for perf event based access check
> > >   mm/damon/vaddr: support perf event based access check
> > >   mm/damon/paddr: support perf event based access check
> >
> > I find your patches are introducing new infra code for this extension.  It
> > seems bit specialized for perf event only, though.  I'm concerned if future
> > extension for another access check primitives cannot reuse the infra.
> >
> > My DAMON extension project [1] is for page fault based access monitoring, but
> > it also introduces a framework for general multiple access sampling primitives.
> > I'm wondering if perf event based extension can be implemented using the
> > general acces ssampling primitives infra code, and if you already considered
> > that but found it is not feasible.
> 
> If such infrastructure code exists, I would like to use it, so I will
> consider it.

Great.  Please take a look and let me know if you have any questions about
that.  The current implementation of the infra is only for proof of the
concept, so it may lack documentations and quite suboptimal.

> 
> > >   mm/damon: allow user to set min and max size of region
> >
> > The min size setup makes sense.  I understand the max size is for disabling the
> > regions adjustment (merge/split) mechanism.  IOW, for fixed granularity
> > monitoring.  Users can do that by setting min_nr_regions and max_nr_regions
> > same [2], though.  So, max size setting seems not really needed.
> 
> Yes, if fixed granularity monitoring is possible then that is sufficient.
> 
> I have tried setting min_nr_regions and max_nr_regions to be the same.
> I understand that the region split progresses over time and results
> in fixed-granularity monitoring at the minimum region size, but since
> my configuration has a relatively long sampling interval, it takes
> time to reach that state.

Ok, that makes sense.  Thank you for explaining the issue.

> 
> So in the patch, when adding a new region with damon_set_regions(),
> it will be split by the maximum region size.

Actually DAMON is internally setting such maximum region size based on the
min_nr_regions parameter, via damon_region_sz_limit().  Nonetheless, the limit
is applied only in regions merge time.  That's why it requires the regions
split to happen sufficiently until the real fixed granularity monitoring is
started.

And I think this behavior is just a bug, or suboptimum implementation at least.
That is, users set the minimum number of regions but it may not really be kept.
That's definitely confusing behavior.  Actually there was a similar case that
number of regions can be larger than the max_nr_regions.  We fixed it, with
commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
max_nr_regions is unmet").  I think we discussed about similar case for
min_nr_regions, but I cannot find the discussion for now.

So, I think it is better to fix this rather than introducing a new parameter.
Maybe we can split regions based on the min_nr_regions based size limit, before
starting the main loop of kdamond_fn().  Similar to the max_nr_regions
violation, there could be yet another corner case on online parameters commit
situation, so it would better to check the case, too.  You could implement such
fix on your own, or let me do that.  In the latter case, if you don't mind, I
will add your Reported-by: tag to the fix.  Please let me know your
preferrence.

> 
> > Again, great RFC patch series, thank you for sharing!  I'm looking forward to
> > your answers to above high level questions and comments.
> 
> Thank you so much for checking out the patch.

The pleasure is mine, and hope this patch series to get more forward progress!


Thanks,
SJ
