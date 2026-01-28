Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6539227EA8;
	Wed, 28 Jan 2026 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769563546; cv=none; b=lfBN2vbDK2Immyc2qsF+WRJrs5Bm9CQlXIuV97ApJqUFoRm8ym9yrMAKLyC8lWx13nnDx5XlLh/17DYtOhO8TP1f830AHwJNaLMRMYVx9FrutTdutDIP5y8SBiQrcgAu5n6DuRzGMkBWGEOXHZ4FSe2wsdvIV2Wy9rD3krYmZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769563546; c=relaxed/simple;
	bh=e0W8b/lJMt8akxgb08koUYI+7WMv1CQDwZ7pqzCYq+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqUnfvHvclo7GIR8vjkakUvApJSpXZcSmfGl1X3v2QBPhLx1k1IgRwjh339LnKm8J2i++Wp7IFNuN51wJhf9NwHL0/O5K07aCdYSkODJHB553KkmDfJkFbjUBLLyJWt5qX3kf41gJsr4CwzB2TU3DHFBY3pJnIx5dysXcHHmezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3l+vILW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3l+vILW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E5DC116C6;
	Wed, 28 Jan 2026 01:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769563546;
	bh=e0W8b/lJMt8akxgb08koUYI+7WMv1CQDwZ7pqzCYq+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3l+vILWzCwLTGPzcFHOMrhXMzBS2ehHyHZijgbcNTZme/C1fcdnaz3E8yx0haBfY
	 kq8Ii/3BH3ciKInZOK1qs/aZmDONw2WxG3hGuq3v9VExXV2tfGSdI9wQXCaxhSw4x8
	 FzWML7wzZvVOEc2wReYY0AShnmYFTUngIu+0DyeVp6fUEFAHVu4OFZh6PEe6xxqpxZ
	 4wYZ5cc5+IcU5q3xOvQ0MFNlbMcFXi0govjucAWLHDNyBixplRImvn4vGiBCkQUJAJ
	 PAAWc2tAt9dOGPL+1mTR6+S9aJfULMd4IoeKbeukjfvKNC/rmiYqtquMTlIi4oCI2j
	 QK6K+b1OggHsQ==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [RFC PATCH 0/5] mm/damon: Add node_sys_bp quota goal metric for PA-based migration control
Date: Tue, 27 Jan 2026 17:25:37 -0800
Message-ID: <20260128012539.72119-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y17__d=ZsM1yX+MXx0ozVdsXnFqF4p0g+kATEitrWyZFfg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 27 Jan 2026 10:52:53 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Fri, Jan 23, 2026 at 5:50 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Cc-ing SK hynix folks (Honggyu and Yunjeong) for quota auto-tuning behavior
> > confusion (not stop immediately after satisfying the goal) I discuss below.
> >
> > Hello Ravi,
> >
> 
>  Hi SJ,
> 
>   Thank you for the detailed review and for Cc'ing SK hynix folks.
> 
> >
> > Thank you for sharing this great RFC!
> >
> > I had a chance to be involved in a high level design of this series, off the
> > mailing list.  I'm disclosing the fact for others' context, since a few of my
> > comments below are based on the previous off-list discussion.
> >
> > On Thu, 22 Jan 2026 20:57:23 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > This series introduces a new DAMON quota goal metric,
> >
> > As I discussed off the list, I believe the new goal can be useful.  Thank you
> > again for making this!
> >
> > > `node_sys_bp`, designed
> > > for controlling memory migration in heterogeneous memory systems (e.g.,
> > > DRAM↔CXL tiering). These patches are provided as an initial RFC and have
> > > not been tested on actual hardware.
> >
> > I feel like the name is not very self explaining what it is, though.  I'm also
> > bit confused about what it does is what we discussed off list.  I'll add more
> > details below, on more detailed explanation about the new goal.
> >
> 
> Will change the name to damos_target_mem_node_sys_bp in v2.

Sounds good name.  But, could it be more consistent with existing node-related
quota goal metrics such as 'node_mem_used_bp' and 'node_mem_free_bp'?  What
about... say... 'node_target_mem_bp'?  Please feel free to suggest a better
one.

