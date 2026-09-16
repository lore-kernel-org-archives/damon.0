Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C9378D8C;
	Wed, 16 Sep 2026 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519379; cv=none; b=c6k/rZ0zWgW6cr57KGDmpYCC1WHPJ26eU3xbTiPhCNi1GFU5blyxVDxP4T0otAMIQL+2jd1puH4acEVnSR+vOZoJxOaluB2EguY+/IEAiAtQbYCSXHGhB9dp9kfuM69NrpcYKUH7qCyt8f4AQv/+95QeuyduPAPNAExTM48IqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519379; c=relaxed/simple;
	bh=M79rNXIuCXBavZscdTkcVfTLyKvWAUxuMw6XfalyHPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogjLCBSSdQqaISP7HP0igXujMqDD4Fl7D0jDGUYi8QHOlBRyUTHTePEK9xR6IMG0TyNbbzMUv+uPY5yzJAz6oxCPirD6SJEoMnsUnZin8MUcW3SX4Gh1U+v7dEeNY4Pyv5R6vN3Gbt88oW5aaknS5d/vBW3d0qL1mI+GEHhsU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwoU/MyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwoU/MyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ED11F000FF;
	Wed, 16 Sep 2026 00:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519358;
	bh=lSFqgIB/QkG8NNxRnnvdrACKkHikqffoikxUFlVJO+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iwoU/MyHU5H3ffHp5R6u8BJl2K2nKRPi4E6PniVHazaizPYr0Aqt3zBS8+NI2rCRv
	 7X65gQjc+rdA63Vu9rhQiTWwVKJC/2y5wzUdcurQ5CZIsXikvkhE4hu0kWufoWww15
	 1XUqlm1jBYClQqcaGA9+g4sVOOBwsdkmxmEoHwpwOc+25kylVsfulDQR51cOw0xlue
	 xODeWztXJi4Mi5s9J/g4W42nzhg19DCGaA++Rf4rJTlNcQuWH6ztDUfTbWGOrKbNmM
	 8eoeHDXRSbJB19rBoKj9xJjXtoEtnS8XFGoPGid8mGlAwFcQnZGsIela4PIGHQiAoF
	 NN8jt0mOG4VOg==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports
Date: Tue, 15 Sep 2026 17:42:28 -0700
Message-ID: <20260916004230.101408-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y17GK7TQHA5FyoMdnOFM1Y38g7P9qc-nMgP-dO4zfRj8Ug@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 14:23:02 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Fri, Sep 11, 2026 at 6:38 PM SJ Park <sj@kernel.org> wrote:
> >
> > Hello Ravi,
> >
> > On Thu, 10 Sep 2026 10:16:14 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > This series lets DAMON take its access information from a hardware sampler
> > > instead of from a page-table scan, and lets a scheme's score be weighted by what
> > > that sampler reported.
[...]
> > First of all, thank you very much for sharing this great series.
> >
> 
> Thanks SJ for the detailed review and the milestone 2 / phase 3 clarifications.

Glad to hear that!

[...]
> > > What running it
> > > across vendors needed on top of that direction is:
> > >
> > >   - per-CPU lockless rings between the NMI sample handler and the kdamond drain,
> >
> > I understand we need to make it lockless.  I wonder if we have to make it
> > per-CPU.  I understand it will be better in terms of performance, especially on
> > machines having many CPUs.  That said, this feels like somewhat we can discuss
> > in phase 3.  And it would deserve to have sufficient discussions and
> > performance evaluations.
> 
> The per-CPU structure is not a performance optimization we can defer -- it
> is required by the calling context.  A perf-event overflow handler runs in
> NMI context, which cannot take a mutex or any sleeping lock.
> damon_report_access() takes a mutex, so it cannot be called from there.

Thank you for clarifying, Ravi.  But, what I wanted to say is, we could update
damon_report_access() to not use mutex but atomic operations.  Does that make
sense?  FYI, damon_report_access() will also be renamed, say,
damon_report_attr().

[...]
> Understood.  I included the page-fault source in v2 because the December
> 2025 RFC [1] that introduced damon_report_access() had it as the primary
> consumer, and I wanted to carry forward that ability.  Since it is out of
> scope for milestone 2, I will drop it from v3.
> 
> Patches 1, 2, and 3 will be dropped from the v3 submission since they are
> all tied to the page fault path.

Makes sense, thank you!

> 
> >
> > >   - per-CPU events that follow CPU hotplug, armed when the kdamond starts and
> > >     disarmed and drained when it stops,
> > >   - a per-PMU owner, so two contexts cannot claim the same PMU type,
> > >   - whichever address a PMU does report carried on the report and matched
> > >     against the context's own address space, so one source serves a paddr or a
> > >     vaddr context without a backend per address space.
> >
> > These all soudns making sense to me.  Nonetheless, I think we can scope
> > milestone 2 to support only physical address and defer these things to the
> > phase 3.
> >
> 
> Got it. Will scope v3 to PA only. so included results for v3 would be based on
> AMD IBS testing.

