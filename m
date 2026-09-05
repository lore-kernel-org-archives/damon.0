Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDE368D45
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788627150; cv=none; b=CQavA5yA+wWuATvuql3C5GZv7v8UrdW/M+EEGYiT6YRuFmGIlBfRdxr5YZajL08I0YngDBVWe3a+jOdZjiCS0Mi5YthZeAbInq/JymqH0zo9+QPU5of5gHqvuyS87AA68KCa6lTt7etaY9HTGEmTNbhU3kFfYkc/I+aXCE4RYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788627150; c=relaxed/simple;
	bh=uK5ERlxda1rAEDQRVOrVJT9lk1PtbRdW2voD2aCX2B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEj0FTgyxLoiSPadGvn3OrVFAhaIWgo4MRCdk6jnbDozIF49hFxwap9segoErTQlcrF6Z77+BjpfYqgnlLF9vViDUrEnQJoggL10S6+2EpoPvvkrc2sLhZ3jWJ7IcGoVNs99+ktY/z04ZGwNnSuSV9jhkzO640bPNU5JjIOK6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df3yij/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df3yij/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4BA1F00A3A;
	Sat,  5 Sep 2026 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788627148;
	bh=1C2eg3cenbcfacI4YbTnX7lIlYM2EwRcdmw9F9GajEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Df3yij/LQmtO49IV0phC66lZPqsI5fIa4iyHaeVONOqZJHjPaV/Hx+XWVCq0kEiaI
	 8PQ4dO+PYALtEIOIFwqaxttCI7Tg76K9BQwXGp8q2vn+8v4ucL3P7l6xALE3bjFoq6
	 aoOM+z8GGnLnnCI4snSXjhguHkhz8i4WcD9BVh60+dLkKSWW+ARh8a+CD+syhW2ZVp
	 ez/7jAQQnquCslXJ9gkp46WQeYawra8CMbUaov5kijGWLDfEFzz2uPDqE+vKKs1evy
	 A8VwNUBwXaw4EgDZ71SBHrDUO4V25lgNfYoDHp2GYlyTbHDgcy8kpP8wut9bMpP28K
	 cJrPKpmbQum2A==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
Date: Sat,  5 Sep 2026 09:52:20 -0700
Message-ID: <20260905165221.83994-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711004808.32620-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 17:48:08 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed, 24 Jun 2026 07:56:14 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 25 May 2026 15:52:08 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > Hello,
> > > 
> > > 
> > > TLDR: Let's extend DAMON for data attributes monitoring, andd then further
> > > extend that for multiple access check primitives including page faults, perf
> > > memory-access events and optimized AMD IBS-like h/w feature drivers.
> > [...] 
> > > Roadmap
> > > =======
> > > 
> > > Assuming you agree to use the data attributes monitoring interface, I suggest
> > > us to do the work in below roadmap.
> > > 
> > > Milestone 1: PTE Accessed bit as one of the data attributes
> > > -----------------------------------------------------------
> > > 
> > > I will work on stabilizing and further extending the data attributes interface
> > > and internal framework to be able to support PTE Accessed bit.  This may take
> > > no small amount of efforts, but hopefully doable by the end of this year.
> > 
> > Let me share more detailed plan for this milestone.  Nothing is set on the
> > stone.  Everything can be changed on the road.
> > 
> > The overall goal is, making attributes monitoring be able to do everything we
> > are doing now with PTE Accessed-bit based monitoring.  It is needed because we
> > want to do everythin we can do now with the PMU/page fault-based DAMON.  Also
> > it is needed because we will need to deprecate nr_accesses in long term without
> > breaking users.  For this, below changes will be made.
[...]
> > 3. Extend attrs for PTE Accessed bit check
> > 
> > Further, we will extend DAMON attributes monitoring to handle PTE Accessed bit
> > check.  We will extend it to let users configure probing preparation
> > operations.  The first operation to support will be the PTE Accessed bit
> > clearing operation.  Together, we will introduce new DAMON probe filter that
> > checks the PTE Accessed bit.  Using those, users will be able to do the
> > PTE Accessed bit based access monitoring in attrs-only monitoring mode.
> 
> I have a hacking level prototype for this in damon/next tree.  I will take more
> time for stabilizing it.  I'm aiming to make this be merged into 7.4-rc1.

The patch series [1] for this is now merged into mm.git.  Hopefully it will be
merged into 7.4-rc1 as planned.

Note that the series is supporting only paddr.  I'm working on extending it for
vaddr.  Actually there were user requests for this.  A working prototype is in
damon/next.

> 
> > 
> > 4. Extend attrs for DAMOS
> > 
> > Finally, we will extend DAMOS to be able to run with probe_hits.  That is, it
> > will be extended to let users configure the DAMOS target access pattern and do
> > its quota-prioritization based on the probe_hits.
> > 
> > After the four major changes are made, the attributes only mode DAMON can do
> > everything current DAAMON is doing, without nr_accesses.  We will then move on
> > to the milestone 2 of this project, and start a long term nr_accesses
> > deprecation.
> > 
> > I hope all changes to be landed by 7.5-rc1.

I'm now working on this.  Actually there were user requests for this.  A
working prototype implementation of an essential change is in damon/next.
Hopefully that will be landed by 7.5-rc1.  Some additional works for full DAMOS
support are expected, and those may be done after 7.5-rc1.

> 
> So I believe we are still on the track :)
> 
> [1] moving sum: https://lore.kernel.org/20260703170605.94472-1-sj@kernel.org
> [2] attrs-only: https://lore.kerrnel.org/20260710134651.18084-1-sj@kernel.org
> [3] attrs-only enqueue notice:
>     https://lore.kernel.org/20260710202349.2F2DA1F000E9@smtp.kernel.org/

[1] https://lore.kernel.org/20260901132506.99243-1-sj@kernel.org


Thanks,
SJ

[...]
