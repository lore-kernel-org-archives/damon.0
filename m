Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CD3074AE;
	Tue, 24 Jun 2025 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804397; cv=none; b=Vx6OiMXAcmqCYJZfZz55U/cq+uV4KyNJAdOplS5g2TOjXaF528swqgbTLSuwK1bttYviy9Dz2cNOb+n4dgDnBQrMM9dNudY3PyGE/7PbpaZUdlCJxGk5+cISz59gzXaqOZM9UktwIEpIAKNczx3vCijnRKiQZzxHRX/nT3ecWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804397; c=relaxed/simple;
	bh=qqsLtwIT4qxU4K+cteeeR4I1NfXqbVh6Rfi797SclZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAPBIxanqy84vAjnFmjs3kCcA1lKUOmjt0VTEumrmV4j0Rih7Gz7upBp/yPDm8xLx++3rAy6uAs6ZeOyJRnejyugjhgnm0WiA2LzrXHxMgUjF7GC6x/e6FjIaVvMosAq3DzhKTpfTAOfAQ1biFSlhPZNrNYbBok50jn/spxt174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0QHymvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0QHymvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DAFC4CEE3;
	Tue, 24 Jun 2025 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750804397;
	bh=qqsLtwIT4qxU4K+cteeeR4I1NfXqbVh6Rfi797SclZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0QHymvcqE8bSbo7a5ZCaMfLocL+lI+alJWG0sqJkDMvGi6LhGUwJKwraLqve24Uo
	 7/PCOIGj/vWYPyFWNRddNsV9e03cPmkfTNQBX1/6KS2XQuKDuHuS9q6b3/7EGDBv7P
	 hKgbr0LUnRUJsZ6waCkiwPVdOLWNa8SSsmXCnogDGXTATykPWYdetghtMu/3HPdqom
	 LYwQRKjHqtt+pzQhlBwJmes7/f3qUQQWkV8HAen2ElHn9HWQ4XzvcSgwEuygzEJpxw
	 L1daQvdO44f2/uXvqF6kVXiK2r94ZqW2zIX/sxkaeUZW+MxLAmnMcdxiEmdveK+v/I
	 thc8y2Zh9IDyA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
Date: Tue, 24 Jun 2025 15:33:08 -0700
Message-ID: <20250624223310.55786-1-sj@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAMvvPS5kgOJtb6U+9TwEqSDYn0R2FG6rAPWjS98hAdHr4jkKbg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 24 Jun 2025 11:01:46 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Mon, Jun 23, 2025 at 7:34 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 23 Jun 2025 18:15:00 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > [...]
> > > Hi SeongJae,
> > >
> > > I really appreciate your detailed response.
> > > The quota auto-tuning helps, but I feel like it's still not exactly
> > > what I want. For example, I think a quota goal that stops migration
> > > based on the memory usage balance gets quite a bit more complicated
> > > when instead of interleaving all data, we are just interleaving *hot*
> > > data. I haven't looked at it extensively, but I imagine it wouldn't be
> > > easy to identify how much data is hot in the paddr setting,
> >
> > I don't think so, and I don't see why you think so.  Could you please
> > elaborate?
> 
> Elaborated below.
> 
> > > especially
> > > because the regions can contain a significant amount of unallocated
> > > data.
> >
> > In the case, unallocated data shouldn't be accessed at all, so the region will
> > just look cold to DAMON.
> 
> "Significant" was too strong of a word, but if physical memory is
> fragmented, couldn't there be a non-negligible amount of unallocated
> memory in a hot region? If so, I think it would mean that you cannot
> simply take a sum of the sizes of the hot regions in each node to
> compute how the hot data is interleaved because those regions may
> contain unallocated memory that shouldn't count for that calculation.
> Does that make sense?
> 
> It's very possible I might be overthinking this and it won't be an
> issue in practice. It might be best to not worry about it until it
> becomes an issue in practice.

So, I understand this is not a problem for only this migration-based
interleaving approach, but general DAMON accuracy on physical address space.

I agree.  DAMON's region-based mechanism provides only best effort results, and
depending on the workloads, virtual address space based monitoring has chances
to work better than physical address space.  Whether the accuracy level is
acceptable or not would depend on use case.  What I can say at the moment is,
there are use cases of physical address based DAMON, and we are working further
for making it better.  Recent monitoring intervals auto-tuning was one such
efforts.

