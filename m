Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4C5B1EB;
	Sat, 14 Mar 2026 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451878; cv=none; b=EssTzTjfco/p3FMrbdg00h6Y2trSJmv1eg337k8Ert9XRNCCrpmjAmGfVTimTS/a9bf7CqhDtfi9T40DyYEPZPXRacgVvmgMIVvwefbHizkcpu71MDdMq0YahXm2frQox5rE7ozCf0owMTvvGr45KABHFoOOOz1WhrkhQEziovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451878; c=relaxed/simple;
	bh=KcINNhRmCzgBqiFRq849ArmBY3HgveYIGaJwxHKXNKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQaQerKFtJ4ltlciUu2u87ykHNMW8Q9L67MdT9pLqcAWroyx2zyt5UQ2N9AzlZPCx+OSPozmJjJPgG77f/X5ZIC3OIqyhih+24tOucYvduLPvTSlybAo1K95+S6ccWGEKtArVbg+SEIfiUL61p41jEgAZcbL7jQkQ0TvR+TeQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrW+/VpV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrW+/VpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB56C19421;
	Sat, 14 Mar 2026 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773451878;
	bh=KcINNhRmCzgBqiFRq849ArmBY3HgveYIGaJwxHKXNKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrW+/VpVDYa4Y4kADKjIk06IN3657d8SutcoPhVwmNIYQFXxrLeVVTIm8SvFEk13x
	 +dOJunD/D+WQH6cwAMk9EhHx+zQyjxewHl4tyz7Ve2yMgwNBUXpkVSqOYgx884rfGa
	 L5TTlAItxUuPCzUPr57hPl/NbncTJRtLO9bDQ8p9xfbYBAVxOcs8xopzB7pOsYlSQx
	 aiXBkqQwXcXMaCNLe72FE5Xx91HwPuJt2wUj1+tAA7tfw4xFwYWbJQhq0iYLBYdSuY
	 RoJC0tb6+pwMMYqne7lemfaZr8C1PI1DSbCZLVsJK/t2AJeHyTx4CwZLMMLlDsGhUN
	 8N1a/CT7hgnyA==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] mm/damon: introduce perf event based access check
Date: Fri, 13 Mar 2026 18:31:13 -0700
Message-ID: <20260314013115.81177-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umygtmi_rHUbayYn=EMFg=0ztZH1ot73KzsaHTy+yk-a=Qw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Mar 2026 16:35:55 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年3月11日(水) 9:51 SeongJae Park <sj@kernel.org>:
> >
> > On Mon,  9 Mar 2026 10:00:03 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > DAMON currently only provides PTE accessed-bit based access check, this
> > > patch series adds a new perf event based access check.
> > >
> > > Since perf event-based access checks do not require modifying the PTE
> > > accessed-bit for pages representing each damon region, it reduces the
> > > overhead of monitoring at a fixed granularity of the page size.
> >
> > Based on my understanding of this patch sereis that I was enlightened from the
> > conversation with you on the RFC v1 and kind comments from perf community, I
> > agree to the points of this patch series.  Extending DAMON with h/w features
> > like AMD IBS and Intel PEBS is what multiple people shown interests.  I believe
> > it can benefit multiple users.
> >
> > I hope this work to be continued until it is landed on the mainline, and I will
> > be happy to help.  Probably not exactly in the current shape, though.  I think
> > this is still in an early stage.  And for the reason, I will comment on only
> > high level things here, rather than diving deep into each patch.
> 
> Thank you for your helpful comments.
> I will continue to work on this project.

Glad to hear that :)

> 
> > > Furthermore, this patch series also includes a feature that allows you
> > > to set a minimum region size for each target, enabling you to monitor
> > > at any fixed size greater than the page size for each target.
> >
> > I'm not very sure if this is really required to be a part of this series.  Can
> > you further share more details about what is the benefit of this feeature, and
> > if it should be coupled with this patch series?  It would be great if you can
> > share some test results proving the arguments.
> >
> > If this is really beneficial but there is no reason to couple with this series,
> > I think merging this separately first or later could also be an option.
> 
> Indeed, this patch can be submitted separately.
> 
> The purpose of access monitoring with a fixed granularity greater than
> the page size is to reduce overhead when the total size of the memory
> region being tracked is large.

