Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142EB202C44
	for <damon@lists.linux.dev>; Mon, 16 Jun 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059771; cv=none; b=FKPxt5RkhHjl7sIIvu3vDM5rBlyGOJ6Tt8wWARu+iYq2oZ3mjm4Sx0nAPZEMCjHglxRWTzYJWMX66SQGiBByDjWhzWtWl/WJpjYQX9PpPr8K2mck4e2vidw5sm5iBRbTPbybcrlt+tnBJA37JxmEMuTx/ZvWV6WfXATZND4Wbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059771; c=relaxed/simple;
	bh=uhpJklVbBbRMO7R0wFYgpRhw8DZy55F6QA/PMvAN/z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFB0XbP7Mejjcb7cxTP1cca9dy5YeTphdu/ivcxd0SGtkdLsrWt9dfkE7cEuMr1gkF/6F4yhzgkHR5JodxpDFavDn+SB3vt/oGnQm81P4F+axcqNB9Yqxgx3Dft4CAs6H8u0A19PoE07q60Viyqm+3LPFicPYLl9i5en4ll72MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e0-684fcaeedd57
Date: Mon, 16 Jun 2025 16:42:33 +0900
From: Byungchul Park <byungchul@sk.com>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, bijantabatab@micron.com,
	venkataravis@micron.com, emirakhur@micron.com, ajayjoshi@micron.com,
	vtavarespetr@micron.com, damon@lists.linux.dev,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH 0/4] mm/damon: Add DAMOS action to interleave data
 across nodes
Message-ID: <20250616074233.GA74466@system.software.com>
References: <20250612181330.31236-1-bijan311@gmail.com>
 <20250612234942.3612-1-sj@kernel.org>
 <CAMvvPS4WsGkfukNscnLWW40Agg6_wmkm_QF96m+HZrEZrstR4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMvvPS4WsGkfukNscnLWW40Agg6_wmkm_QF96m+HZrEZrstR4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsXC9ZZnke67U/4ZBu2PTS1W7G1lt5izfg2b
	xa4bIRYNPz6zWSy4d57R4smBdiDx/zerxdf1v5gtZny4xG7x8+5xdovjW+exWyxsW8JicXnX
	HDaLe2v+s1p865O2OPz1DZPFzuY7TBbH701it1i9JsNi9tF77A4iHjtn3WX36G67zO6xeM9L
	Jo9NqzrZPDZ9msTucWLGbxaPnQ8tPV5snsnosbhvMqvH9/UdbB69ze/YPN7vu8rm8XmTXABv
	FJdNSmpOZllqkb5dAlfGu4/vmAomx1U0Pp3M3sC42ruLkZNDQsBEYuvrH8ww9rK7rewgNouA
	qsTS62tZQGw2AXWJGzd+gtWICGhI7Ph+B6iGi4NZ4DezxLTDDWAJYYFIiX0Hr4DZvAIWEkcv
	LgMrEhJYxijROuk9VEJQ4uTMJ2BTmYGm/pl3CSjOAWRLSyz/xwERlpdo3jobrJxTIFDi5JRl
	bCC2qICyxIFtx5lAZkoI3GKX2DCthRXiakmJgytusExgFJyFZMUsJCtmIayYhWTFAkaWVYxC
	mXlluYmZOSZ6GZV5mRV6yfm5mxiBkb2s9k/0DsZPF4IPMQpwMCrx8B7Y6pchxJpYVlyZe4hR
	goNZSYR38QmgEG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6p
	BsagV9k1Oi9N5K/pX2ErO/R3EWf+cpFn0ZE+l4/7ti6dkDBr02YWh9SY4tLNN4S3hf258jYi
	9qSG1LctLk6T7QtZZ155azzddaf+XrsUfaeHrZd5Z2s+6/M/rXupyFYxsGtWzf5Kp3UMZtbb
	8leke800u/JsfoNFgeGcr5qb7B9oyG65End5vZoSS3FGoqEWc1FxIgDzJjDy6AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsXC5WfdrPvulH+GwYxLihYr9rayW8xZv4bN
	YteNEIuGH5/ZLBbcO89o8eRAO5D4/5vV4uv6X8wWMz5cYrf4efc4u8XxrfPYLQ7PPclqsbBt
	CYvF5V1z2CzurfnPavGtT9ri0LXnrBaHv75hstjZfIfJ4vi9SewWq9dkWMw+eo/dQcxj56y7
	7B7dbZfZPRbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHi80zGT0W901m9fi+voPNo7f5HZvH
	+31X2Ty+3fbwWPziA5PH501yAfxRXDYpqTmZZalF+nYJXBnvPr5jKpgcV9H4dDJ7A+Nq7y5G
	Tg4JAROJZXdb2UFsFgFViaXX17KA2GwC6hI3bvxkBrFFBDQkdny/A1TDxcEs8JtZYtrhBrCE
	sECkxL6DV8BsXgELiaMXl4EVCQksY5RonfQeKiEocXLmE7CpzEBT/8y7BBTnALKlJZb/44AI
	y0s0b50NVs4pEChxcsoyNhBbVEBZ4sC240wTGPlmIZk0C8mkWQiTZiGZtICRZRWjSGZeWW5i
	Zo6pXnF2RmVeZoVecn7uJkZg5C6r/TNxB+OXy+6HGAU4GJV4eB9s8s8QYk0sK67MPcQowcGs
	JMK7+IRfhhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAPj
	3Jc3f/92TmY79Lyk+svvxpbbWZtfZC2YKboz//Tqe8d2r9504F7x/5SV4nfVy22eLNOPW6hz
	6PD0PRa1Idv/NPuJt8xrK1hz2Dqj5N+vS7Lt0WJvbq4oyfl7q9ZYO5Yt5HHIg2+VLisLPTY4
	haxe+ktQJOgQt+TUW2luekEvs6+Zri0xyVR+pMRSnJFoqMVcVJwIAKOKiFDYAgAA