> 
> > > Also, if the interleave weights changed, for example, from 11:9
> > > to 10:10, it would be preferable if only 5% of data is migrated;
> > > however, with the round robin approach, 50% would be.
> 
> Elaborating more on this:
> Imagine a process begins with a weights of 3 and 2 for node 0 and 1
> respectively in both DAMON and the weighted interleave policy. If you
> looked at the which node a page resides in for a group of contiguous
> pages, it would be something like this (using letters to represent the
> virtual addresses):
> 
> A -> node 0
> B -> node 0
> C -> node 0
> D -> node 1
> E -> node 1
> F -> node 0
> G -> node 0
> H -> node 0
> I -> node 1
> J -> node 1
> 
> If we use a user defined quota autotuning mechanism like you described
> in [1] to stop DAMON interleaving when we detect that the data is
> interleaved correctly, no interleaving would happen, which is good.
> However, let's say we change the DAMON weights to be 4:1. My
> understanding is that DAMON applies the scheme to regions in ascending
> order of physical address (for paddr schemes), so if using the
> round-robin algorithm you provided in [2], the interleaving would
> apply to the pages in node 0 first, then node 1. For the sake of
> simplicity, let's say in this scenario the pages in the same node are
> sorted by their virtual address,
> so the interleaving would be applied
> in the order ABCFGHDEIJ. This would result in the following page
> placement
> 
> A -> node 0
> B -> node 0
> C -> node 0
> D -> node 0
> E -> node 0
> F -> node 0
> G -> node 1
> H -> node 0
> I -> node 0
> J -> node 1
> 
> So, four pages, D, E, F, G,  and I, have been migrated. However, if
> they were interleaved using their virtual addresses*, only pages D and
> I would have been migrated.

Thank you for this kind and detailed explanation.  Now I can understand your
concern.  To my understanding, one of the important assumptions on the example
is that pages of the DAMON region are sorted on both virtual address space and
physical address space.  I'm not very sure if that is a reasonable assumption.

Hence, in such virtual address-randomly mixed DAMON region cases, I think
physical address based approach could work better than when virtual
address-sorted case, and sometimes even make less migration than virtual
address-based case.  For example, let's say we found a DAMON region of 6 pages
in node 0.  And the virtual address-based interleaving targets of the 6 pages
are all node 1, while physical address-based interleaving target nodes are 3
pages for node 0 and other 3 pages for node 1 (weights 1:1).  Then virtual
address-based interleaving does 6 migrations while the other one does only 3
migrations.

So both approach has worst case scenario, and my gut feeling is that this might
not result in big difference as long as careful scheme aggressiveness control
is made (whether using quota auto-tuning or manual online DAMON parameters
tuning).  Of course it would be nice if we have good test results.

Meanwhile, assuming the DAMON regions on the physical address space may have
pages of random virtual addresses, I find another concern about the behavior
from users' perspective.  In my opinion, commonly expected behaviors for the
interface we are working together is, "DAMON will migrate pages of the regions
of the access pattern to give NUMA nodes with given weights." If there is a
DAMON region having random virtual addrss page, and the virtual address-based
target node selection results in a target nodes ratio that is different from
the user-specified weights (like above example of 6 pages), I think users could
be confused about the results.

To go in this direction, I think the interface should clearly explain the
behavior.  I should confess I concern even in the case, if the behavior is
unnecessarily complex for users and developers.

Alternatively, if we go fully virtual address based approach (monitor on
virtual address and operate with virtual address), I think the behavior would
be optimum and easier to expected by users.

> 
> * Technically, the mempolicy code interleaves based on the offset from
> the start of the VMA, but that difference doesn't change this example.
> 
> > > Finally, and I
> > > forgot to mention this in my last message, the round-robin approach
> > > does away with any notion of spatial locality, which does help the
> > > effectiveness of interleaving [1].
> 
> Elaborating more on this.
> As implied by the comment in [3], interleaving works better the finer
> grained it is done in virtual memory. As an extreme example, if you
> had weights of 3:2, putting the first 60% of a process's data in node
> 0 and the remaining 40% in node 1 would satisfy the ratio globally,
> but you would likely not see the benefits of interleaving. We can see
> in the example above that your round-robin approach does not maintain
> the desired interleave ratio locally, even though it does globally.

I'm not very agreed if keeping the ratio process-locally is always beneficial.
At least when people use DAMON in the physical address space, I'd assume their
concern is global memory bandwidth control.  And hence I imagine they would
care about the global ratio more than local ratio.

I agree there could be a case users care about process local ratio, though.  In
the case, I feel using virtual address based mode sounds more natural, unless
there is other reason to use physical address space mode.

> 
> > We could use the probabilistic interleaving, if this is the problem?
> 
> I don't think so. In the above example, with probabilistic
> interleaving, you would still migrate, on average, 20% of the pages in
> node 0 and 80% of the pages in node 1. Similarly, the probablistic
> interleaving also does not consider the virtual address, so it
> wouldn't maintain the interleave ratio locally in the virtual address
> space either.

Right.  But if the DAMON region is having random virtual address pages, it
wouldn't always result in the worst case.

