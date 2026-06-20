Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B33230BDB;
	Sat, 20 Jun 2026 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781987968; cv=none; b=gc054cdIQ/BImKsA5gf93hudHKAKAKGwOiuuKuUPFkWvZ2U+0gOVB/Ym3Tk8Qokdd75OzzoUb4ZDBtQn8K3qc+8pX3w6cMnS+gIJMPWpo6PD0GTpnUHQPEe3rSIMLkO1Qc0a1VJm/fxWZ8b/rvpk4Fe2smTCrRpI14b98V5Tgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781987968; c=relaxed/simple;
	bh=En7ibmIeKKuSeEScLzehFkNVSi/MwhMISBI8c+F/9qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFmSCYlgG6mv4K9jecWbu3AnmJNaW2Osx1Zi2r9JT0xZjjeWMR8pgjQfvlk3DrBNmGVE1lADNhaRsDVkgzGExvbyhetIy8Khvvowndd6qK5TrgwLmnMd52suWbRui9Rc9k5tyxcuzyVDuVuLrJ/ohfKreLDn/w1bC8evmOeQ99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzgdRRjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzgdRRjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714601F000E9;
	Sat, 20 Jun 2026 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781987966;
	bh=EV9gJW6CU149INEIzocl32tRmEpbH+kREegdIG+aONM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VzgdRRjkky23ULkXUnpUbHXGCFAzqSVYV6GOCRyvoB4F5EUVdmxtAwc1TRzJJy3VD
	 KiVApsctfHheLNo01q+uErJESEUIrtFlvdS2042C7w0kcmVvaqbjNfORZALxbOMTp5
	 3FsYtglg3fxDzFiKtyt5Fwkx22oxmVjJRjgiNxs9yyc+3uvwRHd1mVMkL3iXjXDRb2
	 j25Sz52zhjy//SUf0WGppkyEjSfvPah+RckSsShRyfdjaxDKg/bqbdAvJZwsIiayI3
	 loEFNMuTk8WN3ioRXLZq6sDmutfsvRP3rgyjgwbh7mOQmCXhfpe+b5DbimMbrjZ8zZ
	 /9qaApcwQpxng==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	Wang Lian <lianux.mm@gmail.com>,
	akpm@linux-foundation.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	npache@redhat.com,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/6] mm/damon: Add mTHP-aware collapse/split with ARM SPE feedback
Date: Sat, 20 Jun 2026 13:39:14 -0700
Message-ID: <20260620203915.82947-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d0cda5a2-94f9-4733-8a62-90ad15243041@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ damon@lists.linux.dev

On Fri, 19 Jun 2026 17:31:33 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/19/2026 6:40 AM, Wang Lian wrote:
> > Hi SeongJae,
> > 
> > Thank you for the thorough and thoughtful review.  Your feedback on the
> > x86 AF behavior was an important correction -- I'll address that and
> > your other questions below.
> > 
> > On Thu, 18 Jun 2026 SeongJae Park <sj@kernel.org> wrote:
> > 
> >> This makes sense to me.  I also agree this could caused the reported
> >> problem.  And this is a known limitation of DAMON.  My suggestion for
> >> straightforward workaround of this problem is, using 'age' information
> >> of DAMON for better identification of the hot memory.
> > 
> > Thank you for pointing out idle time percentiles [1].  We agree that 'age'
> > helps differentiate frequently-accessed from occasionally-accessed regions,
> > and it is a good workaround for many cases.
> > 
> > However, age operates at region granularity, which is still at or above
> > PMD level for THP-mapped memory.  When only a few 4KB subpages within a
> > 2MB THP are hot, age tells us the region has been accessed recently, but
> > not which subpages are hot.  The split decision needs sub-PMD information,
> > which is what the SPE heatmap provides.
> > 
> > That said, combining age with split could be valuable: split only regions
> > that have been consistently hot (high age) AND have sparse sub-page access
> > patterns.  We will explore this.

Yes, I agree.  Using features like SPE in addition to 'age' will make it much
better.

