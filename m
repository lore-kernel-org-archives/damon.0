Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3E3368BD;
	Tue, 21 Jul 2026 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594881; cv=none; b=bBSr4fak6+472+VHPfJZNfWf0GADK2WuYahd0qdF+Fx4+Ltc7tjAZVT0oh5j2PAeOaEz5dgbY+bwFaf5ex+hpGUsDoJKxHB5h29E7RazSSIzQr5BwSbFY3fdWXUT075/Y2fiXovfpxAai34PIK5KbkdwGhqgr51OVCUNvjuPXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594881; c=relaxed/simple;
	bh=eXw8eShQ92zJgJxTG6i52RVei5ncVISs0dertqkyzW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7YAGbUcaSIQ7T9uw+fFuB0TxPylzHBKrdf9fIa/gmda4hkm/2yNNr6ut6wyMDWcS+ZVDQUDEDEtsW4El5yHMEONMNXt+aae2FlvGzhnn8aD2iTtMF7zM6IA6S9rBjhDm2rRrdyjIb6zlAngzTsbeldSvZOPgCajyCniT4DHRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ+JOotz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ+JOotz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FB21F000E9;
	Tue, 21 Jul 2026 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594879;
	bh=0BYYLROr1KG9jlLLfTtwXV9u2OCUpqCq1wscUtJCU88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZ+JOotzLCADPj5ZcLz4qpPhReX0z96lHAj/QsuIidRGnjPTkxvw7/2YObTqfndrF
	 SeqoFMMVq3fuDvXE2HYlDnC5EkoXzW/yN5Bwr7zgcDl27z8dN7kKcwA2SfihqsgKuN
	 JrNxYXkH73ogcRbEbUPbeVsOhrcGF4axGQF9+vjZ6/dMmzcP0qHDwRwi8e6yhg8q2Z
	 wKNXSHIUrmqb4YJ4/KipcPYAQpxyprzaJCwyQjbDQhqdJX0a8KUcsK69hNpZMogpOW
	 wM1aGiVY61F3NvJ4tZeCW4lJ313MMc9tMgBZ4K0K7/ZgY6GfiBzzBNlyjqd6kZxR95
	 sJw4M2TziIBNg==
From: SJ Park <sj@kernel.org>
To: "Zi Yan" <ziy@nvidia.com>
Cc: SJ Park <sj@kernel.org>,
	"Lian Wang" <lianux.mm@gmail.com>,
	david@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
Date: Mon, 20 Jul 2026 17:47:55 -0700
Message-ID: <20260721004755.93824-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DK3MYJN8KSZ5.1U0STUJGETSJH@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 20 Jul 2026 15:12:50 -0400 "Zi Yan" <ziy@nvidia.com> wrote:

> On Mon Jul 20, 2026 at 5:56 AM EDT, Lian Wang wrote:
> > Hi David,
> >
> > On 7/20/2026 10:44 AM, David Hildenbrand (Arm) wrote:
> >> you give no real motivation and evaluation why this is required or
> >> why this gives the user any benefit.
> >> A SPLIT with an explicit order is not really want we want and it
> >> does not fit the existing primitives.
> >
> > Thank you for the direct feedback.  Let me explain where this came
> > from -- the cover letter should have included this context.
> >
> > This started from a real problem at Sangfor.  The scenario is:
> >
> >   KVM-QEMU virtualization on Kunpeng 920, with KVM guest memory
> >   backed by tmpfs shared mappings (THP=always on the host).  An
> >   Oracle database runs inside the VM.  DAMON monitors the KVM
> >   process on the host to measure the hot-memory ratio.
> >
> >   The KVM process allocates and uses a large amount of memory.
> >   Under the same workload, DAMON reports a significantly higher
> >   hot-memory ratio with THP enabled versus THP disabled.  Direct
> >   tmpfs write tests inside the VM -- touching at 4K and 2M
> >   strides -- show a clear gap between the two cases.
> >
> >   DAMON parameters used:
> >
> >     operations=vaddr
> >     monitoring_attrs/nr_regions/min=500
> >     monitoring_attrs/nr_regions/max=2000
> >     monitoring_attrs/intervals/sample_us=500000
> >     monitoring_attrs/intervals/aggr_us=20000000
> >     monitoring_attrs/intervals/update_us=60000000

Thank you for sharing your detailed setup.  It is helpful.  Btw, have you
considered using intervals auto-tuning [1]?

> >     schemes/0/action=stat
> >     schemes/0/access_pattern/nr_accesses/min=1
> >     schemes/0/access_pattern/nr_accesses/max=max
> >
> > The underlying issue is that under PMD-mapped THP, DAMON's monitoring
> > granularity is coarser than the actual working set -- a single
> > Accessed bit covers 512 base pages.  Before SJ's probe infrastructure
> > arrives, there is a gap: DAMON cannot distinguish hot sub-pages from
> > cold ones within a single THP.
> >
> > Split is one possible mechanism to bridge that gap -- by dismantling
> > the PMD mapping, each base page gets its own PTE Accessed bit and
> > DAMON recovers fine-grain monitoring.

Thank you for clarifying the motivation of this series.

To me, it's still unclear what is the real user impact, though.  I mean, I can
understand DAMON suddenly reporting more hot memory can surprise some people.
But, why that matters in what extent for your use case?  You may not run DAMON
on your system only to read the information.  You may run it to do something
beneficial using the information.  What is that, and how badly degraded DAMON's
monitoring results affect it?

Overall, unless the real impact is serious, splitting huge pages only for
better DAMON monitoring sounds like not a good tradeoff.  You will increase
DAMON overhead and lose THP benefits in some extent.

> > It is not intended to be a
> > permanent API, and certainly not "the opposite of collapse".

Once it is added to the kernel, we have to support it for long term.  Let's not
introduce something for only temporal use.

> 
> If you just want PTE level access bit information, why not split PMD
> mapping instead of the THP itself?
> 
> In addition, the issue is about access monitoring granularity in DAMON,
> why should user care and know about THP split operations? I would expect
> DAMON detects the inability of getting fine grain access information and
> split the PMD mapping itself instead of a user initiated DAMON_SPLIT. If
> that is not possible with DAMON, an alternative is to provide something
> more generic like DAMON_SAMPLE, which does the split under the hood,
> instead of exposing MM internal operations.

Thank you for good opinion, Zi.  I agree all the points.  That said, I still
want to understand the problem first.

> 
> >
> > I did not write this scenario into the cover letter because our test
> > results do not yet show a clear quantitative benefit worth claiming,
> > and I did not want to oversell.  Without the context, I understand it
> > looks like I randomly proposed a new primitive -- that was not the
> > intention.
> >
> > SJ acknowledged [1] that the monitoring problem under THP is real.

Yes, the behavior is real and I agree your theory of how it happens.  I don't
clearly understand if it is really bad in what situations, though.

> > My RFC is a concrete proposal to start the discussion.  If split with
> > an explicit order is not the right primitive, I would appreciate your
> > thoughts on what the correct DAMOS abstraction for this should be.

Only after understanding what is the problem and how bad it is, we will be able
to think of different approaches and assess those.  To me, it is still unclear
what is the real problem and how bad it is.  I will wait for your further
clarifications of those.

> >
> > [1] https://lore.kernel.org/20260620203915.82947-1-sj@kernel.org/

[1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#monitoring-intervals-auto-tuning


Thanks,
SJ

[...]
