Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34F33B6CC;
	Wed, 30 Sep 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755732; cv=none; b=W5L+MFYX55HI2mVrcTtZ/Vy2wH8LzrN3mySWQJPAgEE116rtL3vimXyDwdIXN960IzjsDzfRJ4wh3V1zqVKIv2a8upea79t2KTLPvk1dlnRjQYUOUg6sMhU8FyZq18jvR6120ZcRQ2t612xJNRQA2th56BruDwim8tVnGTRQ2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755732; c=relaxed/simple;
	bh=3jpX3++RlolaBIRiSpDY68a58XgumXoiTLt1jbMCgN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGw72l8xGqJ9EJD8++sq23XNR8bY8kej8zR3Q/tDhIhRDZfyllD9UM7dD4vk/Vxd4dAfIpVq4zmayWASw8son1n7/RFbEQlMcyVfbAk90/9OYd8nKB2MIT12YDYbohdWRyr1VnuI/Mg6Ko6eFlcTZjPeC3OdieBgyL1VYse+oVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XggV0HEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XggV0HEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652C11F000FF;
	Wed, 30 Sep 2026 08:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755725;
	bh=EgiI2zzwe8TB/ZW7XItAedr7ZYnB5/cnPC/QFupZv60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XggV0HEx4iFhJNOcs0B7+qgnbnzi6NXR5MD9WbJ7i65myhUAHSTmNy6Ac7ZhgF93d
	 2vR5/dLU6+PjoDXGP0wPigAZTRWnD4cYe93FRgqToAC/9KtR1TRCOPpUfK1jTaFzcg
	 3QSk8SN+ocw23C9X3rs/lQqj5dU9+xFAZcjAq0qKugUCSA5GX3Lg/OQCQNttM5ycih
	 yIRoFMzfv495BHVUK4a4Mbe5MWHkXqbu779h24yeOclupcxVOTD6VmFgL9EsiFqOtM
	 VrzmxBcdP4ebr6Sk9sQI/LUDhMnozE4r0E2FYr9xxMez6HkxaAA5nDEzc8expHpxR2
	 P8GOR9B/XDPtA==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jialiang Huang <huang-jl@deepseek.com>,
	lance.yang@linux.dev,
	KunWu Chan <kunwu.chan@gmail.com>,
	baohua@kernel.org,
	damon@lists.linux.dev,
	david@kernel.org,
	linux-mm@kvack.org,
	mst@redhat.com,
	ryncsn@gmail.com,
	virtualization@lists.linux.dev,
	xueyuan.chen21@gmail.com,
	xiang@kernel.org
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Wed, 30 Sep 2026 01:08:38 -0700
Message-ID: <20260930080838.10887-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930030747.47294-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lian,

On Wed, 30 Sep 2026 11:07:29 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Hi SJ,
> 
> On Tue, 29 Sep 2026 09:56:03 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > I agree the reclaim-reporting granularity mismatch could be a room to improve.
> 
> Thanks for pointing us back to the Access/Contiguity-aware Memory
> Autoscaling proposal. Jialiang's description gives us a useful deployment
> context and a concrete problem to investigate.
> 
> The guest reclaim/reporting case and our host-side THP/tiering case are
> different, but both raise questions about how workload behaviour and
> monitoring granularity should guide kernel actions.
> 
> KunWu and I would like to help move this work forward together, alongside
> the existing DAMON roadmap. For now, I would like to share a few possible
> areas for discussion:
> 
> 1. Workloads, DAMON policies, and tiering. My current work includes
>    improving masim-based experiments and studying TPP-inspired memory
>    tiering. We would like to make the workloads more representative and
>    better understand how DAMON's observations and policy settings affect
>    placement decisions. The aim is to understand where configuration
>    changes are sufficient and where code changes, if any, would help.
> 
> 2. Testing and contributing to the existing PMU work. Our initial focus
>    would be on helping with the Arm SPE integration and testing the IBS
>    and PEBS work on x86, in coordination with the people already working
>    on these. The experiments could evaluate whether finer-grained
>    sampling provides useful additional information, and at what CPU
>    cost. We could leave huge-page-specific mechanisms for a later
>    discussion, guided by the results.
> 
> 3. Following up on the DeepSeek workload. If the team is interested, we
>    could learn more about the workloads and tuning questions they can
>    share, and study the path from workload behaviour and monitoring
>    parameters through reclaim and free-page reporting. Pratyush's
>    reporting-delay suggestion adds another useful dimension. This may
>    provide a practical starting point for revisiting parts of the
>    access/contiguity-aware autoscaling work and evaluating their
>    relevance to the reported workload.
> 
> Could we discuss whether some of these could become follow-up milestones
> in the DAMON discussions at LPC, or here on the mailing list?

Thank you for adding topics to discuss.

Of course we could disucss anywhere anytime.  I think Access/Contituity-aware
Memory Autoscaling (ACMA) could be just a parallel project.  It doens't need to
be an extension of, or blocked by "beyond-page table access bit" project, in my
humble opinion.

ACMA is still on my TODO list.  It is mainly a matter of prioritization.  As it
becomes clear it requires more attention, I could allocate more time for the
project.  There was a user showing interest recently.  I'm planning to
prioritize it more.  If DeepSeek could confirm their interest, it could help me
prioritizing it further.

As always, coding may not be that difficult and take that long time.  Testing
might be the biggest challenge.  I don't have good test infrastructure now.
Actually the lack of good test infrastructure is one of my biggest DAMON
maintenance concerns nowadays.  Others' help on testing or test infra would be
super helpful.

If someone wants to implement and contribute it based on the proposed idea, it
would also be nice.

> We would be
> happy to help organise the discussion and take on agreed pieces of
> testing or development. We would also welcome closer collaboration with
> DeepSeek and other interested MM developers, including Muchun, where our
> work overlaps.

Sounds great.  That would be super productive collaborations.

> 
> This is only a brief outline for now. I plan to bring the experimental
> results and remaining questions to LPC. After discussing and aligning on
> the details there, we plan to share a more detailed proposal with the
> community and write up the planned work and experimental findings in
> blog posts.

We could keep discussing in mailing list, but of course in person discussions
are always helpful.  I'm eagerly looking forward to the next week :)

> 
> I appreciate how much is already on your schedule. We hope to support
> the existing plans and help with agreed tasks as the scope becomes
> clearer. There is no urgency to reply; we can discuss these ideas
> whenever it fits your schedule.

Appreciate your continued and grateful contributions, Lian.


Thanks,
SJ

[...]