[...]
> > > Solution: bp-Based Target State Goals
> > > =====================================
> > >
> > > Instead of specifying action rates, `node_sys_bp` specifies a TARGET STATE:
> > >
> > >     "Node N should contain X basis points (X/10000) of system memory"
> >
> > I'm not sure if this is exactly what we discussed off list.  What I expected
> > the goal would be based on our discussion is, what the first patch is saying.
> > To quote the part,
> >
> >     @@ -155,6 +155,7 @@ enum damos_action {
> >       * @DAMOS_QUOTA_NODE_MEM_FREE_BP:      MemFree ratio of a node.
> >       * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:    MemUsed ratio of a node for a cgroup.
> >       * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:    MemFree ratio of a node for a cgroup.
> >     + * @DAMOS_QUOTA_NODE_SYS_BP:           Scheme-eligible bytes ratio of a node.
> >       * @NR_DAMOS_QUOTA_GOAL_METRICS:       Number of DAMOS quota goal metrics.
> >
> > That is, my understanding of what we want to achive with the new goal is,
> > letting users to ask DAMON "migrate hot pages of node A to node B, aiming
> > X % of node B becomes hot, as a result of the migrations".
> >
> 
> Yes, this is the intent. Looking back at my implementation, I see the
> mismatch:
> 
> 1. **Numerator**: Should count only scheme-eligible bytes.
> 
> 2. **Denominator**: Should use node capacity, but I used total system
>    memory.
> 
> > But your above description is not saying about the "scheme-eligibility".  Also,
> > the goal metric is the ratio of the memory to the entire system memory, not
> > just a given node.  My quick read of damon_pa_get_node_sys_bp() on the second
> > patch of this series confirms the implementation is following your description,
> > not what I imagined.
> >
> 
> You're right. The implementation diverged from what we discussed. I'll
> fix both the numerator and denominator in v2.

Thank you for clarifying it and sharing the next plan, all sounds good!

[...]
> > Please note that the goal-based quota auto-tuning works in proportional way,
> > preferring small steps and "eventual" goal convergence.  As a result, migration
> > will occur a few more times until it is completely stopped after the goal is
> > satisfied.  Unless there is another scheme that migrates pages into node 0, you
> > may end up having node 0 having a bit less than the 40% memory.
> >
> > >
> > >     No oscillation - migration stops when target state is reached.
> >
> > So, little bit of oscillation could still happen.  Hopefully that shouldn't be
> > significant, though.
> >
> 
> Yes, As we discussed offline, for a two-context approach:
> 
>       Context 0: monitors node 0, migrate_hot → node 1
>         goal: damos_target_mem_node_sys_bp, nid=1, target=4000
>         "Stop when node 1 is 40% hot"
> 
>       Context 1: monitors node 1, migrate_hot → node 0
>         goal: damos_target_mem_node_sys_bp, nid=0, target=6000
>         "Stop when node 0 is 60% hot"
> 
> Each context eventually stops when its target node reaches the desired
> threshold,
> and the reverse direction is handled by the other context. For my use
> case, eventual convergence with this setup could be acceptable.

Thank you for clarifying this!  I'm relieved we don't have a concern here.

> An immediate-stop feature could still be useful for the broader community.

Thank you for the feedback.  I will take more time on thinking about how to
implement this.

> Will test and post results after the next iteration.
> 
> > IIRC, SK hynix people also confused with the behavior when they experimented
> > migrate_{hot,cold} action with NODE_MEM_USED_BP goal based quota auto-tuning,
> > but using only a single scheme that does migration in a single direction.
> > Because this is at least second time it made confusion, if you need, maybe I
> > can try to add a feature for making DAMOS immediately stops after the goal is
> > satisfied.  Let me know if such new feature can be useful for you.  Cc-ing SK
> > hynix people (Honggyu and Yunjeong) so that they can correct me if my memory is
> > broken, or answer if the new feature I described here can be useful for them.
[...]
> > > Why get_goal_metric() Ops Callback
> > > ==================================
> > >
> > > The bp calculation requires iterating over monitored PA regions:
> > >
> > >     for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > >         if (page_to_nid(pfn_to_page(pfn)) == nid)
> > >             node_bytes += PAGE_SIZE;
> > >     }
> > >     bp = node_bytes * 10000 / system_total;
> > >
> > > This requires address-space knowledge that only the ops provider has.
> > > Existing goal metrics (PSI, node_mem_*, node_memcg_*) are computed in
> > > core using system-wide data that doesn't require iterating monitored
> > > regions.
> > >
> > > The new `get_goal_metric()` callback in `damon_operations` allows:
> > >
> > >   1. Core to remain generic - handles all common metrics
> >
> > I agree this is indeed making the design clean.  But, we already having such
> > exception, like core.c code using 'damon_target_has_pid().  Having just one
> > more exception seems ok to me, unless it makes code too ugly.
> >
> > >   2. Ops providers to implement metrics requiring region iteration
> > >   3. Clean separation - PA implements node_sys_bp, VA could add
> > >      different metrics in future
> >
> > I agree it could be useful for clean support of virtual address mode in future.
> > But, I'd prefer making this as simple and small as possible for the support we
> > will use at the moment.
> >
> > >   4. Optional implementation - ops return 0 if metric unsupported
> >
> > Again, letting core logic having a bit of ops layer information is not a big
> > problem to my humble perspective.
> >
> > So, I'd more prefer not adding the Ops callback, unless you have some other
> > concerns.
> >
> 
> Agreed. I'll remove the get_goal_metric() ops callback in v2

Thank you for flexibly accepting my suggestion.

[...]
> > > Advantages of PA-Based Migration
> > > ================================
> > >
> > > PA-based migration with DAMON enables integration of multiple hotness
> > > sources for migration decisions:
> > >
> > >   1. DAMON's native access pattern monitoring
> > >   2. Fault-based information (similar to NUMA Balancing)
> > >   3. Future: Hardware monitoring units (e.g., CXL CHMU)
> > >   4. Future: Instruction-Based Sampling (AMD IBS, Intel PEBS)
> > >
> > > Unlike VA-based approaches tied to individual process address spaces, PA
> > > monitoring can aggregate hotness information from multiple sources to make
> > > system-wide migration decisions across the entire physical memory space.
> >
> > Maybe you are saying about the damon_report_access() based DAMON extension
> > project [1]?  Since it is not yet upstreamed, and the long term plan is to
> > support not only physical address but also virtual address space, I think this
> > section is better to be removed, unless the DAMON extension project is merged
> > before this patch series.  I expect this patch series will be merged much
> > earlier than the extension project.
> >
> 
> Agreed. I'll remove the references to future hotness sources.

Thank you!

[...]
> > > Feedback on the overall approach and design is appreciated.
> >
> > I hope my above comments helps the forward progress of this nice series.
> >
> 
> They are very helpful. Thanks a lot.

The pleasure is mine, looking forward to the next version of this patch series
:)


Thanks,
SJ

[...]
