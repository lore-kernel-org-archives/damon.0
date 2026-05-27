Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5A1684B0
	for <damon@lists.linux.dev>; Wed, 27 May 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840706; cv=none; b=fOhgEMvgB4JnTy1CGBJwn3pHyvZD1LYpC8Kb9rPVnOM3X3k5GG3JEiTKQRU8DuVgUperyAlsTu0Br58aEdPikH65FmEisQzrkhcHQY2IF+9LeXXzVXRjJLQfT7kwvMT9GzL39ADpYMdchR6YNgSWxED2MVgU9p6y/Z91sIcGlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840706; c=relaxed/simple;
	bh=i6a0UtZSt9bLT6c+ahXNSAIDoxPSfZo1tbdYZgpRpv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3RseCIwPHs5/mqeHLR7rtfbSN21BSw5LYlY+Nyy74wAm1VwJPKEG7s6CNtGqmccmCGE2JTqb/oD5XaDlzR9KSvFwYj4kzL5lkNMpHbyZ/j59rVtNvgoGyXyaxEWraX1X/Kciy2TbfyrFIAiFwrY35eo03Ac5KQzUqjjHIgjLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JygJVIVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JygJVIVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DF91F000E9;
	Wed, 27 May 2026 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779840688;
	bh=QIV8y91rknjUQu6xhjrUlHbv7tS9XdlNQb6ZILAjQNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JygJVIVdrWZTneGOfWKe4wGJPLOODWT1L9KrBTs1EtMB52VHMhjWWAxzInjurknX7
	 Z5JYQvVQc42HckdXHoRPK+CPgNMcvW7EkkYWYlDBXGPtFaj/sn1IQUmzHY2F2aQO8R
	 7+MamaG+PhLfEnTIWkP4lAQJcu+9GJbc/RQ7IYaG/RMcajfhqG1wxVq1NWB9SNOxnt
	 m8NqYCFMQOozROJgOWDQZWi32GOaHCwu4PqBq13Kw073ijuHN+NazpsGeWp4aYy932
	 0H9Y5SCLCwMJEUFIK3WXLypCC37pK+aaue0t7GpWzlG6srztB120P+E4mUh3oNr+kq
	 ZETANCAhI2wOw==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