X-CFilter-Loop: Reflected

On Fri, Jun 13, 2025 at 10:44:17AM -0500, Bijan Tabatabai wrote:
> Hi SeongJae,
> 
> Thank you for your comments.
> 
> On Thu, Jun 12, 2025 at 6:49 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Bijan,
> >
> > On Thu, 12 Jun 2025 13:13:26 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > From: Bijan Tabatabai <bijantabatab@micron.com>
> > >
> > > A recent patch set automatically set the interleave weight for each node
> > > according to the node's maximum bandwidth [1]. In another thread, the patch
> > > set's author, Joshua Hahn, wondered if/how these weights should be changed
> > > if the bandwidth utilization of the system changes [2].
> >
> > Thank you for sharing the background.  I do agree it is an important question.
> >
> > >
> > > This patch set adds the mechanism for dynamically changing how application
> > > data is interleaved across nodes while leaving the policy of what the
> > > interleave weights should be to userspace. It does this by adding a new
> > > DAMOS action: DAMOS_INTERLEAVE. We implement DAMOS_INTERLEAVE with both
> > > paddr and vaddr operations sets. Using the paddr version is useful for
> > > managing page placement globally. Using the vaddr version limits tracking
> > > to one process per kdamond instance, but the va based tracking better
> > > captures spacial locality.
> > >
> > > DAMOS_INTERLEAVE interleaves pages within a region across nodes using the
> > > interleave weights at /sys/kernel/mm/mempolicy/weighted_interleave/node<N>
> > > and the page placement algorithm in weighted_interleave_nid via
> > > policy_nodemask.
> >
> > So, what DAMOS_INTERLEAVE will do is, migrating pages of a given DAMON region
> > into multiple nodes, following interleaving weights, right?
> 
> That's correct.

Your approach sounds interesting.

IIUC, the approach can be intergrated with the existing numa hinting
mechanism as well, so as to perform weighted interleaving migration for
promotion, which may result in suppressing the migration anyway tho, in
MPOL_WEIGHTED_INTERLEAVE set.

Do you have plan for the that too?

Plus, it'd be the best if you share the improvement result rather than
the placement data.

	Byungchul

