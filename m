Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7738239E;
	Tue,  1 Sep 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272596; cv=none; b=qYw63eWUADt1z67WMBvY53oJAExQmvPin/2b4UI680saeCOFYqLF6SjKb7AMLPntduINpCSLpSUyCFGQuYq9KpNoCVhVTdbkSiC5EFwMrVsqaz44d7Wq/3J1nJ3Ub9sJJilL+4Opu2DOy4xOQwkCTlXn1ZleLvTkTNdv0YBuQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272596; c=relaxed/simple;
	bh=gUuI0GhsK1yS1mGIQXyP8DKxvToNm2loMMwqydRKzZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IESTztZbNSW0J+h3JExpfiLrIeIvi2SucvdYVmUHPsAwBq22t/biriiJAi8JoZTBetXgM/htix5cojJNcsyXuFWfOk+eo1ruJR/WGvraRqjb6nzzA4JyxWgBn2h+ND8LF3CgYFuuyIVXqKVrg+KKukrTDG1GZIt/BA1/VwXJ23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPHfjvFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPHfjvFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B31F000E9;
	Tue,  1 Sep 2026 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272595;
	bh=HAnWOLBaYdAhbX/W7o4srvf+nw40P/4MunhygRfNOJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DPHfjvFXIyEpaCxKqRMtNK5UBj6fVVRSReoO7SSt9q74/XFmvDeLdUHGkjCfl7T88
	 dHNnM45LM7ZeVd+cCgot6x0CHgRLRUe1BYxTlwFUQn5QBJRE1mqyiI9N83vKyddo7Q
	 LMKF0fasYGqgRbWMG2WvXU1GDlOA6ZPV7Jc+zMW1+OGN5NBzDYUd051dkc6mNowGvA
	 XUMDvHlQqyTKqFZ5b8Fm5zmXnj50AbxlgTkE0WiDXaT2GQFC2HTZiyzZ6YGnw/GBY4
	 4bbk7HKIvRif63485w0YiniA1/cBiycD2iiuH/3on6ou4nJQTP2OwYMgVIWiG5NNP1
	 68jliECJSBwEg==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Tue,  1 Sep 2026 07:23:07 -0700
Message-ID: <20260901142307.100701-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901065847.42869-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lian,

On Tue,  1 Sep 2026 14:58:35 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Hi SJ and Asier,
> 
> Thanks for working on this and for providing the server results.  I have two
> questions about what hugepage_mem_bp is intended to represent.
> 
> > Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. Add a new DAMOS quota
> > goal metric to measure the amount of huge page consumption to total
> > memory consumption ratio.
> 
> First, NR_ANON_THPS tracks anonymous PMD mappings, while NR_SHMEM_THPS and
> NR_FILE_THPS track PMD-mappable page-cache folios.  Therefore, splitting only
> an anonymous PMD mapping can change hugepage_mem_bp without physically
> splitting the folio.  Is the intended metric PMD-mapped memory or physical
> large-folio memory?  Clarifying this and adding a mapping-only test may help.

Good point.  I was just missing this.  So, hugepage_mem_bp is not accounting
anon mTHPs, right?  Since hugepage_mem_bp is for general hugepages, I think
this is better to be improved.  Seems using MTHP_STAT_NR_ANON that is exposed
as 'nr_anon' can be used?  Because this is an improvement rather than a fix of
a bug, I think doing this as either a followup or new version of this series
are ok.  Asier, what do you think?

> 
> Second, the metric is global while a DAMOS scheme can target one process.

Actually it can target multiple processes if those are in single DAMON context.

> THPs from other processes or NUMA nodes can satisfy the target or dilute the
> monitored process's changes.  Is this intentional?

I think it is intentional.  The user should have the control on collapsing
hugepages, or believe the uncontrolled collapse mechanisms.

> If so, documenting the
> scope and testing a background THP workload may be useful.

More documentation and testing are always welcome :)

> 
> The temporal results approach the 10% and 25% targets, while the consistent
> results overshoot the 10% target to about 20% and 45%.  I would describe this
> as control-response data.  TPS, latency, TLB, fragmentation and collapse CPU
> data could further show the workload benefit and cost.

Yes, those would be helpful.  That's not mandatory for this simple change in my
opinion, though.  I would let Asier decide whether and when to make and share
such data.

> 
> If I have misunderstood any of this, please feel free to ignore these
> comments and correct me.

Your comments are very helpful, thank you for your review and comments, Lian.

> 
> The enum, quota-goal wiring and sysfs exposure otherwise look consistent with
> the existing DAMOS autotuning framework.  I consider the points above
> follow-up questions about semantics and evaluation, rather than blockers for
> this series.

I agree.

> 
> For the series:
> 
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thank you!

> 
> Please feel free to Cc me on related follow-up patches.  I am happy to help
> review the code.  Besides my own DAMON work, I have recently been reviewing
> and learning from other DAMON and MM work, and I would be glad to continue.

I'm curious if you and general reviewers need or prefer to directly be Cc-ed.
I was naively thinking people can search and review DAMON patches by
subscribing to the mailing list or using the archives via lore.kernel.org like
tools.


Thanks,
SJ

[...]