This sounds bit strange to me, because DAMON's upper-bound monitoring overhead
is proportional to the user-set maximum number of regions, not the total
monitoring memory size.

> 
> Also, we want to be able to track hugepage sizes for some targets, so a minimum
> region size setting is provided for each target.
> For example, when memcached is started with the --enable-largepages option,
> it will attempt to use THP.

This is again sounds not very completely easy to understand to me, since
adaptive regions adjustment will converge to work in THP granularity in the
case.

Maybe you want to monitor virtual addresses in fixed granularity, but use
different granularity per target?  You could do the fixed granularity
monitoring by setting the min_nr_regions and max_nr_regions same to the total
size of monitoring memory divided by the desired granularity size.  But maybe
this is challenging for your use case, because you use 'vaddr', which
dynamically changes the total monitoring memory size depending on the process's
memory mapping status?

You can also do different granularity monitoring for different virtual address
space by using different DAMON contexts per the target process.  But I guess
you're saying it is not a good user experience?

If so, that makes more sense to me.  But, I think user-space helpers could help
you overhauling the challenges.  I'm curious if you tried that, and found it is
really uncomfortable or too suboptimal.  If so, sharing the experience and/or
test results in more detail will be very helpful.  Maybe we can do this discuss
in more detail on the separated patch, though.

> 
> > >
> > > Using these features also requires modifications to damo, but these are
> > > not included in this patch series and are currently under development in
> > > the following branch:
> > >
> > > * https://github.com/mita/damo/tree/damo-perf-for-v3.1.8
> >
> > Sounds good.  No rush, but also feel free to send patches or PRs for this.  It
> > is common to support DAMON features on DAMON user-space tool even before the
> > DAMON features are merged into the mainline.
> >
> > >
> > > Any feedback or advice on the patch set would be greatly appreciated.
> > >
> > > * v2
> >
> > Let's keep using "RFC" here.
> 
> OK.
> 
> > > - reintroduce damon_operations->cleanup()
> > > - introduce struct damon_access_report
> > > - use struct damon_access_report instead of introducing struct
> > >   damon_perf_record
> >
> > Thank you for doing this.  I hope using not only the struct but the underlying
> > infrastructure, though.  Let me comment this more detail below.
> >
> > > - remove maximum region size setting
> > >
> > > * v1
> >
> > Ditto.  Let's keep using "RFC".
> >
> > > - https://lore.kernel.org/damon/20260123021014.26915-1-akinobu.mita@gmail.com/T/
> >
> > Thank you for sharing the link.  This is helpful for me at reviewing.
> >
> > >
> > > * TODO
> > > - Currently, it is possible to unintentionally specify a perf_event
> > >   that cannot obtain either PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR
> > > - Check if it works in a virtual environment using vPMU
> >
> > The above two TODOs make sense to me.
> >
> > I'd like to request below things as main TODOs.
> >
> > First, I hope the benefit of this change is described in more detail.  The
> > current description mentions it is more lightweight since it doesn't need to
> > update the accessed bit.  But, PMU-based monitoring should also have its own
> > additional work.  It would be nice if you can describe what additional works
> > for PMU-based monitoring induce, and why it is generally lower than that of
> > access bit modification.
> >
> > Having a more clear motivation, or expected use case would be nice.  You don't
> > neeed to share real details of your use case.  You can anonymize sensitive
> > things if needed.  But giving a reasonable and realistic use case will be nice
> > to understand where this can really be beneficial.
> >
> > Sharing a test results showing the benefit will also be very nice.  It doesn't
> > need to be huge real world test, but some reasonable amount of data that
> > collected on a realistic test setup could be very helpful.
> 
> All of the TODOs you suggested are useful.  I will try to share the test
> results and comparisons with access bit based cases.

Great, looking forward to!

> 
> > Second, I hope this patch series to reuse the DAMON primitives extension
> > infrastructure if possible, to reduce possible future duplications.  I'll add
> > more details about this below.
> >
> > >
> > > Akinobu Mita (6):
> > >   mm/damon: reintroduce damon_operations->cleanup()
> >
> > Thank you for doing this :)
> >
> > >   mm/damon/core: introduce struct damon_access_report
> >
> > Again, thank you for doing this.  I understand this is an answer to my previous
> > question to the RFC v1 of this series.  I was asking if you considered the
> > infrastructure part of my page faults based DAMON extension series, and you
> > borrowed the main data structure of the series here.  But, I hope us to reuse
> > more of the code, since it is more generic from my point of view.
> 
> The plan was to start by reusing structures and gradually make use of
> infrastructure.  Now, I have a better understanding of your DAMON
> extension series
> and have no major concerns about migrating to it.