Date: Tue, 26 May 2026 17:11:18 -0700
Message-ID: <20260527001119.29147-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y150x1ATN8xSJegyS=r9f8ySOFf+KuqmiDoE41vQb-Ky4g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 14:46:14 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Tue, May 26, 2026 at 7:29 AM Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > Hi SeongJae,
> >
> > 2026年5月26日(火) 7:52 SeongJae Park <sj@kernel.org>:
> > >
> > > Hello,
> > >
> > >
> > > TLDR: Let's extend DAMON for data attributes monitoring, andd then further
> > > extend that for multiple access check primitives including page faults, perf
> > > memory-access events and optimized AMD IBS-like h/w feature drivers.
> > >
> > > Ongoing Projects
> > > ================
> > >
> > > At the moment, DAMON is utilizing page table accessed bits as its major access
> > > check primitive.  Because of the limitations in the primitive, interests in
> > > extending DAMON to use different access check primitives, including page fault
> > > events and h/w features such as AMD IBS, were expressed multiple times.
> > >
> > > I started working [1] on the page fault events based extension for
> > > per-CPUs/threads/reads/writes monitoring.  Akinobu is working [2] on perf
> > > events based extension for lower overhead fixed granularity monitoring.  Ravi
> > > is working [3] on AMD IBS based extension for memory tiering.
> > >
> > > Xin Hao proposed [4] extending DAMON for NUMA systems in 2022.  Pedro Demarchi
> > > Gomes proposed [5,6] extending DAMON for write-only monitoring in 2022 and
> > > 2025.  My page faults based monitoring extension is partly for their projects.
> > >
> > > Types of Required Works
> > > =======================
> > >
> > > Each work commonly requires three types of changes.  Startign from the lowest
> > > layer, the required changes are as below.
> > >
> > > Firstly, we need to extend existing DAMON operation set (paddr and vaddr) or
> > > implement a new one for controlling the new access check primitives.  This
> > > part, at least for page fault events and perf events are not overlapping and we
> > > could work in parallel.
> > >
> > > Secondly, we need DAMON core layer change for the reporting-based access check.
> > > Page table accessed bits are set by h/w and DAMON does nothing about it.  DAMON
> > > wait until h/w sets the bits, and later harvest the information by reading the
> > > bits.  In other words, DAMON only "pulls" the information.  For page faults and
> > > perf events like primitives, we need to hook the access events and "push" the
> > > information to DAMON.  For the page fault events based extension [1], I
> > > implemented damon_report_access() and related infrastructure for this purpose.
> > > The implementation is quite unoptimized.  But I believe the design is good
> > > enough for long term maintainability.  I want us to use this framework.  We can
> > > make it works first, and later optimize.
> > >
> > > Finally, we need DAMON user interface.  For the page fault events based
> > > extension [1], I introduced access sampling control interface.  The idea is
> > > letting users control the access sampling in a more detailed way.   At that
> > > time, I was thinking it is long term maintainable and Akinobu and I could reuse
> > > it.  I still think it would work.  But, I recently got another idea.
> > >
> > > The new idea is extending DAMON for general data attributes monitoring.  The
> > > first change [7] for making it able to monitor not only data access but also
> > > general dasta attributes including anonymity of the pages and belonging memory
> > > cgroup is recently merged into mm.git.  As the cover letter of the patch series
> > > is also explaining, the work has started for light-weight per-cgroup access
> > > monitoring.  But, in long term, we want to make data access information as just
> > > one of the supported data attributes.  Then, we can further extend access
> > > confirmation coming from different primitives as different data attributes.
> > > For example, in addition to "PTE Accessed-bit" attribute, we can add "perf
> > > event mem-access reported" attribute and "AMD IBS access reported" attribute.
> > > I think this is long term maintainable and therefore want us to use this
> > > interface.
> > >
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
> > >
> > > Milestone 2: First damon_report_access()-based data attribute monitoring
> > > ------------------------------------------------------------------------
> > >
> > > Once the first milestone is completed, we will add the damon_report_access()
> > > and related infrastructure changes into the DAMON core.  On top of it, we will
> > > further implement the first data attribute that utilizing the reporting
> > > infrastructure.  I personally think the perf event based one is a good target
> > > at the momentt.  I think so mainly because the perf maintainers didn't show
> > > special concern yet.  We can discuss the target again after the first milestone
> > > is completed, though.  Hopefully this is doable by the LSFMMBPF 2027.
> > >
> > > The timeline is just a gut feeling.  It could be done much earlier or later.
> > >
> > > Milestone 3: Parallel extenstion for other primitives
> > > -----------------------------------------------------
> > >
> > > After milestone 2 is done, we have the user interface and the infrastructure.
> > > We will be able to further implement our favorite access check primitives on
> > > top of it in individual schedule, without blocked by each other.
> > >
> > > Collaboration
> > > =============
> > >
> > > Milestone 1 and damon_report_access() part of milestone 2 would need to
> > > primarly done by myself.  If you are interested in this project, reviewing the
> > > patches that I will post for the milestones and doing some testing would be
> > > very helpful.
> > >
> > > For the second half of milestone 2, I may need more help from Akinobu, Ravi or
> > > someone else who may experienced with the first target primitive.  Maybe I
> > > could develop the damon_report_access() part and post it on the mailing list,
> > > and the other collaborator could further develop the first target primitive
> > > extension on top of the patches, like we did for vaddr page interleaving.
> > > Let's discuss the details after milestone 1, though.
> > >
> > > Request For Comments
> > > ====================
> > >
> > > I would appreciate any inputs about this roadmap and plan.  I'm primarily
> > > curious if the plan and the timeline makes sense to Akinobu and Ravi, who are
> > > actively working on, and might need to wait for my milestone 1.  Also if there
> > > are people who interested in this, please feel free to add your inputs publicly
> > > or privately, in your preferred way.
> >
> > The roadmap and plan are reasonable, and I have no objections.
> >
> > Ravi and I need a damon_report_access() interface that has a per-CPU buffer and
> > can be called from the perf overflow handler for each project.
> > Can we expect that the infrastructure to achieve this will be implemented in
> > Milestone 1 or 2?
> >
> 
> Hi Akinobu,
> 
> The per-CPU NMI-safe ring is already on lore as patch 3/7 of the
> IBS RFC I posted earlier this month:
> 
>   [RFC PATCH 3/7] mm/damon/core: replace mutex-protected report buffer
>                   with per-CPU lockless ring
>   https://lore.kernel.org/20260516223439.4033-4-ravis.opensrc@gmail.com
> 
> A drain-side improvement is also worth picking from the same series:
> 
>   [RFC PATCH 4/7] mm/damon/core: flat-array snapshot + bsearch
>                   in ring-drain loop
>   https://lore.kernel.org/20260516223439.4033-5-ravis.opensrc@gmail.com
> 
> Hopefully these are useful while you wait for milestone 1.
> 
> Best Regards,
> Ravi.
> 
> > Alternatively, we could start with the current simple implementation and
> > improve it by integrating each other's optimized implementations.

I'd prefer this way.  That is, I want to finish milestone 2 as soon as
possible because it is blocking us.  For the speed, I think doing it with
simplest implementation will be helpful.  After that, we can further work
together on optimizing the framework.

Please feel free to post RFC without waiting for milestone 2, though.


Thanks,
SJ

[...]
