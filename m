Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8B2472A0;
	Mon, 23 Jun 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701127; cv=none; b=lK1v82dDOUrXWZD5S4CfpL3lVxNjFksYFOWkXOf17H+KRJfMLabWBw6XgRpcZhdQ5tTZeDLXvyf53i+L+3i74YRPAlBO9WVN9GE4yJzPej7eG3FANIprMEy6uxJSWJFZF79HBWbG5ndxEHPPXoVkG7HT/Ywaat9pSLA0+Lf+Yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701127; c=relaxed/simple;
	bh=p/gKN8Tu3R0Zs5HrvxYXD6gKw7ejc6XSA7qOeDkbRno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBAH/VRkQ+vd7WwY0kEnU7rBkx8RV1W7q7qg+RJ+zd/Lu5lByFWkM/oJ4TAEaRYa9nF2OKSh18qr+aY/IC0qhFP+H7peNzPNPHQZzFZDIHpMhJYqaSxQOt51qpqKX6wmHl0rtGUeacxXAtBFo7hhCM14xvsJQMGpPNzYk+GBj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcLURrWX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcLURrWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8366C4CEEA;
	Mon, 23 Jun 2025 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750701126;
	bh=p/gKN8Tu3R0Zs5HrvxYXD6gKw7ejc6XSA7qOeDkbRno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcLURrWX9DPjPH8jYAODJNJrme5Pjg5BG2ZCr2jFmb9Qb/+UNZYqxO8reQbhEd3s9
	 qZUuBP1HzoCLbna/5okZpJtod2Soo9w/S1nWbg0MPRrjWKIn/5AQiCRNgwqA471QCv
	 UH46652LvD6bsImx6TsoAE6iJJ8Uapi4qSa3uuZKpx0Cr6RQAxAsXUgDy9cCCHIwuF
	 SOMggD4m3TZny6vcznH2YGLtN8zuWcylQkUbeKxGYBm3t67XSfZCbKdmNwNaBXmo/Z
	 IFvFDwqQM53K8zArPxYrMPXkQ5KAe1T/6G+dO4WtL4yyFgEAlYwhxl4+MUuCUdNaZo
	 2LJzsRQnkVcXA==
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
Date: Mon, 23 Jun 2025 10:52:04 -0700
Message-Id: <20250623175204.43917-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS5JL20OJic0EFKbuY_VgEAjveJoquTReyLjknSZ-6BeVQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 09:16:53 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Sat, Jun 21, 2025 at 1:02 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Bijan,
> >
> > On Fri, 20 Jun 2025 13:04:58 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > From: Bijan Tabatabai <bijantabatab@micron.com>
> > >
> > > The migrate_{hot,cold} DAMONS actions take a parameter, target_nid, to
> > > indicate what node the actions should migrate pages to. In this patch,
> > > we allow passing in a list of migration targets into target_nid. When
> > > this is done, the mirgate_{hot, cold} actions will migrate pages between
> > > the specified nodes using the global interleave weights found at
> > > /sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functionality
> > > can be used to dynamically adjust how pages are interleaved in response
> > > to changes in bandwidth utilization to improve performance, as discussed
> > > in [1]. When only a single migration target is passed to target_nid, the
> > > migrate_{hot,cold} actions will act the same as before.
> > [...]
> > >  include/linux/damon.h    |   8 +--
> > >  mm/damon/core.c          |   9 ++--
> > >  mm/damon/lru_sort.c      |   2 +-
> > >  mm/damon/paddr.c         | 108 +++++++++++++++++++++++++++++++++++++--
> > >  mm/damon/reclaim.c       |   2 +-
> > >  mm/damon/sysfs-schemes.c |  14 +++--
> > >  samples/damon/mtier.c    |   6 ++-
> > >  samples/damon/prcl.c     |   2 +-
> > >  8 files changed, 131 insertions(+), 20 deletions(-)
> >
> > If we keep pursuing making DAMON users be able to specify multiple migration
> > destination nodes and their weights[1], I think we may need only paddr.c part
> > change of this patch in the final version of this great work.
> 
> Sounds good to me.
> 
> > [...]
> > >  static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> > >               unsigned long *sz_filter_passed)
> > >  {
> > >       unsigned long addr, applied;
> > > -     LIST_HEAD(folio_list);
> > > +     struct rmap_walk_control rwc;
> > [...]
> > >
> > >       addr = r->ar.start;
> > >       while (addr < r->ar.end) {
> > > @@ -522,15 +599,38 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> > >               else
> > >                       *sz_filter_passed += folio_size(folio);
> > >
> > > +             /*
> > > +              * If there is only one target node, migrate there. Otherwise,
> > > +              * interleave across the nodes according to the global
> > > +              * interleave weights
> > > +              */
> > > +             if (nr_nodes == 1) {
> > > +                     target_nid = first_node(s->target_nids);
> > > +             } else {
> > > +                     target_nid = NUMA_NO_NODE;
> > > +                     /* Updates target_nid */
> > > +                     rmap_walk(folio, &rwc);
> > > +             }
> >
> > So we are doing rmap_walk(), which is known to be not very fast, for getting
> > the target node id of this page, in a way very similar to that of weighted
> > interleaving, right?  I don't think we really need to behave that same to
> > weighted interleaving with the cost.
> >
> > I'd hence suggest to implement and use a simple weights handling mechanism
> > here.  It could be roud-robin way, like weighted interleaving, or probabilistic
> > way, using damon_rand().
> >
> > The round-robin way may be simpler in my opinion.  For example,
> >
> > unsigned int damos_pa_nid_to_migrate(struct damos_migrate_dest *dest)
> > {
> >         static unsigned int nr_migrated = 0;
> >         unsigned int total_weight = 0;
> >         unsigned int weights_to_ignore;
> >         size_t i;
> >
> >         for (i = 0; i < dest->nr_dests; i++)
> >                 total_weight += dest->weight_arr[i];
> >         weights_to_ignore = nr_migrate++ % total_weight;
> >         total_weight = 0;
> >         for (i = 0; i < dest->nr_dests; i++) {
> >                 total_weight += dest->weight_arr[i];
> >                 if (total_weight >= weights_to_ignore)
> >                         return dest->node_id_arr[i];
> >         }
> >         WARN_ON_ONCE(1, "I don't know what I did wrong");
> >         return 0;
> > }
> >
> > Then, we could replace the above rmap_walk() call with this one.  What do you
> > think?
> 
> I do actually think doing the interleaving based on the VMA offset is
> important for a couple of reasons.
> 
> 1. If also using the weighted interleaving mempolicy, and the DAMON
> weights are the same as the mempolicy weights, DAMON won't have to
> migrate newly allocated pages. This is relatively minor, but helps
> avoid unnecessary work.
> 
> 2. More importantly, I believe this approach will cause a lot of
> needless ping-ponging, where the same folios are being moved around
> when they don't need to be. For example, let's say folios A-F are hot,
> and just for simplification, if they are on the same node, they will
> be in the same DAMON region, and only those folios are in those DAMON
> regions. If all the folios start in Node 0 and both nodes have a
> weight of 1, we have:
> 
> nr_migrated = 0
> Node 0           Node 1
> ----------           ----------
> A-F                  <empty>
> 
> After the scheme is first applied
> 
> nr_migrated = 6
> Node 0           Node 1
> ----------           ----------
> A,C,E              B,D,F
> 
> This is fine, but these folios are still hot, so the scheme will be
> applied to them again
> 
> nr_migrated = 12
> Node 0           Node 1
> ----------           ----------
> A,E,D             C,D,F
> 
> If I am understanding your code sample correctly, this will continue
> to happen each time the scheme is applied, causing folios to be
> migrated for no reason.

Thank you for walking with me, Bijan.  I understand and agree your concerns.
Actually, this kind of unnecessary ping-pong is a general problem for DAMOS.
We hence made a few DAMOS features to avoid this issue.

The first feature is 'age' reset.  DAMOS sets 'age' of regions to zero when it
applies an action.  Hence if your DAMOS scheme has minimum 'age' for the target
access pattern, the region will not be selected as action target again, very
soon.

The second feature is the quota.  You can set speed limit of a DAMOS action, to
avoid DAMOS being too aggressive.  When DAMOS finds memory regions that
eligible for a given action and larger than the given quota, it calculates
access temperature of regions, and apply the action to only hottest or coldest
regions of quota amount.  Whether to prioritize hotter or colder depends on the
action.  DAMOS_MIGRATE_HOT prefers hotter one.  Together with the age reset,
this can reduce unnecessary pingpong.

The third feature is quota auto-tuning.  You can ask DAMON to adjust the quotas
on its own, based on some metrics.  Let me describe an example with memory
tiering use case.  Consider there are two NUMA nodes of different speed.  Node
0 is faster than node 1, samely for every CPU.  Then you can ask DAMON to
migrate hot pages on node 1 to node 0 aiming 99% of node 0 memory be allocated,
while migrating cold pages on node 0 to node 1 aiming 1% of node 0 memory be
free.  Then, DAMON will adjust the quotas for two different schemes based on
current node 0 memory used/free amount.  If node 0 memory is used less than
99%, hot pages migration scheme will work.  The aggressiveness will be
determined on the difference between the current memory usage and the target
usage.  For example, DAMON will try to migrate hot pages faster when node 0
memory usage is 50%, compared to when node 0 memory usage is 98%.  The cold
pages migration scheme will do nothing when node 0 memory is used less than
99%, since its goal (1% node 0 free memory ratio) is already over-achieved.
When the node 0 memory usage becomes 99% and no more allocation is made, DAMON
will be quiet.  Even if a few more allocations happen, DAMON will work in slow
speed, and hence make only reasonable and healthy amount of noise.

Back to your use case, you could set per-node ideal memory usage of
interleaving as the quota goal.  For example, on the 1:1 ratio interleaving on
2 NUMA nodes, you could use two DAMOS scheme, one aiming 50% node 0 memused,
and other one aiming 50% node 0 memfree.  Once pages are well interleaved, both
schemes will stop working for unnecessary pingponging.

Note that you can one of quota auto-tuning metric that DAMON support is
arbitrary user input.  When this is being used, users can simply feed any value
as current value of the goal metric.  For example, you can use application's
performance metric, memory bandwidth, or whatever.  You could see the
node0-node1 balance from your user-space tool and feed it to DAMON quota
auto-tuning.  Then, DAMON will do more migration when it is imbalanced, and no
more migration when it is well balanced.

Finally, you can change DAMON parameters including schemes while DAMON is
running.  You can add and remove schemes whenever you want, while DAMON keeps
monitoring the access pattern.  Your user-space tool can determine how
aggressive migration is required based on current memory balance and adjust
DAMOS quotas online, or even turns DAMOS schemes off/on on demand.

So I think you could avoid the problem using these features.  Does this make
sense to you?

In future, we could add more DAMOS self-feedback metric for this use case.  For
example, the memory usage balance of nodes.  My self-tuning example above was
using two schemes since there is no DAMOS quota goal tuning metric that can
directly be used for your use case.  But I'd say that shouldn't be a blocker of
this work.

> Using the VMA offset to determine where a page
> should be placed avoids this problem because it gives a folio a single
> node it can be in for a given set of interleave weights. This means
> that in steady state, no folios will be migrated.

This makes sense for this use case.  But I don't think this makes same sense
for possible other use cases, like memory tiering on systems having multiple
NUMA nodes of same tier.  If you really need this virtual address space based
deterministic behavior, it would make more sense to use virtual address spaces
monitoring (damon-vaddr).

> 
> I see what you're saying about rmap_walks being expensive, but since
> DAMON operates off the critical path for the workload, I don't think
> the cost is that problematic.

You're right.  We try to make DAMON be controllable (min/max_nr_regions or
DAMOS quotas) rather than always fast.  But, we still try to be fast and
invisible when possible.  Since this change is not only for interleaving but
also general multi-nodes migration and we have features that hopefully can
potentially address your concern, I'd like to think again with you.


Thanks,
SJ

[...]