Great.  Nonetheless, I expect you might find devils in the details while coding
it.  Please bear in mind and don't hesitate at asking my help.  I tend to be
wrong a lot and learn from mistakes. :)

> 
> > >   mm/damon/core: add common code for perf event based access check
> >
> > This patch is introducing a few of sysfs files under DAMON sysfs context
> > directory, namely 'perf_events/' and its underlying files.  The files is for
> > registering perf events for the access monitoring.  I don't dislike the basic
> > concept, but concerned if it is too specific for only perf events and therefore
> > cannot be easily extended in future.
> >
> > The faults-based DAMON extension patch series [1] implements files for similar
> > but more general concept.  It defines a concept called sampling primitives.  It
> > is the low level primitives for access check.  It could be access bit checking,
> > page fault event, or something new, like perf events.  It adds
> > monitoring_attrs/sample/primitives/ sysfs directory, which can be used for
> > selecting what primitives the user wants to use.  I think perf events can be
> > defined as another access check primitive, and the sysfs files can be added
> > under here.
> 
> I agree.
> 
> > I was also bit concerned at the fact that the filees are effectively exposing
> > perf_event_attr struct.  That is, I was concerning about stability of the
> > struct.  I now see it is a part of linux user api, so I assume it is a stable
> > api.  Could you please confirm this?  Also, adding more clarification about
> > that fact on the patch would be nice.
> 
> Since `perf_event_attr` itself is an argument to the `perf_event_open()` system
> call, I think future compatibility will be maintained, but I also have some
> concerns about whether the interface provided by this patch is optimal.
> 
> Also, as mentioned in the TODO section, there are currently almost no
> restrictions on the PMUs that can be specified, so it is possible to register
> PMUs that are completely useless for perf event-based access checks.

I agree to this concern.

> I have one idea under consideration, and I plan to address it when I send out
> the next patch series.

Sounds good, looking forward to the next version.

> 
> > >   mm/damon/vaddr: support perf event based access check
> > >   mm/damon/paddr: support perf event based access check
> >
> > My understanding of the above two patches is like below.
> >
> > 1. The perf event samples are added to a circular buffer whenever it is
> >    generated.
> > 2. At the end of each sampling interval, the ops reads each sample in the
> >    buffer, find a matching DAMON region for the sample, and updte the
> >    'nr_accesses' of the region.
> >
> > For this, this patch series implements the circular buffer for storing samples,
> > and xarrays for finding the matching DAMON region for a given sample.
> >
> > The page fault based DAMON extension patch series is doing something similar.
> > The first patch of the series implements the buffer for storing access samples.
> > I think the perf event samples can be stored here.
> >
> > The seventh patch of the series implements the logic for finding the matching
> > DAMON region for each of the samples in the samples buffer, and update the
> > 'nr_accesses' of the DAMON region.
> >
> > Because the page fault based extension's infrastructure is quite general for
> > any future types of the primitives, I think it would be nice to reuse it.
> >
> > The infrastructure is quite simple and not optimized for performance.  But
> > optimizations can be made later.  I'm more interested in the long term
> > maintenance of the interface.  And I think the page fault based extension's
> > infrastructure is easier for long term maintenance.  Of course I might be
> > biased.  Please let me know what you think.
> >
> > If it helps and if you don't mind, maybe I can try to implement this series on
> > the page fault based infrastructure and share it as another RFC patch series.
> 
> I'm starting to get a vision of how to incorporate this as sampling primitives,
> but if you try implementing it and share your results, it would be extremely
> helpful.

Ok, I will try to make it in a dirty but fast way and share asap, probably
within 2-3 weeks.

> 
> > >   mm/damon: allow user to set min size of region
> >
> > As I mentioned abovely, I'm not sure if this is really need to be coupled with
> > this entire series.
> 
> I'm happy with this patch, as it's much simpler than the last one for RFC v1.
> Next time, I'll send them separately.

Nice, looking forward to it!


Thanks,
SJ

[...]