> 
> > > I don't think anything done with
> > > quotas can get around that.
> >
> > I think I'm not getting your points well, sorry.  More elaboration of your
> > concern would be helpful.
> 
> I elaborated more above. Hopefully that clears up any confusion. If
> you still have questions, maybe it would be easier to e-meet and have
> a live discussion about it? I see you have a DAMON chat slot open
> tomorrow at 9:30 PT [4]. If you have nothing else scheduled, maybe
> that would be a good time to chat?

Nice suggestion, thank you.  For readers of this mail other than I and Bijan, I
and Bijan made an appointment for this off list.

> 
> [...]
> 
> > > I see where you're coming from. I think the crux of this difference is
> > > that in my use case, the set of nodes we are monitoring is the same as
> > > the set of nodes we are migrating to, while in the use case you
> > > describe, the set of nodes being monitored is disjoint from the set of
> > > migration target nodes.
> >
> > I understand and agree this difference.
> >
> > > I think this in particular makes ping ponging
> > > more of a problem for my use case, compared to promotion/demotion
> > > schemes.
> >
> > But again I'm failing at understanding this, sorry.  Could I ask more
> > elaborations?
> 
> Sure, and sorry for needing to elaborate so much.

No worry, thank you for walking with me.

> 
> What I was trying to say is that in the case where a scheme is
> monitoring the same nodes it is migrating to, when it detects a hot
> region, it will interleave the pages in the region between the nodes.
> If there are two nodes, and assuming the access pattern was uniform
> across the region, we have now turned one hot region into two. Using
> the algorithms you provided earlier, the next time the scheme is
> applied, it will interleave both of those regions again because the
> only information it has about where to place pages is how many pages
> it has previously interleaved.

You're correct, if we don't use a nodes imbalance state based scheme tuning 
approach.  With the approach, but, this will not happen?

> Using virtual addresses to interleave
> solves this problem by providing one and only one location a page
> should be in given a set of interleave weights.

Even in the case, DAMON will do rmap of the pages.  Even if it is entirely
virtual address mode, rmap walking is not needed, but DAMON should still
iterate each pages.  For large systems, that might be not negligible system
resource.  I think even if we use virtual address based target node selection,
or entirely virtual address mode, that kind of imbalance status based scheme
tuning could be beneficial.

> 
> When a scheme is monitoring one set of nodes and migrating to another
> disjoint set of nodes, you don't have this problem because once the
> pages are migrated, they won't be considered by the scheme until some
> other scheme moves those pages back into the monitored nodes.

Not technically, in my opinion.  In the tiering scenario, we have two schemes
migrating ho/cold pages to each other node.  Without quota or very good
hot/coldness thresholds, unnecessary pingpoing can happen.

> 
> Does that make sense?
> 
> > >
> > > > If you really need this virtual address space based
> > > > deterministic behavior, it would make more sense to use virtual address spaces
> > > > monitoring (damon-vaddr).
> > >
> > > Maybe it does make sense for me to implement vaddr versions of the
> > > migrate actions for my use case.
> >
> > Yes, that could also be an option.
> 
> Given how much my explanations here stressed that having access to the
> virtual addresses solves the problems I mentioned, I think the path
> forward for the next revision should be:
> 
> 1) Have the paddr migration scheme use the round-robin interleaving
> that you provided - This would be good for the use case you described
> where you promote pages from a node into multiple nodes of the same
> tier.

If you will not use that, I don't think you need to do that.  Let's work for
only our own selfish purposes ;)  I believe that is a better approach for long
term maintenance, too.

> 2) Implement a vaddr migration scheme that uses the virtual address
> based interleaving - This is useful for my target use case of
> balancing bandwidth utilization between nodes?
> 
> If the vaddr scheme proves insufficient down the line for my use case,
> we can have another discussion at that time.
> How does this sound to you?

I find no concern at fully virtual address based approach off the top of my
head.  And if you think it will work for you and you will use that, I think
this is the right way to go.  I also think based on our previous discussion,
this could work for your and other's multiple use cases.

We still have a few conflicting opinions about physical address monitoring
based approach.  I love having the discussions with you.  But I don't think
those can be blockers of 2).  So to me, 2) seems the right way to go.

> 
> > > One thing that gives me pause about
> > > this, is that, from what I understand, it would be harder to have
> > > vaddr schemes apply to processes that start after damon begins. I
> > > think to do that, one would have to detect when a process starts, and
> > > then do a damon tune to upgrade the targets list? It would be nice if,
> > > say, you could specify a cgroup as a vaddr target and track all
> > > processes in that cgroup, but that would be a different patchset for
> > > another day.
> >
> > I agree that could be a future thing to do.  Note that DAMON user-space tool
> > implements[1] a similar feature.
> 
> Thanks, I'll take a look at that.
> 
> [...]
> 
> Thanks again for the time you are spending on these discussions. I do
> appreciate it, and I hope I'm not taking up too much of your time.

I also appreciate your time and patience.  I see we are near to the alignment,
though, please bear in mind!


Thanks,
SJ

[...]
