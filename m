Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92A299927;
	Wed, 29 Jul 2026 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288129; cv=none; b=QkqMmC7ezmYHCFLnHhX+wyWSWbCgGJwfhaAMlHZPXRVICUumHZRCKhLX34/kvCj24lHeTIiNOZ+kb1WMyMwXmDpCO/OB5seUs6oIrzWfOQgvkGHQZXwNFqycAePVQOXtDY1/OuSyIfT41gAw8KY77ov2eKjd1l+lsUiw6TrbLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288129; c=relaxed/simple;
	bh=AjYee3AvUlawK8sahONTWVst5h1KjAK167T6BS9tVmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7pix2nRpbVLEqz3zYu91U+9AAMIQ0YF3Do2Ss8j7VjnLGdigQwK0R5qv3dgBjQR6TNk33Rf1VGDUZB6puJfoCOAVxutdRGBJaz71UIXPRREdm8fhE2+kqNEqc2k2+OcF87O+Gb0QbyB5XKBFI3o/QYfjJIdYVMhMr3R8s0lh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilMzXKMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilMzXKMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CFA1F00A3D;
	Wed, 29 Jul 2026 01:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785288128;
	bh=0t+IAasOBTAZXdXVEKb9SrgtdAFOWGHpWG5YeS1gqYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ilMzXKMFyYAdxLu8llGrYeS8DZhGN0EyufAWHOK8i2Xq3AKDxcZk8W3osWsNYwHoN
	 k/SYFoyuT0z8x+dZ/nCJ01WD/90pwIxoAbZHpnFsrQrIqQWf8lpUENXC5vtfYoCOaB
	 6IImUXw2GWfLEpMU0jXHnGrx9MzSTZZp61qPjf8Xw5VebWu2LuaxRO88kosPZV7zXK
	 S9O80Ao9P4zMGDpmUJp9SJbMLhfOpO6kgl3Qz/WbDP2knVHqZDq4cXC9QZHzTtz94C
	 aXY0LY9zS+bhVh8QvLmwwjPMhbGVEL9YVrLgrSObnrMMsh2eqYtL6qD9MRsW0mK3dV
	 0g0kqrz5Vg7HQ==
From: SJ Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas with per-range regions
Date: Tue, 28 Jul 2026 18:21:59 -0700
Message-ID: <20260729012200.98442-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1c815b59-915a-414c-9029-eaac11dcf804@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 23:17:01 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> 
> On 7/28/26 10:30 PM, SJ Park wrote:
> > On Tue, 28 Jul 2026 18:06:48 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >
> >> On 7/27/26 10:26 PM, SJ Park wrote:
> >>> Hello Jiayuan,
> >>>
> >>> On Mon, 27 Jul 2026 17:54:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >>>
> >>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
[...]
> > Actually I was also thinking about this problem for in the past.  One of my
> > idea at that time was, handle only a few largest holes that practically being
> > problems.  That is, while reading the system ram layout, find the holes, sort
> > those by size, and do make holes in DAMON regions layout for the biggest N
> > (say, 2) holes.  This may handle most cases including your 5 TiB hole.
> > Actually vaddr is doing this, so we may be able to reuse some of the code.
> >
> > If it makes sense to you, I will try to implement this.
> 
> One worry with a fixed N is that it's a magic number. If a machine has more
> than N big holes (more sockets / NUMA nodes, or several CXL devices), the
> extra ones are silently not excluded and get walked again.
> 
> And making N configurable just moves the per-machine tuning back to the
> user, which is exactly what I'm trying to avoid.
> 
> vaddr over-includes the gaps into its regions too, but it can skip them
> cheaply: it walks the VMA tree (find_vma / maple tree), it's cheap.
> paddr has no such structure, so an included hole is walked in full.
> 
> That's why a fixed N is safe for vaddr but risky for paddr.

I agree it has the problem of magic number.  That said, I expect common systems
wouldn't have that many problematic large holes.  If it is not clearly wrong,
I'd consider starting with magic number 2.  I feel magic number 2 is appealing
probably because we could reuse vaddr's code in the case.  But it would already
be much better than nothing in the problematic setups.  At least it will cover
your 5 TiB hole.

Depending on what we learn from the fields, we could change the magic number or
add more optimizations in future.  Setting N as a fraction of max_nr_regions
and/or handling holes based on their size (relative to real System RAMs?) are a
few ideas off the top of my head.

> 
> 
> >>> user-visible parameters and internal state is also a concern.
> >>
> >> I think monitor_region_start/end is meant to expose the overall range, and
> >> skipping the holes inside it is an implementation detail. Even if we didn't
> >> skip them, the adaptive region count is never 1 anyway — DAMON already
> >> splits [first,last] into many regions. The holes just add a few more, so
> >> the param never matched the internal state exactly to begin with.
> > It is arguable, but I believe this also makes sense in my opinion.
> >
> >>
> >>> A quick workaround would be adjusting the memory layout in BIOS, using DAMON
> >>> sysfs interface instead, or setting the monitor_region_{start,end} to cover
> >>> only the single area.  Have you considered such workarounds?
> >>>
> >>> Let's complete this high level discussion first.
> >>
> >> Right, this is doable today — the DAMON sysfs interface can set multiple
> >>
> >> regions manually. This patch is only about convenience.
> > Are you actually running DAMON_LRU_SORT or DAMON_RECLAIM in a production system
> > having 5 TiB hole?  Or, planning to do?  If the above idea makes sense to you,
> > I could prioritize implementation of it depending on this.
> 
> 
> I'm not actually running DAMON_LRU_SORT or DAMON_RECLAIM on such a machine.

Thank you for clarifying!  Let's keep this brainstorm level discussion, then.

> I ran into this while working on per-cgroup hot/cold page tracking, where I
> was comparing performance and accuracy across setups — that's where these
> numbers came from.

Sounds interesting.  Btw, there are multiple ways to do per-cgroup monitoring.
Using DAMOS_STAT with memcg DAMOS filter is one of the ways.  Data
access-as-a-data-attribute patch series [1] will allow doing that in a much
more lightweight and flexible way.

> 
> 
> >
> > Thanks,
> > SJ
> >
> > [...]
> 
> 
> 
> And to be clear, I'm not trying to land a patch here — I just noticed this
> as a possible optimization. If you have a better idea, I'm happy to go with
> it :).

No worry!  FYI, using subject tag 'RFC' could be a good way to make the
intention more explicit, if you want.

[1] https://lore.kernel.org/20260728041242.187380-1-sj@kernel.org


Thanks,
SJ