> > We already have
> > DAMOS actions for migrating pages of a given DAMON region, namely
> > DAMOS_MIGRATE_{HOT,COLD}.  The actions support only single migration target
> > node, though.  To my perspective, hence, DAMOS_INTERLEAVE looks like an
> > extended version of DAMOS_MIGRATE_{HOT,COLD} for flexible target node
> > selections.  In a way, DAMOS_INTERLEAVE is rather a restricted version of
> > DAMOS_MIGRATE_{HOT,COLD}, since it prioritizes only hotter regions, if I read
> > the second patch correctly.
> >
> > What about extending DAMOS_MIGRATE_{HOT,COLD} to support your use case?  For
> > example, letting users enter special keyword, say, 'weighted_interleave' to
> > 'target_nid' DAMON sysfs file.  In the case, DAMOS_MIGRATE_{HOT,COLD} would
> > work in the way you are implementing DAMOS_INTERLEAVE.
> 
> I like this idea. I will do this in the next version of the patch. I
> have a couple of questions
> about how to go about this if you don't mind.
> 
> First, should I drop the vaddr implementation or implement
> DAMOS_MIGRATE_{HOT,COLD}
> in vaddr as well? I am leaning towards the former because I believe
> the paddr version is
> more important, though the vaddr version is useful if the user only
> cares about one
> application.
> 
> Second, do you have a preference for how we indicate that we are using
> the mempolicy
> rather than target_nid in struct damos? I was thinking of either
> setting target_nid to
> NUMA_NO_NODE or adding a boolean to struct damos for this.
> 
> Maybe it would also be a good idea to generalize it some more. I
> implemented this using
> just weighted interleave because I was targeting the use case where
> the best interleave
> weights for a workload changes as the bandwidth utilization of the
> system changes, which
> I will go describe in more detail further down. However, we could
> apply the same logic for
> any mempolicy instead of just filtering for MPOL_WEIGHTED_INTERLEAVE. This might
> clean up the code a little bit because the logic dependent on
> CONFIG_NUMA would be
> contained in the mempolicy code.
> 
> > > We chose to reuse the mempolicy weighted interleave
> > > infrastructure to avoid reimplementing code. However, this has the awkward
> > > side effect that only pages that are mapped to processes using
> > > MPOL_WEIGHTED_INTERLEAVE will be migrated according to new interleave
> > > weights. This might be fine because workloads that want their data to be
> > > dynamically interleaved will want their newly allocated data to be
> > > interleaved at the same ratio.
> >
> > Makes sense to me.  I'm not very familiar with interleaving and memory policy,
> > though.
> >
> > >
> > > If exposing policy_nodemask is undesirable,
> >
> > I see you are exposing it on include/linux/mempolicy.h on the first patch of
> > this series, and I agree it is not desirable to unnecessarily expose functions.
> > But you could reduce the exposure by exporting it on mm/internal.h instead.
> > mempolicy maitnainers and reviewers who you kindly Cc-ed to this mail could
> > give us good opinions.
> >
> > > we have two alternative methods
> > > for having DAMON access the interleave weights it should use. We would
> > > appreciate feedback on which method is preferred.
> > > 1. Use mpol_misplaced instead
> > >   pros: mpol_misplaced is already exposed publically
> > >   cons: Would require refactoring mpol_misplaced to take a struct vm_area
> > >   instead of a struct vm_fault, and require refactoring mpol_misplaced and
> > >   get_vma_policy to take in a struct task_struct rather than just using
> > >   current. Also requires processes to use MPOL_WEIGHTED_INTERLEAVE.
> >
> > I feel cons is larger than pros.  mpolicy people's opinion would matter more,
> > though.
> >
> > > 2. Add a new field to struct damos, similar to target_nid for the
> > > MIGRATE_HOT/COLD schemes.
> > >   pros: Keeps changes contained inside DAMON. Would not require processes
> > >   to use MPOL_WEIGHTED_INTERLEAVE.
> > >   cons: Duplicates page placement code. Requires discussion on the sysfs
> > >   interface to use for users to pass in the interleave weights.
> >
> > I agree this is also somewhat doable.  In future, we might want to implement
> > this anyway, for non-global and flexible memory interleaving.  But if memory
> > policy people are ok with reusing policy_nodemask(), I don't think we need to
> > do this now.
> >
> > >
> > > This patchset was tested on an AMD machine with a NUMA node with CPUs
> > > attached to DDR memory and a cpu-less NUMA node attached to CXL memory.
> > > However, this patch set should generalize to other architectures and number
> > > of NUMA nodes.
> >
> > I show the test results on the commit messages of the second and the fourth
> > patches.  In the next version, letting readers know that here would be nice.
> > Also adding a short description of what you confirmed with the tests here
> > (e.g., with the test we confirmed this patch functions as expected [and
> > achieves X % Y metric wins]) would be nice.
> >
> 
> Noted. I'll include this in the cover letter of the next patch set.
> 
> > >
> > > Patches Sequence
> > > ________________
> > > The first patch exposes policy_nodemask() in include/linux/mempolicy.h to
> > > let DAMON determine where a page should be placed for interleaving.
> > > The second patch implements DAMOS_INTERLEAVE as a paddr action.
> > > The third patch moves the DAMON page migration code to ops-common, allowing
> > > vaddr actions to use it.
> > > Finally, the fourth patch implements a vaddr version of DAMOS_INTERLEAVE.
> >
> > I'll try to take look on code and add comments if something stands out, but
> > let's focus on the high level discussion first, especially whether to implement
> > this as a new DAMOS action, or extend DAMOS_MIGRATE_{HOT,COLD} actions.
> 
> Makes sense. Based on your reply, I will probably change the code significantly.
> 
> > I think it would also be nice if you could add more explanation about why you
> > picked DAMON as a way to implement this feature.  I assume that's because you
> > found opportunities to utilize this feature in some access-aware way or
> > utilizing DAMOS features.  I was actually able to imagine some such usages.
> > For example, we could do the re-interleaving for hot or cold pages of specific
> > NUMA nodes or specific virtual address ranges first to make interleaving
> > effective faster.
> 
> Yeah, I'll give more detail on the use case I was targeting, which I
> will also include
> in the cover letter of the next patch set.
> 
> Basically, we have seen that the best interleave weights for a workload can
> change depending on the bandwidth utilization of the system. This was touched
> upon in the discussion in [1]. As a toy example, imagine some
> application that uses
> 75% of the local bandwidth. Assuming sufficient capacity, when running alone, we
> probably want to keep all of that application's data in local memory.
> However, if a
> second instance of that application begins, using the same amount of bandwidth,
> it would be best to interleave the data of both processes to alleviate
> the bandwidth
> pressure from the local node. Likewise, when one of the processes ends, the data
> should be moved back to local memory.
> 
> We imagine there would be a userspace application that would monitor system
> performance characteristics, such as bandwidth utilization or memory
> access latency,
> and uses that information to tune the interleave weights. Others seemed to have
> come to a similar conclusion in previous discussions [2]. We are
> currently working
> on a userspace program that does this, but it's not quite ready to be
> published yet.
> 
> After the userspace application adjusts the interleave weights, we need some
> mechanism to migrate the application pages that have already been allocated.
> We think DAMON is the correct venue for this mechanism because we noticed
> that we don't have to migrate all of the application's pages to
> improve performance,
> we just need to migrate the frequently accessed pages. DAMON's existing hotness
> tracking is very useful for this. Additionally, as Ying pointed out
> [3], a complete
> solution must also handle when a memory node is at capacity. The existing
> DAMOS_MIGRATE_COLD action can be used in conjunction with the functionality
> in this patch set to provide that complete solution.
> 
> [1] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy@gmail.com/
> [2] https://lore.kernel.org/linux-mm/20250314151137.892379-1-joshua.hahnjy@gmail.com/
> [3] https://lore.kernel.org/linux-mm/87frjfx6u4.fsf@DESKTOP-5N7EMDA/
> 
> > Also we could apply a sort of speed limit for the interleaving-migration to
> > ensure it doesn't consume memory bandwidth too much.  The limit could be
> > arbitrarily user-defined or auto-tuned for specific system metrics value (e.g.,
> > memory bandwidth balance?).
> 
> I agree this is a concern, but I figured DAMOS's existing quota mechanism would
> handle it. If you could elaborate on why quotas aren't enough here,
> that would help
> me come up with a solution.
> 
> 
> > If you have such use case in your mind or your test setups, sharing those here
> > or on the next versions of this would be very helpful for reviewers.
> 
> Answered above. I will include them in the next version.
> 
> Thanks,
> Bijan
> 
> > >
> > > [1] https://lore.kernel.org/linux-mm/20250520141236.2987309-1-joshua.hahnjy@gmail.com/
> > > [2] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy@gmail.com/
> >
> >
> > Thanks,
> > SJ
> >
> > [...]