> > 
> >>> On ARM64, this is compounded by the hardware AF mechanism -- the AF
> >>> is only set on a TLB miss.
> >>
> >> This makes sense to me.  However, I don't get how this is contributing
> >> to the problem.  Could you please elaborate?
> > 
> > The AF-on-TLB-miss behavior creates a second-order problem that directly
> > exacerbates the overestimation. 
> > 
> > When DAMON's mkold path clears the PMD AF, it deliberately skips the TLB 
> > flush to minimize overhead. If the dense working set fits entirely within 
> > the L2 TLB (e.g., 16MB workload using 8 PMD entries on Kunpeng 920's 2048-entry 
> > L2 TLB), subsequent hardware accesses hit the valid, stale TLB entries 
> > directly. The hardware MMU never generates a page table walk, so the 
> > in-memory PMD AF stays 0. 

Yes, that all makes sense.  But, let's not call it "stale" TLB entry.  TLB is
only for translation and the entry is doing its role.  We do not flush TLB by
purpose.  Nothing is stale here.

> > 
> > Consequently, DAMON sees `nr_accesses = 0` and assumes the region is completely 
> > cold, making it impossible to naturally track the sub-page usage shifts. When 
> > sporadic/noise accesses later hit other parts of this "seemingly cold" PMD 
> > and trigger an isolated TLB refilling, DAMON abruptly sees the whole 2MB 
> > as hot. This binary oscillation (completely blind vs. fully hot) is what 
> > drives the massive overestimation under THP.
> > 
> > We confirmed this TLB-reach aspect empirically via our T1 test:
> >   16MB THP (8 PMDs, 0.4% of L2 TLB reach) -> DAMON tracks 0 accesses (blind)
> >   16GB THP (8192 PMDs, 400% of L2 TLB reach) -> DAMON tracks normally due to natural eviction

So, it is a problem different from the previously mentioned one (showing more
hot memory), correct?  Has it reported from a real production?

DAMON does not flush TLB assuming real production systems would have anyway
large amount of working set that naturally flush TLB.  If there are real
production systems that this assumption doesn't apply, we may neeed to think
this again.

Anyway, the cover letter would be better to make this point clear.

> > 
> >>> x86 is not subject to this specific blindness under similar
> >>> conditions.
> >>
> >> To my understanding on x86, same issue exists.  If TLB hits, Aceessed
> >> bit is not set, and DAMON shows it as unaccessed.  Am I missing
> >> something?
> > 
> > You are entirely right, and I was wrong on this point. I re-checked the 
> > kernel source and verified that x86's ptep_test_and_clear_young() does NOT 
> > flush the TLB. Even ptep_clear_flush_young() on x86 deliberately skips the 
> > flush as a performance optimization (arch/x86/mm/pgtable.c:486-502). The 
> > same optimization architectural behavior exists on PowerPC and RISC-V.
> > 
> > Therefore, both architectures are theoretically vulnerable to this stale-TLB 
> > blind spot under identical tightly-fit workloads. Our initial assumption 
> > was biased because T1 was only conducted on ARM64. We will reproduce the 
> > T1 setup on x86 to verify the exact behavior, and I will correct this 
> > claim in the v2 cover letter. Thank you for catching this mistake.
> > 
> >> Nice!  Asier was planning to do similar work in future.  I think you
> >> could collaborate to reduce unnecessary duplicates!
> > 
> > Great to hear! We would be happy to collaborate with Asier. I'll reach
> > out to him to coordinate our efforts.
> Sure, I will be happy to cooperate.

Great, looking forward to your fantastic coworks!

> >> I'd suggest making the name simpler and consistent to DAMOS_COLLAPSE,
> >> though.  Say, DAMOS_SPLIT ?
> > 
> > Agreed. DAMOS_SPLIT is cleaner and fits the existing naming convention 
> > perfectly. Will rename in v2.
> > 
> >> So you implemented a debugfs interface?  That must be a nice approach
> >> for PoC.  But it may be difficult to be upstreamed as is.
> >>
> >> You could build a control plane that decides the exact address ranges
> >> to split, and directly feed it to DAMOS using DAMOS address filter.
> > 
> > The native perf event approach [3] aligns perfectly with our long-term 
> > Phase 2c plan, and we are highly interested in collaborating on it to 
> > eliminate the userspace daemon and debugfs bridge entirely.
> > 
> > However, since native kernel-side SPE handling is a long-term item, we 
> > will follow your pragmatic alternative suggestion for v2: use DAMOS address 
> > filters or user_input quota goals [2] to feed the split decisions from 
> > userspace cleanly. This allows us to upstream the core infrastructure 
> > (mTHP target_order for collapse and the new DAMOS_SPLIT action) first.
> > 
> >> Do you really need to khugepaged together, when you already have
> >> DAMOS_COLLAPSE, and anyway you are running DAMON for hugepage splits?
> > 
> > Excellent point. Running both concurrently on the same VMA introduces 
> > redundancy and heavy ping-pong effects. 
> > 
> > Option (b) is definitely cleaner: we will let DAMON handle both split and 
> > re-collapse decisions using its own access data. To make this robust in 
> > production environments where khugepaged is globally enabled, we will 
> > explore having the DAMOS_SPLIT path temporarily mark the target ranges 
> > (e.g., via a pseudo-VM_NOHUGEPAGE backing off mechanism) to prevent 
> > khugepaged from immediately undoing DAMON's work.

