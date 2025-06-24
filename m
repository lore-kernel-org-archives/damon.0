Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A142AEED;
	Tue, 24 Jun 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725251; cv=none; b=bCZti5Bsz5/X5NBJaGsZSUDpUathceQteHG/w/3Ory+9AgW862sVCdCdiT2PAE/Rcx63bufUdZit+zwub9avhkhoJfZjpWH3nw4rxU6iEc6a0AogvODFVgrWvYxtQZb21Z5apxEc/3F+TZNMZrIJCYX4uSCzZCdIk0QuuBAhJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725251; c=relaxed/simple;
	bh=lXIMUIqca9amr01wZvSN4kfNBTEuykhwJx5cSkrzAJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQk50OD++NLzoAiGnRDpDkO0MQKq2ZXdpn0Yho6vblvTFAwt2K7wMuhEID2izMdjJK16VQCE9IivQHApQ0rLXgvDwgLsq1mVfyW3BGNBeggwzwGUsnOR5S4CEiczRUbxBdSVXWVKlLiZpUAIKXINvywoTLoU5tfHVdO5OwqeH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJU6m1UC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJU6m1UC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C12EC4CEEA;
	Tue, 24 Jun 2025 00:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750725250;
	bh=lXIMUIqca9amr01wZvSN4kfNBTEuykhwJx5cSkrzAJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJU6m1UCxcYko2rIclBtf62bO/+78UquCelaCQcsoCnem7Vqnup2QMpw2P2SfJmgF
	 GiInmVd6XBORQp0WUx+9Q+HNbCV6vF8k6BaYUP1Smx83Phb6MP4nnQZpjTuUPSPpbu
	 q2fOnP1yNnOqDzesR+ft8r01N5IBLroDQSS9IfPD69ffR7KsJfp8M+oil8PpcyHVmk
	 6HW4dfKnuLUQrvYrbUS8R9yB5y7PmPwVVapvTsVTpXdPPTnmM2C2N+ZC5q9GX4kT5o
	 LZPKD2pQ6/mdjBHDs0nWS5LucSNskCm0Jd96j/aIyvHOvxBsz/ROmvRfxSRSuo7URt
	 /aJ01viuxo7gg==
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
Date: Mon, 23 Jun 2025 17:34:08 -0700
Message-Id: <20250624003408.47807-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS4CNzc7gSF8Z+6ogB212V+GDJyW9PXrrrP+wMyDNfXKqg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 18:15:00 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

[...]
> Hi SeongJae,
> 
> I really appreciate your detailed response.
> The quota auto-tuning helps, but I feel like it's still not exactly
> what I want. For example, I think a quota goal that stops migration
> based on the memory usage balance gets quite a bit more complicated
> when instead of interleaving all data, we are just interleaving *hot*
> data. I haven't looked at it extensively, but I imagine it wouldn't be
> easy to identify how much data is hot in the paddr setting,

I don't think so, and I don't see why you think so.  Could you please
elaborate?

> especially
> because the regions can contain a significant amount of unallocated
> data.

In the case, unallocated data shouldn't be accessed at all, so the region will
just look cold to DAMON.

> Also, if the interleave weights changed, for example, from 11:9
> to 10:10, it would be preferable if only 5% of data is migrated;
> however, with the round robin approach, 50% would be. Finally, and I
> forgot to mention this in my last message, the round-robin approach
> does away with any notion of spatial locality, which does help the
> effectiveness of interleaving [1].

We could use the probabilistic interleaving, if this is the problem?

> I don't think anything done with
> quotas can get around that.

I think I'm not getting your points well, sorry.  More elaboration of your
concern would be helpful.

> I wonder if there's an elegant way to
> specify whether to use rmap or not, but my initial feeling is that
> might just add complication to the code and interface for not enough
> benefit.

Agreed.  Please note that I'm open to add an interface for this behavior if the
benefit is clear.  I'm also thinking adding none-rmap migration first (if it
shows some benefit), and adding rmap support later with additional benefit
confirmation could also be an option.

> 
> Maybe, as you suggest later on, this is an indication that my use case
> is a better fit for a vaddr scheme. I'll get into that more below.
> 
> > > Using the VMA offset to determine where a page
> > > should be placed avoids this problem because it gives a folio a single
> > > node it can be in for a given set of interleave weights. This means
> > > that in steady state, no folios will be migrated.
> >
> > This makes sense for this use case.  But I don't think this makes same sense
> > for possible other use cases, like memory tiering on systems having multiple
> > NUMA nodes of same tier.
> 
> I see where you're coming from. I think the crux of this difference is
> that in my use case, the set of nodes we are monitoring is the same as
> the set of nodes we are migrating to, while in the use case you
> describe, the set of nodes being monitored is disjoint from the set of
> migration target nodes.

I understand and agree this difference.

> I think this in particular makes ping ponging
> more of a problem for my use case, compared to promotion/demotion
> schemes.

But again I'm failing at understanding this, sorry.  Could I ask more
elaborations?

> 
> > If you really need this virtual address space based
> > deterministic behavior, it would make more sense to use virtual address spaces
> > monitoring (damon-vaddr).
> 
> Maybe it does make sense for me to implement vaddr versions of the
> migrate actions for my use case.

Yes, that could also be an option.

> One thing that gives me pause about
> this, is that, from what I understand, it would be harder to have
> vaddr schemes apply to processes that start after damon begins. I
> think to do that, one would have to detect when a process starts, and
> then do a damon tune to upgrade the targets list? It would be nice if,
> say, you could specify a cgroup as a vaddr target and track all
> processes in that cgroup, but that would be a different patchset for
> another day.

I agree that could be a future thing to do.  Note that DAMON user-space tool
implements[1] a similar feature.

> 
> But, using vaddr has other benefits, like the sampling would take into
> account the locality of the accesses. There are also ways to make
> vaddr sampling more efficient by using higher levels of the page
> tables, that I don't think apply to paddr schemes [2]. I believe the
> authors of [2] said they submitted their patches to the kernel, but I
> don't know if it has been upstreamed (sorry about derailing the
> conversation slightly).

Thank you for reminding it.  It was nice finding and approach[2], but
unfortunately it didn't be upstreamed.  I now realize the monitoring intervals
auto-tuning[3] idea was partly motivated by the nice discussion, though.

[1] https://github.com/damonitor/damo/blob/next/release_note#L33
[2] https://lore.kernel.org/damon/20240318132848.82686-1-aravinda.prasad@intel.com/
[3] https://lkml.kernel.org/r/20250303221726.484227-1-sj@kernel.org


Thanks,
SJ

[...]

> 
> [1] https://elixir.bootlin.com/linux/v6.16-rc3/source/mm/mempolicy.c#L213
> [2] https://www.usenix.org/conference/atc24/presentation/nair