Sounds good!

> 
> > >
> > > This is tested with PEBS on Intel and IBS on AMD, both configured as `perf_event`
> > > attributes on a probe and using the perf core's event plumbing rather than
> > > per-vendor MSR code.  A third source has already been written against the same
> > > ring: Kunwu Chan's ARM SPE backend [5], which reaches it through an AUX buffer
> > > drained in process context instead of an overflow callback, and which the
> > > roadmap [2] places in its third milestone.
> >
> > Awesome, appreciate your huge effort on this!
> >
> > >
> > > The partitioning is what lets promotion and demotion run in one context.  A
> > > sampler says which regions are hot; it says nothing about which are cold, because
> > > a sampler that reports nothing about a page cannot distinguish untouched from
> > > unsampled.
> >
> > I'm not really sure.  I think absence of samples for an address range can also
> > mean the address range is cold?  Actually the page table accessed bit based
> > monitoring also use a sort of sampling, so I don't show real distinction.
> >
> > Maybe you're right, but I think this deserves sufficient discussions and
> > testing that we could defer to the phase 3.
> >
> > > Region age is what a demotion scheme matches on, and age comes from
> > > the page-fault primitive.
> >
> > We would have age in perf event based mode, too.  Isn't it?
> >
> 
> You are right.  Region age accumulates whenever nr_accesses stays at zero
> across aggregation boundaries, and that holds whether the zero comes from a
> PTE scan or from an empty perf-event drain.
> 
> I was initially concerned that a sparse sampling PMU might not cover every
> cold region in every aggregation window, leaving silence that could be
> mistaken for cold,
> whereas page faults provide higher spatial coverage for confirming
> first-access.  Having both together was intended as a defence against that gap.
> 
> Based on your observation I retested this on hardware.  On AMD Turin
> the cold demotion scheme found and demoted the idle working set
> correctly using only the hardware-sampled IBS signal -- nr_accesses aged to zero
> for regions that genuinely had no traffic, and the scheme acted on age as
> expected.  The combined design may still be worth exploring later when
> page fault
> is considered to be reintroduced in phase 3.

Sounds good, thank you for the testing Ravi!

> 
> > > With the ring partitioned by class both are live at
> > > once: the probe supplies hotness, the primitive supplies age, and two schemes
> > > over the same regions can move memory in both directions under one kdamond.
> >
> > Unless the needs are clearly confirmed, I'd prefer having single class for
> > simplicity.
> >
> 
> With the page fault primitive out of scope there is no case for two ring
> classes.  I will prepare v3 with a single class.

Sounds good!

[...]
> > >   4. `mm/damon: add damos_node_eligible_mem_bp tracepoint` -- a per-tick
> > >      tracepoint over the node-eligible-memory quota goal evaluation, exposing
> > >      the goal's target and current values, so the loop a bandwidth-driven
> > >      controller steers is visible to a tracer.
> >
> > This seems doesn't need to wait anything.  If this turned out to be helpful,
> > please feel free to separately send patches for this.
> >
> 
> Yes. It is quite useful to track goal convergence. Will send a single patch
> targeting mm-new.

Looking forward to the patch!

[...]
> Summary of what v3 will contain (5 patches, former patches 5-9 of v2):
>   - paddr-only, single ring class, no page fault primitive
>   - per-CPU rings retained (required by NMI calling context, not an
>     optimization)
>   - perf-event overflow handler (paddr path, vaddr parts deferred to phase 3)
>   - sysfs/lifecycle surface
>   - probe-weighted score
>   - kunit tests updated for the simplified scope

Makes sense.  And regardless of my global ring idea, feel free to keep the
per-CPU rings.  As long as it is an RFC, please feel free to implement it in an
easy-to-implement way.

Please also note that I'm still working on shaping the milestone 2
deliverables.  I'm not yet in a stage that I can share how it will really look
like.  So the final version of your work might need a significant amount of
change to rebase on it.  I will also try to make it not unnecessarily delayed
more than our planned timeline.  But please bear in mind with me.

> 
> Separate send targeting mm-new:
>   - tracepoint (former patch 4)

Looking forward to it.

[...]
> [1] RFC PATCH v3 00/37: mm/damon: introduce
> per-CPUs/threads/write/read monitoring
>     https://lore.kernel.org/damon/20251208062943.68824-1-sj@kernel.org/


Thanks,
SJ

[...]