Can't you simply turn off khugepaged?

> > 
> >>> - The rbtree entry TTL (30s) and signal threshold (1/10 of peak) are
> >>>   empirical defaults subject to further tuning.
> >>
> >> I don't fully understand this part.  Could you please elaborate?
> > 
> > Since ARM SPE samples hardware accesses instruction-by-instruction, the raw 
> > data is highly statistical and noisy. 
> > 
> > The TTL (30s) defines the lifecycle of our per-folio rbtree tracking entries. 
> > Entries not updated within 30 seconds are pruned to prevent stale tracking data 
> > from corrupting split decisions after a workload phase change. 30s is selected 
> > to comfortably outlive DAMON's aggregation intervals while keeping the rbtree 
> > memory footprint tightly bounded.
> > 
> > The signal threshold (1/10 of peak) filters out the statistical sampling noise. 
> > Instead of treating any subpage with access > 0 as hot, the algorithm finds the 
> > peak access count inside the 2MB region and only marks sub-chunks with >= 1/10 
> > of that peak as genuinely hot. On Kunpeng 920, this specific threshold successfully 
> > reduced false-hot subpage classifications from ~50% to <5%. We plan to make 
> > these parameters sysfs-configurable.
> > 
> >>> - The ARM64 DAMON blind spot (WSS < L2 TLB reach) is a pre-existing
> >>>   hardware-MMU characteristic, not introduced by this series.  Setting
> >>>   nr_accesses/min=0 serves as an effective workaround for the split path.
> >>
> >> I don't fully understand this, too.  Could you please elaborate and
> >> enlighten me?
> > 
> > The blind spot creates an operational deadlock for the split infrastructure:
> >   1. WSS < TLB reach -> All THP entries stay cached in TLB.

But, is this really common on real production systems?

> >   2. DAMON's page-table scan yields `nr_accesses = 0` globally.
> >   3. A scheme requiring `nr_accesses.min = 1` never fires -> DAMOS_SPLIT is never invoked.

Why would you run DAMOS_SPLIT action for regions having 1 or higher
nr_accesses?  Having nr_accesses 1 or higher means the region was accessed, and
I asume you want to split THP that cold.  Shouldn't it rather target regions
having only 0 nr_accesses, as it means it is cold?

> >   4. THPs remain unsplit -> WSS remains within TLB reach -> Loop returns to step 1.
> > 
> > Setting `nr_accesses.min = 0` and `max = 0` breaks this deadlock.

Ah, yes, now I got it.  And this seems the right approach to me.  FYI
min_nr_accesses and max_nr_accesses are the terms we  usually use.

> > It forces 
> > DAMON to evaluate these seemingly "dead/cold" regions. Once the split handler 
> > invokes, it checks the ARM SPE telemetry (which captures data directly from the 
> > instruction pipeline, completely bypassing the MMU page-table AF limitation). 
> > If SPE reveals a sparse access heatmap, the split is executed. Once shattered into 
> > mTHP/base pages, the TLB reach drops, natural TLB misses resume, and DAMON's 
> > standard page-table tracking fully recovers.
> > 
> > 
> > Thanks again for your guidance. The action items for v2 are locked in:
> >   1. Rename DAMOS_MTHP_SPLIT -> DAMOS_SPLIT.
> >   2. Drop debugfs in favor of DAMOS address filters / control plane.
> >   3. Correct x86 AF behavior statements in the cover letter.
> >   4. Coordinate with Asier on split/collapse unification.

Sounds good.  Looking forward to the next version!  Also, if the blind spot is
a problem reported from the real production systems, please clarify it.

> >   5. Implement back-off to prevent khugepaged ping-pong under Option (b).

Again, why can't you just turn kdamond off?


Thanks,
SJ

[...]
